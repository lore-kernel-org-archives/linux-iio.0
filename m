Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153A726F293;
	Sun, 21 Jun 2026 12:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782046068; cv=none; b=tE/imTXWnwxNKDvaJjb9UeYCI7nAaVGRZP+l0WwXLqDCoxhkBtPmL4lksymuxqq8yrMXtv2PoEWQ/E5ndTP2ByNXGlk6xSOSjJFeTU7XzHZalRfyLLD4nBQFWyirjKuxee5jvMkxG1T0gA06+wM8qFLCiq1iZ6DpX/Zwfeyufe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782046068; c=relaxed/simple;
	bh=xX6rR5IkV4qgAh/2rE2ppsN5/yjeVQk0J/zyxciohQA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R4RuhSYc66gSqDnAWBDkUTtSJ9sm8a17H75RBwcFs0xG1WLdOZ6Jppai7wAZquty6H0rFQRibOlZaKIpBO757zLRzTrUJAy1K9SpXUmFtEVYDdZsbRGJVKzw44kBRd1IJXmVTZ0bpy0P95z6x81/fkQS8S2fnhro0klafp/rHqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6ullMil; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6ullMil"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E5A1F000E9;
	Sun, 21 Jun 2026 12:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782046066;
	bh=uLYSmQkwNX1AL5m58ySQye6fWdwjE8fomlk7NAMcq3I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=V6ullMilj94Z5x7l5LlRpdls6kDnzbJ2ySepMonwI5lo3K/bMP5IqWkRX/CvY0fe3
	 fSIGQE4guF7l+ddYxmwlrXTfOHLW0K9Mrq3Y/k9JHgoZHI9LPObAG9hNILjHqzIBNF
	 ZCYJxA03mYUPmjyY4woM4vEEf2Ej+tsZctfaLSQLIqTm2pXH7ZZo2d1WdQjy0XlM61
	 gFL8xzuVYl8i6Pjnzp4BYV1CKPtgzhpD3uf0gQzzL9/D5M4vl/HE1UdElxFEICMAhb
	 gQwCflFM6hsChEdAWh3bHLWNE9EIZZXq1znKu5lDt5LWNFVF/VKwhfmPpE7l5mnjdK
	 VcfO1kZ7IbzZA==
Date: Sun, 21 Jun 2026 13:47:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: radu.sabau@analog.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad_sigma_delta: allow COMPILE_TEST in
 isolation
Message-ID: <20260621134738.63df8aa2@jic23-huawei>
In-Reply-To: <aiaTVDWpKECtZPyz@nsa>
References: <20260608-ad_sigma_delta_spi-v1-1-61e37666d9b6@analog.com>
	<aiaTVDWpKECtZPyz@nsa>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Jun 2026 11:04:23 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, Jun 08, 2026 at 12:02:54PM +0300, Radu Sabau via B4 Relay wrote:
> > From: Radu Sabau <radu.sabau@analog.com>
> >=20
> > AD_SIGMA_DELTA is a hidden tristate that can only be enabled by
> > selecting drivers (AD7124, AD7192, etc.), all of which require SPI.
> > This prevents compile-testing the library code directly with allmodconf=
ig
> > or by manually enabling it with COMPILE_TEST.
> >=20
> > Add a prompt string guarded by "if COMPILE_TEST" so the symbol becomes
> > directly selectable when COMPILE_TEST is set.
> >=20
> > Also add an explicit "depends on SPI" since the ad_sigma_delta library
> > directly calls SPI core symbols such as spi_bus_lock(), spi_bus_unlock(=
),
> > and spi_sync_locked().
> >=20
> > Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> > --- =20
>=20
> LGTM,
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
I'm not sure I see a massive benefit in this but it's small and doesn't
affect most folk actually using IIO, so fair enough.
Applied.
>=20
> >  drivers/iio/adc/Kconfig | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index a9dedbb8eb46..329d1f6e5106 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -33,7 +33,8 @@ config AB8500_GPADC
> >  	  and USB voltages integral to the U8500 platform.
> > =20
> >  config AD_SIGMA_DELTA
> > -	tristate
> > +	tristate "Analog Devices Sigma-Delta Modulator support" if COMPILE_TE=
ST
> > +	depends on SPI
> >  	select IIO_BUFFER
> >  	select IIO_BUFFER_DMAENGINE
> >  	select IIO_TRIGGERED_BUFFER
> >=20
> > ---
> > base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
> > change-id: 20260608-ad_sigma_delta_spi-6063f200195b
> >=20
> > Best regards,
> > --=20
> > Radu Sabau <radu.sabau@analog.com>
> >=20
> >  =20
>=20

