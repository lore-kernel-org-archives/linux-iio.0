Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:48511 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757656AbdJQKnG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Oct 2017 06:43:06 -0400
Message-Id: <43bd5525f1db09764a40f4e225a772b30603c3f5.1508232186.git.lukas@wunner.de>
In-Reply-To: <cover.1508232186.git.lukas@wunner.de>
References: <cover.1508232186.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 17 Oct 2017 12:42:00 +0200
Subject: [PATCH v2 3/3] iio: dac: ti-dac082s085: Read chip spec from device
 table
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mathias Duckeck <m.duckeck@kunbus.de>,
        Phil Elwell <phil@raspberrypi.org>, linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The two properties unique to each supported chip, resolution and number
of channels, are currently gleaned from the chip's name.
E.g. dac102s085 is a dual channel 10-bit DAC.
        ^^^
This was deemed unmaintainable by the subsystem maintainer once the
driver is extended to support further chips, hence it was requested
to add an explicit table for chip-specific information and use an
enum to reference into it.

This adds 17 LoC without any immediate gain, so make the change in a
separate commit which can be reverted if we determine in 10 years that
it was unnecessary.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/iio/dac/ti-dac082s085.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/dac/ti-dac082s085.c b/drivers/iio/dac/ti-dac082s085.c
index 0fefb110be69..2c1556f32574 100644
--- a/drivers/iio/dac/ti-dac082s085.c
+++ b/drivers/iio/dac/ti-dac082s085.c
@@ -20,6 +20,22 @@
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 
+enum { dual_8bit, dual_10bit, dual_12bit, quad_8bit, quad_10bit, quad_12bit };
+
+struct ti_dac_spec {
+	u8 num_channels;
+	u8 resolution;
+};
+
+static const struct ti_dac_spec ti_dac_spec[] = {
+	[dual_8bit]  = { .num_channels = 2, .resolution = 8  },
+	[dual_10bit] = { .num_channels = 2, .resolution = 10 },
+	[dual_12bit] = { .num_channels = 2, .resolution = 12 },
+	[quad_8bit]  = { .num_channels = 4, .resolution = 8  },
+	[quad_10bit] = { .num_channels = 4, .resolution = 10 },
+	[quad_12bit] = { .num_channels = 4, .resolution = 12 },
+};
+
 /**
  * struct ti_dac_chip - TI DAC chip
  * @lock: protects write sequences
@@ -246,6 +262,7 @@ static const struct iio_info ti_dac_info = {
 static int ti_dac_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
+	const struct ti_dac_spec *spec;
 	struct ti_dac_chip *ti_dac;
 	struct iio_dev *indio_dev;
 	int ret;
@@ -267,9 +284,9 @@ static int ti_dac_probe(struct spi_device *spi)
 	spi_message_init_with_transfers(&ti_dac->mesg, &ti_dac->xfer, 1);
 	ti_dac->mesg.spi = spi;
 
-	ret = sscanf(spi->modalias, "dac%2hhu%1d",
-		     &ti_dac->resolution, &indio_dev->num_channels);
-	WARN_ON(ret != 2);
+	spec = &ti_dac_spec[spi_get_device_id(spi)->driver_data];
+	indio_dev->num_channels = spec->num_channels;
+	ti_dac->resolution = spec->resolution;
 
 	ti_dac->vref = devm_regulator_get(dev, "vref");
 	if (IS_ERR(ti_dac->vref))
@@ -325,12 +342,12 @@ MODULE_DEVICE_TABLE(of, ti_dac_of_id);
 #endif
 
 static const struct spi_device_id ti_dac_spi_id[] = {
-	{ "dac082s085" },
-	{ "dac102s085" },
-	{ "dac122s085" },
-	{ "dac084s085" },
-	{ "dac104s085" },
-	{ "dac124s085" },
+	{ "dac082s085", dual_8bit  },
+	{ "dac102s085", dual_10bit },
+	{ "dac122s085", dual_12bit },
+	{ "dac084s085", quad_8bit  },
+	{ "dac104s085", quad_10bit },
+	{ "dac124s085", quad_12bit },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ti_dac_spi_id);
-- 
2.11.0

