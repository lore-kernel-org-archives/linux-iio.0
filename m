Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D13F324B20
	for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2026 03:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789962437; cv=none; b=qpYsaHKcRa/WCch/nlwIpDBaC5MaxDkFcltaJOT4zMWwB1gvShA7luM1BPGwrFR1lIVGw+4ZESxqRb7XqDtf8vl8sxseD2OegCN/679IKf07+rjQsQ/UNFg8cCeRI7HuT+ROK5ZpeHaq88B1GQU3Prgfa6gwEM1anKLjkZDDXrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789962437; c=relaxed/simple;
	bh=Xwsx0IoG7pdlxWv+gqVn2pz0HMlQnsGHWJbTzIdDBJc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YYL4hvccojqAhDruzY/1J119ctN9tBvxU/rzlwfS7qYN0sWbHm43Ju8isuhw7bfpJWiovz9JXYFd76WrJSlxXvKJldTJ7fleoFd4yAN6mO4684338pl++aQJpy1jP8SXRdAPrRKf1qgpdHIRpMSSBLfL8ldEv0w0aefujdjs7QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJB2LjCG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJB2LjCG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3B41F000FF;
	Mon, 21 Sep 2026 03:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789962435;
	bh=61JAgPFDnqWbs60uXNmAe/+Sbg5fHaDLUHs02uau3tE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LJB2LjCGeUOiud1X3eWHcyx1Fporl82PRh7Z5LGChYlSF5SqEkmJD86o+hElKBPpl
	 ToJIxJMxyRMecswBBLTOktBPLYrkRWLQZBGBJlqw0d1OrLXK3bdFzFRfPvQsvXJ8lx
	 HN7R3ajSr4O/fA0g3DY272dAFfW8ZcG4b1NxlUGxNPOuB4WMQb1M3miflKiSXQs+6P
	 ZvP8ydkOKqTL/5SqfMo0NkbDSWGBhCjd+rO87f+jxz5z6FMCpkuwK9QZSkGQ6b+iGp
	 yN8vFhzqRNxEOeyKmz2SccfmDmHI/GAjfBVqJVCl7M678bIYIEteqCaptntuJfbwEC
	 rogQSKxsVUU+A==
Date: Mon, 21 Sep 2026 04:47:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Yuval Saar <thefireking@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, maxwell@maxwelld.cc
Subject: Re: [PATCH v2] iio: adc: mcp3422: use read_avail() for available
 attributes
Message-ID: <20260921044709.27d59a97@jic23-hlaptop>
In-Reply-To: <20260920160247.1224672-1-thefireking@gmail.com>
References: <20260919195507.94130-1-thefireking@gmail.com>
	<20260920160247.1224672-1-thefireking@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Sep 2026 19:00:29 +0300
Yuval Saar <thefireking@gmail.com> wrote:

> Custom sysfs show functions only expose the sampling frequency and
> scale lists to userspace. Use read_avail() and the channel _available
> masks so the IIO core creates sampling_frequency_available and
> in_voltage_scale_available. Sysfs names and formatted output are
> unchanged, and in-kernel IIO consumers can query the lists directly.
> 
> Replace magic numbers(chip ids and sample-rate values) with named constants.
> 
> Compile tested. checkpatch --strict clean. Sysfs names and available-list
> text checked against IIO core formatters. No hardware.
> 
> Assisted-by: LLM
> Signed-off-by: Yuval Saar <thefireking@gmail.com>
Hi Yuval

You've run into a somewhat aged driver here, so I think it needs a little
more surgery before landing this change.

Hopefully I've given enough details below - if not look at other recent
drivers for inspiration.  Suggestion would be a precursor patch getting
rid of the use of those IDs to replace them with a pointer to a structure
that encodes what we currently have as code as simple static const data.

Thanks

Jonathan

> ---
>  drivers/iio/adc/mcp3422.c | 168 ++++++++++++++++++++------------------
>  1 file changed, 90 insertions(+), 78 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
> index 36ba00edf..239438dc7 100644
> --- a/drivers/iio/adc/mcp3422.c
> +++ b/drivers/iio/adc/mcp3422.c
> @@ -19,11 +19,9 @@
>  #include <linux/i2c.h>
>  #include <linux/module.h>
>  #include <linux/delay.h>
> -#include <linux/sysfs.h>
>  #include <linux/unaligned.h>
>  
>  #include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
>  
>  #define MCP3422_CHANNEL_MASK	GENMASK(6, 5)
>  #define MCP3422_SRATE_MASK	GENMASK(3, 2)
> @@ -39,6 +37,25 @@
>  #define MCP3422_PGA_8	3
>  #define MCP3422_CONT_SAMPLING	BIT(4)
>  
> +/* Sample rates in SPS. MCP3422_SRATE_* above are the config-bit encodings. */
> +#define MCP3422_SPS_240	240
> +#define MCP3422_SPS_60	60
> +#define MCP3422_SPS_15	15
> +#define MCP3422_SPS_3	3
Defines that use the number in the name to give you a number on the right
are rarely useful.  Just use the numbers directly!  This applies
even when they are used in a few places.  The best representation for 3 is
the number 3 not a long name with 3 in it.


> +
> +/*
> + * i2c_device_id.driver_data / adc->id. MCP3421-4 are 18-bit (3 SPS
> + * available); MCP3425-8 are 16-bit and omit that rate.
> + */
> +#define MCP3421_ID		1
> +#define MCP3422_ID		2
> +#define MCP3423_ID		3
> +#define MCP3424_ID		4
> +#define MCP3425_ID		5
> +#define MCP3426_ID		6
> +#define MCP3427_ID		7
> +#define MCP3428_ID		8

This is highlighting another driver problem.  It would be much better
to just have the driver_data / match_data point to a structure with
any device specific info we need.  Then we can just have a flag
to say if they support 3 SPS or not.

> +
>  #define MCP3422_CHAN(_index) \
>  	{ \
>  		.type = IIO_VOLTAGE, \
> @@ -47,27 +64,33 @@
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) \
>  				| BIT(IIO_CHAN_INFO_SCALE), \
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +		.info_mask_shared_by_type_available = \

Curiously the current interface is shared_by_dir I think.
We should avoid ABI changes if possible and it is a correct if unusual
choice.

> +				BIT(IIO_CHAN_INFO_SCALE), \
> +		.info_mask_shared_by_all_available = \
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ), \
>  	}
>  
> -static const int mcp3422_scales[4][4] = {
> -	{ 1000000, 500000, 250000, 125000 },
> -	{ 250000,  125000, 62500,  31250  },
> -	{ 62500,   31250,  15625,  7812   },
> -	{ 15625,   7812,   3906,   1953   } };
> +/* IIO_VAL_INT_PLUS_NANO lists: { integer, nano } per PGA gain. */
> +static const int mcp3422_scale_avail[][8] = {
> +	[MCP3422_SRATE_240] = { 0, 1000000, 0, 500000, 0, 250000, 0, 125000 },
> +	[MCP3422_SRATE_60]  = { 0, 250000,  0, 125000, 0, 62500,  0, 31250  },
> +	[MCP3422_SRATE_15]  = { 0, 62500,   0, 31250,  0, 15625,  0, 7812   },
> +	[MCP3422_SRATE_3]   = { 0, 15625,   0, 7812,   0, 3906,   0, 1953   },
> +};
>  
>  /* Constant msleep times for data acquisitions */
> -static const int mcp3422_read_times[4] = {
> -	[MCP3422_SRATE_240] = 1000 / 240,
> -	[MCP3422_SRATE_60] = 1000 / 60,
> -	[MCP3422_SRATE_15] = 1000 / 15,
> -	[MCP3422_SRATE_3] = 1000 / 3 };
> -
> -/* sample rates to integer conversion table */
> -static const int mcp3422_sample_rates[4] = {
> -	[MCP3422_SRATE_240] = 240,
> -	[MCP3422_SRATE_60] = 60,
> -	[MCP3422_SRATE_15] = 15,
> -	[MCP3422_SRATE_3] = 3 };
> +static const int mcp3422_read_times[] = {
> +	[MCP3422_SRATE_240] = 1000 / MCP3422_SPS_240,
> +	[MCP3422_SRATE_60] = 1000 / MCP3422_SPS_60,
> +	[MCP3422_SRATE_15] = 1000 / MCP3422_SPS_15,
> +	[MCP3422_SRATE_3] = 1000 / MCP3422_SPS_3 };
> +
> +/* sample rates to integer conversion table; 3 SPS is last and 18-bit only */
> +static const int mcp3422_sample_rates[] = {
> +	[MCP3422_SRATE_240] = MCP3422_SPS_240,
> +	[MCP3422_SRATE_60] = MCP3422_SPS_60,
> +	[MCP3422_SRATE_15] = MCP3422_SPS_15,
> +	[MCP3422_SRATE_3] = MCP3422_SPS_3 };
>  
>  /* sample rates to sign extension table */
>  static const int mcp3422_sign_extend[4] = {
> @@ -169,7 +192,7 @@ static int mcp3422_read_raw(struct iio_dev *iio,
>  	case IIO_CHAN_INFO_SCALE:
>  
>  		*val1 = 0;
> -		*val2 = mcp3422_scales[sample_rate][pga];
> +		*val2 = mcp3422_scale_avail[sample_rate][2 * pga + 1];
>  		return IIO_VAL_INT_PLUS_NANO;
>  
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> @@ -199,8 +222,8 @@ static int mcp3422_write_raw(struct iio_dev *iio,
>  		if (val1 != 0)
>  			return -EINVAL;
>  
> -		for (i = 0; i < ARRAY_SIZE(mcp3422_scales[0]); i++) {
> -			if (val2 == mcp3422_scales[sample_rate][i]) {
> +		for (i = 0; i < ARRAY_SIZE(mcp3422_scale_avail[0]) / 2; i++) {
> +			if (val2 == mcp3422_scale_avail[sample_rate][2 * i + 1]) {

It's common to use an extra dimension of size 2 to provide the val / val2
part.  Then just cast it to pass to read_available() as that needs to cope
with both 1 element and 2 element lists.

>  				adc->pga[req_channel] = i;
>  
>  				FIELD_MODIFY(MCP3422_CHANNEL_MASK, &config, req_channel);
> @@ -213,17 +236,17 @@ static int mcp3422_write_raw(struct iio_dev *iio,
>  
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		switch (val1) {
> -		case 240:
> +		case MCP3422_SPS_240:
>  			temp = MCP3422_SRATE_240;
>  			break;
> -		case 60:
> +		case MCP3422_SPS_60:

Stick to numbers rather than 'matching' defines. 

>  			temp = MCP3422_SRATE_60;
>  			break;
> -		case 15:
> +		case MCP3422_SPS_15:
>  			temp = MCP3422_SRATE_15;
>  			break;
> -		case 3:
> -			if (adc->id > 4)
> +		case MCP3422_SPS_3:
> +			if (adc->id > MCP3424_ID)
>  				return -EINVAL;
>  			temp = MCP3422_SRATE_3;
>  			break;
> @@ -256,45 +279,34 @@ static int mcp3422_write_raw_get_fmt(struct iio_dev *indio_dev,
>  	}
>  }
>  
> -static ssize_t mcp3422_show_samp_freqs(struct device *dev,
> -		struct device_attribute *attr, char *buf)
> -{
> -	struct mcp3422 *adc = iio_priv(dev_to_iio_dev(dev));
> -
> -	if (adc->id > 4)
> -		return sprintf(buf, "240 60 15\n");
> -
> -	return sprintf(buf, "240 60 15 3\n");
> -}
> -
> -static ssize_t mcp3422_show_scales(struct device *dev,
> -		struct device_attribute *attr, char *buf)
> +static int mcp3422_read_avail(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      const int **vals, int *type, int *length,
> +			      long mask)
>  {
> -	struct mcp3422 *adc = iio_priv(dev_to_iio_dev(dev));
> +	struct mcp3422 *adc = iio_priv(indio_dev);
>  	u8 sample_rate = FIELD_GET(MCP3422_SRATE_MASK, adc->config);
>  
> -	return sprintf(buf, "0.%09u 0.%09u 0.%09u 0.%09u\n",
> -		mcp3422_scales[sample_rate][0],
> -		mcp3422_scales[sample_rate][1],
> -		mcp3422_scales[sample_rate][2],
> -		mcp3422_scales[sample_rate][3]);
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		*vals = mcp3422_scale_avail[sample_rate];
> +		*type = IIO_VAL_INT_PLUS_NANO;
> +		*length = ARRAY_SIZE(mcp3422_scale_avail[0]);
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*vals = mcp3422_sample_rates;
> +		*type = IIO_VAL_INT;
> +		if (adc->id <= MCP3424_ID)
> +			*length = ARRAY_SIZE(mcp3422_sample_rates);
> +		else
> +			/* 16-bit parts: drop trailing 3 SPS entry */
> +			*length = ARRAY_SIZE(mcp3422_sample_rates) - 1;
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
>  }
>  
> -static IIO_DEVICE_ATTR(sampling_frequency_available, S_IRUGO,
> -		mcp3422_show_samp_freqs, NULL, 0);
> -static IIO_DEVICE_ATTR(in_voltage_scale_available, S_IRUGO,
> -		mcp3422_show_scales, NULL, 0);
> -
> -static struct attribute *mcp3422_attributes[] = {
> -	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
> -	&iio_dev_attr_in_voltage_scale_available.dev_attr.attr,
> -	NULL,
> -};
> -
> -static const struct attribute_group mcp3422_attribute_group = {
> -	.attrs = mcp3422_attributes,
> -};
> -
>  static const struct iio_chan_spec mcp3421_channels[] = {
>  	MCP3422_CHAN(0),
>  };
> @@ -313,9 +325,9 @@ static const struct iio_chan_spec mcp3424_channels[] = {
>  
>  static const struct iio_info mcp3422_info = {
>  	.read_raw = mcp3422_read_raw,
> +	.read_avail = mcp3422_read_avail,
>  	.write_raw = mcp3422_write_raw,
>  	.write_raw_get_fmt = mcp3422_write_raw_get_fmt,
> -	.attrs = &mcp3422_attribute_group,
>  };
>  
>  static int mcp3422_probe(struct i2c_client *client)
> @@ -344,20 +356,20 @@ static int mcp3422_probe(struct i2c_client *client)
>  	indio_dev->info = &mcp3422_info;
>  
>  	switch (adc->id) {
> -	case 1:
> -	case 5:
> +	case MCP3421_ID:
> +	case MCP3425_ID:

As below. All this can be replaced by a look up into the structure
that we will be getting a pointer to from the match data.

>  		indio_dev->channels = mcp3421_channels;
>  		indio_dev->num_channels = ARRAY_SIZE(mcp3421_channels);
>  		break;
> -	case 2:
> -	case 3:
> -	case 6:
> -	case 7:
> +	case MCP3422_ID:
> +	case MCP3423_ID:
> +	case MCP3426_ID:
> +	case MCP3427_ID:
>  		indio_dev->channels = mcp3422_channels;
>  		indio_dev->num_channels = ARRAY_SIZE(mcp3422_channels);
>  		break;
> -	case 4:
> -	case 8:
> +	case MCP3424_ID:
> +	case MCP3428_ID:
>  		indio_dev->channels = mcp3424_channels;
>  		indio_dev->num_channels = ARRAY_SIZE(mcp3424_channels);
>  		break;
> @@ -382,14 +394,14 @@ static int mcp3422_probe(struct i2c_client *client)
>  }
>  
>  static const struct i2c_device_id mcp3422_id[] = {
> -	{ .name = "mcp3421", .driver_data = 1 },
> -	{ .name = "mcp3422", .driver_data = 2 },
> -	{ .name = "mcp3423", .driver_data = 3 },
> -	{ .name = "mcp3424", .driver_data = 4 },
> -	{ .name = "mcp3425", .driver_data = 5 },
> -	{ .name = "mcp3426", .driver_data = 6 },
> -	{ .name = "mcp3427", .driver_data = 7 },
> -	{ .name = "mcp3428", .driver_data = 8 },
> +	{ .name = "mcp3421", .driver_data = MCP3421_ID },
> +	{ .name = "mcp3422", .driver_data = MCP3422_ID },
> +	{ .name = "mcp3423", .driver_data = MCP3423_ID },
> +	{ .name = "mcp3424", .driver_data = MCP3424_ID },
> +	{ .name = "mcp3425", .driver_data = MCP3425_ID },
> +	{ .name = "mcp3426", .driver_data = MCP3426_ID },
> +	{ .name = "mcp3427", .driver_data = MCP3427_ID },
> +	{ .name = "mcp3428", .driver_data = MCP3428_ID },
As above, please make driver_data point to a structure (you'll
need a cast, but this is very common so lots of examples to look at).
Then we can introduce model specific data.  Often call that something like
struct mcp3421_chip_info = {
	struct iio_chan_spec *channels;
	int num_channels;
	bool supports_3sps;
};

Then just have an instance named after each chip with the appropriate
data.  This may seem overly complex, but as a driver gains more part
support this pattern has always proved easier to extend than IDs and
code that picks between them.

>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, mcp3422_id);
> 
> base-commit: 69fa76f0af3414cc189c3b0b807cb59e327ecc00

