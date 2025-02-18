FROM osrm/osrm-backend:latest

RUN mkdir /data
WORKDIR /data
ADD https://download.geofabrik.de/asia/india/southern-zone-latest.osm.pbf /data
RUN /usr/local/bin/osrm-extract -p /opt/bicycle.lua /data/southern-zone-latest.osm.pbf && \
    /usr/local/bin/osrm-partition /data/southern-zone-latest.osrm && \
    /usr/local/bin/osrm-customize /data/southern-zone-latest.osrm

CMD [ "/usr/local/bin/osrm-routed", "--max-table-size", "100000", "--algorithm", "mld", "/data/southern-zone-latest.osrm" ]
