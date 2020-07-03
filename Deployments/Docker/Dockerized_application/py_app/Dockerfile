FROM python:2
ADD . /sampleapp
WORKDIR /sampleapp
COPY requirements.txt ./
RUN pip install -r requirements.txt
CMD ["bash", "-c","python", "app.py"]


