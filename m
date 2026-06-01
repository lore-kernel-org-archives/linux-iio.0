Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65DF38BF62;
	Mon,  1 Jun 2026 10:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780310857; cv=none; b=lBbi0NRdqUytZ3JkOtaTl943PywTpRPoPMJFFcqMNkEnWA9w1qmVQ2G3s725aNrP1tYPs8zLRRbcVuI+563xM7LDmnz/U+zQYn1ADgHcJluW4CtQzxIt9ol25u88/FOtt/moO1BMLuZtDpj7oSX/Ctzrdt4jXgaXb7Xk2TZ/m4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780310857; c=relaxed/simple;
	bh=og6wY6rHNw91hOuiB46Z/zZFricRfqEJmgrAabhrh0s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V7x9z2Wy1231chwiDmEtEXcQzvUZgpkozzsnJ49Y9Jsp3OvCF8ZgL0DzVFtyBvJPCq5JjzlP3IF1P439TfuHLcC1ggUlARakPxDNrWxd4ubTwDpVdfta22NsOAUyrqOc8E1F2eF6M7aqueIlKsyIogwfUHgj7wgcB5g6w72Lq4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJ9k3qC0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJ9k3qC0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A3A1F00893;
	Mon,  1 Jun 2026 10:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780310856;
	bh=dmOVbM9oTryg1A3s9uyqxCiifGseppAJBNQByaR9R5w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hJ9k3qC0eAB57NuIVnvWsCo3aIHDVFus6SRjCVrWhH/KYkwF+WAK09n2DSp8wjIbx
	 5Uf6+GeL8WgR5cMRV+ebnwTmDrDdO7VdXl4qbUg91WHp3FH0sy+mdR6d1bTBxP6OZx
	 p4Jiix/3vWoOz9SLBbCe+J/K1xwqRxMrMdgPRUWVn+k3ElYojEUsKjmlMuRYwga6tl
	 TAKhbWcxPudP6WreS2JytoxRVkua+71PI4P54IJXgnrXKFoC6fHu+mt1gbQlZ60BfX
	 IMfPp8b1x0+jnkhdz62+pDiBOm3JxCVX657gzgzSjzdVsUHY3kvXRb0I9rBxJeggGn
	 gAdhLyAOELz5Q==
Date: Mon, 1 Jun 2026 11:47:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] iio: light: veml6031x00: add support for events
 and trigger
Message-ID: <20260601114726.3be42aac@jic23-huawei>
In-Reply-To: <20260531-veml6031x00-v4-4-e64f7fdce38d@gmail.com>
References: <20260531-veml6031x00-v4-0-e64f7fdce38d@gmail.com>
	<20260531-veml6031x00-v4-4-e64f7fdce38d@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 31 May 2026 21:58:24 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The device provides a shared interrupt line for to notify events and
> data ready, which can be used as a trigger. The interrupt line is not a
> requirement for the device to work. Implement variants for the cases
> whether the interrupt line is provided or not.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
A few more things inline. Some from sashiko.

> +static int veml6031x00_write_event_config(struct iio_dev *iio,
> +					  const struct iio_chan_spec *chan,
> +					  enum iio_event_type type,
> +					  enum iio_event_direction dir,
> +					  bool state)
> +{
> +	struct veml6031x00_data *data = iio_priv(iio);
> +	int ret;
> +
> +	guard(mutex)(&data->irq_lock);
> +
> +	/* avoid multiple increments/decrements from one source */
> +	if (state == data->ev_en)
> +		return 0;
> +
> +	if (state) {
> +		ret = pm_runtime_resume_and_get(data->dev);

Sashiko points out that, unlike buffered capture there is no core
based disabling of events in remove path.  Hence if events are on
we may not get the runtime pm put that we need to actually power down
the device and the stuff above it in the system.  You need
to do your own tracking for whether it's needed or not.

For background, we can't do a general disable from the IIO core because
the core doesn't actually know what events are enabled as we don't model
the complex interactions that can occur between different events - i.e.
enabling one can disable another.

> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = veml6031x00_set_interrupt(data, state);
> +	if (ret) {
> +		if (state)
> +			pm_runtime_put_autosuspend(data->dev);
> +		return ret;
> +	}
> +
> +	data->ev_en = state;
> +
> +	if (!state)
> +		pm_runtime_put_autosuspend(data->dev);
> +
> +	return 0;
> +}

>  
> +/* AF_TRIG is reset by hardware, but the rest of the fields are persistent */

https://sashiko.dev/#/patchset/20260531-veml6031x00-v4-0-e64f7fdce38d%40gmail.com
comment seems valid to me. I think you have to treat this register as volatile
and rewrite the whole thing every time. Maybe a reorder would work. Drop the region
after the update.  However then next access has to do a read so maybe just
do your own sub register caching for this one.


> +static int veml6031x00_set_af_trig(struct veml6031x00_data *data, bool state)
> +{
> +	regcache_drop_region(data->regmap, VEML6031X00_REG_CONF0,
> +			     VEML6031X00_REG_CONF0);
> +
> +	return regmap_update_bits(data->regmap, VEML6031X00_REG_CONF0,
> +				  VEML6031X00_CONF0_AF_TRIG,
> +				  FIELD_PREP(VEML6031X00_CONF0_AF_TRIG, state));
> +}
> +
> +static irqreturn_t veml6031x00_interrupt(int irq, void *private)
> +{
> +	struct iio_dev *iio = private;
> +	struct veml6031x00_data *data = iio_priv(iio);
> +	s64 timestamp;
> +	int ret, reg;

regval. Reg is often used for register address.

> +
> +	ret = regmap_read(data->regmap, VEML6031X00_REG_INT, &reg);
> +	if (ret) {
> +		dev_err(data->dev,
> +			"Failed to read interrupt register %d\n", ret);
> +		return IRQ_NONE;
> +	}
> +
> +	if (!(reg & VEML6031X00_INT_MASK))
> +		return IRQ_NONE;
> +
> +	guard(mutex)(&data->irq_lock);

I'm not really sure what this lock is protecting against.  It doesn't cover
the register read above, so the rest may be based on stale value of reg.
Perhaps some comments?

> +
> +	if ((reg & (VEML6031X00_INT_TH_H | VEML6031X00_INT_TH_L)) && data->ev_en) {
> +		timestamp = iio_get_time_ns(iio);
> +
> +		if (reg & VEML6031X00_INT_TH_H)
> +			iio_push_event(iio, IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
> +								 IIO_EV_TYPE_THRESH,
> +								 IIO_EV_DIR_RISING),
> +				       timestamp);
> +		if (reg & VEML6031X00_INT_TH_L)
> +			iio_push_event(iio, IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
> +								 IIO_EV_TYPE_THRESH,
> +								 IIO_EV_DIR_FALLING),
> +				       timestamp);
> +	}
> +
> +	if ((reg & VEML6031X00_INT_DRDY) && data->trig_en) {
> +		iio_trigger_poll_nested(data->trig);
> +		ret = veml6031x00_set_af_trig(data, true);

This superficially seems like something that maybe belongs in the trigger
reenable callback?  That will get called in much the same place, but has
the advantage that it documents this is about reenabling that trigger.

> +		if (ret)
> +			dev_err(data->dev, "Failed to set trigger %d\n", ret);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int veml6031x00_buffer_preenable(struct iio_dev *iio)
>  {
>  	struct veml6031x00_data *data = iio_priv(iio);
> @@ -534,11 +863,54 @@ static int veml6031x00_buffer_postdisable(struct iio_dev *iio)
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

Correct report form sashiko here. You should not be mixing guard and gotos.
It's fine to just use traditional mutex_lock / unlock in some
functions where guard() is not appropriate.

Note i don't think there is a bug here but this pattern is considered
fragile as future code might see the gotos and add some more and one of
those might cross the declaration hidden in guard()


> +
> +	if (state == data->trig_en)
> +		return 0;
> +
> +	ret = veml6031x00_set_interrupt(data, state);
> +	if (ret)
> +		return ret;
> +
> +	/* The AF bit must be set before setting AF_TRIG */
> +	ret = regmap_update_bits(data->regmap, VEML6031X00_REG_CONF0,
> +				 VEML6031X00_CONF0_AF,
> +				 FIELD_PREP(VEML6031X00_CONF0_AF, state));
> +	if (ret)
> +		goto err_disable_interrupt;
> +
> +	ret = veml6031x00_set_af_trig(data, state);
> +	if (ret)
> +		goto err_clear_af;
> +
> +	data->trig_en = state;
> +
> +	return 0;
> +
> +err_clear_af:
> +	regmap_update_bits(data->regmap, VEML6031X00_REG_CONF0,
> +			   VEML6031X00_CONF0_AF,
> +			   FIELD_PREP(VEML6031X00_CONF0_AF, !state));
> +err_disable_interrupt:
> +	veml6031x00_set_interrupt(data, !state);
> +	return ret;
> +}
> +
>  static const struct iio_buffer_setup_ops veml6031x00_buffer_setup_ops = {
>  	.preenable = veml6031x00_buffer_preenable,
>  	.postdisable = veml6031x00_buffer_postdisable,
>  };
>  
> +static const struct iio_trigger_ops veml6031x00_trigger_ops = {
> +	.set_trigger_state = veml6031x00_set_trigger_state,
Another plausible sashiko comment. Is this trigger usable by another device?
That in theory at least includes when this device is not using it.  Might
be easier to set the validation callback to restrict it to this device.

> +};


>  
> @@ -638,6 +1059,10 @@ static int veml6031x00_probe(struct i2c_client *i2c)
>  	if (ret)
>  		return ret;
>  
> +	ret = devm_mutex_init(dev, &data->irq_lock);
> +	if (ret)
> +		return ret;
> +
>  	ret = veml6031x00_regfield_init(data);
>  	if (ret)
>  		return dev_err_probe(dev, ret, "Failed to init regfield\n");
> @@ -677,12 +1102,21 @@ static int veml6031x00_probe(struct i2c_client *i2c)
>  	iio->channels = veml6031x00_channels;
>  	iio->num_channels = ARRAY_SIZE(veml6031x00_channels);

Sashiko caught that you need separate channel definitions as well for the
no irq vs irq cases.  Otherwise a bunch of sysfs files that don't do anything
will be created.

>  	iio->modes = INDIO_DIRECT_MODE;
> -	iio->info = &veml6031x00_info;
>  
>  	ret = veml6031x00_hw_init(iio);
>  	if (ret)
>  		return ret;
>  
> +	if (i2c->irq) {
> +		ret = veml6031x00_setup_irq(i2c, iio);
> +		if (ret)
> +			return ret;
> +
> +		iio->info = &veml6031x00_info;
> +	} else {
> +		iio->info = &veml6031x00_info_no_irq;
> +	}
> +
>  	ret = devm_iio_triggered_buffer_setup(dev, iio, NULL,
>  					      veml6031x00_trig_handler,
>  					      &veml6031x00_buffer_setup_ops);
> 

