Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:34190 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932291Ab3JNVfD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 14 Oct 2013 17:35:03 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH v3 04/10] staging:iio:hmc5843: Remove ability to change operating mode
Date: Mon, 14 Oct 2013 23:34:52 +0200
Message-Id: <1381786498-25954-5-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1381786498-25954-1-git-send-email-pmeerw@pmeerw.net>
References: <1381786498-25954-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

only continuous mode is supported for now; the driver could/should
be switched to single conversion mode

operating mode should be determined by the way IIO accesses the device
and not exposed explicitly

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/magnetometer/hmc5843.c | 68 ------------------------------
 1 file changed, 68 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index b6380fa..91b5ddf 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -186,73 +186,6 @@ static int hmc5843_read_measurement(struct hmc5843_data *data,
 }
 
 /*
- * From the datasheet:
- * 0 - Continuous-Conversion Mode: In continuous-conversion mode, the
- *     device continuously performs conversions and places the result in
- *     the data register.
- *
- * 1 - Single-Conversion Mode : Device performs a single measurement,
- *     sets RDY high and returns to sleep mode.
- *
- * 2 - Idle Mode : Device is placed in idle mode.
- *
- * 3 - Sleep Mode : Device is placed in sleep mode.
- *
- */
-static ssize_t hmc5843_show_operating_mode(struct device *dev,
-					struct device_attribute *attr,
-					char *buf)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct hmc5843_data *data = iio_priv(indio_dev);
-	return sprintf(buf, "%d\n", data->operating_mode);
-}
-
-static ssize_t hmc5843_set_operating_mode(struct device *dev,
-				struct device_attribute *attr,
-				const char *buf,
-				size_t count)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
-	struct hmc5843_data *data = iio_priv(indio_dev);
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	unsigned long operating_mode = 0;
-	s32 status;
-	int error;
-
-	mutex_lock(&data->lock);
-	error = kstrtoul(buf, 10, &operating_mode);
-	if (error) {
-		count = error;
-		goto exit;
-	}
-	dev_dbg(dev, "set conversion mode to %lu\n", operating_mode);
-	if (operating_mode > HMC5843_MODE_SLEEP) {
-		count = -EINVAL;
-		goto exit;
-	}
-
-	status = i2c_smbus_write_byte_data(client, this_attr->address,
-					operating_mode);
-	if (status) {
-		count = -EINVAL;
-		goto exit;
-	}
-	data->operating_mode = operating_mode;
-
-exit:
-	mutex_unlock(&data->lock);
-	return count;
-}
-
-static IIO_DEVICE_ATTR(operating_mode,
-			S_IWUSR | S_IRUGO,
-			hmc5843_show_operating_mode,
-			hmc5843_set_operating_mode,
-			HMC5843_MODE_REG);
-
-/*
  * API for setting the measurement configuration to
  * Normal, Positive bias and Negative bias
  *
@@ -546,7 +479,6 @@ static const struct iio_chan_spec hmc5883_channels[] = {
 
 static struct attribute *hmc5843_attributes[] = {
 	&iio_dev_attr_meas_conf.dev_attr.attr,
-	&iio_dev_attr_operating_mode.dev_attr.attr,
 	&iio_dev_attr_scale_available.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
 	NULL
-- 
1.8.4

