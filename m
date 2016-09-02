Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35311 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752478AbcIBN2a (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Sep 2016 09:28:30 -0400
Received: by mail-wm0-f50.google.com with SMTP id w2so29943973wmd.0
        for <linux-iio@vger.kernel.org>; Fri, 02 Sep 2016 06:28:29 -0700 (PDT)
From: Crt Mori <cmo@melexis.com>
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
        Markus Pargmann <mpa@pengutronix.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH] iio: fetch and enable regulators unconditionally
Date: Fri,  2 Sep 2016 15:27:17 +0200
Message-Id: <20160902132717.5839-1-cmo@melexis.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch is inspired by a comment of Jonathan Cameron on patch of
Linus Walleij commit aeb55fff3891834e07a3144159a7298a19696af8 ("iio: st_sensors: fetch and enable regulators unconditionally").

The explanation for this change is same as in that patch:
"Supplies are *not* optional (optional means that the supply is
optional in the electrical sense, not the software sense) so we need to
get the and enable them at all times.

If the device tree or board file does not define suitable regulators for
the component, it will be substituted by a dummy regulator, or, if
regulators are disabled altogether, by stubs. There is no need to use the
IS_ERR_OR_NULL() check that is considered harmful.

Reported-by: Linus Wallerij <linus.walleij@linaro.org>
Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Crt Mori <cmo@melexis.com>
---
 drivers/iio/adc/ad7266.c           | 8 +++-----
 drivers/iio/adc/fsl-imx25-gcq.c    | 6 +++---
 drivers/iio/adc/ti-ads8688.c       | 9 +++------
 drivers/iio/dac/ad5761.c           | 9 +++------
 drivers/iio/pressure/ms5611_core.c | 6 ++----
 5 files changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index c0f6a98..196b29a 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -395,7 +395,7 @@ static int ad7266_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 
-	st->reg = devm_regulator_get_optional(&spi->dev, "vref");
+	st->reg = devm_regulator_get(&spi->dev, "vref");
 	if (!IS_ERR(st->reg)) {
 		ret = regulator_enable(st->reg);
 		if (ret)
@@ -481,8 +481,7 @@ error_free_gpios:
 	if (!st->fixed_addr)
 		gpio_free_array(st->gpios, ARRAY_SIZE(st->gpios));
 error_disable_reg:
-	if (!IS_ERR_OR_NULL(st->reg))
-		regulator_disable(st->reg);
+	regulator_disable(st->reg);
 
 	return ret;
 }
@@ -496,8 +495,7 @@ static int ad7266_remove(struct spi_device *spi)
 	iio_triggered_buffer_cleanup(indio_dev);
 	if (!st->fixed_addr)
 		gpio_free_array(st->gpios, ARRAY_SIZE(st->gpios));
-	if (!IS_ERR_OR_NULL(st->reg))
-		regulator_disable(st->reg);
+	regulator_disable(st->reg);
 
 	return 0;
 }
diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
index 72b32c1..8aaf026 100644
--- a/drivers/iio/adc/fsl-imx25-gcq.c
+++ b/drivers/iio/adc/fsl-imx25-gcq.c
@@ -195,11 +195,11 @@ static int mx25_gcq_setup_cfgs(struct platform_device *pdev,
 	 */
 	priv->vref[MX25_ADC_REFP_INT] = NULL;
 	priv->vref[MX25_ADC_REFP_EXT] =
-		devm_regulator_get_optional(&pdev->dev, "vref-ext");
+		devm_regulator_get(&pdev->dev, "vref-ext");
 	priv->vref[MX25_ADC_REFP_XP] =
-		devm_regulator_get_optional(&pdev->dev, "vref-xp");
+		devm_regulator_get(&pdev->dev, "vref-xp");
 	priv->vref[MX25_ADC_REFP_YP] =
-		devm_regulator_get_optional(&pdev->dev, "vref-yp");
+		devm_regulator_get(&pdev->dev, "vref-yp");
 
 	for_each_child_of_node(np, child) {
 		u32 reg;
diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
index c400439..39bc9e4 100644
--- a/drivers/iio/adc/ti-ads8688.c
+++ b/drivers/iio/adc/ti-ads8688.c
@@ -395,7 +395,7 @@ static int ads8688_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 
-	st->reg = devm_regulator_get_optional(&spi->dev, "vref");
+	st->reg = devm_regulator_get(&spi->dev, "vref");
 	if (!IS_ERR(st->reg)) {
 		ret = regulator_enable(st->reg);
 		if (ret)
@@ -438,9 +438,7 @@ static int ads8688_probe(struct spi_device *spi)
 	return 0;
 
 error_out:
-	if (!IS_ERR_OR_NULL(st->reg))
-		regulator_disable(st->reg);
-
+	regulator_disable(st->reg);
 	return ret;
 }
 
@@ -451,8 +449,7 @@ static int ads8688_remove(struct spi_device *spi)
 
 	iio_device_unregister(indio_dev);
 
-	if (!IS_ERR_OR_NULL(st->reg))
-		regulator_disable(st->reg);
+	regulator_disable(st->reg);
 
 	return 0;
 }
diff --git a/drivers/iio/dac/ad5761.c b/drivers/iio/dac/ad5761.c
index d6510d6..70d88c4 100644
--- a/drivers/iio/dac/ad5761.c
+++ b/drivers/iio/dac/ad5761.c
@@ -292,7 +292,7 @@ static int ad5761_get_vref(struct ad5761_state *st,
 {
 	int ret;
 
-	st->vref_reg = devm_regulator_get_optional(&st->spi->dev, "vref");
+	st->vref_reg = devm_regulator_get(&st->spi->dev, "vref");
 	if (PTR_ERR(st->vref_reg) == -ENODEV) {
 		/* Use Internal regulator */
 		if (!chip_info->int_vref) {
@@ -387,9 +387,7 @@ static int ad5761_probe(struct spi_device *spi)
 	return 0;
 
 disable_regulator_err:
-	if (!IS_ERR_OR_NULL(st->vref_reg))
-		regulator_disable(st->vref_reg);
-
+	regulator_disable(st->vref_reg);
 	return ret;
 }
 
@@ -400,8 +398,7 @@ static int ad5761_remove(struct spi_device *spi)
 
 	iio_device_unregister(iio_dev);
 
-	if (!IS_ERR_OR_NULL(st->vref_reg))
-		regulator_disable(st->vref_reg);
+	regulator_disable(st->vref_reg);
 
 	return 0;
 }
diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
index feb41f8..a74ed1f 100644
--- a/drivers/iio/pressure/ms5611_core.c
+++ b/drivers/iio/pressure/ms5611_core.c
@@ -416,8 +416,7 @@ static int ms5611_init(struct iio_dev *indio_dev)
 	return 0;
 
 err_regulator_disable:
-	if (!IS_ERR_OR_NULL(st->vdd))
-		regulator_disable(st->vdd);
+	regulator_disable(st->vdd);
 	return ret;
 }
 
@@ -425,8 +424,7 @@ static void ms5611_fini(const struct iio_dev *indio_dev)
 {
 	const struct ms5611_state *st = iio_priv(indio_dev);
 
-	if (!IS_ERR_OR_NULL(st->vdd))
-		regulator_disable(st->vdd);
+	regulator_disable(st->vdd);
 }
 
 int ms5611_probe(struct iio_dev *indio_dev, struct device *dev,
-- 
2.9.3

