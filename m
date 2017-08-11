Return-Path: <SRS0=OkIe=7N=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	gregor.boirie@parrot.com,
	denis.ciocca@st.com,
	lorenzo.bianconi@st.com
Subject: [PATCH 2/2] iio: accel: st_accel: fix data-ready line configuration
Date: Fri, 11 Aug 2017 21:44:14 +0200
Message-Id: <20170811194414.20741-3-lorenzo.bianconi@st.com>
In-Reply-To: <20170811194414.20741-1-lorenzo.bianconi@st.com>
References: <20170811194414.20741-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Remove int2 configuration parameter for LIS3DH, LSM303DLHC, LSM330D,
LSM330DL, LSM330DLC, LSM303AGR, LIS2DH12 and LNG2DM since these devices
export just int1 as data-ready line

Fixes: 23cde4d65cc7 (iio: Added platform data to select the DRDY pin)
Fixes: dcdb0a78cab3 (iio: accel: st_accel: add support to lng2dm)
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/accel/st_accel_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 1e0eea110fa9..752856b3a849 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -161,7 +161,7 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 		.drdy_irq = {
 			.addr = 0x22,
 			.mask_int1 = 0x10,
-			.mask_int2 = 0x08,
+			.mask_int2 = 0x00,
 			.addr_ihl = 0x25,
 			.mask_ihl = 0x02,
 			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
@@ -637,7 +637,7 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 		.drdy_irq = {
 			.addr = 0x22,
 			.mask_int1 = 0x10,
-			.mask_int2 = 0x08,
+			.mask_int2 = 0x00,
 			.addr_ihl = 0x25,
 			.mask_ihl = 0x02,
 			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
-- 
2.14.0
