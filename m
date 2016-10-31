Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36650 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S944699AbcJaRIP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 31 Oct 2016 13:08:15 -0400
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        Eva Rachel Retuya <eraretuya@gmail.com>
Subject: [PATCH 4/6] staging: iio: ad7192: rename regulator 'reg' to 'avdd'
Date: Tue,  1 Nov 2016 01:04:33 +0800
Message-Id: <1477933475-21914-5-git-send-email-eraretuya@gmail.com>
In-Reply-To: <1477933475-21914-1-git-send-email-eraretuya@gmail.com>
References: <1477933475-21914-1-git-send-email-eraretuya@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Rename regulator 'reg' to 'avdd' so as to be clear what regulator it
stands for specifically. Also, update the goto label accordingly.

Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
---
 drivers/staging/iio/adc/ad7192.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 3f8dc66..1fb68c0 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -152,7 +152,7 @@
  */
 
 struct ad7192_state {
-	struct regulator		*reg;
+	struct regulator		*avdd;
 	struct regulator		*dvdd;
 	u16				int_vref_mv;
 	u32				mclk;
@@ -634,11 +634,11 @@ static int ad7192_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 
-	st->reg = devm_regulator_get(&spi->dev, "avdd");
-	if (IS_ERR(st->reg))
-		return PTR_ERR(st->reg);
+	st->avdd = devm_regulator_get(&spi->dev, "avdd");
+	if (IS_ERR(st->avdd))
+		return PTR_ERR(st->avdd);
 
-	ret = regulator_enable(st->reg);
+	ret = regulator_enable(st->avdd);
 	if (ret) {
 		dev_err(&spi->dev, "Failed to enable specified AVdd supply\n");
 		return ret;
@@ -647,16 +647,16 @@ static int ad7192_probe(struct spi_device *spi)
 	st->dvdd = devm_regulator_get(&spi->dev, "dvdd");
 	if (IS_ERR(st->dvdd)) {
 		ret = PTR_ERR(st->dvdd);
-		goto error_disable_reg;
+		goto error_disable_avdd;
 	}
 
 	ret = regulator_enable(st->dvdd);
 	if (ret) {
 		dev_err(&spi->dev, "Failed to enable specified DVdd supply\n");
-		goto error_disable_reg;
+		goto error_disable_avdd;
 	}
 
-	voltage_uv = regulator_get_voltage(st->reg);
+	voltage_uv = regulator_get_voltage(st->avdd);
 
 	if (pdata->vref_mv)
 		st->int_vref_mv = pdata->vref_mv;
@@ -706,8 +706,8 @@ static int ad7192_probe(struct spi_device *spi)
 	ad_sd_cleanup_buffer_and_trigger(indio_dev);
 error_disable_dvdd:
 	regulator_disable(st->dvdd);
-error_disable_reg:
-	regulator_disable(st->reg);
+error_disable_avdd:
+	regulator_disable(st->avdd);
 
 	return ret;
 }
@@ -721,7 +721,7 @@ static int ad7192_remove(struct spi_device *spi)
 	ad_sd_cleanup_buffer_and_trigger(indio_dev);
 
 	regulator_disable(st->dvdd);
-	regulator_disable(st->reg);
+	regulator_disable(st->avdd);
 
 	return 0;
 }
-- 
2.7.4

