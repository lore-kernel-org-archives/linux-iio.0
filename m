Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCB41DDC1B;
	Sat, 16 May 2026 14:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778942488; cv=none; b=USO9WpQFabl1Xn+iBm55Kkw8rAsgxRdQpaETYZoFoH1ELKOn1azxrqe0iZv9jeEgCo3JQ9WpnTCGVVACN35p4xteW2NzaIuwwrf162pJ93JWLjffB/CYiq2mpo1t6NWiqCeeojYPGmR6cxqii8w/0byXe6BVuQFTcs/jlRYJlds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778942488; c=relaxed/simple;
	bh=0eAQBBZjIMiMk5PIxpK3SkFr8ZFWxD9ODc+sXne3OZw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bn2+77tN6BOOjiNE/TcOvQA4JRecpLWdi6tZO8rKqjBqIHlBv+m2gLB+5CLjksvjEhz2Gt8O5m1pLa33oVeR+8NbsU2pRQISjofm2jEYUj8jwLwlR0BK9CzI+BVJRoimIAAynVG7zf4SYcqKCmeqbA9oFrhEPiYaLP1GAtwk+o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vD0koHGl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vD0koHGl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE95C19425;
	Sat, 16 May 2026 14:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778942487;
	bh=0eAQBBZjIMiMk5PIxpK3SkFr8ZFWxD9ODc+sXne3OZw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vD0koHGlPZYTUpBFkRf0IY78xgELxXNHsPYxBmXPl+nHmO0lRTT6x1jLO3Oh2m13e
	 /eGzXkusqfAU4Ugl84lcZW7m5/U19nJWiizu1l0/NeEooHVXpMiYMfPAEOgx1dl3E3
	 JnwwouHUafSKsdG8qfkEp1iXW4NyeR6tXvCI3So91IX+J3704aD1i9+/CJ6p1afePL
	 B1M/ck+b1UUWQpKP0uySMbC4s0OOjJL8qzuSE5qVRgVp/qDsmeOfBaI5U7bZpRQS3h
	 BAc9VjWSHG0pi8HK++SBptcKDWetT8J5ulBUW98yonMQZqoF7+xLfpF3W/g4NlwVbh
	 Kt1/xYP9Be4Ew==
Date: Sat, 16 May 2026 15:41:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: light: add support for veml6031x00 ALS
 series
Message-ID: <20260516154118.34bd85a0@jic23-huawei>
In-Reply-To: <20260513-veml6031x00-v2-4-4703ca661a1d@gmail.com>
References: <20260513-veml6031x00-v2-0-4703ca661a1d@gmail.com>
	<20260513-veml6031x00-v2-4-4703ca661a1d@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 May 2026 17:49:44 +1300
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> These sensors provide two light channels (ALS and IR), I2C communication
> and a multiplexed interrupt line to signal data ready and configurable
> threshold alarms.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Usual stuff of check what Sashiko came up with:
https://sashiko.dev/#/patchset/20260513-veml6031x00-v2-0-4703ca661a1d%40gmail.com

I'm fairly sure one or two of them are wrong (the timestamp scan index
thing trips it up a lot).

Anyhow, a couple of other things inline (+ highlighting one sashiko bug I definitely
agree with!)

Pretty good state on the whole.  Obviously it is a bit big though so
breaking it up as Andy requested will get more eyes on the code.

Thanks,

Jonathan


> ---
>  MAINTAINERS                     |    6 +
>  drivers/iio/light/Kconfig       |   14 +
>  drivers/iio/light/Makefile      |    1 +
>  drivers/iio/light/veml6031x00.c | 1193 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 1214 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2fb1c75afd16..47da46717c16 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -28381,6 +28381,12 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/light/vishay,veml6046x00.yaml
>  F:	drivers/iio/light/veml6046x00.c
>  
> +VISHAY VEML6031X00 AMBIENT LIGHT SENSOR DRIVER
> +M:	Javier Carrasco <javier.carrasco.cruz@gmail.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
Minor but I'd prefer the entry to be added in previous patch (the dt binding)
and then updated here.  Avoids a few script warnings and correctly reflects
what is covered after each patch.

> +F:	drivers/iio/light/veml6031x00.c
> +
>  VISHAY VEML6075 UVA AND UVB LIGHT SENSOR DRIVER
>  M:	Javier Carrasco <javier.carrasco.cruz@gmail.com>
>  S:	Maintained

> diff --git a/drivers/iio/light/veml6031x00.c b/drivers/iio/light/veml6031x00.c
> new file mode 100644
> index 000000000000..c7808768f45a
> --- /dev/null
> +++ b/drivers/iio/light/veml6031x00.c

> +/* Bit masks for specific functionality */
> +#define VEML6031X00_ALL_CH_MASK     GENMASK(1, 0)

This isn't a mask.  I'd express it as BIT() | BIT() where it's used.


> +/* Autosuspend delay */
> +#define VEML6031X00_AUTOSUSPEND_MS  2000

Given it's an arbitrary value used in one place. I'd be tempted just
to put the value in that call as that's where we'd typically look
if wondering what it is.

> +
> +static int veml6031x00_get_it(struct veml6031x00_data *data, int *val, int *val2)
See below. Why pass in val?

> +{
> +	int ret, it_idx;
> +
> +	ret = regmap_field_read(data->rf.it, &it_idx);
> +	if (ret)
> +		return ret;
> +
> +	ret = iio_gts_find_int_time_by_sel(&data->gts, it_idx);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val2 = ret;
> +	*val = 0;
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}


> +
> +static int veml6031x00_write_period(struct iio_dev *iio, int val)
> +{
> +	struct veml6031x00_data *data = iio_priv(iio);
> +
> +	if (val > 8 || hweight8(val) != 1)

Sashiko points out that this should probably sanity check val >= 0 as top
bit set passes that test but is garbage.


> +		return -EINVAL;
> +
> +	return regmap_field_write(data->rf.pers, ffs(val) - 1);
> +}


> +static int veml6031x00_single_read(struct iio_dev *iio, enum iio_chan_type type,
> +				   int *val)
> +{
> +	struct veml6031x00_data *data = iio_priv(iio);
> +	int addr, it_sec, it_usec, ret;
> +	__le16 reg;
> +
> +	switch (type) {
> +	case IIO_LIGHT:
> +		addr = VEML6031X00_REG_ALS_L;
> +		break;
> +	case IIO_INTENSITY:
> +		addr = VEML6031X00_REG_IR_L;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = pm_runtime_resume_and_get(data->dev);

Ideally:
Use PM_RUNTIME_ACQUIRE_AUTOSUSPEND() and PM_RUNTIME_ACQUIRE_ERR() +
further down:
IIO_DEV_ACQUIRE_DIRECT_MODE() and IIO_DEV_ACQUIRE_FAILED() - 

I'm slowly trying to encourage more use of those in IIO (but not mass conversions!)
and would like a few more good examples of how to do it in tree!

That should then allow direct returns in error paths.  The scope will extend
a tiny bit further but only to include the le16_to_cpu so that is fine.


> +	if (ret)
> +		return ret;
> +
> +	ret = veml6031x00_get_it(data, &it_sec, &it_usec);
> +	if (ret < 0)
> +		goto put_autosuspend;
> +
> +	/* integration time + 10 % to ensure completion */
> +	fsleep((it_sec * MICRO) + it_usec + (it_usec / 10));
> +
> +	if (!iio_device_claim_direct(iio)) {
> +		ret = -EBUSY;
> +		goto put_autosuspend;
> +	}
> +
> +	ret = regmap_bulk_read(data->regmap, addr, &reg, sizeof(reg));
> +	iio_device_release_direct(iio);
> +	if (ret < 0)
> +		goto put_autosuspend;
> +
> +	*val = le16_to_cpu(reg);
> +	ret = IIO_VAL_INT;
> +
> +put_autosuspend:
> +	pm_runtime_put_autosuspend(data->dev);
> +	return ret;
> +}
> +
> +static int veml6031x00_read_raw(struct iio_dev *iio,
> +				struct iio_chan_spec const *chan, int *val,
> +				int *val2, long mask)
> +{
> +	struct veml6031x00_data *data = iio_priv(iio);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		return veml6031x00_single_read(iio, chan->type, val);
> +	case IIO_CHAN_INFO_INT_TIME:
> +		*val = 0;

Forcing only *val to 0 then passing it to the get_it made me wonder why
not val2.  Seems better option is don't pass val to a function that doesn't
use it.

> +		return veml6031x00_get_it(data, val, val2);
> +	case IIO_CHAN_INFO_SCALE:
> +		return veml6031x00_get_scale(data, val, val2);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int veml6031x00_read_avail(struct iio_dev *iio,
> +				  struct iio_chan_spec const *chan,
> +				  const int **vals, int *type, int *length,
> +				  long mask)
> +{
> +	struct veml6031x00_data *data = iio_priv(iio);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_INT_TIME:
> +		return iio_gts_avail_times(&data->gts, vals, type, length);
> +	case IIO_CHAN_INFO_SCALE:
> +		return iio_gts_all_avail_scales(&data->gts, vals, type, length);
	default:
		return -EINVAL;

for consistency and because it makes intent a little clearer.

> +	}
> +
> +	return -EINVAL;
> +}

> +static int veml6031x00_set_interrupt(struct veml6031x00_data *data, bool state)
> +{
> +	int ret;
I wondered about whether the locking around this was sufficient to not need
atomics + ensure we don't end up with an error decrement resulting in a counter
going to 0 that wasn't previously...  Not quite I think because you don't hold the
lock on the error path in veml6031x00_set_trigger_state()

I think the lock should be held there then mark this as __must_hold()
and the atomics aren't necessary.  Right now they don't quite do the job anyway.

> +
> +	if (state) {
> +		if (atomic_inc_return(&data->int_users) > 1)
> +			return 0;
> +	} else {
> +		if (atomic_dec_return(&data->int_users) > 0)
> +			return 0;
> +	}
> +
> +	ret = regmap_field_write(data->rf.int_en, state);
> +	if (ret) {
> +		if (state)
> +			atomic_dec(&data->int_users);
> +		else
> +			atomic_inc(&data->int_users);
> +	}
> +
> +	return ret;

> +}

> +
> +static int veml6031x00_buffer_preenable(struct iio_dev *iio)
> +{
> +	struct veml6031x00_data *data = iio_priv(iio);
> +	int ret, it_sec, it_usec;
> +
> +	ret = pm_runtime_resume_and_get(data->dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = veml6031x00_get_it(data, &it_sec, &it_usec);
> +	if (ret < 0) {
> +		pm_runtime_put_autosuspend(data->dev);
> +		return ret;
> +	}
> +
> +	/*
> +	 * Wait one integration period + 10% margin so the first triggered
> +	 * read does not race with the sensor completing its first conversion
> +	 * after power-on.
> +	 */
> +	fsleep((it_sec * MICRO) + it_usec + (it_usec / 10));
> +
> +	return 0;
> +}
> +
> +static int veml6031x00_buffer_postdisable(struct iio_dev *iio)
> +{
> +	struct veml6031x00_data *data = iio_priv(iio);
> +	struct device *dev = data->dev;
> +
> +	pm_runtime_put_autosuspend(dev);

Might as well do
	pm_runtime_put_autosuspend(data->dev);
and save a local variable.

> +
> +	return 0;
> +}


> +
> +static irqreturn_t veml6031x00_trig_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *iio = pf->indio_dev;
> +	struct veml6031x00_data *data = iio_priv(iio);
> +	int ch, ret, i = 0;
> +	struct {
> +		__le16 chans[2];
> +		aligned_s64 timestamp;
> +	} scan;
> +
> +	memset(&scan, 0, sizeof(scan));

Can do 
	} scan = { };
Which is guaranteed by the options the kernel is built with + self
tests to initialize the holes as well.

> +
> +	if (*iio->active_scan_mask == VEML6031X00_ALL_CH_MASK) {
> +		ret = regmap_bulk_read(data->regmap,
> +				       VEML6031X00_REG_ALS_L,
> +				       &scan.chans, sizeof(scan.chans));
> +		if (ret)
> +			goto done;
> +	} else {
> +		iio_for_each_active_channel(iio, ch) {
> +			ret = regmap_bulk_read(data->regmap,
> +					       iio->channels[ch].address,
> +					       &scan.chans[i++], 2);

sizeof(*scan.chans) nicer than the 2.  I would have said
sizeof(scan.chans[i]) but then you'll have to pull the i++ out of
the call. Either is fine, jut replace the magic 2.


> +			if (ret)
> +				goto done;
> +		}
> +	}
> +
> +	iio_push_to_buffers_with_timestamp(iio, &scan, pf->timestamp);
	iio_push_to_buffers_with_ts(iio, &scan, sizeof(scan), pf->timestamp);

The _timestamp variant is deprecated as we can't do sanity checks on the
buffer being big enough.

> +
> +done:
> +	iio_trigger_notify_done(iio->trig);
> +
> +	return IRQ_HANDLED;
> +}

> +
> +static int veml6031x00_hw_init(struct iio_dev *iio)
> +{
> +	struct veml6031x00_data *data = iio_priv(iio);
> +	struct device *dev = data->dev;
> +	int ret, val;
> +	__le16 reg;
> +
> +	/* Max resolution = 6.9632 lx/cnt for gain = 0.125 and IT = 3.125ms */
> +	ret = devm_iio_init_iio_gts(data->dev, 6, 963200000,
> +				    veml6031x00_gain_sel,
> +				    ARRAY_SIZE(veml6031x00_gain_sel),
> +				    veml6031x00_it_sel,
> +				    ARRAY_SIZE(veml6031x00_it_sel),
> +				    &data->gts);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret, "failed to init iio gts\n");

Use dev

> +
> +	reg = 0;
> +	ret = regmap_bulk_write(data->regmap, VEML6031X00_REG_WL_L, &reg,
> +				sizeof(reg));

I don't mind slightly long lines if it helps readability.  Here I think it would
be nicer as:
	ret = regmap_bulk_write(data->regmap, VEML6031X00_REG_WL_L, &reg, sizeof(reg));

> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to set low threshold\n");
> +
> +	reg = cpu_to_le16(U16_MAX);
> +	ret = regmap_bulk_write(data->regmap, VEML6031X00_REG_WH_L, &reg,
> +				sizeof(reg));

Similar on slightly long lines.

> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to set high threshold\n");
> +
> +	ret = regmap_field_write(data->rf.int_en, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_read(data->regmap, VEML6031X00_REG_INT, &val);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to clear interrupts\n");
> +
> +	return 0;
> +}
> +
> +static int veml6031x00_setup_irq(struct i2c_client *i2c, struct iio_dev *iio)
> +{
> +	struct veml6031x00_data *data = iio_priv(iio);
> +	struct device *dev = data->dev;
> +	int ret;
> +
> +	data->trig = devm_iio_trigger_alloc(dev, "%s-drdy%d", iio->name,
> +					    iio_device_id(iio));
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
> +	ret = devm_request_threaded_irq(dev, i2c->irq, NULL,
> +					veml6031x00_interrupt,
> +					IRQF_ONESHOT,
> +					iio->name, iio);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to request irq %d\n",
> +				     i2c->irq);
> +
> +	iio->info = &veml6031x00_info;

As below - I'd set this in the caller.

> +
> +	return 0;
> +}
> +
> +static int veml6031x00_probe(struct i2c_client *i2c)
> +{
> +	struct device *dev = &i2c->dev;
> +	struct veml6031x00_data *data;
> +	struct iio_dev *iio;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	regmap = devm_regmap_init_i2c(i2c, &veml6031x00_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap),
> +				     "Failed to set regmap\n");
> +
> +	iio = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!iio)
> +		return -ENOMEM;
> +
> +	data = iio_priv(iio);
> +	i2c_set_clientdata(i2c, iio);
> +	data->dev = dev;
> +	data->regmap = regmap;
> +
> +	ret = devm_mutex_init(dev, &data->lock);
> +	if (ret)
> +		return ret;
> +
> +	ret = veml6031x00_regfield_init(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to init regfield\n");
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable regulator\n");
> +
> +	data->chip = i2c_get_match_data(i2c);
> +	if (!data->chip)
> +		return dev_err_probe(dev, -EINVAL, "Failed to get chip data\n");
> +
> +	ret = devm_add_action_or_reset(dev, veml6031x00_als_shutdown_action, data);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to add shutdown action\n");
> +
> +	ret = pm_runtime_set_active(dev);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to activate PM runtime\n");
> +
> +	ret = devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable PM runtime\n");
> +
> +	pm_runtime_get_noresume(dev);
> +	pm_runtime_set_autosuspend_delay(dev, VEML6031X00_AUTOSUSPEND_MS);
> +	pm_runtime_use_autosuspend(dev);
> +
> +	ret = veml6031x00_validate_part_id(data);
> +	if (ret)
> +		return ret;
> +
> +	iio->name = data->chip->name;
> +	iio->channels = veml6031x00_channels;
> +	iio->num_channels = ARRAY_SIZE(veml6031x00_channels);
> +	iio->modes = INDIO_DIRECT_MODE;
> +
> +	if (i2c->irq) {
> +		ret = veml6031x00_setup_irq(i2c, iio);
> +		if (ret < 0)
> +			return ret;

I'd drag the setting of info out of setup_irq() and having
it here just so it's obvious this is also picking between two
different versions of that.
(really minor!)

> +	} else {
> +		iio->info = &veml6031x00_info_no_irq;
> +	}
> +
> +	ret = veml6031x00_hw_init(iio);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, iio, NULL,
> +					      veml6031x00_trig_handler,
> +					      &veml6031x00_buffer_setup_ops);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to register triggered buffer\n");
> +
> +	pm_runtime_put_autosuspend(dev);
> +
> +	ret = devm_iio_device_register(dev, iio);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to register iio device\n");
> +
> +	return 0;
> +}

