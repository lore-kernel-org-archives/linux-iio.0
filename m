Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795422055;
	b=qoQJxK5lB+KXKK489SOhaKHdtmtqb8E/mRiNz/6rwIzLeNl+uayXlCq3mA8AeU9RoD5z
	 YzEgE45SCtlQ/Ur85hpNkDmYz8tegtcLsW8oZ3xakYJUOwYyQhRdX+njCxxzgszKGa+ip
	 7q1dSYolzL12/plgKzlylOgAwy/cywbBpw/XS9/qn6xZhdrzeh+j4LNGavgzRiMplOC6N
	 Y19AYV7N0MeJ9SFGL2nCX+4K0bZUE2Yw6zaLJNKtrLNP6zTfF1vghQ5vUZOG0jbNBaZLv
	 E3duJ1NCtY3y+eF4XQcFOk0k/K5r8f3m1R1TJ24S+vH/uY4QqfIssloOQf7X0c8QGug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795422055;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=cl/pXUAFHMOStgfX/z8Ynk6bC8AeiuvQc0TEpF7Sanc=;
	b=uqfFS2u4dcb2htAnJyLdZG4qhqcZZ/r8GqVDD9P0aSsOv0ZiPR0G4+zXQ5nopUIJe5D7
	 yvpV9PpgKeOcNEqHy8WcO9nWmPzx2Cu9PTZuwaeJ6m0gRzqIJO7geOboVkfdABwwj0Xlb
	 Jz+7mQjHdYKH3OSf0QCCk1K+kQXGOHFvIpefcyYXT/dJu7olVHwH36PjobQSP7CzKB5Qe
	 bR0UsnBMb7sdBwSNuLxLi0raxS8EZHEiTWRPyxqtrs3qjC8urIFTz2J1vVtc1zg2hT9rp
	 w28yBFKMJ7EvObdwGAOg8ba1yUHhw+b9/MNaNRTvjPI1sT4tl5Llom4fjkG575vZYJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="h7Dj/gnA";
	arc=none smtp.remote-ip=91.218.175.130
Received: from mta0.migadu.com (out-130.mta0.migadu.com [91.218.175.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DEA606A321
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 08:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8DEA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=h7Dj/gnA
X-Envelope-To: linux-iio@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ajmNhYRWREHcQLIOsLlhjIqUbOiezGtNKYIUFAOCjbI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795422052; v=1; x=1796026852;
 b=h7Dj/gnAvup5Su8uFzAL2Nx4tXRt/vyjaB/mpTl1mlyhXFGbaYqr3h7LWqROUscOOPRyhuFu
 m5EL46rJktJ9yqJwdV2/TywFqTkzDJ+BNjLrCF2fRQV5IWrfZIRGjYhEgI4yLMYr1fxjZPjicYc
 ZmNMKdIG6jaN//dVy20ejSa0=
X-Envelope-To: linux-iio@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 0e9517c8098cc229;
	Mon, 23 Nov 2026 08:20:49 +0000
X-Mizu-Trace-ID: 0e9517c8098cc229
X-Migadu-Flow: FLOW_OUT
Date: Mon, 23 Nov 2026 10:20:41 +0200
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
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jakub Szczudlo <jakubszczudlo40@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] iio: adc: rohm-bd79112: Support ROHM BD79111
Message-ID: <b3dd43b931928ea59cfe8ce6b42168e2b3537b57.1795421473.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1795421473.git.mazziesaccount@gmail.com>
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
	protocol="application/pgp-signature"; boundary="uMJVGXi8IEaDRH/0"
Content-Disposition: inline
In-Reply-To: <cover.1795421473.git.mazziesaccount@gmail.com>

--uMJVGXi8IEaDRH/0
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

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by; Andy Shevchenko <andriy.shevchenko@intel.com>

---
Revision history:
v2 =3D> v3:
 - Drop unused define
 - Fix accidential double-semicolon
 - Comment nitpick fix
v1 =3D> v2:
 - Various styling fixes as suggested by Jonathan and Andy
 - Return -ENODATA instead of -ENODEV when SPI match data is not
   available.
---
 drivers/iio/adc/Kconfig        | 10 +++--
 drivers/iio/adc/rohm-bd79112.c | 69 +++++++++++++++++++++++++++-------
 2 files changed, 61 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a802d8ee4dd9..78562e6c62f5 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1516,14 +1516,16 @@ config RN5T618_ADC
 	  will be called rn5t618-adc.
=20
 config ROHM_BD79112
-	tristate "Rohm BD79112 ADC driver"
+	tristate "ADC/GPIO Driver for ROHM BD79112 et al."
 	depends on SPI && GPIOLIB
 	select REGMAP_SPI
 	select IIO_ADC_HELPER
 	help
-	  Say yes here to build support for the ROHM BD79112 ADC. The
-	  ROHM BD79112 is a 12-bit, 32-channel, SAR ADC. Analog inputs
-	  can also be used for GPIO.
+	  Say yes here to build support for the following ROHM SAR ADCs:
+	  - BD79111 (12-bit, 16 channels)
+	  - BD79112 (12-bit, 32 channels)
+
+	  Analog inputs can also be used for GPIO.
=20
 config ROHM_BD79124
 	tristate "Rohm BD79124 ADC driver"
diff --git a/drivers/iio/adc/rohm-bd79112.c b/drivers/iio/adc/rohm-bd79112.c
index 638ba161bba8..fd24f33dff82 100644
--- a/drivers/iio/adc/rohm-bd79112.c
+++ b/drivers/iio/adc/rohm-bd79112.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * ROHM ADC driver for BD79112 signal monitoring hub.
+ * ADC/GPIO driver for ROHM BD79112 and similar signal monitoring hubs.
  * Copyright (C) 2025, ROHM Semiconductor.
  *
  * SPI communication derived from ad7923.c and ti-ads7950.c
@@ -24,12 +24,12 @@
 #include <linux/iio/adc-helpers.h>
 #include <linux/iio/iio.h>
=20
-#define BD79112_MAX_NUM_CHANNELS 32
-
 struct bd79112_data;
=20
 struct bd7911x_chip_data {
+	const char *name;
 	const char * const *chan_names;
+	unsigned int num_max_channels;
 	int (*init_disable_gpios)(struct bd79112_data *data);
 };
=20
@@ -377,7 +377,6 @@ static int bd79112_gpio_output(struct gpio_chip *gc, un=
signed int offset,
 }
=20
 static const struct gpio_chip bd79112_gpio_chip =3D {
-	.label			=3D "bd79112-gpio",
 	.get_direction		=3D bd79112_gpio_dir_get,
 	.direction_input	=3D bd79112_gpio_input,
 	.direction_output	=3D bd79112_gpio_output,
@@ -386,26 +385,44 @@ static const struct gpio_chip bd79112_gpio_chip =3D {
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
 	return gpio_channels;
 }
=20
+/* The BD79111 only has the registers for pins 0 - 15 */
+static int bd79111_disable_gpios(struct bd79112_data *data)
+{
+	static const unsigned int regs[] =3D {
+		BD79112_REG_GPI_EN_A8_A15, BD79112_REG_GPI_EN_A0_A7,
+		BD79112_REG_GPO_EN_A8_A15, BD79112_REG_GPO_EN_A0_A7,
+	};
+	int ret;
+
+	for (unsigned int i =3D 0; i < ARRAY_SIZE(regs); i++) {
+		ret =3D regmap_write(data->map, regs[i], 0);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int bd79112_disable_gpios(struct bd79112_data *data)
 {
 	int ret;
@@ -419,7 +436,15 @@ static int bd79112_disable_gpios(struct bd79112_data *=
data)
 	return 0;
 }
=20
-/* ADC channels as named in the data-sheet */
+/* The BD79111 channel names as in the data-sheet */
+static const char * const bd79111_chan_names[] =3D {
+	"AGIO0", "AGIO1", "AGIO2", "AGIO3",		/* 0 - 3 */
+	"AGIO4", "AGIO5", "AGIO6", "AGIO7",		/* 4 - 7 */
+	"AGIO8", "AGIO9", "AGIO10", "AGIO11",		/* 8 - 11 */
+	"AGIO12", "AGIO13", "AGIO14", "AGIO15",		/* 12 - 15 */
+};
+
+/* The BD79112 channel name as in the data-sheet */
 static const char * const bd79112_chan_names[] =3D {
 	"AGIO0A", "AGIO1A", "AGIO2A", "AGIO3A",		/* 0 - 3 */
 	"AGIO4A", "AGIO5A", "AGIO6A", "AGIO7A",		/* 4 - 7 */
@@ -431,8 +456,17 @@ static const char * const bd79112_chan_names[] =3D {
 	"AGIO12B", "AGIO13B", "AGIO14B", "AGIO15B",	/* 28 - 31 */
 };
=20
+static const struct bd7911x_chip_data bd79111_chip_data =3D {
+	.name =3D "bd79111",
+	.chan_names =3D bd79111_chan_names,
+	.num_max_channels =3D 16,
+	.init_disable_gpios =3D bd79111_disable_gpios,
+};
+
 static const struct bd7911x_chip_data bd79112_chip_data =3D {
+	.name =3D "bd79112",
 	.chan_names =3D bd79112_chan_names,
+	.num_max_channels =3D 32,
 	.init_disable_gpios =3D bd79112_disable_gpios,
 };
=20
@@ -492,7 +526,7 @@ static int bd79112_probe(struct spi_device *spi)
 				     "Failed to optimize SPI write message\n");
=20
 	ret =3D devm_iio_adc_device_alloc_chaninfo_se(dev, &bd79112_chan_template,
-						    BD79112_MAX_NUM_CHANNELS - 1,
+						    data->cd->num_max_channels - 1,
 						    &cs);
=20
 	/* Register all pins as GPIOs if there are no ADC channels */
@@ -509,7 +543,7 @@ static int bd79112_probe(struct spi_device *spi)
 		cs[i].datasheet_name =3D data->cd->chan_names[cs[i].channel];
=20
 	iio_dev->info =3D &bd79112_info;
-	iio_dev->name =3D "bd79112";
+	iio_dev->name =3D data->cd->name;
 	iio_dev->modes =3D INDIO_DIRECT_MODE;
=20
 	/*
@@ -528,14 +562,15 @@ static int bd79112_probe(struct spi_device *spi)
=20
 register_gpios:
 	gpio_pins =3D bd79112_get_gpio_pins(iio_dev->channels,
-					  iio_dev->num_channels);
+					  iio_dev->num_channels,
+					  data->cd->num_max_channels);
=20
 	/* If all channels are reserved for ADC, then we're done. */
 	if (!gpio_pins)
 		return 0;
=20
 	/* Default all the GPIO pins to GPI */
-	for_each_set_bit(pin, &gpio_pins, BD79112_MAX_NUM_CHANNELS) {
+	for_each_set_bit(pin, &gpio_pins, data->cd->num_max_channels) {
 		ret =3D bd79112_gpio_dir_set(data, pin, GPIO_LINE_DIRECTION_IN);
 		if (ret)
 			return dev_err_probe(dev, ret,
@@ -545,17 +580,23 @@ static int bd79112_probe(struct spi_device *spi)
 	data->gpio_valid_mask =3D gpio_pins;
 	data->gc =3D bd79112_gpio_chip;
 	data->gc.parent =3D dev;
+	data->gc.ngpio =3D data->cd->num_max_channels;
+	data->gc.label =3D devm_kasprintf(dev, GFP_KERNEL, "%s-gpio", data->cd->n=
ame);
+	if (!data->gc.label)
+		return -ENOMEM;
=20
 	return devm_gpiochip_add_data(dev, &data->gc, data);
 }
=20
 static const struct of_device_id bd79112_of_match[] =3D {
+	{ .compatible =3D "rohm,bd79111", .data =3D &bd79111_chip_data },
 	{ .compatible =3D "rohm,bd79112", .data =3D &bd79112_chip_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, bd79112_of_match);
=20
 static const struct spi_device_id bd79112_id[] =3D {
+	{ .name =3D "bd79111", .driver_data =3D (kernel_ulong_t)&bd79111_chip_dat=
a },
 	{ .name =3D "bd79112", .driver_data =3D (kernel_ulong_t)&bd79112_chip_dat=
a },
 	{ }
 };
@@ -572,6 +613,6 @@ static struct spi_driver bd79112_driver =3D {
 module_spi_driver(bd79112_driver);
=20
 MODULE_AUTHOR("Matti Vaittinen <mazziesaccount@gmail.com>");
-MODULE_DESCRIPTION("Driver for ROHM BD79112 ADC/GPIO");
+MODULE_DESCRIPTION("ADC/GPIO Driver for ROHM BD79112 et al.");
 MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS("IIO_DRIVER");
--=20
2.56.1


--uMJVGXi8IEaDRH/0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmsD91kACgkQeFA3/03a
ocUzZQf/c/TLWLygmYw6gMt8elt6Kql0sDyQIC4xas3fgi3M90LMKEVOCpp6YhHx
plv+xLWMk3vDFvI3PuaBmBy+9nG74cnRWCchWj6mPB6bYWjfdhy2u3QAysUd7p7K
xNC91Hamw+g0f+LuXTwpX1Ne8r/LXlIs57gKoA3VuMB8PvfM8GT0AtuUtUmqyd7Z
ML/AkqQNHLbJzEICEUfed0K0EQYTxMyxfLEuP73jAUOp5ywwPszISc7yXI4Muo/t
+V03zJor8teajPl0kg1cXc5xY6dYuvqVw4SQlUjgAFo7S8jOJhPEePyElgaJIEO1
6wKARHjnmoWYLaHcQkB1rWO1IsLyZQ==
=z/ta
-----END PGP SIGNATURE-----

--uMJVGXi8IEaDRH/0--
