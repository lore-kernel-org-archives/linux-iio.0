Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A7BEAC7
	for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 19:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775936906; cv=none; b=FqEOPc0yi7rsJNYsWyIu3P5HNv/QTcP4IuPDmNPL7hxAJ3bhjyrgWyQ6hEhR6iRuqxKYlHVrcyGKDzt5yCn0DrwFAONYfA0cm/S10qukMKZtODbehKOfRW9GUWuU5G2nLxtdZ+yW1Dv6u5uU8CnrGBMC4N8a+Ulnw+s8KXmi5xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775936906; c=relaxed/simple;
	bh=ym8GfoIBqrIMcc4pKwd5Jh5e2DuzzYrSfMQzWAkR/Po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gz30GasPA7AqPEXD3ddyyBd9K8abNJlIAllMHrfe3W8/WoqFjX+HZFzy0SRINVN9TFMvkJPlw26/mo67sHsDZ1b2izsYuqr3zAd2FBSWnGbVsH80JZLglxLyxw7PxuWCcLop/dsaF9eUzfZfuF7xh3HVCIdNyZUwDH124kSfKDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=qFsLpz3w; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="qFsLpz3w"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-40ede943bf0so1942031fac.2
        for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 12:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775936903; x=1776541703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=arKhOc5Bz7HGwOSw+V6oF9pwALnDqmL4gyLcqB7kdsg=;
        b=qFsLpz3wQ2kBfW3z6pJNUmASCA6/DZCau6SJ3Rg+0I1f7whAAh3lpEP6JA1YsZlUXn
         Vw/cqd8sNOJnVZiNvYTRvxewxPxG2JY+MxExKh2KhdoRYQ+C4hFjw2wueOnqQxFLwYMh
         lSGInvXHX+xn6nNWCmrCfQt1nXU8k/DaO3wGvc+nLbSktwxXi3/GDvxr4qE03lZDAjoR
         e2Mjvzg81TPQT+T1OUckarEffrn8wibgbNClpQIyfoMn4z8WWSH2vvOO3OGfcP0em5wi
         AS4cnrMZ10Z6qpOfXq8NyWPn7sj21Z/4//cheiHFHQGET1+2aVb8s6pyFXufb+e49mZw
         rkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775936903; x=1776541703;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=arKhOc5Bz7HGwOSw+V6oF9pwALnDqmL4gyLcqB7kdsg=;
        b=aRtZoYDb5hrYTrgRkrFvmop8MVJQfc7NhS+Qc2jbX9byzSyYUzGgR11RG/aNKRiWPn
         TY4vq94Of1iX4FJYOuxScD6Y3oi1BllNHD3SIogx/rKF/nIZoLC/ZSrymagMJs4wRV0y
         HCXSgrIZSD+bMTJcIFACST2QtTLR15vSVGe5VvPTUqjbnM+/v1vt9Oxg7PdSB3HufB+5
         XLk4aPhOl+VNy5NplDDYfAtA5Zw0y2skMGa3kFJRn9tiuBwxP7dLwkm4KreB9Gj6qjm4
         nppCpcpXPnuPYuLVKZd9BAkyM+p7Zsrsmil96qI+M0UyV28CeFA1NLc3Cf2pR4Ntie18
         JJjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhuVdQ5intZpCHMHqM2rUzDB/TYJGuAQvc4FqpurVIWqKi4qnhMhkI2GEBlDHEbaJUjtEAUMvKZHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxtxDJA49cy5lmL2qsE1Z5ECKQFikd9IUbVoldfDH1jAomg+py
	Ku0LKhvPo8oU3ur9+ZZO1epy1+ah9a8lCj5+diJu7hbrnceMiBMddWx5W0mRnTRLero=
X-Gm-Gg: AeBDiesae1K/ScFgqW4ecO+w/FWvg8+j5o7VM8dpaPbeizAZi4kUuS/diWkHzoCoKMT
	ecPm9Y5z6fpat5K4r1x74vOySDH1jVvsIoj7u0EC86cleUSFH30TFdo4jiY/iCtkfAknY1ULLNG
	EIJUF+9pD7IFONqzmPTRPvXEGVkmWdPQjGhU3mXRD+YoxU8FSbjM7yHDCBa0xmBL4VdkIURFSaN
	ailrU5ZLIFLnhBKeMVTA9wL19SiPMR3d5gLukH6f0LhmtNn4tM44m6BT1MRJBEwoF1V3f8n9tWo
	VLhhLOVGz1qkThzFWGaNqeeWn6ziBMjxkapviWfHrhYTodbWe8hzc5JMnY0VaqgbDjs0MhZ7OuS
	UdRY4OJY2KnTx6XAOIySZ5K3I1Vtn7iPoWDRDFhlypDe5cgSCUTqFH4P0jbVZnohE74TAr+uTBP
	/8SEAA3KImNJkt8hyay3rYMlaqOXU/DnVKmQWs2qBzE9XahiKB4jGE2BHU9XGdg7oe6akBE+K2s
	A==
X-Received: by 2002:a05:6870:45aa:b0:41c:6512:8419 with SMTP id 586e51a60fabf-423e10dbd2cmr4318652fac.28.1775936902735;
        Sat, 11 Apr 2026 12:48:22 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:d2e5:c81c:5b23:fe55? ([2600:8803:e7e4:500:d2e5:c81c:5b23:fe55])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-423ddb20c0fsm4920432fac.11.2026.04.11.12.48.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Apr 2026 12:48:22 -0700 (PDT)
Message-ID: <45f6a6dc-e027-4616-8cea-9be8d006521a@baylibre.com>
Date: Sat, 11 Apr 2026 14:48:20 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iio: dac: mcp4821: add configurable gain support
To: Nikhil Gautam <nikhilgtr@gmail.com>, jic23@kernel.org
Cc: anshulusr@gmail.com, linux-iio@vger.kernel.org
References: <acYb1XOmw1yoyu_4@nik>
 <20260327061802.13043-1-nikhilgtr@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260327061802.13043-1-nikhilgtr@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Please don't send new revisions in reply to previous revisions. It breaks
some tools. Always start a new thread for a new revision.

On 3/27/26 1:18 AM, Nikhil Gautam wrote:
> Add support for configuring the DAC gain using the GA bit.
> Expose gain control via IIO_CHAN_INFO_CALIBSCALE.
> 
> Scale is updated dynamically based on selected gain:
> - 1x gain → 2.048V full-scale
> - 2x gain → 4.096V full-scale
> 
> Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
> ---
> Changes in v2:
> - Drop header reordering
> - Move MCP4821_GAIN_ENABLE define before MCP4802_SECOND_CHAN
> - Use IIO_CHAN_INFO_SCALE instead of CALIBSCALE since full scale changes
> - Restore original -EINVAL handling in default cases
> 
> Changes in v3:
> - Restored NULL check in indio_dev alloc
> ---
>  drivers/iio/dac/mcp4821.c | 103 ++++++++++++++++++++++++++++++--------
>  1 file changed, 82 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iio/dac/mcp4821.c b/drivers/iio/dac/mcp4821.c
> index 748bdca9a964..9160812219f9 100644
> --- a/drivers/iio/dac/mcp4821.c
> +++ b/drivers/iio/dac/mcp4821.c
> @@ -12,7 +12,6 @@
>   *	MCP48x2: https://ww1.microchip.com/downloads/en/DeviceDoc/20002249B.pdf
>   *
>   * TODO:
> - *	- Configurable gain
>   *	- Regulator control
>   */
>  
> @@ -26,12 +25,32 @@
>  #include <linux/unaligned.h>
>  
>  #define MCP4821_ACTIVE_MODE BIT(12)
> +#define MCP4821_GAIN_ENABLE BIT(13)
>  #define MCP4802_SECOND_CHAN BIT(15)
>  
> -/* DAC uses an internal Voltage reference of 4.096V at a gain of 2x */
> -#define MCP4821_2X_GAIN_VREF_MV 4096
> +/* DAC uses an internal Voltage reference of 2.048V */
> +#define MCP4821_VREF_MV 2048
>  
> -enum mcp4821_supported_drvice_ids {
> +/*
> + * MCP48xx DAC output:
> + *
> + * Vout = (Vref * D / 2^N) * G
> + *
> + * where:
> + *  - Vref = 2.048V (internal reference)
> + *  - N = DAC resolution (12 bits for MCP4821)
> + *  - G = gain selection:
> + *        1x when GA bit = 1
> + *        2x when GA bit = 0 (default)
> + *
> + * Therefore full-scale voltage is:
> + *  - 1x gain: 2.048V
> + *  - 2x gain: 4.096V
> + *
> + * Scale = Vfull-scale / 2^N
> + */
> +
> +enum mcp4821_supported_device_ids {

Unrelated change. Spelling error should be fixed in a separate patch.

>  	ID_MCP4801,
>  	ID_MCP4802,
>  	ID_MCP4811,
> @@ -43,6 +62,7 @@ enum mcp4821_supported_drvice_ids {
>  struct mcp4821_state {
>  	struct spi_device *spi;
>  	u16 dac_value[2];
> +	bool gain_1x;
>  };
>  
>  struct mcp4821_chip_info {
> @@ -57,6 +77,7 @@ struct mcp4821_chip_info {
>  		.channel = (channel_id),                              \
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),         \
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
> +		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE), \
>  		.scan_type = {                                        \
>  			.realbits = (resolution),                     \
>  			.shift = 12 - (resolution),                   \
> @@ -122,8 +143,13 @@ static int mcp4821_read_raw(struct iio_dev *indio_dev,
>  		state = iio_priv(indio_dev);
>  		*val = state->dac_value[chan->channel];
>  		return IIO_VAL_INT;
> +
>  	case IIO_CHAN_INFO_SCALE:
> -		*val = MCP4821_2X_GAIN_VREF_MV;


> +		state = iio_priv(indio_dev);

I would start with a separate patch to move setting state to where it
is declared so that we don't have to duplicate this line in each case.


> +		if (state->gain_1x)
> +			*val = MCP4821_VREF_MV;
> +		else
> +			*val = MCP4821_VREF_MV * 2;

Why not make the variable store the gain value instead of being bool?

Then this can just be:

		*val = MCP4821_VREF_MV * state->gain;

>  		*val2 = chan->scan_type.realbits;
>  		return IIO_VAL_FRACTIONAL_LOG2;
>  	default:
> @@ -140,34 +166,66 @@ static int mcp4821_write_raw(struct iio_dev *indio_dev,
>  	__be16 write_buffer;
>  	int ret;
>  
> -	if (val2 != 0)
> -		return -EINVAL;
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
>  
> -	if (val < 0 || val >= BIT(chan->scan_type.realbits))
> -		return -EINVAL;
> +		if (val2 != 0)
> +			return -EINVAL;
>  
> -	if (mask != IIO_CHAN_INFO_RAW)
> -		return -EINVAL;
> +		if (val < 0 || val >= BIT(chan->scan_type.realbits))
> +			return -EINVAL;
> +
> +		write_val = MCP4821_ACTIVE_MODE | val << chan->scan_type.shift;
> +		if (chan->channel)
> +			write_val |= MCP4802_SECOND_CHAN;
> +		if (state->gain_1x)
> +			write_val |= MCP4821_GAIN_ENABLE;
>  
> -	write_val = MCP4821_ACTIVE_MODE | val << chan->scan_type.shift;
> -	if (chan->channel)
> -		write_val |= MCP4802_SECOND_CHAN;
> +		write_buffer = cpu_to_be16(write_val);
> +		ret = spi_write(state->spi, &write_buffer, sizeof(write_buffer));
> +		if (ret) {
> +			dev_err(&state->spi->dev, "Failed to write to device: %d", ret);
> +			return ret;
> +		}
>  
> -	write_buffer = cpu_to_be16(write_val);
> -	ret = spi_write(state->spi, &write_buffer, sizeof(write_buffer));
> -	if (ret) {
> -		dev_err(&state->spi->dev, "Failed to write to device: %d", ret);
> -		return ret;
> +		state->dac_value[chan->channel] = val;
> +		return 0;
> +
> +	case IIO_CHAN_INFO_SCALE:


> +		if (val == 1)
> +			state->gain_1x = true;
> +		else if (val == 2)
> +			state->gain_1x = false;
> +		else
> +			return -EINVAL;

And this can be:

		if (!in_range(val, 1, 2))
			return -EINVAL;

		state->gain = val;

> +		return 0;
> +	default:
> +		return -EINVAL;
>  	}
> +}
>  
> -	state->dac_value[chan->channel] = val;
> +static const int mcp4821_gain_avail[] = {1, 2};

The attribute is the scale attribute, not gain, so these need to
be: { MCP4821_VREF_MV, 2 * MCP4821_VREF_MV } combined with...

>  
> -	return 0;
> +static int mcp4821_read_avail(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      const int **vals, int *type, int *length,
> +			      long info)
> +{
> +	switch (info) {
> +	case IIO_CHAN_INFO_SCALE:
> +		*vals = mcp4821_gain_avail;
> +		*type = IIO_VAL_INT;

... IIO_VAL_FRACTIONAL_LOG2.

The idea is that the scale_available attribute should return the same
values as the scale attribute.

> +		*length = 2;
> +		return IIO_AVAIL_LIST;

> +	default:
> +		return -EINVAL;
> +	}
>  }
>  
>  static const struct iio_info mcp4821_info = {
>  	.read_raw = &mcp4821_read_raw,
>  	.write_raw = &mcp4821_write_raw,
> +	.read_avail = &mcp4821_read_avail,
>  };
>  
>  static int mcp4821_probe(struct spi_device *spi)
> @@ -183,6 +241,9 @@ static int mcp4821_probe(struct spi_device *spi)
>  	state = iio_priv(indio_dev);
>  	state->spi = spi;
>  
> +	/* default gain is 2x as GA bit is active low*/
> +	state->gain_1x = false;
> +
>  	info = spi_get_device_match_data(spi);
>  	indio_dev->name = info->name;
>  	indio_dev->info = &mcp4821_info;

