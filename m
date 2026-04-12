Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B02B72618;
	Sun, 12 Apr 2026 18:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776020331; cv=none; b=qNZONrM8/Dn4Vq1NMqlr/ODH2easliTK4kn96IgUMw/dEZsgailfZfpR6AJND3E6VIBjsHVfqjdC4hBft0PvOut1mh4mPa8ILcDjC9fxkBX3oUMto80t9BxKig5Z9glvPWHutSNKmU1iOOeO6rqvYb160vc9tK0H/U2m5yuSIOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776020331; c=relaxed/simple;
	bh=EI/EZFMvRE9dk8zjPETYG0uNEyzc+WOucebcWx+iPXo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o51qgrr6DwQp7RPODbakXOF0t4i5Lq+LHhA7AKzg9Fx+afRfNZvGw9LA95uMePtCYHbj2KRRiHNe4tEKgifKe1k6K8xcb45TPgprWkkLftoYZnccgftpFN28FBTR1HHeOLdwEKT1qrjqDafj8e+56JXya9I+1Y3gilzbCoeLNns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYDS4NkT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYDS4NkT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1DBC19424;
	Sun, 12 Apr 2026 18:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776020331;
	bh=EI/EZFMvRE9dk8zjPETYG0uNEyzc+WOucebcWx+iPXo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SYDS4NkT0OIKHYG+9HFr9MbRAQlTdLO2QgGskTWu4mAh9Jy7KuJH5MBBXWp8xEQwO
	 9OBfmw4KDWfSJMbzPtBX3fF1wJ3dJ4/7Bf6BFYmPS0J12roChpXTct1+fjOEkciKMb
	 CAOLc/weQ+vY/tCqPF0UxmDdwpA5XtMKlSy6XxV7c/KaSVrMca8CaplPo/KEtvSQdT
	 1u3NcWheF55z9z7uIwe1gfKotf/SKfskoqXvZXi7sBZ6JqHC86BEjTiGs+4YfThEPP
	 Y2uVZpwY7o6ufIhCMPM5v3NpWB3woPNJI2cXuZ63FZXAuif10ltoj6B2QRtgOuAEe+
	 T/y10Wqfmi5sw==
Date: Sun, 12 Apr 2026 19:58:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Jorge Marques <jorge.marques@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Renato
 Lui Geh <renatogeh@gmail.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/13] iio: adc: ad7793: use dev_err_probe
Message-ID: <20260412195845.29495023@jic23-huawei>
In-Reply-To: <20260330111856.121589-6-antoniu.miclaus@analog.com>
References: <20260330111856.121589-1-antoniu.miclaus@analog.com>
	<20260330111856.121589-6-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Mar 2026 14:18:48 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Use dev_err_probe() instead of dev_err() in the probe path to ensure
> proper handling of deferred probing and to simplify error handling.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  drivers/iio/adc/ad7793.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
> index 21c667e37b31..624530cce938 100644
> --- a/drivers/iio/adc/ad7793.c
> +++ b/drivers/iio/adc/ad7793.c
> @@ -278,8 +278,8 @@ static int ad7793_setup(struct iio_dev *indio_dev,
>  	id &= AD7793_ID_MASK;
>  
>  	if (id != st->chip_info->id) {
> -		ret = -ENODEV;
> -		dev_err(&st->sd.spi->dev, "device ID query failed\n");
> +		ret = dev_err_probe(&st->sd.spi->dev, -ENODEV,

There are quite a few instances of this dereference nest.
Unless other things come up in this set I don't mind it being dealt
with separately but to me it seems like a helper to make this
		ret = dev_err_probe(adi_sigma_delta_get_dev(&st->sd), -ENODEV,
might be nice?  Longer line but avoids diving into the implementation details
in a driver that shouldn't really be doing that.


> +				    "device ID query failed\n");
>  		goto out;
>  	}
>  
> @@ -338,8 +338,7 @@ static int ad7793_setup(struct iio_dev *indio_dev,
>  
>  	return 0;
>  out:
> -	dev_err(&st->sd.spi->dev, "setup failed\n");
> -	return ret;
> +	return dev_err_probe(&st->sd.spi->dev, ret, "setup failed\n");
>  }
>  
>  static const u16 ad7793_sample_freq_avail[16] = {0, 470, 242, 123, 62, 50, 39,
> @@ -780,15 +779,11 @@ static int ad7793_probe(struct spi_device *spi)
>  	struct iio_dev *indio_dev;
>  	int ret, vref_mv = 0;
>  
> -	if (!pdata) {
> -		dev_err(&spi->dev, "no platform data?\n");
> -		return -ENODEV;
> -	}
> +	if (!pdata)
> +		return dev_err_probe(dev, -ENODEV, "no platform data?\n");
>  
> -	if (!spi->irq) {
> -		dev_err(&spi->dev, "no IRQ?\n");
> -		return -ENODEV;
> -	}
> +	if (!spi->irq)
> +		return dev_err_probe(dev, -ENODEV, "no IRQ?\n");
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
>  	if (indio_dev == NULL)

