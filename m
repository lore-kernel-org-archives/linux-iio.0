Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BDC45BD7B
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 18:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777399634; cv=none; b=b6wM3Djb60GMx8OJGGLLFKNI2BXVYsH1o1EiuHFQe9S9R3R2jmi9L9xf5J8qJlvE9tYyNhsWODAQPWEoqLFTknOHrFL//kNuZu/w5otuYrjOd0+UhCumkH1nUoJrBwIMWo+CsAaspeMCvwGrDWDG016TYX7FLnyTkCMdyQte7lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777399634; c=relaxed/simple;
	bh=ghtsXt8115VJ4wu0mwTLHKDYTTv2vuq23Ck4+SJhiOE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fBCk9zl06uOOQKuSTHmvy+g4RNBxVdxV2Gg5pmNZmgaIcCRWgpjkGNYZIkuj7m3DhF29nfS4udlCMvbgbWnfZDRuHW5OX/aj9hj4Z4Qw6l05HKBkzTzgti3MXoVa9W9QGneU5T+FknXPZBtshhYQa1l56rncNpbB/8NMCeq3tL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qju50vmO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qju50vmO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43558C2BCAF;
	Tue, 28 Apr 2026 18:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777399634;
	bh=ghtsXt8115VJ4wu0mwTLHKDYTTv2vuq23Ck4+SJhiOE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qju50vmO0POcLMIVVpgsRj75OQ6LFnDdoBRDbzXifynHVubwJc54IFHgZQ+59rDTW
	 aM1NFBqIdWpwZxbDlKT8XNLFgZG4c5kJJGt1sh4f8mX35161eyeMI4+twm5QGhtcFM
	 XTcv0adVjPDwZ95SSvCK/UV6vZ3SSCMu35yLdNpK8j4mc/A7lMAXYWQCwwaaDa67ul
	 I4IxvDh/lcc2aV0fmAg4zRKLyt4IEXLZnMOoln/xFulENzEQ0FEmKdkEStNloIPEoW
	 +oiBDrQ358lpvaAVPRrCyg9y/P06CKjUN7PlZvF5+zHgW0db9RHjQhmHhXHPkyRyUM
	 XCk5eouJpTnKA==
Date: Tue, 28 Apr 2026 19:07:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Braga Lagrotaria de Oliveira <gabrielblo@ime.usp.br>
Cc: David Lechner <dlechner@baylibre.com>, javier.carrasco.cruz@gmail.com,
 nuno.sa@analog.com, andy@kernel.org, Ricardo H H Kojo
 <ricardo.kojo@ime.usp.br>, Ellian Carlos <elliancarlos@gmail.com>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: light: veml6030: Generalize hw_init for veml6030
 and veml6035
Message-ID: <20260428190704.6aa99621@jic23-huawei>
In-Reply-To: <CAOmGE-3_WYpL0AFpV-NcF=yZ2SBvUrSELuc=VXb=UVKGBbxnvw@mail.gmail.com>
References: <20260420201441.18055-1-gabrielblo@ime.usp.br>
	<26330121-79bd-4273-b8e4-17efa19454eb@baylibre.com>
	<CAOmGE-1108GJobu8nNc=WnV-+WFeW-LF2j0fQ+aMv9Ke27HOqw@mail.gmail.com>
	<CAOmGE-3_WYpL0AFpV-NcF=yZ2SBvUrSELuc=VXb=UVKGBbxnvw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Apr 2026 20:37:23 -0300
Gabriel Braga Lagrotaria de Oliveira <gabrielblo@ime.usp.br> wrote:

> Thank you for the feedback! We have one remaining question regarding the
> naming conventions: while adding the init_config pointer to the chip
> structure, we noticed the structure name itself (veml603x_chip) includes
> the 'x' wildcard. Should we rename this to a specific model or keep it
> as-is for the v2 submission?

Other than top posting, good question.

If it had a lot of instances I'd argue not worth the effort, but as there
are only 4, sure an extra patch to tidy that up would remove one more
case of wildcards people might copy in future.

Thanks

Jonathan

>=20
> Em seg., 27 de abr. de 2026 =C3=A0s 20:32, Gabriel Braga Lagrotaria de Ol=
iveira <
> gabrielblo@ime.usp.br> escreveu: =20
>=20
> > Thank you for the feedback! We have one remaining question regarding the
> > naming conventions: while adding the init_config pointer to the chip
> > structure, we noticed the structure name itself (veml603x_chip) includes
> > the 'x' wildcard. Should we rename this to a specific model or keep it
> > as-is for the v2 submission?
> >
> > Em seg., 20 de abr. de 2026 =C3=A0s 18:00, David Lechner <dlechner@bayl=
ibre.com>
> > escreveu:
> > =20
> >> On 4/20/26 3:14 PM, Gabriel Braga Lagrotaria wrote: =20
> >> > Add a new veml603x_hw_init() function to deduplicate the setup logic
> >> > for veml6030_hw_init() and veml6035_hw_init().
> >> >
> >> > Additionally, introduce struct veml603x_hw_init_config to store and
> >> > pass the custom configuration values specific to each device variati=
on.
> >> >
> >> > Signed-off-by: Gabriel Braga Lagrotaria <gabrielblo@ime.usp.br>
> >> > Co-developed-by: Ricardo H H Kojo <ricardo.kojo@ime.usp.br>
> >> > Signed-off-by: Ricardo H H Kojo <ricardo.kojo@ime.usp.br>
> >> > Co-developed-by: Ellian Carlos <elliancarlos@gmail.com>
> >> > Signed-off-by: Ellian Carlos <elliancarlos@gmail.com>
> >> > ---
> >> >  drivers/iio/light/veml6030.c | 98 +++++++++++++++------------------=
---
> >> >  1 file changed, 41 insertions(+), 57 deletions(-)
> >> >
> >> > diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml60=
30.c
> >> > index 6bcacae38..84a551683 100644
> >> > --- a/drivers/iio/light/veml6030.c
> >> > +++ b/drivers/iio/light/veml6030.c
> >> > @@ -963,19 +963,38 @@ static int veml6030_regfield_init(struct iio_d=
ev =20
> >> *indio_dev) =20
> >> >       return 0;
> >> >  }
> >> >
> >> > -/*
> >> > - * Set ALS gain to 1/8, integration time to 100 ms, PSM to mode 2,
> >> > - * persistence to 1 x integration time and the threshold
> >> > - * interrupt disabled by default. First shutdown the sensor,
> >> > - * update registers and then power on the sensor.
> >> > - */
> >> > -static int veml6030_hw_init(struct iio_dev *indio_dev, struct devic=
e =20
> >> *dev) =20
> >> > +struct veml603x_hw_init_config { =20
> >>
> >> Generally we try to avoid "x" wildcard in names as it is not particula=
rly
> >> future-proof. We can just use veml6030 since that is the driver name.
> >> =20
> >> > +     const struct iio_gain_sel_pair *gain_sel;
> >> > +     int gain_sel_size;
> >> > +     int gain_max_scale_int;
> >> > +     int gain_max_scale_nano;
> >> > +     unsigned int reg_als_conf_value;
> >> > +}; =20
> >>
> >> Would it make sense to add this to the chip info instead of creating
> >> new tables?
> >> =20
> >> > +
> >> > +static const struct veml603x_hw_init_config veml6030_hw_init_config=
 =3D {
> >> > +     .gain_sel =3D veml6030_gain_sel,
> >> > +     .gain_sel_size =3D ARRAY_SIZE(veml6030_gain_sel),
> >> > +     .gain_max_scale_int =3D 2,
> >> > +     .gain_max_scale_nano =3D 150400000,
> >> > +     .reg_als_conf_value =3D 0x1001,
> >> > +};
> >> > +
> >> > +static const struct veml603x_hw_init_config veml6035_hw_init_config=
 =3D {
> >> > +     .gain_sel =3D veml6035_gain_sel,
> >> > +     .gain_sel_size =3D ARRAY_SIZE(veml6035_gain_sel),
> >> > +     .gain_max_scale_int =3D 0,
> >> > +     .gain_max_scale_nano =3D 409600000,
> >> > +     .reg_als_conf_value =3D VEML6035_SENS | VEML6035_CHAN_EN | =20
> >> VEML6030_ALS_SD, =20
> >> > +};
> >> > + =20
> >>
> >> Or if we want to keep these to avoid duplication...
> >> =20
> >> > +static int veml603x_hw_init(struct iio_dev *indio_dev, struct devic=
e =20
> >> *dev, =20
> >> > +                         const struct veml603x_hw_init_config *cfg)
> >> >  {
> >> >       int ret, val;
> >> >       struct veml6030_data *data =3D iio_priv(indio_dev);
> >> >
> >> > -     ret =3D devm_iio_init_iio_gts(dev, 2, 150400000,
> >> > -                                 veml6030_gain_sel, =20
> >> ARRAY_SIZE(veml6030_gain_sel), =20
> >> > +     ret =3D devm_iio_init_iio_gts(dev, cfg->gain_max_scale_int, =20
> >> cfg->gain_max_scale_nano, =20
> >> > +                                 cfg->gain_sel, cfg->gain_sel_size,
> >> >                                   veml6030_it_sel, =20
> >> ARRAY_SIZE(veml6030_it_sel), =20
> >> >                                   &data->gts);
> >> >       if (ret)
> >> > @@ -985,7 +1004,7 @@ static int veml6030_hw_init(struct iio_dev =20
> >> *indio_dev, struct device *dev) =20
> >> >       if (ret)
> >> >               return dev_err_probe(dev, ret, "can't shutdown als\n");
> >> >
> >> > -     ret =3D regmap_write(data->regmap, VEML6030_REG_ALS_CONF, 0x10=
01);
> >> > +     ret =3D regmap_write(data->regmap, VEML6030_REG_ALS_CONF, =20
> >> cfg->reg_als_conf_value); =20
> >> >       if (ret)
> >> >               return dev_err_probe(dev, ret, "can't setup als =20
> >> configs\n"); =20
> >> >
> >> > @@ -1019,6 +1038,17 @@ static int veml6030_hw_init(struct iio_dev =20
> >> *indio_dev, struct device *dev) =20
> >> >       return ret;
> >> >  }
> >> >
> >> > +/*
> >> > + * Set ALS gain to 1/8, integration time to 100 ms, PSM to mode 2,
> >> > + * persistence to 1 x integration time and the threshold
> >> > + * interrupt disabled by default. First shutdown the sensor,
> >> > + * update registers and then power on the sensor.
> >> > + */
> >> > +static int veml6030_hw_init(struct iio_dev *indio_dev, struct devic=
e =20
> >> *dev) =20
> >> > +{
> >> > +     return veml603x_hw_init(indio_dev, dev, &veml6030_hw_init_conf=
ig);
> >> > +}
> >> > + =20
> >>
> >> ... then drop these wrapper functions and just put the pointer to the
> >> hw_init_config in the chip info.
> >> =20
> >> >  /*
> >> >   * Set ALS gain to 1/8, integration time to 100 ms, ALS and WHITE
> >> >   * channel enabled, ALS channel interrupt, PSM enabled, =20
> >>
> >> I think this comment and the one a bit above would mame more sense now
> >> on the hw_init_config structs since that is where the actual parameters
> >> are defined.
> >> =20
> >> > @@ -1028,53 +1058,7 @@ static int veml6030_hw_init(struct iio_dev =20
> >> *indio_dev, struct device *dev) =20
> >> >   */
> >> >  static int veml6035_hw_init(struct iio_dev *indio_dev, struct devic=
e =20
> >> *dev) =20
> >> >  { =20
> >>
> >> ...
> >> =20
> >> > +     return veml603x_hw_init(indio_dev, dev, &veml6035_hw_init_conf=
ig);
> >> >  }
> >> >
> >> >  static int veml6030_probe(struct i2c_client *client) =20
> >>
> >> =20

