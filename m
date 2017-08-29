Return-Path: <SRS0=wrTi=77=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linus.walleij@linaro.org,
	lorenzo.bianconi@st.com
Subject: [PATCH] iio: magnetometer: st_magn: fix drdy line configuration for LIS3MDL
Date: Tue, 29 Aug 2017 13:45:11 +0200
Message-Id: <20170829114511.14756-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Data-ready line in LIS3MDL is routed to drdy pin and it is not possible
to select a different INT pin. st_sensors_set_dataready_irq() assumes
that if drdy int address is not exported in register map, irq trigger
is not supported by the sensor and hw_irq_trigger is always false.
Based on this configuration st_sensors_irq_thread does not consume
generated interrupt causing an unhandled irq.
Fix this taking into account status register address in
st_sensors_set_dataready_irq()

Fixes: 90efe0556292 (iio: st_sensors: harden interrupt handling)
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/common/st_sensors/st_sensors_core.c | 11 ++++++++++-
 drivers/iio/magnetometer/st_magn_core.c         |  4 ++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index d99bb1460fe2..02e833b14db0 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -463,8 +463,17 @@ int st_sensors_set_dataready_irq(struct iio_dev *indio_dev, bool enable)
 	u8 drdy_mask;
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 
-	if (!sdata->sensor_settings->drdy_irq.addr)
+	if (!sdata->sensor_settings->drdy_irq.addr) {
+		/*
+		 * there are some devices (e.g. LIS3MDL) where drdy line is
+		 * routed to a given pin and it is not possible to select a
+		 * different one. Take into account irq status register
+		 * to understand if irq trigger can be properly supported
+		 */
+		if (sdata->sensor_settings->drdy_irq.addr_stat_drdy)
+			sdata->hw_irq_trigger = enable;
 		return 0;
+	}
 
 	/* Enable/Disable the interrupt generator 1. */
 	if (sdata->sensor_settings->drdy_irq.ig1.en_addr > 0) {
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 83fdd7230917..f7388d265eb0 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -315,6 +315,10 @@ static const struct st_sensor_settings st_magn_sensors_settings[] = {
 				},
 			},
 		},
+		.drdy_irq = {
+			/* drdy line is routed drdy pin */
+			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
+		},
 		.multi_read_bit = true,
 		.bootime = 2,
 	},
-- 
2.14.1
