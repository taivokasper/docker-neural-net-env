FROM debian

MAINTAINER Taivo Käsper <taivo.kasper@gmail.com>

ENV PATH /root/anaconda/bin:$PATH

RUN apt-get update \
      && apt-get install -y curl libbz2-dev bzip2
RUN curl -o anaconda.sh https://repo.anaconda.com/archive/Anaconda3-5.2.0-Linux-x86_64.sh
RUN bash anaconda.sh -b -p $HOME/anaconda

RUN pip install msgpack
RUN pip install tensorflow

RUN pip install keras

EXPOSE 8888

WORKDIR /notebook

CMD jupyter notebook --ip=0.0.0.0 --no-browser --allow-root
