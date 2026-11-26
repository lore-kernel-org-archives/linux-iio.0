Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795656935;
	b=C4ObEi9wBmbF7eZnYUa/b18fZlMdESn4EancmuXNZ3aa9WrnZ/CteoX4b/onx1z6j1tT
	 6pHS8MlIMw+E3VaQOStL3hP6KRl3IidflaarCdbQ8SgBZ2PbLyXHwG2ti2fe1hixOS0J6
	 WoC51qy/YO+dElPNtYlXoHwbgjYthfmz9l8pNwOpf0jC1kU1Tl2yKfnbXNLCuh/vDKta8
	 2xTP7rI4iOvGKycwV3XAXHvc0hr0fHpigWr13kMRbrbO6hveWKaSeeHEHy2S5ZO2/PfTr
	 /ChBVaeULgRrtjJf8XXZeOQa052oheqXSvkH7GAUeTh1nGXyZridsQ+td5TCvHKkU3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795656935;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=i+t3krcnrSYsZa5AgyFFMlylA+OGXI+XKMafwE7Z/Lg=;
	b=uxZgmG/KJjCfLMWohfZCeDo+iZnJ+dgPIKbNFFhzBxEQJyyvaNjfWnCnqMVtPG/H2g4J
	 EtIjlx0mV6xoIcXDU9Y5QC9hfLPfnIHv/n2lfuUCQo0SORnqYV3divbdfWoqYO8tN+Uun
	 f6H0LcJJGBX2rM/RCQuvXL1XtZUQMz6mVPw9eJWdBmLGObU2NZZd7TN7gY6BJ9ezTI71+
	 icSjcwQYkI7FpvGRGx+Q4EL6WTvMdM/4LVT4M34qvNeJt1W2pweTpvOZ6My268BuX0YdX
	 sA6GpZ9nWaJhpJO3/5RK4mbGxhcuhMostAlQYAMPeig50k4nJpfg854alOL1Kv/5eGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RY0qDRz9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F2F606A327;
	Thu, 26 Nov 2026 01:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RY0qDRz9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A371F000C0;
	Thu, 26 Nov 2026 01:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795656934;
	bh=i+t3krcnrSYsZa5AgyFFMlylA+OGXI+XKMafwE7Z/Lg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RY0qDRz92XwftN8jwUG1FGkMah/MuCM+qbBLbTir/QPXAqUMB2N91eHWfuKF0P5SP
	 GNZ5ltx/1uBdC8ZxWMMwp4svktXC8HnTW7/dDOjTSLnaCrqOTOJ+GRdokzoM96IdSN
	 JdnWomiPk1lu/TOTnEF5Ual1TvAMBppMghCXIvcb6tLDlPwMbvttn4Dc9HalkyXyqW
	 730+MDAJ40W/aWceh5T6SVaRbtH8YpX8AeRct+yM0pspWsvmwRITHDuBFVtUVevUzZ
	 8lYb0KKjMWcYlAHInTyXuo+iNe7vWYH45USpzWQv7xNRHFefS73atnRReqKZsL8Zsx
	 1gFxwXdX4yUig==
Date: Thu, 26 Nov 2026 01:35:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Ilia Snezhkov via B4 Relay <devnull+iasnezhkov.gmail.com@kernel.org>
Cc: iasnezhkov@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-iio@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: adc: mt6359: divide scale by ADC resolution
Message-ID: <20261126013527.15aa8cd6@jic23-hlaptop>
In-Reply-To: <20261126005326.71926-2-iasnezhkov@gmail.com>
References: <20261126005326.71926-1-iasnezhkov@gmail.com>
	<20261126005326.71926-2-iasnezhkov@gmail.com>
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

On Thu, 26 Nov 2026 00:53:27 +0000
Ilia Snezhkov via B4 Relay <devnull+iasnezhkov.gmail.com@kernel.org> wrote:

> From: Ilia Snezhkov <iasnezhkov@gmail.com>
> 
> mt6359_auxadc_read_raw() returns raw ADC counts for IIO_CHAN_INFO_RAW
> (12-bit or 15-bit depending on the channel), and returns only
> (r_ratio.numerator * vref_mV) / r_ratio.denominator for
> IIO_CHAN_INFO_SCALE without dividing by the ADC full-scale range
> (1 << chan->scan_type.realbits).
> 
> As a result, iio_read_channel_processed() and userspace consumers
> multiplying raw * scale obtain millivolt values that are 4096x (12-bit)
> or 32768x (15-bit) too large.
> 
> Include the 1 << chan->scan_type.realbits divisor in
> IIO_CHAN_INFO_SCALE: shift r_ratio.denominator left by realbits for
> IIO_VAL_FRACTIONAL when denominator > 1 (r_ratio.denominator is u8 and
> realbits is at most 15, so the result fits comfortably in int), and
> return IIO_VAL_FRACTIONAL_LOG2 with realbits otherwise so channels with
> denominator == 1 use an exact shift and unpopulated descriptors (such
> as MT6357 VDCXO where denominator == 0) cannot trigger division by zero.
> 
> Found and drafted with an AI coding assistant.

This details now belongs below the ---
The idea is we won't care much about that going forwards, so let us not
put it in the commit log.

> 
> Fixes: 3587914bf61d ("iio: adc: Add support for MediaTek MT6357/8/9 Auxiliary ADC")
> Signed-off-by: Ilia Snezhkov <iasnezhkov@gmail.com>
> ---
>  drivers/iio/adc/mt6359-auxadc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/mt6359-auxadc.c b/drivers/iio/adc/mt6359-auxadc.c
> index 88b0e26..54c9048 100644
> --- a/drivers/iio/adc/mt6359-auxadc.c
> +++ b/drivers/iio/adc/mt6359-auxadc.c
> @@ -772,11 +772,12 @@ static int mt6359_auxadc_read_raw(struct iio_dev *indio_dev,
>  		*val = desc->r_ratio.numerator * cinfo->vref_mV;
>  
>  		if (desc->r_ratio.denominator > 1) {
> -			*val2 = desc->r_ratio.denominator;
> +			*val2 = (int)desc->r_ratio.denominator << chan->scan_type.realbits;
>  			return IIO_VAL_FRACTIONAL;
>  		}
>  
> -		return IIO_VAL_INT;
> +		*val2 = chan->scan_type.realbits;
> +		return IIO_VAL_FRACTIONAL_LOG2;
>  	}
>  
>  	scoped_guard(mutex, &adc_dev->lock) {

