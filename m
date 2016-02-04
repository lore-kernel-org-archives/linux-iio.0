Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38856 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965721AbcBDOub (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 4 Feb 2016 09:50:31 -0500
From: Cristina Moraru <cristina.moraru09@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	cristina.opriceana@gmail.com, marek@goldelico.com,
	sdliyong@gmail.com, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	octavian.purdila@intel.com, daniel.baluta@intel.com
Cc: Cristina Moraru <cristina.moraru09@gmail.com>
Subject: [RFC PATCH 2/2] iio: hmc5843: Add attribute for available bias values
Date: Thu,  4 Feb 2016 16:50:13 +0200
Message-Id: <1454597413-5298-2-git-send-email-cristina.moraru09@gmail.com>
In-Reply-To: <1454597413-5298-1-git-send-email-cristina.moraru09@gmail.com>
References: <1454597413-5298-1-git-send-email-cristina.moraru09@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add static attribute calibbias_available to show available
configurations for the bias current.

API for setting bias measurement configuration:

0 - Normal measurement configuration (default): In normal measurement
    configuration the device follows normal measurement flow. Pins BP
    and BN are left floating and high impedance.

1 - Positive bias configuration: In positive bias configuration, a
    positive current is forced across the resistive load on pins BP
    and BN.

2 - Negative bias configuration. In negative bias configuration, a
    negative current is forced across the resistive load on pins BP
    and BN.

3 - Only available on HMC5983. Magnetic sensor is disabled.
    Temperature sensor is enabled.

Signed-off-by: Cristina Moraru <cristina.moraru09@gmail.com>
---
 drivers/staging/iio/magnetometer/hmc5843_core.c | 83 +++++++++++++++++++------
 1 file changed, 65 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843_core.c b/drivers/staging/iio/magnetometer/hmc5843_core.c
index c5f16da..9fc0eaa 100644
--- a/drivers/staging/iio/magnetometer/hmc5843_core.c
+++ b/drivers/staging/iio/magnetometer/hmc5843_core.c
@@ -66,6 +66,34 @@
 #define HMC5843_MEAS_CONF_NEGATIVE_BIAS		0x02
 #define HMC5843_MEAS_CONF_MASK			0x03
 
+/*
+ * API for setting the measurement configuration to
+ * Normal, Positive bias and Negative bias
+ *
+ * From the datasheet:
+ * 0 - Normal measurement configuration (default): In normal measurement
+ *     configuration the device follows normal measurement flow. Pins BP
+ *     and BN are left floating and high impedance.
+ *
+ * 1 - Positive bias configuration: In positive bias configuration, a
+ *     positive current is forced across the resistive load on pins BP
+ *     and BN.
+ *
+ * 2 - Negative bias configuration. In negative bias configuration, a
+ *     negative current is forced across the resistive load on pins BP
+ *     and BN.
+ *
+ * 3 - Only available on HMC5983. Magnetic sensor is disabled.
+ *     Temperature sensor is enabled.
+ */
+static const int hmc5843_regval_to_calibbias[] = {
+	0, 1, 2
+};
+
+static const int hmc5983_regval_to_calibbias[] = {
+	0, 1, 2, 3
+};
+
 /* Scaling factors: 10000000/Gain */
 static const int hmc5843_regval_to_nanoscale[] = {
 	6173, 7692, 10309, 12821, 18868, 21739, 25641, 35714
@@ -109,6 +137,8 @@ static const int hmc5983_regval_to_samp_freq[][2] = {
 /* Describe chip variants */
 struct hmc5843_chip_info {
 	const struct iio_chan_spec *channels;
+	const int *regval_to_calibbias;
+	const int n_regval_to_calibbias;
 	const int (*regval_to_samp_freq)[2];
 	const int n_regval_to_samp_freq;
 	const int *regval_to_nanoscale;
@@ -174,24 +204,6 @@ static int hmc5843_read_measurement(struct hmc5843_data *data,
 	return IIO_VAL_INT;
 }
 
-/*
- * API for setting the measurement configuration to
- * Normal, Positive bias and Negative bias
- *
- * From the datasheet:
- * 0 - Normal measurement configuration (default): In normal measurement
- *     configuration the device follows normal measurement flow. Pins BP
- *     and BN are left floating and high impedance.
- *
- * 1 - Positive bias configuration: In positive bias configuration, a
- *     positive current is forced across the resistive load on pins BP
- *     and BN.
- *
- * 2 - Negative bias configuration. In negative bias configuration, a
- *     negative current is forced across the resistive load on pins BP
- *     and BN.
- *
- */
 static int hmc5843_set_meas_conf(struct hmc5843_data *data, u8 meas_conf)
 {
 	int ret;
@@ -286,6 +298,28 @@ static ssize_t hmc5843_show_scale_avail(struct device *dev,
 static IIO_DEVICE_ATTR(scale_available, S_IRUGO,
 	hmc5843_show_scale_avail, NULL, 0);
 
+static ssize_t hmc5843_show_calibbias_avail(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct hmc5843_data *data = iio_priv(dev_to_iio_dev(dev));
+
+	size_t len = 0;
+	int i;
+
+	for (i = 0; i < data->variant->n_regval_to_calibbias; i++)
+		len += scnprintf(buf + len, PAGE_SIZE - len,
+			"%d ", data->variant->regval_to_calibbias[i]);
+
+	/* replace trailing space by newline */
+	buf[len - 1] = '\n';
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR(calibbias_available, S_IRUGO,
+	hmc5843_show_calibbias_avail, NULL, 0);
+
 static int hmc5843_get_scale_index(struct hmc5843_data *data, int val, int val2)
 {
 	int i;
@@ -448,6 +482,7 @@ static const struct iio_chan_spec hmc5883_channels[] = {
 };
 
 static struct attribute *hmc5843_attributes[] = {
+	&iio_dev_attr_calibbias_available.dev_attr.attr,
 	&iio_dev_attr_scale_available.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
 	NULL
@@ -460,6 +495,9 @@ static const struct attribute_group hmc5843_group = {
 static const struct hmc5843_chip_info hmc5843_chip_info_tbl[] = {
 	[HMC5843_ID] = {
 		.channels = hmc5843_channels,
+		.regval_to_calibbias = hmc5843_regval_to_calibbias,
+		.n_regval_to_calibbias =
+				ARRAY_SIZE(hmc5843_regval_to_calibbias),
 		.regval_to_samp_freq = hmc5843_regval_to_samp_freq,
 		.n_regval_to_samp_freq =
 				ARRAY_SIZE(hmc5843_regval_to_samp_freq),
@@ -469,6 +507,9 @@ static const struct hmc5843_chip_info hmc5843_chip_info_tbl[] = {
 	},
 	[HMC5883_ID] = {
 		.channels = hmc5883_channels,
+		.regval_to_calibbias = hmc5843_regval_to_calibbias,
+		.n_regval_to_calibbias =
+				ARRAY_SIZE(hmc5843_regval_to_calibbias),
 		.regval_to_samp_freq = hmc5883_regval_to_samp_freq,
 		.n_regval_to_samp_freq =
 				ARRAY_SIZE(hmc5883_regval_to_samp_freq),
@@ -478,6 +519,9 @@ static const struct hmc5843_chip_info hmc5843_chip_info_tbl[] = {
 	},
 	[HMC5883L_ID] = {
 		.channels = hmc5883_channels,
+		.regval_to_calibbias = hmc5843_regval_to_calibbias,
+		.n_regval_to_calibbias =
+				ARRAY_SIZE(hmc5843_regval_to_calibbias),
 		.regval_to_samp_freq = hmc5883_regval_to_samp_freq,
 		.n_regval_to_samp_freq =
 				ARRAY_SIZE(hmc5883_regval_to_samp_freq),
@@ -487,6 +531,9 @@ static const struct hmc5843_chip_info hmc5843_chip_info_tbl[] = {
 	},
 	[HMC5983_ID] = {
 		.channels = hmc5883_channels,
+		.regval_to_calibbias = hmc5983_regval_to_calibbias,
+		.n_regval_to_calibbias =
+				ARRAY_SIZE(hmc5983_regval_to_calibbias),
 		.regval_to_samp_freq = hmc5983_regval_to_samp_freq,
 		.n_regval_to_samp_freq =
 				ARRAY_SIZE(hmc5983_regval_to_samp_freq),
-- 
1.9.1

