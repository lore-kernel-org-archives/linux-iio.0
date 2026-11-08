Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794170667;
	b=5qA5uJjgtWMJCRhzHtWuCQ9ew8JNG98vAvKRqHcykXBbfmyqCJ3Ho7CuH/m55jWjQ4yP
	 wpARifzYKkA2cOZNkFYHAOV8f3YKiQnmHZprJic8s+qqTI8myy4FTI8HY32EeQQPuufKP
	 6tGakQ2XD0GSFJ2TNaq/PSHj3xytds9mXqgiQKkHxu8ChKNIkPE2uDfc8Q3P2s3UekNJ8
	 j/lx4KNMq8n10fHhOq/fv8bodERoePe9ZN6dsxQduSk0d6e+5xV2sTRnqqPSRyRzz2xQ+
	 K5ZnIaHhAlSLzVT9XjO6DSfRog5WZglum+pYD4pxSJc1gdyWxp/YOwSeeGTcNtlUacQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794170667;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=H2rLNM2YxPfbmqIEUQzYa/dvznwkMSgxJbv5QA7nOgY=;
	b=j3mlXKdvDT+zbmfpjBuT9ihLfBftQQiWdhLn4gb669+OgEKVajYHRQ9OVY2AD/jO6g9m
	 Zpvut5kCEKNoMDvhyszklyNLV+yMKT5cHNDay+nOlTNUaakxPiz9PYUbGhQqhqQS5OiAJ
	 DOjiw7Jj/PX/SMIGS0iYbpxQy1Gu5c+lsKSK+5uHlzGy34pMeXk5jJnyvKlXVVNrImXY4
	 kHYrT73EB6pPIwcTuGlg9Ehc3Od1ES7NR+StqDY1tRBlL3dgBFjB31Ej9SFprsNTw1HIG
	 m7atQU/NsRiVY9oS3yYrcLK8HlbiCRrFzBqMxbqLs0d57JQ4esOkbc7mfTNOC0AMBYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nx+o0NZL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96FA606A33B;
	Sun,  8 Nov 2026 20:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nx+o0NZL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF401F0089F;
	Sun,  8 Nov 2026 20:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794170666;
	bh=H2rLNM2YxPfbmqIEUQzYa/dvznwkMSgxJbv5QA7nOgY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Nx+o0NZLG1wyaUG6kQY55BLY6ck4yIuAVvp6ud2fOhB9yr+KeZSqiL9t9/IhACw5K
	 /XHnZ386gfNsw+WsHNfQ3zT6hTzukaq6WVYxYWoh2VT05dz01yfFUw52mVbknK4Ga1
	 GcEwE99NDTSIByv1qyKkeWsSPZhTQk6+SLxmuqaZsiD6s5bK0pRZjCXaRCuCgGXJmZ
	 OxSG8E58dDElDM1+1DMx9j1Mb2yLFLDxKU7ofNH/YbEYDaVJCQEbyxue50I0qnygxx
	 DxWz1qw6smqHLkNZMcfcxdViswmXf1uKMHRacRFxG0jeYxhnvdGZ2wsPUjYHAZTEnk
	 D3GOMdV/GT7lQ==
Date: Sun, 8 Nov 2026 20:44:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "DelaySystem@tubot.lat" <DelaySystem@tubot.lat>, Krzysztof Kozlowski
 <krzk@kernel.org>, "nuno.sa@analog.com" <nuno.sa@analog.com>,
 "dlechner@baylibre.com" <dlechner@baylibre.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
 "andy@kernel.org" <andy@kernel.org>, "linux-staging@lists.linux.dev"
 <linux-staging@lists.linux.dev>, "linux@analog.com" <linux@analog.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] staging: iio: adc: ad7816: use dev_err_probe() for GPIO
 lookups
Message-ID: <20261108204421.7737004b@jic23-hlaptop>
In-Reply-To: <CAHp75VdHOc13pp1901cxqCvJ3w0cAfZuvxXE_gJTBsJZs-s1eg@mail.gmail.com>
References: <20261107-batch1-s3-warn-v1-1-4fc38341ca38@tubot.lat>
	<CAHp75VdHOc13pp1901cxqCvJ3w0cAfZuvxXE_gJTBsJZs-s1eg@mail.gmail.com>
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

On Sun, 8 Nov 2026 12:09:29 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> =D0=BD=D0=B5=D0=B4=D1=96=D0=BB=D1=8F, 8 =D0=BB=D0=B8=D1=81=D1=82=D0=BE=D0=
=BF=D0=B0=D0=B4=D0=B0 2026=E2=80=AF=D1=80. DelaySystem via B4 Relay <
> devnull+DelaySystem.tubot.lat@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5: =20
>=20
> > From: DelaySystem <DelaySystem@tubot.lat>
> >
> > GPIO lookups can return -EPROBE_DEFER.  Convert the rdwr and convert
> > GPIO lookup failures in ad7816_probe() to dev_err_probe(), which
> > suppresses the error message on deferral and records the deferral
> > reason.  The busy-GPIO path is left untouched: its optionality is the
> > subject of a separate proposed change.
> >
> > No functional change other than defer handling.
> >
> > Signed-off-by: DelaySystem <DelaySystem@tubot.lat>
> > --- =20
>=20
>=20
>=20
> At least this bot doesn=E2=80=99t hide

True enough.  For the avoidance of doubt, I can't apply this as it
doesn't meet the requirement that the Sign off be using a well know
identity of a human who is certifying that they have read, understood
the code and that it meets all the other rules the DCO requires.

Thanks,

Jonathan

>=20
>=20
> >  drivers/staging/iio/adc/ad7816.c | 18 ++++++------------
> >  1 file changed, 6 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/
> > ad7816.c
> > index 2a15d7598abb..11292216dfb5 100644
> > --- a/drivers/staging/iio/adc/ad7816.c
> > +++ b/drivers/staging/iio/adc/ad7816.c
> > @@ -381,20 +381,14 @@ static int ad7816_probe(struct spi_device *spi_de=
v)
> >
> >         chip->id =3D spi_get_device_id(spi_dev)->driver_data;
> >         chip->rdwr_pin =3D devm_gpiod_get(&spi_dev->dev, "rdwr",
> > GPIOD_OUT_HIGH);
> > -       if (IS_ERR(chip->rdwr_pin)) {
> > -               ret =3D PTR_ERR(chip->rdwr_pin);
> > -               dev_err(&spi_dev->dev, "Failed to request rdwr GPIO: %d=
\n",
> > -                       ret);
> > -               return ret;
> > -       }
> > +       if (IS_ERR(chip->rdwr_pin))
> > +               return dev_err_probe(&spi_dev->dev,
> > PTR_ERR(chip->rdwr_pin),
> > +                                    "Failed to request rdwr GPIO\n");
> >         chip->convert_pin =3D devm_gpiod_get(&spi_dev->dev, "convert",
> >                                            GPIOD_OUT_HIGH);
> > -       if (IS_ERR(chip->convert_pin)) {
> > -               ret =3D PTR_ERR(chip->convert_pin);
> > -               dev_err(&spi_dev->dev, "Failed to request convert GPIO:
> > %d\n",
> > -                       ret);
> > -               return ret;
> > -       }
> > +       if (IS_ERR(chip->convert_pin))
> > +               return dev_err_probe(&spi_dev->dev,
> > PTR_ERR(chip->convert_pin),
> > +                                    "Failed to request convert GPIO\n"=
);
> >         if (chip->id =3D=3D ID_AD7816 || chip->id =3D=3D ID_AD7817) {
> >                 chip->busy_pin =3D devm_gpiod_get(&spi_dev->dev, "busy",
> >                                                 GPIOD_IN);
> >
> > ---
> > base-commit: fa4ad798f6f681031775266044ba1b0cf3c670bd
> > change-id: 20261107-batch1-s3-warn-289c98c7b118
> >
> > Best regards,
> > --
> > DelaySystem <DelaySystem@tubot.lat>
> >
> >
> > =20

