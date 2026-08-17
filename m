Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461241E8826;
	Mon, 17 Aug 2026 02:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786932562; cv=none; b=ccFDrAhnhyedrVlcLD0E3n+/zT0e6/B6SgypB3z8BeDD9ZrStq5LBsO/nJEiVh3Y9c/visaDnQRm/xsOotO+WrQTD8BVg8WmIoTJqZeTMAeNTTmfysJOsl+1VXHNXrdZXwZEGi6xw/xIdCmzTCcaqFTj6+Y9dbei37H0f7b3uMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786932562; c=relaxed/simple;
	bh=re03V/t/SJ3Plz4hGpDn7KwL5r2R/fQsoIaGfHRdzaI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oPU5eMfsolyOZFf7BsXz6Ur2JymY1M1gckXkfrPwU1jr2nScKLMmuq4HDNYPwxchQ7o5CX1q6fXxnFq6b4GRUmTmsC8gpF0w2KyNAqGiRvKqbVx1J21ImQpE6N0Fd3dJe8+z4MNm1mBhiORXH/ZH8Ys0vXS3rUnFD9zdiLiEKis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTjVaQ4f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTjVaQ4f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170731F000E9;
	Mon, 17 Aug 2026 02:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786932560;
	bh=wOxLa+c3TRrRqoH2HbbG2xkIT5uJ89Y/7S3kMwkk3Qg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lTjVaQ4fwjqVoTKReeAMkEmN5FoMqWAg3Gjg3u2Ms2YTsvPOtnPzrYLDWBHLmNfZp
	 f8vhW61Ifp8YnSl/JtVEUBuZhZ+R8RFP8M5O45rUNn/0eSb14DaNYRt6+Q1erwJWwD
	 OgH5pEB0R63n5ysd3hsYbww+H8jQ4TNA5OZBKNj8SrH465dHXMedUYEl/vsVL48b1Z
	 Toq1HK2+s1zV4+7l1pwq4x2HwZW61zioDhhe+8B8WRoclFiJ1F3NXt77xKPl4tp/jL
	 TgKC2j8pUUczjBjbhU5R/3YPDqiQxmzu4QzmYyOHg3VTikf8WKQnSyjcV4N8g8PD1G
	 V4sQi6nyIMidA==
Date: Mon, 17 Aug 2026 03:09:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, Kees Cook
 <kees@kernel.org>, "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, Luca Weiss
 <luca.weiss@fairphone.com>
Subject: Re: [PATCH 2/3] iio: light: stk3310: add per-chip match data
Message-ID: <20260817030915.669d7b25@jic23-huawei>
In-Reply-To: <20260810110423.41697-3-jorijnvdgraaf@catcrafts.net>
References: <20260810110423.41697-1-jorijnvdgraaf@catcrafts.net>
	<20260810110423.41697-3-jorijnvdgraaf@catcrafts.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 13:04:22 +0200
Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net> wrote:

> Introduce a chip_info structure carrying the device name and channel
> specification, attach it to every i2c, OF and ACPI table entry, and let
> probe take it from the match data. Clients instantiated through the
> sysfs new_device interface under the lowercase compatible-derived name
> have no firmware node and do not match the uppercase id table entries,
> so absent match data falls back to the original chip data. The channel
> data registers move into .address and the shared channel definitions
> into macros.
> 
> This is a preparatory change for a variant that provides more channels
> than the existing parts. No functional change.
> 
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Hi Jorijn

A few things inline.

> ---
>  drivers/iio/light/stk3310.c | 107 +++++++++++++++++++++++-------------
>  1 file changed, 69 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
> index 7c8a1d2b2ed0..249396b9bf80 100644
> --- a/drivers/iio/light/stk3310.c
> +++ b/drivers/iio/light/stk3310.c
> @@ -181,24 +181,48 @@ static const struct iio_chan_spec_ext_info stk3310_ext_info[] = {
>  	{ }
>  };
>  
> +#define STK3310_LIGHT_CHANNEL {				\
> +	.type = IIO_LIGHT,				\
> +	.address = STK3310_REG_ALS_DATA_MSB,		\

The chan->address is a somewhat unrelated change an rather surprised me below.
Perhaps do that as a precursor as it is a nice change in its own right.

> +	.info_mask_separate =				\
> +		BIT(IIO_CHAN_INFO_RAW) |		\
> +		BIT(IIO_CHAN_INFO_SCALE) |		\
> +		BIT(IIO_CHAN_INFO_INT_TIME),		\
> +}
> +
> +#define STK3310_PROXIMITY_CHANNEL {			\
> +	.type = IIO_PROXIMITY,				\
> +	.address = STK3310_REG_PS_DATA_MSB,		\
> +	.info_mask_separate =				\
> +		BIT(IIO_CHAN_INFO_RAW) |		\
> +		BIT(IIO_CHAN_INFO_SCALE) |		\
> +		BIT(IIO_CHAN_INFO_INT_TIME),		\
> +	.event_spec = stk3310_events,			\
> +	.num_event_specs = ARRAY_SIZE(stk3310_events),	\
> +	.ext_info = stk3310_ext_info,			\
> +}
> +
>  static const struct iio_chan_spec stk3310_channels[] = {
> -	{
> -		.type = IIO_LIGHT,
> -		.info_mask_separate =
> -			BIT(IIO_CHAN_INFO_RAW) |
> -			BIT(IIO_CHAN_INFO_SCALE) |
> -			BIT(IIO_CHAN_INFO_INT_TIME),
> -	},
> -	{
> -		.type = IIO_PROXIMITY,
> -		.info_mask_separate =
> -			BIT(IIO_CHAN_INFO_RAW) |
> -			BIT(IIO_CHAN_INFO_SCALE) |
> -			BIT(IIO_CHAN_INFO_INT_TIME),
> -		.event_spec = stk3310_events,
> -		.num_event_specs = ARRAY_SIZE(stk3310_events),
> -		.ext_info = stk3310_ext_info,
> -	}
> +	STK3310_LIGHT_CHANNEL,
> +	STK3310_PROXIMITY_CHANNEL,
> +};
> +
> +/**
> + * struct stk3310_chip_info - chip-specific data
> + * @name: device name reported to the IIO core
> + * @channels: channel specification
> + * @num_channels: number of channels
> + */
> +struct stk3310_chip_info {
> +	const char			*name;
> +	const struct iio_chan_spec	*channels __counted_by_ptr(num_channels);
> +	unsigned int			num_channels;
> +};
> +
> +static const struct stk3310_chip_info stk3310_chip_info = {
> +	.name = STK3310_DRIVER_NAME,
> +	.channels = stk3310_channels,
> +	.num_channels = ARRAY_SIZE(stk3310_channels),
>  };
>  
>  static IIO_CONST_ATTR(in_illuminance_scale_available, STK3310_SCALE_AVAILABLE);
> @@ -370,7 +394,6 @@ static int stk3310_read_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan,
>  			    int *val, int *val2, long mask)
>  {
> -	u8 reg;
>  	__be16 buf;
>  	int ret;
>  	unsigned int index;
> @@ -382,13 +405,9 @@ static int stk3310_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		if (chan->type == IIO_LIGHT)
> -			reg = STK3310_REG_ALS_DATA_MSB;
> -		else
> -			reg = STK3310_REG_PS_DATA_MSB;
> -
>  		mutex_lock(&data->lock);
> -		ret = regmap_bulk_read(data->regmap, reg, &buf, sizeof(buf));
> +		ret = regmap_bulk_read(data->regmap, chan->address, &buf,
> +				       sizeof(buf));

See above - I'd pull this use of chan->address out as a precursor patch.

>  		if (ret < 0) {
>  			dev_err(&client->dev, "register read failed\n");
>  			mutex_unlock(&data->lock);
> @@ -635,10 +654,22 @@ static irqreturn_t stk3310_irq_event_handler(int irq, void *private)
>  
>  static int stk3310_probe(struct i2c_client *client)
>  {
> +	const struct stk3310_chip_info *chip_info;
>  	int ret;
>  	struct iio_dev *indio_dev;
>  	struct stk3310_data *data;
>  
> +	chip_info = i2c_get_match_data(client);
> +	if (!chip_info) {
> +		/*
> +		 * Clients instantiated through the sysfs new_device
> +		 * interface under the lowercase compatible-derived name
> +		 * have no firmware node and do not match the uppercase
> +		 * id table entries.
> +		 */
> +		chip_info = &stk3310_chip_info;
> +	}
> +
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>  	if (!indio_dev)
>  		return -ENOMEM;
> @@ -657,10 +688,10 @@ static int stk3310_probe(struct i2c_client *client)
>  		return ret;
>  
>  	indio_dev->info = &stk3310_info;
> -	indio_dev->name = STK3310_DRIVER_NAME;
> +	indio_dev->name = chip_info->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> -	indio_dev->channels = stk3310_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(stk3310_channels);
> +	indio_dev->channels = chip_info->channels;
> +	indio_dev->num_channels = chip_info->num_channels;
>  
>  	ret = stk3310_init(indio_dev);
>  	if (ret < 0)
> @@ -766,28 +797,28 @@ static DEFINE_SIMPLE_DEV_PM_OPS(stk3310_pm_ops, stk3310_suspend,
>  				stk3310_resume);
>  
>  static const struct i2c_device_id stk3310_i2c_id[] = {
> -	{ .name = "STK3013" },
> -	{ .name = "STK3310" },
> -	{ .name = "STK3311" },
> -	{ .name = "STK3335" },
> +	{ .name = "STK3013", .driver_data = (kernel_ulong_t)&stk3310_chip_info },
> +	{ .name = "STK3310", .driver_data = (kernel_ulong_t)&stk3310_chip_info },
> +	{ .name = "STK3311", .driver_data = (kernel_ulong_t)&stk3310_chip_info },
> +	{ .name = "STK3335", .driver_data = (kernel_ulong_t)&stk3310_chip_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, stk3310_i2c_id);
>  
>  static const struct acpi_device_id stk3310_acpi_id[] = {
> -	{"STK3013", 0},
> -	{"STK3310", 0},
> -	{"STK3311", 0},
> +	{"STK3013", (kernel_ulong_t)&stk3310_chip_info},
> +	{"STK3310", (kernel_ulong_t)&stk3310_chip_info},
> +	{"STK3311", (kernel_ulong_t)&stk3310_chip_info},

Please tidy up the formatting to use named initializers and spacing
as for the other id tables.

>  	{ }
>  };
>  
>  MODULE_DEVICE_TABLE(acpi, stk3310_acpi_id);
>  
>  static const struct of_device_id stk3310_of_match[] = {
> -	{ .compatible = "sensortek,stk3013", },
> -	{ .compatible = "sensortek,stk3310", },
> -	{ .compatible = "sensortek,stk3311", },
> -	{ .compatible = "sensortek,stk3335", },
> +	{ .compatible = "sensortek,stk3013", .data = &stk3310_chip_info },
> +	{ .compatible = "sensortek,stk3310", .data = &stk3310_chip_info },
> +	{ .compatible = "sensortek,stk3311", .data = &stk3310_chip_info },
> +	{ .compatible = "sensortek,stk3335", .data = &stk3310_chip_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, stk3310_of_match);

