Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181514ADDB1;
	Wed,  6 May 2026 17:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778087375; cv=none; b=UFXDoB7ADdc9Jt8BJ4Mxcax++r3bpcco2zQ1gikN9Ms3cFVdVy3L4djnBkVBorlv15WJAxatc44WLltvPR8TfjQccuMX/8VAh7sk0U7H6VHkWB7Jrtbog2WDezSAsrmRSvmu07nn9V188cfVJ325tHnPYegB37RkJ61Mw/PHbZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778087375; c=relaxed/simple;
	bh=RLMcunNfEufdwqGEpXBwYpNGMo8UK4D+xp/a+JRPqXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ddJbeK4yAPihE9TptkWnbF83I86c8dkfKsRk30w1ShtozVBuSPMUGLFQLFOzVGlZmAdbVM/UHuCAt5Uqlhb+2eCNYO5jJZ8JJoRGlFYgoSF4WacEfJSiBAL17HwSSVpsFWu7PUF2Lr9O+rO7m1ET2/7CrhIMgGewn0KlV4pkCyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYJaZHss; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYJaZHss"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB6BC2BCB0;
	Wed,  6 May 2026 17:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778087373;
	bh=RLMcunNfEufdwqGEpXBwYpNGMo8UK4D+xp/a+JRPqXQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rYJaZHssyNOp8sRwrnMQ0O6Z/sswrTHZtk/qpKs8LNfbcI0KwcjQvJ1TNiLVN0KaI
	 1UGU4FHq7l7G39DHMharq60L9Xi21qO6h4ZmB8oxr+Am9eSXcZfiro+ePPMkaPjCre
	 hKkK0lPOYT0ZaE5ekUDORHKaWj7fYPMA/3GTGqx05ygYHx+AIkFMZ5rQniwZ3w5oCw
	 hGofLfU+UlNvMp7sLbbs3lHFGsOYrW/IOIH+iTQdue48ZUXyOOt4E+/nmwakh1Q8DL
	 BTZGMzh+hKvkOUqsKENrWeo/vm6PBk7Q6BTuSVhHnbkkBrQM0WEpLwD2YaUGJ/pvYj
	 sVxUSRQ52zvbA==
Date: Wed, 6 May 2026 18:09:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Cc: joshua.crofts1@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 14/18] iio: magnetometer: ak8975: switch to using
 managed resources
Message-ID: <20260506180925.3fb80edf@jic23-huawei>
In-Reply-To: <20260505-magnetometer-fixes-v5-14-831b9b5550fc@gmail.com>
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
	<20260505-magnetometer-fixes-v5-14-831b9b5550fc@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 05 May 2026 13:46:10 +0200
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
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Co-developed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
Hi Joshua

Looks fine, but one stale comment needs an update.

Jonathan

> ---
>  drivers/iio/magnetometer/ak8975.c | 77 ++++++++++++++++++++++-----------------
>  1 file changed, 44 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index 1c05e380a4d4f968f505a7d5c0acbec86ad949e1..84ccbca758b0121a9c4930a368cb113471d389da 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -900,9 +900,27 @@ static irqreturn_t ak8975_handle_trigger(int irq, void *p)
>  	return IRQ_HANDLED;
>  }
>  
> +static void devm_ak8975_power_off(void *data)
> +{
> +	struct ak8975_data *ak = data;
> +	struct device *dev = &ak->client->dev;
> +
> +	/* Only power down if currently active */
> +	if (pm_runtime_status_suspended(dev))
> +		return;
> +	/*
> +	 * The device may not be runtime suspended when the driver is

If we get here it's definitely not runtime suspended.  Hence
this comment needs a rewrite.

> +	 * removed, so we soft-stop the chip before hard-stopping the
> +	 * regulators.
> +	 */
> +	ak8975_set_mode(data, POWER_DOWN);
I went looking into how we get into different modes...
This deals with a latent bug in ak8975_setup() in that it can be in fuse mode
in some exit paths.  Arguably if we had an i2c bus fail we probably can't
change the mode anyway, but we should be trying from point of view
of no side effects. I wonder if we should fix that in a precursor to this
patch (given the amount of churn from earlier patches an obscure corner
case of the bug - I don't plan to mark it for backports either way!)

Maybe it's just not worth the bother given this is now here anyway.

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
> @@ -970,10 +988,21 @@ static int ak8975_probe(struct i2c_client *client)
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
>  	ret = ak8975_who_i_am(client, data->def->type);
>  	if (ret) {
>  		dev_err(&client->dev, "Unexpected device\n");
> -		goto power_off;
> +		return ret;
>  	}
>  	dev_dbg(&client->dev, "Asahi compass chip %s\n", name);
>  
> @@ -981,10 +1010,13 @@ static int ak8975_probe(struct i2c_client *client)
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
> @@ -992,52 +1024,32 @@ static int ak8975_probe(struct i2c_client *client)
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

huh. Not sure what this was doing in original code.
I guess forced an immediate power down rather that after an autosuspend
period.  I think that's fine to change - however perhaps do a bit
of analysis on whether my assumption is correct on what this did
and then mention it in the commit message.


> -	pm_runtime_set_active(&client->dev);

> -	pm_runtime_enable(&client->dev);
> +	ret = devm_pm_runtime_enable(dev);
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

