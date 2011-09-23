Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: Michael.Hennerich@analog.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 05/16] staging:iio:adc:ad799x use a table for frequency values rather than big switch.
Date: Fri, 23 Sep 2011 13:01:31 +0100
Message-Id: <1316779302-12357-6-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
References: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad799x_core.c |   74 ++++++++-------------------------
 1 files changed, 17 insertions(+), 57 deletions(-)

diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index 517cbd9..c615188 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -170,7 +170,15 @@ static int ad799x_read_raw(struct iio_dev *dev_info,
 	}
 	return -EINVAL;
 }
-
+static const unsigned int ad7998_frequencies[] = {
+	[AD7998_CYC_DIS]	= 0,
+	[AD7998_CYC_TCONF_32]	= 15625,
+	[AD7998_CYC_TCONF_64]	= 7812,
+	[AD7998_CYC_TCONF_128]	= 3906,
+	[AD7998_CYC_TCONF_512]	= 976,
+	[AD7998_CYC_TCONF_1024]	= 488,
+	[AD7998_CYC_TCONF_2048]	= 244,
+};
 static ssize_t ad799x_read_frequency(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
@@ -178,7 +186,7 @@ static ssize_t ad799x_read_frequency(struct device *dev,
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
 	struct ad799x_state *st = iio_priv(dev_info);
 
-	int ret, len = 0;
+	int ret;
 	u8 val;
 	ret = ad799x_i2c_read8(st, AD7998_CYCLE_TMR_REG, &val);
 	if (ret)
@@ -186,33 +194,7 @@ static ssize_t ad799x_read_frequency(struct device *dev,
 
 	val &= AD7998_CYC_MASK;
 
-	switch (val) {
-	case AD7998_CYC_DIS:
-		len = sprintf(buf, "0\n");
-		break;
-	case AD7998_CYC_TCONF_32:
-		len = sprintf(buf, "15625\n");
-		break;
-	case AD7998_CYC_TCONF_64:
-		len = sprintf(buf, "7812\n");
-		break;
-	case AD7998_CYC_TCONF_128:
-		len = sprintf(buf, "3906\n");
-		break;
-	case AD7998_CYC_TCONF_256:
-		len = sprintf(buf, "1953\n");
-		break;
-	case AD7998_CYC_TCONF_512:
-		len = sprintf(buf, "976\n");
-		break;
-	case AD7998_CYC_TCONF_1024:
-		len = sprintf(buf, "488\n");
-		break;
-	case AD7998_CYC_TCONF_2048:
-		len = sprintf(buf, "244\n");
-		break;
-	}
-	return len;
+	return sprintf(buf, "%u\n", ad7998_frequencies[val]);
 }
 
 static ssize_t ad799x_write_frequency(struct device *dev,
@@ -224,7 +206,7 @@ static ssize_t ad799x_write_frequency(struct device *dev,
 	struct ad799x_state *st = iio_priv(dev_info);
 
 	long val;
-	int ret;
+	int ret, i;
 	u8 t;
 
 	ret = strict_strtol(buf, 10, &val);
@@ -238,36 +220,14 @@ static ssize_t ad799x_write_frequency(struct device *dev,
 	/* Wipe the bits clean */
 	t &= ~AD7998_CYC_MASK;
 
-	switch (val) {
-	case 15625:
-		t |= AD7998_CYC_TCONF_32;
-		break;
-	case 7812:
-		t |= AD7998_CYC_TCONF_64;
-		break;
-	case 3906:
-		t |= AD7998_CYC_TCONF_128;
-		break;
-	case 1953:
-		t |= AD7998_CYC_TCONF_256;
-		break;
-	case 976:
-		t |= AD7998_CYC_TCONF_512;
-		break;
-	case 488:
-		t |= AD7998_CYC_TCONF_1024;
-		break;
-	case 244:
-		t |= AD7998_CYC_TCONF_2048;
-		break;
-	case  0:
-		t |= AD7998_CYC_DIS;
-		break;
-	default:
+	for (i = 0; i < ARRAY_SIZE(ad7998_frequencies); i++)
+		if (val == ad7998_frequencies[i])
+			break;
+	if (i == ARRAY_SIZE(ad7998_frequencies)) {
 		ret = -EINVAL;
 		goto error_ret_mutex;
 	}
-
+	t |= i;
 	ret = ad799x_i2c_write8(st, AD7998_CYCLE_TMR_REG, t);
 
 error_ret_mutex:
-- 
1.7.3.4
