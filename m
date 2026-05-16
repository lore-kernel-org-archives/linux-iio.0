Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D4413957E
	for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 14:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778943531; cv=none; b=Sj1Jl8syZ7vCHilWTrJOFjfgLWPnsmkEiw5f7qAfVgzwpG4vWvEroQKlSpAw9lsnoRPr2pvb3KLp/T7k9PbLZhCQT+yZsAceZNgbsgRf70Aa1TPpenzc/h9uj9Ojhbot5/HyEcXsM0ibAgLspYCFYFB6OQRGNqbd0ZdPorcW85k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778943531; c=relaxed/simple;
	bh=rsJ6f7OiDQtGWvoqxWv5xRbzYtI7n+j90Qq7ZEG9SO4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RENYBL1KzBQi12ukLlicvV/kSJ71ulsD2wk/5hdSF7s15959P7qsiS0JL47pdCpDlkj4nycZaPZIoc37PdIIxQvtNsU4l+QqYKRgh10+shzLXeJV6IgevAb4Fnr3u4MjX5HaASBKNIhB+ArQFUqFlavoK1z73eQ7Cey3I9ocJx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FpRRR04U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpRRR04U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32FBAC2BCC7;
	Sat, 16 May 2026 14:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778943531;
	bh=rsJ6f7OiDQtGWvoqxWv5xRbzYtI7n+j90Qq7ZEG9SO4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FpRRR04U9eROTUz2TUB81dRwbjm189aM1ztmcdcCqXS0jW2CRSrpDO2IK1WEdXjF1
	 lJPFGswDrQ1WLrYBsGfg7E91xXAc/iBnzqtUBuLJcBbiIOQyib795duseXoCSctAr0
	 FMhiz+T+Q48XaIL3whLkRQlOz9QOSOimrJR8FwIVQ5T87NJ32Ckz8pumwz1BeV/8Uh
	 icHgRcskn0invfi2ckDUooqqZr3SMT85Q1rpygQjPefnhA4NIUA3vx6oZTRiqp++iG
	 N6W00L7vghCXxYVnqB3NBN9KZSy175HBb/u4jYEkJ1IzJnEUyR0Olw7meBB7My7S6C
	 HRvi8lc4f9A2w==
Date: Sat, 16 May 2026 15:58:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [RFC PATCH v2 2/2] iio: light: add support for APDS9999 sensor
Message-ID: <20260516155844.1308ee10@jic23-huawei>
In-Reply-To: <f389419972fc790a25b6041f1212e15f155804e2.1778659152.git.azpijr@gmail.com>
References: <cover.1778659152.git.azpijr@gmail.com>
	<f389419972fc790a25b6041f1212e15f155804e2.1778659152.git.azpijr@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 May 2026 10:10:35 +0200
"Jose A. Perez de Azpillaga" <azpijr@gmail.com> wrote:

> Add IIO driver for Broadcom APDS9999 ambient light sensor.
> 
> The APDS9999 is a digital proximity and RGB sensor with ALS
> capability. This driver implements the ALS/Lux functionality using
> the green channel, which uses optical coating technology to
> approximate the human eye spectral response.

Can wrap commit messages to 75 chars.

> 
> Proximity (PS) and RGB color features are not yet implemented.
Needs an update (sashiko pointed this out)
https://sashiko.dev/#/patchset/cover.1778659152.git.azpijr%40gmail.com

> 
> Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

A few minor things inline. 

Thanks,

Jonathan

> diff --git a/drivers/iio/light/apds9999.c b/drivers/iio/light/apds9999.c
> new file mode 100644
> index 000000000000..577b93f61d31
> --- /dev/null
> +++ b/drivers/iio/light/apds9999.c
> @@ -0,0 +1,344 @@

> +static int apds9999_init(struct apds9999_data *data)
> +{
> +	struct device *dev = &data->client->dev;
> +	struct i2c_client *client = data->client;
> +	u8 reg;

I think regval makes it more obvious this isn't a register address.

> +	int ret;
> +
> +	ret = devm_add_action_or_reset(dev, apds9999_standby, client);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&data->lock);
> +
> +	reg = FIELD_PREP(APDS9999_LS_RES_MASK, APDS9999_RES_18BIT) |
> +	      FIELD_PREP(APDS9999_LS_RATE_MASK, APDS9999_RATE_100_MS);
> +	ret = i2c_smbus_write_byte_data(client, APDS9999_REG_LS_MEAS_RATE, reg);
> +	if (ret)
> +		return ret;
> +	data->als_res = APDS9999_RES_18BIT;
> +	data->als_rate = APDS9999_RATE_100_MS;
> +
> +	ret = i2c_smbus_write_byte_data(client, APDS9999_REG_LS_GAIN,
> +					APDS9999_GAIN_3X);
> +	if (ret)
> +		return ret;
> +	data->als_gain_idx = APDS9999_GAIN_3X;
> +
> +	ret = i2c_smbus_write_byte_data(client, APDS9999_REG_MAIN_CTRL,
> +					APDS9999_MAIN_CTRL_LS_EN);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

	return i2c_smbus_write_byte_data()

> +}
> +
> +static int apds9999_read_channel(struct apds9999_data *data, u8 reg, u32 *counts)
> +{
> +	struct i2c_client *client = data->client;
> +	u8 buf[3];
> +	int ret, tries;
> +
> +	guard(mutex)(&data->lock);
> +
> +	/*
> +	 * Poll MAIN_STATUS for new data.  Timeout: ~2 integration periods
> +	 * plus margin.  Each try sleeps 20 ms.
> +	 */
> +	tries = max(2, (apds9999_itimes_us[data->als_res] * 2) / 20000);
> +
> +	while (tries--) {
> +		ret = i2c_smbus_read_byte_data(client,
> +						APDS9999_REG_MAIN_STATUS);
Off by one space and it's under 80 chars anyway (would have been fine if a little
over a well).

		ret = i2c_smbus_read_byte_data(client, APDS9999_REG_MAIN_STATUS);


> +		if (ret < 0)
> +			return ret;
> +		if (ret & APDS9999_MAIN_STATUS_LS_DATA)
> +			break;
> +		fsleep(20000);
> +	}
> +
> +	if (tries < 0)
> +		return -ETIMEDOUT;
> +
> +	ret = i2c_smbus_read_i2c_block_data(client, reg, sizeof(buf), buf);
> +	if (ret < 0)
> +		return ret;
> +	if (ret != sizeof(buf))
> +		return -EIO;
> +
> +	*counts = get_unaligned_le24(buf) & GENMASK(19, 0);
> +	return 0;
> +}
> +
> +static int apds9999_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct apds9999_data *data = iio_priv(indio_dev);
> +	int gain, itime_us;
> +	u64 scale_nano;
> +	u32 counts;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_LIGHT:
> +			ret = apds9999_read_channel(data,
> +						    APDS9999_REG_LS_DATA_GREEN_0,
> +						    &counts);
			if (ret)
				return ret;

			*val = (int)counts;
	
			return IIO_VAL_COUNT;
(See below)

> +			break;
> +		case IIO_INTENSITY:
> +			ret = apds9999_read_channel(data, chan->address,
> +						    &counts);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		if (ret)
> +			return ret;
I'd shift this up so all errors are dealt with at source.  Means we don't need
to read on to see where they are going... 
> +		*val = (int)counts;
> +		return IIO_VAL_INT;
Not worth sharing this either given only save a tiny bit.

> +
> +	case IIO_CHAN_INFO_SCALE:
> +		/*
> +		 * Scale (lux per count) = 54 / (gain * integration_time_ms)
> +		 *
> +		 * The constant 54 is derived from the datasheet table:
> +		 *   at gain = 3x, itime = 100 ms -> 0.180 lux/count
> +		 *   -> C = 0.180 * 3 * 100 = 54
> +		 *
> +		 * Expressed as IIO_VAL_INT_PLUS_NANO.
> +		 */
> +		gain = apds9999_gains[data->als_gain_idx];
> +		itime_us = apds9999_itimes_us[data->als_res];
> +
> +		/* scale_nano = 54e12 / (gain * itime_us) nano-lux/count */
> +		scale_nano = div_u64(54000000000000ULL, (u32)(gain * itime_us));
> +		*val = (int)(scale_nano / NSEC_PER_SEC);
> +		*val2 = (int)(scale_nano % NSEC_PER_SEC);
> +		return IIO_VAL_INT_PLUS_NANO;
> +
> +	case IIO_CHAN_INFO_INT_TIME:
> +		*val = 0;
> +		*val2 = apds9999_itimes_us[data->als_res];
> +		return IIO_VAL_INT_PLUS_MICRO;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_chan_spec apds9999_channels[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> +	},
> +	{
> +		.type = IIO_INTENSITY,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_LIGHT_RED,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> +		.address = APDS9999_REG_LS_DATA_RED_0,
> +	},
> +	{
> +		.type = IIO_INTENSITY,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_LIGHT_GREEN,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> +		.address = APDS9999_REG_LS_DATA_GREEN_0,
> +	},
> +	{
> +		.type = IIO_INTENSITY,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_LIGHT_BLUE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> +		.address = APDS9999_REG_LS_DATA_BLUE_0,
> +	},
> +	{
> +		.type = IIO_INTENSITY,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_LIGHT_CLEAR,

Why clear rather than IR? Sashiko even noticed this. 

> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
> +		.address = APDS9999_REG_LS_DATA_IR_0,
> +	},
> +};

> +
> +static const struct i2c_device_id apds9999_id[] = {
> +	{ "apds9999" },

Whilst not traditionally done, we are moving towards using c99 for this.
	{ .name = "apds9999" }
preferred.  Doesn't actually matter if only a name, but later fields
are likely to soon become a union.  For consistency and ease of explanation
I think always using named structure fields is a good direction to move in.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, apds9999_id);
> +
> +static const struct of_device_id apds9999_of_match[] = {
> +	{ .compatible = "brcm,apds9999" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, apds9999_of_match);
> +
> +static struct i2c_driver apds9999_driver = {
> +	.driver = {
> +		.name = "apds9999",
> +		.of_match_table = apds9999_of_match,
> +	},
> +	.probe = apds9999_probe,
> +	.id_table = apds9999_id,
> +};
> +module_i2c_driver(apds9999_driver);
> +
> +MODULE_AUTHOR("Jose A. Perez de Azpillaga <azpijr@gmail.com>");
> +MODULE_DESCRIPTION("APDS-9999 Lux Light Sensor IIO Driver");
> +MODULE_LICENSE("GPL");
> 

