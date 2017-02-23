FROM node:6.9.5-alpine

# fetch latest version of yarn
RUN apk --no-cache add bash curl tar && \
  curl -o- -L https://yarnpkg.com/install.sh | bash && \
  apk del bash curl tar

# set path to include yarn
ENV PATH /root/.yarn/bin:$PATH

# set working directory
WORKDIR /usr/src/app

# copy package.json and yarn.lock
COPY package.json yarn.lock /usr/src/app/

# install dependencies
RUN yarn install --pure-lockfile --no-progress \
  && yarn cache clean

# copy source
COPY . /usr/src/app

# build source
RUN npm run build

# start server
EXPOSE 3000
CMD ["npm", "start"]
