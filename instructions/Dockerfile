FROM golang:1.17.3-buster as ClaatSetup
RUN CGO_ENABLED=0 go install github.com/googlecodelabs/tools/claat@latest

FROM alpine:3.10 as ClaatExporter
WORKDIR /app
COPY --from=ClaatSetup /go/bin/claat /claat
COPY dojo.md/ dojo.md
COPY docs/ docs/
RUN /claat export -o output dojo.md

FROM alpine:3.10 as AppCompiler
RUN apk add --update git nodejs npm make python gcc g++ && \
    npm install -g gulp-cli

WORKDIR /app
RUN git clone -b main https://github.com/googlecodelabs/tools.git codelabs-tools

WORKDIR /app/codelabs-tools/site
# Install dependencies
RUN npm install && npm install gulp
# Copy exported codelabs from previous stage
COPY --from=ClaatExporter /app/output codelabs/
# Build everything
RUN gulp dist --codelabs-dir=codelabs
# Replace symlink in with actual content (see below for description)
WORKDIR /app/codelabs-tools/site/dist
RUN rm codelabs
COPY --from=ClaatExporter /app/output codelabs/

FROM nginx as Deployment
WORKDIR /app
COPY --from=AppCompiler /app/codelabs-tools/site/dist/ /usr/share/nginx/html
EXPOSE 80