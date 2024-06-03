FROM python:3.11.9

EXPOSE 8000

WORKDIR /app

COPY requirements.txt /app

RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENTRYPOINT [ "python3"]
CMD ["manage.py", "runserver", "0.0.0.0:8000"]