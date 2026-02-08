Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D965E33B6E8
	for <linux-iio@vger.kernel.org>; Sun,  8 Feb 2026 09:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770543373; cv=none; b=e1X5PvpDySabZ1lZ4T2GF+0jMrK0iyZdrX0ZlH3x3BoQuGMWnvzSS6l0HYAhVHyZXA+GjcWe4FP2LayeGNOphp8lvxr93jI1yJCvOVJvtkcEFEClSrEouJUbapnJGKni7G+evQyex+KM1+vUKdXD+OqKArL8wIwBeqCjk3OQ15Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770543373; c=relaxed/simple;
	bh=pE7CiEFSdb6v/uYQYBQ1kZRVHgJMUmJKY9hKT379fuw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gzJ7zKU7THYa1Rb8Sw6Pq/TPzIbH1JQrKiaghX/dyRgaq9DxgOz/ZT6xQCi2V9rxqkTxNco1BZUlLi+Vym1+vKKqHNpMaywD/paQsABiWWZvtcK4bTzE2JpY1oIqG0/Hc69VHMMB6WcgPh4+v5tCLt95AcadcXoOjB/nNWJxoms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmC9lTdX; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmC9lTdX"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4806e0f6b69so26485345e9.3
        for <linux-iio@vger.kernel.org>; Sun, 08 Feb 2026 01:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770543371; x=1771148171; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDjghK/iJ9nqQDNybxcg0smSRXSwudwROS1YKOK31/8=;
        b=MmC9lTdXVySKpVonzFQQURNoS7p/iL5KjjNmvcXuqFnYalpQ27abrQCRYsaS6i9P2u
         p/1c2ovPcBj3djpkr1rrw8pPY0xnDXleCVmevpeP7KiTzf26MuFWLbdVrEBDQJNvZZ//
         mrnpfGqAu8cRNXI5bf51l8bh2fPefYSfjAx5P2c/34Ukynbswk01Y3C57rw52x44N7lb
         gWAIbXU5veH7gO1oXKai6iAtvdrkVczA3A3nNyyGeLTDbutGdF+2Zpk/tmvxJPueOnRS
         RETPOsb1dGWPWgKpn/Idd3TzK+QgAEJ4Xjv+1fQjNL4NymkiqxERyDS65/I73dMiFr20
         l4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770543371; x=1771148171;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eDjghK/iJ9nqQDNybxcg0smSRXSwudwROS1YKOK31/8=;
        b=wd+pFwE+lxHK6MpISyltbYUq/3rTkKpYN5+bHyHnfPOHbmOKxuO3Xwlb3UGnHFGoSB
         gx8wRckQhgpRb81EkBydVeJ+n5xnQHK+rfbw/CyTdAHdjXKYlRle6Frsn9z8cKpMXLs7
         v/56FXl/Yid9AIQG7NHP57vw0mdi7Cwk57kTbz3gfWwaOPyvN6M9Hc86+5qqWBHsTIJP
         yvGkfNGkPLch6QVu/M1N3kGQSrDq43o80CbQqFuX1bGnGZDz+V3v483WFQhijTHRSsoJ
         U/esxtl76Ue1iJB20zn32DqTNPTOhmNnJOrIF0R5xMQgqyjXrO8ijhiWl73cT8XRQ7VS
         ddrg==
X-Forwarded-Encrypted: i=1; AJvYcCWrQVDyqo3WGqjjFHBjcf2YYkE7cuRhk9bfJIZQIqjQRLwBuol3TV3LGoZaMIJdw3DdBCjRZtRTK+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7ANcyDMX7Xv3hWJ9FcflGPyR6qOztS1Ijg7EMalvqoioA+cNk
	nsmnEslOra42TxjAkB/By4aUYpj2b5kDWCCsk9iKlUds+a63RG6DG6yD
X-Gm-Gg: AZuq6aLhjnuqqeB+G3+dFnuVdrkVZqatXmfKkihUjHL8mPsaxpe2hgw888GyIePGZUC
	87dsvlIdoze6GntvYCoxbupw7/ncyXy+Uh2QbQtiqIRbk2EZzFDTJz/AvDsMcU2C3lwaJgwfH2I
	C+IAMfucciYkwrL2JKWXfJ8mj8Yyl6f7YYY9x2GDhLRRk5rW9VV4YWQlVyC8BzrQ4K9FqHNvpBR
	jbwle+UFjrFlWD5nRAS4NSXPtbaDB1WMd4VpV+YTW2C3ezTRoj08XUd4JSUou+2cfb1Gns8+alf
	PR8p+fnJ4Z6QQ/e3o9quQpnOeTll/L26UdIEYeXqVkqaKNtqBqBR/XCqPM0trR2Bv4a0GlQKTp5
	noP7VGQQzAx1LReskDiVQDwPZ5fA8MCiJF5RTpl5Xg+lqAhZmZjNMmOIgF9kLQtrJD7WJueBSng
	62vMLuYeIZWuJb8lfjI4Bwg5DZnsKb152niBVOFsEOPIpGgrV/WTLbPJOEcC7s1A2B/F2JF/RYp
	lugX+G08g==
X-Received: by 2002:a05:600c:c4b8:b0:479:2a09:9262 with SMTP id 5b1f17b1804b1-483201dd20bmr106922795e9.9.1770543371209;
        Sun, 08 Feb 2026 01:36:11 -0800 (PST)
Received: from ?IPv6:2001:818:ea56:d000:94c4:fb0e:28f:2a8d? ([2001:818:ea56:d000:94c4:fb0e:28f:2a8d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483209af8e0sm103494245e9.5.2026.02.08.01.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 01:36:10 -0800 (PST)
Message-ID: <3baf38e130d84cd18a313439191597bdea1fca6e.camel@gmail.com>
Subject: Re: [PATCH 2/6] iio: adc: ad4080: add support for AD4082
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen	
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron	 <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring	 <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Sun, 08 Feb 2026 09:37:15 +0000
In-Reply-To: <51281e19fe2955cb10ffb77b62b0d7738e9b5a93.1770382796.git.antoniu.miclaus@analog.com>
References: <cover.1770382796.git.antoniu.miclaus@analog.com>
	 <51281e19fe2955cb10ffb77b62b0d7738e9b5a93.1770382796.git.antoniu.miclaus@analog.com>
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
> Add support for AD4082 20-bit SAR ADC. The AD4082 has the same
> resolution as AD4080 (20-bit) but differs in LVDS CNV clock count
> maximum (8 vs 7).
>=20
> Changes:
> - Add AD4082_CHIP_ID definition (0x0052)
> - Create ad4082_channel with 20-bit resolution and 32-bit storage
> - Add ad4082_chip_info with lvds_cnv_clk_cnt_max =3D 8
> - Register AD4082 in device ID and OF match tables
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

And same,

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad4080.c | 15 +++++++++++++++
> =C2=A01 file changed, 15 insertions(+)
>=20
> diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
> index 7cf3b6ed7940..7cbbe284dea7 100644
> --- a/drivers/iio/adc/ad4080.c
> +++ b/drivers/iio/adc/ad4080.c
> @@ -127,6 +127,7 @@
> =C2=A0#define AD4080_SPI_READ						BIT(7)
> =C2=A0#define AD4080_CHIP_ID						0x0050
> =C2=A0#define AD4081_CHIP_ID						0x0051
> +#define AD4082_CHIP_ID						0x0052
> =C2=A0#define AD4083_CHIP_ID						0x0053
> =C2=A0#define AD4084_CHIP_ID						0x0054
> =C2=A0#define AD4086_CHIP_ID						0x0056
> @@ -442,6 +443,8 @@ static const struct iio_chan_spec ad4080_channel =3D
> AD4080_CHANNEL_DEFINE(20, 32)
> =C2=A0
> =C2=A0static const struct iio_chan_spec ad4081_channel =3D AD4080_CHANNEL=
_DEFINE(20, 32);
> =C2=A0
> +static const struct iio_chan_spec ad4082_channel =3D AD4080_CHANNEL_DEFI=
NE(20, 32);
> +
> =C2=A0static const struct iio_chan_spec ad4083_channel =3D AD4080_CHANNEL=
_DEFINE(16, 16);
> =C2=A0
> =C2=A0static const struct iio_chan_spec ad4084_channel =3D AD4080_CHANNEL=
_DEFINE(16, 16);
> @@ -470,6 +473,16 @@ static const struct ad4080_chip_info ad4081_chip_inf=
o =3D {
> =C2=A0	.lvds_cnv_clk_cnt_max =3D 2,
> =C2=A0};
> =C2=A0
> +static const struct ad4080_chip_info ad4082_chip_info =3D {
> +	.name =3D "ad4082",
> +	.product_id =3D AD4082_CHIP_ID,
> +	.scale_table =3D ad4080_scale_table,
> +	.num_scales =3D ARRAY_SIZE(ad4080_scale_table),
> +	.num_channels =3D 1,
> +	.channels =3D &ad4082_channel,
> +	.lvds_cnv_clk_cnt_max =3D 8,
> +};
> +
> =C2=A0static const struct ad4080_chip_info ad4083_chip_info =3D {
> =C2=A0	.name =3D "ad4083",
> =C2=A0	.product_id =3D AD4083_CHIP_ID,
> @@ -666,6 +679,7 @@ static int ad4080_probe(struct spi_device *spi)
> =C2=A0static const struct spi_device_id ad4080_id[] =3D {
> =C2=A0	{ "ad4080", (kernel_ulong_t)&ad4080_chip_info },
> =C2=A0	{ "ad4081", (kernel_ulong_t)&ad4081_chip_info },
> +	{ "ad4082", (kernel_ulong_t)&ad4082_chip_info },
> =C2=A0	{ "ad4083", (kernel_ulong_t)&ad4083_chip_info },
> =C2=A0	{ "ad4084", (kernel_ulong_t)&ad4084_chip_info },
> =C2=A0	{ "ad4086", (kernel_ulong_t)&ad4086_chip_info },
> @@ -677,6 +691,7 @@ MODULE_DEVICE_TABLE(spi, ad4080_id);
> =C2=A0static const struct of_device_id ad4080_of_match[] =3D {
> =C2=A0	{ .compatible =3D "adi,ad4080", &ad4080_chip_info },
> =C2=A0	{ .compatible =3D "adi,ad4081", &ad4081_chip_info },
> +	{ .compatible =3D "adi,ad4082", &ad4082_chip_info },
> =C2=A0	{ .compatible =3D "adi,ad4083", &ad4083_chip_info },
> =C2=A0	{ .compatible =3D "adi,ad4084", &ad4084_chip_info },
> =C2=A0	{ .compatible =3D "adi,ad4086", &ad4086_chip_info },
