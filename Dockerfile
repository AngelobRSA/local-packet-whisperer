FROM python:3.11-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && \
    apt-get install -y tshark curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy project files
COPY . .

# Ensure LPW is installed properly using setup.py
RUN python3 setup.py install

# Expose Streamlit port
EXPOSE 8501

# Start LPW service
CMD ["lpw", "start"]
