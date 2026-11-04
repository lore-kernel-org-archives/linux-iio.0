Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793756225;
	b=MmALx15/O1LCytetM0W5MTOIfBxHhJyXbyoy40Prrc1sr6hp0X8SlSgFGPzKHacA1SFY
	 T3vx1l/MKSxf+htY+fXwcitmZvSJ7r8YJphn8iYUMdSSvlyLIpTvuC00rmei0T8veaasK
	 jVgPLsBYImN7XsLo0gjkXCDMPK496cqJvYY8i1vCZTLYrtUks6zOItYBE5fgDDPDmuiQ7
	 /FwjfIS0yiEurIevccTZPJZZijjfzvybSDTtgAjf107P583A8kGQNBA5UzWhgKq4mQABU
	 Qo7+aDp4S+yp5yKbiREd8XozNRZtXpXx7olZlRyXF7V9BwxN0KpDnFuATFONV9am+xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793756225;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=KcOaDBN09o3E/8dmEwrEb/9xgty5DmiykPHBXrYWIh0=;
	b=r1FiYxwiwUu4vFEyELuDaAxt+q9i64UeMFkbFU1OvnnmnslVO6u/bGYq0E8PwHK4FeEw
	 3uIWXxRPJTCb9vB9Jv4AjBNvW/UT5LegmyvCav6zPPyxbuvoGrxBEhK50SM9EQ/N2fBrp
	 mM2LkgdQPA0xFzfA9qXwiCLhLv7uv+G8avHE/8BHnwRv+PoIEM+U2kwk447Czvg3eXq+C
	 Nt0Cw1yP+IIWQhE8j5yq8A4fQAUeWrzeP62ZDvX+clN8iXSbYqQFamyqJ4MGJJfmw7YY8
	 Tpa2MmHMDwBtDVL4q5YV/pxn9LZ/VQu0uggmAP6olBeizoblMUVXgJbGXLFrjHbfASQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mMOankuS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6A9606A31B;
	Wed,  4 Nov 2026 01:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mMOankuS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4F41F000C1;
	Wed,  4 Nov 2026 01:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793756224;
	bh=KcOaDBN09o3E/8dmEwrEb/9xgty5DmiykPHBXrYWIh0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mMOankuSFIV7MeePKoV4Wj800cUtzlXjqNO9u0jEzceg2IVUmdSuLwgrd04chSeT8
	 mxhI/bXA0kqbLly2l/DsOns8BJbDSvlF6V0Yz///B47TJf65UHAUra+4l+lwT/0aKN
	 a08rFJtBNwHXv2MnrJdLuaRHttRFlk0+K3XqPFM8FDRQR3bJyiV+IIfqfxglplHCCE
	 YFvSH4PAqHQvP/uC8hrfc+KRBwN/XL4JG2XIAiO+K32vU0Facp9hxp1MfZ87WDEyy8
	 OGl8sJXxdpdsgfUqX184baY1VYrqXsX0BjOvGo80UDv5dlFXu1mHfUBS6CBB3XZYeC
	 rcca8b/EvVdPg==
Date: Wed, 4 Nov 2026 01:36:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Guenter Roeck <linux@roeck-us.net>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>, Neil
 Armstrong <neil.armstrong@linaro.org>, Marius Cristea
 <marius.cristea@microchip.com>
Subject: Re: [PATCH v5 5/5] iio: adc: add support for PAC1711
Message-ID: <20261104013657.66326d73@jic23-hlaptop>
In-Reply-To: <20261103-pac1711-v5-5-71c20101a52e@microchip.com>
References: <20261103-pac1711-v5-0-71c20101a52e@microchip.com>
	<20261103-pac1711-v5-5-71c20101a52e@microchip.com>
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

On Tue, 3 Nov 2026 16:37:15 +0200
Ariana Lazar <ariana.lazar@microchip.com> wrote:

> This is the iio driver for Microchip PAC1711, PAC1721, PAC1811 and
> PAC1821 single-channel power monitors with accumulator. The PAC1711 and
> PAC1721 devices use 12-bit resolution for voltage and current measurements
> and 24 bits for power calculations, while PAC1811 and PAC1821 have 16-bit
> resolution and use 32 bits for power calculations. The 56-bit accumulator
> register accumulates power (energy) or current (Coulomb counter).
> 
> PAC1711 and PAC1811 measure up to 42V Full-Scale Range, respectively 9V for
> PAC1721 and PAC1821.
> 
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
Hi Ariana

Various comments inline.  Biggest one is that i2c block reads of 2 bytes
are i2c smbus word reads unless I can't read the 'diagrams' in
https://www.kernel.org/doc/html/v5.5/i2c/smbus-protocol.html
I forgot about that until this read through.

Even better we have swapped variants for when a device puts the bytes
in big endian order.

In general I agree with Andy that there this driver needs a good
read through and tidy up. Various bits of inconsistent style
and odd code flow seems to have evolved.  Happens to us all
from time to time when working on too many versions of a driver!

Thanks,

Jonathan

> diff --git a/drivers/iio/adc/pac1711.c b/drivers/iio/adc/pac1711.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..6adc37a7ba0be882397a15b749bd9b1a657a96d6
> --- /dev/null
> +++ b/drivers/iio/adc/pac1711.c

> +
> +static int pac1711_reg_snapshot(struct pac1711_chip_info *info, bool *refreshed)
> +{
> +	u32 wait_time;
> +	int ret;
> +
> +	guard(mutex)(&info->lock);
> +
> +	/* No hardware refresh is needed */
> +	if (refreshed)
> +		*refreshed = false;
> +
> +	/* Return early if the minimum polling time hasn't elapsed */
> +	if (!time_after(jiffies, info->chip_reg_data.jiffies_tstamp +
> +			msecs_to_jiffies(PAC1711_MIN_POLLING_TIME_MS)))
> +		return 0;
> +
> +	wait_time = (1024 * 1000) / pac1711_samp_rate_map_tbl[info->sample_rate_idx];

3 of these?  helper.

> +
> +	/* A hardware refresh will happen */
> +	ret = pac1711_reg_snapshot_locked(info, wait_time);
> +	if (!ret && refreshed)
> +		*refreshed = true;
> +
> +	return ret;
> +}

> +
> +static int pac1711_set_acc_enable(struct pac1711_chip_info *info, int val)
> +{
> +	struct i2c_client *client = info->client;
> +	struct device *dev = &client->dev;
> +	u32 wait_time, sample_rate;
> +	int ret = 0;
> +
> +	if (val != 0 && val != 1)
> +		return -EINVAL;
> +
> +	guard(mutex)(&info->lock);
> +
> +	if (val == info->enable_acc)
> +		return 0;
> +
> +	/*
> +	 * Force a hardware refresh to zero out the internal accumulators
> +	 * and start a new measurement window, as the chip accumulates
> +	 * continuously in the background.
> +	 */
> +	if (val) {
> +		sample_rate = pac1711_samp_rate_map_tbl[info->sample_rate_idx];
> +		wait_time = (1024 * 1000) / sample_rate;
> +		ret = pac1711_send_refresh(info, wait_time);
> +	} else {
> +		info->chip_reg_data.acc_val = 0;
> +		info->chip_reg_data.vacc = 0;
> +		info->chip_reg_data.acc_count = 0;
> +	}
> +
> +	if (!ret)
> +		info->enable_acc = val;
> +
> +	if (ret)
> +		dev_err(dev, "failed to reset accumulator: %d\n", ret);
Move this ahead of the if (!ret)  then return from it.

	if (ret) {
		dev_err(dev, "failed to reset accumulator: %d\n", ret);
		return ret;
	}
	info->enable_acc = val;

	return 0;

is much easier to read.
	
> +
> +	return ret;
> +}

> +static int pac1711_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct pac1711_chip_info *info = iio_priv(indio_dev);
> +	int ret, shift;
> +	u64 tmp = 0;

Declare in more local scope (add {} to appropriate case statements
and it is always set there anyway so don't init.

> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = pac1711_retrieve_data(info);
> +		if (ret)
> +			return ret;
> +
> +		switch (chan->type) {
> +		case IIO_VOLTAGE: {
> +			guard(mutex)(&info->lock);
> +			*val = info->chip_reg_data.vbus;
> +			return IIO_VAL_INT;
> +		}
> +		case IIO_CURRENT: {
> +			guard(mutex)(&info->lock);
> +			*val = info->chip_reg_data.vsense;
> +			return IIO_VAL_INT;
> +		}
> +		case IIO_POWER: {
> +			guard(mutex)(&info->lock);
> +			iio_fill_val_int_64(info->chip_reg_data.vpower, val, val2);
> +			return IIO_VAL_INT_64;
> +		}
> +		case IIO_ENERGY:
> +		case IIO_CHARGE: {
> +			guard(mutex)(&info->lock);
> +			iio_fill_val_int_64(info->chip_reg_data.acc_val, val, val2);

Andy covered this. You raced with another helper being introduced that should work
fine for you as well.

> +			return IIO_VAL_INT_64;
> +		}
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SCALE: {
> +		u32 shunt;
> +
> +		guard(mutex)(&info->lock);
> +		shunt = info->shunt;
> +
> +		switch (chan->address) {
> +		case PAC1711_VBUS_REG_ADDR:
> +			*val = info->features->voltage_millivolts_max;
> +			*val2 = (info->vbus_mode == PAC1711_FULL_RANGE_BIPOLAR) ? 15 : 16;
> +
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		case PAC1711_VSENSE_REG_ADDR:
> +			/*
> +			 * Currents - scale for mA - depends on the channel's shunt value
> +			 * (100mV * 1000000) / (2^16 * shunt(uohm))
> +			 */
> +			*val = 1526;
> +			*val2 = shunt;
> +
> +			if (info->vsense_mode == PAC1711_FULL_RANGE_BIPOLAR)
> +				*val = *val << 1;
> +
> +			return IIO_VAL_FRACTIONAL;
> +		case PAC1711_VPOWER_REG_ADDR:
> +		case PAC1711_VACC_REG_ADDR:
> +			if (chan->type == IIO_CHARGE) {
> +				/*
> +				 * Coulomb counter scale:
> +				 * 16-bit resolution: (100mV * NANO) / 2^16
> +				 * 12-bit resolution: (100mV * NANO) / 2^12
> +				 */
> +				u64 ref = info->features->has_16bit_resolution ?
> +						  1525878906250ULL : 24414062500000ULL;
> +
> +				if (info->vsense_mode == PAC1711_FULL_RANGE_BIPOLAR)
> +					ref = ref << 1;
> +
> +				ref = div_u64(ref, shunt);
> +				*val2 = do_div(ref, 1 * NANO);
> +				*val = ref;
> +
> +				return IIO_VAL_INT_PLUS_NANO;
> +			}
> +
> +			/*
> +			 * Power - uW - it will use the combined scale
> +			 * for current and voltage
> +			 * current(mA) * voltage(mV) = power (uW)
> +			 */
> +			tmp = info->features->voltage_pv_fsr;
> +			do_div(tmp, shunt);
> +
> +			if (chan->type == IIO_ENERGY)
> +				*val2 = info->features->has_16bit_resolution ? 32 : 24;
> +			else
> +				*val2 = 32;
> +
> +			if (info->vsense_mode == PAC1711_FULL_RANGE_BIPOLAR)
> +				*val2 -= 1;
> +
> +			if (info->vbus_mode == PAC1711_FULL_RANGE_BIPOLAR)
> +				*val2 -= 1;
> +
> +			shift = fls64(tmp) - 31;
> +			if (shift > 0) {
> +				tmp >>= shift;
> +				*val2 -= shift;
> +			}
> +
> +			*val = (int)tmp;
> +
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +	case IIO_CHAN_INFO_SAMP_FREQ: {
> +		guard(mutex)(&info->lock);
> +		*val = pac1711_samp_rate_map_tbl[info->sample_rate_idx];
> +		return IIO_VAL_INT;
> +	}
> +	case IIO_CHAN_INFO_ENABLE:  {
> +		guard(mutex)(&info->lock);
> +		*val = info->enable_acc;
> +		return IIO_VAL_INT;
> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int pac1711_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct pac1711_chip_info *info = iio_priv(indio_dev);
> +	struct i2c_client *client = info->client;
> +	struct device *dev = &info->client->dev;
> +	int new_idx, ret, refresh_time;
> +	s32 old_samp_rate;
> +	__be16 val_be16;
> +	u32 wait_time;
> +	u16 val_u16;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ: 

	case IIO_CHAN_INFO_SAMP_FREQ: {
		guard(mutex)(&info->lock);

is commonly done to avoid excessive indent in switch statements
using guards.  Use it here.  You do so above, so clearly
were aware of this.  Please check for consistency things like
this through the whole driver.  Code will often evolve so that
the style becomes inconsistent.  Happens to us all!



> +		scoped_guard(mutex, &info->lock) {
> +			old_samp_rate = pac1711_samp_rate_map_tbl[info->sample_rate_idx];
> +			new_idx = pac1711_get_samp_rate_idx(val);
> +			if (new_idx < 0)
> +				return new_idx;
> +
> +			ret = i2c_smbus_read_i2c_block_data(client, PAC1711_CTRL_ACT_REG_ADDR,
> +							    sizeof(val_u16), (u8 *)&val_be16);
> +			if (ret != sizeof(val_u16)) {
> +				dev_err(&client->dev, "cannot read regs from 0x%02X\n",
> +					PAC1711_CTRL_ACT_REG_ADDR);
> +				return ret < 0 ? ret : -EIO;
> +			}
> +
> +			val_u16 = be16_to_cpu(val_be16);
> +			FIELD_MODIFY(PAC1711_CTRL_SAMPLE_MODE_MASK, &val_u16, new_idx);
> +			val_be16 = cpu_to_be16(val_u16);
> +			ret = i2c_smbus_write_i2c_block_data(client, PAC1711_CTRL_REG_ADDR,
> +							     sizeof(val_be16), (u8 *)&val_be16);
> +			if (ret) {
> +				dev_err(dev, "Failed to configure sampling mode in 0x%02X\n",
> +					PAC1711_CTRL_ACT_REG_ADDR);
> +				return ret;
> +			}
> +
> +			info->sample_rate_idx = new_idx;
> +			info->chip_reg_data.ctrl_act_reg = val_u16;
> +
> +			/* Force register snapshot and timestamp update with a refresh. */
> +			refresh_time = msecs_to_jiffies(PAC1711_MIN_POLLING_TIME_MS) + 1;
> +			info->chip_reg_data.jiffies_tstamp = jiffies - refresh_time;
> +			wait_time = (1024 * 1000) / old_samp_rate;
> +
> +			/*
> +			 * We must wait for cycle completion before updating the
> +			 * sample rate value.
> +			 */
> +			ret = pac1711_reg_snapshot_locked(info, wait_time);
> +			if (ret) {
> +				dev_err(dev, "%s - cannot snapshot ctrl and measurement regs\n",
> +					__func__);
> +				return ret;
> +			}
> +		}
> +
> +		return 0;
> +	case IIO_CHAN_INFO_ENABLE:
> +		return pac1711_set_acc_enable(info, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +

> +
> +static int pac1711_chip_identify(struct iio_dev *indio_dev, struct pac1711_chip_info *info)
> +{
> +	struct i2c_client *client = info->client;
> +	struct device *dev = &client->dev;
> +	u8 chip_rev_info[3] = { };
> +	int ret;
> +
> +	ret = i2c_smbus_read_i2c_block_data(client, PAC1711_PID_REG_ADDR,
> +					    sizeof(chip_rev_info), chip_rev_info);
> +	if (ret != sizeof(chip_rev_info)) {
> +		ret = ret < 0 ? ret : -EIO;
> +		return dev_err_probe(dev, ret, "product ID not recognized\n");
> +	}
> +
> +	info->features = pac1711_get_features_from_id(chip_rev_info[0]);

I'll ask a silly question.  Can you just read the first byte if
we don't care about the other 2?   Would be a bit unusual for that to
cause trouble on an i2c device. If it does, add a comment.

> +	if (!info->features)
> +		return -ENODEV;
> +
> +	indio_dev->name = info->features->name;
> +
> +	return 0;
> +}


> +
> +static int pac1711_chip_configure(struct pac1711_chip_info *info)
> +{
> +	struct i2c_client *client = info->client;
> +	struct device *dev = &client->dev;
> +	__be16 val_be16;
> +	u32 wait_time;
> +	u16 val_u16;
> +	u8 val_u8;
> +	int ret;
> +
> +	/*
> +	 * The current/voltage can be measured unidirectional, bidirectional or half FSR
> +	 * no SLOW triggered REFRESH, clear POR
> +	 */
> +	val_u8 = FIELD_PREP(PAC1711_NEG_PWR_FSR_VS_MASK, info->vsense_mode) |
> +		FIELD_PREP(PAC1711_NEG_PWR_FSR_VB_MASK, info->vbus_mode);
> +
> +	ret = i2c_smbus_write_byte_data(client, PAC1711_NEG_PWR_FSR_REG_ADDR, val_u8);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "cannot write 0x%02X reg\n",
> +				     PAC1711_NEG_PWR_FSR_REG_ADDR);
> +
> +	ret = i2c_smbus_write_byte_data(client, PAC1711_SLOW_REG_ADDR, 0);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "cannot write 0x%02X reg\n", PAC1711_SLOW_REG_ADDR);
> +
> +	/* Get sampling rate from PAC */
> +	ret = i2c_smbus_read_i2c_block_data(client, PAC1711_CTRL_REG_ADDR,
> +					    sizeof(val_u16), (u8 *)&val_be16);

With two bytes is this different from i2c_smbus_read_word_data(). I checked
the protocol docs and don't think it is.

Fun bit is that assumes little endian.
So if it's big endian like here i2c_smbus_read_word_swapped() does the work for
you.

Check for other places this applies (assuming I'm not missing something).



> +	if (ret != sizeof(val_u16))
> +		return dev_err_probe(dev, ret < 0 ? ret : -EIO,
> +				     "cannot read 0x%02X reg\n", PAC1711_CTRL_REG_ADDR);
> +
> +	val_u16 = be16_to_cpu(val_be16);
> +	info->sample_rate_idx = FIELD_GET(PAC1711_CTRL_SAMPLE_MODE_MASK, val_u16);
> +	if (info->sample_rate_idx >= ARRAY_SIZE(pac1711_samp_rate_map_tbl)) {
> +		/*
> +		 * Use default sample rate in case the chip is configured with an sample
> +		 * rate unsupported by the driver. The Control Register is updated.
> +		 */
> +		info->sample_rate_idx = PAC1711_SAMP_1024SPS;
> +		FIELD_MODIFY(PAC1711_CTRL_SAMPLE_MODE_MASK, &val_u16, info->sample_rate_idx);
> +	}
> +
> +	/* Configure the accumulation mode */
> +	FIELD_MODIFY(PAC1711_CTRL_ACC_MODE_MASK, &val_u16, info->accumulation_mode);
> +	val_be16 = cpu_to_be16(val_u16);
> +	ret = i2c_smbus_write_i2c_block_data(client, PAC1711_CTRL_REG_ADDR,
> +					     sizeof(val_be16), (u8 *)&val_be16);

There is a i2c_smbus_write_word_swapped() as well that I think should work here.

> +	if (ret)
> +		return dev_err_probe(dev, ret, "cannot write 0x%02X reg\n", PAC1711_CTRL_REG_ADDR);
> +
> +	/*
> +	 * Sending a REFRESH to the chip, so the new settings take place
> +	 * as well as resetting the accumulators
> +	 */
> +	ret = i2c_smbus_write_byte(client, PAC1711_REFRESH_REG_ADDR);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "cannot write 0x%02X reg\n",
> +				     PAC1711_REFRESH_REG_ADDR);
> +
> +	/*
> +	 * Get the current (in the chip) sampling speed and compute the
> +	 * required timeout based on its value the timeout is 1/sampling_speed
> +	 * wait the maximum amount of time to be on the safe side - the
> +	 * maximum wait time is for 8sps
> +	 */
> +	wait_time = ((1024 * 1000) / pac1711_samp_rate_map_tbl[info->sample_rate_idx]);

Excess brackets + helper as suggested below with that comment with the helper.
Check whole patch for the brackets issue - I haven't looked that carefully
and where this is one instance of this - others often hide!


> +	fsleep(wait_time);
> +
> +	/*
> +	 * VACC and ACC_COUNT registers increment continuously in hardware and do not
> +	 * roll over, so without a periodic Refresh (any) command before the worst-case
> +	 * overflow time is reached, the accumulated data would be silently lost.
> +	 *
> +	 * A periodic refresh works regardless of board pin configuration, while
> +	 * A0/A1 pins are optional (shared with SLOW/GPIO functions and may not be
> +	 * wired as ALERT on every board).
> +	 */
> +	INIT_DELAYED_WORK(&info->work_chip_refresh, pac1711_work_periodic_refresh);
> +	/* Setup the latest moment for reading the regs before saturation */
> +	schedule_delayed_work(&info->work_chip_refresh,
> +			      msecs_to_jiffies(PAC1711_MAX_RFSH_LIMIT_MS));
> +
> +	return devm_add_action_or_reset(&client->dev, pac1711_cancel_delayed_work,
> +					&info->work_chip_refresh);
> +}

> +
> +static int pac1711_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct pac1711_chip_info *info;
> +	struct iio_dev *indio_dev;
> +	u32 wait_time;
> +	int ret, err;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*info));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	info = iio_priv(indio_dev);
> +	info->client = client;
> +
> +	ret = pac1711_chip_identify(indio_dev, info);
> +	if (ret == -ENODEV) {
> +		/*
> +		 * If it fails to identify the hardware based on internal
> +		 * registers, use compatible from devicetree.
> +		 */
> +		info->features = i2c_get_match_data(client);
> +		if (!info->features)
> +			return -EINVAL;
> +
> +		indio_dev->name = info->features->name;
> +	} else if (ret) {
> +		return dev_err_probe(&client->dev, ret, "Failed to identify chip\n");
> +	}
> +
> +	/* Always start with accumulation channels enabled. */
> +	info->enable_acc = true;
> +
> +	err = pac1711_parse_fw(client, info);
> +	if (err)
> +		return dev_err_probe(dev, err, "Error parsing devicetree data\n");
> +
> +	ret = devm_mutex_init(dev, &info->lock);
> +	if (ret)
> +		return ret;
> +
> +	ret = pac1711_chip_configure(info);
> +	if (ret)
> +		return ret;
> +
> +	info->iio_info = pac1711_info;
> +	indio_dev->info = &info->iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = pac1711_setup_channels(indio_dev, info);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Invalid channel configuration\n");
> +
> +	/* Read what has been accumulated in the chip so far and reset the accumulators. */
> +	wait_time = (1024 * 1000) / pac1711_samp_rate_map_tbl[info->sample_rate_idx];

This is repeated a number of times.  A helper function with one clear comment for why it is
this particular form would be helpful.

> +	scoped_guard(mutex, &info->lock) {
> +		ret = pac1711_reg_snapshot_locked(info, wait_time);
> +		if (ret)
> +			return ret;
> +	}

