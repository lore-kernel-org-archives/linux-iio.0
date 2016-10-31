Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33427 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S944910AbcJaRIL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 31 Oct 2016 13:08:11 -0400
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        Eva Rachel Retuya <eraretuya@gmail.com>
Subject: [PATCH 3/6] staging: iio: ad7192: add DVdd regulator
Date: Tue,  1 Nov 2016 01:04:32 +0800
Message-Id: <1477933475-21914-4-git-send-email-eraretuya@gmail.com>
In-Reply-To: <1477933475-21914-1-git-send-email-eraretuya@gmail.com>
References: <1477933475-21914-1-git-send-email-eraretuya@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The AD7190/AD7192/AD7193/AD7195 is supplied with two power sources:
AVdd as analog supply voltage and DVdd as digital supply voltage.

Attempt to fetch and enable the regulator 'dvdd'. Bail out if any error
occurs.

Suggested-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
---
 drivers/staging/iio/adc/ad7192.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 29e32b7..3f8dc66 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -153,6 +153,7 @@
 
 struct ad7192_state {
 	struct regulator		*reg;
+	struct regulator		*dvdd;
 	u16				int_vref_mv;
 	u32				mclk;
 	u32				f_order;
@@ -642,6 +643,19 @@ static int ad7192_probe(struct spi_device *spi)
 		dev_err(&spi->dev, "Failed to enable specified AVdd supply\n");
 		return ret;
 	}
+
+	st->dvdd = devm_regulator_get(&spi->dev, "dvdd");
+	if (IS_ERR(st->dvdd)) {
+		ret = PTR_ERR(st->dvdd);
+		goto error_disable_reg;
+	}
+
+	ret = regulator_enable(st->dvdd);
+	if (ret) {
+		dev_err(&spi->dev, "Failed to enable specified DVdd supply\n");
+		goto error_disable_reg;
+	}
+
 	voltage_uv = regulator_get_voltage(st->reg);
 
 	if (pdata->vref_mv)
@@ -677,7 +691,7 @@ static int ad7192_probe(struct spi_device *spi)
 
 	ret = ad_sd_setup_buffer_and_trigger(indio_dev);
 	if (ret)
-		goto error_disable_reg;
+		goto error_disable_dvdd;
 
 	ret = ad7192_setup(st, pdata);
 	if (ret)
@@ -690,6 +704,8 @@ static int ad7192_probe(struct spi_device *spi)
 
 error_remove_trigger:
 	ad_sd_cleanup_buffer_and_trigger(indio_dev);
+error_disable_dvdd:
+	regulator_disable(st->dvdd);
 error_disable_reg:
 	regulator_disable(st->reg);
 
@@ -704,6 +720,7 @@ static int ad7192_remove(struct spi_device *spi)
 	iio_device_unregister(indio_dev);
 	ad_sd_cleanup_buffer_and_trigger(indio_dev);
 
+	regulator_disable(st->dvdd);
 	regulator_disable(st->reg);
 
 	return 0;
-- 
2.7.4

