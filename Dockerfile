FROM debian:bookworm-slim

# non interactive frontend for locales
ENV DEBIAN_FRONTEND=noninteractive

# installing texlive and utils
RUN apt-get update && \
	apt-get -y install --no-install-recommends pandoc texlive texlive-full texlive-latex-extra texlive-extra-utils texlive-fonts-extra texlive-bibtex-extra texlive-lang-german biber latexmk make inkscape git procps locales curl && \
	rm -rf /var/lib/apt/lists/*

# generating locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
	sed -i -e 's/# de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/' /etc/locale.gen && \
	dpkg-reconfigure --frontend=noninteractive locales && \
	update-locale LANG=en_US.UTF-8
ENV LANGUAGE=de_DE.UTF-8:en_US.UTF-8 LANG=de_DE.UTF-8 LC_ALL=de_DE.UTF-8

# installing cpanm & missing latexindent dependencies
RUN curl -L http://cpanmin.us | perl - --self-upgrade && \
	cpanm Log::Dispatch::File YAML::Tiny File::HomeDir

