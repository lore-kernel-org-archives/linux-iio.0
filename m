Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DAE150997
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 13:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776175060; cv=none; b=RCV0xUvcMUjXuZbVaeVRMc3oXXFH9Q2mZgiQKEs14FjY+1N8ds0Fk/S/wUuTLoZeVDQ1S4VIYA/Zf+FmrNNiLjb+R4P2NbqawnkVB0kj7WEdE5a1SRyAPRqCmh6rCZnjJabp+A9yqvNjJoJDNPhJ2KhWiAAe1JjMxuiA5hEkuzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776175060; c=relaxed/simple;
	bh=kzPhbTfMqE6Rn4XFNMPVuCv+WuyxpMhgfHITma2e6pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pg/HFMjsM5ZHbl3wXTD9wUhTvMm6XM4FUa10Uk8v9uuIfFO8drTSj5VZf91rv6gGRoCBZb5YoJbJg2x112odISi5FrBeyA0g+bAMXDXuPfmGT7aTzNnU16LuLdngLkSeS+8eojEooA4f/dLrCjQCO3BAb21Eptk2GIib4irTPT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=cMqbC841; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="cMqbC841"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7dbf23885dfso3386317a34.3
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 06:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776175056; x=1776779856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CY4/fDA36JbdHEggLUPNkPNxknTCbHt2HC74bDp5beA=;
        b=cMqbC841jrEoNU61b1x9aXX+CmcWGOTkHdVgei5VziwUTnXfF9rciBzG01zvGWggJ4
         0VNaWHdtiXAlbh7Kc7ho1qv00J0h0TnnqRYUjHVhJFjbAkOMXe22U2vKVn4X//5aeSMS
         lopkytBuALy3SEdrWBgKByCHSR/VIEflwP+zjlPD3/ssKcZcSR+HVeRcayAu9Fj1n683
         p4i+tKDLKPtXin1rChxFGe4DhCYepq8/355vDx8JwpdJ176SeC1+A87k+6OGpPYgHThR
         Axvl8BJWvopucj1ycqJKqfPHKb+Tc0V3vCimfJaYd/mJhDfD4fCdLWjKm0lo1DdVmJKJ
         9J5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776175056; x=1776779856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CY4/fDA36JbdHEggLUPNkPNxknTCbHt2HC74bDp5beA=;
        b=hTNMmJQdNJt4asakNkCSUbdFqC+ZVVP6bFki+SqI9kmImJbRCi77STE+JtITx1hKTi
         kDeWxH6+iqYYfB/hfyjUdV37NS8OBhdJhXq2HbYaPEUtzXJg5pEyM7ukwCvip51BwBzW
         uoXZq7tfI14uAnKTEUbos5ZePvXZWykmSV8oH777sIwMJEmrIyfAXnWZp2ZWLgVL4Tpg
         FuXm72qb0hIAbXcWkbJgPDNNfiuUHylGcbR/qELy0MC3keVfuWy6QAQZDy2pCiDfBzSY
         RZUbLJND/MdW347RohyUfVwVRwswyVmwPJAakjzcH67s0cF45tLWonCxRMuXePmtaJI7
         Oojg==
X-Forwarded-Encrypted: i=1; AFNElJ/GbJUCxpO7mUCyNBwN8Xfqqa6LEAHGS1jbPIE8SGpdiyoFDcxExalt2qDOkl6aMC3Et4eaxF6GwQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMNnkwGg7IM7u3hcwOkO/XN00c2kKIBPvqVYqg+3HH15HJsQVh
	8sVAuwFLkOUYRQ1YhJ5A9XH3HB6oCvRTfDxOIs3YldKl9AdmiaJ1pDjgwC0SEu+KHxA=
X-Gm-Gg: AeBDietJ/Emo7vEoZ2um85gh2XrJjku4gINHln5UUojekpVVbs5lFRVFBY1dg/9HSpC
	YBt5BOkKS/NWRTqWARB230vYp/ZrQPCO8JMjea35ybtW9gjxYsVL9s8eFcWYnjmRTeo0eBcDxJm
	es6FrLbZL7t6kXR0FTCH89e771kErx3pFqKFyHt+iZb9YJgb6WHGoHLOaBEryi5xGcIDL+isQrD
	1+s2k7A+E/yDysQIFfMU94R+fuUCDrwKCyT4fRHMgJ1fy1Oo028nK1+F1J5NQjG9k+RoNSKgfJq
	fGgMgYSylfnGh4Gy5EwMvpzLUssYyyK4MeduEecwKXSjUeykXCpByxxfEDEO33/xeNI8+3Fo+sT
	6OJvMuh5U/nFyVDs38R0xjjbTb+rAUDkWirw6zw9ba8Fn3Y07tBQclBmiaTqWbsMjY36dEE2naZ
	q14p8BasR81uLtJFC66sydc5F0z8vci5vDcGHagzVcQa+wmcySTDx6qf7df3MaJ6HUrDTgQl96F
	w==
X-Received: by 2002:a9d:7089:0:b0:7dc:3d7e:40d8 with SMTP id 46e09a7af769-7dc3d7e4d5amr4660463a34.28.1776175056621;
        Tue, 14 Apr 2026 06:57:36 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:5bfd:a817:5527:c417? ([2600:8803:e7e4:500:5bfd:a817:5527:c417])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc3ee565e2sm7338517a34.3.2026.04.14.06.57.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 06:57:36 -0700 (PDT)
Message-ID: <dd2c2d45-ea48-4024-8d35-c3f482515fd7@baylibre.com>
Date: Tue, 14 Apr 2026 08:57:35 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] iio: dac: mcp4821: add configurable gain support
To: Nikhil Gautam <nikhilgtr@gmail.com>, linux-iio@vger.kernel.org
Cc: jic23@kernel.org
References: <20260414092254.34883-1-nikhilgtr@gmail.com>
 <20260414092254.34883-4-nikhilgtr@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260414092254.34883-4-nikhilgtr@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/26 4:22 AM, Nikhil Gautam wrote:
> Add support for configuring the DAC gain using the GA bit and
> update scale handling
> 

...

> +enum gain_modes {
> +	MCP4821_GAIN_X1 = 1,
> +	MCP4821_GAIN_X2 = 2,

We try to avoid making enums that just map the number 1 to 1
and so on.

> +};
> +
>  struct mcp4821_state {
>  	struct spi_device *spi;
>  	u16 dac_value[2];
> +	int gain;
> +	int avail_gain[4];

Would make more sense to call this scale_avail.

>  };
>  
>  struct mcp4821_chip_info {
> @@ -57,6 +83,7 @@ struct mcp4821_chip_info {
>  		.channel = (channel_id),                              \
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),         \
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
> +		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE), \
>  		.scan_type = {                                        \
>  			.realbits = (resolution),                     \
>  			.shift = 12 - (resolution),                   \
> @@ -121,8 +148,9 @@ static int mcp4821_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_RAW:
>  		*val = state->dac_value[chan->channel];
>  		return IIO_VAL_INT;
> +
>  	case IIO_CHAN_INFO_SCALE:
> -		*val = MCP4821_2X_GAIN_VREF_MV;
> +		*val = MCP4821_VREF_MV * state->gain;
>  		*val2 = chan->scan_type.realbits;
>  		return IIO_VAL_FRACTIONAL_LOG2;
>  	default:
> @@ -130,6 +158,17 @@ static int mcp4821_read_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static void mcp4821_calc_scale(int vref_mv, int resolution,
> +				int *val, int *val2)
> +{
> +	s64 tmp;
> +	int micro;
> +
> +	tmp = (s64)vref_mv * 1000000LL >> resolution;

Use MICRO instead of writing lots of 0s.

> +	*val = div_s64_rem(tmp, 1000000LL, &micro);
> +	*val2 = micro;

Technically, IIO_VAL_FRACTIONAL_LOG2 can print up to 9 digits after
the decimal, so this would be safer to do nano instead of micro.

For that, we need to also implement a write_raw_get_fmt() callback.

> +}
> +
>  static int mcp4821_write_raw(struct iio_dev *indio_dev,
>  			     struct iio_chan_spec const *chan, int val,
>  			     int val2, long mask)

...

> @@ -182,12 +271,15 @@ static int mcp4821_probe(struct spi_device *spi)
>  	state = iio_priv(indio_dev);
>  	state->spi = spi;
>  
> +	/* default gain is 2x as GA bit is active low*/

Needs space before ending */

Saying "active low" is a bit odd. I think the main point of selecting
this value is so we don't break userspace that may already be depending
on it being the default.

> +	state->gain = MCP4821_GAIN_X2;
>  	info = spi_get_device_match_data(spi);
>  	indio_dev->name = info->name;
>  	indio_dev->info = &mcp4821_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = info->channels;
>  	indio_dev->num_channels = info->num_channels;
> +	mcp4821_init_avail_gain(state, info->channels[0].scan_type.realbits);
>  
>  	return devm_iio_device_register(&spi->dev, indio_dev);
>  }

