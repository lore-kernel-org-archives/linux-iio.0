Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3712D9780;
	Thu, 13 Aug 2026 01:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786584291; cv=none; b=pV8k090g3eZVWn8a2hxwLDn8ZR0GtaCvhZcnWxCiO+72BSxJD5vpe6tvQ0QNQ5IXE85kwbCOCGg0vLYNXSprZ6DEgG46sGDOqBD62AxkDTNmvN3ARxlg/M89cA8CGt7VsuixegQYuT9/QScg3VreKjX4u7RvsNfQ7shEltVpvvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786584291; c=relaxed/simple;
	bh=sRwkA7/jy+UgDLs8TcKOUykRLCL0EmTrjuPl2/5HecM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rk09FHoEd+BRIQvmGqoF5CRmyPA8Lf2EgdTDJ45brVjg8823H0frspwIUcGPi3tdGfOijM8vrjU6iHOA0TBZ3aHF+NRP7V4H3mgDiKfv5FXPy0VpENgoVzw/nUeRlWI6WiBgbgSYBDXRwk5eGYxPXxsvE00tn0o/9H5EGX42E/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=korujWq/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="korujWq/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0914E1F000E9;
	Thu, 13 Aug 2026 01:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786584290;
	bh=Q2OBP+ldGv+UyQQ+PV2BOJn5wlO1wzlL2l42XJ5wugo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=korujWq/Gug5KYpkN33YGqgkg5NQpYIV/qe9x60WNr43DtsgEy6OEpxa2u/34PkZ4
	 uy/nPijR/08KSrl+NlXZn9Z6dqoeZUHVtxs4l13wQvVI+Mtix68RC9DgONemmqXDgD
	 yRToXh4AKqGrbhqXQXIlsYTeGEFANzCuYMboyPwDC3aOFn0I5J5GTE3MsaGbfibas/
	 4EEuVaXw8RyQvMAB7qkqG+sy06cEzOfpq6whDf3NCkcJidgFl7hOyzXhoeA9vz5ldG
	 csmrmXyfn/P63DSRV8l5Ba5g+vtaVOFmWaNUdXKviWAjnUmVgU8uoSHpJ87l3GHQA7
	 kx5nJHT2ha+FA==
Date: Thu, 13 Aug 2026 02:24:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] iio: light: veml6031x00: add support for events
 and trigger
Message-ID: <20260813022436.41a28d64@jic23-huawei>
In-Reply-To: <20260812-veml6031x00-v6-4-7eef6e4ce290@gmail.com>
References: <20260812-veml6031x00-v6-0-7eef6e4ce290@gmail.com>
	<20260812-veml6031x00-v6-4-7eef6e4ce290@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Aug 2026 22:27:43 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The device provides a shared interrupt line for to notify events and
> data ready, which can be used as a trigger. The interrupt line is not a
> requirement for the device to work. Implement variants for the cases
> whether the interrupt line is provided or not.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Trivial only.
> ---
>  drivers/iio/light/veml6031x00.c | 545 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 539 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/light/veml6031x00.c b/drivers/iio/light/veml6031x00.c
> index 43a701f62aea..6dc7ea7e8a4f 100644
> --- a/drivers/iio/light/veml6031x00.c
> +++ b/drivers/iio/light/veml6031x00.c


> +
> +static int veml6031x00_write_event_config(struct iio_dev *iio,
> +					  const struct iio_chan_spec *chan,
> +					  enum iio_event_type type,
> +					  enum iio_event_direction dir,
> +					  bool state)
> +{
> +	struct veml6031x00_data *data = iio_priv(iio);
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;
> +
> +	guard(mutex)(&data->irq_lock);
> +
> +	/* avoid multiple increments/decrements from one source */
> +	if (state == data->ev_en)
> +		return 0;

There is not a lot of shared code in here between state true/false
I'd split as two helpers.

	if (state)
		ret = veml6031x00_event_enable();
	else
		ret = veml6031x00_even_disable();

> +
> +	if (state) {
> +		ret = pm_runtime_resume_and_get(dev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = veml6031x00_set_interrupt(data, state);
> +	if (ret) {
> +		if (state)
> +			pm_runtime_put_autosuspend(dev);
> +		return ret;
> +	}
> +
> +	data->ev_en = state;
> +
> +	if (!state)
> +		pm_runtime_put_autosuspend(dev);
> +
> +	return 0;
> +}


> @@ -549,11 +948,78 @@ static int veml6031x00_buffer_postdisable(struct iio_dev *iio)
>  	return 0;
>  }
>  
> +static int veml6031x00_set_trigger_state(struct iio_trigger *trig, bool state)
> +{
> +	struct iio_dev *iio = iio_trigger_get_drvdata(trig);
> +	struct veml6031x00_data *data = iio_priv(iio);
> +	int ret;
> +
> +	guard(mutex)(&data->irq_lock);
> +
> +	if (state == data->trig_en)
> +		return 0;
> +
> +	ret = veml6031x00_set_interrupt(data, state);
> +	if (ret)
> +		return ret;
> +
> +	/* The AF bit must be updated before updating AF_TRIG */
> +	ret = regmap_update_bits(data->regmap, VEML6031X00_REG_CONF0,
> +				 VEML6031X00_CONF0_AF,
> +				 FIELD_PREP(VEML6031X00_CONF0_AF, state));
> +	if (ret) {
> +		veml6031x00_set_interrupt(data, !state);
> +
> +		return ret;
> +	}
> +
> +	ret = regmap_update_bits(data->regmap, VEML6031X00_REG_CONF0,
> +				 VEML6031X00_CONF0_AF_TRIG,
> +				 FIELD_PREP(VEML6031X00_CONF0_AF_TRIG, state));
> +	if (ret) {
> +		regmap_update_bits(data->regmap, VEML6031X00_REG_CONF0,
> +				   VEML6031X00_CONF0_AF,
> +				   FIELD_PREP(VEML6031X00_CONF0_AF, !state));
> +		veml6031x00_set_interrupt(data, !state);

This dance vs a goto is I guess due to the mutex.  I'd clean it up
by using a helper function for the stuff done under the guard(). The
helper can do goto based cleanup and avoid repetition plus reduce chance
of missing cleaning something up on error.  The outer function can
still use guard().

> +
> +		return ret;
> +	}
> +
> +	data->trig_en = state;
> +
> +	return 0;
> +}

>  
> +static int veml6031x00_setup_irq(struct i2c_client *i2c, struct iio_dev *iio)
> +{
> +	struct veml6031x00_data *data = iio_priv(iio);
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;
> +
> +	data->trig = devm_iio_trigger_alloc(dev, "%s-drdy%d",
> +					    iio->name, iio_device_id(iio));
> +	if (!data->trig)
> +		return -ENOMEM;
> +
> +	data->trig->ops = &veml6031x00_trigger_ops;
> +	iio_trigger_set_drvdata(data->trig, iio);
> +
> +	ret = devm_iio_trigger_register(dev, data->trig);
> +	if (ret)
> +		return ret;
> +
> +	iio->trig = iio_trigger_get(data->trig);

Sashiko is correct that we loose a reference here on error and right now
there is no IIO core infrastructure to solve this

Why are we setting a default trigger?   Userspace tools should be
fine looking for a data ready trigger, or choosing a different one if they
would prefer. Added advantage of not setting it here is the reference count
issue goes away :)

> +
> +	return devm_request_threaded_irq(dev, i2c->irq,
> +					NULL, veml6031x00_irq,
> +					IRQF_ONESHOT, iio->name, iio);
> +}



