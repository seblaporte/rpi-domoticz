FROM balenalib/raspberrypi3-debian:stretch

RUN [ "cross-build-start" ]

RUN apt-get update && \
    apt-get install -y  nano git openssl libusb-0.1-4 wget ca-certificates netcat libcurl4-openssl-dev php curl build-essential && \
    rm -rf /var/lib/apt/lists/*

# Install domoticz
RUN mkdir /domoticz && \
    cd /domoticz && \
    wget https://releases.domoticz.com/releases/release/domoticz_linux_armv7l.tgz && \
    tar xvfz domoticz_linux_armv7l.tgz && \
    rm domoticz_linux_armv7l.tgz

# Install Xiaomi Vacuum plugin
RUN apt-get update && \
    apt-get install -y python3 python3-dev python3-pip libffi-dev libssl-dev && \
    rm -rf /var/lib/apt/lists/*
RUN pip3 install -U setuptools virtualenv
RUN cd /domoticz/plugins && \
    git clone https://github.com/mrin/domoticz-mirobot-plugin.git xiaomi-mirobot && \
    cd /domoticz/plugins/xiaomi-mirobot && \
    git checkout tags/0.1.3 && \
    virtualenv -p python3 .env && \
    . /domoticz/plugins/xiaomi-mirobot/.env/bin/activate && \
    pip3 install -r pip_req.txt

# Install iSamsungTV (from https://github.com/Tristan79/iSamsungTV)
COPY iSamsungTV/iSamsungTV /usr/local/bin/
RUN chmod +x /usr/local/bin/iSamsungTV

# Install Zigate plugin
RUN cd /domoticz/plugins && \
    git clone https://github.com/sasu-drooz/Domoticz-Zigate.git && \
    chmod +x Domoticz-Zigate/plugin.py

# Install Hyperion plugin
COPY Hyperion /domoticz/plugins/Hyperion
RUN chmod +x /domoticz/plugins/Hyperion/plugin.py

RUN [ "cross-build-end" ]

EXPOSE 8080

ENTRYPOINT ["/domoticz/domoticz", "-dbase", "/config/domoticz.db", "-log", "/config/domoticz.log"]
CMD ["-www", "8080"]
