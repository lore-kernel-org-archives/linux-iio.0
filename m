Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30AC1F0E34;
	Sun, 13 Sep 2026 02:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789267639; cv=none; b=A61IBZD7ZZ3n5QTROPCHdWj1KdIlcUW72YN5bRTTfTuq0DVI45pCjH+DYtAuLvNDQSA5VYzf1shJweRwxIj7aMGWgZTnVNdaoHkU69s9X7KonfDFb4VU2EU+fHbhIjh9W/IkdLPj4Gm4bbRA1k30WlwS5/Sx3W7yVWcpXXglOWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789267639; c=relaxed/simple;
	bh=ekVoW8BYMoStNXNSWHa+OyeDPLoMBK0jsJ2/AT+tKKw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z75316X56gWZ16aJHyrnLhC1wZcvAhZONnqlfXUz5YwbD89r8JK+Fvry6Lppd19WOR2ANfvbhvBgG+8rwq99oG8pqIM4ds4njEFhbe0VTbCr8/nQryRyX0NzEZVIui69zJONnU2253X0TE4ODsNLz9GCcVagdmhhxszPFZ0jXT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/CS9kb4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/CS9kb4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3141F0089A;
	Sun, 13 Sep 2026 02:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789267637;
	bh=8GbhOl0t8LK8EOKYmXqsUgSNIteZ4Npgbfz+IrjohSI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=U/CS9kb4R7XDMVrGUGrRI65hlGOafpM3RzSkWOaFqmxTgYKvMorhNwlOm4QQzEacp
	 JgZln5eQDDS9UVbystWgPWpcBtARfeMV+w1X0K0Ka12AwSkVDSdwL9KWgL2kkbT6Ic
	 +c7jcbcW41LJlzUscwKpWIlbuGal1PTWTDhXyetQ8EfnxrM8C3CTr5y399lVuA/R7Z
	 cSYKBsAPYaKhS2MMbw5qfyWmkhDX/gQtsymNvbrPbT2O2Up4SeNBuWSe1GZ16URjNS
	 cHOElzBWlbVWpjy2vCRK434hbQ8QGRkWW1hTE0PK5yyPgx3gfjJ4VpGvYcMKqGenwD
	 3d/b+Y1MalA7A==
Date: Sun, 13 Sep 2026 03:47:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Shi Hao <i.shihao.999@gmail.com>, "Jose A.
 Perez de Azpillaga" <azpijr@gmail.com>, Joshua Crofts
 <joshua.crofts1@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: light: add AS7343 multi-spectral sensor
 driver
Message-ID: <20260913034714.2fa2fcb5@jic23-hlaptop>
In-Reply-To: <20260912013912.51887-3-marcus.yu.56@gmail.com>
References: <20260912013912.51887-1-marcus.yu.56@gmail.com>
	<20260912013912.51887-3-marcus.yu.56@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 18:39:12 -0700
Chang Yu <marcus.yu.56@gmail.com> wrote:

> Add a driver for the AMS AS7343 14-channel multi-spectral sensor.
> 
> The AS7343 is a 14-channel spectral sensor featuring 11 visible
> channels, 1 near-infrared channel, 1 clear channel (VIS), and 1
> flicker detection channel.
> 
> The driver exposes 12 spectral channels (11 visible light and 1
> near-infrared) via sysfs. Runtime PM is implemented to stop
> measurements when the device is suspended or torn down. Power is
> never cut (PON=1 always) to preserve register values.
> 
> Future patches will add configurable gain and integration time,
> interrupt support, buffered reads, VIS channel, and flicker
> detection.
> 
> Datasheet: https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf
> Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>

Various things inline,

Thanks,

Jonathan

> diff --git a/drivers/iio/light/as7343.c b/drivers/iio/light/as7343.c
> new file mode 100644
> index 000000000000..9ea6a44c35b9
> --- /dev/null
> +++ b/drivers/iio/light/as7343.c
> @@ -0,0 +1,434 @@

> + * TODO:
> + *   - Autosuspend

This should be trivial to do, so I'd prefer you do it from the start
as requires about 3 lines to be changed.

> + *   - Support for configurable gain and integration time
> + *   - Interrupt support
> + *   - Add support for reading the VIS channel
> + *   - Flicker detection
> + */

> + * Integration time is calculated as (ATIME + 1) * ((ASTEP + 1) * 2.78us).
> + * Setting a 30 * 1.67ms = 50.1ms integration time as the default for now.
> + */
> +#define AS7343_ATIME				0x81
> +#define AS7343_ATIME_VAL			29 /* (29 + 1) = 30 steps */
> +#define AS7343_ASTEP				0xd4
> +#define AS7343_ASTEP_VAL			599 /* 1.67ms step size */

See below. Define these values in terms of what they actually are.
That probably means a macro to indicate the maths applied.

> +
> +#define AS7343_CFG0				0xbf
> +#define AS7343_CFG0_REG_BANK			BIT(4)
> +
> +#define AS7343_CFG1				0xc6
> +#define AS7343_CFG1_AGAIN			GENMASK(4, 0)
> +#define AS7343_CFG1_AGAIN_X0_5			0
> +#define AS7343_CFG1_AGAIN_X1			1
> +#define AS7343_CFG1_AGAIN_X2			2
> +#define AS7343_CFG1_AGAIN_X4			3
> +#define AS7343_CFG1_AGAIN_X8			4
> +#define AS7343_CFG1_AGAIN_X16			5
> +#define AS7343_CFG1_AGAIN_X32			6
> +#define AS7343_CFG1_AGAIN_X64			7
> +#define AS7343_CFG1_AGAIN_X128			8
> +#define AS7343_CFG1_AGAIN_X256			9
> +#define AS7343_CFG1_AGAIN_X512			10
> +#define AS7343_CFG1_AGAIN_X1024			11
> +#define AS7343_CFG1_AGAIN_X2048			12
> +
> +#define AS7343_CFG20				0xd6
> +#define AS7343_CFG20_AUTO_SMUX			GENMASK(6, 5)
> +#define AS7343_CFG20_AUTO_SMUX_READOUT_ALL	3 /* all-channel readout */
> +
> +#define AS7343_CONTROL				0xfa
> +
> +/* AS7343 status registers */
> +#define AS7343_STATUS2				0x90
> +#define AS7343_STATUS3				0x91
> +#define AS7343_STATUS				0x93
> +#define AS7343_ASTATUS				0x94
> +#define AS7343_STATUS5				0xbb
> +#define AS7343_STATUS4				0xbc
> +#define AS7343_FD_STATUS			0xe3
> +
> +/* AS7343 spectral data registers */
> +#define AS7343_DATA_FZ		0x95

Given some of your register have a _ in the register name part
I'd add something else to make it clear what is a register
and what is a field in these defines.  Postfix of _REG often
does this job in other drivers.  Apply that consistently
to all register address definitions.

> +#define AS7343_DATA_FY		0x97
> +#define AS7343_DATA_FXL		0x99
> +#define AS7343_DATA_NIR		0x9b
> +#define AS7343_DATA_F2		0xa1
> +#define AS7343_DATA_F3		0xa3
> +#define AS7343_DATA_F4		0xa5
> +#define AS7343_DATA_F6		0xa7
> +#define AS7343_DATA_F1		0xad
> +#define AS7343_DATA_F7		0xaf
> +#define AS7343_DATA_F8		0xb1
> +#define AS7343_DATA_F5		0xb3
> +#define AS7343_DATA_FD_L	0xb7
> +#define AS7343_DATA_FD_H	0xb8
> +
> +/* AS7343 FIFO buffer data registers */
> +#define AS7343_FIFO_LVL		0xfd
> +#define AS7343_FDATA_L		0xfe
> +#define AS7343_FDATA_H		0xff
> +
> +/* AS7343 channel indices. MUST match data register order above. */
> +#define AS7343_CHAN_IDX_FZ	0
> +#define AS7343_CHAN_IDX_FY	1
> +#define AS7343_CHAN_IDX_FXL	2
> +#define AS7343_CHAN_IDX_NIR	3
> +#define AS7343_CHAN_IDX_F2	4
> +#define AS7343_CHAN_IDX_F3	5
> +#define AS7343_CHAN_IDX_F4	6
> +#define AS7343_CHAN_IDX_F6	7
> +#define AS7343_CHAN_IDX_F1	8
> +#define AS7343_CHAN_IDX_F7	9
> +#define AS7343_CHAN_IDX_F8	10
> +#define AS7343_CHAN_IDX_F5	11
> +
> +#define AS7343_CHAN(_chan)					\
> +	{							\
> +		.type = IIO_INTENSITY,				\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
> +		.address = AS7343_DATA_##_chan,			\
> +		.indexed = 1,					\
> +		.channel = AS7343_CHAN_IDX_##_chan,		\
> +	}
> +
> +static const struct iio_chan_spec as7343_channels[] = {
> +	AS7343_CHAN(FZ), AS7343_CHAN(FY), AS7343_CHAN(FXL), AS7343_CHAN(NIR),
> +	AS7343_CHAN(F2), AS7343_CHAN(F3), AS7343_CHAN(F4),  AS7343_CHAN(F6),
> +	AS7343_CHAN(F1), AS7343_CHAN(F7), AS7343_CHAN(F8),  AS7343_CHAN(F5),
> +};
> +
> +struct as7343_data {
> +	struct regmap *regmap;
> +	/* Ensures reads don't stomp on each other */
> +	struct mutex mutex;
> +};
> +
> +static int as7343_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct as7343_data *data = iio_priv(indio_dev);
> +	unsigned int unused;
> +	struct regmap *map;
	struct regmap *map = data->regmap;
	struct device *dev = regmap_get_device(map);

Neither is checked so no point in waiting until a few lines
later to initialize them.

> +	struct device *dev;
> +	__le16 result;
> +	int ret;
> +
> +	map = data->regmap;
> +	dev = regmap_get_device(map);
> +
> +	PM_RUNTIME_ACQUIRE_IF_ENABLED(dev, pm);

Why _IF_ENABLED() variant?  This has come up in several drivers
recently and it makes little sense when used like this. You do this
when you care whether or not runtime pm is enabled.  We don't. Either
device is on already, or runtime pm is enabled and we can turn it on.

> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW: {
> +		/* Wait until integration time passes for all 3 cycles. */
> +		msleep(160);
> +
> +		/*
> +		 * Reading ASTATUS latches all data registers to this read.
> +		 * We don't care about the returned saturation/gain status for
> +		 * now.

Why do we care given only reading one channel and...

> +		 */
> +		guard(mutex)(&data->mutex);
> +		ret = regmap_read(map, AS7343_ASTATUS, &unused);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_bulk_read(map, chan->address,
.. it seems that if you read the low byte first (as this does) it is latched anyway.
There is a statement about this in the i2c intro part section 9.

so we get a consistent register pair.  Thus not needing the latch astatus
gives us.
With that in place reads can't stomp on each other as only
one regmap read is required, so the mutex isn't needed either.
It may be necessary once you add more features - hard to tell yet.

> +				       &result, sizeof(result));
> +		if (ret)
> +			return ret;
> +
> +		*val = le16_to_cpu(result);
> +		return IIO_VAL_INT;
> +	}
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +/*
> + * Channel names and wavelength ranges as defined in the datasheet
> + * (Figure 7, "AS7343 Optical Channel Summary"). Values are the
> + * minimum and maximum peak wavelength in nanometers.
> + *
> + * F1:  395-415 nm
> + * F2:  415-435 nm
> + * FZ:  440-460 nm
> + * F3:  465-485 nm
> + * F4:  505-525 nm
> + * FY:  545-565 nm
> + * F5:  540-560 nm
> + * FXL: 590-610 nm
> + * F6:  630-650 nm
> + * F7:  680-700 nm
> + * F8:  735-755 nm
> + * NIR: 845-865 nm
> + */
> +static const char * const as7343_channel_labels[] = {
> +	[AS7343_CHAN_IDX_F1] = "F1",
> +	[AS7343_CHAN_IDX_F2] = "F2",
> +	[AS7343_CHAN_IDX_FZ] = "FZ",
> +	[AS7343_CHAN_IDX_F3] = "F3",
> +	[AS7343_CHAN_IDX_F4] = "F4",
> +	[AS7343_CHAN_IDX_FY] = "FY",
> +	[AS7343_CHAN_IDX_F5] = "F5",
> +	[AS7343_CHAN_IDX_FXL] = "FXL",
> +	[AS7343_CHAN_IDX_F6] = "F6",
> +	[AS7343_CHAN_IDX_F7] = "F7",
> +	[AS7343_CHAN_IDX_F8] = "F8",
> +	[AS7343_CHAN_IDX_NIR] = "NIR",

I wonder if these could be more useful to a user?  Or are these things standard
in some sense?  Maybe we could put the frequency range in the label given they
are free form 'hints' to userspace.
"F1: 395-415 nm" might be fine?  I'm curious what others think of this suggestion.

> +};
> +
> +static int as7343_read_label(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, char *label)
> +{
> +	int channel = chan->channel;

What stops this being negative?  I'm wondering now why channel in iio_chan_spec
is signed (maybe a decision lost to the mists of time), but it is so you
need to check for < 0 as well.

> +
> +	if (channel >= ARRAY_SIZE(as7343_channel_labels))
> +		return -EINVAL;
> +
> +	return sysfs_emit(label, "%s\n", as7343_channel_labels[channel]);
> +}

> +
> +static int as7343_setup_device(struct device *dev, struct as7343_data *data)
> +{
> +	struct regmap *map = data->regmap;
> +	unsigned int val;
> +	__le16 step;
> +	int ret;
> +
> +	/* Power on */
> +	ret = regmap_set_bits(map, AS7343_ENABLE, AS7343_ENABLE_PON);
> +	if (ret)
> +		return ret;
> +
> +	/* Need to set REG_BANK to 1 before we can access ID */
> +	ret = regmap_set_bits(map, AS7343_CFG0, AS7343_CFG0_REG_BANK);

For the bank I'd not use set_bits / clear_bits because the 0 / 1 nature
of the bank being selected is lost.  Sure it ends up as the same
resule but I would like that FIELD_SET(AS7343_CFG0_REG_BANK, 1) visible.

> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(map, AS7343_ID, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val != 0x81)
> +		dev_info(dev, "Unknown device ID: %x\n", val);
> +
> +	ret = regmap_clear_bits(map, AS7343_CFG0, AS7343_CFG0_REG_BANK);

As above.  We are setting a field to 0 or 1 not clearing or setting
a flag.  It's a bit odd to call them register banks though given there
are no overlapping addresses.

> +	if (ret)
> +		return ret;
> +
> +	/* Configure the SMUX to readout all channels */
> +	ret = regmap_update_bits(map, AS7343_CFG20, AS7343_CFG20_AUTO_SMUX,
> +				 FIELD_PREP(AS7343_CFG20_AUTO_SMUX,
> +					    AS7343_CFG20_AUTO_SMUX_READOUT_ALL));
> +	if (ret)
> +		return ret;
> +
> +	/* Set 50.1ms integration time and x256 gain for now */
> +	step = cpu_to_le16(AS7343_ASTEP_VAL);

As below, what does this mean?  Some sort of macro or function
to associate that with the step size  AS7343_ASTEP_X270ns(0xd5) or
something like that. Given datasheet uses decimal for the actual definition
if not the demo value, use decimal here.

> +	ret = regmap_bulk_write(map, AS7343_ASTEP, &step, sizeof(step));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(map, AS7343_ATIME, AS7343_ATIME_VAL);
What does ATIME_VAL indicate?  Name it after what it represents
or better yet use a macro AS7343_ATIME_STEPS(30)

> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(map, AS7343_CFG1, AS7343_CFG1_AGAIN,
> +				  FIELD_PREP(AS7343_CFG1_AGAIN,
> +					     AS7343_CFG1_AGAIN_X256));
> +}

> +
> +static void as7343_suspend_action(void *data)
> +{
> +	struct device *dev = data;
> +
> +	as7343_suspend(dev);

static void as7343_suspend_action(void *dev)
{
	as7343_suspend(dev);
}

is fine for this sort of thing. dev is standard naming for a struct
device so the local variable isn't adding anyting.

> +}
> +
> +static int as7343_probe(struct i2c_client *client)
> +{

..

> +	ret = as7343_setup_device(dev, data);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(dev, as7343_suspend_action, dev);

Why here? You only start sensing sometime later.

> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to add suspend action\n");
> +
> +	ret = pm_runtime_set_active(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to activate PM runtime\n");
> +
> +	ret = devm_pm_runtime_enable(dev);

Why is devm_pm_runtime_enable_set_active() not appropriate here?
(Note I'm not saying it is, but it seems worth considering).

> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable PM runtime\n");
> +
> +	/* Start measurements */
> +	ret = regmap_set_bits(regmap, AS7343_ENABLE, AS7343_ENABLE_SP_EN);

Logically I would do this before 'set_active' is called as this is
what puts the device in active state.

> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}


