Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] iio:ad5064: Initialize register cache correctly
Date: Fri,  1 Mar 2013 14:07:19 +0100
Message-Id: <1362143239-891-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1362143239-891-1-git-send-email-lars@metafoo.de>
References: <1362143239-891-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Initialize the register cache to the proper mid-scale value based on the
resolution of the device.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/dac/ad5064.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
index a491976..0c8d03a 100644
--- a/drivers/iio/dac/ad5064.c
+++ b/drivers/iio/dac/ad5064.c
@@ -438,6 +438,7 @@ static int __devinit ad5064_probe(struct device *dev, enum ad5064_type type,
 {
 	struct iio_dev *indio_dev;
 	struct ad5064_state *st;
+	unsigned int midscale;
 	unsigned int i;
 	int ret;
 
@@ -474,11 +475,6 @@ static int __devinit ad5064_probe(struct device *dev, enum ad5064_type type,
 			goto error_free_reg;
 	}
 
-	for (i = 0; i < st->chip_info->num_channels; ++i) {
-		st->pwr_down_mode[i] = AD5064_LDAC_PWRDN_1K;
-		st->dac_cache[i] = 0x8000;
-	}
-
 	indio_dev->dev.parent = dev;
 	indio_dev->name = name;
 	indio_dev->info = &ad5064_info;
@@ -486,6 +482,13 @@ static int __devinit ad5064_probe(struct device *dev, enum ad5064_type type,
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = st->chip_info->num_channels;
 
+	midscale = (1 << indio_dev->channels[0].scan_type.realbits) /  2;
+
+	for (i = 0; i < st->chip_info->num_channels; ++i) {
+		st->pwr_down_mode[i] = AD5064_LDAC_PWRDN_1K;
+		st->dac_cache[i] = midscale;
+	}
+
 	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_disable_reg;
-- 
1.8.0
