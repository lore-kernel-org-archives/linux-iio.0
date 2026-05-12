Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2BB3B8128;
	Tue, 12 May 2026 12:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778589496; cv=none; b=a2qCyhryykDWbwcKqHBCl7VRelvGMNWg6nz4dJ8fxzKbzcMy0shuARlOeKS8SrwGBCgF7LrOj3sasr2TemyPH/hjl7edTd4wA7EqNAgYaXgxbyeT5013PQV84CMw16FPGDNMYWO88AHthuGeagT4Twnjj3I5B39p6eyP+RBV1bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778589496; c=relaxed/simple;
	bh=CvcYX0aW+qbT8PxZMbz3l4WtmRd4Pj2jMjb2HPVhMh4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e2CQDvUybb6r5DZBv2PZZk89fXsrfvFuCZ08zBOtYUup38eIVoVt41nfwmmbh/CtTJsRE3xZFQbJSuMCTcQk/q9lCbO7zjwBbMoRKjGDUA34xF40WCQjxOLFQ74u7H0jDPVTJBuJqBQmL7D1RFr2kvLgcyoQU9q5QDsH42qsFIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USRdppdm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USRdppdm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68285C2BCB0;
	Tue, 12 May 2026 12:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778589495;
	bh=CvcYX0aW+qbT8PxZMbz3l4WtmRd4Pj2jMjb2HPVhMh4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=USRdppdmI3rJa1UGbq8Cx+GR2IiXoqtYLNrPZJ462Wnlm57s2g7ZiIFkZrt55I769
	 tZ0gvp6t+x+j0zx8qNSzbDcLgyZww86wC4jWeyIXisIWINblVXHUAZdUWet+wzE5Mp
	 ai4FRmZQXu42nAWJk4aY0OwvgG1XvM4LbCfU0Z0W59Lszz1dAPG2zXww/jN/DtHD2x
	 Edaq2mo67lWtkXXiZ1LIhAji/zKt28bxqq43VJe3m3dECv2G3yxEoUXopsRjtb5Vpp
	 pQykrSq0cJs4GX2d42eGwkynvIo/BjX208+Vvc8BFgHvLiEZphCGNKzfquldrtb3cx
	 EXJPsZVJnBVKg==
Date: Tue, 12 May 2026 13:38:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: ak@it-klinger.de, andriy.shevchenko@linux.intel.com,
 dlechner@baylibre.com, nuno.sa@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 v8 11/11] iio: adc: hx711: add support for HX710B
Message-ID: <20260512133806.74c566e0@jic23-huawei>
In-Reply-To: <20260511174342.123820-12-piyushpatle228@gmail.com>
References: <20260511174342.123820-1-piyushpatle228@gmail.com>
	<20260511174342.123820-12-piyushpatle228@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 23:13:36 +0530
Piyush Patle <piyushpatle228@gmail.com> wrote:

> Add support for the AVIA HX710B ADC, which shares the HX711 GPIO
> interface but uses trailing PD_SCK pulses to select the active mode.
> 
> Model the HX710B with variant-specific channel tables and IIO info,
> track the active channel across conversions, and use the fixed gain
> value when computing scale.
> 
> Also update the adjacent Kconfig text, file header, and module
> description so the driver text matches the newly supported variant.
> 
> Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Hi Piyush,

A few things I'd missed that Sashiko mentioned.
Note that most of what it calls out in v7 of this patch is wrong because
of the whole active_scan_mask / timestamp bit being set or not thing.

The channel representation is indeed odd and I think that bit needs
a rethink unfortunately.  I'd failed to notice it wasn't just two different
channels but instead is one physical set of inputs measured at different
sampling rates.


> @@ -403,16 +442,16 @@ static irqreturn_t hx711_trigger(int irq, void *p)
>  
>  	mutex_lock(&hx711_data->lock);
>  
> -	memset(&hx711_data->buffer, 0, sizeof(hx711_data->buffer));
> +	memset(hx711_data->buffer, 0, sizeof(hx711_data->buffer));
>  
>  	iio_for_each_active_channel(indio_dev, i) {
> -		hx711_data->buffer.channel[j] =
> +		hx711_data->buffer[j] =
>  			hx711_reset_read(hx711_data, &indio_dev->channels[i]);

Sashiko pointed out (v7 review) that this can return an error. We should
really be checking for negative values and if they occur don't push data
to the buffer.  Given this is unlikely to happen except when the device
is very broken, a rate limited dev_err is usual way to report this then
carry on without calling iio_push_to_buffers_with_timestamp().

>  		j++;
>  	}
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, &hx711_data->buffer,
> -							pf->timestamp);
> +	iio_push_to_buffers_with_timestamp(indio_dev, hx711_data->buffer,
> +					   pf->timestamp);
>  
>  	mutex_unlock(&hx711_data->lock);
>  
> @@ -463,6 +502,10 @@ static const struct iio_info hx711_iio_info = {
>  	.attrs			= &hx711_attribute_group,
>  };

> +/*
> + * HX710B channels (Table 3 in datasheet).
> + * 25 pulses (1 trailing): differential input, 10 SPS -> channel 0
> + * 26 pulses (2 trailing): DVDD-AVDD supply monitor, 40 SPS -> channel 2
> + * 27 pulses (3 trailing): differential input, 40 SPS -> channel 3

I'd missed this previously but sashiko raised a question on it.
Why are we representing the same physical input channel as two different IIO channels
based only on the sampling rate?  That doesn't seem to make a lot of sense.
Should be one channel with a sampling_frequency control.


> + * .address stores the trailing pulse count for hx711_set_hx710b_channel().
> + * Channel 2 is used for the supply monitor to avoid aliasing the
> + * channel2 terminal of the first differential pair.
> + */
> +static const struct iio_chan_spec hx710b_chan_spec[] = {
> +	{
> +		.type = IIO_VOLTAGE,
> +		.differential = 1,
> +		.channel = 0,
> +		.channel2 = 1,
> +		.indexed = 1,
> +		.address = 1,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = 0,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 24,
> +			.storagebits = 32,
> +			.endianness = IIO_CPU,
> +		},
> +	},
> +	{
> +		.type = IIO_VOLTAGE,
> +		.channel = 2,
> +		.indexed = 1,
> +		.address = 2,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = 1,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 24,
> +			.storagebits = 32,
> +			.endianness = IIO_CPU,
> +		},
> +	},
> +	{
> +		.type = IIO_VOLTAGE,
> +		.differential = 1,
> +		.channel = 3,
> +		.channel2 = 4,
> +		.indexed = 1,
> +		.address = 3,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = 2,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 24,
> +			.storagebits = 32,
> +			.endianness = IIO_CPU,
> +		},
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(3),
> +};

