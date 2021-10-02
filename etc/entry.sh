#!/bin/bash 
mkdir -p "${STEAMAPPDIR}" || true  
#install rust dedicated server 
bash "${STEAMCMDDIR}/steamcmd.sh" +login anonymous \
				+force_install_dir "${STEAMAPPDIR}" \
				+app_update "${STEAMAPPID}" \
				+quit

# Believe it or not, if you don't do this rust shits itself
cd "${STEAMAPPDIR}"
#Assume all enviroment vars are being passed into the container
bash "./RustDedicated" -batchmode  +app.listenip ${APP_LISENIP} \
                                                +app.port ${APP_PORT} \
                                                +server.ip ${SERVER_IP} \
                                                +server.port ${SERVER_PORT} \
                                                +server.tickrate ${SERVER_TICKRATE} \
                                                +server.hostname "${SERVER_HOSTNAME}" \
                                                +server.identity "${SERVER_IDENTITY}" \
                                                +server.gamemode ${SERVER_GAMEMODE} \
                                                +server.level "${SERVER_LEVEL}" \
                                                +server.seed ${SERVER_SEED} \
                                                +server.salt ${SERVER_SALT} \
                                                +server.maxplayers ${SERVER_MAXPLAYERS} \
                                                +server.worldsize ${SERVER_WORLDSIZE} \
                                                +server.saveinterval ${SERVER_SAVEINTERVAL}\
                                                +rcon.web ${RCON_WEB} \
                                                +rcon.ip ${RCON_IP} \
                                                +rcon.port ${RCON_PORT} \
                                                +rcon.password "${RCON_PASSWORD}"