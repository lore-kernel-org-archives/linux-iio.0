Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922052F5491
	for <linux-iio@vger.kernel.org>; Sun,  8 Feb 2026 09:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770543324; cv=none; b=Z4P8fKnMSKE9Pie5tSH4oWUNGsNwJ5HvDtJ20S7qxHnU22v/uBjv80PsNhZgk61qon+huWhgHSmc44SLU9RizNJJah4jWzBjmIGjyL6KPenZinps5+uPiJWJ8/5Klf0QBMiNwJE8/GVuhb1qR7iPQC7AwWVeOM6dOnvWQzQfggs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770543324; c=relaxed/simple;
	bh=d9U6GwSQ/7vFpEejYgiYa8ahEc/yyszDZ1xLAcBPuj8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ub/4LVYhGKBibBpqW2AAmfjILhWxt1YujcUJ/QhgUoasOFC5wSOPrE98EZgGZ+ZbK21REpAD5oXfks5mkZ4ngf+eeaoEy/D4pyxOBZQiMqYv284j8qIDkoFzFrO35bTZDzivQifaflJQexZoXt4oflg5aQLO/LGHRr9HFtm9X/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9GeZYyB; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9GeZYyB"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4806e0f6b69so26483235e9.3
        for <linux-iio@vger.kernel.org>; Sun, 08 Feb 2026 01:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770543323; x=1771148123; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyYL76OcCTb3+tyPFMjf25Mn3aXA80ZOjq+Jte1NcP8=;
        b=A9GeZYyBKTDJ/DoRYtAS86f8NyZACVeA5fBF4yAIVP/BbxV8XLfQMZdaz4hx5oZ/NS
         dMHFWxuqHC5VPed1/CXP91bbC+kUnaIl507dpfMbrlxVQErZ1X8E+kv6niSOJOSN1rJt
         JN77CRlGmTZFlGpZoxzr3leIGNeHdtIpL6sosxAk1SKNPOj58Rg9qS+9Ztm+/0ahuqd4
         AHYhdieTKBp7v9IreVHL23zyNyqHgcHhkovVLMoAkUQpxdndtmf1pN19G6mMQ/L+/dCx
         aAfsp0RZsquXO/WL4T91vy8964FdSwcmE0jEDcS4wEpyLHemdwNhcNYPPb4FM/ZjP73h
         WCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770543323; x=1771148123;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pyYL76OcCTb3+tyPFMjf25Mn3aXA80ZOjq+Jte1NcP8=;
        b=N2MmLt3arWICZmZlvIclQqnv1Tz/mKn0MiAgvu3NctV7A0tssthZVrl1RsT/A0qSIJ
         BzY54YjGmGyAJ9+5v/XGpK5q+GXrFxzxmdWnfSqeVCDICQpT2TkT7ciSKWReoGFXky7p
         va/7Wk3nHmAMzRGuCMESj7MIDW+utnv5zDpuHgejSC6aBJEue8R7/WRB3G6HCC+dyam2
         m63hbZMlTQBhZFEMYmZuCB8y7IZts62djYf74rLUNDAlTj/TS1ooetsKzhllFKANYK21
         4rq2Qx7sfX1lJSGvZAONH50qKZ6O8JFKYDtaMelC0tSYQFw+ojvKf6dMpa+8e+RPEQIV
         q4iA==
X-Forwarded-Encrypted: i=1; AJvYcCW7CzMS//bPbJGkNwYZdGVYYxXCPJY9FHrJepImr3kwQAYYLAeHkw57He74cft2uVpQcb40jz8pdlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvZWRm0gwBJ657gukpKlxA4yCb6IgXPAXMTeGGCcTiIIQ3Ngdd
	AKPFPIXtIeRZmZwIntpoNZIoSThA1/JktbFl8U/sxt6omANWAdt2dw2q
X-Gm-Gg: AZuq6aLxL0l6vp9P16EkVcl7tn7X831MZF8rZVd0PNUv23jjKu604kshN4Wf+/hiPqS
	En2kjBDKKbR881gN79nAp6HiE+1hNxi66HBF0SH9zNif3T6KAlKw1+JIqKdZUS1yocvQVQJgW86
	KdJaENzEDY1vGpC88noJlOi5yGtiyT2a//OTTDns/V42Bp/BeBVSrQosBhS4oq8SqnBAXpvKLBi
	d94ySyJ7FOq+R9t7+T/pnqNTwDciIvmPYwKKapq9AzDYWHS0ax4JYde5kek53akfoYbQ9+UifGS
	ZE1rl64cr/MeWgxh7JEqi1PkJmT8vxPpfCJENL0SsFNCZsNbvELCxtbi4ABYeokolnFIsB8cUp9
	hhY2E2HHMkYdQDKr007/Z8vZ58mVOT9NSsJvza0SkpPoXIeKadR8LFNIO/FZ+1W7DUg3WWR6xEo
	niuuDnZIlSPzvWPUeidKNWNdthF5dnXs0BADjWEevz6j4xeS5+VNdbqdaFYl0=
X-Received: by 2002:a05:600c:81ca:b0:480:68ed:1e70 with SMTP id 5b1f17b1804b1-483202282c4mr131276045e9.35.1770543322861;
        Sun, 08 Feb 2026 01:35:22 -0800 (PST)
Received: from ?IPv6:2001:818:ea56:d000:94c4:fb0e:28f:2a8d? ([2001:818:ea56:d000:94c4:fb0e:28f:2a8d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483203f529bsm67359295e9.4.2026.02.08.01.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 01:35:22 -0800 (PST)
Message-ID: <8f0d63a6d2a4cfca52ea6c80595a2f1eda3713cf.camel@gmail.com>
Subject: Re: [PATCH 4/6] iio: adc: ad4080: add support for AD4085
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen	
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron	 <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring	 <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Sun, 08 Feb 2026 09:36:26 +0000
In-Reply-To: <587dbc9c21b49c7d99b6b5b8dad419fad415e040.1770382796.git.antoniu.miclaus@analog.com>
References: <cover.1770382796.git.antoniu.miclaus@analog.com>
	 <587dbc9c21b49c7d99b6b5b8dad419fad415e040.1770382796.git.antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-02-06 at 15:08 +0200, Antoniu Miclaus wrote:
> Add support for AD4085 16-bit SAR ADC. The AD4085 has the same
> resolution as AD4084 (16-bit) but differs in LVDS CNV clock count
> maximum (8 vs 2).
>=20
> Changes:
> - Add AD4085_CHIP_ID definition (0x0055)
> - Create ad4085_channel with 16-bit resolution and 16-bit storage
> - Add ad4085_chip_info with lvds_cnv_clk_cnt_max =3D 8
> - Register AD4085 in device ID and OF match tables
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
I do agree with Andy that the commit is too verbose. With that handled:

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad4080.c | 15 +++++++++++++++
> =C2=A01 file changed, 15 insertions(+)
>=20
> diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
> index 7cbbe284dea7..728df626f09e 100644
> --- a/drivers/iio/adc/ad4080.c
> +++ b/drivers/iio/adc/ad4080.c
> @@ -130,6 +130,7 @@
> =C2=A0#define AD4082_CHIP_ID						0x0052
> =C2=A0#define AD4083_CHIP_ID						0x0053
> =C2=A0#define AD4084_CHIP_ID						0x0054
> +#define AD4085_CHIP_ID						0x0055
> =C2=A0#define AD4086_CHIP_ID						0x0056
> =C2=A0#define AD4087_CHIP_ID						0x0057
> =C2=A0
> @@ -449,6 +450,8 @@ static const struct iio_chan_spec ad4083_channel =3D
> AD4080_CHANNEL_DEFINE(16, 16)
> =C2=A0
> =C2=A0static const struct iio_chan_spec ad4084_channel =3D AD4080_CHANNEL=
_DEFINE(16, 16);
> =C2=A0
> +static const struct iio_chan_spec ad4085_channel =3D AD4080_CHANNEL_DEFI=
NE(16, 16);
> +
> =C2=A0static const struct iio_chan_spec ad4086_channel =3D AD4080_CHANNEL=
_DEFINE(14, 16);
> =C2=A0
> =C2=A0static const struct iio_chan_spec ad4087_channel =3D AD4080_CHANNEL=
_DEFINE(14, 16);
> @@ -503,6 +506,16 @@ static const struct ad4080_chip_info ad4084_chip_inf=
o =3D {
> =C2=A0	.lvds_cnv_clk_cnt_max =3D 2,
> =C2=A0};
> =C2=A0
> +static const struct ad4080_chip_info ad4085_chip_info =3D {
> +	.name =3D "ad4085",
> +	.product_id =3D AD4085_CHIP_ID,
> +	.scale_table =3D ad4080_scale_table,
> +	.num_scales =3D ARRAY_SIZE(ad4080_scale_table),
> +	.num_channels =3D 1,
> +	.channels =3D &ad4085_channel,
> +	.lvds_cnv_clk_cnt_max =3D 8,
> +};
> +
> =C2=A0static const struct ad4080_chip_info ad4086_chip_info =3D {
> =C2=A0	.name =3D "ad4086",
> =C2=A0	.product_id =3D AD4086_CHIP_ID,
> @@ -682,6 +695,7 @@ static const struct spi_device_id ad4080_id[] =3D {
> =C2=A0	{ "ad4082", (kernel_ulong_t)&ad4082_chip_info },
> =C2=A0	{ "ad4083", (kernel_ulong_t)&ad4083_chip_info },
> =C2=A0	{ "ad4084", (kernel_ulong_t)&ad4084_chip_info },
> +	{ "ad4085", (kernel_ulong_t)&ad4085_chip_info },
> =C2=A0	{ "ad4086", (kernel_ulong_t)&ad4086_chip_info },
> =C2=A0	{ "ad4087", (kernel_ulong_t)&ad4087_chip_info },
> =C2=A0	{ }
> @@ -694,6 +708,7 @@ static const struct of_device_id ad4080_of_match[] =
=3D {
> =C2=A0	{ .compatible =3D "adi,ad4082", &ad4082_chip_info },
> =C2=A0	{ .compatible =3D "adi,ad4083", &ad4083_chip_info },
> =C2=A0	{ .compatible =3D "adi,ad4084", &ad4084_chip_info },
> +	{ .compatible =3D "adi,ad4085", &ad4085_chip_info },
> =C2=A0	{ .compatible =3D "adi,ad4086", &ad4086_chip_info },
> =C2=A0	{ .compatible =3D "adi,ad4087", &ad4087_chip_info },
> =C2=A0	{ }
