Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890BC64;
	Fri,  3 Jul 2026 00:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783037138; cv=none; b=jPm0q6OCsRVhf8zh6g9pO5tndlV0eGV7C62IxP+p2gpd9CPtqhFHdPlSA6jXDxXJLeIv9/ME6jNzd3HbKZ9S4zw1MwYW7nccmlkNNwSS/IMhk8UZdTLpOdDUl1C3mupHAw8Tj7Q3N+8Fw7awAKG2mYtJ/P9Hvgga+spjpTK+UIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783037138; c=relaxed/simple;
	bh=BPQDibvo23p1qpjC6o0MS+MEpjBV26mTEZ+y3cN9a6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NNKx+dD6bpSY9WQDpf6ltJyTCQ9sHicmayjunPiyGLPxQjIri0OJyEnR9Iv2MzE01K8nKxt3J44W75c7JimgrKAn+4K1lrIEsAH7Wc7wsX1e5uYeXgto05KYrUXSE5YuDsJY3bt+YG24ZokSqpZTmpugNCNgZ4ZPU+gBeTe5X7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lILtw8Y8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lILtw8Y8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E12FC1F000E9;
	Fri,  3 Jul 2026 00:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783037137;
	bh=rctnTl20fzWWKLn2BKUIU+YqIZqZix/n95dwukmGwa0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lILtw8Y8hEwk9WtxoBj54ay66DjRRoIazIwqpSl/7PaQK+/fRVi1Zw/p8D2eYoaVk
	 JYhKsgfQJZ9NwIjGRfeQd65NEnkuDBBPslHMUjNwpafingE3REacUtGkLZNH5s49MC
	 LwKHVg37OhqC+JgniRhtUS7HKEQV8sXAs0tE/YEKqqfOO4NxBJ5viyxqnZt+V+Th0R
	 GG9vszevdUVJkhwjD1wxfesWoNyDIce/GyucacHB2PBCagnXMOIhE5aJRqCOsqll5g
	 MA3oRbiY/dLGT/+G0Fj7B9mEj5Ct3PnuKS/9V1dJZA05U58pk4jFx1UukXL3pr7kqi
	 ub9PI1P5zx7kw==
Date: Fri, 3 Jul 2026 01:05:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM
 AND DRIVERS), devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND
 FLATTENED DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v2 2/2] iio: temperature: Add STS30 temperature sensor
 driver
Message-ID: <20260703010532.4fc0f46b@jic23-huawei>
In-Reply-To: <20260621004626.66629-3-m32285159@gmail.com>
References: <20260621004626.66629-1-m32285159@gmail.com>
	<20260621004626.66629-3-m32285159@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Jun 2026 19:46:24 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> Add a driver for the Sensirion STS30 family of temperature sensor
> drivers over I2C. The STS30 family of sensors includes the STS30, STS31,
> and STS35, all of which are supported by this driver, since they all
> share the same commands, etc. and only differ in accuracy and tolerance.
> 
> The driver currently supports single-shot non-clock stretched readings,
> by using a specified delay based on the repeatability/delay specified
> by the user. The repeatability/delay can be changed at any time through
> sysfs.
> 
> Additionally add Kconfig and Makefile entries for the driver as well as
> a MAINTAINERS entry.
> 
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>

Big question first.  Why IIO? These are fairly basic temperature sensors
which typically means hwmon is more appropriate.  What does it need
that hwmon doesn't provide?

A few other things inline.

> diff --git a/drivers/iio/temperature/sts30.c b/drivers/iio/temperature/sts30.c
> new file mode 100644
> index 000000000000..dcfe3435ae5a
> --- /dev/null
> +++ b/drivers/iio/temperature/sts30.c

> +
> +/* Size of the temperature measurement data received after a read command */
> +#define STS30_TEMP_MEAS_SIZE 2
> +
> +#define STS30_COMMAND_READ_HIGH_REPEAT 0x2400
> +#define STS30_COMMAND_READ_MED_REPEAT 0x240B
> +#define STS30_COMMAND_READ_LOW_REPEAT 0x2416
That smells like two fields in one value.

> +
> +#define STS30_COMMAND_RESET 0x30A2

> +enum sts30_read_delays { 

Name it to indicate unit.

> +	STS30_REPEAT_LOW = 4500,
> +	STS30_REPEAT_MED = 6000,
> +	STS30_REPEAT_HIGH = 15000
> +};
> +

> +static int sts30_read(struct sts30_data *data, u16 command, u16 *val)
> +{
> +	u8 buf[STS30_MEAS_SIZE];
> +	u8 tmp[2];
Might as well make it __be16  then it's aligned.
> +	int ret;
> +
> +	put_unaligned_be16(command, tmp);
> +
> +	ret = i2c_master_send(data->client, tmp, sizeof(tmp));
> +	if (ret < 0)
> +		return ret;
> +	if (ret != sizeof(tmp))
> +		return -EIO;
> +
> +	fsleep(data->delay);
> +
> +	ret = i2c_master_recv(data->client, buf, sizeof(buf));
> +	if (ret < 0)
> +		return ret;
> +	if (ret != sizeof(buf))
> +		return -EIO;
> +
> +	*val = get_unaligned_be16(buf);
> +
> +	ret = sts30_verify_crc8(data, buf);

return sts30_...

> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}

> +
> +static int sts30_read_raw(struct iio_dev *indio_dev,
> +			  struct iio_chan_spec const *chan, int *val, int *val2,
> +			  long mask)
> +{
> +	struct sts30_data *data = iio_priv(indio_dev);
> +	int ret;
> +	u16 tmp;
> +
> +	guard(mutex)(&data->lock);

I'd move this into appropriate scope as the lock isn't needed for
all the const data cases.

> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (data->delay) {
> +		case STS30_REPEAT_LOW:
> +			ret = sts30_read(data, STS30_COMMAND_READ_LOW_REPEAT, &tmp);
> +			break;
> +		case STS30_REPEAT_MED:
> +			ret = sts30_read(data, STS30_COMMAND_READ_MED_REPEAT, &tmp);
> +			break;
> +		case STS30_REPEAT_HIGH:
> +			ret = sts30_read(data, STS30_COMMAND_READ_HIGH_REPEAT, &tmp);
> +			break;
> +		default:
> +			dev_warn(&data->client->dev, "Repeatability state corrupted, got: %d\n",
> +				 data->delay);

Any realistic way this can happen?  If not drop the print.

> +			return -EINVAL;
> +		}
> +
> +		if (ret)
> +			return ret;
> +
> +		*val = tmp;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = STS30_TEMP_OFFSET;

These constant cases don't need the lock.

> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 175000;
> +		*val2 = 65535;
> +		return IIO_VAL_FRACTIONAL;
> +	case IIO_CHAN_INFO_INT_TIME:
> +		*val = 0;
> +		*val2 = data->delay;

Might need the guard - I haven't checked.

> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int sts30_write_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan, int val, int val2,
> +			   long mask)
> +{
> +	struct sts30_data *data = iio_priv(indio_dev);
> +
> +	if (val)
> +		return -EINVAL;

That is going to be IIO_* specific in the switch - so move it into
the case block.

> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_INT_TIME: {
> +		guard(mutex)(&data->lock);

Given it is taken in all non error paths, I'd lift the guard() up to outside
the switch.

> +
> +		switch (val2) {
> +		case STS30_REPEAT_LOW:
> +			data->delay = STS30_REPEAT_LOW;
> +			break;

Given you are done in each of these, return instead of break.

> +		case STS30_REPEAT_MED:
> +			data->delay = STS30_REPEAT_MED;
> +			break;
> +		case STS30_REPEAT_HIGH:
> +			data->delay = STS30_REPEAT_HIGH;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		return 0;
> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info sts30_info = {
> +	.read_raw = sts30_read_raw,
> +	.write_raw = sts30_write_raw
Missing comma.

Basic rule of these is you can only skip the comma if doing so doesn't create additional
churn when adding new stuff after it.  Two cases are common.
1) Nothing can be added there - true of terminators  {} etc.
2) It's one line anyway so any change will result in that line changing
   and hence no advantage in having the comma.

> +};
> +
> +static const struct iio_chan_spec sts30_channels[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_OFFSET) |
> +				      BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_INT_TIME)

No obvious gain in going longer than 80 chars here.  Just have one per line.
Also the , is missing

> +	},
> +};
> +
> +static int sts30_probe(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev;
> +	struct sts30_data *data;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	indio_dev->name = client->name;

I'd prefer to see that done via device specific chip_info structures.
IIRC there are some paths in which client->name might not be set appropriately.
For ACPI PRP0001 (the route that uses compatible) it is set to the vendor stripped
name so that is fine, but should we ever add 'proper' ACPI support it will be the
_HID which isn't what we want.

Anyhow, normally we avoid thinking about this by getting from the data
rather than the ->name via i2c_get_match_data() and appropriate structures.

> +	indio_dev->info = &sts30_info;
> +	indio_dev->channels = sts30_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(sts30_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	data = iio_priv(indio_dev);
> +	data->client = client;
> +	data->delay = STS30_REPEAT_HIGH;
> +
> +	ret = devm_mutex_init(&client->dev, &data->lock);
> +	if (ret)
> +		return ret;
> +
> +	i2c_set_clientdata(client, indio_dev);

Why? I'm not seeing it being used.

> +
> +	ret = sts30_reset(data);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}


