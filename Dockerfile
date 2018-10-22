FROM debian AS build

ENV PATH /root/anaconda/bin:$PATH

# Tools for build
RUN apt-get update \
      && apt-get install -y curl libbz2-dev bzip2

# Install Anaconda3
RUN curl -o anaconda.sh https://repo.anaconda.com/archive/Anaconda3-5.2.0-Linux-x86_64.sh \
      && bash anaconda.sh -b -p /root/anaconda \
      && rm -f anaconda.sh

# Install TensorFlow
RUN pip install msgpack tensorflow

# Install Keras
RUN pip install keras

# Install more ML libraries
RUN pip install scikit-learn

FROM debian

MAINTAINER Taivo Käsper <taivo.kasper@gmail.com>

ENV PATH /root/anaconda/bin:$PATH

COPY --from=build /root/anaconda /root/anaconda

EXPOSE 8888

WORKDIR /notebook

CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--no-browser", "--allow-root"]
