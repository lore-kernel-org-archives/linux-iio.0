Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795011591;
	b=J0MDRB6AdsB7esYqjakbWg19cmZViWd19jzPBkoMj0MhMaYkYtvxJ+EVjz22gQaMy7Pa
	 tZqocTAhZ6DD2XbGBaqG7vrdQrba6c+Hgu2+rTyD2s+N5jA7RGz6PDDoSxxSqScQX5DI0
	 wnyyDz4BLNdJ/mD7qRA4OneuyyzLoqfMYuhgrVsCKrL6NkHHCUu02H+Ke7DP0NNq+6M/q
	 BdvkRoLFat9Cjo14hCzS+0Ub3Jg6N0sHu7pziso2GeRY4U37GyKqx1R7CS5hdGwxnVH86
	 4qVlMlGFYrD6hGFWwHpWGHEkxhFZPKFt+nKTmu3FAsjDl1pYqw6FWiVLHqnBTNMixIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795011591;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=4rdxyYOPFwUyLajcdnVY3OZGYFGwOxBcZYg/ia1yXxg=;
	b=aPDxyRwsXZuMifIJ589MwcQsC4JUDRyiKfWQS4iPdamkJ1h9nZzmVsElRfOdFc/8l53w
	 0If3itRUvejNGHU+TZ9F1/Cnit6EUVUKmi4RKFyH26MzSg54+I1/ujPmZ1Kt/WWU4fuFT
	 03xm5NDmkyIKQj9lv4UFEYr+/tIaY04iQ16CPasW6nNfB9n7D/XNzrveZa1uP1sf/+9uc
	 MIhKHlzZTmHREm08QIpXj7b+nHJ55UqU9v/G9TL9MdttrAvQgAXNrNNHtkJkJBS2wCaL2
	 u6iEbqwyGJyK5jAJLrK+YfW+m/5Rgga5rPiXzEUoLaH+uWIjQEleryDEqMHXR70o3ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Ie1MwWkm;
	arc=none smtp.remote-ip=91.218.175.177
Received: from mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9C460A2601
	for <linux-iio@vger.kernel.org>; Wed, 18 Nov 2026 14:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C9C460A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Ie1MwWkm
X-Envelope-To: linux-iio@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=y58Vqto1CrafBqcfz2cdsiNSD1Wm2+vfCv95aPaAVOk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795011584; v=1; x=1795616384;
 b=Ie1MwWkm7aH1N3ri7M55G2D2qscHe7yDbvwQANOMd7p4Dy24CJpFyDPWrPjIwXjPVnvqU/lo
 c5YiQpeIWaqCOiKlKa0Swfplp08p7ddGmV53QuXfBu7Sf1UF0hNx4HQiRTVEaU8aTbidt7yXu0F
 6xuvdoEc00HY0hoedbMweZao=
X-Envelope-To: linux-iio@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id d5cee1d6bcf1e741;
	Wed, 18 Nov 2026 14:19:44 +0000
X-Mizu-Trace-ID: d5cee1d6bcf1e741
X-Migadu-Flow: FLOW_OUT
Date: Wed, 18 Nov 2026 16:19:35 +0200
From: Matti Vaittinen <matti.vaittinen@linux.dev>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Radu Sabau <radu.sabau@analog.com>,
	Janani Sunil <janani.sunil@analog.com>,
	Salih Erim <salih.erim@amd.com>,
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jakub Szczudlo <jakubszczudlo40@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: adc: rohm-bd79112: Support ROHM BD79111
Message-ID: <ab74e547e892ccabb763a06e8231e8ed44f4fefb.1795009599.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1795009599.git.mazziesaccount@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YRAVFnL+mKuwFnO9"
Content-Disposition: inline
In-Reply-To: <cover.1795009599.git.mazziesaccount@gmail.com>

--YRAVFnL+mKuwFnO9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

ROHM BD79111 is very similar to the BD79112. Both are ADC/GPIO devices,
where pins can be configured to be either used as GPIO or ADC inputs.
ADCs are 12-bit SAR ADCs and GPIOs support input/output but not being IRQ
sources.

The main difference is amount of channels/GPIOs. The BD79112 has 32 pins
for this use, the BD79111 has 16. Furthermore, the BD79111 data-sheet
promises 0.5 MSPS sample rate with maximum of 10 MHz SPI clock,  whereas
the BD79112 data-sheet mentioned 1MSPS rate with maximum of 20 MHz SPI
clock.

NOTE: In order to achieve those speeds one needs to use more optimized
protocol compared to the one implemented in this driver. This driver
retrieves samples using two 16-bit SPI transactions. The first
transaction writes the channel to be sampled, and ignores data on MISO.
Then the next 16-bit transaction carries the data.

Achieving maximum sample-rate would require the driver to interpret the
MISO data of each 16-bit transaction so, that when the
channel-to-be-sampled was sent in transaction N, the data is read at
transaction N+1 - which also already configures the channel to be
sampled for transaction N+2. Supporting this would require the
channel-to-be-read for the future read to be known when the current
channel data is retrieved. For raw-reads this is not possible and for
buffered reads it would make things a bit hairy.

So, here we aim for simplicity instead of the peak performance.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/adc/Kconfig        |   9 +--
 drivers/iio/adc/rohm-bd79112.c | 113 +++++++++++++++++++++++++++------
 2 files changed, 98 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a802d8ee4dd9..db9e0a0713e1 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1516,14 +1516,15 @@ config RN5T618_ADC
 	  will be called rn5t618-adc.
=20
 config ROHM_BD79112
-	tristate "Rohm BD79112 ADC driver"
+	tristate "ROHM BD79112 and BD79111 ADC/GPIO driver"
 	depends on SPI && GPIOLIB
 	select REGMAP_SPI
 	select IIO_ADC_HELPER
 	help
-	  Say yes here to build support for the ROHM BD79112 ADC. The
-	  ROHM BD79112 is a 12-bit, 32-channel, SAR ADC. Analog inputs
-	  can also be used for GPIO.
+	  Say yes here to build support for the ROHM BD79112 and BD79111
+	  ADCs. Both of the ICs are 12-bit SAR ADCs. The ROHM BD79112 has
+	  32-channels, the BD79111 has 16. Analog inputs can also be used
+	  for GPIO.
=20
 config ROHM_BD79124
 	tristate "Rohm BD79124 ADC driver"
diff --git a/drivers/iio/adc/rohm-bd79112.c b/drivers/iio/adc/rohm-bd79112.c
index 2506fec7be84..604c6ccafb4f 100644
--- a/drivers/iio/adc/rohm-bd79112.c
+++ b/drivers/iio/adc/rohm-bd79112.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * ROHM ADC driver for BD79112 signal monitoring hub.
+ * ROHM ADC driver for BD79111 and BD79112 signal monitoring hubs.
  * Copyright (C) 2025, ROHM Semiconductor.
  *
  * SPI communication derived from ad7923.c and ti-ads7950.c
@@ -26,7 +26,17 @@
=20
 #define BD79112_MAX_NUM_CHANNELS 32
=20
+struct bd79112_data;
+
+struct bd7911x_chip_data {
+	const char *name;
+	const char * const *chan_names;
+	unsigned int num_channels;
+	int (*init_disable_gpios)(struct bd79112_data *data);
+};
+
 struct bd79112_data {
+	const struct bd7911x_chip_data *cd;
 	struct spi_device *spi;
 	struct regmap *map;
 	struct device *dev;
@@ -369,7 +379,6 @@ static int bd79112_gpio_output(struct gpio_chip *gc, un=
signed int offset,
 }
=20
 static const struct gpio_chip bd79112_gpio_chip =3D {
-	.label			=3D "bd79112-gpio",
 	.get_direction		=3D bd79112_gpio_dir_get,
 	.direction_input	=3D bd79112_gpio_input,
 	.direction_output	=3D bd79112_gpio_output,
@@ -378,20 +387,20 @@ static const struct gpio_chip bd79112_gpio_chip =3D {
 	.set_multiple		=3D bd79112_gpio_set_multiple,
 	.init_valid_mask	=3D bd79112_gpio_init_valid_mask,
 	.can_sleep		=3D true,
-	.ngpio			=3D 32,
 	.base			=3D -1,
 };
=20
-static unsigned int bd79112_get_gpio_pins(const struct iio_chan_spec *cs, =
int num_channels)
+static unsigned int bd79112_get_gpio_pins(const struct iio_chan_spec *cs,
+					  int num_channels, int max_channels)
 {
 	unsigned int i, gpio_channels;
=20
 	/*
-	 * Let's initialize the mux config to say that all 32 channels are
+	 * Let's initialize the mux config to say that all channels are
 	 * GPIOs. Then we can just loop through the iio_chan_spec and clear the
 	 * bits for found ADC channels.
 	 */
-	gpio_channels =3D GENMASK(31, 0);
+	gpio_channels =3D GENMASK(max_channels - 1, 0);
 	for (i =3D 0; i < num_channels; i++)
 		gpio_channels &=3D ~BIT(cs[i].channel);
=20
@@ -410,6 +419,61 @@ static const char * const bd79112_chan_names[] =3D {
 	"AGIO12B", "AGIO13B", "AGIO14B", "AGIO15B",	/* 28 - 31 */
 };
=20
+static int bd79112_disable_gpios(struct bd79112_data *data)
+{
+	unsigned int i;
+	int ret;
+
+	for (i =3D 0; i < BD79112_NUM_GPIO_EN_REGS; i++) {
+		ret =3D regmap_write(data->map, BD79112_FIRST_GPIO_EN_REG + i, 0);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/* The BD79111 only has the registers for pins 0 - 15 */
+static int bd79111_disable_gpios(struct bd79112_data *data)
+{
+	static const unsigned int regs[] =3D {
+		BD79112_REG_GPI_EN_A8_A15, BD79112_REG_GPI_EN_A0_A7,
+		BD79112_REG_GPO_EN_A8_A15, BD79112_REG_GPO_EN_A0_A7,
+	};
+	unsigned int i;
+	int ret;
+
+	for (i =3D 0; i < ARRAY_SIZE(regs); i++) {
+		ret =3D regmap_write(data->map, regs[i], 0);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/* The BD79111 channel names as in the data-sheet */
+static const char * const bd79111_chan_names[] =3D {
+	"AGIO0", "AGIO1", "AGIO2", "AGIO3",		/* 0 - 3 */
+	"AGIO4", "AGIO5", "AGIO6", "AGIO7",		/* 4 - 7 */
+	"AGIO8", "AGIO9", "AGIO10", "AGIO11",		/* 8 - 11 */
+	"AGIO12", "AGIO13", "AGIO14", "AGIO15",		/* 12 - 15 */
+};
+
+static const struct bd7911x_chip_data bd79111_chip_data =3D {
+	.name =3D "bd79111",
+	.chan_names =3D bd79111_chan_names,
+	.num_channels =3D 16,
+	.init_disable_gpios =3D bd79111_disable_gpios,
+};
+
+static const struct bd7911x_chip_data bd79112_chip_data =3D {
+	.name =3D "bd79112",
+	.chan_names =3D bd79112_chan_names,
+	.num_channels =3D 32,
+	.init_disable_gpios =3D bd79112_disable_gpios,
+};
+
 static int bd79112_probe(struct spi_device *spi)
 {
 	struct bd79112_data *data;
@@ -425,6 +489,10 @@ static int bd79112_probe(struct spi_device *spi)
 		return -ENOMEM;
=20
 	data =3D iio_priv(iio_dev);
+	data->cd =3D spi_get_device_match_data(spi);
+	if (!data->cd)
+		return -ENODEV;
+
 	data->spi =3D spi;
 	data->dev =3D dev;
 	data->map =3D devm_regmap_init(dev, NULL, data, &bd79112_regmap);
@@ -462,7 +530,7 @@ static int bd79112_probe(struct spi_device *spi)
 				     "Failed to optimize SPI write message\n");
=20
 	ret =3D devm_iio_adc_device_alloc_chaninfo_se(dev, &bd79112_chan_template,
-						    BD79112_MAX_NUM_CHANNELS - 1,
+						    data->cd->num_channels - 1,
 						    &cs);
=20
 	/* Register all pins as GPIOs if there are no ADC channels */
@@ -476,10 +544,10 @@ static int bd79112_probe(struct spi_device *spi)
 	iio_dev->channels =3D cs;
=20
 	for (i =3D 0; i < iio_dev->num_channels; i++)
-		cs[i].datasheet_name =3D bd79112_chan_names[cs[i].channel];
+		cs[i].datasheet_name =3D data->cd->chan_names[cs[i].channel];
=20
 	iio_dev->info =3D &bd79112_info;
-	iio_dev->name =3D "bd79112";
+	iio_dev->name =3D data->cd->name;
 	iio_dev->modes =3D INDIO_DIRECT_MODE;
=20
 	/*
@@ -488,12 +556,9 @@ static int bd79112_probe(struct spi_device *spi)
 	 * without having to worry about some pins being initially used for
 	 * GPIO.
 	 */
-	for (i =3D 0; i < BD79112_NUM_GPIO_EN_REGS; i++) {
-		ret =3D regmap_write(data->map, BD79112_FIRST_GPIO_EN_REG + i, 0);
-		if (ret)
-			return dev_err_probe(dev, ret,
-					     "Failed to initialize channels\n");
-	}
+	ret =3D data->cd->init_disable_gpios(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to initialize channels\n");
=20
 	ret =3D devm_iio_device_register(data->dev, iio_dev);
 	if (ret)
@@ -501,14 +566,15 @@ static int bd79112_probe(struct spi_device *spi)
=20
 register_gpios:
 	gpio_pins =3D bd79112_get_gpio_pins(iio_dev->channels,
-					  iio_dev->num_channels);
+					  iio_dev->num_channels,
+					  data->cd->num_channels);
=20
 	/* If all channels are reserved for ADC, then we're done. */
 	if (!gpio_pins)
 		return 0;
=20
 	/* Default all the GPIO pins to GPI */
-	for_each_set_bit(pin, &gpio_pins, BD79112_MAX_NUM_CHANNELS) {
+	for_each_set_bit(pin, &gpio_pins, data->cd->num_channels) {
 		ret =3D bd79112_gpio_dir_set(data, pin, GPIO_LINE_DIRECTION_IN);
 		if (ret)
 			return dev_err_probe(dev, ret,
@@ -518,18 +584,25 @@ static int bd79112_probe(struct spi_device *spi)
 	data->gpio_valid_mask =3D gpio_pins;
 	data->gc =3D bd79112_gpio_chip;
 	data->gc.parent =3D dev;
+	data->gc.ngpio =3D data->cd->num_channels;
+	data->gc.label =3D devm_kasprintf(dev, GFP_KERNEL, "%s-gpio",
+					data->cd->name);
+	if (!data->gc.label)
+		return -ENOMEM;
=20
 	return devm_gpiochip_add_data(dev, &data->gc, data);
 }
=20
 static const struct of_device_id bd79112_of_match[] =3D {
-	{ .compatible =3D "rohm,bd79112" },
+	{ .compatible =3D "rohm,bd79111", .data =3D &bd79111_chip_data },
+	{ .compatible =3D "rohm,bd79112", .data =3D &bd79112_chip_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, bd79112_of_match);
=20
 static const struct spi_device_id bd79112_id[] =3D {
-	{ .name =3D "bd79112" },
+	{ .name =3D "bd79111", .driver_data =3D (kernel_ulong_t)&bd79111_chip_dat=
a },
+	{ .name =3D "bd79112", .driver_data =3D (kernel_ulong_t)&bd79112_chip_dat=
a },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, bd79112_id);
@@ -545,6 +618,6 @@ static struct spi_driver bd79112_driver =3D {
 module_spi_driver(bd79112_driver);
=20
 MODULE_AUTHOR("Matti Vaittinen <mazziesaccount@gmail.com>");
-MODULE_DESCRIPTION("Driver for ROHM BD79112 ADC/GPIO");
+MODULE_DESCRIPTION("Driver for ROHM BD79111 and BD79112 ADC/GPIO");
 MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS("IIO_DRIVER");
--=20
2.56.1


--YRAVFnL+mKuwFnO9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmr9s/cACgkQeFA3/03a
ocUMqwf7BmIWqqRqHND2VY1Z4T4CdPtg+A2aDm2yG8IcNRoYV+J+QUMLjN3Gvfi0
KgGMCozEUOIVD3778gCIc3WQ84UkQi9IyXpKizq3pxaFGQ+O5YRPjObF0OJuO5g5
Ao8pFd6cSCxNKpq+3LFbj72uo69LoAIgz+2BBfhfR0YoYGSFu673r88EqPGa4Lo6
DSHGVqAFGMBlF+XvKZUUmdCusqpzOD0N/KiPfZmlofL5QihMkQzJDyJLB7O+PC3T
gvsIypFk1VwWAFu+9uZSYNvFyr87o2RQ9md1e8c+AqSKoA2pTDyAb4NVl/tC9a/Y
AhJ7YgocLEqG60JaifnwVjZoy2u09A==
=wdjx
-----END PGP SIGNATURE-----

--YRAVFnL+mKuwFnO9--
