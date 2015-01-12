FROM quay.io/sorah/gentoo-flavored:latest
MAINTAINER her@sorah.jp

RUN rm -f /etc/env.d/10rubygems

ADD rbenv.profile.sh /etc/env.d/10rubygems
RUN echo 'dev-lang/ruby' >> /etc/portage/package.mask

ADD setup-rbenv /usr/bin/setup-rbenv
RUN /usr/bin/setup-rbenv
