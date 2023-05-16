FROM node:16.15.0-alpine AS builder

USER node
WORKDIR /home/node

ADD --chown=node:node package.json .
ADD --chown=node:node package-lock.json .

RUN npm install

ADD --chown=node:node . .

RUN npx tsc


# -----------------------

FROM node:16.15.0-alpine AS app

USER node
WORKDIR /home/node

COPY --from=builder /home/node/package.json ./package.json
COPY --from=builder /home/node/package-lock.json ./package-lock.json
COPY --from=builder /home/node/build ./build
COPY --from=builder /home/node/public ./public

RUN npm install --production

CMD [ "node", "build/app.js" ]
