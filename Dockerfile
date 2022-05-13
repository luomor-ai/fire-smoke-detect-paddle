FROM python:3.6
RUN apt-get update
RUN apt-get install vim -y
RUN pip install matplotlib -i https://pypi.doubanio.com/simple/

RUN pip install paddlehub -i https://pypi.doubanio.com/simple/
RUN pip install paddlepaddle -i https://pypi.doubanio.com/simple/