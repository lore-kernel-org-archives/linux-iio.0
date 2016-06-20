Return-Path: <broonie@sirena.org.uk>
From: Mark Brown <broonie@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Date: Mon, 20 Jun 2016 13:53:32 +0100
Message-Id: <1466427214-13372-1-git-send-email-broonie@kernel.org>
Subject: [PATCH 1/3] iio:ad7266: Fix broken regulator error handling
List-ID: <linux-iio@vger.kernel.org>

All regulator_get() variants return either a pointer to a regulator or an
ERR_PTR() so testing for NULL makes no sense and may lead to bugs if we
use NULL as a valid regulator. Fix this by using IS_ERR() as expected.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/iio/adc/ad7266.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index 21e19b60e2b9..835d45db258f 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -397,7 +397,7 @@ static int ad7266_probe(struct spi_device *spi)
 	st = iio_priv(indio_dev);
 
 	st->reg = devm_regulator_get(&spi->dev, "vref");
-	if (!IS_ERR_OR_NULL(st->reg)) {
+	if (!IS_ERR(st->reg)) {
 		ret = regulator_enable(st->reg);
 		if (ret)
 			return ret;
-- 
2.8.1
