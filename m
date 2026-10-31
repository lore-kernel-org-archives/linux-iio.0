Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793490537;
	b=wMCt891CxofXGr5dCqjyDKj963JKML3l2QGHfqVn9TSB6gVJVBnVer/QAMoGvfgSqDm6
	 WrboVvisY3RREeSEjUJrrt1yzViEa7VVBUe84qm14Q5E5brc4gjneML81wExGXkNoQsct
	 Crp2/QFDf5BdbLMFeE17K6GcrfCrLhrxDoqwQ0R+vtO7G+Sz0kRnWNvxomuhWVJo4w1uQ
	 yij+mOWmHKG10o63lFEdxpAi0AKhRe5XypHOg4l0beDCagz3hF/MWYPy+NOfP2S8b9pBO
	 5zqzxDfkCPdcTz757jHDoCnlgrDKRKj9qGRMO2lZMvD5b82fWV9Pdk7VBXGcj4lGx9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793490537;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/r3zCo7njBBfgCidFvl6iw1dmiN6qAZZCDeJgQVlCmE=;
	b=cw1s1uEWyB6Dl9Rr7BRIq+a0m1mot5RsXcWmZRocKYnwMPP7IsxY9MGZC8o/udn2gbI5
	 G8V4NHVKmjYcU7ryZLQHeN8W/U1bWEeJQrRIAYI984G40sNnE7cl3rZ6UUwLZJD7hRv9d
	 fxjL+RS0iZ1Z6vApK5+1nLXSpnj2Nahu6psDQZf+gaDMiF1st4Bx629Jb44Jo27phnD2p
	 hh9x29k6Cf2TKycO8Hjz55YPmHCh1ZuYJOU33E+zD1HGSaRv9Ba4SiRY5eJzQaeBvhwgC
	 Qkjr55b3Y5QoD0rhPNL++m7TQE+WnxulZkbgv1ksw5PN34iwOtEj8UAqUy/TlbexHPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=exy0rapW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1622B606A31A;
	Sat, 31 Oct 2026 23:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=exy0rapW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893D51F000C1;
	Sat, 31 Oct 2026 23:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793490536;
	bh=/r3zCo7njBBfgCidFvl6iw1dmiN6qAZZCDeJgQVlCmE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=exy0rapWigz/9yHpnXX20JqhTSlf6+G+Nx+sWJUaqXLQIJ2RYeZQydYKVi8Td8xk1
	 0dzINn2X/DI9iwlPPBW3xG4VOYT3HfQYujF5j6nipuYj0bIzVn3P7kjv6genyjoHYn
	 jzv5vLvCqOAHlUnIPsFyOYMvO1NC7T0O3VvdNx0CxzfwLw/OmiNg+H5vSVTf7rAne1
	 /1uPERehCpvWqnxuPHRAVcLeu3yGSOVmWy3Ib2KuF/BWSRNQxDwScHKKG/ifw15B1i
	 yJaHosCZ5+u4rAqqZvNXukDKk0kIiBTTh/OUPCwkCeIXjUlmg/rusU2ZjeVzV0KFsg
	 Opk52UjWGOgXQ==
Date: Sat, 31 Oct 2026 23:48:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, Rodolfo
 Giometti <giometti@enneenne.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Angelo Dureghello <adureghello@baylibre.com>, Tobias Sperling
 <tobias.sperling@softing.com>, Eason Yang <j2anfernee@gmail.com>, Marilene
 Andrade Garcia <marilene.agarcia@gmail.com>, Cosmin Tanislav
 <cosmin-gabriel.tanislav.xa@renesas.com>, duje@dujemihanovic.xyz,
 herve.codina@bootlin.com, thomas.petazzoni@bootlin.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: add driver for Texas Instruments
 TLA2528 adc
Message-ID: <20261031234848.00248ddd@jic23-hlaptop>
In-Reply-To: <20261030164705.297354-3-maxime.chevallier@bootlin.com>
References: <20261030164705.297354-1-maxime.chevallier@bootlin.com>
	<20261030164705.297354-3-maxime.chevallier@bootlin.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Oct 2026 17:47:04 +0100
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> Add a new driver for the TI TLA2528 ADC chip. It has 8 12-bit
> channels, that can also be configured as 16-bit averaging channels.
> 
> This is a very simple driver, allowing reading raw values for each
> channel. GPIO mode isn't supported for now, as well as buffered mode and
> the 16-bit averaging mode.
> 
> Co-developed-by: Rodolfo Giometti <giometti@enneenne.com>
> Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Hi Maxime

A couple of minor things inline.  At least one due to cleanup
that happened tree wide in the last year.

I'd also like to avoid propagating the fallback to all channels
if none are specified. In this particular case it is problematic
because if you add the GPIO mode, for chips like this, we tend
to expose all pins that aren't in use for anything else as GPIOs.
With the fallback scheme you have no way to tell if you want all
pins as GPIOs.

That hack went in a few drivers were we added per channel properties
after the initial driver was added added and had to paper over
the backwards compatibility issue.  Hopefully it didn't make it
into fresh drivers whilst I wasn't paying attention!

Thanks,

Jonathan

> diff --git a/drivers/iio/adc/ti-tla2528.c b/drivers/iio/adc/ti-tla2528.c
> new file mode 100644
> index 000000000000..287e52dc9d6d
> --- /dev/null
> +++ b/drivers/iio/adc/ti-tla2528.c

> +
> +static int tla2528_read_sample(const struct i2c_client *client)

Benefit of this helper seems marginal.  Maybe squash into where
it is currently called?  I don't care either way on this one.


> +{
> +	__be16 data;
> +	int ret;
> +
> +	ret = i2c_master_recv(client, (char *)&data, sizeof(data));
> +	if (ret < 0)
> +		return ret;
> +
> +	return be16_to_cpu(data) >> 4;
> +}
> +
> +static int tla2528_read(struct tla2528 *tla2528, u8 channel, int *val)
> +{
> +	int ret;

As below. Use guard() in here. That makes it really obvious why
the mutex is needed.

> +
> +	ret = regmap_update_bits(tla2528->regmap, TLA2528_CHANNEL_SEL_ADR,
> +				 TLA2528_CHANNEL_SEL_MANUAL_CHID, channel);
> +	if (ret)
> +		return ret;
> +
> +	ret = tla2528_read_sample(tla2528->client);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = ret;
> +
> +	return 0;
> +}
> +
> +static int tla2528_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct tla2528 *tla2528 = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&tla2528->lock);
> +		ret = tla2528_read(tla2528, chan->channel, val);
> +		mutex_unlock(&tla2528->lock);
> +		if (ret < 0)
> +			return ret;
> +
> +		return IIO_VAL_INT;
	case IIO_CHAN_INFO_RAW: {
		guard(mutex)(&tla2528->lock);

		ret = tla2528_read(tla2528, chan->channel, val);
		if (ret < 0)
			return ret;

		return IIO_VAL_INT;
	}
Small gain here in keeping the error check right next to the thing
that set it, but might as well have that given it is simple to
use a guard.

Or better still: Move the guard into tla2528_read() 
There it will be more obvious that it is the two step nature
of the read that requires the lock.

> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = tla2528->vref_mv;
> +		*val2 = 12;
> +
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +
> +static int tla2528_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct iio_chan_spec *channels;
> +	struct iio_dev *indio_dev;
> +	struct tla2528 *tla2528;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))

Add a comment that the data reads directly use i2c with
no register address.  FWIW I briefly wondered why the checks in
the regmap init weren't enough.  They aren't because for this particular
mix of reg and val sizes can match others I2C protocol options in
regmap_get_i2c_bus().  With this present though we know they will match
the first and simplest one.

> +		return -EOPNOTSUPP;
> +
> +	if (i2c_check_quirks(client->adapter, I2C_AQ_NO_CLK_STRETCH))
> +		return dev_err_probe(dev, -EOPNOTSUPP,
> +				     "adapter does not support clock stretching\n");
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*tla2528));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	tla2528 = iio_priv(indio_dev);
> +	tla2528->client = client;
> +
> +	tla2528->regmap = devm_regmap_init_i2c(client, &tla2528_regmap_config);
> +	if (IS_ERR(tla2528->regmap))
> +		return PTR_ERR(tla2528->regmap);
> +
> +	ret = devm_mutex_init(dev, &tla2528->lock);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_regulator_get_enable(dev, "dvdd");
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_regulator_get_enable_read_voltage(dev, "avdd");
> +	if (ret < 0)
> +		return ret;
> +
> +	tla2528->vref_mv = ret / (MICRO / MILLI);
> +
> +	ret = devm_iio_adc_device_alloc_chaninfo_se(dev, &tla2528_chan_template,
> +						    TLA2528_NUM_CHANNELS - 1,
> +						    &channels);
> +	if (ret < 0 && ret != -ENOENT)
> +		return ret;
> +
> +	if (ret == -ENOENT) {

We do this trick for old drivers where we only added per channel properties
later.  For a new driver, why not always require the binding to be explicit
and list the channels (even if that is all of them)?

> +		indio_dev->channels = tla2528_channel;
> +		indio_dev->num_channels = ARRAY_SIZE(tla2528_channel);
> +	} else {
> +		indio_dev->channels = channels;
> +		indio_dev->num_channels = ret;
> +	}
> +
> +	indio_dev->name = "tla2528";
> +	indio_dev->info = &tla2528_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = regmap_write(tla2528->regmap, TLA2528_GENERAL_CFG_ADR,
> +			   TLA2528_GENERAL_CFG_RST);
> +	if (ret)
> +		return ret;
> +
> +	fsleep(5 * USEC_PER_MSEC);
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct i2c_device_id tla2528_id[] = {
> +	{ "tla2528" },

This is something that happened in last year, but for these
we now always use named initializers.  There is work ongoing
for a change in the structure definition and that only works
if they are named.  + It is consistent with what we always
did for the of_device_id tables.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, tla2528_id);

