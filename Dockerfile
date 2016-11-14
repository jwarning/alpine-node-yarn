FROM mhart/alpine-node:6.9.1

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
# then install only production dependencies
RUN yarn install && \
  npm run build && \
  rm -rf node_modules && \
  yarn install --production

# start server
EXPOSE 3000
CMD [ "npm", "start" ]
