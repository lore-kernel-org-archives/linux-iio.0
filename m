Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-236.synserver.de ([212.40.185.236]:1387 "EHLO
	smtp-out-236.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932546Ab3GPPLH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Jul 2013 11:11:07 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/4] staging:iio:ade7xxx: Don't expose the chip reset to userspace
Date: Tue, 16 Jul 2013 17:08:02 +0200
Message-Id: <1373987283-32657-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1373987283-32657-1-git-send-email-lars@metafoo.de>
References: <1373987283-32657-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

There is no reason why userspace should want to trigger a manual reset of the
device, so remove this functionality.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/meter/ade7753.c      | 18 ------------------
 drivers/staging/iio/meter/ade7754.c      | 19 -------------------
 drivers/staging/iio/meter/ade7758_core.c | 18 ------------------
 drivers/staging/iio/meter/ade7759.c      | 18 ------------------
 drivers/staging/iio/meter/ade7854.c      | 19 -------------------
 5 files changed, 92 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
index e5943e2..74025fb 100644
--- a/drivers/staging/iio/meter/ade7753.c
+++ b/drivers/staging/iio/meter/ade7753.c
@@ -225,21 +225,6 @@ static int ade7753_reset(struct device *dev)
 	return ade7753_spi_write_reg_16(dev, ADE7753_MODE, val);
 }
 
-static ssize_t ade7753_write_reset(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf, size_t len)
-{
-	if (len < 1)
-		return -1;
-	switch (buf[0]) {
-	case '1':
-	case 'y':
-	case 'Y':
-		return ade7753_reset(dev);
-	}
-	return -1;
-}
-
 static IIO_DEV_ATTR_AENERGY(ade7753_read_24bit, ADE7753_AENERGY);
 static IIO_DEV_ATTR_LAENERGY(ade7753_read_24bit, ADE7753_LAENERGY);
 static IIO_DEV_ATTR_VAENERGY(ade7753_read_24bit, ADE7753_VAENERGY);
@@ -458,8 +443,6 @@ static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
 		ade7753_read_frequency,
 		ade7753_write_frequency);
 
-static IIO_DEV_ATTR_RESET(ade7753_write_reset);
-
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("27900 14000 7000 3500");
 
 static struct attribute *ade7753_attributes[] = {
@@ -468,7 +451,6 @@ static struct attribute *ade7753_attributes[] = {
 	&iio_const_attr_in_temp_scale.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
-	&iio_dev_attr_reset.dev_attr.attr,
 	&iio_dev_attr_phcal.dev_attr.attr,
 	&iio_dev_attr_cfden.dev_attr.attr,
 	&iio_dev_attr_aenergy.dev_attr.attr,
diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
index 7b6503b..f649ebe 100644
--- a/drivers/staging/iio/meter/ade7754.c
+++ b/drivers/staging/iio/meter/ade7754.c
@@ -224,22 +224,6 @@ static int ade7754_reset(struct device *dev)
 	return ade7754_spi_write_reg_8(dev, ADE7754_OPMODE, val);
 }
 
-
-static ssize_t ade7754_write_reset(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf, size_t len)
-{
-	if (len < 1)
-		return -1;
-	switch (buf[0]) {
-	case '1':
-	case 'y':
-	case 'Y':
-		return ade7754_reset(dev);
-	}
-	return -1;
-}
-
 static IIO_DEV_ATTR_AENERGY(ade7754_read_24bit, ADE7754_AENERGY);
 static IIO_DEV_ATTR_LAENERGY(ade7754_read_24bit, ADE7754_LAENERGY);
 static IIO_DEV_ATTR_VAENERGY(ade7754_read_24bit, ADE7754_VAENERGY);
@@ -478,8 +462,6 @@ static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
 		ade7754_read_frequency,
 		ade7754_write_frequency);
 
-static IIO_DEV_ATTR_RESET(ade7754_write_reset);
-
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("26000 13000 65000 33000");
 
 static struct attribute *ade7754_attributes[] = {
@@ -488,7 +470,6 @@ static struct attribute *ade7754_attributes[] = {
 	&iio_const_attr_in_temp_scale.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
-	&iio_dev_attr_reset.dev_attr.attr,
 	&iio_dev_attr_aenergy.dev_attr.attr,
 	&iio_dev_attr_laenergy.dev_attr.attr,
 	&iio_dev_attr_vaenergy.dev_attr.attr,
diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index 8f5bcfa..6005d4a 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -313,21 +313,6 @@ static int ade7758_reset(struct device *dev)
 	return ret;
 }
 
-static ssize_t ade7758_write_reset(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf, size_t len)
-{
-	if (len < 1)
-		return -1;
-	switch (buf[0]) {
-	case '1':
-	case 'y':
-	case 'Y':
-		return ade7758_reset(dev);
-	}
-	return len;
-}
-
 static IIO_DEV_ATTR_VPEAK(S_IWUSR | S_IRUGO,
 		ade7758_read_8bit,
 		ade7758_write_8bit,
@@ -591,8 +576,6 @@ static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
 		ade7758_read_frequency,
 		ade7758_write_frequency);
 
-static IIO_DEV_ATTR_RESET(ade7758_write_reset);
-
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("26040 13020 6510 3255");
 
 static struct attribute *ade7758_attributes[] = {
@@ -601,7 +584,6 @@ static struct attribute *ade7758_attributes[] = {
 	&iio_const_attr_in_temp_scale.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
-	&iio_dev_attr_reset.dev_attr.attr,
 	&iio_dev_attr_awatthr.dev_attr.attr,
 	&iio_dev_attr_bwatthr.dev_attr.attr,
 	&iio_dev_attr_cwatthr.dev_attr.attr,
diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
index 17dc373..d214ac4 100644
--- a/drivers/staging/iio/meter/ade7759.c
+++ b/drivers/staging/iio/meter/ade7759.c
@@ -229,21 +229,6 @@ static int ade7759_reset(struct device *dev)
 	return ret;
 }
 
-static ssize_t ade7759_write_reset(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf, size_t len)
-{
-	if (len < 1)
-		return -1;
-	switch (buf[0]) {
-	case '1':
-	case 'y':
-	case 'Y':
-		return ade7759_reset(dev);
-	}
-	return -1;
-}
-
 static IIO_DEV_ATTR_AENERGY(ade7759_read_40bit, ADE7759_AENERGY);
 static IIO_DEV_ATTR_CFDEN(S_IWUSR | S_IRUGO,
 		ade7759_read_16bit,
@@ -418,8 +403,6 @@ static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
 		ade7759_read_frequency,
 		ade7759_write_frequency);
 
-static IIO_DEV_ATTR_RESET(ade7759_write_reset);
-
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("27900 14000 7000 3500");
 
 static struct attribute *ade7759_attributes[] = {
@@ -428,7 +411,6 @@ static struct attribute *ade7759_attributes[] = {
 	&iio_const_attr_in_temp_scale.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
-	&iio_dev_attr_reset.dev_attr.attr,
 	&iio_dev_attr_phcal.dev_attr.attr,
 	&iio_dev_attr_cfden.dev_attr.attr,
 	&iio_dev_attr_aenergy.dev_attr.attr,
diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
index c642da8..e8379c0 100644
--- a/drivers/staging/iio/meter/ade7854.c
+++ b/drivers/staging/iio/meter/ade7854.c
@@ -186,22 +186,6 @@ static int ade7854_reset(struct device *dev)
 	return st->write_reg_16(dev, ADE7854_CONFIG, val);
 }
 
-
-static ssize_t ade7854_write_reset(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf, size_t len)
-{
-	if (len < 1)
-		return -1;
-	switch (buf[0]) {
-	case '1':
-	case 'y':
-	case 'Y':
-		return ade7854_reset(dev);
-	}
-	return -1;
-}
-
 static IIO_DEV_ATTR_AIGAIN(S_IWUSR | S_IRUGO,
 		ade7854_read_24bit,
 		ade7854_write_24bit,
@@ -468,8 +452,6 @@ err_ret:
 	return ret;
 }
 
-static IIO_DEV_ATTR_RESET(ade7854_write_reset);
-
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("8000");
 
 static IIO_CONST_ATTR(name, "ade7854");
@@ -515,7 +497,6 @@ static struct attribute *ade7854_attributes[] = {
 	&iio_dev_attr_bvahr.dev_attr.attr,
 	&iio_dev_attr_cvahr.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
-	&iio_dev_attr_reset.dev_attr.attr,
 	&iio_const_attr_name.dev_attr.attr,
 	&iio_dev_attr_vpeak.dev_attr.attr,
 	&iio_dev_attr_ipeak.dev_attr.attr,
-- 
1.8.0

