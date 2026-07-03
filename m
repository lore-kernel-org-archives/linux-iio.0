Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BBC30DD2A;
	Fri,  3 Jul 2026 23:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783120171; cv=none; b=ja5MK1GeCs4Ru1r0GqfSzAJ2MYMvmcFqw6CuxStPsiQfCMyJ7i7dT9Z3qDwqlj075biwnTtnaV5iuAtbBDBuSv67fMZ8V430nkLx6I6p6S8O5JgCpmaEmCKfiLlW3cmmeEhWiWUey/Pe3JoWT3E2JeWOQKvQQEgy83/VToTvMHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783120171; c=relaxed/simple;
	bh=qNwXEgxGLEakDXJp7NVqnpLQxQ4SxeM+/K2tBzzYJQU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z6s/3hTauYGhtRZmvJtAxO6cQ0Yld/8Ay5VtXOTKvUGYJt2WvjLhEJ3KnmzT3F9325UwijgWrOiUX160IzcdzWzCUn5ZP4PfoTrEGDfOvO+nsS4MulC0ghH1iYF/+6/a413FXo2+xMOigVJqoJ2K7FuOdS+fGVcVFyKZcTUNDfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHTxBUSq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHTxBUSq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A012E1F000E9;
	Fri,  3 Jul 2026 23:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783120170;
	bh=OirdlbAGORQUa48T79uzMhCWSunEUqnyVoOKDad5Wxk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VHTxBUSqR9tpNrho2fD4yAcwn4FqjWMlz7Gsmf7ifih94yzZ89LMuf6K4CGhSJYeC
	 zFoa0LdQKBh7+Xa5VykhfJNrTy21AZkB0BsF/c16pSOK1NNWCpP51r/pS70F8DCYTQ
	 6Sp2iDDYlXyd2XXPCOQ/dsbx+gtxgjsbVKmf85mgf0UhWaTzWF2cPeYQZsJS1HIzm2
	 HV0Yb2Gk9MYpukVxlLpLMDzdcr/+/BCk4LE8NKA/J7244OxtwS09IUu8VXHFVa9SYx
	 z1xnwAyeJ15LTrwgPls4Rjx+sv9vM7sfZLPC+VQVxptY0fWNmmaY49ZTdneDZI7Sk9
	 u4wreZVVcZIBw==
Date: Sat, 4 Jul 2026 00:09:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 joshua.crofts1@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ti-ads1015: use devm helpers to fix probe
 error paths
Message-ID: <20260704000926.1614a51f@jic23-huawei>
In-Reply-To: <20260529183708.17819-1-sozdayvek@gmail.com>
References: <20260529183708.17819-1-sozdayvek@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 23:37:08 +0500
Stepan Ionichev <sozdayvek@gmail.com> wrote:

> Once ads1015_probe() gets past ads1015_set_conv_mode(CONTINUOUS), two
> resources leak on its error paths and on driver unbind:
> 
>   - pm_runtime_enable() is left enabled if iio_device_register() fails;
>     on subsequent probe/rebind the runtime PM tracking complains about
>     an unbalanced enable.
>   - The CONTINUOUS conversion mode written to the chip is never restored
>     on any error path after that point, so on probe failure the chip is
>     left running.
> 
> Convert all three teardown operations of ads1015_remove() to devm so
> that the error paths and the unbind path share the same unwind in
> reverse-of-setup order:
> 
>   - ads1015_set_conv_mode(SINGLESHOT) becomes a devm action registered
>     immediately after CONTINUOUS mode is enabled.
>   - pm_runtime_enable() becomes devm_pm_runtime_enable().
>   - iio_device_register() becomes devm_iio_device_register(), so the
>     iio device is unregistered first on unbind.
> 
> ads1015_remove() is no longer needed and is dropped.
> 
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
These are always a bit fiddly so I was hoping to get some more eyes on this
one.  Ah well, long enough and I think it's fine and sashiko is happy so applied.

Thanks,

Jonathan

> ---
> v2:
> - Full devm conversion: register a devm action for set_conv_mode(SINGLESHOT),
>   switch to devm_iio_device_register, drop ads1015_remove() entirely.  This
>   avoids mixing devm with manual unwind (Jonathan) and also fixes the
>   pre-existing continuous-mode leak on probe failure.
> - Drop the unrelated dev_err() -> dev_err_probe() conversion from v1 (Joshua).
> 
> v1: https://lore.kernel.org/all/20260529101011.3030-1-sozdayvek@gmail.com/
> 
>  drivers/iio/adc/ti-ads1015.c | 44 +++++++++++++++---------------------
>  1 file changed, 18 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index c7ffe47449e2..d7f4d0d5bcf9 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -930,6 +930,17 @@ static int ads1015_set_conv_mode(struct ads1015_data *data, int mode)
>  				  mode << ADS1015_CFG_MOD_SHIFT);
>  }
>  
> +static void ads1015_power_down(void *p)
> +{
> +	struct ads1015_data *data = p;
> +	int ret;
> +
> +	ret = ads1015_set_conv_mode(data, ADS1015_SINGLESHOT);
> +	if (ret)
> +		dev_warn(regmap_get_device(data->regmap),
> +			 "Failed to power down (%pe)\n", ERR_PTR(ret));
> +}
> +
>  static int ads1015_probe(struct i2c_client *client)
>  {
>  	const struct ads1015_chip_data *chip;
> @@ -1030,6 +1041,10 @@ static int ads1015_probe(struct i2c_client *client)
>  	if (ret)
>  		return ret;
>  
> +	ret = devm_add_action_or_reset(&client->dev, ads1015_power_down, data);
> +	if (ret)
> +		return ret;
> +
>  	data->conv_invalid = true;
>  
>  	ret = pm_runtime_set_active(&client->dev);
> @@ -1037,33 +1052,11 @@ static int ads1015_probe(struct i2c_client *client)
>  		return ret;
>  	pm_runtime_set_autosuspend_delay(&client->dev, ADS1015_SLEEP_DELAY_MS);
>  	pm_runtime_use_autosuspend(&client->dev);
> -	pm_runtime_enable(&client->dev);
> -
> -	ret = iio_device_register(indio_dev);
> -	if (ret < 0) {
> -		dev_err(&client->dev, "Failed to register IIO device\n");
> +	ret = devm_pm_runtime_enable(&client->dev);
> +	if (ret)
>  		return ret;
> -	}
> -
> -	return 0;
> -}
>  
> -static void ads1015_remove(struct i2c_client *client)
> -{
> -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> -	struct ads1015_data *data = iio_priv(indio_dev);
> -	int ret;
> -
> -	iio_device_unregister(indio_dev);
> -
> -	pm_runtime_disable(&client->dev);
> -	pm_runtime_set_suspended(&client->dev);
> -
> -	/* power down single shot mode */
> -	ret = ads1015_set_conv_mode(data, ADS1015_SINGLESHOT);
> -	if (ret)
> -		dev_warn(&client->dev, "Failed to power down (%pe)\n",
> -			 ERR_PTR(ret));
> +	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  
>  #ifdef CONFIG_PM
> @@ -1150,7 +1143,6 @@ static struct i2c_driver ads1015_driver = {
>  		.pm = &ads1015_pm_ops,
>  	},
>  	.probe		= ads1015_probe,
> -	.remove		= ads1015_remove,
>  	.id_table	= ads1015_id,
>  };
>  

