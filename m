Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33267 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932361AbcFCKBg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jun 2016 06:01:36 -0400
Received: by mail-pf0-f179.google.com with SMTP id b124so42319503pfb.0
        for <linux-iio@vger.kernel.org>; Fri, 03 Jun 2016 03:01:36 -0700 (PDT)
From: Rocky Hsiao <rocky.hsiao@dyna-image.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Rocky Hsiao <rocky.hsiao@dyna-image.com>,
	linux-kernel@vger.kernel.org,
	John Huang <john.huang@dyna-image.com>,
	Thomas Lin <thomas.lin@dyna-image.com>
Subject: [PATCH 1/2] iio: light: al3320a: support illuminance0_input function
Date: Fri,  3 Jun 2016 18:00:16 +0800
Message-Id: <1464948016-49062-1-git-send-email-rocky.hsiao@dyna-image.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add few functions to show lux.

Signed-off-by: Rocky Hsiao <rocky.hsiao@dyna-image.com>
---
 drivers/iio/light/al3320a.c | 50 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
index 6aac651..f32b5d1 100644
--- a/drivers/iio/light/al3320a.c
+++ b/drivers/iio/light/al3320a.c
@@ -11,6 +11,13 @@
  *
  * TODO: interrupt support, thresholds
  *
+ * last change: 2016/06/03
+ *
+ * change list:
+ * - add few function to supprt illuminance0_input
+ *
+ * editor: Rocky Hsiao <rocky.hsiao@dyna-image>
+ *
  */
 
 #include <linux/module.h>
@@ -72,9 +79,47 @@ static const struct iio_chan_spec al3320a_channels[] = {
 	}
 };
 
+static int al3320a_get_adc_value(struct al3320a_data *data)
+{
+	int val;
+
+	val = i2c_smbus_read_word_data(data->client, AL3320A_REG_DATA_LOW);
+
+	return val;
+}
+
+static int al3320a_get_lux(struct al3320a_data *data)
+{
+	int ret;
+	long ret64;
+
+	ret = al3320a_get_adc_value(data);
+	ret64 = ret;
+	ret64 = (ret64 * 32000) / 1000000;
+	ret = ret64;
+
+	return  ret;
+}
+
+static ssize_t al3320a_lux_show(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct al3320a_data *data = iio_priv(dev_to_iio_dev(dev));
+	int val;
+
+	val = al3320a_get_lux(data);
+
+	return sprintf(buf, "%d\n", val);
+}
+
+static IIO_DEVICE_ATTR(illuminance0_input, S_IRUGO,
+		al3320a_lux_show, NULL, 0);
+
 static IIO_CONST_ATTR(in_illuminance_scale_available, AL3320A_SCALE_AVAILABLE);
 
 static struct attribute *al3320a_attributes[] = {
+	&iio_dev_attr_illuminance0_input.dev_attr.attr,
 	&iio_const_attr_in_illuminance_scale_available.dev_attr.attr,
 	NULL,
 };
@@ -125,8 +170,8 @@ static int al3320a_read_raw(struct iio_dev *indio_dev,
 		 * - low byte of output is stored at AL3320A_REG_DATA_LOW
 		 * - high byte of output is stored at AL3320A_REG_DATA_LOW + 1
 		 */
-		ret = i2c_smbus_read_word_data(data->client,
-					       AL3320A_REG_DATA_LOW);
+		ret = al3320a_get_adc_value(data);
+
 		if (ret < 0)
 			return ret;
 		*val = ret;
@@ -201,6 +246,7 @@ static int al3320a_probe(struct i2c_client *client,
 		dev_err(&client->dev, "al3320a chip init failed\n");
 		return ret;
 	}
+
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
-- 
2.1.2

