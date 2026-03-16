Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B803DEAF8;
	Mon, 16 Mar 2026 18:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773685886; cv=none; b=Ysy5HvlWTmmAoZuwQr+g2cXyE9Hnd40jjXupeqnkTAT+9JYW6W2A20IcFv8pgp9oqxuM+uEASIRgU8VKGxeNdwges9RMOMLykow9Fn3+aHWdZgP4TY1cE4KYVqRBh+RJX6zVNYFV5khNuenmcsSMGIuWtadf21v/dfcvUW//UnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773685886; c=relaxed/simple;
	bh=/341tmVA/vpTq4iA3KHxWy3dIVN8HL9NUtzjrYa2B9g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WZawGH9KuRiWGZkGEj+ODcINd0UX4VdC1jd+JGn0ya99XFs7mDGk/+GK86j8nI2SFEf0X7hezKFhHiVkiKrqDdE9HlaiXOyp3W9oOOoAbKRjrQJ1coqoy1AWzZVYVbH4mQt6K/KmVE7kbta6ceUL5+NLWssb3p17BXLmvWb01MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVJJM4Ib; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVJJM4Ib"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F31C19421;
	Mon, 16 Mar 2026 18:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773685885;
	bh=/341tmVA/vpTq4iA3KHxWy3dIVN8HL9NUtzjrYa2B9g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZVJJM4IbGffu4trVq1isJYCU8TdMCMY7r2VW59pT3w8bDuPmUJLr++K9bsfiOwpEM
	 WR1gqU/bI09hxvYkcOPOeW4YLm38t1LRn76MXcvnNPj+b5hwkFPz0VrVH4IMtikp0q
	 w6gkQc3U1neiXM4mojcEet4ixogI9nQOu1eEzgMX93j9VmFNYpP2cMteA3EOBj8OSS
	 ii+zQjPINrt8ZpcIqLry8nOgywuT63H38VPSADSJBW/PGAQpl+zb/K1jXD8XVwKNg0
	 Idb89JOLotC2o7T3AnUMn37w1uLd0TVo7FE63rUU6Tj9AvO5Ix+REcuFOe0Pr50oNl
	 Nt9g92qZR6hzg==
Date: Mon, 16 Mar 2026 18:31:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Matt Ranostay <mranostay@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ti-adc161s626: use DMA-safe memory for
 spi_read()
Message-ID: <20260316183117.4dde7386@jic23-huawei>
In-Reply-To: <20260314-iio-adc-ti-adc161s626-fix-scan-buf-v1-2-56243b11e87b@baylibre.com>
References: <20260314-iio-adc-ti-adc161s626-fix-scan-buf-v1-0-56243b11e87b@baylibre.com>
	<20260314-iio-adc-ti-adc161s626-fix-scan-buf-v1-2-56243b11e87b@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Mar 2026 18:13:32 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Add a DMA-safe buffer and use it for spi_read() instead of a stack
> memory. All SPI buffers must be DMA-safe.
> 
> Since we only need up to 3 bytes, we just use a u8[] instead of __be16
> and __be32 and change the conversion functions appropriately.
> 
> Fixes: 4d671b71beef ("iio: adc: ti-adc161s626: add support for TI 1-channel differential ADCs")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/iio/adc/ti-adc161s626.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-adc161s626.c b/drivers/iio/adc/ti-adc161s626.c
> index 1d427548e0b3..6416d6a7ada0 100644
> --- a/drivers/iio/adc/ti-adc161s626.c
> +++ b/drivers/iio/adc/ti-adc161s626.c
> @@ -70,6 +70,7 @@ struct ti_adc_data {
>  
>  	u8 read_size;
>  	u8 shift;
> +	u8 buf[3] __aligned(IIO_DMA_MINALIGN);
On this. There is new generic infrastructure for marking these.
https://elixir.bootlin.com/linux/v7.0-rc3/source/include/linux/dma-mapping.h#L720
https://lore.kernel.org/all/01ea88055ded4d70cac70ba557680fd5fa7d9ff5.1767601130.git.mst@redhat.com/

Would look like
	__dma_from_device_group_begin();
	u8 buf[3];
	__dma_from_device_group_end();

Do you think we should adopt them rather than doing our own thing?
Slowly though I don't want the noise of a mass conversion.

As normal, advantage of standard infrastructure is cutting down
in subsystem specific magic.

I 'think' result is the same (though it also forces the trailing padding if anything
comes after this and needs it).


>  };
>  
>  static int ti_adc_read_measurement(struct ti_adc_data *data,
> @@ -78,26 +79,20 @@ static int ti_adc_read_measurement(struct ti_adc_data *data,
>  	int ret;
>  
>  	switch (data->read_size) {
> -	case 2: {
> -		__be16 buf;
> -
> -		ret = spi_read(data->spi, (void *) &buf, 2);
> +	case 2:
> +		ret = spi_read(data->spi, data->buf, 2);
>  		if (ret)
>  			return ret;
>  
> -		*val = be16_to_cpu(buf);
> +		*val = get_unaligned_be16(data->buf);
>  		break;
> -	}
> -	case 3: {
> -		__be32 buf;
> -
> -		ret = spi_read(data->spi, (void *) &buf, 3);
> +	case 3:
> +		ret = spi_read(data->spi, data->buf, 3);
>  		if (ret)
>  			return ret;
>  
> -		*val = be32_to_cpu(buf) >> 8;
> +		*val = get_unaligned_be24(data->buf);
>  		break;
> -	}
>  	default:
>  		return -EINVAL;
>  	}
> 

