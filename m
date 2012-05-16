Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:56432 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751754Ab2EPQXr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 16 May 2012 12:23:47 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 7/9] iio: rename function/data to consistently start with hmc5843_
Date: Wed, 16 May 2012 18:22:09 +0200
Message-Id: <1337185331-26616-8-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1337185331-26616-1-git-send-email-pmeerw@pmeerw.net>
References: <1337185331-26616-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/magnetometer/hmc5843.c |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index 57ed182..2e1bc6c 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -115,7 +115,7 @@ static const int hmc5843_regval_to_nanoscale[] = {
  * 6		| (+-)4.5			| 390
  * 7		| (+-)6.5			| 280
  */
-static const int regval_to_input_field_mg[] = {
+static const int hmc5843_regval_to_input_field_mga[] = {
 	700,
 	1000,
 	1500,
@@ -138,7 +138,7 @@ static const int regval_to_input_field_mg[] = {
  * 6		| 50
  * 7		| Not used
  */
-static const char * const regval_to_samp_freq[] = {
+static const char * const hmc5843_regval_to_sample_freq[] = {
 	"0.5",
 	"1",
 	"2",
@@ -355,7 +355,7 @@ static s32 hmc5843_set_rate(struct i2c_client *client,
 static int hmc5843_check_sampling_frequency(struct hmc5843_data *data,
 						const char *buf)
 {
-	const char * const *samp_freq = regval_to_samp_freq;
+	const char * const *samp_freq = hmc5843_regval_to_sample_freq;
 	int i;
 
 	for (i = 0; i < HMC5843_RATE_NOT_USED; i++) {
@@ -367,7 +367,7 @@ static int hmc5843_check_sampling_frequency(struct hmc5843_data *data,
 	return -EINVAL;
 }
 
-static ssize_t set_sampling_frequency(struct device *dev,
+static ssize_t hmc5843_set_sampling_frequency(struct device *dev,
 					struct device_attribute *attr,
 					const char *buf, size_t count)
 {
@@ -397,7 +397,7 @@ exit:
 	return count;
 }
 
-static ssize_t show_sampling_frequency(struct device *dev,
+static ssize_t hmc5843_show_sampling_frequency(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
@@ -409,16 +409,16 @@ static ssize_t show_sampling_frequency(struct device *dev,
 	if (rate < 0)
 		return rate;
 	rate = (rate & HMC5843_RATE_BITMASK) >> HMC5843_RATE_OFFSET;
-	return sprintf(buf, "%s\n", regval_to_samp_freq[rate]);
+	return sprintf(buf, "%s\n", hmc5843_regval_to_sample_freq[rate]);
 }
 
 static IIO_DEVICE_ATTR(sampling_frequency,
 			S_IWUSR | S_IRUGO,
-			show_sampling_frequency,
-			set_sampling_frequency,
+			hmc5843_show_sampling_frequency,
+			hmc5843_set_sampling_frequency,
 			HMC5843_CONFIG_REG_A);
 
-static ssize_t show_range(struct device *dev,
+static ssize_t hmc5843_show_range_gain(struct device *dev,
 				struct device_attribute *attr,
 				char *buf)
 {
@@ -427,10 +427,10 @@ static ssize_t show_range(struct device *dev,
 	struct hmc5843_data *data = iio_priv(indio_dev);
 
 	range = data->range;
-	return sprintf(buf, "%d\n", regval_to_input_field_mg[range]);
+	return sprintf(buf, "%d\n", hmc5843_regval_to_input_field_mga[range]);
 }
 
-static ssize_t set_range(struct device *dev,
+static ssize_t hmc5843_set_range_gain(struct device *dev,
 			struct device_attribute *attr,
 			const char *buf,
 			size_t count)
@@ -467,8 +467,8 @@ exit:
 
 static IIO_DEVICE_ATTR(in_magn_range,
 			S_IWUSR | S_IRUGO,
-			show_range,
-			set_range,
+			hmc5843_show_range_gain,
+			hmc5843_set_range_gain,
 			HMC5843_CONFIG_REG_B);
 
 static int hmc5843_read_raw(struct iio_dev *indio_dev,
-- 
1.7.5.4

