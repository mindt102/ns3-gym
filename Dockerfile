FROM ubuntu:22.04

RUN apt-get update
RUN apt-get install -y \
	vim \
	tmux \
	python-is-python3 \
	git \
	g++ \
	python3 \
	python3-pip \
	libzmq5 \
	libzmq5-dev \
	libprotobuf-dev \
	protobuf-compiler
	
RUN mkdir -p /usr/ns3-gym
WORKDIR /usr/ns3-gym
COPY . .

RUN CXXFLAGS="-Wall -g -O0" python3 waf configure 
RUN python3 waf build
RUN pip3 install ./src/opengym/model/ns3gym
RUN pip3 install -r requirements.txt
RUN apt-get clean && \
    rm -rf /var/lib/apt 
CMD tail -f /dev/null
