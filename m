Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795699403;
	b=jp8lT6RjScYBYEOKiBLkV1nSiPic8SH/2JvOcR1RsrpLir5mwWe+sQGOIBEtY8ctDoRE
	 GRXH0WFER7Pv1/88XzdfsgRY5Nhebi/HFMAZpjS0ALlLcJLjvWHUamfEkZM4gWJUNY21/
	 X+kWfnRRlOeyp0nyE5KbnqRjfyJLPovPATCsl9yS3p5Lw0Mn86+KYFVj2LdGF9JZUNGDh
	 U+dBe5RIIVNIobG7sXIp7ocztyqJzWOoCLTkfuMNGUKKYzYu5UIFY5OCiCu2McDluQGMd
	 QRQuNf33RHLTJQZ2K61zA5I7z4oVMXytfni0Jnj/eOxG+UwM1mybOVCgsw0gA9MG4XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699403;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:MIME-Version:Content-Type:Content-Disposition;
	bh=9Q4HPbDok+YSIxyUO4+Gr54EuShnAYriLRIDzQva5Zo=;
	b=LTqZGfJLSL4uZXj4d6HQzDAdwrHoJdI61CijTdeQO+BfdiD9/5Xw1wXNvmHnTvsCgyvi
	 /MO/7t7zoxzH/UXn+gVsR2sx/kjay7LWFia3krR3ff6NIHei6qaf3lzWZaAlVkzb3GhQM
	 PxTd1/i7cHlGLUPW2FHff9c0VkYEzXVbOnxDNCe8C2wOWA7wbgtHqNxMGeoE0aM7a1thT
	 K6Fl2BcIrdnmwCpLer8Kx/4yv+t3zP5UG2Ph1asOerJzk0445r5SysqBdz7M71IHlBeEJ
	 2Ux6R6mVc5NXT3w0LPer80ervuI5YOdVF9vumVWV9OGDbj7pUXjaMbF7BLmroeLMXzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="A5iud+/e";
	arc=none smtp.remote-ip=95.215.58.6
Received: from mta1.migadu.com (out-6.mta1.migadu.com [95.215.58.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4193606A31C
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 13:23:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F4193606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=A5iud+/e
X-Envelope-To: linux-iio@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Gw/m0PMEovpXp86ymn4CNu2TctHCtUbXODjvntf+6Qg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795699400; v=1; x=1796304200;
 b=A5iud+/ejTsomPvWG9oMwJ+GADdm0/7YcVnvJa6tSiUI1A7YA73M/83EdNUUXJuFELUfVKMJ
 1QkP5wSNxrDBaRxYOMhG3I68ht9dFOZamgy9zbyuRyT3cP2uYoEupdDEzONBgF0UdSBjdJwJMgN
 7E5kQ7B28gkAYMqOmkOf0tEU=
X-Envelope-To: linux-iio@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 7c97a814df217ae3;
	Thu, 26 Nov 2026 13:23:19 +0000
X-Mizu-Trace-ID: 7c97a814df217ae3
X-Migadu-Flow: FLOW_OUT
Date: Thu, 26 Nov 2026 15:23:10 +0200
From: Matti Vaittinen <matti.vaittinen@linux.dev>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: dac: rohm-bd79703: Fix full-scale voltages
Message-ID: <0723d51fa973f0204e1c436c08a784b7b1cca795.1795699121.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
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
	protocol="application/pgp-signature"; boundary="SBrO5oM791bhl63I"
Content-Disposition: inline

--SBrO5oM791bhl63I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

The BD79702 and BD79703 have a VFS pin which can be used to supply a
full-scale voltage to be output with maximum DAC word. The driver
assumes this voltage is the full-scale voltage for all of the DAC
channels. This, however, is not true.

The VFS-pin voltage is only used for the first half of the channels. Eg.
on BD79703, channels AO1 and AO2 use VFS, AO3 and, AO4 use the VCC.
Similarly, the BD79703 channels AO1, AO2, and, AO3 use VFS, AO4, AO5, and
AO6 use the VCC.

Fix the driver to use correct full-scale voltages (VCC instead of VFS) on
the last channels of the BD79702 and BD79703. The BD79700 and BD79701
logic should not be changed.

NOTE: This change is visible to the user-space, it makes the scale a
per-channel property so the sysFS file out_voltage_scale gets replaced
by per-channel variants out_voltageN_scale

Fixes: af6aca656a85 ("iio: dac: Support ROHM BD79703 DAC")
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
---
 drivers/iio/dac/rohm-bd79703.c | 77 ++++++++++++++++++++++------------
 1 file changed, 51 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/dac/rohm-bd79703.c b/drivers/iio/dac/rohm-bd79703.c
index 127ccc2c4a22..1d58bc1544a1 100644
--- a/drivers/iio/dac/rohm-bd79703.c
+++ b/drivers/iio/dac/rohm-bd79703.c
@@ -41,7 +41,9 @@ static const struct regmap_config bd79703_regmap_config =
=3D {
 /* Dynamic driver private data */
 struct bd79703_data {
 	struct regmap *regmap;
-	int vfs;
+	int vcc_mv;
+	int vfs_mv;
+	unsigned int num_vfs_chan;
 };
=20
 /* Static, IC type specific data for different variants */
@@ -49,7 +51,11 @@ struct bd7970x_chip_data {
 	const char *name;
 	const struct iio_chan_spec *channels;
 	int num_channels;
-	bool has_vfs;
+	/*
+	 * Some ICs use VFS-pin for full-scale voltage for first N channels.
+	 * We need to know these channels to get correct scale
+	 */
+	unsigned int num_vfs_chan;
 };
=20
 static int bd79703_read_raw(struct iio_dev *idev,
@@ -61,7 +67,11 @@ static int bd79703_read_raw(struct iio_dev *idev,
 	if (mask !=3D IIO_CHAN_INFO_SCALE)
 		return -EINVAL;
=20
-	*val =3D data->vfs / 1000;
+	if (data->num_vfs_chan > chan->channel)
+		*val =3D data->vfs_mv;
+	else
+		*val =3D data->vcc_mv;
+
 	*val2 =3D BD79703_DAC_BITS;
=20
 	return IIO_VAL_FRACTIONAL_LOG2;
@@ -88,16 +98,26 @@ static const struct iio_info bd79703_info =3D {
 };
=20
 #define BD79703_CHAN_ADDR(_chan, _addr) {			\
+	.type =3D IIO_VOLTAGE,					\
+	.indexed =3D 1,						\
+	.output =3D 1,						\
+	.channel =3D (_chan),					\
+	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |		\
+			      BIT(IIO_CHAN_INFO_SCALE),		\
+	.address =3D (_addr),					\
+}
+
+#define BD79703_CHAN(_chan) {					\
 	.type =3D IIO_VOLTAGE,					\
 	.indexed =3D 1,						\
 	.output =3D 1,						\
 	.channel =3D (_chan),					\
 	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),		\
 	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),	\
-	.address =3D (_addr),					\
+	.address =3D (_chan) + 1,					\
 }
=20
-#define BD79703_CHAN(_chan) BD79703_CHAN_ADDR((_chan), (_chan) + 1)
+#define BD79703_CHAN_VFS(_chan) BD79703_CHAN_ADDR((_chan), (_chan) + 1)
=20
 static const struct iio_chan_spec bd79700_channels[] =3D {
 	BD79703_CHAN(0),
@@ -115,6 +135,8 @@ static const struct iio_chan_spec bd79701_channels[] =
=3D {
  * and 3, but to the channels 0, 1, 4, 5. So the addressing used with SPI
  * accesses is 1, 2, 5 and 6 for them. Thus, they're not constant offset to
  * the channel number as with other IC variants.
+ *
+ * Furthermore, the BD79702 and BD79703 can have different scale for chann=
els.
  */
 static const struct iio_chan_spec bd79702_channels[] =3D {
 	BD79703_CHAN_ADDR(0, 1),
@@ -124,40 +146,40 @@ static const struct iio_chan_spec bd79702_channels[] =
=3D {
 };
=20
 static const struct iio_chan_spec bd79703_channels[] =3D {
-	BD79703_CHAN(0),
-	BD79703_CHAN(1),
-	BD79703_CHAN(2),
-	BD79703_CHAN(3),
-	BD79703_CHAN(4),
-	BD79703_CHAN(5),
+	BD79703_CHAN_VFS(0),
+	BD79703_CHAN_VFS(1),
+	BD79703_CHAN_VFS(2),
+	BD79703_CHAN_VFS(3),
+	BD79703_CHAN_VFS(4),
+	BD79703_CHAN_VFS(5),
 };
=20
 static const struct bd7970x_chip_data bd79700_chip_data =3D {
 	.name =3D "bd79700",
 	.channels =3D bd79700_channels,
 	.num_channels =3D ARRAY_SIZE(bd79700_channels),
-	.has_vfs =3D false,
+	.num_vfs_chan =3D 0,
 };
=20
 static const struct bd7970x_chip_data bd79701_chip_data =3D {
 	.name =3D "bd79701",
 	.channels =3D bd79701_channels,
 	.num_channels =3D ARRAY_SIZE(bd79701_channels),
-	.has_vfs =3D false,
+	.num_vfs_chan =3D 0,
 };
=20
 static const struct bd7970x_chip_data bd79702_chip_data =3D {
 	.name =3D "bd79702",
 	.channels =3D bd79702_channels,
 	.num_channels =3D ARRAY_SIZE(bd79702_channels),
-	.has_vfs =3D true,
+	.num_vfs_chan =3D 2,
 };
=20
 static const struct bd7970x_chip_data bd79703_chip_data =3D {
 	.name =3D "bd79703",
 	.channels =3D bd79703_channels,
 	.num_channels =3D ARRAY_SIZE(bd79703_channels),
-	.has_vfs =3D true,
+	.num_vfs_chan =3D 3,
 };
=20
 static int bd79703_probe(struct spi_device *spi)
@@ -184,23 +206,26 @@ static int bd79703_probe(struct spi_device *spi)
 				     "Failed to initialize Regmap\n");
=20
 	/*
-	 * BD79703 has a separate VFS pin, whereas the BD79700 and BD79701 use
-	 * VCC for their full-scale output voltage.
+	 * BD79702 and BD79703 have a separate VFS pin. On these ICs, the VFS
+	 * pin provides the full-scale output voltage for half of the channels,
+	 * and use VCC for the rest.
+	 * The BD79700 and BD79701 use VCC for their full-scale output voltage
+	 * for all of the channels.
 	 */
-	if (cd->has_vfs) {
-		ret =3D devm_regulator_get_enable(dev, "vcc");
-		if (ret)
-			return dev_err_probe(dev, ret, "Failed to enable VCC\n");
+	ret =3D devm_regulator_get_enable_read_voltage(dev, "vcc");
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to enable VCC\n");
+
+	data->vcc_mv =3D ret / 1000;
=20
+	if (cd->num_vfs_chan > 0) {
 		ret =3D devm_regulator_get_enable_read_voltage(dev, "vfs");
 		if (ret < 0)
 			return dev_err_probe(dev, ret, "Failed to get Vfs\n");
-	} else {
-		ret =3D devm_regulator_get_enable_read_voltage(dev, "vcc");
-		if (ret < 0)
-			return dev_err_probe(dev, ret, "Failed to get VCC\n");
+
+		data->vfs_mv =3D ret / 1000;
+		data->num_vfs_chan =3D cd->num_vfs_chan;
 	}
-	data->vfs =3D ret;
=20
 	idev->channels =3D cd->channels;
 	idev->num_channels =3D cd->num_channels;

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
--=20
2.56.1


--SBrO5oM791bhl63I
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmsIMrkACgkQeFA3/03a
ocWZGgf/WGMQfQcG+5sPffKQaUguCrZfa0xsJhGRcalXJZtit7Fji1rfUcdXARtc
WKta7FtrrRBunN4Fze9ZCl3gGDc1YvMUP3xdQP815mrpw41k/eE4krHa/6ZVbOug
qUOKl8NnVtJ+BS8DNAbIZbsZ4ow5E0XMbA4Hznt7M5eTDgtNrr83yX/mAKltpCPn
65EptkQEtzR+uspUuke7vLN7kByScNjn7dYwCDo02J2GdjssEQPJ5R1olv0b7S3z
YtubUZ1oBdo4+akdqpOuNjwPp5s/gB6HPbH77lF00hyGt1ARX7pQw1xDDV24GvTU
+/jYD87czL47JQ25hYBTFHjopKFnzw==
=GNsh
-----END PGP SIGNATURE-----

--SBrO5oM791bhl63I--
