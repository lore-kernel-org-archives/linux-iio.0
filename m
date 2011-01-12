Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.work-microwave.de ([62.245.205.51]:34836 "EHLO
	work-microwave.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751165Ab1ALSrN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Jan 2011 13:47:13 -0500
From: Roland Stigge <rst@work-microwave.de>
To: linux-iio@vger.kernel.org
Cc: Roland Stigge <rst@work-microwave.de>
Subject: [PATCH] iio: Fixpoint formatted output bugfix
Date: Wed, 12 Jan 2011 19:35:59 +0100
Message-Id: <1294857359-18723-1-git-send-email-rst@work-microwave.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix some ADC drivers' _scale interface to correct fixpoint formatted output
---
 drivers/staging/iio/adc/ad7476_core.c |    2 +-
 drivers/staging/iio/adc/ad7887_core.c |    2 +-
 drivers/staging/iio/adc/ad799x_core.c |    2 +-
 drivers/staging/iio/dac/ad5446.c      |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/adc/ad7476_core.c
index deb68c8..b8b54da 100644
--- a/drivers/staging/iio/adc/ad7476_core.c
+++ b/drivers/staging/iio/adc/ad7476_core.c
@@ -68,7 +68,7 @@ static ssize_t ad7476_show_scale(struct device *dev,
 	/* Corresponds to Vref / 2^(bits) */
 	unsigned int scale_uv = (st->int_vref_mv * 1000) >> st->chip_info->bits;
 
-	return sprintf(buf, "%d.%d\n", scale_uv / 1000, scale_uv % 1000);
+	return sprintf(buf, "%d.%03d\n", scale_uv / 1000, scale_uv % 1000);
 }
 static IIO_DEVICE_ATTR(in_scale, S_IRUGO, ad7476_show_scale, NULL, 0);
 
diff --git a/drivers/staging/iio/adc/ad7887_core.c b/drivers/staging/iio/adc/ad7887_core.c
index 6859089..5d85efa 100644
--- a/drivers/staging/iio/adc/ad7887_core.c
+++ b/drivers/staging/iio/adc/ad7887_core.c
@@ -68,7 +68,7 @@ static ssize_t ad7887_show_scale(struct device *dev,
 	/* Corresponds to Vref / 2^(bits) */
 	unsigned int scale_uv = (st->int_vref_mv * 1000) >> st->chip_info->bits;
 
-	return sprintf(buf, "%d.%d\n", scale_uv / 1000, scale_uv % 1000);
+	return sprintf(buf, "%d.%03d\n", scale_uv / 1000, scale_uv % 1000);
 }
 static IIO_DEVICE_ATTR(in_scale, S_IRUGO, ad7887_show_scale, NULL, 0);
 
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index 6309d52..89ccf37 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -432,7 +432,7 @@ static ssize_t ad799x_show_scale(struct device *dev,
 	/* Corresponds to Vref / 2^(bits) */
 	unsigned int scale_uv = (st->int_vref_mv * 1000) >> st->chip_info->bits;
 
-	return sprintf(buf, "%d.%d\n", scale_uv / 1000, scale_uv % 1000);
+	return sprintf(buf, "%d.%03d\n", scale_uv / 1000, scale_uv % 1000);
 }
 
 static IIO_DEVICE_ATTR(in_scale, S_IRUGO, ad799x_show_scale, NULL, 0);
diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
index e3387cd..0f87eca 100644
--- a/drivers/staging/iio/dac/ad5446.c
+++ b/drivers/staging/iio/dac/ad5446.c
@@ -87,7 +87,7 @@ static ssize_t ad5446_show_scale(struct device *dev,
 	/* Corresponds to Vref / 2^(bits) */
 	unsigned int scale_uv = (st->vref_mv * 1000) >> st->chip_info->bits;
 
-	return sprintf(buf, "%d.%d\n", scale_uv / 1000, scale_uv % 1000);
+	return sprintf(buf, "%d.%03d\n", scale_uv / 1000, scale_uv % 1000);
 }
 static IIO_DEVICE_ATTR(out_scale, S_IRUGO, ad5446_show_scale, NULL, 0);
 
-- 
1.7.2.3

