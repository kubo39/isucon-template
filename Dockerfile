FROM dlang2/ldc-ubuntu:1.23.0

EXPOSE 8080

WORKDIR /usr/src/isucon

COPY dub.sdl dub.selections.json ./
COPY source ./source
RUN touch source/app.d && dub build -b release

RUN apt-get update && apt-get install -y default-mysql-client

CMD ["/usr/src/isucon/isuconapp"]
