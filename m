Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792724776;
	b=NjZDoxfjP6so8gNvn061jEYsp4GhqXmugD4tetKPd6Nff7RV+S7xnY+Q7L6nOtU5yIvg
	 4NU0C/cL2r2+KUacv66bQ4ki4fn3x5IysQjD3xOPPO3fnhr/hpcQVRhbaQ1Sq33Tbzow5
	 ZJ/PKIpys11G+wpJ1xfYoq8ZOI6v/BocJAbtK1/Jz9sSnvQvQEiSujDXFTLb8mJJYePwL
	 RHYll9flikDGXiVQgVUz17vfD7RhsNhT6bcbnzHFUAJk20dAaIor7yZt0Du+YkHBNElZS
	 mjapGeRhR9NgYAtVSzcYxKfKQ/omz8nAvdQxX6JeTMhn3KmmGrvxb8BHQB4boJWeB8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792724776;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=frwXj1z8hv8l/RpQIFEREFwbvpkIu3oS45o4hbxpnuk=;
	b=4w6DPKxp8AlFsBNCNtPsTnh57t100zyEW991ml+tdoV5zhOBqXKgcUimgGd5tEkDCGtq
	 JEGuf9uhpAhXS2KYfgHq6YzYJDojcraIqQeN1ipi8FUqRrc2SUxMP+scS7vRaM50ur23I
	 YSTsPlA5T1uctgWZvuMwQStES8zmfMqebyvMWn87lZRWf6jcX7cV4l3FRYU86nt3KywZT
	 qddeb73YyCkbCjlzVh7InTv5O2RmnmrPFPjax5yFmTzo36QrkoXyjtU998+V1H8bo7w1L
	 yvuQUYS2GwYT1BrhIl4K3cjxTbSiUatK5rHICHsy0Yt3v4HytSeawHSP6cb7fKcTQHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q9cBoyuM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859F2606A319;
	Fri, 23 Oct 2026 03:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q9cBoyuM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD64E1F01825;
	Fri, 23 Oct 2026 03:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792724776;
	bh=frwXj1z8hv8l/RpQIFEREFwbvpkIu3oS45o4hbxpnuk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Q9cBoyuMF/TmV/iMnSwiD1MEVhEQxn/l8qxVjf+aL66LinbL59PDvpvvYDasJ94UJ
	 /dVFxE6zXdW08H5TbpZN+xzn44R99XGh6RWQwYYh4q8XwcVeGCRQ4tNNqwszjk/2LW
	 snjEuZ/qCihF12VEzTKPgQYDuHkgC1sq1Q4r9LcxyGJvPBBEfEDOx4opYklBLqD7Tg
	 YEqtsQPr6QAHZilBUUJtLVxKIjX7JC02rffjmfB0iMSwiULU01ROHYAYDOxSJ87p2D
	 A28/h3Kmezyc+HJLLeLOMMzR4HASw6Q1LnFa7zm/KDWQKAzeGAxg8kL5VdwaEDvwB7
	 VxMkAVNF4MuzQ==
Date: Fri, 23 Oct 2026 04:06:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Victor Chernyakin <chernyakin.victor.j@outlook.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: add IIO_VAL_DECIMAL64_{ATTO,ZEPTO,YOCTO}
 formats
Message-ID: <20261023040607.400f8420@jic23-hlaptop>
In-Reply-To: <SN1PR12MB25287F63D68E82759D3A0FF5A5652@SN1PR12MB2528.namprd12.prod.outlook.com>
References: <SN1PR12MB25286BE4E1EA3B75F8E563A9A5652@SN1PR12MB2528.namprd12.prod.outlook.com>
	<SN1PR12MB25287F63D68E82759D3A0FF5A5652@SN1PR12MB2528.namprd12.prod.outlook.com>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Oct 2026 18:40:30 -0500
Victor Chernyakin <chernyakin.victor.j@outlook.com> wrote:

> The highest-precision format IIO has right now is IIO_VAL_DECIMAL64_FEMTO,
> which gives 15 decimal digits of precision after the decimal point. This
> is not enough for the upcoming TI FDC1004 driver, which needs 22 digits
> of precision to exactly express its scale value. This patch adds higher-
> precision formats, up to IIO_VAL_DECIMAL64_YOCTO (24 digits of precision).
> 
> Signed-off-by: Victor Chernyakin <chernyakin.victor.j@outlook.com>
Some discussion of whether these are perhaps overkill in the driver
patch given device precision doesn't seem to be nearly that good.
> ---
>  drivers/iio/industrialio-core.c | 6 ++++++
>  include/linux/iio/types.h       | 3 +++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 767a7794624a..008387efe96b 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -716,6 +716,9 @@ static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
>  	case IIO_VAL_DECIMAL64_NANO:
>  	case IIO_VAL_DECIMAL64_PICO:
>  	case IIO_VAL_DECIMAL64_FEMTO:

Seems we failed to update the test in drivers/iio/tests/iio-test-format.c for
FEMTO. Please add that and a similar test for your new units.

> +	case IIO_VAL_DECIMAL64_ATTO:
> +	case IIO_VAL_DECIMAL64_ZEPTO:
> +	case IIO_VAL_DECIMAL64_YOCTO:
>  	{
>  		int scale = type - IIO_VAL_DECIMAL64_BASE;
>  		s64 frac;
> @@ -1034,6 +1037,9 @@ static ssize_t iio_write_channel_info(struct device *dev,
>  		case IIO_VAL_DECIMAL64_NANO:
>  		case IIO_VAL_DECIMAL64_PICO:
>  		case IIO_VAL_DECIMAL64_FEMTO:
> +		case IIO_VAL_DECIMAL64_ATTO:
> +		case IIO_VAL_DECIMAL64_ZEPTO:
> +		case IIO_VAL_DECIMAL64_YOCTO:
>  			dec_scale = type - IIO_VAL_DECIMAL64_BASE;
>  			fallthrough;
>  		case IIO_VAL_INT_64:
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index d8944c9e5e90..2ef9b2a8b119 100644
> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -43,6 +43,9 @@ enum iio_event_info {
>  #define IIO_VAL_DECIMAL64_NANO		(IIO_VAL_DECIMAL64_BASE + 9)
>  #define IIO_VAL_DECIMAL64_PICO		(IIO_VAL_DECIMAL64_BASE + 12)
>  #define IIO_VAL_DECIMAL64_FEMTO		(IIO_VAL_DECIMAL64_BASE + 15)
> +#define IIO_VAL_DECIMAL64_ATTO		(IIO_VAL_DECIMAL64_BASE + 18)
> +#define IIO_VAL_DECIMAL64_ZEPTO		(IIO_VAL_DECIMAL64_BASE + 21)
> +#define IIO_VAL_DECIMAL64_YOCTO		(IIO_VAL_DECIMAL64_BASE + 24)
>  
>  static inline s64 iio_val_s64_compose(s32 val0, s32 val1)
>  {

