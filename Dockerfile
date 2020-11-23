# We're using python Base Image
FROM python:3.9

# Set working Directory
WORKDIR /userbot/

# Prepair Enviroment
RUN apt -qq update
RUN apt -qq install -y --no-install-recommends \
    figlet \
    neofetch \
    jq \
    ffmpeg \
    megatools \
    unzip \
    git \
    wget \
    postgresql \
    bash \
    aria2


# Install Chrome Driver
RUN wget -N https://chromedriver.storage.googleapis.com/86.0.4240.22/chromedriver_linux64.zip -P ~/ && \
    unzip ~/chromedriver_linux64.zip -d ~/ && \
    rm ~/chromedriver_linux64.zip && \
    mv -f ~/chromedriver /usr/bin/chromedriver && \
    chown root:root /usr/bin/chromedriver && \
    chmod 0755 /usr/bin/chromedriver
    

# install pre requirements
COPY requirements.txt .
RUN pip install -r requirements.txt

# copy the content of the local src directory to the working directory
COPY . .

# Setting up aria2c
RUN chmod +x resources/aria.sh

# Set Docker how to run
CMD ["bash","start.sh"]