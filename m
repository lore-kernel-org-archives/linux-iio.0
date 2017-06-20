Return-Path: <SRS0=PPNF=5Z=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org
Subject: [PATCH] iio: magnetometer: st_magn_core: enable multiread by default for LIS3MDL
Date: Tue, 20 Jun 2017 19:42:45 +0200
Message-Id: <20170620174245.6800-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Enable multiread by default for LIS3MDL since using I2C interface
the subaddr Msb is used to automatically increase the slave address
during multiple data read/write. In the same way, using SPI interface,
bit 1 in register address is used to enable auto-increment of the slave
address in multiple read/write.

Fixes: 872e79add756 (iio:magn: Add STMicroelectronics magn driver)
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/magnetometer/st_magn_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 8e1b0861fbe4..3573636bad8e 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -315,7 +315,7 @@ static const struct st_sensor_settings st_magn_sensors_settings[] = {
 				},
 			},
 		},
-		.multi_read_bit = false,
+		.multi_read_bit = true,
 		.bootime = 2,
 	},
 	{
-- 
2.13.1
