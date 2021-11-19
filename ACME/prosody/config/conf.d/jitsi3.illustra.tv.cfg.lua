

plugin_paths = { "/usr/share/jitsi-meet/prosody-plugins/", "/home/prosody-modules/" }
interfaces = { "127.0.0.1", "10.0.1.4"} -- Listen only for local connections


-- domain mapper options, must at least have domain base set to use the mapper
muc_mapper_domain_base = "torino.illustra.tv";

turncredentials_secret = "W7BnBiE1Sz67I3Td";

turncredentials_port = 443;
turncredentials_ttl = 86400;

turncredentials = {
  { type = "stun", host = "turn.voiceproxy02.illustra.tv", port = "443" },
  { type = "turn", host = "turn.illustra.tv", port = "443", transport="tcp" },
};



cross_domain_bosh = true;
consider_bosh_secure = true;


-- https://ssl-config.mozilla.org/#server=haproxy&version=2.1&config=intermediate&openssl=1.1.0g&guideline=5.4
ssl = {
 protocol = "tlsv1_2+";
 ciphers = "ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384"
}

-- ================= SMACKS/WebSocket
smacks_max_unacked_stanzas = 5;
smacks_hibernation_time = 60;
smacks_max_hibernated_sessions = 1;
smacks_max_old_sessions = 1;

consider_websocket_secure = true;
cross_domain_websocket = true;



VirtualHost "{{ .Env.XMPP_DOMAIN }}"
       -- enabled = false -- Remove this line to enable this host
       authentication = "any"
       -- Properties below are modified by jitsi-meet-tokens package config
       -- and authentication above is switched to "token"
       --app_id="example_app_id"
       --app_secret="example_app_secret"
       -- Assign this host a certificate for TLS, otherwise it would use the one
       -- set in the global section (if any).
       -- Note that old-style SSL on port 5223 only supports one certificate, and will always
       -- use the global one.
       ssl = {
               key = "/certs/torino.illustra.tv.key";
               certificate = "/certs/torino.illustra.tv.crt";
       }
       speakerstats_component = "speakerstats.torino.illustra.tv"
       conference_duration_component = "conferenceduration.torino.illustra.tv"
       -- we need bosh
       modules_enabled = {
         "bosh";
           "pubsub";
           "ping"; -- Enable mod_ping
           "auth_any";
           "saslauth";
          -- "speakerstats";
   "pinger";
           "turncredentials";
          -- "conference_duration";
          -- "muc_lobby_rooms";
           "smacks";
           "websocket";        }
       c2s_require_encryption = false
       s2s_secure_auth = true
       allow_unencrypted_plain_auth = true
       c2s_interfaces = {  "78.129.193.37"} -- Listen only on these interfaces
      c2s_ports = { 5222, 5280} 
       lobby_muc = "lobby.torino.illustra.tv"
       main_muc = "conference.torino.illustra.tv"
       -- muc_lobby_whitelist = { "recorder.torino.illustra.tv" } -- Here we can whitelist jibri to enter lobby enabled rooms

Component "conference.torino.illustra.tv" "muc"
   storage = "none"
   modules_enabled = {
       "muc_meeting_id";
       "muc_domain_mapper";
       -- "token_verification";
   }
   admins = { "focus@auth.torino.illustra.tv" }
   muc_room_locking = false
   muc_room_default_public_jids = true

-- internal muc component
Component "internal.auth.torino.illustra.tv" "muc"
   storage = "none"
   modules_enabled = {
     "ping";
   }
   admins = { "focus@auth.torino.illustra.tv", "jvb@auth.torino.illustra.tv" }
   muc_room_locking = false
   muc_room_default_public_jids = true

VirtualHost "auth.torino.illustra.tv"
   ssl = {
       key = "/certs/auth.torino.illustra.tv.key";
       certificate = "/certs/auth.torino.illustra.tv.crt";
   }
   authentication = "internal_plain"

Component "focus.torino.illustra.tv"
   component_secret = "hCl8X32G"

Component "speakerstats.torino.illustra.tv" "speakerstats_component"
   muc_component = "conference.torino.illustra.tv"

Component "conferenceduration.torino.illustra.tv" "conference_duration_component"
   muc_component = "conference.torino.illustra.tv"

Component "lobby.torino.illustra.tv" "muc"
   storage = "none"
   restrict_room_creation = true
   muc_room_locking = false
   muc_room_default_public_jids = true
