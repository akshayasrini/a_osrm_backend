FROM osrm/osrm-backend:latest

RUN mkdir /data
WORKDIR /data
ADD https://download.geofabrik.de/asia/bhutan-latest.osm.pbf /data
RUN /usr/local/bin/osrm-extract -p /opt/bicycle.lua /data/bhutan-latest.osm.pbf && \
    /usr/local/bin/osrm-partition /data/bhutan-latest.osrm && \
    /usr/local/bin/osrm-customize /data/bhutan-latest.osrm

CMD [ "/usr/local/bin/osrm-routed", "--max-table-size", "100000", "--algorithm", "mld", "/data/bhutan-latest.osrm" ]
