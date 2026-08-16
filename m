Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C4837F8C4;
	Sun, 16 Aug 2026 21:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786916075; cv=none; b=Sr0FDzgJOfm+DgdU9uOSldDs3qBk4EfWG+6VgZnNugYnuoG7H8r++4x/dftTU8rE2sHSsd0zU9alq1HVEXW/yHilIFJBKoFrV3CfQnOK18+j/WVOKjQcasXCcwwM+Sxq9PXQNbVYeUcyauwOZCzsjjVhAaowPaPu5FD5TFSchFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786916075; c=relaxed/simple;
	bh=seiMpe9VE8n0i/uwUuiZVELiVonOtL02DYSK9LXbgG8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ffcn0azPhV51xfiwNwBgHM+2Jm2x9zALxv0JmWrVZAtQ4ogPaKkzSF0ItUrO1sMWH+Tto+1ocnlV3LoaRU7yD34dWM/RiicB+YSE2DScNRgpy8r01xT1Q271bMQ5IUIkIVFIeshBtEQU0HBSFWi0lA4LunIsOlQa18fL4ovtKV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRBgDFK5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRBgDFK5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CEB11F000E9;
	Sun, 16 Aug 2026 21:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786916073;
	bh=uod8fIMy2JLlgadI/Q24fmG+HITi8bTBWFw375HTSC8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hRBgDFK5a1peDcF2Uu/45iiFRfKDfxbB6qOPxHOHm6S+wDo+wArvBx+3TqJA/ktLx
	 Wnq2I8CUpvWGqsXp/3A0T+RTSlpwnCesEzNi2Iv2+sVCM3D3XVsZu/eImnRO7RI195
	 MidbpmxyrC1OwuZ6wtorDbxu4bK/E+9RTp9Mfq5JtnnqZFUQ0WHXl+yeYyuVchV4W8
	 8jEUrpbNTG09x/qWNQOc8UTVJWSyqRNVnrS8/t1Yy8z2fCH7Aj1qMudeb0by4Ts//e
	 e28B7tCrtf9QPguFcGhyQi8G/ZgMp6nUzOZ1i9Eq96SMH988J1oU4vKTa8T9hO2zDt
	 cDPXUExb5WUpw==
Date: Sun, 16 Aug 2026 22:34:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 3/9] iio: adc: ti-ads1262: support per-channel
 sampling frequency
Message-ID: <20260816223432.64ddf4d0@jic23-huawei>
In-Reply-To: <20260807-ads126x-v3-3-f89925d72792@gmail.com>
References: <20260807-ads126x-v3-0-f89925d72792@gmail.com>
	<20260807-ads126x-v3-3-f89925d72792@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 07 Aug 2026 22:58:25 -0500
Kurt Borja <kuurtb@gmail.com> wrote:

> Add per-channel sampling frequency support. The "available" attribute is
> assigned per-channel too, in order to eventually support per-filter
> availability.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Trivial things only.

> ---
>  drivers/iio/adc/ti-ads1262.c | 159 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 158 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1262.c b/drivers/iio/adc/ti-ads1262.c
> index d78e5e3ae13e..b3b7b1249102 100644
> --- a/drivers/iio/adc/ti-ads1262.c
> +++ b/drivers/iio/adc/ti-ads1262.c
> @@ -26,6 +26,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/spi/spi.h>
>  #include <linux/types.h>
> +#include <linux/units.h>
>  
>  #include <asm/byteorder.h>
>  
> @@ -148,6 +149,7 @@ enum {
>  	ADS1262_DR_14400_SPS,
>  	ADS1262_DR_19200_SPS,
>  	ADS1262_DR_38400_SPS,
> +	ADS1262_DR_COUNT,

For count / terminating entries, no trailing comma as nothing should ever
come after them.

>  };
>  
>  static int ads1262_channel_enable(struct ads1262 *st,
>  				  const struct iio_chan_spec *spec)
>  {
> +	struct ads1262_channel *chan = &st->channels[spec->scan_index];
> +	int ret;
>  	u8 val;
>  
>  	guard(mutex)(&st->xfer_lock);
>  	guard(mutex)(&st->chan_lock);
>  
> +	val = FIELD_PREP(ADS1262_MODE2_DR_MASK, chan->data_rate);
> +	ret = regmap_update_bits(st->regmap, ADS1262_MODE2_REG,
> +				 ADS1262_MODE2_DR_MASK, val);
Not seeing an advantage here over
	ret = regmap_update_bits(st->regmap, ADS1262_MODE2_REG,
				 ADS1262_MODE2_DR_MASK,
				 FIELD_PREP(ADS1262_MODE2_DR_MASK, chan->data_rate));

It is fine to go a little over 80 chars when it helps readability.  Here I think
that is the case as clear we have matching masks.

> +	if (ret)
> +		return ret;
> +
>  	val = FIELD_PREP(ADS1262_INPMUX_MUXN_MASK, spec->channel2) |
>  	      FIELD_PREP(ADS1262_INPMUX_MUXP_MASK, spec->channel);
>  	return regmap_update_bits(st->regmap, ADS1262_INPMUX_REG,
