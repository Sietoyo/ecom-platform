# Local Setup (WSL2 + Docker)

## What this project runs locally
- MinIO (data lake UI + object storage)
- Postgres (warehouse)
- Kafka + Zookeeper (streaming backbone)
- Kafka UI (topic/message browser)

## Prerequisites
- Windows 10/11 + WSL2
- Docker Desktop installed and Docker Engine running
- Ubuntu on WSL (tested with Ubuntu 24.04 LTS)

## Start services
From the project root:

```bash
docker compose up -d
docker compose ps
cat > README.md <<'MD'
# E-Commerce Lakehouse (Local) — Batch + Star Schema (V1)

This project is an end-to-end data engineering portfolio build that simulates a real-world e-commerce analytics platform. It implements a local lakehouse + warehouse pattern using Docker and WSL2, and models analytics data using a Gold-layer star schema.

## Architecture (V1)
- **Bronze (raw):** source CSV files loaded as-is into Postgres bronze tables and stored in MinIO under `bronze/ecom/raw/`
- **Silver (clean):** typed/casted tables (dates, numerics, booleans)
- **Gold (analytics):** star schema (dimensions + fact table) optimized for BI-style queries

**Core services**
- MinIO (object storage “lake”)
- Postgres (warehouse)
- Kafka + Kafka UI (reserved for V2 streaming)
- Airflow / DQ tools (planned in later phases)

## Data model (Gold star schema)
**Fact table**
- `gold.fact_sales` (grain: 1 row per order item)

**Dimensions**
- `gold.dim_date`
- `gold.dim_customer`
- `gold.dim_product`
- `gold.dim_seller`

> Star schema diagram is stored under `docs/architecture/` (add your exported image there).

## How to run (local)
See: `docs/runbook/local_setup.md`

## Build steps (V1)
1. Start containers: `docker compose up -d`
2. Create schemas: `bronze`, `silver`, `gold`, `ops`
3. Load raw data into Bronze (CSV -> staging tables)
4. Build Silver (type casting)
5. Build Gold (star schema + keys)
6. Run analytics queries (examples below)

## Example analytics queries (Gold)
- Revenue by month and category (delivered orders)
- Top categories by delivered revenue
- Revenue by customer segment

## Screenshots
All screenshots are stored in: `docs/screenshots/`

Recommended key screenshots:
- Platform running: `05_platform_containers_running.png`
- MinIO buckets: `07_minio_buckets_created_bronze_silver_gold.png`
- Bronze row counts: `13_bronze_row_counts_loaded.png`
- Silver schema + sample rows: `15_*.png`, `16_*.png`
- Gold tables: `17_gold_tables_created_star_schema.png`
- Gold KPIs: `18_*.png`, `20_*.png`, `21_*.png`

## Roadmap
- **V2:** Streaming + orchestration (Kafka topics, producer/consumer, Airflow DAG)
- **V3:** Data quality + observability (Great Expectations, logging, freshness checks)
- **V4:** Cloud migration blueprint (AWS/Azure mapping + optional CI)

