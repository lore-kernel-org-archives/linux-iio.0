Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:55171 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751552AbdHNJBP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Aug 2017 05:01:15 -0400
Date: Mon, 14 Aug 2017 11:01:23 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Cc: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] iio: srf08: add sensor type srf10
Message-ID: <20170814090123.GA9918@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Ultrasonic sensor srf10 is quite similar to srf08 and now also supported by
the driver as device tree compatible string.

It was necessary to prepare the source for supplementary sensors. This is
done by enum srf08_sensor_type.

The most significiant difference between srf08 and srf10 is another range
and values of register gain (in the driver it's call sensitivity).
Therefore the array of it is extended and dependent of the sensor type.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/proximity/Kconfig |  4 +--
 drivers/iio/proximity/srf08.c | 59 ++++++++++++++++++++++++++++++++++---------
 2 files changed, 49 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
index 5b81a8c9d438..df33ccc0d035 100644
--- a/drivers/iio/proximity/Kconfig
+++ b/drivers/iio/proximity/Kconfig
@@ -57,10 +57,10 @@ config SX9500
 	  module will be called sx9500.
 
 config SRF08
-	tristate "Devantech SRF08 ultrasonic ranger sensor"
+	tristate "Devantech SRF08/SRF10 ultrasonic ranger sensor"
 	depends on I2C
 	help
-	  Say Y here to build a driver for Devantech SRF08 ultrasonic
+	  Say Y here to build a driver for Devantech SRF08/SRF10 ultrasonic
 	  ranger sensor. This driver can be used to measure the distance
 	  of objects.
 
diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
index 8018bb90b7b2..52573b013313 100644
--- a/drivers/iio/proximity/srf08.c
+++ b/drivers/iio/proximity/srf08.c
@@ -9,6 +9,7 @@
  *
  * For details about the device see:
  * http://www.robot-electronics.co.uk/htm/srf08tech.html
+ * http://www.robot-electronics.co.uk/htm/srf10tech.htm
  */
 
 #include <linux/err.h>
@@ -33,9 +34,16 @@
 
 #define SRF08_CMD_RANGING_CM	0x51	/* Ranging Mode - Result in cm */
 
-#define SRF08_DEFAULT_GAIN	1025	/* default analogue value of Gain */
 #define SRF08_DEFAULT_RANGE	6020	/* default value of Range in mm */
 
+#define SRF08_MAX_SENSITIVITY	32	/* number of Gain Register values */
+
+enum srf08_sensor_type {
+	SRF08,
+	SRF10,
+	SRF_MAX_TYPE
+};
+
 struct srf08_data {
 	struct i2c_client	*client;
 
@@ -54,6 +62,9 @@ struct srf08_data {
 	 * 1x16-bit channel + 3x16 padding + 4x16 timestamp
 	 */
 	s16			buffer[8];
+
+	/* Sensor-Type */
+	enum srf08_sensor_type	sensor_type;
 };
 
 /*
@@ -63,11 +74,24 @@ struct srf08_data {
  * But with ADC's this term is already used differently and that's why it
  * is called "Sensitivity" here.
  */
-static const int srf08_sensitivity[] = {
+static const int srf08_sensitivity[SRF_MAX_TYPE][SRF08_MAX_SENSITIVITY] = {
+	[SRF08] = {
 	 94,  97, 100, 103, 107, 110, 114, 118,
 	123, 128, 133, 139, 145, 152, 159, 168,
 	177, 187, 199, 212, 227, 245, 265, 288,
-	317, 352, 395, 450, 524, 626, 777, 1025 };
+	317, 352, 395, 450, 524, 626, 777, 1025
+	},
+	[SRF10] = {
+	 40,  40,  50,  60,  70,  80, 100, 120,
+	140, 200, 250, 300, 350, 400, 500, 600,
+	700,
+	},
+};
+
+static const int srf08_default_sensitivity[SRF_MAX_TYPE] = {
+	[SRF08] = 1025,
+	[SRF10] = 700,
+};
 
 static int srf08_read_ranging(struct srf08_data *data)
 {
@@ -263,9 +287,13 @@ static ssize_t srf08_show_sensitivity_available(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	int i, len = 0;
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct srf08_data *data = iio_priv(indio_dev);
 
-	for (i = 0; i < ARRAY_SIZE(srf08_sensitivity); i++)
-		len += sprintf(buf + len, "%d ", srf08_sensitivity[i]);
+	for (i = 0; i < SRF08_MAX_SENSITIVITY; i++)
+		if (srf08_sensitivity[data->sensor_type][i])
+			len += sprintf(buf + len, "%d ",
+				srf08_sensitivity[data->sensor_type][i]);
 
 	len += sprintf(buf + len, "\n");
 
@@ -294,13 +322,16 @@ static ssize_t srf08_write_sensitivity(struct srf08_data *data,
 	int ret, i;
 	u8 regval;
 
-	for (i = 0; i < ARRAY_SIZE(srf08_sensitivity); i++)
-		if (val == srf08_sensitivity[i]) {
+	if (!val)
+		return -EINVAL;
+
+	for (i = 0; i < SRF08_MAX_SENSITIVITY; i++)
+		if (val && (val == srf08_sensitivity[data->sensor_type][i])) {
 			regval = i;
 			break;
 		}
 
-	if (i >= ARRAY_SIZE(srf08_sensitivity))
+	if (i >= SRF08_MAX_SENSITIVITY)
 		return -EINVAL;
 
 	mutex_lock(&data->lock);
@@ -398,8 +429,9 @@ static int srf08_probe(struct i2c_client *client,
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
+	data->sensor_type = (enum srf08_sensor_type)id->driver_data;
 
-	indio_dev->name = "srf08";
+	indio_dev->name = id->name;
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &srf08_info;
@@ -424,7 +456,8 @@ static int srf08_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
-	ret = srf08_write_sensitivity(data, SRF08_DEFAULT_GAIN);
+	ret = srf08_write_sensitivity(data,
+			srf08_default_sensitivity[id->driver_data]);
 	if (ret < 0)
 		return ret;
 
@@ -432,14 +465,16 @@ static int srf08_probe(struct i2c_client *client,
 }
 
 static const struct of_device_id of_srf08_match[] = {
-	{ .compatible = "devantech,srf08", 0},
+	{ .compatible = "devantech,srf08", (void *)SRF08},
+	{ .compatible = "devantech,srf10", (void *)SRF10},
 	{},
 };
 
 MODULE_DEVICE_TABLE(of, of_srf08_match);
 
 static const struct i2c_device_id srf08_id[] = {
-	{ "srf08", 0 },
+	{ "srf08", SRF08 },
+	{ "srf10", SRF10 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, srf08_id);
-- 
2.1.4


-- 
