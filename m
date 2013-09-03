Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:33383 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759207Ab3ICBFd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 2 Sep 2013 21:05:33 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 08/18] staging:iio:hmc5843: Introduce helper functions to show/check list of int pairs
Date: Tue,  3 Sep 2013 03:05:10 +0200
Message-Id: <1378170320-27538-9-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1378170320-27538-1-git-send-email-pmeerw@pmeerw.net>
References: <1378170320-27538-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/magnetometer/hmc5843.c |   53 +++++++++++++++++-----------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index 63a8956..bff03d5 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -356,24 +356,43 @@ static IIO_DEVICE_ATTR(meas_conf,
 			hmc5843_set_measurement_configuration,
 			0);
 
-static ssize_t hmc5843_show_samp_freq_avail(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t hmc5843_show_int_plus_micros(char *buf,
+	const int (*vals)[2], int n)
 {
-	struct hmc5843_data *data = iio_priv(dev_to_iio_dev(dev));
-	ssize_t total_n = 0;
+	ssize_t total_out = 0;
 	int i;
 
-	for (i = 0; i < HMC5843_RATE_NOT_USED; i++) {
-		ssize_t n = sprintf(buf, "%d.%d ",
-			data->variant->regval_to_samp_freq[i][0],
-			data->variant->regval_to_samp_freq[i][1]);
-		buf += n;
-		total_n += n;
+	for (i = 0; i < n; i++) {
+		ssize_t out = sprintf(buf, "%d.%d ", vals[i][0], vals[i][1]);
+		buf += out;
+		total_out += out;
 	}
 	/* replace trailing space by newline */
 	buf[-1] = '\n';
 
-	return total_n;
+	return total_out;
+}
+
+static int hmc5843_check_int_plus_micros(const int (*vals)[2], int n,
+					int val, int val2)
+{
+	int i;
+
+	for (i = 0; i < n; i++) {
+		if (val == vals[i][0] && val2 == vals[i][1])
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+static ssize_t hmc5843_show_samp_freq_avail(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct hmc5843_data *data = iio_priv(dev_to_iio_dev(dev));
+
+	return hmc5843_show_int_plus_micros(buf,
+		data->variant->regval_to_samp_freq, HMC5843_RATE_NOT_USED);
 }
 
 static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(hmc5843_show_samp_freq_avail);
@@ -389,15 +408,9 @@ static s32 hmc5843_set_rate(struct hmc5843_data *data, u8 rate)
 static int hmc5843_check_samp_freq(struct hmc5843_data *data,
 	int val, int val2)
 {
-	int i;
-
-	for (i = 0; i < HMC5843_RATE_NOT_USED; i++) {
-		if (val == data->variant->regval_to_samp_freq[i][0] &&
-			val2 == data->variant->regval_to_samp_freq[i][1])
-			return i;
-	}
-
-	return -EINVAL;
+	return hmc5843_check_int_plus_micros(
+		data->variant->regval_to_samp_freq, HMC5843_RATE_NOT_USED,
+		val, val2);
 }
 
 static ssize_t hmc5843_show_range_gain(struct device *dev,
-- 
1.7.9.5

