FROM stoo/erlang:17.0-2

# Install package and add to PATH
ADD erldns.tar.gz /
ENV PATH /opt/erldns/bin:/opt/erlang/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN echo "PATH=$PATH" >>/etc/profile

# Configure application startup
RUN mkdir /etc/service/erldns
ADD erldns.sh /etc/service/erldns/run

# Add a user
RUN useradd -c "erldns User" -d / -u 10000 -U erldns

# Include an SSH key
ADD sshid.pub /tmp/sshid.pub
RUN mkdir -m 0700 /root/.ssh
RUN cat /tmp/sshid.pub >>/root/.ssh/authorized_keys
RUN rm -f /tmp/sshid.pub

# Start baseimage init by default
CMD ["/sbin/my_init"]

# Set up erldns CONFIG_PATH
ENV CONFIG_PATH /etc/opt/erldns/sys

# Expose the DNS port
EXPOSE 8053
