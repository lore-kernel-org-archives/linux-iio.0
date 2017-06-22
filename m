Return-Path: <SRS0=TZvf=53=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: gregor.boirie@parrot.com,
	linux-iio@vger.kernel.org,
	lorenzo.bianconi@st.com
Subject: [PATCH] iio: pressure: st_pressure_core: disable multiread by default for LPS22HB
Date: Thu, 22 Jun 2017 19:46:43 +0200
Message-Id: <20170622174643.13259-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Set multiread variable to false for LPS22HB pressure sensor since
it is already enabled in CTRL_REG2. Previous configuration does not
cause any issue in I2C communication since SUB Msb has no meaning
whereas it breaks register address in SPI communication

Fixes: e039e2f5b4da (iio:st_pressure:initial lps22hb sensor support)
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/pressure/st_pressure_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index aa61ec15c139..f1bce05ffa13 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -456,7 +456,7 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
 			.mask_od = 0x40,
 			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
 		},
-		.multi_read_bit = true,
+		.multi_read_bit = false,
 		.bootime = 2,
 	},
 };
-- 
2.13.1
