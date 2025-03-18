FROM python:3.11-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && \
    apt-get install -y tshark curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy project files
COPY . .

# Install LPW using setup.py
RUN pip install --no-cache-dir .

# Ensure lpw is installed properly and available globally
RUN pip install --no-cache-dir --editable .

# Expose Streamlit port
EXPOSE 8501

# Start LPW service
CMD ["python3", "-m", "lpw.bin.lpw", "start"]
