Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834BE3F23DB
	for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2026 12:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355043; cv=none; b=jk1j3QNixJUIB/MyHOOrAf3902j5aRbBHG3+Zl9hSCC6OrAuTcaJ8v39ESUDgc+bxV/UA/TWOR5m1luYOSaZJUMvoRIVy2gFh+V1q0jOL+BOCTUpe6c08ZLVTdg1Oym+Vq8jn080YacsUiyW88EukSWJZQ60P+Uf6+WPeQPSLqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355043; c=relaxed/simple;
	bh=lr6jiPIpLky0GuKyeChe9rFkYM2HR+DgUJmFtFLBbyI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cvgpv5ehXdCsJBCJUmBHcBeAIqR0RvMI2UgRDgDgXtWQ4zqaG2/MM+aQJ0w1OnFWgAfeT5TWHFYV4bIHuIQG/eF+RjNgZCho7UwADeyonJZbpEH7uE3LSa0i/Kw2t/QPulkPudkytCI57K+oHHZ3EyQQZ342lus8yplNlQLyoeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXjjklpR; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXjjklpR"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-486fe2024a9so30222625e9.0
        for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2026 05:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774355039; x=1774959839; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=81frdM2Oa48B98UOrUG3uZiR8G5c1Jk4OAiomv1LF0A=;
        b=mXjjklpRA+ZthGKi2L75ymV0GQVI1iSguAwp+krahpu5STQFwP5UHrt7fOxDGWloGg
         nyXynWXIwcdnrkyoO3bFw88K+QN06M1IBMpwO4VKVvEY9nEAqbZKRZv95yDQ8VR4CN4Z
         HDtGbMlsOkl8cJB9YxX9ErUhIgXdLJ+3ph60LiEB4qSVPNnEwWhaTct4f6S/JUeV7ahW
         1fN+6w4vQhhBZGP4W6t2yhXJwbx2sJOEoDe4Et7EYUPc4c2iqgysul5sT4wV/a3C5/Bo
         X9Tk2P0bay95Qi3UKKc575R5w8dnC6WlGAh4RVMiPy+DBQ9LbU9qbV+VlBa5bfKeeRWM
         u/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774355039; x=1774959839;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=81frdM2Oa48B98UOrUG3uZiR8G5c1Jk4OAiomv1LF0A=;
        b=sq1GrdqbfXYNmrVDVxoOOcDVtYqIxkiBMPO6Y8YCruLYR1LDpu2NnxQBoZxVxP5eyK
         mcBoJC6m9brvzkrBfwaFUM9g9nrNMc4M4xYaCgQMLSPiAH+LEsvhGLZB8rWxEX7ZLiRt
         EJoQj2gh9bwP6antFN3RmT3W4EudVsukwRVlNoGrOeQvaXyxaKNhoyH8DUu7A+BxZJuy
         3XhXn9UlnA3tzwTJHlLSnb50iDpawBpY9m6MignFu+izqMqgZaUN2H5dVAVcsfDzOIdR
         PhYNC5TyTD6TCXLH+TA7cGgKKR3n36GMQBq6NXqrdSqVRd74HakYFaYyhhivjqICikF0
         FtFw==
X-Forwarded-Encrypted: i=1; AJvYcCU5n3i0BYVcpmU20xsvN0FLJJ59XVljVKkhTEcbcwiU+hVLzPuR9+Xp3yMGW9UkvKVgAN9msl2X3Mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQHZACMzyhdrhy+gwGgJYzt2V9nrnI+o1OPTx7wlmmJke0WVTa
	rz/DlVOjzS0UhgTnfMvgbj3GzD22H0RPRCaZ/HdJxN4LC8MlwWVRMcQN
X-Gm-Gg: ATEYQzwCnx0EGLx7cnjMyz3Wd/wGsxdgdZTpdKVmN44Iv3MkWpAyFEASNsdCXMN5xQU
	7RvSdG8ao3yHROaDIUeJgfjQnb9t8Fsa/ayMF5wMxaM2MDYrb7fbGBw6NtDEpuY6WTIAy6fBQZS
	XMeBlxqsvlRu/INDeN0BRxCCfR42ZKOqZc9hz18m7eQtOf94P09JfGLnK5Nfp2cDc5jkqM+NFqJ
	Z8ysaJzR68IZ6GlFMEi4Qkmm5gp8oaRhZc1UjkHlNetYpx7lvUQBTxYLJNiIvX51e3tUzjMWjn7
	GCn7nI8rBT6BuyYVGG/cRbY04JYq3DBvlTVQ6sq1fJkku3JZyQlsRvovxaXYWUdrTQ8lDH0dYcj
	U6nw9lIqLQEIHXmDDCUtXkTC8kOPJOJ8gz4smdZ+CIdhBmZ23yWtDtITUIKhs5of4n63n7xhZOD
	GEEkXNTWxkDu0FYiEuYBYIDg5P6zFCozE=
X-Received: by 2002:a05:600c:c84:b0:480:1c69:9d36 with SMTP id 5b1f17b1804b1-486fee0d808mr230563355e9.17.1774355038309;
        Tue, 24 Mar 2026 05:23:58 -0700 (PDT)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871107b43esm17847145e9.21.2026.03.24.05.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 05:23:57 -0700 (PDT)
Message-ID: <5a610d89d307940e5e72644a83ca77cef6a65241.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: ti-ads8688: use read_avail for available
 attributes
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Gabriel Rondon <grondon@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, 
 Andy Shevchenko
	 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 24 Mar 2026 12:24:44 +0000
In-Reply-To: <b980b8ad92cf560021a8b428ed0134ca582895c8.camel@gmail.com>
References: <20260323215633.8140-1-grondon@gmail.com>
	 <b980b8ad92cf560021a8b428ed0134ca582895c8.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-03-24 at 11:42 +0000, Nuno S=C3=A1 wrote:
> On Mon, 2026-03-23 at 21:56 +0000, Gabriel Rondon wrote:
> > Convert the in_voltage_scale_available and in_voltage_offset_available
> > attributes from legacy IIO_DEVICE_ATTR with custom show functions to th=
e
> > IIO framework's read_avail callback. This uses the framework's built-in
> > support for _available attributes, removing the need for manual sysfs
> > formatting.
> >=20
> > Precompute the available scale values at probe time since they depend o=
n
> > the reference voltage which does not change after initialization.
> >=20
> > Signed-off-by: Gabriel Rondon <grondon@gmail.com>
> > ---
>=20
> Hi Grabriel,
>=20
> Thanks for your patch, just some minor nits from me. Anyways:
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> > =C2=A0drivers/iio/adc/ti-ads8688.c | 73 +++++++++++++++++++------------=
-----
> > =C2=A01 file changed, 38 insertions(+), 35 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.=
c
> > index b0bf46cae..f37098db9 100644
> > --- a/drivers/iio/adc/ti-ads8688.c
> > +++ b/drivers/iio/adc/ti-ads8688.c
> > @@ -6,7 +6,6 @@
> > =C2=A0#include <linux/device.h>
> > =C2=A0#include <linux/kernel.h>
> > =C2=A0#include <linux/slab.h>
> > -#include <linux/sysfs.h>
> > =C2=A0#include <linux/spi/spi.h>
> > =C2=A0#include <linux/regulator/consumer.h>
> > =C2=A0#include <linux/err.h>
> > @@ -17,7 +16,6 @@
> > =C2=A0#include <linux/iio/buffer.h>
> > =C2=A0#include <linux/iio/trigger_consumer.h>
> > =C2=A0#include <linux/iio/triggered_buffer.h>
> > -#include <linux/iio/sysfs.h>
> > =C2=A0
> > =C2=A0#define ADS8688_CMD_REG(x)		(x << 8)
> > =C2=A0#define ADS8688_CMD_REG_NOOP		0x00
> > @@ -66,6 +64,7 @@ struct ads8688_state {
> > =C2=A0	const struct ads8688_chip_info	*chip_info;
> > =C2=A0	struct spi_device		*spi;
> > =C2=A0	unsigned int			vref_mv;
> > +	int				scale_avail[3][2];
> > =C2=A0	enum ads8688_range		range[8];
> > =C2=A0	union {
> > =C2=A0		__be32 d32;
> > @@ -114,37 +113,9 @@ static const struct ads8688_ranges ads8688_range_d=
ef[5] =3D {
> > =C2=A0	}
> > =C2=A0};
> > =C2=A0
> > -static ssize_t ads8688_show_scales(struct device *dev,
> > -				=C2=A0=C2=A0 struct device_attribute *attr, char *buf)
> > -{
> > -	struct ads8688_state *st =3D iio_priv(dev_to_iio_dev(dev));
> > -
> > -	return sprintf(buf, "0.%09u 0.%09u 0.%09u\n",
> > -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ads8688_range_def[0].scale * st=
->vref_mv,
> > -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ads8688_range_def[1].scale * st=
->vref_mv,
> > -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ads8688_range_def[2].scale * st=
->vref_mv);
> > -}
> > -
> > -static ssize_t ads8688_show_offsets(struct device *dev,
> > -				=C2=A0=C2=A0=C2=A0 struct device_attribute *attr, char *buf)
> > -{
> > -	return sprintf(buf, "%d %d\n", ads8688_range_def[0].offset,
> > -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ads8688_range_def[3].offset);
> > -}
> > -
> > -static IIO_DEVICE_ATTR(in_voltage_scale_available, S_IRUGO,
> > -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ads8688_show_scales, NULL, 0);
> > -static IIO_DEVICE_ATTR(in_voltage_offset_available, S_IRUGO,
> > -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ads8688_show_offsets, NULL, 0);
> > -
> > -static struct attribute *ads8688_attributes[] =3D {
> > -	&iio_dev_attr_in_voltage_scale_available.dev_attr.attr,
> > -	&iio_dev_attr_in_voltage_offset_available.dev_attr.attr,
> > -	NULL,
> > -};
> > -
> > -static const struct attribute_group ads8688_attribute_group =3D {
> > -	.attrs =3D ads8688_attributes,
> > +static const int ads8688_offset_avail[] =3D {
> > +	-(1 << (ADS8688_REALBITS - 1)),
> > +	0,
> > =C2=A0};
> > =C2=A0
> > =C2=A0#define ADS8688_CHAN(index)					\
> > @@ -155,6 +126,9 @@ static const struct attribute_group ads8688_attribu=
te_group =3D {
> > =C2=A0	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW)		\
> > =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | BIT(IIO_CHAN_INFO_SCALE)	\
> > =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | BIT(IIO_CHAN_INFO_OFFSET),	\
> > +	.info_mask_shared_by_type_available =3D			\
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_SCALE)		\
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | BIT(IIO_CHAN_INFO_OFFSET),	\
> > =C2=A0	.scan_index =3D index,					\
> > =C2=A0	.scan_type =3D {						\
> > =C2=A0		.sign =3D 'u',					\
> > @@ -369,11 +343,34 @@ static int ads8688_write_raw_get_fmt(struct iio_d=
ev *indio_dev,
> > =C2=A0	return -EINVAL;
> > =C2=A0}
> > =C2=A0
> > +static int ads8688_read_avail(struct iio_dev *indio_dev,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const int **vals, int *type, int *le=
ngth,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 long mask)
> > +{
> > +	struct ads8688_state *st =3D iio_priv(indio_dev);
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_SCALE:
> > +		*vals =3D (const int *)st->scale_avail;
> > +		*type =3D IIO_VAL_INT_PLUS_NANO;
> > +		*length =3D ARRAY_SIZE(st->scale_avail) * 2;
> > +		return IIO_AVAIL_LIST;
> > +	case IIO_CHAN_INFO_OFFSET:
> > +		*vals =3D ads8688_offset_avail;
> > +		*type =3D IIO_VAL_INT;
> > +		*length =3D ARRAY_SIZE(ads8688_offset_avail);
> > +		return IIO_AVAIL_LIST;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > =C2=A0static const struct iio_info ads8688_info =3D {
> > =C2=A0	.read_raw =3D &ads8688_read_raw,
> > +	.read_avail =3D &ads8688_read_avail,
> > =C2=A0	.write_raw =3D &ads8688_write_raw,
> > =C2=A0	.write_raw_get_fmt =3D &ads8688_write_raw_get_fmt,
> > -	.attrs =3D &ads8688_attribute_group,
> > =C2=A0};
> > =C2=A0
> > =C2=A0static irqreturn_t ads8688_trigger_handler(int irq, void *p)
> > @@ -412,7 +409,7 @@ static int ads8688_probe(struct spi_device *spi)
> > =C2=A0{
> > =C2=A0	struct ads8688_state *st;
> > =C2=A0	struct iio_dev *indio_dev;
> > -	int ret;
> > +	int ret, i;
>=20
> These days you could just declare i in the for() loop and make it
> unsigned int.
>=20
> > =C2=A0
> > =C2=A0	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> > =C2=A0	if (indio_dev =3D=3D NULL)
> > @@ -426,6 +423,12 @@ static int ads8688_probe(struct spi_device *spi)
> > =C2=A0
> > =C2=A0	st->vref_mv =3D ret =3D=3D -ENODEV ? ADS8688_VREF_MV : ret / 100=
0;
> > =C2=A0
> > +	for (i =3D 0; i < ARRAY_SIZE(st->scale_avail); i++) {
> > +		st->scale_avail[i][0] =3D 0;
> > +		st->scale_avail[i][1] =3D ads8688_range_def[i].scale *
> > +					st->vref_mv;
> > +	}
>=20
> Even though the above crosses the column preferred limit, I don't think
> the line break hurts readability.=20

Naturally I meant that the line break __hurts__ (to me at least :))

- Nuno S=C3=A1
>=20
> - Nuno S=C3=A1
> >=20
