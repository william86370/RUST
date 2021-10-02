###########################################################
# Dockerfile that unfortantly builds a rust server for K8
###########################################################
FROM cm2network/steamcmd:root

LABEL maintainer="william86370@gmail.com"

ENV STEAMAPPID 258550
ENV STEAMAPP rust
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated"
ENV DLURL https://raw.githubusercontent.com/william86370/RUST
ENV VERSION=1.0.1

# Add entry script & RUST config
# Remove packages and tidy up
RUN set -x \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		wget \
		ca-certificates \
		lib32z1 \
	&& mkdir -p "${STEAMAPPDIR}" \
	&& wget --max-redirect=30 "${DLURL}/master/etc/entry.sh" -O "${HOMEDIR}/entry.sh" \
	&& { \
		echo '@ShutdownOnFailedCommand 1'; \
		echo '@NoPromptForPassword 1'; \
		echo 'login anonymous'; \
		echo 'force_install_dir '"${STEAMAPPDIR}"''; \
		echo 'app_update '"${STEAMAPPID}"''; \
		echo 'quit'; \
	   } > "${HOMEDIR}/${STEAMAPP}_update.txt" \
	&& chmod +x "${HOMEDIR}/entry.sh" \
	&& chown -R "${USER}:${USER}" "${HOMEDIR}/entry.sh" "${STEAMAPPDIR}" "${HOMEDIR}/${STEAMAPP}_update.txt" \	
	&& rm -rf /var/lib/apt/lists/* 

ENV APP_LISENIP=0.0.0.0  \
APP_PORT=28082  \
SERVER_IP=0.0.0.0  \
SERVER_PORT=28015  \
SERVER_TICKRATE=30  \
SERVER_HOSTNAME=Rust  \
SERVER_IDENTITY=rustserver  \
SERVER_GAMEMODE=vanilla  \
SERVER_LEVEL="Procedural Map"  \
SERVER_SEED=0  \
SERVER_SALT=0  \
SERVER_MAXPLAYERS=50  \
SERVER_WORLDSIZE=3000  \
SERVER_SAVEINTERVAL=300  \
RCON_WEB=1  \
RCON_IP=0.0.0.0  \
RCON_PORT=28016  \
RCON_PASSWORD="CHANGE_ME" 


USER ${USER}

VOLUME ${STEAMAPPDIR}

WORKDIR ${HOMEDIR}

CMD ["bash", "entry.sh"]