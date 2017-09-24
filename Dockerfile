FROM centos:7
LABEL project="Christian's Docker Test"
LABEL maintainer="madriga1@msn.com"
ENV SELPATH /opt/selenium
#--------------------------------------------------------
# Update the image with the latest packages (recommended)
#--------------------------------------------------------
RUN yum update -y; yum clean all
RUN rm -rf /var/cache/yum
#--------------------------------------------------------
# Lets install the packages we need
#--------------------------------------------------------
RUN yum -y install bzip2 wget sudo unzip java-1.8.0-openjdk
# Clean up guy...
RUN rm -rf /var/cache/yum
#========================================
# Add normal seluser
#========================================
RUN useradd seluser \
         --shell /bin/bash  \
         --create-home \
	&& usermod -a -G wheel seluser \
	&& echo 'ALL ALL = (ALL) NOPASSWD: ALL' >> /etc/sudoers \
  	&& echo 'seluser:secret' | chpasswd
#========================================
# Let's install the hub
#========================================
USER seluser
WORKDIR $SELPATH
RUN sudo chown seluser:seluser $SELPATH
RUN  wget -q https://selenium-release.storage.googleapis.com/3.5/selenium-server-standalone-3.5.3.jar 
