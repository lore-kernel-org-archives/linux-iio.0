Return-Path: <SRS0=M5O5=7S=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linus.walleij@linaro.org,
	lorenzo.bianconi@st.com
Subject: [PATCH 2/4] iio: magnetometer: st_magn: remove ihl property for LSM303AGR
Date: Wed, 16 Aug 2017 19:02:51 +0200
Message-Id: <20170816170253.8382-3-lorenzo.bianconi@st.com>
In-Reply-To: <20170816170253.8382-1-lorenzo.bianconi@st.com>
References: <20170816170253.8382-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Remove IRQ active low support for LSM303AGR since the sensor does not
support that capability for data-ready line

Fixes: a9fd053b56c6 (iio: st_sensors: support active-low interrupts)
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/magnetometer/st_magn_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 039b0e94420a..cd89962f2de3 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -356,8 +356,6 @@ static const struct st_sensor_settings st_magn_sensors_settings[] = {
 		.drdy_irq = {
 			.addr = 0x62,
 			.mask_int1 = 0x01,
-			.addr_ihl = 0x63,
-			.mask_ihl = 0x04,
 			.addr_stat_drdy = 0x67,
 		},
 		.multi_read_bit = false,
-- 
2.14.0
