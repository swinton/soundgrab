#!/bin/sh
set -e

# Get master
curl --output master.mpd 'https://aod-dash-ww-live.bbcfmt.s.llnwi.net/usp/auth/vod/piff_abr_full_audio/1b88ea-m000rwsp/vf_m000rwsp_e3445d61-7fd1-4421-b75b-944e30291472.ism/pc_hd_abr_v2_nonuk_dash_master.mpd?s=1614079820&e=1614123020&h=672410a581135a4f9b036577fb47f684' \
-X 'GET' \
-H 'Pragma: no-cache' \
-H 'Accept: */*' \
-H 'Origin: https://emp.bbc.co.uk' \
-H 'Cache-Control: no-cache' \
-H 'Accept-Language: en-us' \
-H 'Host: aod-dash-ww-live.bbcfmt.s.llnwi.net' \
-H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0.3 Safari/605.1.15' \
-H 'Referer: https://emp.bbc.co.uk/' \
-H 'Connection: keep-alive'

# Get initialization file
curl --output - 'https://aod-dash-ww-live.bbcfmt.s.llnwi.net/usp/auth/vod/piff_abr_full_audio/1b88ea-m000rwsp/vf_m000rwsp_e3445d61-7fd1-4421-b75b-944e30291472.ism/dash/vf_m000rwsp_e3445d61-7fd1-4421-b75b-944e30291472-audio_eng_1=96000.dash' \
-X 'GET' \
-H 'Pragma: no-cache' \
-H 'Accept: */*' \
-H 'Origin: https://emp.bbc.co.uk' \
-H 'Cache-Control: no-cache' \
-H 'Accept-Language: en-us' \
-H 'Host: aod-dash-ww-live.bbcfmt.s.llnwi.net' \
-H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0.3 Safari/605.1.15' \
-H 'Referer: https://emp.bbc.co.uk/' \
-H 'Connection: keep-alive' > output.mp4

# Get segments
for i in {1..282}; do
  curl --output - "https://aod-dash-ww-live.bbcfmt.s.llnwi.net/usp/auth/vod/piff_abr_full_audio/1b88ea-m000rwsp/vf_m000rwsp_e3445d61-7fd1-4421-b75b-944e30291472.ism/dash/vf_m000rwsp_e3445d61-7fd1-4421-b75b-944e30291472-audio_eng_1=96000-$i.m4s" \
  -X 'GET' \
  -H 'Pragma: no-cache' \
  -H 'Accept: */*' \
  -H 'Origin: https://emp.bbc.co.uk' \
  -H 'Cache-Control: no-cache' \
  -H 'Accept-Language: en-us' \
  -H 'Host: aod-dash-ww-live.bbcfmt.s.llnwi.net' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0.3 Safari/605.1.15' \
  -H 'Referer: https://emp.bbc.co.uk/' \
  -H 'Connection: keep-alive' >> output.mp4
done

# Convert to audio
ffmpeg -i output.mp4 -vn output.mp3
