Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:53152 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752996AbcFTMz1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jun 2016 08:55:27 -0400
From: Mark Brown <broonie@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, Mark Brown <broonie@kernel.org>
Date: Mon, 20 Jun 2016 13:53:33 +0100
Message-Id: <1466427214-13372-2-git-send-email-broonie@kernel.org>
In-Reply-To: <1466427214-13372-1-git-send-email-broonie@kernel.org>
References: <1466427214-13372-1-git-send-email-broonie@kernel.org>
Subject: [PATCH 2/3] iio:ad7266: Fix support for optional regulators
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The ad7266 driver attempts to support deciding between the use of internal
and external power supplies by checking to see if an error is returned when
requesting the regulator. This doesn't work with the current code since the
driver uses a normal regulator_get() which is for non-optional supplies
and so assumes that if a regulator is not provided by the platform then
this is a bug in the platform integration and so substitutes a dummy
regulator. Use regulator_get_optional() instead which indicates to the
framework that the regulator may be absent and provides a dummy regulator
instead.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/iio/adc/ad7266.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index 835d45db258f..655b36b4e9cb 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -396,7 +396,7 @@ static int ad7266_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 
-	st->reg = devm_regulator_get(&spi->dev, "vref");
+	st->reg = devm_regulator_get_optional(&spi->dev, "vref");
 	if (!IS_ERR(st->reg)) {
 		ret = regulator_enable(st->reg);
 		if (ret)
-- 
2.8.1

