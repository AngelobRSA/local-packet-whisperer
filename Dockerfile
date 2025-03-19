FROM python:3.11-slim

WORKDIR /app

# Set Python to always use UTF-8
ENV PYTHONUTF8=1

# Install system dependencies
RUN apt-get update && \
    apt-get install -y tshark curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


COPY . .

# Install Rust & Cargo before installing Python dependencies
RUN apt-get update && apt-get install -y curl && \
    curl https://sh.rustup.rs -sSf | sh -s -- -y && \
    export PATH="$HOME/.cargo/bin:$PATH"


RUN pip install --no-cache-dir -r requirements.txt

# Install LPW using setup.py
RUN pip install --no-cache-dir .

# Expose Streamlit port
EXPOSE 8501

# Start LPW service
CMD ["streamlit", "run", "bin/lpw_main.py"]
  