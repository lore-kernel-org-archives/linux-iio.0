Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE7F2264BB;
	Sat, 31 Jan 2026 16:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769877560; cv=none; b=Eynuj4xjWrd11Zyd1CO9yOU91eM1OtcxMsd3dUV5USQWhIYlfX8MUXIPt4EKSi7sektTeME3Z6ICq1dRVVQdFNRxI41yQklNbDjhRXmr4zwuDb7QPJkgdBlEbAQhrYFfpYipOijrVxZZsz9pHzSz0TOCEmmPOdI89u8vwzhbCHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769877560; c=relaxed/simple;
	bh=saHEm0XXKqpc/2ahUByI7b1+HBSBtvZ/qPvvk9iLeng=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pN+HgnMs8MxYpZP3YJ5X8YsEzJSxKSmxyehJKKFxBTTSWegPx7+Y42CidKoa9hnJB8IS7iycIWQQhve/K2gOaZ4EPBwunjCLucaYAi7av/vZmwBIPC9Z0bdpIRq4RUHYaLw2QC/Cx4L5k0qM2eGREXiU9tAS9zW1uohUZFKZT1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRchXdX8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRchXdX8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86595C4CEF1;
	Sat, 31 Jan 2026 16:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769877559;
	bh=saHEm0XXKqpc/2ahUByI7b1+HBSBtvZ/qPvvk9iLeng=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iRchXdX8iiagZZsgrZ6gN1zm+O6ZSt//QfT5750OuWur1Pem9JoehKqZ0PP8gyg4x
	 InBjBA7og8pKomRrD4upeYZObVQ/aygGktN+Vu8GiB0Ln+o2ag1oAAvJYW673VjJZ7
	 G3N51ZxzLzqGMjVJb2oWrtAj6t6VWfoMvk16Xy8oRMeReW+o0Jpdvn+9FyGmUK41pz
	 Ohxt317adkfds0yk6Uh1Dis3QcRdW5A4WQimYHdyTR1EmfNdPKBtRaR+hbvH+j3r6q
	 BAq8+E3DDuRV5nHqvIO7Hnr6mD+2lPvdjj2r2pP5w4C28iWYp7iMzwuNCec5ezJa+T
	 C3QZQQXvRvhDA==
Date: Sat, 31 Jan 2026 16:39:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Gustavo Bastos
 <gustavobastos@usp.br>, Andrew Ijano <andrew.ijano@gmail.com>,
 linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
 linux-kernel@vger.kernel.org (open list), kernel-janitors@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH next 4/4] iio: sca3000: stop interrupts via
 devm_add_action_or_reset()
Message-ID: <20260131163909.7c90c9d7@jic23-huawei>
In-Reply-To: <20260130214323.236389-5-harshit.m.mogalapalli@oracle.com>
References: <20260130214323.236389-1-harshit.m.mogalapalli@oracle.com>
	<20260130214323.236389-5-harshit.m.mogalapalli@oracle.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Jan 2026 13:43:11 -0800
Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com> wrote:

> sca3000_stop_all_interrupts() is moved above the probe routine so the
> new function sca3000_disable_interrupts() used in probe can directly
> call it without additional declaration.
> 
> Used devm_add_action_or_reset() for shutting doing the interrupts. After
> this there is no need to have a remove call back, so got rid of the
> remove callback.
> 
> No functional change intended.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Will need an update if you indeed didn't intend to change order in previous
patch.  devm_iio_device_register() is last in vast majority of probe
functions because it opens us up to userspace interaction. We almost
always want to cut that off on remove before doing anything else.

> ---
>  drivers/iio/accel/sca3000.c | 58 ++++++++++++++++++++-----------------
>  1 file changed, 32 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> index bf1957c7bc77..7f7d29688a81 100644
> --- a/drivers/iio/accel/sca3000.c
> +++ b/drivers/iio/accel/sca3000.c
> @@ -1437,6 +1437,34 @@ static const struct iio_info sca3000_info = {
>  	.write_event_config = &sca3000_write_event_config,
>  };
>  
> +static int sca3000_stop_all_interrupts(struct sca3000_state *st)
> +{
> +	int ret;
> +
> +	mutex_lock(&st->lock);

Use guard(mutex)(&st->lock); to simplify this. Remember to include cleanup.h
A future patch could then make use of guard() more widely in this driver.

> +	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
> +	if (ret)
> +		goto error_ret;

Blank line here.  Keeps each group of action / error check clearly delineated
if we have a blank line between them. Note this is a case of do as I say
not as I did nearly 17 years back when I wrote this (younger me did many
things wrong ;)

With guard() above, you can just do
	if (ret)
		return ret;

here.
> +	ret = sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
> +				(st->rx[0] &
> +				 ~(SCA3000_REG_INT_MASK_RING_THREE_QUARTER |
> +				   SCA3000_REG_INT_MASK_RING_HALF |
> +				   SCA3000_REG_INT_MASK_ALL_INTS)));

With guard() above, this becomes
	return sca3000_write_reg();


> +error_ret:
> +	mutex_unlock(&st->lock);
> +	return ret;
> +}
> +
> +static void sca3000_disable_interrupts(void *data)
> +{
> +	struct iio_dev *indio_dev = data;
> +	struct sca3000_state *st = iio_priv(indio_dev);
> +
> +	/* Must ensure no interrupts can be generated after this! */
> +	sca3000_stop_all_interrupts(st);
> +}
> +
> +
>  static int sca3000_probe(struct spi_device *spi)
>  {
>  	const struct spi_device_id *id = spi_get_device_id(spi);
> @@ -1481,6 +1509,7 @@ static int sca3000_probe(struct spi_device *spi)
>  		if (ret)
>  			return ret;
>  	}
> +

Unrelated change.  Make sure to check for these in patches before
you send them out.  It adds noise and typically means you'll end
up doing another version even if everything else is good.

>  	ret = sca3000_clean_setup(st);
>  	if (ret)
>  		return ret;
> @@ -1489,34 +1518,12 @@ static int sca3000_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> -	return devm_iio_device_register(dev, indio_dev);
> -}
> -
> -static int sca3000_stop_all_interrupts(struct sca3000_state *st)
> -{
> -	int ret;
> -
> -	mutex_lock(&st->lock);
> -	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
> +	ret = devm_iio_device_register(dev, indio_dev);
>  	if (ret)
> -		goto error_ret;
> -	ret = sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
> -				(st->rx[0] &
> -				 ~(SCA3000_REG_INT_MASK_RING_THREE_QUARTER |
> -				   SCA3000_REG_INT_MASK_RING_HALF |
> -				   SCA3000_REG_INT_MASK_ALL_INTS)));
> -error_ret:
> -	mutex_unlock(&st->lock);
> -	return ret;
> -}
> +		return ret;
>  
> -static void sca3000_remove(struct spi_device *spi)
> -{
> -	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> -	struct sca3000_state *st = iio_priv(indio_dev);
> +	return devm_add_action_or_reset(dev, sca3000_disable_interrupts, indio_dev);
As mentioned above. This looks unlikely to be a good idea as a reorder of code.

I'd expect interfaces to go away and then interrupts to be stopped. In general
that should always be safe unless we have some racey bug somewhere in the IIO
core or the driver is doing something unusual.

Thanks,

Jonathan

>  
> -	/* Must ensure no interrupts can be generated after this! */
> -	sca3000_stop_all_interrupts(st);
>  }
>  
>  static const struct spi_device_id sca3000_id[] = {
> @@ -1533,7 +1540,6 @@ static struct spi_driver sca3000_driver = {
>  		.name = "sca3000",
>  	},
>  	.probe = sca3000_probe,
> -	.remove = sca3000_remove,
>  	.id_table = sca3000_id,
>  };
>  module_spi_driver(sca3000_driver);

