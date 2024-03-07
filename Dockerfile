# Use an official Python runtime as a parent image
FROM python:3.8

# Set environment variables
ENV DATABASE_NAME=virtual_clinic
ENV DATABASE_USER=admin
ENV DATABASE_PASSWORD=Admin@vc1

# Install MySQL client and other dependencies
RUN apt-get update
RUN pip install mysqlclient
# RUN pip3 install virtualenv
RUN apt-get install default-libmysqlclient-dev
RUN rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file and install dependencies
COPY requirements.txt /app/
RUN python3 -m venv env && \
    . env/bin/activate && \
    pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy the application code into the container
COPY . /app/

# Run migrations and start the Django server
CMD . env/bin/activate && \
    python manage.py makemigrations && \
    python manage.py migrate && \
    python manage.py runserver 0.0.0.0:8006

