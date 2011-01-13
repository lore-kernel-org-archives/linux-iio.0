Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.work-microwave.de ([62.245.205.51]:39292 "EHLO
	work-microwave.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756571Ab1AMRl3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 13 Jan 2011 12:41:29 -0500
From: Roland Stigge <rst@work-microwave.de>
To: greg@kroah.com, linux-iio@vger.kernel.org
Cc: Roland Stigge <stigge@antcom.de>
Subject: [PATCH] iio: Fixpoint formatted output bugfix
Date: Thu, 13 Jan 2011 18:37:36 +0100
Message-Id: <1294940256-21253-1-git-send-email-rst@work-microwave.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix some ADC drivers' _scale interface to correct fixpoint formatted output

Signed-off-by: Roland Stigge <stigge@antcom.de>
Acked-by: "Jonathan Cameron <jic23@cam.ac.uk>"

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
