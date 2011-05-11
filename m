Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>, <drivers@analog.com>,
	<device-drivers-devel@blackfin.uclinux.org>, Michael Hennerich
	<michael.hennerich@analog.com>
Subject: [PATCH 4/6] IIO-work: meter: ade7758: Fix list and set of available sample frequencies.
Date: Wed, 11 May 2011 16:26:58 +0200
Message-ID: <1305124020-2526-4-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1305124020-2526-1-git-send-email-michael.hennerich@analog.com>
References: <1305124020-2526-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Fix list of available sample frequencies.
Fix ade7758_write_frequency().

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/meter/ade7758_core.c |   28 ++++++++++++++++++----------
 1 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index 971b247..b2d7345 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -533,7 +533,6 @@ static ssize_t ade7758_write_frequency(struct device *dev,
 		size_t len)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7758_state *st = iio_dev_get_devdata(indio_dev);
 	unsigned long val;
 	int ret;
 	u8 reg, t;
@@ -544,14 +543,23 @@ static ssize_t ade7758_write_frequency(struct device *dev,
 
 	mutex_lock(&indio_dev->mlock);
 
-	t = (26040 / val);
-	if (t > 0)
-		t >>= 1;
-
-	if (t > 1)
-		st->us->max_speed_hz = ADE7758_SPI_SLOW;
-	else
-		st->us->max_speed_hz = ADE7758_SPI_FAST;
+	switch (val) {
+	case 26040:
+		t = 0;
+		break;
+	case 13020:
+		t = 1;
+		break;
+	case 6510:
+		t = 2;
+		break;
+	case 3255:
+		t = 3;
+		break;
+	default:
+		ret = -EINVAL;
+	 	goto out;
+	}
 
 	ret = ade7758_spi_read_reg_8(dev,
 			ADE7758_WAVMODE,
@@ -671,7 +679,7 @@ static IIO_DEV_ATTR_WAVEFORM_TYPE(S_IWUSR | S_IRUGO,
 
 static IIO_DEV_ATTR_RESET(ade7758_write_reset);
 
-static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("26000 13000 65000 33000");
+static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("26040 13020 6510 3255");
 
 static struct attribute *ade7758_attributes[] = {
 	&iio_dev_attr_temp_raw.dev_attr.attr,
-- 
1.6.0.2
