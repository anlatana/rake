FROM centos:7
ENV PATH=/opt/rh/rh-ruby25/root/usr/local/bin:/opt/rh/rh-ruby25/root/usr/bin${PATH:+:${PATH}}
ENV LD_LIBRARY_PATH=/opt/rh/rh-ruby25/root/usr/local/lib64:/opt/rh/rh-ruby25/root/usr/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
ENV MANPATH=/opt/rh/rh-ruby25/root/usr/local/share/man:/opt/rh/rh-ruby25/root/usr/share/man:$MANPATH
ENV PKG_CONFIG_PATH=/opt/rh/rh-ruby25/root/usr/local/lib64/pkgconfig:/opt/rh/rh-ruby25/root/usr/lib64/pkgconfig${PKG_CONFIG_PATH:+:${PKG_CONFIG_PATH}}
ENV XDG_DATA_DIRS=/opt/rh/rh-ruby25/root/usr/local/share:/opt/rh/rh-ruby25/root/usr/share:${XDG_DATA_DIRS:-/usr/local/share:/usr/share}

WORKDIR /home
RUN yum install centos-release-scl centos-release-scl-rh -y
RUN rpm -ivh http://yum.puppetlabs.com/puppet5-release-el-7.noarch.rpm
RUN yum --enablerepo=centos-sclo-rh install gem bundler rh-ruby25 puppet-agent -y && yum clean all
RUN scl enable rh-ruby25 bash
COPY test.pp .
COPY Gemfile .
#RUN gem install yard puppet-strings
RUN /opt/puppetlabs/puppet/bin/gem install puppet-strings
RUN gem list
CMD /opt/puppetlabs/bin/puppet strings generate test.pp
