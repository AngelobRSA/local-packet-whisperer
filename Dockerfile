FROM python:3.11-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && \
    apt-get install -y tshark curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy project files
COPY . .

# Install Python dependencies
RUN pip install --no-cache-dir .

# Expose Streamlit port
EXPOSE 8501

# Start LPW service
CMD ["lpw"]
