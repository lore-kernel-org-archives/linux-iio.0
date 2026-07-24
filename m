Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0B421C16A;
	Fri, 24 Jul 2026 00:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784852710; cv=none; b=V4aezJROmNsCGu/GuEq0Qot2wutvfRl5BmKAQ4TjAyks13COkPAiJJAq7E0L9Mkot0ZRsEi4C/uZAMMcAvzBvOTDM0gS233Zwjv9LlkmjOnoLSb8GDhjDIm+75loVuxBvvnkNopa50RmYBSf0jWOLZAP6NGlZWR3BaJB1MrRStY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784852710; c=relaxed/simple;
	bh=+uSmUyNE5Mwph4Csfg3Wj6AXYPSbG5Ue2FUPzfO6hjM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FLZaAfk0NeB5H+6vXTOhGD9DLcE45nfjfv8CY9ns4ESD428djpJvvbBUtEUAxybeocuODr5l7WfhQ0VcGBJ7PUR0mHc8rRXnmyFrrgWU3fXl4WoIvHsZWvZwRweCSjBhJibIhpzDiD48QqdClTjp5ma1/GpMnbcfW5vcYUk1bR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFUKmD3x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFUKmD3x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D571F000E9;
	Fri, 24 Jul 2026 00:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784852709;
	bh=oq0ZDK1ZxeeMF8swvdYj4UKGN/R4xplxMYhulgskbxI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BFUKmD3xyJvEEPVVi1m9uZcQqw+U/t7moFxdROowaxBSmhv93mqOZIRimXXoyhW+s
	 3aXJ2h3kRW4eEkLDGSS9pTmcvl8xKOT/ukSCp5mZBLHySJyLVlvAq2UZjLttRD0doU
	 giW7kIe8y6f2Cfrf84z9j6gEE/q2VKRncoULnPGbXJel6grwepbOs3NqB0cWoBSnkn
	 mgGDPuNO3C54+XIin+apUwrTYVFHrWLg6nAHulwRjQ+tTm+1x6WVzTDziSRsscXyv2
	 seH5kf520YCUzpLaDIaQ1leQC/E6SwWiLnhIlhh+QA3Myn93+d3LQfqYCGi0ltCsMP
	 z0p9lmMBIoqSg==
Date: Fri, 24 Jul 2026 01:25:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chris
 Morgan <macromorgan@hotmail.com>, Luca Weiss <luca.weiss@fairphone.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: imu: inv_icm42600: add support for icm42630
Message-ID: <20260724012505.02029e51@jic23-huawei>
In-Reply-To: <BE1P281MB142628222E8A8A94CDBB5693CEC22@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
References: <20260720173411.82979-1-jorijnvdgraaf@catcrafts.net>
	<20260720173411.82979-3-jorijnvdgraaf@catcrafts.net>
	<BE1P281MB142628222E8A8A94CDBB5693CEC22@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Jul 2026 07:18:02 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> >
> >________________________________________
> >From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
> >Sent: Monday, July 20, 2026 19:34
> >To: Jonathan Cameron; Jean-Baptiste Maneyrol
> >Cc: Jorijn van der Graaf; David Lechner; Nuno S=C3=A1; Andy Shevchenko; =
Rob Herring; Krzysztof Kozlowski; Conor Dooley; Chris Morgan; Luca Weiss; l=
inux-iio@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.ker=
nel.org
> >Subject: [PATCH 2/2] iio: imu: inv_icm42600: add support for icm42630
> >
> >The TDK InvenSense ICM-42630 is a 6-axis IMU of the ICM-42600 family, fo=
und e.=E2=80=8Ag. in the Fairphone 6. It is register-compatible with its si=
blings (the existing driver works on it unmodified) and reports WHOAMI valu=
e 0x0C. The part appears to
> >ZjQcmQRYFpfptBannerStart
> >This Message Is From an External Sender
> >This message came from outside your organization.
> >
> >ZjQcmQRYFpfptBannerEnd
> >
> >The TDK InvenSense ICM-42630 is a 6-axis IMU of the ICM-42600 family,
> >found e.g. in the Fairphone 6. It is register-compatible with its
> >siblings (the existing driver works on it unmodified) and reports
> >WHOAMI value 0x0C.
> >
> >The part appears to be a mobile SKU and has no public datasheet: the
> >identity comes from the Fairphone 6 platform documentation and
> >schematics naming the part, and the WHOAMI value was read from the
> >hardware, whose bank 0 register defaults match the ICM-42600 family
> >layout.
> >
> >Add the chip id, WHOAMI value and I2C/SPI match entries, using the
> >family default configuration like the ICM-42631.
> >
> >Tested on the Fairphone 6 via a backport of this change to the
> >device's 7.1-based kernel (only the id-table style adjusted to that
> >base), on a bit-banged SPI bus with INT1 wired to the SoC: probe,
> >accelerometer, gyroscope and temperature raw reads, all full-scale
> >ranges, multiple sampling frequencies, and watermark-paced FIFO reads
> >through the INT1 interrupt.
> >
> >Assisted-by: Claude:claude-fable-5
> >Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>

Just one minor thing inline

> >diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/i=
io/imu/inv_icm42600/inv_icm42600_i2c.c
> >index 28552d2db91d..c413904c8680 100644
> >--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> >+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> >@@ -81,6 +81,7 @@ static const struct i2c_device_id inv_icm42600_id[] =
=3D {
> >        { .name =3D "icm42622", .driver_data =3D INV_CHIP_ICM42622 },
> >        { .name =3D "icm42688", .driver_data =3D INV_CHIP_ICM42688 },
> >        { .name =3D "icm42631", .driver_data =3D INV_CHIP_ICM42631 },
> >+       { .name =3D "icm42630", .driver_data =3D INV_CHIP_ICM42630 },
> >        { }
> > };
> > MODULE_DEVICE_TABLE(i2c, inv_icm42600_id);
> >@@ -107,6 +108,9 @@ static const struct of_device_id inv_icm42600_of_mat=
ches[] =3D {
> >        }, {
> >                .compatible =3D "invensense,icm42631",
> >                .data =3D (void *)INV_CHIP_ICM42631,
> >+       }, {
> >+               .compatible =3D "invensense,icm42630",
> >+               .data =3D (void *)INV_CHIP_ICM42630,
> >        },
> >        { }
> > };
> >diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/i=
io/imu/inv_icm42600/inv_icm42600_spi.c
> >index faf743bc6444..a1d12ce3bf87 100644
> >--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
> >+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
> >@@ -78,6 +78,7 @@ static const struct spi_device_id inv_icm42600_id[] =
=3D {
> >        { .name =3D "icm42622", .driver_data =3D INV_CHIP_ICM42622 },
> >        { .name =3D "icm42688", .driver_data =3D INV_CHIP_ICM42688 },
> >        { .name =3D "icm42631", .driver_data =3D INV_CHIP_ICM42631 },
> >+       { .name =3D "icm42630", .driver_data =3D INV_CHIP_ICM42630 },
> >        { }
> > };
> > MODULE_DEVICE_TABLE(spi, inv_icm42600_id);
> >@@ -104,6 +105,9 @@ static const struct of_device_id inv_icm42600_of_mat=
ches[] =3D {
> >        }, {
> >                .compatible =3D "invensense,icm42631",
> >                .data =3D (void *)INV_CHIP_ICM42631,
> >+       }, {
> >+               .compatible =3D "invensense,icm42630",
> >+               .data =3D (void *)INV_CHIP_ICM42630,
> >        },

Hmm. These tables should ideally be in numeric order.   That can be
a separate follow up patch though.   For this one can you just
put it before the 42631 here and wherever else that is relevant.

If you don't mind doing a precursor patch to reorder the entrees
then even better!

Thanks,

Jonathan

> >        { }
> > };
> >--
> >2.55.0
> > =20
>=20
> Hello Jorijn,
>=20
> it is OK for me, thanks for the patch.
>=20
> Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
>=20
> Thanks,
> JB
