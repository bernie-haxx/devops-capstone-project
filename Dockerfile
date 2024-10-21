FROM python:3.9-slim

# WORKDIR and Dependencies
WORKDIR /app
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# Copy app Contents
COPY service/ ./service/

# Switch to non-root user
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

# RUn the service
EXPOSE 8080
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]