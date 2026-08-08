Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCF53A169F
	for <linux-iio@vger.kernel.org>; Sat,  8 Aug 2026 18:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786214364; cv=none; b=NljFfYcgN7XEvgB2cqwW2CYPtuYwjBrNZpmUYiPKPKcgFrdKOV9oZrua0jV8BkmYEaXvRw0azbCGM7wFUe5Jj377ETQ/acR0M03plTIcLGPsHrvnPYQpJKsRbgNJ5sno6bpJtJgNbdzzgYvSSfHca+vCFsFoysh0m1dzDcIaSoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786214364; c=relaxed/simple;
	bh=DF5T9k9wXqRrWW/3DRHpYPp37Km3snDpH2AdlQ1S5KY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e3NJ/bpb0tZTh+QSukIInqhJ8Y2lHnFdvf+GmErFmAOIVmqGr+hgNHc5fC2vsJ54gb5uWSxlH8shVi5olnHF+LrTHTQgPPWHGYRbKBNd8RUG3/Khdy1pm5TC1lIaXD/U++WEbyUEgUrMQelzCxRtMvMf9WXHYloHLvjeXb4nbj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=KByalQ2K; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="KByalQ2K"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7eb1dc6bd53so357072a34.2
        for <linux-iio@vger.kernel.org>; Sat, 08 Aug 2026 11:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786214362; x=1786819162; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xTmko/UIhaHdTdyyYBVejmpjMSHJAjZ74UYAaIqTXAc=;
        b=KByalQ2KJDvYbx6zlGCgCoTGWrJGslBMEB9uel3ffwrUtKBxQJFTGA6q9YlG6R2Tg+
         U7ZnbW7IhdBHZBlyLayTQ5Mz7m2fUEEKEEOnpw0ucio/MLj7vv+bL3peoyl0ANE45tvD
         trDoLREgfSY/qp5977dqq0aeR00BvKHwSbBBJrvtqZImIulpIIO7GbQID/kPGvIjJ3P6
         uI9hNJ4Xhr36lgfp8xqdus8SbH1nR3o/QO97kDlaSPtUIffZ6db+yTlMvdwTmKpODQ6j
         EesOvbnbuufb16lveLTC1TlFYw8mkANFHqj2oBYPUDLzpUcaHQ2lV5Mg9cbLW1WPhcBG
         Quww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786214362; x=1786819162;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xTmko/UIhaHdTdyyYBVejmpjMSHJAjZ74UYAaIqTXAc=;
        b=dJxKp7kgdsKUSAg5AqLqKIPbJgTlpPTqa9Co/HtSSnTq6Qsdp8zJc4lSDGuo6l0YJw
         Wh8JPxG5bYjhI3W/ST6xPW1WpliPbhyt5j3jMumPdhFMDofrSBo1l4wDMtosLXXXhalf
         ZZLcLf/f9c+QdUBsjzV/gTyVcq7KF/cJemuODY1yFq88lp7/qYsNTvuHpYy+vVOTe+OG
         V8P9NloQarfINdKs5QBVcodUUMdHzkQfR1U1dNum2JGGjDqr3/NrJeIpSDG61T27wrus
         NURKb7Hay69fUJddJKvRyqbaLaWtJlHrozy5fFTGJ+FdX/PQjDLa2ka8bvt08SXZXNcR
         gG2g==
X-Forwarded-Encrypted: i=1; AHgh+RpBUaDrEskreQTwUeEEM1dlQ+ZxqtSUaac4VkmbMc1u1deQe+9lggLhtnNtm7VINhhLbwhtSICz6iU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Uah3NQD5gbT/+yqRrvhrEl2Hd87AK5WUGlij6KarQLCHandy
	3V8E/j8t5+1NtPww4gyLLn4EnxRnM6wE0FEhk7Cgahb/eqQLpGZq9MT6g8DKA1TnnUE=
X-Gm-Gg: AR+sD12PjQctG78KpNGCYKqSq4WUxRg9azgB8OVtT+0M4u0+1siVGErPoCsZd0ZRQwl
	gcAm4y58phZudDvijMFq28j8lv+ONdUbZA9H2X6l+8qNY8MGL102IqYRBZAiNigXmrSBeEqProH
	VvjaarnAL/9eY5BAuLXE4g33YSYYgke/DkHpDrdBfA5MwvRHjAuinfP6oMjkx8e9/D5+Yc+g1OM
	6N7BEw/d+N/1uxRJV/t490wgyXjKpbM9EUXAEsUZsBTQhEBBkTVn759CzwA8mXXsGNvOZWR8B25
	/8+2N6JzbpOaNlA55fw1dZiKAR5BG3qyYLLZgEUGcZaeGG2+SvpvhRSKARfEBPyTGcnA5/MUpgB
	RvgIhgNiHtv3BLvy/QmTwnJhlGwUC8PcXFpY1iiXKB1bpIe/INTmxrv8ZMEWr4eVrPLabefGzKF
	DHyu9TMnnzfqNrsw0njeFZOBYSCAkJlY1FwT8yu7oWNWZjVQgRrBuc14gnkqcX4gC0cAJSBqEPa
	m3BRlgMzWQXumTwpixyCwt3B7M1HrIaOC4XI/8=
X-Received: by 2002:a05:6830:2e01:b0:7e9:e8a6:6389 with SMTP id 46e09a7af769-7f1e5c9713dmr19717218a34.4.1786214361669;
        Sat, 08 Aug 2026 11:39:21 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:99c2:f16e:201c:3bb5? ([2600:8803:e7e4:500:99c2:f16e:201c:3bb5])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f35b7c4c3bsm3710095a34.24.2026.08.08.11.39.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Aug 2026 11:39:21 -0700 (PDT)
Message-ID: <6f403c9b-e6b4-4144-b78b-844d0cc02b1d@baylibre.com>
Date: Sat, 8 Aug 2026 13:39:20 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/9] iio: adc: ti-ads1262: support per-channel sampling
 frequency
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <20260807-ads126x-v3-0-f89925d72792@gmail.com>
 <20260807-ads126x-v3-3-f89925d72792@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260807-ads126x-v3-3-f89925d72792@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/7/26 10:58 PM, Kurt Borja wrote:
> Add per-channel sampling frequency support. The "available" attribute is
> assigned per-channel too, in order to eventually support per-filter
> availability.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>  drivers/iio/adc/ti-ads1262.c | 159 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 158 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1262.c b/drivers/iio/adc/ti-ads1262.c
> index d78e5e3ae13e..b3b7b1249102 100644
> --- a/drivers/iio/adc/ti-ads1262.c
> +++ b/drivers/iio/adc/ti-ads1262.c
> @@ -26,6 +26,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/spi/spi.h>
>  #include <linux/types.h>
> +#include <linux/units.h>
>  
>  #include <asm/byteorder.h>
>  
> @@ -148,6 +149,7 @@ enum {
>  	ADS1262_DR_14400_SPS,
>  	ADS1262_DR_19200_SPS,
>  	ADS1262_DR_38400_SPS,
> +	ADS1262_DR_COUNT,
>  };
>  

/* FIR filter has limited data rate range. */
#define ADS1262_DR_COUNT_FIR_FILTER (ADS1262_DR_20_SPS + 1)

So we can properly restrict the rate when the FIR filter
is selected.

>  enum {
> @@ -173,6 +175,11 @@ struct ads1262_chip_info {
>  	const char *name;
>  };
>  
> +struct ads1262_channel {
> +	u8 data_rate;
> +	int samp_freqs[ADS1262_DR_COUNT][2];
> +};
> +
>  struct ads1262 {
>  	struct spi_device *spi;
>  	struct regmap *regmap;
> @@ -183,12 +190,47 @@ struct ads1262 {
>  	/* Protects channel state */
>  	struct mutex chan_lock;
>  	unsigned int num_channels;
> +	struct ads1262_channel *channels;
>  	struct completion drdy;
>  
>  	/* Protects transfer buffers and concurrent SPI transfers */
>  	struct mutex xfer_lock;
>  };
>  

Could use a comment to explain this is based on datasheet table
showing decimation ratios which correspond to the last two columns.

> +static const u32 ads1262_data_rate_div[] = {
> +	[ADS1262_DR_2_5_SPS]	= 8 * 64 * 5760,
> +	[ADS1262_DR_5_SPS]	= 8 * 64 * 2880,
> +	[ADS1262_DR_10_SPS]	= 8 * 64 * 1440,
> +	[ADS1262_DR_16_6_SPS]	= 8 * 64 * 864,
> +	[ADS1262_DR_20_SPS]	= 8 * 64 * 720,
> +	[ADS1262_DR_50_SPS]	= 8 * 64 * 288,
> +	[ADS1262_DR_60_SPS]	= 8 * 64 * 240,
> +	[ADS1262_DR_100_SPS]	= 8 * 64 * 144,
> +	[ADS1262_DR_400_SPS]	= 8 * 64 * 36,
> +	[ADS1262_DR_1200_SPS]	= 8 * 64 * 12,
> +	[ADS1262_DR_2400_SPS]	= 8 * 64 * 6,
> +	[ADS1262_DR_4800_SPS]	= 8 * 64 * 3,
> +	[ADS1262_DR_7200_SPS]	= 8 * 64 * 2,
> +	[ADS1262_DR_14400_SPS]	= 8 * 64 * 1,
> +	[ADS1262_DR_19200_SPS]	= 8 * 48 * 1,
> +	[ADS1262_DR_38400_SPS]	= 8 * 24 * 1,
> +};
> +
> +static int ads1262_find_two(const int (*array)[2], size_t num_elements, int val,
> +			    int val2)
> +{
> +	int i;
> +
> +	for (i = 0; i < num_elements; i++) {
> +		if (val == array[i][0] && val2 == array[i][1])
> +			break;

Just return i directly here.

> +	}
> +	if (i == num_elements)
> +		return -EINVAL;

Then can return directly here.

> +
> +	return i;
> +}
> +
>  static int ads1262_dev_cmd(struct ads1262 *st, u8 opcode)
>  {
>  	guard(mutex)(&st->xfer_lock);
> @@ -316,11 +358,19 @@ static int ads1262_wait_for_conversion(struct ads1262 *st)
>  static int ads1262_channel_enable(struct ads1262 *st,
>  				  const struct iio_chan_spec *spec)
>  {
> +	struct ads1262_channel *chan = &st->channels[spec->scan_index];
> +	int ret;
>  	u8 val;
>  
>  	guard(mutex)(&st->xfer_lock);
>  	guard(mutex)(&st->chan_lock);
>  
> +	val = FIELD_PREP(ADS1262_MODE2_DR_MASK, chan->data_rate);
> +	ret = regmap_update_bits(st->regmap, ADS1262_MODE2_REG,
> +				 ADS1262_MODE2_DR_MASK, val);
> +	if (ret)
> +		return ret;
> +
>  	val = FIELD_PREP(ADS1262_INPMUX_MUXN_MASK, spec->channel2) |
>  	      FIELD_PREP(ADS1262_INPMUX_MUXP_MASK, spec->channel);
>  	return regmap_update_bits(st->regmap, ADS1262_INPMUX_REG,
> @@ -372,6 +422,8 @@ static int ads1262_read_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan, int *val,
>  			    int *val2, long mask)
>  {
> +	struct ads1262 *st = iio_priv(indio_dev);
> +	struct ads1262_channel *chan_data = &st->channels[chan->scan_index];
>  	__be32 raw;
>  	int ret;
>  
> @@ -384,6 +436,65 @@ static int ads1262_read_raw(struct iio_dev *indio_dev,
>  
>  		return IIO_VAL_INT;
>  
> +	case IIO_CHAN_INFO_SAMP_FREQ: {
> +		guard(mutex)(&st->chan_lock);
> +
> +		*val = chan_data->samp_freqs[chan_data->data_rate][0];
> +		*val2 = chan_data->samp_freqs[chan_data->data_rate][1];
> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	}
> +
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int ads1262_read_avail(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan, const int **vals,
> +			      int *type, int *length, long mask)
> +{
> +	struct ads1262 *st = iio_priv(indio_dev);
> +	struct ads1262_channel *chan_data = &st->channels[chan->scan_index];
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		*vals = (const int *)chan_data->samp_freqs;
> +		*length = ARRAY_SIZE(chan_data->samp_freqs) * 2;

For now, this should be ADS1262_DR_COUNT_FIR_FILTER * 2 for now since
FIR filter is the default.

> +		return IIO_AVAIL_LIST;
> +
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int ads1262_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int val,
> +			     int val2, long mask)
> +{
> +	struct ads1262 *st = iio_priv(indio_dev);
> +	struct ads1262_channel *chan_data = &st->channels[chan->scan_index];
> +	int ret;
> +
> +	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +	if (IIO_DEV_ACQUIRE_FAILED(claim))
> +		return -EBUSY;
> +
> +	guard(mutex)(&st->chan_lock);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = ads1262_find_two(chan_data->samp_freqs,
> +				       ARRAY_SIZE(chan_data->samp_freqs),

Likewise ADS1262_DR_COUNT_FIR_FILTER here too for now.

> +				       val, val2);
> +		if (ret < 0)
> +			return -EINVAL;

Just return ret;

> +
> +		chan_data->data_rate = ret;
> +
> +		return 0;
> +
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> @@ -404,6 +515,8 @@ static int ads1262_debugfs_reg_access(struct iio_dev *indio_dev, unsigned int re
>  
>  static const struct iio_info ads1262_iio_info = {
>  	.read_raw = ads1262_read_raw,
> +	.read_avail = ads1262_read_avail,
> +	.write_raw = ads1262_write_raw,
>  	.debugfs_reg_access = ads1262_debugfs_reg_access,
>  };
>  
> @@ -575,6 +688,36 @@ static const struct regmap_bus ads1262_regmap_bus = {
>  	.max_raw_write = ADS1262_MAX_REGMAP_WRITE,
>  };
>  
> +static void ads1262_populate_samp_freqs(struct ads1262 *st,
> +					struct ads1262_channel *chan)
> +{
> +	int freq_Hz, freq_rem;

Shouldn't these be u64 and u32?

> +	u64 freq_uHz;
> +
> +	for (unsigned int i = 0; i < ARRAY_SIZE(chan->samp_freqs); i++) {
> +		freq_uHz = div_u64(mul_u32_u32(st->clk_rate, MICRO),
> +				   ads1262_data_rate_div[i]);
> +		freq_Hz = div_u64_rem(freq_uHz, MICRO, &freq_rem);
> +
> +		chan->samp_freqs[i][0] = freq_Hz;
> +		chan->samp_freqs[i][1] = freq_rem;
> +	}
> +}
> +
> +static int ads1262_populate_tables(struct iio_dev *indio_dev)
> +{
> +	struct ads1262 *st = iio_priv(indio_dev);
> +	struct ads1262_channel *chan;
> +
> +	for (unsigned int i = 0; i < st->num_channels; i++) {
> +		chan = &st->channels[i];
> +
> +		ads1262_populate_samp_freqs(st, chan);
> +	}
> +
> +	return 0;
> +}
> +
>  static int ads1262_gpio_setup(struct ads1262 *st)
>  {
>  	struct device *dev = &st->spi->dev;
> @@ -661,6 +804,11 @@ static int ads1262_parse_channels(struct iio_dev *indio_dev)
>  	if (st->num_channels > ADS1262_MAX_CHANNEL_COUNT)
>  		return dev_err_probe(dev, -EINVAL, "too many channels\n");
>  
> +	st->channels = devm_kcalloc(dev, st->num_channels, sizeof(*st->channels),
> +				    GFP_KERNEL);
> +	if (!st->channels)
> +		return -ENOMEM;
> +
>  	/* Account for the timestamp channel */
>  	num_specs = st->num_channels + 1;
>  	specs = devm_kcalloc(dev, num_specs, sizeof(*specs), GFP_KERNEL);
> @@ -681,6 +829,8 @@ static int ads1262_parse_channels(struct iio_dev *indio_dev)
>  			return dev_err_probe(dev, -EINVAL, "%s: duplicated channel reg\n",
>  					     fwnode_get_name(node));
>  
> +		st->channels[reg].data_rate = ADS1262_DR_20_SPS;
> +
>  		specs[reg].scan_index = reg;
>  		specs[reg].scan_type = (struct iio_scan_type) {
>  			.format = IIO_SCAN_FORMAT_SIGNED_INT,
> @@ -701,7 +851,10 @@ static int ads1262_parse_channels(struct iio_dev *indio_dev)
>  		if (specs[reg].channel != ADS1262_INPMUX_TEMP)
>  			specs[reg].indexed = true;
>  
> -		specs[reg].info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> +		specs[reg].info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +						BIT(IIO_CHAN_INFO_SAMP_FREQ);
> +		specs[reg].info_mask_separate_available =
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ);
>  	}
>  
>  	specs[num_specs - 1] = IIO_CHAN_SOFT_TIMESTAMP(num_specs - 1);
> @@ -786,6 +939,10 @@ static int ads1262_spi_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> +	ret = ads1262_populate_tables(indio_dev);
> +	if (ret)
> +		return ret;
> +
>  	st->regmap = devm_regmap_init(dev, &ads1262_regmap_bus, st,
>  				      &ads1262_regmap_config);
>  	if (IS_ERR(st->regmap))
> 

