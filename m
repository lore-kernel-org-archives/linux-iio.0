Return-Path: <denis.ciocca@st.com>
From: Denis CIOCCA <denis.ciocca@st.com>
To: jic23@kernel.org, lars@metafoo.de
Cc: linux-iio@vger.kernel.org, Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH] iio:magn: Add sensors_supported in st_magn_sensors
Date: Tue, 29 Jan 2013 12:54:01 +0100
Message-Id: <1359460441-19310-1-git-send-email-denis.ciocca@st.com>
List-ID: <linux-iio@vger.kernel.org>

This patch add sensors_supported struct to st_magn_sensors. Without this the probe can't match the WhoAmI and sensor name.
---
 drivers/iio/magnetometer/st_magn_core.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 1dfcb41..a69fbe1 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -136,6 +136,10 @@ static const struct iio_chan_spec st_magn_2_16bit_channels[] = {
 static const struct st_sensors st_magn_sensors[] = {
 	{
 		.wai = ST_MAGN_1_WAI_EXP,
+		.sensors_supported = {
+			[0] = LSM303DLHC_MAGN_DEV_NAME,
+			[1] = LSM303DLM_MAGN_DEV_NAME,
+		},
 		.ch = (struct iio_chan_spec *)st_magn_16bit_channels,
 		.odr = {
 			.addr = ST_MAGN_1_ODR_ADDR,
@@ -210,6 +214,9 @@ static const struct st_sensors st_magn_sensors[] = {
 	},
 	{
 		.wai = ST_MAGN_2_WAI_EXP,
+		.sensors_supported = {
+			[0] = LIS3MDL_MAGN_DEV_NAME,
+		},
 		.ch = (struct iio_chan_spec *)st_magn_2_16bit_channels,
 		.odr = {
 			.addr = ST_MAGN_2_ODR_ADDR,
-- 
1.7.9.5
