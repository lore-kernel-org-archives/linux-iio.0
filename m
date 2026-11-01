Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793499778;
	b=bW+VmHzRI6PJDJjRnvskiehCQzcj/iKAM8vpwMz7scSFKGD7EMHb8II6uV6EoTrNrE0H
	 hU1Fb3OUlbEAw/O7Ev5HRQNTE4p2jXlV6/N4ArYBvnudY3/c4Tt+ei6X7gpW8jXeLUWja
	 EuJTB+8C6YEtEkJlObKpPWVo4rpGwr36aN1Zvp/xGMVy/nNTs7Np1LwfrXYVotL1NBEVw
	 1anEk890voOYaXP9Q+Z25M6MeezUizRCppBys10r400lJBQpkT4MX1YeAHfxnrRhKifDg
	 N9DvsRmqkHu4BGweAmKYjQovCbEpKfUwrCcMtq+MIy+E46RVB4RXtGkgdUNHsPXvEAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793499778;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=s65N0D+hKvfL5wtXZVb2lwzTAXbSEa6hdapedc2qxmU=;
	b=tU9/eZi3ngGM6bD3qmjL9/4MVszjIC8PiFcC2BvjMlWmF36bk69UkYD6hAvtloLW272o
	 2X+YWGyn/EJq+sI4BG39GEEHeQiWNQaEpbZjmm+TA0NaYQWCiBen/nxm/308v0pyiP+Sl
	 9qVovnXC9mEk2GcMDbefAEyy71eI81jxUeJ/jlg2FRk74qbH8Cb6/IdazoDn6+XEkLW9f
	 vpoBgxoDfDLCJmX3WO8DUTnkLrTGNdIsxxGPkp21xeoCfAlzEiGi2l/eXlub+HMwJNd34
	 Hxc0DtRJWqUToJGJrLHdEESn/G9uENUCXv/oQyJMi6OKZdR5Uceog7Ic2aD+M9l9dqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="X/9LPMpK";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400CF606A324;
	Sun,  1 Nov 2026 02:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X/9LPMpK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C541F000C1;
	Sun,  1 Nov 2026 02:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793499777;
	bh=s65N0D+hKvfL5wtXZVb2lwzTAXbSEa6hdapedc2qxmU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=X/9LPMpKz2wIy63f9B0DGwku/g4cLSZMOu+sP653GtQY7SBS2RFxrUHnc/LvEZ0o/
	 1w0Q0El8ftUbH5S88qwS4tfzmV5+Ag1NSOygTTNJzI2jpi1d9yGMK/Jex4OocYeIFC
	 oueLbAo1YTLjdGaGOxcyafRveO75FeF96RP39fNdJ/heNlQtOWgnG9fNMFd42IwpPi
	 azHZ7QX8OmYMljdQN/xvAJtwmd4+NYc+6GlRozsAspDVYBtp6gOF9+LN7Wd5jLR7il
	 +Z9Kmpb/+AP+4hL1OANxOKzEED06MlbV+2AeQZfhCxEy7WMEftqYy11yLFjAWZgBVp
	 7T2V6xmx1m9HQ==
Date: Sun, 1 Nov 2026 02:22:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Josef Bacik
 <josef@toxicpanda.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable <stable@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Edmund Berenson <edmund.berenson@emlix.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 06/15] iio: adc: ad7923: add the AD7927 to the SPI ID
 table
Message-ID: <20261101022251.651228f3@jic23-hlaptop>
In-Reply-To: <auHBuXD-rgDoIzSu@nsa>
References: <20261027-llm-char-misc-iio-v1-0-0d818334f6c7@linuxfoundation.org>
	<20261027-llm-char-misc-iio-v1-6-0d818334f6c7@linuxfoundation.org>
	<auHBuXD-rgDoIzSu@nsa>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Oct 2026 09:35:52 +0000
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> On Tue, Oct 27, 2026 at 05:19:10PM +0100, Greg Kroah-Hartman wrote:
> > From: Josef Bacik <josef@toxicpanda.com>
> >=20
> > The binding describes the AD7927 as
> >=20
> >   compatible =3D "adi,ad7927", "adi,ad7928";
> >=20
> > The OF match takes the second string. The modalias of the SPI device is
> > made from the first one, "ad7927", which is not in the spi_device_id ta=
ble:
> > spi_get_device_id() returns NULL and ad7923_probe() dereferences it for
> > the chip information. The module is not loaded automatically either, as=
 the
> > uevent of an SPI device says "spi:ad7927".
> >=20
> > Add the name, with the data of the AD7928.
> >=20
> > Fixes: 1140f96cd4af ("dt-bindings: iio: adc: ad7923: adjust documentati=
on")
> > Cc: stable <stable@kernel.org>
> > Cc: "Nuno S=C3=A1" <nuno.sa@analog.com>
> > Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> > Cc: David Lechner <dlechner@baylibre.com>
> > Cc: Andy Shevchenko <andy@kernel.org>
> > Cc: Edmund Berenson <edmund.berenson@emlix.com>
> > Cc: Krzysztof Kozlowski <krzk@kernel.org>
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied to the fixes-togreg branch of iio.git.
Will rebase that on rc1 once available.

>=20
> >  drivers/iio/adc/ad7923.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
> > index 44e014da9722..69fafb4aa4ea 100644
> > --- a/drivers/iio/adc/ad7923.c
> > +++ b/drivers/iio/adc/ad7923.c
> > @@ -366,6 +366,7 @@ static const struct spi_device_id ad7923_id[] =3D {
> >  	{ .name =3D "ad7924", .driver_data =3D AD7924 },
> >  	{ .name =3D "ad7908", .driver_data =3D AD7908 },
> >  	{ .name =3D "ad7918", .driver_data =3D AD7918 },
> > +	{ .name =3D "ad7927", .driver_data =3D AD7928 },
> >  	{ .name =3D "ad7928", .driver_data =3D AD7928 },
> >  	{ }
> >  };
> >=20
> > --=20
> > 2.56.0
> >  =20

