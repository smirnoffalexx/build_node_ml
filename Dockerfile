FROM ubuntu

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /root

RUN apt-get update 

RUN apt-get install git curl gcc g++ make 

RUN git clone https://github.com/polyml/polyml && cd polyml

RUN ./configure --prefix=/usr && make && make compiler && make install && cd ..

RUN git clone https://github.com/HOL-Theorem-Prover/HOL && cd HOL && git checkout kananaskis-14 

# optionally change HOL version

RUN poly --script tools/smart-configure.sml && bin/build && cd ..

RUN git clone https://github.com/CakeML/cakeml git checkout v1469

# optionally change cakeml version

RUN "$HOME/HOL/bin/Holmake"

WORKDIR /root

RUN echo "export PATH=$PATH:/root/HOL/bin:/root/cakeml:/root/cake-x64-64" >> .bashrc

# if user need cake-x64-64 compiler then:

# choose a compiler version

# RUN curl -vLJO https://github.com/CakeML/cakeml/releases/download/v1469/cake-x64-64.tar.gz

# RUN tar -xvf cake-x64-64.tar.gz && cd cake-x64-64 && make && cd .. && rm cake-x64-64.tar.gz

# if user need emacs then:

# RUN apt-get install -y emacs

# RUN mkdir .emacs.d

# RUN git clone https://github.com/smirnoffalexx/HOL-emacs.git && cd HOL-emacs

# RUN cp init.el root/.emacs.d/init.el && cd .. && rm -rf HOL-emacs
