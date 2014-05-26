FROM stoo/erlang-dev:0.1.0

# Download the erldns release repo
WORKDIR /devdock/work
RUN git clone https://github.com/timclassic/erldns-rel.git

# Build
WORKDIR erldns-rel
RUN relx -l $ERL_LIBS
WORKDIR /devdock/work
RUN mkdir opt
RUN mv erldns-rel/_rel/erldns opt

# Reset working directory
WORKDIR /devdock/work
