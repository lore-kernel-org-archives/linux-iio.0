Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FD6346769
	for <linux-iio@vger.kernel.org>; Sun,  8 Feb 2026 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770543350; cv=none; b=FbJGJbPjArDoy20AuzeoDBSRnz3cHgZlw2P3K8toCYmucX2eXsqyF2pY9Ejkvnq6bBuPhXWRCNd0Kn4ujxsMGg1E7TowSUJ7wjOE1nYK3b5bdS1VVCclB7g7AbRmWvKgyKv0PkB27TJQ7HScYEFBono0Ch+SEBzF3YMPVx/gsB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770543350; c=relaxed/simple;
	bh=WCHl5DemabpyhnLUWX76It/3sUfmDTuYSHpdsEv6jLQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IfRHGAWi1dvPwHN+NFy69h1mLffcnsf/pd8i8wAEpGLShg7lWMHgsBjdP2HKGaORMbpjDMZW7eCcT7y/qpiSFZNPvXLR6BqWP0QV7+vB8qAHwKt+VXIwRH27/kQqJLp/q+mWBS8kROUwgn0qTQ3wN6vxe0djhZnrjQSC27/QoHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOhci8oS; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOhci8oS"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47ee937ecf2so32595635e9.0
        for <linux-iio@vger.kernel.org>; Sun, 08 Feb 2026 01:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770543348; x=1771148148; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5iZc9RqfK4a3YMrmNhUt/9wGJJUw6bZ4CSVXQbmLO10=;
        b=IOhci8oSb5rEScOpVnzbokVP4gr3kaAptBYXlExtxnrG8eXPgWccftd5NJ1aGDE5hs
         ojGvvanUsuea7MN0r1vQ3D+5E8f6e8hWeflOqHXsNW3QyM6nUQRm+LOMKn5f3E8uCm7C
         2AncIYhI4jnggB7nYJloOKWXFukMZci21ppiEw6J2/mqv6ASgDydxQe7OlwaN+iG0Eel
         LbbLVoXIyVpzKHTia3ClCOusNefQW1rEU4vhPmlPL+pVdRbyOV24Efx+cnbeKEkYQHuN
         Fht0SpYMMg/FZchpCTbcLeaXVg2k6IW+EH8KRJGTehqzgnwmatKqH1XnbydP1s7bQQYn
         TigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770543348; x=1771148148;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5iZc9RqfK4a3YMrmNhUt/9wGJJUw6bZ4CSVXQbmLO10=;
        b=XzeQsoaJ7c69PZU53heJI7HPOw0RYWiVzWkzS8XKFulDKqap2CaBqS5hQiYoLk7tzL
         Ah7gLjiyclwpny97Ckevc7DrUeZ5sGPZDaC+P8+QIoy/+zKF2krfksZs+g2n5kUq7Ul5
         gsUMwUuVtBBLTrdSsbDXO0D96TZ8yN2VJXOlgYreqdUPU4KQEfpirfZRD3nFRV1yUE4O
         fnic2OC4iAtzBWxt8h5Tsf1X4s+log+nchhvjQEo8REsGlIehuP+1KFN41Tj1VVqm+hP
         HCRb2HoLB2qYab3Q7TlakkdqJsxq3idjSEEvP+FlKDAYRxYMgt/pOvp7d9eoojCNzy1t
         rBwg==
X-Forwarded-Encrypted: i=1; AJvYcCUUDN1xH9nAvs16z6wyerzI1K0u0AzLeOlVpIe/rEUtGdGXSTTq1r/QoXW37VXbM7pZ02zJRcu9deU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCHUMVtB4TjUKKyVsTopXlOst5RTgdFjajtgmF4rIzbrjzQLKr
	w+3QRhPWviXboPqucZu6XZavii3n63t9UvvUv8Rh76az+V7syo7NAW4I
X-Gm-Gg: AZuq6aKE7NXlwD9HF03ftNJ+Nsyv7bWhHqyQ0rQ8li9Dsx95J/wHsxB5LBLlY1dMNtg
	idEOT0jawqm6NHNcQAlSGd3Wme6NQEx2DWkjQIvJ3+1pxilO5DknSumPmHHYwx0u42u6JhgBKEw
	v92/Ec/0vplthyggvv5texXb1XWcye6Q90LXu5yeo1d2f+3gamQ4nmjfx+pUZqlRMHQZ5Iafe91
	xTdVKJBKO1BEw6VeZfOjFeCNvUoa5JlggnYHrQFyK/qUpI2FVMke/r4DSgoFxysUhauJtNXx051
	awx1InOo7Pm6bbTZED+MrUEgagagJ1/u6zaztKE+hxTl5muNxhjTc7UiSV7QYTnu/jb3tk4jCQs
	56W3NSqO/SUrx7h4O7NRR0CVsZySlkUlxpck4pxBp7bR7TPsKY70jmyVd00H97Cr4vRvuubEmXa
	n/YfSjnKChzdfTgfaYPjDh2k1/0SAXfIbnL0TQ/Ortmu6K//eWto2fZPzT+2JnetHEwyYODg==
X-Received: by 2002:a05:600c:3588:b0:481:a662:b3f3 with SMTP id 5b1f17b1804b1-483203ab7b0mr132212605e9.7.1770543348179;
        Sun, 08 Feb 2026 01:35:48 -0800 (PST)
Received: from ?IPv6:2001:818:ea56:d000:94c4:fb0e:28f:2a8d? ([2001:818:ea56:d000:94c4:fb0e:28f:2a8d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436297462a8sm16785577f8f.30.2026.02.08.01.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 01:35:47 -0800 (PST)
Message-ID: <c71d3ed0baffe4fc2d03a37d38aa3f03aeba7d6f.camel@gmail.com>
Subject: Re: [PATCH 6/6] iio: adc: ad4080: add support for AD4088
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen	
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron	 <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring	 <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Sun, 08 Feb 2026 09:36:52 +0000
In-Reply-To: <afcd7b733511ddf5e96d0b539fd3593edf3d8c45.1770382796.git.antoniu.miclaus@analog.com>
References: <cover.1770382796.git.antoniu.miclaus@analog.com>
	 <afcd7b733511ddf5e96d0b539fd3593edf3d8c45.1770382796.git.antoniu.miclaus@analog.com>
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
> Add support for AD4088 14-bit SAR ADC. The AD4088 has the same
> resolution as AD4087 (14-bit) but differs in LVDS CNV clock count
> maximum (8 vs 1).
>=20
> Changes:
> - Add AD4088_CHIP_ID definition (0x0058)
> - Create ad4088_channel with 14-bit resolution and 16-bit storage
> - Add ad4088_chip_info with lvds_cnv_clk_cnt_max =3D 8
> - Register AD4088 in device ID and OF match tables
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---

Same,

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad4080.c | 15 +++++++++++++++
> =C2=A01 file changed, 15 insertions(+)
>=20
> diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
> index 728df626f09e..fc261d3d7687 100644
> --- a/drivers/iio/adc/ad4080.c
> +++ b/drivers/iio/adc/ad4080.c
> @@ -133,6 +133,7 @@
> =C2=A0#define AD4085_CHIP_ID						0x0055
> =C2=A0#define AD4086_CHIP_ID						0x0056
> =C2=A0#define AD4087_CHIP_ID						0x0057
> +#define AD4088_CHIP_ID						0x0058
> =C2=A0
> =C2=A0#define AD4080_LVDS_CNV_CLK_CNT_MAX				7
> =C2=A0
> @@ -456,6 +457,8 @@ static const struct iio_chan_spec ad4086_channel =3D
> AD4080_CHANNEL_DEFINE(14, 16)
> =C2=A0
> =C2=A0static const struct iio_chan_spec ad4087_channel =3D AD4080_CHANNEL=
_DEFINE(14, 16);
> =C2=A0
> +static const struct iio_chan_spec ad4088_channel =3D AD4080_CHANNEL_DEFI=
NE(14, 16);
> +
> =C2=A0static const struct ad4080_chip_info ad4080_chip_info =3D {
> =C2=A0	.name =3D "ad4080",
> =C2=A0	.product_id =3D AD4080_CHIP_ID,
> @@ -536,6 +539,16 @@ static const struct ad4080_chip_info ad4087_chip_inf=
o =3D {
> =C2=A0	.lvds_cnv_clk_cnt_max =3D 1,
> =C2=A0};
> =C2=A0
> +static const struct ad4080_chip_info ad4088_chip_info =3D {
> +	.name =3D "ad4088",
> +	.product_id =3D AD4088_CHIP_ID,
> +	.scale_table =3D ad4080_scale_table,
> +	.num_scales =3D ARRAY_SIZE(ad4080_scale_table),
> +	.num_channels =3D 1,
> +	.channels =3D &ad4088_channel,
> +	.lvds_cnv_clk_cnt_max =3D 8,
> +};
> +
> =C2=A0static int ad4080_setup(struct iio_dev *indio_dev)
> =C2=A0{
> =C2=A0	struct ad4080_state *st =3D iio_priv(indio_dev);
> @@ -698,6 +711,7 @@ static const struct spi_device_id ad4080_id[] =3D {
> =C2=A0	{ "ad4085", (kernel_ulong_t)&ad4085_chip_info },
> =C2=A0	{ "ad4086", (kernel_ulong_t)&ad4086_chip_info },
> =C2=A0	{ "ad4087", (kernel_ulong_t)&ad4087_chip_info },
> +	{ "ad4088", (kernel_ulong_t)&ad4088_chip_info },
> =C2=A0	{ }
> =C2=A0};
> =C2=A0MODULE_DEVICE_TABLE(spi, ad4080_id);
> @@ -711,6 +725,7 @@ static const struct of_device_id ad4080_of_match[] =
=3D {
> =C2=A0	{ .compatible =3D "adi,ad4085", &ad4085_chip_info },
> =C2=A0	{ .compatible =3D "adi,ad4086", &ad4086_chip_info },
> =C2=A0	{ .compatible =3D "adi,ad4087", &ad4087_chip_info },
> +	{ .compatible =3D "adi,ad4088", &ad4088_chip_info },
> =C2=A0	{ }
> =C2=A0};
> =C2=A0MODULE_DEVICE_TABLE(of, ad4080_of_match);
