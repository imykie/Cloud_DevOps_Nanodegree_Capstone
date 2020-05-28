FROM python:3.7.3-stretch

LABEL maintainer='tundexmike@gmail.com'

# Working Directory
WORKDIR /app

# Copy ML-API to app
COPY . app.py /app/

# Install dependencies
RUN pip install --upgrade pip && \
    pip install --trusted-host pypi.python.org -r requirements.txt

# Expose port 80
EXPOSE 80

# Run app.py at container launch
CMD ["python", "app.py"] 