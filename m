Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B6D184524;
	Sun,  1 Mar 2026 11:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772365033; cv=none; b=UNXwGHTiJzfZFtR/VsKIh2fYMa2xf/cVdV5EFPI42MMN30/ZFg99ciy0ofnA3qx8B2wcYsLRFEWSsEsGkkNLbtC+41uIseY73dSNIFWhGlfcmAU2cxkls96SYDB2Hej1mDobuWHEdRKzGUdeLNDe8IKckSV9b5Zs/Q3aCvxuFkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772365033; c=relaxed/simple;
	bh=rrwquvcKbGXDpyX4U7rCdBtFBlQ+EPivynl1wuKHzCI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QCX++7Xtbs5iGcyLTEUUduHwmJaDWax75ne00JQOqf7eAfCMLicqeZdOipcbu4C+RFAK0IcD60l38EDVukLVb79BSou0WODZxshsvO9PCMg65IU7tZnbBtGM8zoJokSLcySzcnmxFuagbdWJlI3U8iaF0HHT7ek+gZqRgTmRNfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WaaOaAP+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaaOaAP+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679B7C116C6;
	Sun,  1 Mar 2026 11:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772365033;
	bh=rrwquvcKbGXDpyX4U7rCdBtFBlQ+EPivynl1wuKHzCI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WaaOaAP+5HYEYh5VKAFD1aPOhWxR+hAFYpXO+UXEDfY9vAn4AJmBkf4dp1BoxRBMi
	 Wy6gVvx5yHsOANvPmjdNHWZP6U/r53SBj1ItY+6dyOfe6kGJxueF9b/coGyemDS5IX
	 AjXio5VaALpau1HbKMs3eSmc4TqRlbGtki+J8nJgSYNOiHIAFxgUoApTAL1j1xRUdT
	 rRjsnS+2YWc68Nv/gShaOBvi8p9Otb7qhyBBoeHl5yfxSkVhy3K34fJPeeiFu8OiK0
	 uX/Y3i1M07LTjDORdaAgKWCi7HsbXIHQuaXYQ2HFaq8ue/pnUwVc8TzVepWcVzp/8X
	 Y/DaAWtka7rDg==
Date: Sun, 1 Mar 2026 11:37:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Archit Anant <architanant5@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad799x: use devm_iio_device_register and devm
 buffer setup
Message-ID: <20260301113705.75b8224f@jic23-huawei>
In-Reply-To: <20260228154515.16639-1-architanant5@gmail.com>
References: <20260228154515.16639-1-architanant5@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Feb 2026 21:15:15 +0530
Archit Anant <architanant5@gmail.com> wrote:

> Convert the driver to use the device-managed versions of
> iio_device_register() and iio_triggered_buffer_setup().
> 
> This simplifies the error handling in ad799x_probe() by removing the
> 'error_cleanup_ring' goto label. It also removes the need to manually
> call iio_device_unregister() and iio_triggered_buffer_cleanup() in
> ad799x_remove().

It's also unfortunately broken.  There is a simple rule of thumb for
use of devm.  It must be used for 'everything' up to the point in probe()
where you decide to stop using it.  After that it cannot be used
at all.

The reason is that everything in the remove() callback occurs before the
unwinding of devm actions.  Thus if you mix and match, you get ordering
problems.

In this case you turn the power off before removing the user space
interfaces which is going to be rather unexpected if someone is still
using those interfaces.

Jonathan

> 
> Signed-off-by: Archit Anant <architanant5@gmail.com>
> ---
>  drivers/iio/adc/ad799x.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index 108bb22162ef..42712372acdb 100644
> --- a/drivers/iio/adc/ad799x.c
> +++ b/drivers/iio/adc/ad799x.c
> @@ -847,7 +847,7 @@ static int ad799x_probe(struct i2c_client *client)
>  	if (ret)
>  		goto error_disable_vref;
>  
> -	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> +	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
>  		&ad799x_trigger_handler, NULL);
>  	if (ret)
>  		goto error_disable_vref;
> @@ -862,19 +862,17 @@ static int ad799x_probe(struct i2c_client *client)
>  						client->name,
>  						indio_dev);
>  		if (ret)
> -			goto error_cleanup_ring;
> +			goto error_disable_vref;
>  	}
>  
>  	mutex_init(&st->lock);
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(&client->dev, indio_dev);
>  	if (ret)
> -		goto error_cleanup_ring;
> +		goto error_disable_vref;
>  
>  	return 0;
>  
> -error_cleanup_ring:
> -	iio_triggered_buffer_cleanup(indio_dev);
>  error_disable_vref:
>  	if (st->vref)
>  		regulator_disable(st->vref);
> @@ -889,9 +887,6 @@ static void ad799x_remove(struct i2c_client *client)
>  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>  	struct ad799x_state *st = iio_priv(indio_dev);
>  
> -	iio_device_unregister(indio_dev);
> -
> -	iio_triggered_buffer_cleanup(indio_dev);
>  	if (st->vref)
>  		regulator_disable(st->vref);
>  	regulator_disable(st->reg);

