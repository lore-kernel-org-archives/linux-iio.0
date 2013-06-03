Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eu1sys200aog111.obsmtp.com ([207.126.144.131]:38640 "EHLO
	eu1sys200aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758076Ab3FCO7I (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 3 Jun 2013 10:59:08 -0400
From: Denis CIOCCA <denis.ciocca@st.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, frederic.pillon@stericsson.com,
	lee.jones@stericcson.com, Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 2/3] iio:common: Removed stuff macros, added num_data_channels on st_sensors struct             and added support on one-shot sysfs reads to 3 byte channel
Date: Mon,  3 Jun 2013 16:58:51 +0200
Message-Id: <1370271532-10194-3-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1370271532-10194-1-git-send-email-denis.ciocca@st.com>
References: <1370271532-10194-1-git-send-email-denis.ciocca@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch introduce num_data_channels variable on st_sensors struct
to manage different type of channels (size or number) in
st_sensors_get_buffer_element function.
Removed ST_SENSORS_NUMBER_DATA_CHANNELS and ST_SENSORS_BYTE_FOR_CHANNEL
and used struct iio_chan_spec const *ch to catch data.
Added 3 byte channel data support on one-shot reads.

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/accel/st_accel_core.c                 |    3 ++
 drivers/iio/common/st_sensors/st_sensors_buffer.c |   49 ++++++++++++---------
 drivers/iio/common/st_sensors/st_sensors_core.c   |   34 ++++++++++----
 drivers/iio/gyro/st_gyro_core.c                   |    3 ++
 drivers/iio/magnetometer/st_magn_core.c           |    3 ++
 include/linux/iio/common/st_sensors.h             |    4 +-
 6 files changed, 64 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 40236d5..4aec121 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -26,6 +26,8 @@
 #include <linux/iio/common/st_sensors.h>
 #include "st_accel.h"
 
+#define ST_ACCEL_NUMBER_DATA_CHANNELS		3
+
 /* DEFAULT VALUE FOR SENSORS */
 #define ST_ACCEL_DEFAULT_OUT_X_L_ADDR		0x28
 #define ST_ACCEL_DEFAULT_OUT_Y_L_ADDR		0x2a
@@ -454,6 +456,7 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
 	if (err < 0)
 		goto st_accel_common_probe_error;
 
+	adata->num_data_channels = ST_ACCEL_NUMBER_DATA_CHANNELS;
 	adata->multiread_bit = adata->sensor->multi_read_bit;
 	indio_dev->channels = adata->sensor->ch;
 	indio_dev->num_channels = ST_SENSORS_NUMBER_ALL_CHANNELS;
diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
index 09b236d..7a76db3 100644
--- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
+++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
@@ -24,11 +24,20 @@
 
 int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
 {
+	u8 *addr;
 	int i, n = 0, len;
-	u8 addr[ST_SENSORS_NUMBER_DATA_CHANNELS];
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
+	unsigned int num_data_channels = sdata->num_data_channels;
+	unsigned int byte_for_channel =
+			indio_dev->channels[0].scan_type.storagebits >> 3;
 
-	for (i = 0; i < ST_SENSORS_NUMBER_DATA_CHANNELS; i++) {
+	addr = kmalloc(num_data_channels, GFP_KERNEL);
+	if (!addr) {
+		len = -ENOMEM;
+		goto st_sensors_get_buffer_element_error;
+	}
+
+	for (i = 0; i < num_data_channels; i++) {
 		if (test_bit(i, indio_dev->active_scan_mask)) {
 			addr[n] = indio_dev->channels[i].address;
 			n++;
@@ -37,52 +46,48 @@ int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
 	switch (n) {
 	case 1:
 		len = sdata->tf->read_multiple_byte(&sdata->tb, sdata->dev,
-			addr[0], ST_SENSORS_BYTE_FOR_CHANNEL, buf,
-			sdata->multiread_bit);
+			addr[0], byte_for_channel, buf, sdata->multiread_bit);
 		break;
 	case 2:
-		if ((addr[1] - addr[0]) == ST_SENSORS_BYTE_FOR_CHANNEL) {
+		if ((addr[1] - addr[0]) == byte_for_channel) {
 			len = sdata->tf->read_multiple_byte(&sdata->tb,
-					sdata->dev, addr[0],
-					ST_SENSORS_BYTE_FOR_CHANNEL*n,
-					buf, sdata->multiread_bit);
+				sdata->dev, addr[0], byte_for_channel * n,
+				buf, sdata->multiread_bit);
 		} else {
-			u8 rx_array[ST_SENSORS_BYTE_FOR_CHANNEL*
-				    ST_SENSORS_NUMBER_DATA_CHANNELS];
+			u8 rx_array[byte_for_channel * num_data_channels];
 			len = sdata->tf->read_multiple_byte(&sdata->tb,
 				sdata->dev, addr[0],
-				ST_SENSORS_BYTE_FOR_CHANNEL*
-				ST_SENSORS_NUMBER_DATA_CHANNELS,
+				byte_for_channel * num_data_channels,
 				rx_array, sdata->multiread_bit);
 			if (len < 0)
-				goto read_data_channels_error;
+				goto st_sensors_free_memory;
 
-			for (i = 0; i < n * ST_SENSORS_NUMBER_DATA_CHANNELS;
-									i++) {
+			for (i = 0; i < n * num_data_channels; i++) {
 				if (i < n)
 					buf[i] = rx_array[i];
 				else
 					buf[i] = rx_array[n + i];
 			}
-			len = ST_SENSORS_BYTE_FOR_CHANNEL*n;
+			len = byte_for_channel * n;
 		}
 		break;
 	case 3:
 		len = sdata->tf->read_multiple_byte(&sdata->tb, sdata->dev,
-			addr[0], ST_SENSORS_BYTE_FOR_CHANNEL*
-			ST_SENSORS_NUMBER_DATA_CHANNELS,
+			addr[0], byte_for_channel * num_data_channels,
 			buf, sdata->multiread_bit);
 		break;
 	default:
 		len = -EINVAL;
-		goto read_data_channels_error;
+		goto st_sensors_free_memory;
 	}
-	if (len != ST_SENSORS_BYTE_FOR_CHANNEL*n) {
+	if (len != byte_for_channel * n) {
 		len = -EIO;
-		goto read_data_channels_error;
+		goto st_sensors_free_memory;
 	}
 
-read_data_channels_error:
+st_sensors_free_memory:
+	kfree(addr);
+st_sensors_get_buffer_element_error:
 	return len;
 }
 EXPORT_SYMBOL(st_sensors_get_buffer_element);
diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index ed9bc8a..865b178 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -20,6 +20,11 @@
 
 #define ST_SENSORS_WAI_ADDRESS		0x0f
 
+static inline u32 st_sensors_get_unaligned_le24(const u8 *p)
+{
+	return ((s32)((p[0] | p[1] << 8 | p[2] << 16) << 8) >> 8);
+}
+
 static int st_sensors_write_data_with_mask(struct iio_dev *indio_dev,
 						u8 reg_addr, u8 mask, u8 data)
 {
@@ -112,7 +117,8 @@ st_sensors_match_odr_error:
 	return ret;
 }
 
-static int st_sensors_set_fullscale(struct iio_dev *indio_dev, unsigned int fs)
+static int st_sensors_set_fullscale(struct iio_dev *indio_dev,
+							unsigned int fs)
 {
 	int err, i = 0;
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
@@ -273,21 +279,33 @@ st_sensors_match_scale_error:
 EXPORT_SYMBOL(st_sensors_set_fullscale_by_gain);
 
 static int st_sensors_read_axis_data(struct iio_dev *indio_dev,
-							u8 ch_addr, int *data)
+				struct iio_chan_spec const *ch, int *data)
 {
 	int err;
-	u8 outdata[ST_SENSORS_BYTE_FOR_CHANNEL];
+	u8 *outdata;
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
+	unsigned int byte_for_channel = ch->scan_type.storagebits >> 3;
+
+	outdata = kmalloc(byte_for_channel, GFP_KERNEL);
+	if (!outdata) {
+		err = -EINVAL;
+		goto st_sensors_read_axis_data_error;
+	}
 
 	err = sdata->tf->read_multiple_byte(&sdata->tb, sdata->dev,
-				ch_addr, ST_SENSORS_BYTE_FOR_CHANNEL,
+				ch->address, byte_for_channel,
 				outdata, sdata->multiread_bit);
 	if (err < 0)
-		goto read_error;
+		goto st_sensors_free_memory;
 
-	*data = (s16)get_unaligned_le16(outdata);
+	if (byte_for_channel == 2)
+		*data = (s16)get_unaligned_le16(outdata);
+	else if (byte_for_channel == 3)
+		*data = (s32)st_sensors_get_unaligned_le24(outdata);
 
-read_error:
+st_sensors_free_memory:
+	kfree(outdata);
+st_sensors_read_axis_data_error:
 	return err;
 }
 
@@ -307,7 +325,7 @@ int st_sensors_read_info_raw(struct iio_dev *indio_dev,
 			goto read_error;
 
 		msleep((sdata->sensor->bootime * 1000) / sdata->odr);
-		err = st_sensors_read_axis_data(indio_dev, ch->address, val);
+		err = st_sensors_read_axis_data(indio_dev, ch, val);
 		if (err < 0)
 			goto read_error;
 
diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index 9bae46b..f9ed348 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -27,6 +27,8 @@
 #include <linux/iio/common/st_sensors.h>
 #include "st_gyro.h"
 
+#define ST_GYRO_NUMBER_DATA_CHANNELS		3
+
 /* DEFAULT VALUE FOR SENSORS */
 #define ST_GYRO_DEFAULT_OUT_X_L_ADDR		0x28
 #define ST_GYRO_DEFAULT_OUT_Y_L_ADDR		0x2a
@@ -313,6 +315,7 @@ int st_gyro_common_probe(struct iio_dev *indio_dev)
 	if (err < 0)
 		goto st_gyro_common_probe_error;
 
+	gdata->num_data_channels = ST_GYRO_NUMBER_DATA_CHANNELS;
 	gdata->multiread_bit = gdata->sensor->multi_read_bit;
 	indio_dev->channels = gdata->sensor->ch;
 	indio_dev->num_channels = ST_SENSORS_NUMBER_ALL_CHANNELS;
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 715d616..ebfe8f1 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -26,6 +26,8 @@
 #include <linux/iio/common/st_sensors.h>
 #include "st_magn.h"
 
+#define ST_MAGN_NUMBER_DATA_CHANNELS		3
+
 /* DEFAULT VALUE FOR SENSORS */
 #define ST_MAGN_DEFAULT_OUT_X_L_ADDR		0X04
 #define ST_MAGN_DEFAULT_OUT_Y_L_ADDR		0X08
@@ -356,6 +358,7 @@ int st_magn_common_probe(struct iio_dev *indio_dev)
 	if (err < 0)
 		goto st_magn_common_probe_error;
 
+	mdata->num_data_channels = ST_MAGN_NUMBER_DATA_CHANNELS;
 	mdata->multiread_bit = mdata->sensor->multi_read_bit;
 	indio_dev->channels = mdata->sensor->ch;
 	indio_dev->num_channels = ST_SENSORS_NUMBER_ALL_CHANNELS;
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index 5ffd763..72b2694 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -24,9 +24,7 @@
 #define ST_SENSORS_FULLSCALE_AVL_MAX		10
 
 #define ST_SENSORS_NUMBER_ALL_CHANNELS		4
-#define ST_SENSORS_NUMBER_DATA_CHANNELS		3
 #define ST_SENSORS_ENABLE_ALL_AXIS		0x07
-#define ST_SENSORS_BYTE_FOR_CHANNEL		2
 #define ST_SENSORS_SCAN_X			0
 #define ST_SENSORS_SCAN_Y			1
 #define ST_SENSORS_SCAN_Z			2
@@ -202,6 +200,7 @@ struct st_sensors {
  * @multiread_bit: Use or not particular bit for [I2C/SPI] multiread.
  * @buffer_data: Data used by buffer part.
  * @odr: Output data rate of the sensor [Hz].
+ * num_data_channels: Number of data channels used in buffer.
  * @get_irq_data_ready: Function to get the IRQ used for data ready signal.
  * @tf: Transfer function structure used by I/O operations.
  * @tb: Transfer buffers and mutex used by I/O operations.
@@ -218,6 +217,7 @@ struct st_sensor_data {
 	char *buffer_data;
 
 	unsigned int odr;
+	unsigned int num_data_channels;
 
 	unsigned int (*get_irq_data_ready) (struct iio_dev *indio_dev);
 
-- 
1.7.9.5

