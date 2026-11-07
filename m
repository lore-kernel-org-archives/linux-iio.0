Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794080606;
	b=M89dLkUmQSfdrG7jEbKPXaYLlj/FKRxnROvWj2oHVi/7dq6OFj1EWfCWSK9YXX3d7TE0
	 YvRVqOj3iFjLR2rAFIqgT3M3skui2cydZoy3a/nmeIGi0M6quU2LoOd+lCWevd9UNJltX
	 7+LKJ80Rwi5YlxkAj9pCqXMdzVE93bM4AZz/UqM4aPHxoCg1NPL1ZkWtn2xu9pUtxYGEN
	 HsJa13ZWDb+MPvAdwcBrO781UxLVfXkDcfVaoPhePErpPrrvhXEF9co7n9USu2kmog78Q
	 iVCvf/5AcP04ieg2wDMbX6Pd2s0fFrIrNhZjfveKTcLm5csfIG8R1JCRVJSM6EZ/V0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794080606;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=70SryVxENfXeYEbliXkZ/e1GSRjmFQ0gwBkP1nJXNKA=;
	b=WNi6wF38SfrZmb9oX1CL+TWayPIWuOha42A/KjG7KdVoKRnGMareX6sQ4grP9lGlKRNR
	 44HYTjMaSAcYFg6EOGp/26mWZfloJRN8ubbJtf4zKMAP1kIN39lE0ipNz0Cm9XsNJBR5a
	 SidnDAyPRPUIt4rsgmlyHJELa2EfmoGKx47/ckrnloKmiYGrFvkSE38w0RsjdTOcPEtOI
	 9hCLpsy1uhjk/rKgBSGzkExU83zsWhuRZzlqMmWUpF3u2htyeO+AlHsnC1J/m25cjBt4t
	 6e7Ssq+xk7/6EjtHTfDfNA3LVSnovv+oaQ6XkNl/BavATTdG991ATZWCZUbrXhoalPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K8cwM5JJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616FE606A32C;
	Sat,  7 Nov 2026 19:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K8cwM5JJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2ECE1F0089F;
	Sat,  7 Nov 2026 19:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794080606;
	bh=70SryVxENfXeYEbliXkZ/e1GSRjmFQ0gwBkP1nJXNKA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=K8cwM5JJhmQ0fbW1aJzdE8ksuLOQ/GOS9GDwLBcJDTesMhlxatf6HbutgM/IGrXYl
	 Q/rihEeyk4HOUeCEj/zIMna5zeID8vFcL1JWHNkaXAEKjC0ZtDLBfNjEeybtPHNsKF
	 KQL7ovXpDgjQuTk4mE6vzPZGzkpWGGyGiQ2GF/JrhGx/v2t0/UALOOimwVELS8GY5o
	 Xj5ZJ7mQ+fUIr4BoF6/IucvQQfhQPhPBEj+cEWuDpfYULqz/JdJKz02PpK30xt/xP3
	 69WOolOrE3tY8+XJezdgAmX5WyBNtWqI0JzBY55NiDl/CzHEKWa1ZjbkKYcI+xl08g
	 cSBe1a+mkEuMw==
Date: Sat, 7 Nov 2026 19:43:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Esben Haabendal <esben@geanix.com>, Kuppuswamy
 Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, "Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>, Pan Chuang <panchuang@vivo.com>, Hemanth
 Selam <hemanth.selam@gmail.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Nikita Travkin <nikita@trvn.ru>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: light: ltr501: Add support for the
 LTR-659PS-01 proximity sensor
Message-ID: <20261107194319.0645b31f@jic23-hlaptop>
In-Reply-To: <CAPVz0n10N6PvBC5AL=nT+fUGsONtuzTZvzSYqAXP_eWWb86nuQ@mail.gmail.com>
References: <20261106091943.35783-1-clamor95@gmail.com>
	<20261106091943.35783-5-clamor95@gmail.com>
	<20261107033340.64062192@jic23-hlaptop>
	<CAPVz0n10N6PvBC5AL=nT+fUGsONtuzTZvzSYqAXP_eWWb86nuQ@mail.gmail.com>
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

On Sat, 7 Nov 2026 12:15:07 +0200
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> =D1=81=D0=B1, 7 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 05:=
33 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Fri,  6 Nov 2026 11:19:43 +0200
> > Svyatoslav Ryhel <clamor95@gmail.com> wrote:
> > =20
> > > Add support for the Lite-On LTR-659PS-01 proximity sensor. This devic=
e is
> > > nearly identical to the LTR-559ALS-01, but omits all elements related=
 to
> > > ambient light sensing.
> > >
> > > Add a no_als_support flag, similar to how no_irq_support is used, to
> > > isolate ALS register access for the LTR-659PS-01, since ALS registers=
 are
> > > marked as reserved and interactions with them are discouraged.
> > >
> > > The ltr501_trigger_handler relied on the scan index to identify chann=
els.
> > > This approach is fragile regarding channel status flags and can break=
 if
> > > the index is not strictly set. Switch to checking the channel type
> > > instead.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  drivers/iio/light/ltr501.c | 73 +++++++++++++++++++++++++++++++-----=
--
> > >  1 file changed, 61 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> > > index d5ce6468a229b..e7762115df913 100644
> > > --- a/drivers/iio/light/ltr501.c
> > > +++ b/drivers/iio/light/ltr501.c
> > > @@ -151,6 +151,7 @@ struct ltr501_chip_info {
> > >       u8 als_gain_mask;
> > >       u8 als_gain_shift;
> > >       bool no_irq_support;
> > > +     bool no_als_support;
> > >       struct iio_chan_spec const *channels;
> > >       const int no_channels;
> > >  };
> > > @@ -192,6 +193,11 @@ static bool ltr501_has_irq_support(const struct =
ltr501_chip_info *info)
> > >       return !info->no_irq_support;
> > >  }
> > >
> > > +static bool ltr501_has_als_support(const struct ltr501_chip_info *in=
fo) =20
> >
> > Is the helper bring enough value?  The !info->no_als_support
> > where this is used seems clear enough to me.
> > =20
>=20
> Noted, if you are fine with !info->no_als_support I have no objections.
>=20
> > > +{
> > > +     return !info->no_als_support;
> > > +}
> > > +
> > >  static int ltr501_match_samp_freq(const struct ltr501_samp_table *ta=
b,
> > >                                          int len, int val, int val2)
> > >  {
> > > @@ -656,6 +662,29 @@ static const struct iio_chan_spec ltr301_channel=
s[] =3D {
> > >       IIO_CHAN_SOFT_TIMESTAMP(2),
> > >  };
> > >
> > > +static const struct iio_chan_spec ltr659_channels[] =3D {
> > > +     {
> > > +             .type =3D IIO_PROXIMITY,
> > > +             .address =3D LTR501_PS_DATA,
> > > +             .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > > +                                   BIT(IIO_CHAN_INFO_SCALE) |
> > > +                                   BIT(IIO_CHAN_INFO_SAMP_FREQ),
> > > +             .info_mask_separate_available =3D BIT(IIO_CHAN_INFO_SCA=
LE) |
> > > +                                             BIT(IIO_CHAN_INFO_SAMP_=
FREQ), =20
> >
> > The sampling frequency applies to both channels here. I'd just make that
> > info_mask_shared_by_all
> > =20
>=20
> so IIO_CHAN_INFO_SCALE is separate
> and IIO_CHAN_INFO_SAMP_FREQ is shared_by_all
>=20
> Noted.
>=20
Roughly speaking look at what is being described and consider what it appli=
es to.

Here the timestamp is grabbed for each single channel read, so sampling_fre=
quency
it applies to the timestamp as well as the channel.  There are messier corn=
ers
with sampling for devices with more channels where it would be per channel =
in
the case that they are sampled one by one.
That usually indicates the sampling frequency of a scan is 1/(1/sampA + 1/s=
ampB ...)
If the sampling of a scan is independent of channels enabled (because we re=
ad
them all anyway, parallel read out in the hardware or the sampling is clock=
ed at
a rate such that they all get sampled in less time than the inter sample fr=
equency
then sampling_frequency may still be shared_by_all.

The scale doesn't apply to the timestamp.  Now you only have one channel
so you could use shared_by_type, but for this I'd just go with most common
pattern for related drivers and separate is also a valid ABI choice.

Userspace should always cope with figuring out whether the broader scoped
parameters apply to a specific channel - so separate and shared_by_type
are equivalent when there is only one channel of the type.

Jonathan


>=20
> > > +             .scan_index =3D 0,
> > > +             .scan_type =3D {
> > > +                     .sign =3D 'u',
> > > +                     .realbits =3D 11,
> > > +                     .storagebits =3D 16,
> > > +                     .endianness =3D IIO_CPU,
> > > +             },
> > > +             .event_spec =3D ltr501_pxs_event_spec,
> > > +             .num_event_specs =3D ARRAY_SIZE(ltr501_pxs_event_spec),
> > > +             .ext_info =3D ltr501_ext_info,
> > > +     },
> > > +     IIO_CHAN_SOFT_TIMESTAMP(1),
> > > +}; =20
> > =20

