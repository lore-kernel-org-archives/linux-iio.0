Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2621F39182A
	for <linux-iio@vger.kernel.org>; Wed,  4 Mar 2026 11:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772624876; cv=none; b=WVkZyvPZKQ/ZFw/0QS/FkgDt0u0FdS44CUojBeXXPYJUPDcmHXMJ+OM27sMrkibCYx087kfXs6KdeMWBtFq3q0Z/2D5E1HmnilHFfBXUuJwKJb3eeH6QDoIToojar83MDEffuGBAoOI+C3761ery/G65+85/69h8WwJxqiRHdNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772624876; c=relaxed/simple;
	bh=/R4eaBcrPWpSJC8OeQOy0GTZEIidjpvzldxcxjU2idw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P0qB+CChqMXP1ugaiqYxZnCtvl79kTZQXCeO7UzHdiV9Vx6KE3x+BVA70sDEAGVvjiBEcsV66wiG0bOgTLxhfmbdOID/MUCwDqzb1HIc2lDAnDoRDlPLfOBbL2GS/tDL3+pKkLxlfwgTR4XWNPzJcQDcm7jrnxbf907+ZD7OWIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNxxACgi; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNxxACgi"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439ac15f35fso3755750f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 04 Mar 2026 03:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772624873; x=1773229673; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CduAQzbmJX58L5AceBDqB7EH1l0pF29iMVDCaHBV8pk=;
        b=LNxxACgiNpyN1jEhDJkix3m9mJWIlpkr42EL1l+57EONc2GbzdOH084plUqRUOYjDQ
         t+L0oPWwamNC7/WykQr2kqiZit9A5Iavp2leYE0gFhcYf4iMD/1D1ReKlhDpQw4CnncO
         ZrhVKFAm9is/z6lcy9tDEXHUeCioWvTICo0qyyzzil3mUrmFiYt1wSYdNE0lBBWyRW1D
         Xcn6nHg/i7MVY5PxGHz91d2Y+yx+h9d9s85p1oA9B9XuzirSWWYHnKInGVC/NpwyFGqG
         Lh+WnihnkzDMi/B9W2//aivHRXwrlSo/kWe8aOPJ9usmJEmiFMvDfiqoLp61W8zkWtFL
         /DRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772624873; x=1773229673;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CduAQzbmJX58L5AceBDqB7EH1l0pF29iMVDCaHBV8pk=;
        b=FySanXH8msA8fnGZjxYP7v3XvOyRt6y1zKD66RfZtvU0Gim6sV8dtl0vaCot8jnjJ/
         IiZk/8MINWCjYRwcuwGT98g5uwx8ThVdOuQ9wgGGCRyiZ66dhaVTp+CQVKIk7E02ea0C
         /dY/AM4FL1Ce9eZYL+lIIpSLznEw2H/TaCm5Nhes+E7C4ukjbtYDQbkpMxLb3TNP2hF4
         hSXDBwN4a3cdhxTuruXK6lTodaC3A0DOyX1arz6iClnEVRCrB4E90UWkzAtulYtHsrbi
         2tqKkqufMwR9icuggsuM/3xECGamz6RFkREwXrV7Ls/uCZHo81iNx/Cz/3ob9r6Jptzl
         Fb8w==
X-Forwarded-Encrypted: i=1; AJvYcCUMXakPwr9EwU608MoRDK45k9nOrIaFsV6Nh9ZULRtylkpHFkKfnHj0yDI02qR1ZWYUz9Q3u0P6akQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmALTtjSbAKV6++UNdWEKKs7zbWofoZWJp2p5DL8O5YkSnwek5
	asVSnmJx0+AhQIXKQlVwqOaFU55gD75/pS3JA3KSPF0Id9guvAqbtbcP
X-Gm-Gg: ATEYQzwmdyAFW/o27qZUkI1vIM+auw8Ayt0OuedrsRs1SOm91MKWAdNEEzWyu/KGIaL
	HTSLskLyhpBQ+LQaZZ+u9zjHNY7lYiwq037eur2OpuIfC1/9kkBbmL/vxDcipHCPrAK4IHzHkCe
	r/GWbjvfQT07ZaNjWz5nSaFN94QP9zLT0a18CCAMZ7U4Ko74TlQZira+E3K6YYf4vEr5ZZAAX+x
	YY+YTjJg75FDVcGRisdAuZIusDWOREPa046z2XE5L8F3h36tQUZDFxieSiEdjKFynWxNvZJ/ZL4
	4WjVTIFD4vYZ03cGyTjzy6c1wHewLCCA8ZaJeGetA5JRwlFrhwGRS1iwVmTo/ny3KhpT/RfqUzU
	RZvbdm750JEoGjDpkVY6EtqqqqaZ0LrMFzHhsfyQdwm/5C98buHzqWcTFHmcWfUXmvXxObAUjNl
	13xUDbZzWPJojEk73pM1heKow32rkRz/k=
X-Received: by 2002:a05:6000:2381:b0:439:b3c5:ea20 with SMTP id ffacd0b85a97d-439c7f64c41mr3158399f8f.5.1772624873314;
        Wed, 04 Mar 2026 03:47:53 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439ac9f3e5bsm33109011f8f.37.2026.03.04.03.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 03:47:53 -0800 (PST)
Message-ID: <40d38cac145215e525c0fdc19f48634e9315467f.camel@gmail.com>
Subject: Re: [PATCH v3] iio: frequency: admv1013: fix NULL pointer
 dereference on str
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron
	 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 04 Mar 2026 11:48:37 +0000
In-Reply-To: <20260304095818.5459-1-antoniu.miclaus@analog.com>
References: <20260304095818.5459-1-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-03-04 at 11:58 +0200, Antoniu Miclaus wrote:
> When device_property_read_string() fails, str is left uninitialized
> but the code falls through to strcmp(str, ...), dereferencing a garbage
> pointer. Replace manual read/strcmp with
> device_property_match_property_string() which reads the property as a
> single string value and matches it against an array of known valid
> strings, handling the missing property case internally.
>=20
> Fixes: da35a7b526d9 ("iio: frequency: admv1013: add support for ADMV1013"=
)
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

One nit below but no need to re-spin just for that:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> Changes in v3:
> =C2=A0- add enum for quad SE mode indices to avoid magic numbers
> =C2=A0- use designated initializers for string arrays
> =C2=A0- replace switch with a lookup table for quad SE register values
>=20
> =C2=A0drivers/iio/frequency/admv1013.c | 55 +++++++++++++++++++----------=
---
> =C2=A01 file changed, 33 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/adm=
v1013.c
> index 9202443ef445..afdf06a0de43 100644
> --- a/drivers/iio/frequency/admv1013.c
> +++ b/drivers/iio/frequency/admv1013.c
> @@ -90,6 +90,12 @@ enum {
> =C2=A0	ADMV1013_SE_MODE_DIFF =3D 12
> =C2=A0};
> =C2=A0
> +enum {
> +	ADMV1013_QUAD_SE_DIFF,
> +	ADMV1013_QUAD_SE_POS,
> +	ADMV1013_QUAD_SE_NEG,
> +};
> +
> =C2=A0struct admv1013_state {
> =C2=A0	struct spi_device	*spi;
> =C2=A0	struct clk		*clkin;
> @@ -512,37 +518,42 @@ static void admv1013_powerdown(void *data)
> =C2=A0	admv1013_spi_update_bits(data, ADMV1013_REG_ENABLE, enable_reg_msk=
, enable_reg);
> =C2=A0}
> =C2=A0
> +static const char * const admv1013_input_modes[] =3D {
> +	[ADMV1013_IQ_MODE] =3D "iq",
> +	[ADMV1013_IF_MODE] =3D "if",
> +};
> +
> +static const char * const admv1013_quad_se_modes[] =3D {
> +	[ADMV1013_QUAD_SE_DIFF] =3D "diff",
> +	[ADMV1013_QUAD_SE_POS] =3D "se-pos",
> +	[ADMV1013_QUAD_SE_NEG] =3D "se-neg",
> +};
> +
> +static const unsigned int admv1013_quad_se_regvals[] =3D {
> +	[ADMV1013_QUAD_SE_DIFF] =3D ADMV1013_SE_MODE_DIFF,
> +	[ADMV1013_QUAD_SE_POS] =3D ADMV1013_SE_MODE_POS,
> +	[ADMV1013_QUAD_SE_NEG] =3D ADMV1013_SE_MODE_NEG,
> +};
> +
> =C2=A0static int admv1013_properties_parse(struct admv1013_state *st)
> =C2=A0{
> =C2=A0	int ret;
> -	const char *str;
> =C2=A0	struct device *dev =3D &st->spi->dev;
> =C2=A0
> =C2=A0	st->det_en =3D device_property_read_bool(dev, "adi,detector-enable=
");
> =C2=A0
> -	ret =3D device_property_read_string(dev, "adi,input-mode", &str);
> -	if (ret)
> -		st->input_mode =3D ADMV1013_IQ_MODE;
> +	ret =3D device_property_match_property_string(dev, "adi,input-mode",
> +						=C2=A0=C2=A0=C2=A0 admv1013_input_modes,
> +						=C2=A0=C2=A0=C2=A0 ARRAY_SIZE(admv1013_input_modes));
> +	st->input_mode =3D ret >=3D 0 ? ret : ADMV1013_IQ_MODE;
> =C2=A0
> -	if (!strcmp(str, "iq"))
> -		st->input_mode =3D ADMV1013_IQ_MODE;
> -	else if (!strcmp(str, "if"))
> -		st->input_mode =3D ADMV1013_IF_MODE;
> -	else
> -		return -EINVAL;
> +	ret =3D device_property_match_property_string(dev, "adi,quad-se-mode",
> +						=C2=A0=C2=A0=C2=A0 admv1013_quad_se_modes,
> +						=C2=A0=C2=A0=C2=A0 ARRAY_SIZE(admv1013_quad_se_modes));
> +	if (ret < 0)
> +		ret =3D ADMV1013_QUAD_SE_DIFF;
> =C2=A0
> -	ret =3D device_property_read_string(dev, "adi,quad-se-mode", &str);
> -	if (ret)
> -		st->quad_se_mode =3D ADMV1013_SE_MODE_DIFF;
> -
> -	if (!strcmp(str, "diff"))
> -		st->quad_se_mode =3D ADMV1013_SE_MODE_DIFF;
> -	else if (!strcmp(str, "se-pos"))
> -		st->quad_se_mode =3D ADMV1013_SE_MODE_POS;
> -	else if (!strcmp(str, "se-neg"))
> -		st->quad_se_mode =3D ADMV1013_SE_MODE_NEG;
> -	else
> -		return -EINVAL;
> +	st->quad_se_mode =3D admv1013_quad_se_regvals[ret];

You could have kept the same style:

st->quad_se_mode =3D ret >=3D 0 ? admv1013_quad_se_regvals[ret] : ADMV1013_=
SE_MODE_DIFF;

yes, more that 80 col but maybe one of those justifiable cases :)

- Nuno S=C3=A1


