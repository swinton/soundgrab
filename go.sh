#!/bin/sh
set -e

# Get master
curl --output master.mpd 'https://aod-dash-ww-live.akamaized.net/usp/auth/vod/piff_abr_full_audio/b927be-m000sj3v/vf_m000sj3v_3fc66e93-0f2e-4b1f-ad07-3d9d036df472.ism/pc_hd_abr_v2_nonuk_dash_master.mpd?__gda__=1614057413_7463186847919246f75c666e55f71b08#t=7186s' \
-X 'GET' \
-H 'Pragma: no-cache' \
-H 'Accept: */*' \
-H 'Origin: https://emp.bbc.co.uk' \
-H 'Cache-Control: no-cache' \
-H 'Accept-Language: en-us' \
-H 'Host: aod-dash-ww-live.akamaized.net' \
-H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0.3 Safari/605.1.15' \
-H 'Referer: https://emp.bbc.co.uk/' \
-H 'Connection: keep-alive'

# Get initialization file
curl --output init.mp4 'https://aod-dash-ww-live.akamaized.net/usp/auth/vod/piff_abr_full_audio/b927be-m000sj3v/vf_m000sj3v_3fc66e93-0f2e-4b1f-ad07-3d9d036df472.ism/dash/vf_m000sj3v_3fc66e93-0f2e-4b1f-ad07-3d9d036df472-audio_eng_1=96000.dash' \
-X 'GET' \
-H 'Pragma: no-cache' \
-H 'Accept: */*' \
-H 'Origin: https://emp.bbc.co.uk' \
-H 'Cache-Control: no-cache' \
-H 'Accept-Language: en-us' \
-H 'Host: aod-dash-ww-live.akamaized.net' \
-H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0.3 Safari/605.1.15' \
-H 'Referer: https://emp.bbc.co.uk/' \
-H 'Connection: keep-alive'

# Get segments
for i in {1..1123}; do
  curl --output segment-$i.m4s "https://aod-dash-ww-live.akamaized.net/usp/auth/vod/piff_abr_full_audio/b927be-m000sj3v/vf_m000sj3v_3fc66e93-0f2e-4b1f-ad07-3d9d036df472.ism/dash/vf_m000sj3v_3fc66e93-0f2e-4b1f-ad07-3d9d036df472-audio_eng_1=96000-$i.m4s" \
  -X 'GET' \
  -H 'Pragma: no-cache' \
  -H 'Accept: */*' \
  -H 'Origin: https://emp.bbc.co.uk' \
  -H 'Cache-Control: no-cache' \
  -H 'Accept-Language: en-us' \
  -H 'Host: aod-dash-ww-live.akamaized.net' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0.3 Safari/605.1.15' \
  -H 'Referer: https://emp.bbc.co.uk/' \
  -H 'Connection: keep-alive'
done

# Generate output (https://stackoverflow.com/a/29175518)
# BEWARE: this messes up the ordering
# See: cat.sh
# TODO: preserve ordering when concatenating segments
cat init.mp4 *.m4s > output.mp4

# Convert to audio
ffmpeg -i output.mp4 -vn output.mp3
