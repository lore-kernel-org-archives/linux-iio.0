Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1ED389473;
	Mon,  1 Jun 2026 10:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309277; cv=none; b=jXhjJ6glgxL3jOgxMb67qGi9eNt6bvDn1UTggMsNdMT/HCWl4gfCIjjqa+Z4x9Oa3hrT1VwPPwCnZD7lH/ZFl1JOpedMWxs6u58JvhzAQVb+Wtl1xTgDL+qWnsKZqI1NvpuFz42pSaphizfd3M8kaeqA0dVJjflO7sjz/8eHAhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309277; c=relaxed/simple;
	bh=rsZEV4L1yTsTC+P8M/+rqFCVR0XH7vlrSlbwFShPaVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dubuL4AMMmkTtR1Ieibb4O3VcWx5AfP6WVo5AzEIox005C5J0bDBqm1LK/c+gxinX+An5KEiMhDTIwkt+P+YeTl3LkF4qpFqjEHknlyki0UxEiZ94c+EpDPHH8ax0m09a4MOA/s5pI4tYUdGftlrGOKKJ2+FXEdYtr2H1UuOMDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lk1HGV3+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lk1HGV3+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCBEF1F00893;
	Mon,  1 Jun 2026 10:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780309273;
	bh=gHsImc1SKwNheenRWKGBzYrdMP5pDqP0yuhUbCayxuc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lk1HGV3+6viJQM3dBwuPNbVWi2s8K5llML7ku7B8jqfDk3Gwc/P+DYisQgW5ZoGnm
	 Q/H59mKEMM2cdl8BYHQPG4Hxc2JkIIXPBy6a0QAA9BLb1S/UPZ/JRUM7cnSEaBeydP
	 jlRMMYeSh9s6BL1cIMCo0lIzzKar33E+QBMCgTRdiRK9odXkDzWIjxKs7mNPqkZrOF
	 QOf76P7WLVqL0D0MGa70UmPfvloQEK2rnbovC8a98AIutm4m/4T6DyH0cZIy/gUImO
	 /XO5sIZdoayYnbHevgK575EybHMA9Hvv1AqM4w9oNAtzFF+5R03TaMpu2I9L7iHcvQ
	 VIfBxpLjQvpQw==
Date: Mon, 1 Jun 2026 11:21:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] iio: light: add support for veml6031x00 ALS
 series
Message-ID: <20260601112103.281387ee@jic23-huawei>
In-Reply-To: <20260531-veml6031x00-v4-2-e64f7fdce38d@gmail.com>
References: <20260531-veml6031x00-v4-0-e64f7fdce38d@gmail.com>
	<20260531-veml6031x00-v4-2-e64f7fdce38d@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 31 May 2026 21:58:22 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> These sensors provide two light channels (ALS and IR), I2C communication
> and a multiplexed interrupt line to signal data ready and configurable
> threshold alarms.
> 
> This first implementation provides basic functionality (measurement
> configuration, raw reads and ID validation) and defines the different
> register regions in preparation for extended features in the subsequent
> patches of the series.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
A few comments from sashiko and a couple from me based on a fresh read.


> diff --git a/drivers/iio/light/veml6031x00.c b/drivers/iio/light/veml6031x00.c
> new file mode 100644
> index 000000000000..6f9a7bad44d4
> --- /dev/null
> +++ b/drivers/iio/light/veml6031x00.c

> +
> +static const struct iio_chan_spec veml6031x00_channels[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.address = VEML6031X00_REG_ALS_L,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME),
> +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
> +	},
> +	{
> +		.type = IIO_INTENSITY,
> +		.address = VEML6031X00_REG_IR_L,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_LIGHT_IR,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),

Can we move scale to shared_by_type?

Thinking on some of the others, they should probably be shared_by_type as well
rather than shared_by_all. If we ever add buffered support and a timestamp
the integration_time doesn't apply to that. 

shared_by_all tends to only include things that are truely universal like
sampling_frequency.


> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME),
> +	},
> +};

> +
> +static int veml6031x00_get_it(struct veml6031x00_data *data, int *val2)
> +{
> +	int ret, it_idx;
> +
> +	scoped_guard(mutex, &data->scale_lock) {

Given below I suggest you need an unlocked variant of this, maybe
think about whether we care if the scope includes the table search.

I'd just take the lock for the whole function.

> +		ret = regmap_field_read(data->rf.it, &it_idx);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = iio_gts_find_int_time_by_sel(&data->gts, it_idx);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val2 = ret;
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}

> +
> +static int veml6031x00_single_read(struct iio_dev *iio, enum iio_chan_type type,
> +				   int *val)
> +{
> +	struct veml6031x00_data *data = iio_priv(iio);
> +	int addr, it_usec, ret;
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
> +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(data->dev, pm);
> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
> +
> +	ret = veml6031x00_get_it(data, &it_usec);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* integration time + 10 % to ensure completion */
> +	fsleep(it_usec + (it_usec / 10));
> +
> +	ret = regmap_bulk_read(data->regmap, addr, &reg, sizeof(reg));
> +	if (ret)
> +		return ret;

https://sashiko.dev/#/patchset/20260531-veml6031x00-v4-0-e64f7fdce38d%40gmail.com

Hmm. Sashiko shouts race here. It is kind of correct in that we don't know
if we have a matching pair of integration time and reading. Thus we might
have
Thread 1                           Thread 2
Power on.                           
Get small integration time           
                                   Set large integration time
read before new integration done.

Whether this is bug kind of depends on the device when the integration time
is updated.  Does it finish current integration with old one, or does it just
update some register against which a comparator is running. So if we are
already integrating, do we just integrate for longer before stopping?

I haven't checked but this smells like kind of thing a datasheet won't tell
us.  Hence I'd be tempted to throw use of data->mutex to serialize single
reads and integration time updates + anything related to that).  It's
harmless at worst and makes it easier to reason about this code.
You'll need an unlocked  __veml6031x00_get_it() variant to call though
given that takes the same lock. 



 


> +
> +	*val = le16_to_cpu(reg);
> +	return IIO_VAL_INT;
> +}

> +
> +static int veml6031x00_validate_part_id(struct veml6031x00_data *data)
> +{
> +	int part_id, ret;
> +	__le16 reg;
> +
> +	ret = regmap_bulk_read(data->regmap, VEML6031X00_REG_ID_L, &reg,
> +			       sizeof(reg));
> +	if (ret)
> +		return dev_err_probe(data->dev, ret, "Failed to read ID\n");
> +
> +	part_id = le16_to_cpu(reg);
> +	if (part_id != data->chip->part_id)
> +		dev_warn(data->dev, "Unknown ID %04x\n", part_id);

Maybe relax to dev_info() given we expect this to happen if fallback
compatibles get used in future. Warn is a little strong.

> +
> +	return 0;
> +}

> +static int veml6031x00_probe(struct i2c_client *i2c)
> +{

> +	pm_runtime_set_autosuspend_delay(dev, 2000);
> +	pm_runtime_use_autosuspend(dev);
> +	ret = devm_pm_runtime_set_active_enabled(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
> +
> +	ret = devm_pm_runtime_get_noresume(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get runtime PM\n");
> +
> +	ret = veml6031x00_validate_part_id(data);
> +	if (ret)
> +		return ret;
> +
> +	iio->name = data->chip->name;
> +	iio->channels = veml6031x00_channels;
> +	iio->num_channels = ARRAY_SIZE(veml6031x00_channels);
> +	iio->modes = INDIO_DIRECT_MODE;
> +	iio->info = &veml6031x00_info;
This block doesn't need to happen in the runtime pm region.
> +
> +	ret = veml6031x00_hw_init(iio);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_put_autosuspend(dev);

As sashiko shouts, this looks like runtime pm will underflow on remove.
Check it by removing your driver.  It doesn't actually result in any 
problem, as the runtime pm subsystem just saturates at 0 on decrement.
Given that's tear down anyway maybe we don't care.  However, it's easy
enough to fix by using pm_runtime_get_no_resume() and a couple of
explicit calls to put it in error paths.





> +
> +	ret = devm_iio_device_register(dev, iio);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to register iio device\n");
> +
> +	return 0;
> +}

> 

