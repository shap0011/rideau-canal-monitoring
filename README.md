# Rideau Canal Real-time Monitoring System

## 1. Project Title and Description

Real-time Monitoring System for the **Rideau Canal Skateway** (Dow's Lake, Fifth Avenue, NAC) using Azure IoT, Stream Analytics, Cosmos DB, Blob Storage, and a Flask-based web dashboard.

The system simulates IoT sensors sending ice and weather data, processes it in real time, stores aggregated results, archives historical data, and displays current conditions and safety status on a web dashboard.

---

## 2. Student Information

- **Name:** Olga Durham

- **Student ID:** 040687883

- **Course:** 25F CST8916 Remote Data and RT Applications

**Repositories:**

- **Main Documentation:** https://github.com/shap0011/rideau-canal-monitoring

- **Sensor Simulation:** https://github.com/shap0011/rideau-canal-sensor-simulation

- **Web Dashboard:** https://github.com/shap0011/rideau-canal-dashboard

---

## 3. Scenario Overview

### Problem Statement

The Rideau Canal Skateway in Ottawa requires continuous monitoring to ensure skater safety. Ice thickness, surface temperature, snow accumulation, and external temperature vary throughout the day and across locations.

### System Objectives

- Simulate IoT sensors at three key locations.

- Process data in real time using Azure Stream Analytics (5-minute windows).

- Store processed aggregates in Azure Cosmos DB and archive to Blob Storage.

- Visualize current and historical conditions in a web dashboard.

- Indicate safety status (Safe / Caution / Unsafe) for each location.

---

## 4. System Architecture

### 4.1 Architecture Diagram

_Architecture diagram is located in_ `architecture/architecture-diagram.png`.

### 4.2 Data Flow

1. **Sensor Simulation** (Python) generates JSON data every 10 seconds for:

   - Dow's Lake

   - Fifth Avenue

   - NAC

2. Data is sent to **Azure IoT Hub**.

3. **Azure Stream Analytics** reads from IoT Hub and:

   - Aggregates data in **5-minute tumbling windows**.

   - Calculates averages/min/max values.

   - Determines **safety status** per window and location.

   - Writes aggregated data to:

     - **Azure Cosmos DB** (for dashboard queries).

     - **Azure Blob Storage** (for historical archives).

4. **Flask Web Dashboard** (Python) reads from Cosmos DB and:

   - Displays latest status for each location.

   - Shows historical trend charts (last hour).

   - Auto-refreshes every 30 seconds.

### 4.3 Azure Services Used

- Azure IoT Hub

- Azure Stream Analytics

- Azure Cosmos DB (NoSQL API)

- Azure Blob Storage

- Azure App Service (hosting Flask dashboard)

---

## 5. Implementation Overview

- **IoT Sensor Simulation**

  - Repository: [rideau-canal-sensor-simulation](https://github.com/shap0011/rideau-canal-sensor-simulation)

  - Python script that simulates three devices and sends telemetry to IoT Hub.

- **Azure IoT Hub Configuration**

  - Resource group: `cst8916Final`

  - Region: `Canada Central`

  - Devices: `dows-lake`, `fifth-avenue`, `nac`

- **Stream Analytics Job**

  - Input: IoT Hub

  - Outputs: Cosmos DB + Blob Storage

  - Query: see `stream-analytics/query.sql`

- **Cosmos DB Setup**

  - Database: `RideauCanalDB`

  - Container: `SensorAggregations`

  - Partition key: `/location`

  - Document ID: `{location}-{timestamp}`

- **Blob Storage Configuration**

  - Container: `historical-data`

  - Path: `aggregations/{date}/{time}`

  - Format: line-delimited JSON

- **Web Dashboard (Flask)**

  - Repository: [rideau-canal-dashboard](https://github.com/shap0011/rideau-canal-dashboard)

  - Backend: Flask REST API querying Cosmos DB

  - Frontend: HTML/CSS/JavaScript + Chart.js

  - Deployment: Azure App Service (Python runtime)

---

## 6. Repository Links

See `LINKS.md` for:

    - All three GitHub repositories

    - Live Azure App Service dashboard URL

    - Video demo link

---

## 7. Video Demonstration

- **YouTube Link (Unlisted):** TODO: Add link here

- Duration: ≤ 10 minutes

- Content: Architecture, live demo, code walkthrough, conclusion.

---

## 8. Setup Instructions (High-Level)

### Prerequisites

- Azure subscription (Azure for Students is sufficient)

- Python 3.10+ installed locally

- Git \& GitHub

- (Optional) Virtual environment tool (venv)

### High-Level Steps

1. Clone all three repositories.

2. Configure Azure resources (IoT Hub, Stream Analytics, Cosmos DB, Blob Storage, App Service).

3. Configure sensor simulator with device connection strings and IoT Hub info.

4. Start Stream Analytics job.

5. Run sensor simulator to generate data.

6. Verify data in Cosmos DB and Blob Storage.

7. Run Flask dashboard locally.

8. Deploy dashboard to Azure App Service.

_Detailed setup steps are provided in the READMEs of the other repositories._

---

## 9. Results and Analysis

- Sample aggregated documents (Cosmos DB)

- Sample archived files (Blob Storage)

- Screenshots of dashboard with safety statuses and trends

- Observations about:

  - Typical ranges of ice thickness and temperature

  - Safety status distribution over time

---

## 10. Challenges and Solutions

Describe:

- Technical issues (e.g., connection strings, Stream Analytics query bugs, Cosmos DB indexing).

- How you diagnosed and fixed them.

---

## 11. AI Tools Used

## AI Tools Used

- **Tool:** ChatGPT

- **Purpose:** Help with initial project structure, documentation templates, and example code snippets.

- **Extent:** All AI-generated content was reviewed, understood, and modified to match my own implementation. I understand all code and configuration before using it.
