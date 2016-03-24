Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:34353 "EHLO
	mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbcCXNSe (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 24 Mar 2016 09:18:34 -0400
Received: by mail-lf0-f44.google.com with SMTP id c62so30918174lfc.1
        for <linux-iio@vger.kernel.org>; Thu, 24 Mar 2016 06:18:33 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 2/4] iio: st_sensors: read each channel individually
Date: Thu, 24 Mar 2016 14:18:04 +0100
Message-Id: <1458825486-17188-2-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1458825486-17188-1-git-send-email-linus.walleij@linaro.org>
References: <1458825486-17188-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The current buffer read code tries to optimize reads from the
sensor data registers by issuing a single read operation across
all the indata registers.

This doesn't work: when the LIS331DL accelerometer sensor is
configured to open drain, active low interrupt mode, this will
just clear the XDA (X-axis data available) bit in the STATUS_REG
register (0x27), while YDA, ZDA and even ZYXDA remain set to 1,
and the internal logic of the sensor holds the DRDY (INT1) line
asserted (the value of the status register is 0xee).

If we instead issue one read operation per enabled channel
(X, Y, Z) things start working and we can use open drain and
active low interrupts.

Cc: Giuseppe Barba <giuseppe.barba@st.com>
Cc: Denis Ciocca <denis.ciocca@st.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/common/st_sensors/st_sensors_buffer.c | 63 +++++------------------
 1 file changed, 13 insertions(+), 50 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
index 73764961feac..2ce0d2a3f855 100644
--- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
+++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
@@ -24,67 +24,30 @@
 
 int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
 {
-	u8 addr[3]; /* no ST sensor has more than 3 channels */
-	int i, n = 0, len;
+	int i, len;
+	int total = 0;
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 	unsigned int num_data_channels = sdata->num_data_channels;
-	unsigned int byte_for_channel =
-			indio_dev->channels[0].scan_type.storagebits >> 3;
 
 	for (i = 0; i < num_data_channels; i++) {
+		unsigned int bytes_to_read;
+
 		if (test_bit(i, indio_dev->active_scan_mask)) {
-			addr[n] = indio_dev->channels[i].address;
-			n++;
-		}
-	}
-	switch (n) {
-	case 1:
-		len = sdata->tf->read_multiple_byte(&sdata->tb, sdata->dev,
-			addr[0], byte_for_channel, buf, sdata->multiread_bit);
-		break;
-	case 2:
-		if ((addr[1] - addr[0]) == byte_for_channel) {
+			bytes_to_read = indio_dev->channels[i].scan_type.storagebits >> 3;
 			len = sdata->tf->read_multiple_byte(&sdata->tb,
-				sdata->dev, addr[0], byte_for_channel * n,
-				buf, sdata->multiread_bit);
-		} else {
-			u8 *rx_array;
-			rx_array = kmalloc(byte_for_channel * num_data_channels,
-					   GFP_KERNEL);
-			if (!rx_array)
-				return -ENOMEM;
+				sdata->dev, indio_dev->channels[i].address,
+				bytes_to_read,
+				buf + total, sdata->multiread_bit);
 
-			len = sdata->tf->read_multiple_byte(&sdata->tb,
-				sdata->dev, addr[0],
-				byte_for_channel * num_data_channels,
-				rx_array, sdata->multiread_bit);
-			if (len < 0) {
-				kfree(rx_array);
-				return len;
-			}
+			if (len < bytes_to_read)
+				return -EIO;
 
-			for (i = 0; i < n * byte_for_channel; i++) {
-				if (i < n)
-					buf[i] = rx_array[i];
-				else
-					buf[i] = rx_array[n + i];
-			}
-			kfree(rx_array);
-			len = byte_for_channel * n;
+			/* Advance the buffer pointer */
+			total += len;
 		}
-		break;
-	case 3:
-		len = sdata->tf->read_multiple_byte(&sdata->tb, sdata->dev,
-			addr[0], byte_for_channel * num_data_channels,
-			buf, sdata->multiread_bit);
-		break;
-	default:
-		return -EINVAL;
 	}
-	if (len != byte_for_channel * n)
-		return -EIO;
 
-	return len;
+	return total;
 }
 EXPORT_SYMBOL(st_sensors_get_buffer_element);
 
-- 
2.4.3

