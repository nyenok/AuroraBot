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
RUN mkdir -p /tmp/ && \
    cd /tmp/ && \
    wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/$(curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE)/chromedriver_linux64.zip  && \
    unzip /tmp/chromedriver.zip chromedriver -d /usr/bin/ && \
    # clean up the container "layer", after we are done
    rm /tmp/chromedriver.zip.
 
ENV GOOGLE_CHROME_DRIVER /usr/bin/chromedriver
ENV GOOGLE_CHROME_BIN /usr/bin/google-chrome-stable
    
# install pre requirements
COPY requirements.txt .
RUN pip install -r requirements.txt

# copy the content of the local src directory to the working directory
COPY . .

# Setting up aria2c
RUN chmod +x resources/aria.sh

# Set Docker how to run
CMD ["bash","start.sh"]