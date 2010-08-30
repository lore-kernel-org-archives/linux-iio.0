Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay02-haj2.antispameurope.com ([83.246.65.52]:43357 "EHLO
	relay02-haj2.antispameurope.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755505Ab0H3ODz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 30 Aug 2010 10:03:55 -0400
Received: from iis.fhg.de (iis.iis.fhg.de [153.96.172.2])
	by relay02-haj2.antispameurope.com (ASE-Secure-MTA) with SMTP id C44026F062A
	for <linux-iio@vger.kernel.org>; Mon, 30 Aug 2010 16:03:52 +0200 (CEST)
Received: from smtp02.iis.fraunhofer.de (mailserv02.iis.fraunhofer.de [153.96.171.52])
	by iis.fhg.de (8.8.5/) with ESMTP id QAA27905
	for <linux-iio@vger.kernel.org>; Mon, 30 Aug 2010 16:03:52 +0200 (MET DST)
Received: from ix1064.iis.fraunhofer.de (ix1064.iis.fhg.de [10.12.75.146])
	by smtp02.iis.fraunhofer.de (Postfix) with ESMTP id B9F07200A085
	for <linux-iio@vger.kernel.org>; Mon, 30 Aug 2010 16:03:52 +0200 (CEST)
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
To: linux-iio@vger.kernel.org
Subject: [PATCH 3/3] staging:iio:hmc5843 change ABI to comply with documentation
Date: Mon, 30 Aug 2010 16:03:52 +0200
Message-Id: <1283177032-7014-3-git-send-email-manuel.stahl@iis.fraunhofer.de>
In-Reply-To: <1283165728-2231-2-git-send-email-manuel.stahl@iis.fraunhofer.de>
References: <1283165728-2231-2-git-send-email-manuel.stahl@iis.fraunhofer.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
---
 drivers/staging/iio/magnetometer/hmc5843.c |   32 ++++++++++++++--------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index 92f6c6f..66aab5a 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -95,15 +95,15 @@
 #define	CONF_NOT_USED				0x03
 #define	MEAS_CONF_MASK				0x03
 
-static const int regval_to_counts_per_mg[] = {
-	1620,
-	1300,
-	970,
-	780,
-	530,
-	460,
-	390,
-	280
+static const char *regval_to_scale[] = {
+	"0.0000006173",
+	"0.0000007692",
+	"0.0000010309",
+	"0.0000012821",
+	"0.0000018868",
+	"0.0000021739",
+	"0.0000025641",
+	"0.0000035714",
 };
 static const int regval_to_input_field_mg[] = {
 	700,
@@ -322,7 +322,7 @@ static IIO_DEVICE_ATTR(meas_conf,
  * 6		| 50
  * 7		| Not used
  */
-static IIO_CONST_ATTR_AVAIL_SAMP_FREQ("0.5 1 2 5 10 20 50");
+static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("0.5 1 2 5 10 20 50");
 
 static s32 hmc5843_set_rate(struct i2c_client *client,
 				u8 rate)
@@ -459,17 +459,17 @@ static IIO_DEVICE_ATTR(magn_range,
 			set_range,
 			HMC5843_CONFIG_REG_B);
 
-static ssize_t show_gain(struct device *dev,
+static ssize_t show_scale(struct device *dev,
 			struct device_attribute *attr,
 			char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct hmc5843_data *data = indio_dev->dev_data;
-	return sprintf(buf, "%d\n", regval_to_counts_per_mg[data->range]);
+	return strlen(strcpy(buf, regval_to_scale[data->range]));
 }
-static IIO_DEVICE_ATTR(magn_gain,
+static IIO_DEVICE_ATTR(magn_scale,
 			S_IRUGO,
-			show_gain,
+			show_scale,
 			NULL , 0);
 
 static struct attribute *hmc5843_attributes[] = {
@@ -477,11 +477,11 @@ static struct attribute *hmc5843_attributes[] = {
 	&iio_dev_attr_operating_mode.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_dev_attr_magn_range.dev_attr.attr,
-	&iio_dev_attr_magn_gain.dev_attr.attr,
+	&iio_dev_attr_magn_scale.dev_attr.attr,
 	&iio_dev_attr_magn_x_raw.dev_attr.attr,
 	&iio_dev_attr_magn_y_raw.dev_attr.attr,
 	&iio_dev_attr_magn_z_raw.dev_attr.attr,
-	&iio_const_attr_available_sampling_frequency.dev_attr.attr,
+	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	NULL
 };
 
-- 
1.7.0.6

