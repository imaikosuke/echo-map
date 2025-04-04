"use client";

import { MapContainer, Marker, Popup, TileLayer } from "react-leaflet";
import "leaflet/dist/leaflet.css";
import { defaultIcon } from "./marker-icon";

export default function Map() {
  return (
    <div style={{ height: "100vh", width: "100%" }}>
      <MapContainer
        center={[35.6895, 139.6917] as [number, number]}
        zoom={13}
        scrollWheelZoom={false}
        style={{ height: "100%", width: "100%" }}
      >
        <TileLayer
          attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
          url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
          crossOrigin="anonymous"
        />
        <Marker position={[35.6895, 139.6917] as [number, number]} icon={defaultIcon}>
          <Popup>東京タワー</Popup>
        </Marker>
      </MapContainer>
    </div>
  );
}
