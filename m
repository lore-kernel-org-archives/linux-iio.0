Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302E333ADA0;
	Wed, 20 May 2026 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779291081; cv=none; b=KxHlHt3qfgImNjg1e5IXExwQYY1EjLRiuWp9BzC3KxzmiESxK8rbaLzeRYTGEFaLX8irnOFzUYIM2/aRCZHc9S2UQsIuYn8+V3TngpoZHkOi60dYdVRCAqQ6U0NNuhufCZBc+TwReyYrEwry7GeOt9Ta19g0v/jDXKAMpj/odTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779291081; c=relaxed/simple;
	bh=3p2IOwCzEqrYE/nKvFkPypEnZxNGmWw86LT7vUzqhog=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O/9inKtssI3UQYacVG3wN40sYgkOtXvF/yCODP/UnBU+ZjhHCk7wkVHVswo8nmWWBBQFhyMQlOZd7YC1wvtKdZtN27GpSVEhzwulEEecTuolxC5UvXNbOWGzdSkSnBWgwVJb/W2DYWjThSOrRzdCrvDFuUAY7Q71tw76UJvw+dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVKfxy4j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVKfxy4j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F841F000E9;
	Wed, 20 May 2026 15:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779291079;
	bh=EgJsD6E1XV19Ynyg+XIdSpApzuyMGLkdVdOM+rnQoxQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JVKfxy4j1LlPVjQHmo5al5a8kchlAqTuudb1gYtZv9/cXklMxmt5Mtv2V9OsDrjoT
	 g+ky/OfS7QzB+YmMqD9mmg/4mM3EXmS9WMEP9pmTodUFq70fERrLUolmFJsiFprFYy
	 KVbWPwHEqi0bDNySH42UjxloJGXJzZEip+XVI6s4aRw44ZtYssh10FRq3Byj4oZEtu
	 VPaP3oGL9VKWeaRwF+O2xeWmqlI50VshvwJPLQOtf2cs5y0HHapW1rzcN6zcfcIRFj
	 HPdZifxfDtMmPgpa4tc9VYCFHjfa3Uo0QSa0DcQVfVkoErHk12G8nkjL9Ymwr74vUH
	 DV3PdCnPBwEpQ==
Date: Wed, 20 May 2026 16:31:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Cc: joshua.crofts1@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v8 1/5] iio: magnetometer: ak8975: switch to using
 managed resources
Message-ID: <20260520163114.612745d4@jic23-huawei>
In-Reply-To: <20260518-magnetometer-fixes-post-pickup-v8-1-088d610108a0@gmail.com>
References: <20260518-magnetometer-fixes-post-pickup-v8-0-088d610108a0@gmail.com>
	<20260518-magnetometer-fixes-post-pickup-v8-1-088d610108a0@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 09:50:25 +0200
Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:

> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Switch the driver to use managed resources (devm_*) which simplifier
> error handling and allows removing ak8975_remove() method from
> the driver.
> 
> Note, on error path we now also set mode to POWER_DOWN state which is
> fine. Even if the device is in that mode, there is no problem to set
> that mode again, it should be no-op.
> 
> Additionally, remove any pm_runtime_get/put*() function calls that
> dummy cycled the counter to autosuspend the device.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Co-developed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
>  drivers/iio/magnetometer/ak8975.c | 77 ++++++++++++++++++++++-----------------
>  1 file changed, 43 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index bb74abb648f138352576a68c49d3c7dce7cc068e..de4402201783430fc69369f1accaab35145e9f0c 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -935,9 +935,25 @@ static const struct iio_buffer_setup_ops ak8975_buffer_setup_ops = {
>  	.preenable = ak8975_buffer_preenable,
>  	.postdisable = ak8975_buffer_postdisable,
>  };
> +
> +static void devm_ak8975_power_off(void *data)
> +{
> +	struct ak8975_data *ak = data;
> +	struct device *dev = &ak->client->dev;
> +
> +	/* Only power down if currently active */
> +	if (pm_runtime_suspended(dev))
I don't think we established that this actually works without underflowing 
the regular reference counts if in runtime pm suspsended state when
we tear get to devm cleanup.

Sashiko correctly moans about this and points out you refer to a different
check anyway on the comment below.
https://sashiko.dev/#/patchset/20260518-magnetometer-fixes-post-pickup-v8-0-088d610108a0%40gmail.com

I'm not convinced pm_runtime_status_suspended() is sufficient either.

The only path I'm 100% sure of is when we add tracking flag in the
iio_priv() to indicate if we are already runtime suspended.  Ugly but
at least we know that will not run into these odd race conditions.

This is 'probably' a new bug rather than a latent one because of the
unusual handling below.  I think there is a race in original code but
it is narrow so unlikely anyone ever hit it.

Whilst I do discuss what else you might do - I'd throw a flag in iio_priv()
because it is a simpler solution.

Now, if you happen to have some sort of real hardware or emulation to test
the different flows, then I'd be interested to see if there are advantages
to doing something closer to what this driver originally did.

> +		return;
> +
> +	/* Soft-stop the chip before hard-stopping the regulators */
> +	ak8975_set_mode(data, POWER_DOWN);
> +	ak8975_power_off(data);
> +}
> +
>  static int ak8975_probe(struct i2c_client *client)
>  {
>  	const struct i2c_device_id *id = i2c_client_get_device_id(client);
> +	struct device *dev = &client->dev;
>  	struct ak8975_data *data;
>  	struct iio_dev *indio_dev;
>  	struct gpio_desc *eoc_gpiod;
> @@ -1005,10 +1021,21 @@ static int ak8975_probe(struct i2c_client *client)
>  	if (ret)
>  		return ret;
>  
> +	/*
> +	 * Set device as active early so pm_runtime_status_suspended() works
> +	 * correctly if probe fails before pm_runtime is enabled. Do not attempt
> +	 * to move this line lower.
> +	 */
> +	pm_runtime_set_active(dev);
> +
> +	ret = devm_add_action_or_reset(dev, devm_ak8975_power_off, data);
> +	if (ret)
> +		return ret;
> +
>  	ret = ak8975_who_i_am(data, data->def->type);
>  	if (ret) {
>  		dev_err(&client->dev, "Unexpected device\n");
> -		goto power_off;
> +		return ret;
>  	}
>  	dev_dbg(&client->dev, "Asahi compass chip %s\n", name);
>  
> @@ -1016,10 +1043,13 @@ static int ak8975_probe(struct i2c_client *client)
>  	ret = ak8975_setup(data);
>  	if (ret) {
>  		dev_err(&client->dev, "%s initialization fails\n", name);
> -		goto power_off;
> +		return ret;
>  	}
>  
> -	mutex_init(&data->lock);
> +	ret = devm_mutex_init(dev, &data->lock);
> +	if (ret)
> +		return ret;
> +
>  	indio_dev->channels = ak8975_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(ak8975_channels);
>  	indio_dev->info = &ak8975_info;
> @@ -1027,52 +1057,32 @@ static int ak8975_probe(struct i2c_client *client)
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->name = name;
>  
> -	ret = iio_triggered_buffer_setup(indio_dev, NULL, ak8975_handle_trigger,
> -					 &ak8975_buffer_setup_ops);
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> +					      ak8975_handle_trigger,
> +					      &ak8975_buffer_setup_ops);
>  	if (ret) {
>  		dev_err(&client->dev, "triggered buffer setup failed\n");
> -		goto power_off;
> +		return ret;
>  	}
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
>  	if (ret) {
>  		dev_err(&client->dev, "device register failed\n");
> -		goto cleanup_buffer;
> +		return ret;
>  	}
>  
> -	/* Enable runtime PM */
> -	pm_runtime_get_noresume(&client->dev);

See below for comment on this.

> -	pm_runtime_set_active(&client->dev);
> -	pm_runtime_enable(&client->dev);
>  	/*
>  	 * The device comes online in 500us, so add two orders of magnitude
>  	 * of delay before autosuspending: 50 ms.
>  	 */
>  	pm_runtime_set_autosuspend_delay(&client->dev, 50);
>  	pm_runtime_use_autosuspend(&client->dev);
> -	pm_runtime_put(&client->dev);
>  
>  	return 0;
> -
> -cleanup_buffer:
> -	iio_triggered_buffer_cleanup(indio_dev);
> -power_off:
> -	ak8975_power_off(data);
> -	return ret;
> -}
> -
> -static void ak8975_remove(struct i2c_client *client)
> -{
> -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> -	struct ak8975_data *data = iio_priv(indio_dev);
> -
> -	pm_runtime_get_sync(&client->dev);
This forces device to wake up.

> -	pm_runtime_put_noidle(&client->dev);
This forces the counter down to 0 but doesn't trigger a runtime
pm suspend.   I'm nervous though as userspace is still in place
(before iio_device_register() - so it's possible another
get / put cycle can occur before the next call).

> -	pm_runtime_disable(&client->dev);
Hence when we disable runtime pm the device is powered up and
the rest won't underflow.

Now interestingly there is a :
devm_pm_runtime_get_noresume() which calls
pm_runtime_get_noresume() and schedules the
pm_runtime_put_noidle() in the tear down path.. 

However it is vanishingly rarely used and the sequence to me
is non obvious - the two users are inconsistent :(


> -	iio_device_unregister(indio_dev);
> -	iio_triggered_buffer_cleanup(indio_dev);
> -	ak8975_set_mode(data, POWER_DOWN);
> -	ak8975_power_off(data);
>  }
>  
>  static int ak8975_runtime_suspend(struct device *dev)
> @@ -1166,7 +1176,6 @@ static struct i2c_driver ak8975_driver = {
>  		.acpi_match_table = ak_acpi_match,
>  	},
>  	.probe		= ak8975_probe,
> -	.remove		= ak8975_remove,
>  	.id_table	= ak8975_id,
>  };
>  module_i2c_driver(ak8975_driver);
> 

