Return-Path: <denis.ciocca@st.com>
From: Denis CIOCCA <denis.ciocca@st.com>
To: jic23@kernel.org, j.anaszewski@samsung.com,
	linux-iio@vger.kernel.org
Cc: Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 1/5] iio:common: Common library modifications to support pressure sensors
Date: Tue, 14 May 2013 16:21:59 +0200
Message-Id: <1368541323-27423-2-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1368541323-27423-1-git-send-email-denis.ciocca@st.com>
References: <1368541323-27423-1-git-send-email-denis.ciocca@st.com>
List-ID: <linux-iio@vger.kernel.org>

This patch add function pointer to get buffer element to support
the pressure sensors. The channel macro definition also changed.

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/common/st_sensors/st_sensors_buffer.c |    2 +-
 include/linux/iio/common/st_sensors.h             |   21 ++++++++++-----------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
index 09b236d..430039d 100644
--- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
+++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
@@ -94,7 +94,7 @@ irqreturn_t st_sensors_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 
-	len = st_sensors_get_buffer_element(indio_dev, sdata->buffer_data);
+	len = sdata->get_buffer_element(indio_dev, sdata->buffer_data);
 	if (len < 0)
 		goto st_sensors_get_buffer_element_error;
 
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index 172c5b2..50fc92e 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -30,8 +30,6 @@
 #define ST_SENSORS_SCAN_X			0
 #define ST_SENSORS_SCAN_Y			1
 #define ST_SENSORS_SCAN_Z			2
-#define ST_SENSORS_DEFAULT_12_REALBITS		12
-#define ST_SENSORS_DEFAULT_16_REALBITS		16
 #define ST_SENSORS_DEFAULT_POWER_ON_VALUE	0x01
 #define ST_SENSORS_DEFAULT_POWER_OFF_VALUE	0x00
 #define ST_SENSORS_DEFAULT_WAI_ADDRESS		0x0f
@@ -42,20 +40,20 @@
 #define ST_SENSORS_MAX_NAME			17
 #define ST_SENSORS_MAX_4WAI			7
 
-#define ST_SENSORS_LSM_CHANNELS(device_type, index, mod, endian, bits, addr) \
+#define ST_SENSORS_LSM_CHANNELS(device_type, mask, index, mod, \
+					ch2, s, endian, rbits, sbits, addr) \
 { \
 	.type = device_type, \
-	.modified = 1, \
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
-			BIT(IIO_CHAN_INFO_SCALE), \
+	.modified = mod, \
+	.info_mask_separate = mask, \
 	.scan_index = index, \
-	.channel2 = mod, \
+	.channel2 = ch2, \
 	.address = addr, \
 	.scan_type = { \
-		.sign = 's', \
-		.realbits = bits, \
-		.shift = 16 - bits, \
-		.storagebits = 16, \
+		.sign = s, \
+		.realbits = rbits, \
+		.shift = sbits - rbits, \
+		.storagebits = sbits, \
 		.endianness = endian, \
 	}, \
 }
@@ -222,6 +220,7 @@ struct st_sensor_data {
 	unsigned int odr;
 
 	unsigned int (*get_irq_data_ready) (struct iio_dev *indio_dev);
+	int (*get_buffer_element) (struct iio_dev *indio_dev, u8 *buf);
 
 	const struct st_sensor_transfer_function *tf;
 	struct st_sensor_transfer_buffer tb;
-- 
1.7.9.5
