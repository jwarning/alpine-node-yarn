FROM mhart/alpine-node:6.9.5

# fetch latest version of yarn
RUN apk --no-cache add bash curl tar && \
  curl -o- -L https://yarnpkg.com/install.sh | bash && \
  apk del bash curl tar

# set path to include yarn
ENV PATH /root/.yarn/bin:$PATH

# create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# copy source
COPY . /usr/src/app

# install dependencies and build source
# then install production only dependencies
RUN yarn install --no-progress && \
  npm run build && \
  rm -rf node_modules && \
  yarn install --production --no-progress && \
  yarn cache clean

# start server
EXPOSE 3000
CMD [ "npm", "start" ]
