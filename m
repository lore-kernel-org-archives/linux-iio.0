Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800DD2D063A
	for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 09:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772098325; cv=none; b=V96yDc6eEQ51D1YpEOuQUAY7TM80ZlSEo/AESDzicO5IYoPZuAGcdgQ7P2QYvPvQwBJGQQ5CeC4D1sz13lq2EiIDLVz89NYYTwixNy/uv3sKs9G9eORmZhEiYWeBpmNjsCdO7h3ts4ddKexBlYV11Lb7PclQtJkopCu4Ct85mdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772098325; c=relaxed/simple;
	bh=VDoXj22Oqfb6AlLbLMDpWxYxX5vDi0/YRFdcwWhluRI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TRJDJMHzMHAdfu7xvyIEen7japOEp2aAnIZgu1BV5wZHTtzjlM/f3QiGP4T0T9JghG1vlWREQBf/tIO7bDkj6IfR0WKge6/oBVaNID+43SMMJXGwxTHNHPtihEhBbJMqvf1QE1N4KNF4yEBI/ZREgksU6/6fvHyM5VLD7aMiXvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxy2vN9b; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxy2vN9b"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4398c7083d7so552896f8f.3
        for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 01:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772098323; x=1772703123; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L81So1ONkp6t2Vs8xDqcWZCIsJZWaTlxD48UJI4eGtM=;
        b=cxy2vN9bs6o+hH37fk2V/kXPrRWjO+rmiNILPnVMC8xHHE7aIka8vAYyETeE/qln/q
         7sejwOevqEhFLcz0ly4VVnfyjzaa3Q18FCJ7ZLGAt2UigVma2BeYQrEXVekKL9s4eAj1
         U6TqPyQUX4w6y46daPHyh//yeTdVwz3mcntrx5jQ0RVy9vq3/MRXSbmxTnmRryOswf6U
         RntqyZFY47YRzz6MaWjvvo06zqczK3ozI6oQ6kKbPBPzBoi2Iccy0VEHzXbkFzfsYWsU
         k0fC5gVPvJtrH96zpq8G+fzPf8EwM1k5BLGYxOagGsedqLDjdJsxzdH3nKCTOlprpeda
         T5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772098323; x=1772703123;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L81So1ONkp6t2Vs8xDqcWZCIsJZWaTlxD48UJI4eGtM=;
        b=C3qX1RuE+WArBCD1Jx55e5Kbsq+hI67IlxhiUn9njMLi59BIN63N80XBwBfQZjZABe
         JJpgEul/oT2NtuD4Yi1QDkf1Y7ZJjZ14e0QQXCwL+fsj4Adfu0/DbGz4x8WKHdB9NHH6
         spnFiStTFOcRnycVptlzFEekpzy/tRqRrahHldhDcSou8I7pJxrYVqUx+NJsuG7xf45q
         Gg/AJ3X07gSrm49hTeW+J9L5pxv1kWFotkBZ4XoyjdAQLYE6Phz8orGJvF5uajQkfflm
         +taHIhupnASlHXV7+XuPjX8vb1RmK0ybK3y2CEFv8/sd80vSLWqKn6moUhkwDJeqS6R7
         eD7A==
X-Forwarded-Encrypted: i=1; AJvYcCV34YMs3jQaIwCsavZU3+nEjvY99ix2yfqMp+uhBriPNqxsnN+xK3gyOsI71dZRNsDLnviltadmGRI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1EFB5IAhdodE/BdXvHr2UEks4wLghAnMLBsK7nqC+Yqq9X8JC
	Pu6Ddt2gXOsdnMOlp3Y11j4V0blJ8dZyvmkz+6+sKwkCkof+qRlu7OGt
X-Gm-Gg: ATEYQzzYhPXO43Y5Xaha6m7bflUECYQQ4BU7M+aD0P1+Cs+f0Tih0qOFAuVGLWd0ItL
	0gbMUrY3bRKVr0IIA32zXrF52wpfY0jDmcvxMhRUrx3J3sS78Wl13unO4m9ZZGs9K6W0EyTny4T
	9aZ84xJDXOCi96SbJo2hOJcB3KqDfmVkLDIy73IKFjFUdru1QxT9PrYW7Vpomne1doadJ6BXFef
	QdTcn/ma+XQTDjtyh9BoTYBFWXb9fIvPSsq4FE6UrIzgKC9WcYZn+cne0kshTV8/qyNaJd6VkN+
	+vWSo1rgQBpitTLCpDgCbAyAWZ2N/iBGG8Izd9wKnYAH5ynldEC2P0qjA3GeFF6qXU5HSmkgxy+
	8NhEroRBL1fNEAiu1dCcPm+OqGOJ2fwuS6gvbbN7zKVqJrz8cUlp4S60RVShhVWfXkFHWDNC05G
	33hvYBUdQ18gMu45ASU8S5PrULK7uaOx4=
X-Received: by 2002:a05:6000:144c:b0:437:7268:8e1e with SMTP id ffacd0b85a97d-43997f4145emr2841521f8f.51.1772098322654;
        Thu, 26 Feb 2026 01:32:02 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4398a09aad0sm15400640f8f.2.2026.02.26.01.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 01:32:02 -0800 (PST)
Message-ID: <446c20d78f9e990a90bf9d75ee82d056be6bfca8.camel@gmail.com>
Subject: Re: [PATCH RFC] iio: adc: ad4030: fix calibscale read/write unit
 mismatch
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Marcelo Schmitt
	 <marcelo.schmitt1@gmail.com>, Giorgi Tchankvetadze
	 <giorgitchankvetadze1997@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, 	jic23@kernel.org, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Thu, 26 Feb 2026 09:32:45 +0000
In-Reply-To: <436cefe2-2ccb-41f6-89ec-921e234dfa32@baylibre.com>
References: <20260225113102.84568-2-giorgitchankvetadze1997@gmail.com>
	 <aZ7iyJ2CdNB3L6ON@debian-BULLSEYE-live-builder-AMD64>
	 <436cefe2-2ccb-41f6-89ec-921e234dfa32@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-02-25 at 09:20 -0600, David Lechner wrote:
> On 2/25/26 5:53 AM, Marcelo Schmitt wrote:
> > On 02/25, Giorgi Tchankvetadze wrote:
> > > The read path returns calibscale in IIO_VAL_INT_PLUS_NANO but the wri=
te
> > > path treats it as MICRO. Since no write_raw_get_fmt is provided, the
> > > IIO core defaults to MICRO when parsing userspace input.
> > >=20
> > > This means reading calibscale and writing it back results in a ~1000x
> > > gain error.
> > >=20
> > > Change the read path and available range to use MICRO to match the
> > > write path.
> >=20
> > The updates to ad4030 driver will add write_raw_get_fmt() [1].
> > [1]:
> > https://lore.kernel.org/linux-iio/516cccc47e917bd26be29b016907f50a244a6=
8b9.1771865684.git.marcelo.schmitt@analog.com/
> >=20
> > At first glance, I think this could instead add a case to write_raw_get=
_fmt(),
> > keeping calibscale nano precision (unless nano precision doesn't make s=
ense
> > for ad4030 calibscale (don't recall from top of my mind)).
>=20
> Since this is a fix and needs to be backported, it probably make sense
> to not depend on a patch that is adding new features.
>=20

+1

- Nuno S=C3=A1

> I'm sure Jonathan will have an opinion about how he would like to handle
> a conflict between the fixes and testing branches though.
>=20
> >=20
> > >=20
> > > Fixes: 0cb8b324852f ("iio: adc: ad4030: add driver for ad4030-24")
> > > Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.co=
m>
> > > ---
> > > =C2=A0drivers/iio/adc/ad4030.c | 10 +++++-----
> > > =C2=A01 file changed, 5 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> > > index def3e1d01ceb..3d823648371d 100644
> > > --- a/drivers/iio/adc/ad4030.c
> > > +++ b/drivers/iio/adc/ad4030.c
> > > @@ -423,10 +423,10 @@ static int ad4030_get_chan_calibscale(struct ii=
o_dev *indio_dev,
> > > =C2=A0
> > > =C2=A0	/* From datasheet: multiplied output =3D input =C3=97 gain wor=
d/0x8000 */
> > > =C2=A0	*val =3D gain / AD4030_GAIN_MIDLE_POINT;
> > > -	*val2 =3D mul_u64_u32_div(gain % AD4030_GAIN_MIDLE_POINT, NANO,
> > > +	*val2 =3D mul_u64_u32_div(gain % AD4030_GAIN_MIDLE_POINT, MICRO,
> > > =C2=A0				AD4030_GAIN_MIDLE_POINT);
> > > =C2=A0
> > > -	return IIO_VAL_INT_PLUS_NANO;
> > > +	return IIO_VAL_INT_PLUS_MICRO;
> > > =C2=A0}
> > > =C2=A0
> > > =C2=A0/* Returns the offset where 1 LSB =3D (VREF/2^precision_bits - =
1)/gain */
> > > @@ -720,8 +720,8 @@ static irqreturn_t ad4030_trigger_handler(int irq=
, void *p)
> > > =C2=A0
> > > =C2=A0static const int ad4030_gain_avail[3][2] =3D {
> > > =C2=A0	{ 0, 0 },
> > > -	{ 0, 30518 },
> > > -	{ 1, 999969482 },
> > > +	{ 0, 30 },
> > > +	{ 1, 999969 },
>=20
> This loses precision. Instead I would change the write to IIO_VAL_INT_PLU=
S_NANO
> to match the read.
>=20
> > > =C2=A0};
> > > =C2=A0
> > > =C2=A0static int ad4030_read_avail(struct iio_dev *indio_dev,
> > > @@ -739,7 +739,7 @@ static int ad4030_read_avail(struct iio_dev *indi=
o_dev,
> > > =C2=A0
> > > =C2=A0	case IIO_CHAN_INFO_CALIBSCALE:
> > > =C2=A0		*vals =3D (void *)ad4030_gain_avail;
> > > -		*type =3D IIO_VAL_INT_PLUS_NANO;
> > > +		*type =3D IIO_VAL_INT_PLUS_MICRO;
> > > =C2=A0		return IIO_AVAIL_RANGE;
> > > =C2=A0
> > > =C2=A0	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> > > --=20
> > > 2.52.0
> > >=20
> > >=20
