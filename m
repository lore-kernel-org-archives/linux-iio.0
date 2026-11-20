Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795177716;
	b=UkpPAOsS7vnxPiQ3z7fNKng8GAVef51N1Uk7/QCxGDj/tKrZalBFQW5QR53laHHqYDCK
	 TejeohxYUWcEkdKJP+EH0jcUO1aMr2y4mHrDnG7zPx903r4I7MH8vsg9zaR8+TDlfSrHf
	 mdetHjqf52121VIiKEvnVtjUx6Op2hCf0voP3JeqbfY60/Ep66Fw9FyzFUU0OqFzGYWNj
	 RRe8FAnIFnanHWyjCHeb5gTQaTQn0m8EDW9jfrJ9+Jr1eSROe3HbGqB/3unV1Vf/8ZOPk
	 v3BQVs2MXPiZMi4KR9XvjVm/r2JuZgeDHTt3gtq9IeVS2fQpKBRDiIKn6TvVRfJJBdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795177716;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=RSpeMgnCaVKopAGlbQsQpEYmH7lBqzMS/R2/pJiIlpw=;
	b=FABKav5/I9FofUhvUKFAwGtjELaPqOAZxZpQ441TJT8r1tPSP38Lc3++17GvGALWLubx
	 jpYGcEKGHRMGmXNmCDXFCOh3X7DxxlYiQepd2TStjsFuTTx16/FP+09h+vSros209sRAI
	 4bKMYnTj4ecJAxFD/ZSr1QFc+qH0dX4dba12n0bU7eShm0Ec/FYvwz3o2Fb5GdXEPaOQj
	 gP3UX5xBRTgqqtCtnC8VrEm+gbxHXXptvI6iaFb2G1Yf8yO9F7nwsYPP7Y83H7IO6IEMo
	 4uo9soK2zFAlap1uSZzIQnbXh6dNDj4A93I66UQ1Wyj8599/OxL5FyVSpev0k4E5gVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="H/ksjT74";
	arc=none smtp.remote-ip=91.218.175.43
Received: from mta0.migadu.com (out-43.mta0.migadu.com [91.218.175.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEAD606A320
	for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 12:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BEAD606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=H/ksjT74
X-Envelope-To: linux-iio@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=GFu1qplnbZuq7CqyXNmmjt9Q7ABYkwEjuse0c9T6uzE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795177713; v=1; x=1795782513;
 b=H/ksjT74RKG3AnYFbTJ57j7TQVO6YRp8rIPBiNa1Ch+pyE5dxM10StMkRFUaSZyc+mipL/cs
 SYD3e3h6gefpMStIqy4yvxEMDowlXPrGH9Iyt1i+zjdoFigkdRLJnmLUWTIc6VB94vXFsuFcT+D
 kETmEhlWku7rbPxXQk7lUPRg=
X-Envelope-To: linux-iio@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id d53a5449a415dd17;
	Fri, 20 Nov 2026 12:28:33 +0000
X-Mizu-Trace-ID: d53a5449a415dd17
X-Migadu-Flow: FLOW_OUT
Date: Fri, 20 Nov 2026 14:28:28 +0200
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
Subject: [PATCH v2 3/3] iio: adc: rohm-bd79112: Support ROHM BD79111
Message-ID: <4be17e339f768da93db2f42abd3cc5a21fea01ad.1795176984.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1795176984.git.mazziesaccount@gmail.com>
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
	protocol="application/pgp-signature"; boundary="t7+2jXN09R9j1ZFp"
Content-Disposition: inline
In-Reply-To: <cover.1795176984.git.mazziesaccount@gmail.com>

--t7+2jXN09R9j1ZFp
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

---
Revision history:
v1 =3D> v2:
 - Various styling fixes as suggested by Jonathan and Andy
 - Return -ENODATA instead of -ENODEV when SPI match data is not
   available.
---
 drivers/iio/adc/Kconfig        | 10 +++--
 drivers/iio/adc/rohm-bd79112.c | 69 +++++++++++++++++++++++++++-------
 2 files changed, 62 insertions(+), 17 deletions(-)

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
index 04084e88984a..8bbb86098ff5 100644
--- a/drivers/iio/adc/rohm-bd79112.c
+++ b/drivers/iio/adc/rohm-bd79112.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * ROHM ADC driver for BD79112 signal monitoring hub.
+ * ROHM ADC/GPIO driver for BD79112 and similar signal monitoring hubs.
  * Copyright (C) 2025, ROHM Semiconductor.
  *
  * SPI communication derived from ad7923.c and ti-ads7950.c
@@ -29,7 +29,9 @@
 struct bd79112_data;
=20
 struct bd7911x_chip_data {
+	const char *name;
 	const char * const *chan_names;
+	unsigned int num_max_channels;
 	int (*init_disable_gpios)(struct bd79112_data *data);
 };
=20
@@ -377,7 +379,6 @@ static int bd79112_gpio_output(struct gpio_chip *gc, un=
signed int offset,
 }
=20
 static const struct gpio_chip bd79112_gpio_chip =3D {
-	.label			=3D "bd79112-gpio",
 	.get_direction		=3D bd79112_gpio_dir_get,
 	.direction_input	=3D bd79112_gpio_input,
 	.direction_output	=3D bd79112_gpio_output,
@@ -386,26 +387,44 @@ static const struct gpio_chip bd79112_gpio_chip =3D {
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
@@ -419,7 +438,15 @@ static int bd79112_disable_gpios(struct bd79112_data *=
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
@@ -431,8 +458,17 @@ static const char * const bd79112_chan_names[] =3D {
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
@@ -453,7 +489,7 @@ static int bd79112_probe(struct spi_device *spi)
 	data =3D iio_priv(iio_dev);
 	data->cd =3D spi_get_device_match_data(spi);
 	if (!data->cd)
-		return -ENODEV;
+		return -ENODATA;
=20
 	data->spi =3D spi;
 	data->dev =3D dev;
@@ -492,7 +528,7 @@ static int bd79112_probe(struct spi_device *spi)
 				     "Failed to optimize SPI write message\n");
=20
 	ret =3D devm_iio_adc_device_alloc_chaninfo_se(dev, &bd79112_chan_template,
-						    BD79112_MAX_NUM_CHANNELS - 1,
+						    data->cd->num_max_channels - 1,
 						    &cs);
=20
 	/* Register all pins as GPIOs if there are no ADC channels */
@@ -509,7 +545,7 @@ static int bd79112_probe(struct spi_device *spi)
 		cs[i].datasheet_name =3D data->cd->chan_names[cs[i].channel];
=20
 	iio_dev->info =3D &bd79112_info;
-	iio_dev->name =3D "bd79112";
+	iio_dev->name =3D data->cd->name;;
 	iio_dev->modes =3D INDIO_DIRECT_MODE;
=20
 	/*
@@ -528,14 +564,15 @@ static int bd79112_probe(struct spi_device *spi)
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
@@ -545,17 +582,23 @@ static int bd79112_probe(struct spi_device *spi)
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
@@ -572,6 +615,6 @@ static struct spi_driver bd79112_driver =3D {
 module_spi_driver(bd79112_driver);
=20
 MODULE_AUTHOR("Matti Vaittinen <mazziesaccount@gmail.com>");
-MODULE_DESCRIPTION("Driver for ROHM BD79112 ADC/GPIO");
+MODULE_DESCRIPTION("ADC/GPIO Driver for ROHM BD79112 et al.");
 MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS("IIO_DRIVER");
--=20
2.56.1


--t7+2jXN09R9j1ZFp
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmsAPOwACgkQeFA3/03a
ocW4+gf8CPFRSgIkBokmOnoE9x+3dFpNaJi9kaRc3BanAc3wJC1ZQNfuX7e6QIOG
h5ofEGkkyX0qCtgWN7BTJa2fNdS10MYQU6j3mCbFtXUbOZ2z/61HeH6ftDe6/G/A
TZMugegdUYF5/imzqlWP64KwwABVKfGFX4iMfJXqQFI269d/9SHTQtVmi4/6bUQa
XDkS7OKCu4q8FRqMujgmjG/xfmzuhplvSjWhwU83xYLYdWZj1H/y7OHAkPkY+Qbs
5/ChU8V46LVp0lkGPT3c3u661JFFyKzsepVK+AdakBGNNtqvHoQ3w3V1Z+apJJHy
INiEd+hFsKJ2z3bL411HZlA2vMCElQ==
=I1te
-----END PGP SIGNATURE-----

--t7+2jXN09R9j1ZFp--
