FROM python:3.11-slim

WORKDIR /app

# Set Python to always use UTF-8
ENV PYTHONUTF8=1

# Install system dependencies
RUN apt-get update && \
    apt-get install -y tshark curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy project files
COPY . .

# Install Python dependencies but exclude 'uv'
RUN pip install --no-cache-dir -r requirements.txt --no-binary uv

# Install LPW as an editable package
RUN pip install --no-cache-dir --editable .

# Expose Streamlit port
EXPOSE 8501

# Start LPW service
CMD ["python3", "-m", "lpw.bin.lpw", "start"]
