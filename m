Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793554904;
	b=SFcwy2jEsARiNLPLxYlP3Rg2gFTsbbdyspw62F6RhqmUcpFadizBpYRRTeMtMkwN/xxk
	 CLMuCn0n2K67u0zCOlEuJ9DvrVkg6w7s/dWLDdNFIks7Kq/5U06rx9BxLRMciho6soBzD
	 hZ6cpoD4DkKkjBV10VfRFOcj5qhg8Se2nH8wn9gDFBvtk2oJIUaSNEbi5rIIvDQI+xIue
	 8HGW9i67XAYPdoVJWHo6xhQxacfda6mJv2dpWcdrG1rJLa9Go4BZPs6Z58KgKG2VJn/h8
	 XIliGcTNSs+cF9uiWhC66SIqIXFaYzfzVhr+A6EinDpa4IoI65kIMR3eqsUxeGfRGSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793554904;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZSWxv+vsV3OMpY3UoOnjoLymmnb2qgFdGAgFrnTm7wA=;
	b=Eyw4mGTtswy/zrClQGxgdABNragC/b2R1eatdgIDp7gV+z7rjUwQS/6x1oKZJ5KPuvKG
	 jdDLJEUiIGQBmdvI5qWrffjhUWfe1lrl0hvb+A63I1N7CZWylqRqgUQYLwkBHSX3DdaQ+
	 qoZokFHAX9HzwIYrwHIn+WwbOJyBVjrduYV7z7SwGyDveeVd3MZvEjwIAr5mm2oY7xAMT
	 IPGiF5uohXUlInJoENRGQoES6wX4vBgqupP68RuqQOnr961G2989eq+s4J53YbPzyafwd
	 G7TZnjHur01jZAwsav/WPWBsjVIw6CI5Gd6LtNaIEsKi3SeFtPvzwKwTb7Q/MpblIcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hJYf1Zmh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3ED606A32C;
	Sun,  1 Nov 2026 17:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hJYf1Zmh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3961F000C1;
	Sun,  1 Nov 2026 17:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793554903;
	bh=ZSWxv+vsV3OMpY3UoOnjoLymmnb2qgFdGAgFrnTm7wA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hJYf1Zmh2Yx9+qETVYUi6n/ZBYeFIK+4QJnS6Yn2Q23NGW/MPESWC54jo5Qhioi75
	 MUZ8ia1LeX5PcscI6EVBgWu6xB0lxUn4sJWDCBuFrF6rAZXzX6uVI+OQMp9xKZl1a7
	 1OePawjs35W9cDvd3BoBLEg9CBB99xp/FHEtSMfS0qgcqSoZrQGFn3EA8UmhU8yUGf
	 7uUNVXsuZUAiXu05o5VLCGqPFaJCMkW0YkpIBHVvv4XOyJ0ZOQERDfqw3qiBcVCCdM
	 O9SsPRB4aZ5MrJ2trR2gfUgDyhEp+rGAK3kehDgRLYeZniN6LkFz7SB9G/MLGwMvjN
	 ixQGjVXexQeNw==
Date: Sun, 1 Nov 2026 17:41:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Esben Haabendal <esben@geanix.com>, Kuppuswamy
 Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, "Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>, Pan Chuang <panchuang@vivo.com>, Hemanth
 Selam <hemanth.selam@gmail.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Nikita Travkin <nikita@trvn.ru>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] iio: light: ltr501: Add support for the
 LTR-659PS-01 proximity sensor
Message-ID: <20261101174140.4d11fdfc@jic23-hlaptop>
In-Reply-To: <20261101141507.119186-3-clamor95@gmail.com>
References: <20261101141507.119186-1-clamor95@gmail.com>
	<20261101141507.119186-3-clamor95@gmail.com>
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

On Sun,  1 Nov 2026 16:15:07 +0200
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> Add support for the Lite-On LTR-659PS-01 proximity sensor. This device is
> nearly identical to the LTR-559ALS-01, but omits all elements related to
> ambient light sensing (Even the regmap is identical, but ALS registers are
> marked as reserved and interactions with them are discouraged).
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Hi Svyatoslav,

Various more general comments on the driver in here. Only real request
is to not copy the rather ugly existing indentation for new code.

If nothing else comes up in review, I can just tidy that up whilst applying.
For now I'm going to leave this on list to give others time to take a
look.

Thanks,

Jonathan

> ---
>  drivers/iio/light/ltr501.c | 58 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> index 302be2fc314c5..5cc1141322ad5 100644
> --- a/drivers/iio/light/ltr501.c
> +++ b/drivers/iio/light/ltr501.c
> @@ -96,6 +96,7 @@ enum {
>  	ltr329,
>  	ltr501,
>  	ltr559,
> +	ltr659,
>  };
>  
>  struct ltr501_gain {
> @@ -649,6 +650,26 @@ static const struct iio_chan_spec ltr301_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(2),
>  };
>  
> +static const struct iio_chan_spec ltr659_channels[] = {
> +	{
> +		.type = IIO_PROXIMITY,
> +		.address = LTR501_PS_DATA,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = 0,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 11,
> +			.storagebits = 16,
> +			.endianness = IIO_CPU,
> +		},
> +		.event_spec = ltr501_pxs_event_spec,
> +		.num_event_specs = ARRAY_SIZE(ltr501_pxs_event_spec),
> +		.ext_info = ltr501_ext_info,
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(1),
> +};
> +
>  static int ltr501_read_info_raw(struct ltr501_data *data,
>  				struct iio_chan_spec const *chan,
>  				int *val)
> @@ -1178,6 +1199,12 @@ static struct attribute *ltr301_attributes[] = {
>  	NULL
>  };
>  
> +static struct attribute *ltr659_attributes[] = {
> +	&iio_dev_attr_in_proximity_scale_available.dev_attr.attr,
> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> +	NULL
> +};
Not something I'm going to ask for as part of this series, but
if anyone working with this driver has time it would be good to
move the available handling over to the read_avail() callback
and masks.  This is an old driver and so far not been converted
to that newer infrastructure.

> +
>  static const struct attribute_group ltr501_attribute_group = {
>  	.attrs = ltr501_attributes,
>  };
> @@ -1186,6 +1213,10 @@ static const struct attribute_group ltr301_attribute_group = {
>  	.attrs = ltr301_attributes,
>  };
>  
> +static const struct attribute_group ltr659_attribute_group = {
> +	.attrs = ltr659_attributes,
> +};
> +
>  static const struct iio_info ltr501_info_no_irq = {
>  	.read_raw = ltr501_read_raw,
>  	.write_raw = ltr501_write_raw,
> @@ -1218,6 +1249,22 @@ static const struct iio_info ltr301_info = {
>  	.write_event_config	= &ltr501_write_event_config,
>  };
>  
> +static const struct iio_info ltr659_info_no_irq = {
> +	.read_raw = ltr501_read_raw,
> +	.write_raw = ltr501_write_raw,
> +	.attrs = &ltr659_attribute_group,
> +};
> +
> +static const struct iio_info ltr659_info = {
> +	.read_raw = ltr501_read_raw,
> +	.write_raw = ltr501_write_raw,
> +	.attrs = &ltr659_attribute_group,
> +	.read_event_value	= &ltr501_read_event,
> +	.write_event_value	= &ltr501_write_event,
> +	.read_event_config	= &ltr501_read_event_config,
> +	.write_event_config	= &ltr501_write_event_config,

The indenting of the existing structure is weird and could do with a tidy up.
I'd suggest just dropping any attempt to force alignment.  As is shown
here, doing that tends to lead to inconsistency over time as a driver
evolves.

> +};
> +
>  static const struct ltr501_chip_info ltr501_chip_info_tbl[] = {
>  	[ltr301] = {
>  		.partid = 0x08,
> @@ -1283,6 +1330,15 @@ static const struct ltr501_chip_info ltr501_chip_info_tbl[] = {
>  		.channels = ltr501_channels,
>  		.no_channels = ARRAY_SIZE(ltr501_channels),
>  	},

Another nice to have but not a request for this series.
Would be good to move away from handling these as an array with the enum
value in the firmware tables. That scales badly and runs into NULL check
problems when we use the generic firmware accessors (which we should really
be using here). i2c_get_match_data().  The standard way to do this
today is to use separate named structures and put pointers to those in the
tables.

> +	[ltr659] = {
> +		.partid = 0x09,
> +		.ps_gain = ltr559_ps_gain_tbl,
> +		.ps_gain_tbl_size = ARRAY_SIZE(ltr559_ps_gain_tbl),
> +		.info = &ltr659_info,
> +		.info_no_irq = &ltr659_info_no_irq,
> +		.channels = ltr659_channels,
> +		.no_channels = ARRAY_SIZE(ltr659_channels),
> +	},
>  };
>  
>  static int ltr501_write_contr(struct ltr501_data *data, u8 als_val, u8 ps_val)
> @@ -1635,6 +1691,7 @@ static const struct i2c_device_id ltr501_id[] = {
>  	{ .name = "ltr329", .driver_data = ltr329 },
>  	{ .name = "ltr501", .driver_data = ltr501 },
>  	{ .name = "ltr559", .driver_data = ltr559 },
> +	{ .name = "ltr659", .driver_data = ltr659 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ltr501_id);
> @@ -1645,6 +1702,7 @@ static const struct of_device_id ltr501_of_match[] = {
>  	{ .compatible = "liteon,ltr329", },
>  	{ .compatible = "liteon,ltr501", },
>  	{ .compatible = "liteon,ltr559", },
> +	{ .compatible = "liteon,ltr659", },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, ltr501_of_match);

