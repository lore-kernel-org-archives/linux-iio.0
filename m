Return-Path: <SRS0=Iqip=5O=linux.intel.com=andriy.shevchenko@kernel.org>
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-iio@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v1] iio: adc: ad7791: Use sysfs_match_string() helper
Date: Fri,  9 Jun 2017 15:08:10 +0300
Message-Id: <20170609120810.22057-1-andriy.shevchenko@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

Use sysfs_match_string() helper instead of open coded variant.

Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/adc/ad7791.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
index 1817ebf5ad84..34e353c43ac8 100644
--- a/drivers/iio/adc/ad7791.c
+++ b/drivers/iio/adc/ad7791.c
@@ -272,11 +272,9 @@ static ssize_t ad7791_write_frequency(struct device *dev,
 	struct ad7791_state *st = iio_priv(indio_dev);
 	int i, ret;
 
-	for (i = 0; i < ARRAY_SIZE(ad7791_sample_freq_avail); i++)
-		if (sysfs_streq(ad7791_sample_freq_avail[i], buf))
-			break;
-	if (i == ARRAY_SIZE(ad7791_sample_freq_avail))
-		return -EINVAL;
+	i = sysfs_match_string(ad7791_sample_freq_avail, buf);
+	if (i < 0)
+		return i;
 
 	ret = iio_device_claim_direct_mode(indio_dev);
 	if (ret)
-- 
2.11.0
