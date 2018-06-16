FROM resin/rpi-raspbian:jessie

RUN apt-get update && \
    apt-get install -y  nano \
                        git \
                        openssl \
                        wget \
                        ca-certificates \
                        netcat \
                        libcurl4-openssl-dev \
                        php5 \
			curl

# Install domoticz
RUN mkdir /domoticz && \
    cd /domoticz && \
    wget https://releases.domoticz.com/releases/release/domoticz_linux_armv7l.tgz && \
    tar xvfz domoticz_linux_armv7l.tgz && \
    rm domoticz_linux_armv7l.tgz

# Install Xiaomi Vacuum plugin
RUN apt-get install -y python3 python3-dev python3-pip libffi-dev libssl-dev
RUN pip3 install -U setuptools virtualenv
RUN apt-get install build-essential
RUN cd /domoticz/plugins && \
    git clone https://github.com/mrin/domoticz-mirobot-plugin.git xiaomi-mirobot && \
    cd /domoticz/plugins/xiaomi-mirobot && \
    virtualenv -p python3 .env && \
    . /domoticz/plugins/xiaomi-mirobot/.env/bin/activate && \
    pip3 install -r pip_req.txt

# Installation de iSamsungTV
RUN wget https://github.com/Tristan79/iSamsungTV/raw/master/pi/iSamsungTV && \
    chmod +x iSamsungTV && \
    mv iSamsungTV /usr/local/bin/

# HTTP port (web interface)
EXPOSE 8080

ENTRYPOINT ["/domoticz/domoticz", "-dbase", "/config/domoticz.db", "-log", "/config/domoticz.log"]

CMD ["-www", "8080"]
