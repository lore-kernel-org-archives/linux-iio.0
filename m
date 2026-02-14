Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBE11DF273;
	Sat, 14 Feb 2026 18:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771094281; cv=none; b=eBp+zIjIbOzRy1azpZ4kdpy/E27krxxWyNN5/tp29jVfvCEDKFFsrKxjZGdIH9zWrY7y7eFaoLcuyIuJPSUS999/vRyGNKszgRoQJfwMtRCDhDNfA+b0SRAP0f38vbMwkaCEpB420FmaBNxnstBu5nwg81G4SfxI8kN/JgfcQEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771094281; c=relaxed/simple;
	bh=50eBXZnfYwe9UG3B5fmyvWf54Ns+laZT/xFOqXi2wXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d7I4QYn6fOhTyNs8tMDbCJ76gZ7o/x+Ax6GGBhPOUbM3XzSDD6VVpdIVctpeeLZg+GQhQtlR5b6oASj3CQqC2nktfqoTgv5WBX1wG1MkU498na0SxbxRUa6pOLLAiQlGovJzAeJvRvR+yckQPpvd57/H8OTx6JsSoch89aLEqA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/49cNkv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/49cNkv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1038AC16AAE;
	Sat, 14 Feb 2026 18:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771094280;
	bh=50eBXZnfYwe9UG3B5fmyvWf54Ns+laZT/xFOqXi2wXQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X/49cNkv/2qT4M5glNKh9VoJcjh/dQJcgGYo/jRAf5bJNNFmxZGsVMfZQwnMnsFUw
	 OVTryBr+QO/V8DyjrM6RgUQVFODisHwuo7PkM0TxGzKT7OzKhm+91aBuy2MZ8Nil2h
	 bhrniwdCd6fSw0y3GDbttnfl9v/rJR7OfqqRU1osGUQvaBjW9ZY8UlYFEwkHOM72lE
	 qsjB7AK3GlPCYlSkloxko12PgyjtWx2peqXjoWMxdHU8xHALvDZ0If6k7fzX+lTH9Y
	 /C30hbv34voBs89KCrop51eooweoraYUu0jiUkNKp+ANyFf/FVezV62Mhdii9jXbOS
	 wJrOPEai5dHIQ==
Date: Sat, 14 Feb 2026 18:37:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 06/11] iio: amplifiers: ad8366: replace reset-gpio
 with reset controller
Message-ID: <20260214183751.799483ba@jic23-huawei>
In-Reply-To: <20260210-iio-ad8366-update-v4-6-15505f7b15b4@analog.com>
References: <20260210-iio-ad8366-update-v4-0-15505f7b15b4@analog.com>
	<20260210-iio-ad8366-update-v4-6-15505f7b15b4@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Feb 2026 19:42:06 +0000
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Remove reset_gpio from the device state struct and use the
> reset_control interface instead, using a local variable,
Prefer commit descriptions wrapped to 75 chars.

Remove reset_gpio from the device state struct and use the reset_control 
interface instead, using a local variable, as it is not being used anywhere
else.

> as it is not being used anywhere else.

> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  drivers/iio/amplifiers/ad8366.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
> index f0053a09cbb6..67817dedd75d 100644
> --- a/drivers/iio/amplifiers/ad8366.c
> +++ b/drivers/iio/amplifiers/ad8366.c
> @@ -17,6 +17,7 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/reset.h>
>  #include <linux/spi/spi.h>
>  
>  #include <linux/iio/iio.h>
> @@ -38,7 +39,6 @@ struct ad8366_state {
>  	struct spi_device	*spi;
>  	struct regulator	*reg;
>  	struct mutex            lock; /* protect sensor state */
> -	struct gpio_desc	*reset_gpio;
>  	unsigned char		ch[2];
>  	enum ad8366_type	type;
>  	const struct ad8366_info *info;
> @@ -242,6 +242,7 @@ static const struct iio_chan_spec ada4961_channels[] = {
>  static int ad8366_probe(struct spi_device *spi)
>  {
>  	struct device *dev = &spi->dev;
> +	struct reset_control *rstc;
>  	struct iio_dev *indio_dev;
>  	struct ad8366_state *st;
>  	int ret;
> @@ -276,9 +277,9 @@ static int ad8366_probe(struct spi_device *spi)
>  	case ID_ADL5240:
>  	case ID_HMC792:
>  	case ID_HMC1119:
> -		st->reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset", GPIOD_OUT_HIGH);
> -		if (IS_ERR(st->reset_gpio)) {
> -			ret = PTR_ERR(st->reset_gpio);
> +		rstc = devm_reset_control_get_optional_exclusive_deasserted(dev, NULL);
> +		if (IS_ERR(rstc)) {
> +			ret = PTR_ERR(rstc);
>  			goto error_disable_reg;
>  		}
>  		indio_dev->channels = ada4961_channels;
> 

