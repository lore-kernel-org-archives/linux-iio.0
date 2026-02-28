Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2036843DA32;
	Sat, 28 Feb 2026 13:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772283965; cv=none; b=L/kx/omhRO8bT84iPYDvpz3XAk1sANEwE4DsRY1aBqfJyoowwlS/vO22xgT10yyWqg5r+zr7EzBkWhdxss+GaPrZzryXaC1V78tbxsWi3bCqawC1/du1PLN6R9Tqc4eJFO8dLeuwHOEjhhgfNnt1Zdsem0A/Sdhwg2vlwN5zMz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772283965; c=relaxed/simple;
	bh=oi7/362Nu4qtKLX/yc/nGD8St7Yg23Ena4EFxgIb9iY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WCTByJXVRzOydikNOBaC8aDxn7gWVbbo8W64/2j0o2YO0cbqQK6sGVYMMyQmFsWYNt4W8hmnakQM4ybasMIMWwo3BV8rSa59GZKsdO3HlVOtKF7x+himZUQvgkAXAR5Cq4YeIATCuP/mrHMSbA27E1lG08oxF4577ISVDSYkzXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0ZUTeQo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0ZUTeQo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D9CC116D0;
	Sat, 28 Feb 2026 13:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772283965;
	bh=oi7/362Nu4qtKLX/yc/nGD8St7Yg23Ena4EFxgIb9iY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r0ZUTeQovFV8bbe4lZA1hS9N967gtdfkjOAa/cfk5mh3Ab/EMP5RoJ3BF7ojBWT3a
	 xkFojGCijm+7Ri4nqpGxClWcRNVIKrWJyDqpswZseZcvbQoAhpSgDDUVa1NbjSM9mV
	 hqRU1lkjd1fByqI0Uon1oFOqx1/gEmlCaxCk4ocABESZsitCoAgr1wUhDMDvalsIor
	 REjqMhRLYPAFWZTLfo2+a5WiUvSMlr9yBKV9nJpSLnGYzKw728uCcwb5pQK35I4xnm
	 AyzQoIuIIG7Q+lxAYOTPGslbgtL05dJsJuiYKZcw0ZxBZqS907/qcpJEkAFrOA7JO3
	 MhIOfsY4LlP/Q==
Date: Sat, 28 Feb 2026 13:05:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 2/2] iio: temperature: add ADI MAX30210 driver
Message-ID: <20260228130556.25782f89@jic23-huawei>
In-Reply-To: <20260226163041.169786-3-johnerasmusmari.geronimo@analog.com>
References: <20260226163041.169786-1-johnerasmusmari.geronimo@analog.com>
	<20260226163041.169786-3-johnerasmusmari.geronimo@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Feb 2026 00:30:41 +0800
John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com> wrote:

> MAX30210 =C2=B10.1=C2=B0C Accurate Ultra-Small Low-Power Digital Temperat=
ure Sensor

For a temperature sensor, this description doesn't give enough detail
on why you are proposing an IIO driver rather than a hwmon one.

Please add more for v2.  Focus on what the part is and features you are sup=
porting
that don't have a path to being supporting in hwmon. E.g. the fifo.

The other thing to add a brief note on is why this support cannot be easily
added to an existing driver.
>=20
> Signed-off-by: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analo=
g.com>
Various additional comments inline from me.

Welcome to IIO!

Jonathan


> diff --git a/drivers/iio/temperature/max30210.c b/drivers/iio/temperature=
/max30210.c
> new file mode 100644
> index 000000000000..aaa3a26be131
> --- /dev/null
> +++ b/drivers/iio/temperature/max30210.c
> @@ -0,0 +1,758 @@

> +
> +#define MAX30210_STATUS_REG		0x00
> +#define MAX30210_INT_EN_REG		0x02
> +#define MAX30210_FIFO_DATA_REG		0x08
> +#define MAX30210_FIFO_CONF_1_REG	0x09
> +#define MAX30210_FIFO_CONF_2_REG	0x0A
> +#define MAX30210_SYS_CONF_REG		0x11
> +#define MAX30210_PIN_CONF_REG		0x12
> +#define MAX30210_TEMP_ALM_HI_REG	0x22
> +#define MAX30210_TEMP_ALM_LO_REG	0x24
> +#define MAX30210_TEMP_INC_THRESH_REG	0x26
> +#define MAX30210_TEMP_DEC_THRESH_REG	0x27
> +#define MAX30210_TEMP_CONF_1_REG	0x28
> +#define MAX30210_TEMP_CONF_2_REG	0x29
> +#define MAX30210_TEMP_CONV_REG		0x2A
> +#define MAX30210_TEMP_DATA_REG		0x2B
> +#define MAX30210_TEMP_SLOPE_REG		0x2D
> +#define MAX30210_UNIQUE_ID_REG		0x30
> +#define MAX30210_PART_ID_REG		0xFF
> +
> +#define MAX30210_A_FULL_MASK   BIT(7)

I'm very keen that field names reflect which register they are in.
That makes it much easier to review whether they are being correctly
used.  Usual way to do that is have a prefix that incorporates enough=20
of the register name to work out that mapping.

> +#define MAX30210_TEMP_RDY_MASK BIT(6)
> +#define MAX30210_TEMP_DEC_MASK BIT(5)
> +#define MAX30210_TEMP_INC_MASK BIT(4)
> +#define MAX30210_TEMP_LO_MASK  BIT(3)
> +#define MAX30210_TEMP_HI_MASK  BIT(2)
> +#define MAX30210_PWR_RDY_MASK  BIT(0)
> +
> +#define MAX30210_FLUSH_FIFO_MASK BIT(4)
> +
> +#define MAX30210_EXT_CNV_EN_MASK	BIT(7)
> +#define MAX30210_EXT_CVT_ICFG_MASK	BIT(6)
> +#define MAX30210_INT_FCFG_MASK		GENMASK(3, 2)
> +#define MAX30210_INT_OCFG_MASK		GENMASK(1, 0)
> +
> +#define MAX30210_CHG_DET_EN_MASK	BIT(3)
> +#define MAX30210_RATE_CHG_FILTER_MASK	GENMASK(2, 0)
> +
> +#define MAX30210_TEMP_PERIOD_MASK	GENMASK(3, 0)
> +#define MAX30210_ALERT_MODE_MASK	BIT(7)
> +
> +#define MAX30210_AUTO_MASK	BIT(1)
> +#define MAX30210_CONV_T_MASK	BIT(0)
> +
> +#define MAX30210_PART_ID		0x45
> +#define MAX30210_FIFO_SIZE		64
> +#define MAX30210_FIFO_INVAL_DATA	GENMASK(23, 0)
> +#define MAX30210_WATERMARK_DEFAULT	(0x40 - 0x1F)
> +
> +#define MAX30210_INT_EN(state, mask)	((state) ? (mask) : 0x0)
Use regmap_assign_bits() to replace this macro.


> +
> +struct max30210_state {
> +	/*
> +	 * Prevent simultaneous access to the i2c client.
Why does that matter?  I'd imagine you have some read / modify write
sequences or need to not change the mode whilst something else is going
on?

> +	 */
> +	struct mutex lock;
> +	struct regmap *regmap;
> +	struct iio_trigger *trig;
> +	struct gpio_desc *powerdown_gpio;
> +	u8 watermark;
> +	u8 data[3 * MAX30210_FIFO_SIZE]  __aligned(IIO_DMA_MINALIGN);
> +};

> +static int max30210_read_temp(struct regmap *regmap, unsigned int reg,
> +			      int *temp)
> +{
> +	u8 uval[2] __aligned(IIO_DMA_MINALIGN);

As below, forcing alignment on the stack doesn't work for this purpose.
Needs to be on the heap. Put it next to data in the _state structure.

However, this is an i2c driver. I2C doesn't have any such requirements
on buffer alignment because it always bounce buffers data if needed.


> +	int ret;
> +
> +	ret =3D regmap_bulk_read(regmap, reg, uval, 2);
> +	if (ret)
> +		return ret;
> +
> +	*temp =3D sign_extend32(get_unaligned_be16(uval), 15);
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int max30210_write_temp(struct regmap *regmap, unsigned int reg,
> +			       int temp)
> +{
> +	u8 uval[2] __aligned(IIO_DMA_MINALIGN);

You've miss understood the purpose of IIO_DMA_MINALIGN.
Make sure to look into that but the short answer is you can't do it on the =
stack.

> +
> +	put_unaligned_be16(temp, uval);
> +
> +	return regmap_bulk_write(regmap, reg, uval, 2);
Use a __be16 type for the buffer and then sizeof() for the 2

> +}
> +
> +static void max30210_fifo_read(struct iio_dev *indio_dev)
> +{
> +	struct max30210_state *st =3D iio_priv(indio_dev);
> +	u32 samp;
> +	int ret, i, j;
> +
> +	ret =3D regmap_bulk_read(st->regmap, MAX30210_FIFO_DATA_REG,
> +			       st->data, 3 * st->watermark);
> +	if (ret < 0)
> +		return dev_err(&indio_dev->dev, "Failed to read from fifo.\n");
> +
> +	for (i =3D 0; i < st->watermark; i++) {

		u32 samp =3D 0;

> +		samp =3D 0;
> +
> +		for (j =3D 0; j < 3; j++) {
> +			samp <<=3D 8;
> +			samp |=3D st->data[3 * i + j];

Looks like get_unaligned_be24() or similar. Use that instead of opencoding
the endian conversion.  However, you are claiming this is a big endian chan=
nel
and this is an endian conversion so something is wrong.  If you keep it as
a big endian channel, this probably wants to be simply memcpy()




> +		}
> +
> +		if (samp =3D=3D MAX30210_FIFO_INVAL_DATA) {
> +			dev_err(&indio_dev->dev, "Invalid data\n");
> +			continue;
> +		}
> +
> +		iio_push_to_buffers(indio_dev, &samp);
> +	}
> +}
> +
> +static irqreturn_t max30210_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf =3D p;
> +	struct iio_dev *indio_dev =3D pf->indio_dev;
> +	struct max30210_state *st =3D iio_priv(indio_dev);
> +	unsigned int status;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret =3D regmap_read(st->regmap, MAX30210_STATUS_REG, &status);
> +	if (ret) {
> +		dev_err(&indio_dev->dev, "Status byte read error\n");
> +		goto exit_irq;
> +	}
> +
> +	if (status & MAX30210_PWR_RDY_MASK) {
> +		dev_info(&indio_dev->dev, "power-on\n");

dev_dbg() at most.

> +		st->watermark =3D MAX30210_WATERMARK_DEFAULT;
> +	}
> +
> +	if (status & MAX30210_A_FULL_MASK)
> +		max30210_fifo_read(indio_dev);
> +
> +	if (status & MAX30210_TEMP_HI_MASK)
This is unusual.  If you have a single interrupt for both trigger
and thresholds then you can't use iio_trigger_generic_data_rdy_poll()

The main interrupt handler needs to work out what has happened then
ultimately use iio_trigger_poll_nested() to fire of the data capture.

However, there is a hardware fifo going on here. So what benefit
is the trigger providing?  Triggers are optional and often not appropriate
when there are hardware fifos present because it is not useful to use
them to capture data from other devices etc.  So just drop the trigger
here and have this as the main irq handler.

> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_RISING),
> +			       iio_get_time_ns(indio_dev));
> +
> +	if (status & MAX30210_TEMP_LO_MASK)
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_FALLING),
> +			       iio_get_time_ns(indio_dev));
> +
> +exit_irq:

Whilst this is not buggy the advice (see cleanup.h comments) is never
combine gotos and guard() / __free() in one function. There are some evil c=
orner
case and GCC at least doesn't catch them all.  Various ways to refactor
the code to avoid the mix.

> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}

> +
> +static int max30210_validate_trigger(struct iio_dev *indio_dev,
> +				     struct iio_trigger *trig)
> +{
> +	struct max30210_state *st =3D iio_priv(indio_dev);
> +
> +	if (st->trig !=3D trig)
> +		return -EINVAL;
Can you use iio_validate_own_trigger()?
They should both have the same parent.

> +
> +	return 0;

> +static int max30210_write_event(struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan,
> +				enum iio_event_type type,
> +				enum iio_event_direction dir,
> +				enum iio_event_info info, int val, int val2)
> +{
> +	struct max30210_state *st =3D iio_priv(indio_dev);
> +
> +	if (info =3D=3D IIO_EV_INFO_VALUE) {
Can flip the logic to reduce indent.
	if (info !=3D IIO_EV_INFO_VALUE)
		return -EINVAL;

	switch()

> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			switch (type) {
> +			case IIO_EV_TYPE_THRESH:
> +				return max30210_write_temp(st->regmap,
> +							   MAX30210_TEMP_ALM_HI_REG, val);
> +			default:
> +				return -EINVAL;
> +			}
> +			break;

As below (check for other instances of this)

> +		case IIO_EV_DIR_FALLING:
> +			switch (type) {
> +			case IIO_EV_TYPE_THRESH:
> +				return max30210_write_temp(st->regmap,
> +							   MAX30210_TEMP_ALM_LO_REG, val);
> +			default:
> +				return -EINVAL;
> +			}
> +			break;

Can't get here so drop the break.

> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}

> +
> +static int max30210_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int *val,
> +			     int *val2, long mask)
> +{
> +	struct max30210_state *st =3D iio_priv(indio_dev);
> +	unsigned int uval;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		*val =3D 5;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret =3D regmap_read(st->regmap, MAX30210_TEMP_CONF_2_REG, &uval);
> +		if (ret)
> +			return ret;
> +
> +		uval =3D FIELD_GET(MAX30210_TEMP_PERIOD_MASK, uval);
> +
> +		*val =3D 8;
> +
> +		/**

/*=20
See below and run a W=3D1 build which will probably complain about this.

> +		 * register values 0x9 or above have the same sample
> +		 * rate of 8Hz
> +		 */
> +		*val2 =3D uval >=3D 0x9 ? 1 : BIT(0x9 - uval);
> +
> +		return IIO_VAL_FRACTIONAL;
> +	case IIO_CHAN_INFO_RAW:
> +		ret =3D iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D regmap_write(st->regmap, MAX30210_TEMP_CONV_REG,
> +				   MAX30210_CONV_T_MASK);
> +		if (ret)
> +			goto release_dmode;
> +
> +		fsleep(8000);

Add a spec reference for this.

> +
> +		ret =3D max30210_read_temp(st->regmap, MAX30210_TEMP_DATA_REG, val);
> +
> +release_dmode:

Labels for gotos inside a switch are not a good thing to do for readability.
We have the new ACQUIRE() stuff that David mentioned, but if that isn't app=
ropriate
I'd suggest factoring out some of the code here so you can avoid the goto.

> +		iio_device_release_direct_mode(indio_dev);
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +}
> +
> +static int max30210_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan, int val,
> +			      int val2, long mask)
> +{
> +	struct max30210_state *st =3D iio_priv(indio_dev);
> +	u64 data;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret =3D iio_device_claim_direct_mode(indio_dev);

Others pointed out this needs to be based on upstream where that
particular function has gone away.

> +		if (ret)
> +			return ret;
> +
> +		/**
Not kernel-doc style so /*

> +		 * micro_value =3D val * 1000000 + val2
> +		 * reg_value =3D ((micro_value * 64) / 1000000) - 1

Except that's not the reg_val, because you then call fls() on it.

> +		 */
> +		data =3D (val * MICRO + val2) << 6;
> +		do_div(data, MICRO);
> +
> +		data =3D fls_long(data - 1);

This is unusual enough I'd add a comment on the maths.

> +		data =3D FIELD_PREP(MAX30210_TEMP_PERIOD_MASK, data);

Use a different variable of the appropriate type to store the result.
That way no need for a cast below.

> +
> +		ret =3D regmap_update_bits(st->regmap, MAX30210_TEMP_CONF_2_REG,
> +					 MAX30210_TEMP_PERIOD_MASK,
> +					 (unsigned int)data);
> +
> +		iio_device_release_direct_mode(indio_dev);
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}


> +
> +static const struct iio_dev_attr *max30210_fifo_attributes[] =3D {
> +	&iio_dev_attr_hwfifo_watermark_min,
> +	&iio_dev_attr_hwfifo_watermark_max,
> +	&iio_dev_attr_hwfifo_watermark,
> +	NULL,

No comma for a null terminator.  Doesn't add anything useful and
makes it easier to put things after this (which is obviously a bug).

> +};
> +
> +static int max30210_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct max30210_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	ret =3D regmap_update_bits(st->regmap, MAX30210_INT_EN_REG,
> +				 MAX30210_A_FULL_MASK, MAX30210_A_FULL_MASK);

regmap_set_bits() just avoids repeating the mask.


> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_update_bits(st->regmap, MAX30210_FIFO_CONF_2_REG,
> +				 MAX30210_FLUSH_FIFO_MASK,
> +				 MAX30210_FLUSH_FIFO_MASK);

set bits is fine here.  I assume it auto-clears?


> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(st->regmap, MAX30210_TEMP_CONV_REG,
> +			   MAX30210_AUTO_MASK | MAX30210_CONV_T_MASK);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

return regmap_write()

> +}
> +
> +static int max30210_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct max30210_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	ret =3D regmap_update_bits(st->regmap, MAX30210_INT_EN_REG,
> +				 MAX30210_A_FULL_MASK, 0x0);
Tiny bit simpler as
	ret =3D regmap_clear_bits(st->regmap, MAX30210_INT_EN_REG,
				MAX30210_A_FULL_MASK);

> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_update_bits(st->regmap, MAX30210_FIFO_CONF_2_REG,
> +				 MAX30210_FLUSH_FIFO_MASK,
> +				 MAX30210_FLUSH_FIFO_MASK);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(st->regmap, MAX30210_TEMP_CONV_REG, 0x0);

return regmap_write();

I'm a bit surprised by the ordering in here (I haven't looked at the datash=
eet).
Mostly we'd expect the tear down of settings to be the reverse of setup. He=
re
that probably means that final write belongs before the flushing of the fif=
o.

> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static const struct iio_buffer_setup_ops max30210_buffer_ops =3D {
> +	.preenable =3D max30210_buffer_preenable,
> +	.postdisable =3D max30210_buffer_postdisable,
> +};
> +
> +static const struct iio_info max30210_info =3D {
> +	.read_raw =3D max30210_read_raw,
> +	.read_avail =3D max30210_read_avail,
> +	.write_raw =3D max30210_write_raw,
> +	.write_raw_get_fmt =3D max30210_write_raw_get_fmt,
> +	.hwfifo_set_watermark =3D max30210_set_watermark,
> +	.debugfs_reg_access =3D &max30210_reg_access,

Why & for some function pointers and not others?

> +	.validate_trigger =3D &max30210_validate_trigger,
> +	.read_event_value =3D max30210_read_event,
> +	.write_event_value =3D max30210_write_event,
> +	.write_event_config =3D max30210_write_event_config,
> +	.read_event_config =3D max30210_read_event_config,
> +};

> +
> +static const struct iio_chan_spec max30210_channels =3D {
> +	.type =3D IIO_TEMP,
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> +			      BIT(IIO_CHAN_INFO_SCALE) |
> +			      BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +	.info_mask_separate_available =3D BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +	.output =3D 0,

0 is a natural default for a boolean type thing like .output, so
no need to specify it. Let the C spec guarantees around zeroing all
fields deal with it for you.

> +	.scan_index =3D 0,
> +	.event_spec =3D max30210_events,
> +	.num_event_specs =3D ARRAY_SIZE(max30210_events),
> +	.scan_type =3D {
> +		.sign =3D 's',
> +		.realbits =3D 16,
> +		.storagebits =3D 32,
> +		.shift =3D 8,
> +		.endianness =3D IIO_BE,
> +	},
> +};

> +static int max30210_probe(struct i2c_client *client)
> +{
> +	struct device *dev =3D &client->dev;
> +	struct iio_dev *indio_dev;
> +	struct max30210_state *st;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
> +		return -EOPNOTSUPP;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st =3D iio_priv(indio_dev);
> +
> +	mutex_init(&st->lock);

	ret =3D devm_mutex_init(&st->lock);
	if (ret)
		return ret;

Look at what that does.  We don't care a lot about lock lifetime debugging
but given it's easy to do, why not enable it for the driver.


> +
> +	ret =3D devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to enable vdd regulator.\n");
> +
> +	st->regmap =3D devm_regmap_init_i2c(client, &max30210_regmap);
> +	if (IS_ERR(st->regmap))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap),
> +				     "Failed to allocate regmap.\n");
> +
> +	ret =3D max30210_setup(st, dev);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->channels =3D &max30210_channels;
> +	indio_dev->num_channels =3D 1;
> +	indio_dev->name =3D "max30210";
> +	indio_dev->info =3D &max30210_info;
> +
> +	ret =3D devm_iio_triggered_buffer_setup_ext(dev, indio_dev, NULL,
> +						  max30210_trigger_handler,
> +						  IIO_BUFFER_DIRECTION_IN,
> +						  &max30210_buffer_ops,
> +						  max30210_fifo_attributes);
> +	if (ret < 0)
> +		return ret;

For consistency, if (ret) should be fine here.  I don't think any
IIO core calls return positive integers.

> +
> +	if (client->irq) {
> +		st->trig =3D devm_iio_trigger_alloc(dev, "%s-dev%d",
> +						  indio_dev->name,
> +						  iio_device_id(indio_dev));
> +		if (!st->trig)
> +			return -ENOMEM;
> +
> +		st->trig->ops =3D &max30210_trigger_ops;
> +		iio_trigger_set_drvdata(st->trig, indio_dev);
> +		ret =3D devm_iio_trigger_register(dev, st->trig);
> +		if (ret)
> +			return ret;
> +
> +		indio_dev->trig =3D st->trig;
> +		ret =3D devm_request_threaded_irq(dev, client->irq,
> +						iio_trigger_generic_data_rdy_poll,
> +						NULL, IRQF_TRIGGER_FALLING,

So we have an unfortunate history of drivers that specify the interrupt
polarity that we can't fix, but for new drivers, that is a job for firmware
not the driver (because there may be an inverter in the path or similar).
Hence most likely flags here should be IRQF_NO_THREAD.

There is no thread, so devm_request_irq() is enough.
However, note that iio_trigger_generic_data_ready_poll() is ultimately kick=
ing
of activity on an interrupt chip (software one) that is buried in the
IIO core. That can't be done correctly from a thread.  Hence the IRQF_NO_TH=
READ.

> +						indio_dev->name, st->trig);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret =3D devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

	return devm_iio_device_register();

> +}
> +
> +static const struct i2c_device_id max30210_id[] =3D {
> +	{ "max30210", 0 },
No point in the 0, so  just
	{ "max30210" },

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, max30210_id);

