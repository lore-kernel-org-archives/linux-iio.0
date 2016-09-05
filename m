Return-Path: <cmo@melexis.com>
From: Crt Mori <cmo@melexis.com>
To: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
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
Subject: [PATCH v2 2/2] iio: devm_regulator_get_optional never returns NULL
Date: Mon,  5 Sep 2016 11:14:49 +0200
Message-Id: <20160905091449.12297-2-cmo@melexis.com>
In-Reply-To: <20160905091449.12297-1-cmo@melexis.com>
References: <20160905091449.12297-1-cmo@melexis.com>
List-ID: <linux-iio@vger.kernel.org>

This patch is inspired by a comment of Jonathan Cameron on patch of
Linus Walleij commit aeb55fff3891834e07a3144159a7298a19696af8 ("iio:
st_sensors: fetch and enable regulators unconditionally"). Because
changes made in this patch are actually reference generators they should
be using devm_regulator_get_optional, but if they do not explicitly set
the reference to NULL they should not be using IS_ERR_OR_NULL, but
simple IS_ERR check.

Suggested-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Crt Mori <cmo@melexis.com>
---
 drivers/iio/adc/ad7266.c     | 4 ++--
 drivers/iio/adc/ti-ads8688.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index c0f6a98..b8d5cfd 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -481,7 +481,7 @@ error_free_gpios:
 	if (!st->fixed_addr)
 		gpio_free_array(st->gpios, ARRAY_SIZE(st->gpios));
 error_disable_reg:
-	if (!IS_ERR_OR_NULL(st->reg))
+	if (!IS_ERR(st->reg))
 		regulator_disable(st->reg);
 
 	return ret;
@@ -496,7 +496,7 @@ static int ad7266_remove(struct spi_device *spi)
 	iio_triggered_buffer_cleanup(indio_dev);
 	if (!st->fixed_addr)
 		gpio_free_array(st->gpios, ARRAY_SIZE(st->gpios));
-	if (!IS_ERR_OR_NULL(st->reg))
+	if (!IS_ERR(st->reg))
 		regulator_disable(st->reg);
 
 	return 0;
diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
index c400439..4a16349 100644
--- a/drivers/iio/adc/ti-ads8688.c
+++ b/drivers/iio/adc/ti-ads8688.c
@@ -438,7 +438,7 @@ static int ads8688_probe(struct spi_device *spi)
 	return 0;
 
 error_out:
-	if (!IS_ERR_OR_NULL(st->reg))
+	if (!IS_ERR(st->reg))
 		regulator_disable(st->reg);
 
 	return ret;
@@ -451,7 +451,7 @@ static int ads8688_remove(struct spi_device *spi)
 
 	iio_device_unregister(indio_dev);
 
-	if (!IS_ERR_OR_NULL(st->reg))
+	if (!IS_ERR(st->reg))
 		regulator_disable(st->reg);
 
 	return 0;
-- 
2.9.3
