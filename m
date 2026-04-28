Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0577315D3B;
	Tue, 28 Apr 2026 16:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393986; cv=none; b=fr0nHHlp0r1jj+THpKQShK0mTkZZySNu56qTfFVqX5r2i8eGdJgRkq7JByLhwxoOiizzM0dk1/6bgOFlF7ZhlA4D63oGGObXp+b9xqrNu39iaVFjAksJjGvyY2971zF3LklfeFm+wcTBoEzMMg3S8BEjKZgbSLurINAdB+fPshg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393986; c=relaxed/simple;
	bh=tZmy42vYZf3nJtC/s2c4W5fSN4vgauuyFuyAe37EYEs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KB0WCM5XxYKGqZZ6nnWyH6yE26tbUnQdG5Dt4pZggFiNvOYRP/Nomq42+LkIwSmTJE9dqSAFNK1VSRb3h8pVJ6ovKs6KOMZx0mV71s1uI8eIevActqWQVvToA/UzDoB8ysK9EKpVodFKX3sVKqxYq6WXkHk5v2jNJ+kI2VtIjco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2kBJW5K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2kBJW5K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C229C2BCAF;
	Tue, 28 Apr 2026 16:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777393986;
	bh=tZmy42vYZf3nJtC/s2c4W5fSN4vgauuyFuyAe37EYEs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c2kBJW5K9lMc6T4z1AWxRArjnf6jCz1j5BKT2JidgcKy8sQM9wf6VivVM+OJrNJOc
	 E7/fiCq95wAT1wTZwm5l09o0j9/6Xc0UxOERuoANouCKm2g9Ob2PN6tnOc1ctVW6kZ
	 IX9oBQRT94MhfjiXxFhhSRJ/27IPgGu2Dw5WVoTOV57KFo8mPxPBlyGj4ONoNFT7KW
	 7BnV9H2i9/lrCSM6QogCDxgmWAk0S7qLnAx01LwjjqAhVhe97pd4UIZNfio3KQxe+d
	 paG+1j8QUbKOpfBuaS3zxt7SmLChrL97VjAoitFu21r9TZ0SzdTwCXayQxXGVWiK8s
	 F1vUkWcKl4xrQ==
Date: Tue, 28 Apr 2026 17:32:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Joshua Crofts <joshua.crofts1@gmail.com>
Subject: Re: [PATCH v0 10/14] iio: magnetometer: ak8975: switch to using
 managed resources
Message-ID: <20260428173256.25a64370@jic23-huawei>
In-Reply-To: <20260427201412.3067235-11-andriy.shevchenko@linux.intel.com>
References: <20260427201412.3067235-1-andriy.shevchenko@linux.intel.com>
	<20260427201412.3067235-11-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Apr 2026 22:09:55 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Switch the driver to use managed resources (devm_*) which simplifier
> error handling and allows removing ak8975_remove() method from
> the driver.
> 
> Note, on error path we now also set mode to POWER_DOWN state which is
> fine. Even if the device is in that mode, there is no problem to set
> that mode again, it should be no-op.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

One day I'll have time to write up some notes on patterns that work
for runtime pm + devm. I don't think think this one does - note original
code didn't work either as would underflow on regulators in some paths
and hence print warnings.
> ---
>  drivers/iio/magnetometer/ak8975.c | 59 ++++++++++++++-----------------
>  1 file changed, 26 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index 53158ffd173b..d666d9d171bd 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -888,9 +888,16 @@ static irqreturn_t ak8975_handle_trigger(int irq, void *p)
>  	return IRQ_HANDLED;
>  }
>  
> +static void devm_ak8975_power_off(void *data)
> +{
> +	ak8975_set_mode(data, POWER_DOWN);

Add a comment somewhere appropriate on what we are undoing with this.

It's a 'might not be runtime suspended' at time of remove I think
rather than the mode being set at that point in probe.

If it is suspended, we shouldn't call the regulator disables
in power_off.  So maybe gate this whole thing on
whether runtime suspended.  If you do that be careful with what
state we are in until runtime PM is enabled.  Maybe you already have that
covered elsewhere.


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
> @@ -958,10 +965,14 @@ static int ak8975_probe(struct i2c_client *client)
>  	if (ret)
>  		return ret;

If following comments above and below you'd need to set the state
to active here.  If you go that way, make sure to add a comment to
say why it is up here (and hopefully prevent someone thinking they can
move it down).

>  
> +	ret = devm_add_action_or_reset(dev, devm_ak8975_power_off, data);
> +	if (ret)
> +		return ret;
> +
>  	ret = ak8975_who_i_am(client, data->def->type);
>  	if (ret) {
>  		dev_err(&client->dev, "Unexpected device\n");
> -		goto power_off;
> +		return ret;
>  	}
>  	dev_dbg(&client->dev, "Asahi compass chip %s\n", name);
>  
> @@ -969,10 +980,13 @@ static int ak8975_probe(struct i2c_client *client)
>  	ret = ak8975_setup(client);
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
> @@ -980,52 +994,32 @@ static int ak8975_probe(struct i2c_client *client)
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->name = name;
>  
> -	ret = iio_triggered_buffer_setup(indio_dev, NULL, ak8975_handle_trigger,
> -					 NULL);
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> +					      ak8975_handle_trigger, NULL);
>  	if (ret) {
>  		dev_err(&client->dev, "triggered buffer setup failed\n");
> -		goto power_off;
> +		return ret;
>  	}
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(dev, indio_dev);
>  	if (ret) {
>  		dev_err(&client->dev, "device register failed\n");
> -		goto cleanup_buffer;
> +		return ret;
>  	}
>  
>  	/* Enable runtime PM */
> -	pm_runtime_get_noresume(&client->dev);
> -	pm_runtime_set_active(&client->dev);
> -	pm_runtime_enable(&client->dev);
> +	ret = devm_pm_runtime_set_active_enabled(dev);

This hits the race with whether we can query if the device is disabled mentioned
above. Dance where we need to be able to check that before we turn runtime pm on
so that we can correctly do regulator disables if we error out before here.

> +	if (ret)
> +		return ret;
> +
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

