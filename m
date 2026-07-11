Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBDA25DB1A
	for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 14:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783780408; cv=none; b=kkdQwdr3YRvOgGkhfqyzpToaZeaQmQPvj3sNe5U9t+Psq0eSVSlX0iiz5r+qZaPfPGYFZXw6scK/zsZI2HUMFT/ji9B1VhonhBYuPvxnVQ5a5MGSo4CFh8l9ZQY2aewAmf7ndkUfUqb68Z+AoSfAXG92j+jJb4rPLH8u3JqEPns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783780408; c=relaxed/simple;
	bh=qVipgHOBpx41dSC7v0weGrXYha/INIFVRx2IXh4riwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lMilcWoXtJdDRawEThRQ7TGfl9wSs9GMXQeEdH6gGY68AGBTUsIDzAr9NzRXhtoLFM+F2cU+uyykDYijpDDEHyLpczROV/lrGYoM2iE2q5GZZmqupMfc9WicFmmkGRIbDvORyA2sPUdAh1OIkY/0+nmMp+GzOA/JSA9R7wshM7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=TMiii6zf; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="TMiii6zf"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4955cd5da3dso742143b6e.2
        for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 07:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783780404; x=1784385204; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7ANE1fxQe57OuRECeLcRe8WkdUSBILcKueuA4U5TIdQ=;
        b=TMiii6zfyMd/Q/Xlx1V8s3tImnIxjgDpVCjybVZAa8A8hKfBlQVb6uK4Dhtb1GImpg
         KZvqb/S6OuqIpbU6SWzr17Hl8ndYrtz8Jl13UPcyUAl+DUpB0f8fvPOy1fCBD4d/A2N+
         95OOurZbTgJ3e5nL2Nu9CGVAXg4jHkh4uZAgBv+dvqPYoofvxZM0izGxk8pelzvO/0Rn
         6S/EES9dBJrNCOMfT+Hs8ZNimU+5EmZKTpDgcV5hE5iuyfyEye6FTshVEqkGWZpIyCiV
         g1AqbSiT0MS/rGdCNaknQ2ll5vdDFA8S3uRUo7x6bsEbI/BxSBMMz9Wz79DNV8Nkvg6x
         lg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783780404; x=1784385204;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7ANE1fxQe57OuRECeLcRe8WkdUSBILcKueuA4U5TIdQ=;
        b=FwNYURsM7pjKaHvMlPxLM2SuzSY6+Myr1ws39rw+nQxVE1hZCDLbN8xieCUL1i+9pz
         8aY2Jmo7k/GNzcj93e0clmdzeV31LRiUUEVGS5vOsRJ7OVYb74OHJBWk7cr4AeZlCYHe
         QYfIVtg6L926gGOTxWFYnkQncgZyj1BbwWp2Ew+Gz5T6yG318711Q7igG5YeLSkC2u7e
         nYsdbiS+j9yLV+zKiR+RkV26TguaQRSitJsXrI9teB3FpfydhNxflwGn1TnFP1TH/74S
         6zfJ0LhXitVVnhiSQOfvCaN2TfWmU+LOUuqGY0+Uh/gjub+JZC6cUcZgEhg+c+qkqKrA
         NWMA==
X-Gm-Message-State: AOJu0Yyz0WU7Ab24faCoC1nv71SYLtDDofkBxvhm+10qKkqPp+AO2wti
	EHcQQVF2GsFVHs6JNgocB9XMK5yeWIGXmShjYW0i43ZTWXGCuU9bpgap0cSfY7n1AZYlzGoQqS+
	KfNea
X-Gm-Gg: AfdE7ckZ3FXYUt2GRQW9NHB3gCtzfXgjnayzCa0hE+ZCjwiYopP0Ezq1q1ZeUDXcByt
	fkZH2yPtGCrdbEnRD3lsHdPamcTB5FpSOhBjPXHHlnApooztnbVNftRlqi4X7LZJlQdAYNY7Hnf
	eiGQb6Nl7bcA7k/Yfb2+m2nhny/BzyYRidqA/eVaqYI8Glf5H5NtEEW93mV4zi2YvJ8zMmM4C7H
	3JGxQfm9+karh44eemsmC6nFvcwbPKq/YRjxFJRQRahVK7iHdC9WUtSQcSzVO+AvpThStcIMR94
	fGr9uy99HuuixM1fYPVcM5Ld7ruVf0BH+249gAGxjBrl+wAklPAYF3afL/fVR8HT3hGaUNkZfHF
	BuhZDgsNply9v7G3N1UMQdCA0IKhQXJx70L94XrcZxZyHrvABAnALK8vFLT4vbCvcrjyQuaIcBf
	HqU9rqNV46B0T9DR6Ezrn9ldDCoIyKJOJoMyQuI4IdBg0+n3JVCYcenr2qVCYRS8o=
X-Received: by 2002:a05:6808:10d3:b0:496:10b0:20f0 with SMTP id 5614622812f47-4a42affec11mr2289056b6e.42.1783780404461;
        Sat, 11 Jul 2026 07:33:24 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:a950:74e5:81f2:8c89? ([2600:8803:e7e4:500:a950:74e5:81f2:8c89])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a42ae81f1esm1924545b6e.11.2026.07.11.07.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jul 2026 07:33:22 -0700 (PDT)
Message-ID: <ef17bf0d-4837-4cd6-85d9-b5417d3740f8@baylibre.com>
Date: Sat, 11 Jul 2026 09:33:22 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: light: opt3001: split opt3001_get_processed()
 logic
To: Joshua Crofts <joshua.crofts1@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260711-opt3001-unwind-cleanup-v2-1-47f617e00c65@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260711-opt3001-unwind-cleanup-v2-1-47f617e00c65@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/11/26 1:14 AM, Joshua Crofts wrote:
> Split the logic inside the opt3001_get_processed() function, as the
> current flow is hard to read, mixing IRQ and non-IRQ code blocks.
> 
> Separate the IRQ code path into its own function, same for the
> non-IRQ path.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
> This patch fixes the absolutely horrible code flow in the
> opt3001_get_processed() function, where the original implementation
> used checks whether IRQ mode is enabled to execute blocks of code,
> making the function hard to read. Ideas on how to improve the functions
> are more than welcome.
> 
> Originally suggested by Jonathan Cameron.
> ---
> Changes in v2:
> - Remove ternary operator and add if/else
> - Remove timeout variable
> - Link to v1: https://lore.kernel.org/r/20260708-opt3001-unwind-cleanup-v1-1-900b2cfddb6a@gmail.com
> ---
>  drivers/iio/light/opt3001.c | 197 ++++++++++++++++++++++++++------------------
>  1 file changed, 118 insertions(+), 79 deletions(-)
> 
> diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
> index 2bce6cd5f4e4..d1a2426cd355 100644
> --- a/drivers/iio/light/opt3001.c
> +++ b/drivers/iio/light/opt3001.c
> @@ -316,36 +316,33 @@ static const struct iio_chan_spec opt3002_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(1),
>  };
>  
> -static int opt3001_get_processed(struct opt3001 *opt, int *val, int *val2)
> +static int opt3001_get_processed_irq(struct opt3001 *opt, int *val, int *val2)
>  {
>  	struct i2c_client *client = opt->client;
>  	struct device *dev = &client->dev;
> -	int ret;
>  	u16 mantissa;
> -	u16 reg;
>  	u8 exponent;
>  	u16 value;
> -	long timeout;
> +	u16 reg;
> +	int ret;
>  
> -	if (opt->use_irq) {
> -		/*
> -		 * Enable the end-of-conversion interrupt mechanism. Note that
> -		 * doing so will overwrite the low-level limit value however we
> -		 * will restore this value later on.
> -		 */
> -		ret = i2c_smbus_write_word_swapped(client,
> -						   OPT3001_LOW_LIMIT,
> -						   OPT3001_LOW_LIMIT_EOC_ENABLE);
> -		if (ret < 0) {
> -			dev_err(dev, "failed to write register %02x\n",
> -				OPT3001_LOW_LIMIT);
> -			return ret;
> -		}
> -
> -		/* Allow IRQ to access the device despite lock being set */
> -		opt->ok_to_ignore_lock = true;
> +	/*
> +	 * Enable the end-of-conversion interrupt mechanism. Note that
> +	 * doing so will overwrite the low-level limit value however we
> +	 * will restore this value later on.
> +	 */
> +	ret = i2c_smbus_write_word_swapped(client,
> +					   OPT3001_LOW_LIMIT,
> +					   OPT3001_LOW_LIMIT_EOC_ENABLE);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to write register %02x\n",
> +			OPT3001_LOW_LIMIT);
> +		return ret;
>  	}
>  
> +	/* Allow IRQ to access the device despite lock being set */
> +	opt->ok_to_ignore_lock = true;
> +
>  	/* Reset data-ready indicator flag */
>  	opt->result_ready = false;
>  
> @@ -367,70 +364,33 @@ static int opt3001_get_processed(struct opt3001 *opt, int *val, int *val2)
>  		goto err;
>  	}
>  
> -	if (opt->use_irq) {
> -		/* Wait for the IRQ to indicate the conversion is complete */
> -		ret = wait_event_timeout(opt->result_ready_queue,
> -					 opt->result_ready,
> -					 msecs_to_jiffies(OPT3001_RESULT_READY_LONG));
> -		if (ret == 0) {
> -			ret = -ETIMEDOUT;
> -			goto err;
> -		}
> -	} else {
> -		/* Sleep for result ready time */
> -		timeout = (opt->int_time == OPT3001_INT_TIME_SHORT) ?
> -			OPT3001_RESULT_READY_SHORT : OPT3001_RESULT_READY_LONG;
> -		msleep(timeout);
> -
> -		/* Check result ready flag */
> -		ret = i2c_smbus_read_word_swapped(client, OPT3001_CONFIGURATION);
> -		if (ret < 0) {
> -			dev_err(dev, "failed to read register %02x\n",
> -				OPT3001_CONFIGURATION);
> -			goto err;
> -		}
> -
> -		if (!(ret & OPT3001_CONFIGURATION_CRF)) {
> -			ret = -ETIMEDOUT;
> -			goto err;
> -		}
> -
> -		/* Obtain value */
> -		ret = i2c_smbus_read_word_swapped(client, OPT3001_RESULT);
> -		if (ret < 0) {
> -			dev_err(dev, "failed to read register %02x\n",
> -				OPT3001_RESULT);
> -			goto err;
> -		}
> -		opt->result = ret;
> -		opt->result_ready = true;
> -	}
> +	ret = wait_event_timeout(opt->result_ready_queue,
> +				 opt->result_ready,
> +				 msecs_to_jiffies(OPT3001_RESULT_READY_LONG));
> +	if (ret == 0)
> +		ret = -ETIMEDOUT;
>  
>  err:
> -	if (opt->use_irq)
> -		/* Disallow IRQ to access the device while lock is active */
> -		opt->ok_to_ignore_lock = false;
> +	opt->ok_to_ignore_lock = false;
>  
>  	if (ret < 0)
>  		return ret;
>  
> -	if (opt->use_irq) {
> -		/*
> -		 * Disable the end-of-conversion interrupt mechanism by
> -		 * restoring the low-level limit value (clearing
> -		 * OPT3001_LOW_LIMIT_EOC_ENABLE). Note that selectively clearing
> -		 * those enable bits would affect the actual limit value due to
> -		 * bit-overlap and therefore can't be done.
> -		 */
> -		value = (opt->low_thresh_exp << 12) | opt->low_thresh_mantissa;
> -		ret = i2c_smbus_write_word_swapped(client,
> -						   OPT3001_LOW_LIMIT,
> -						   value);
> -		if (ret < 0) {
> -			dev_err(dev, "failed to write register %02x\n",
> -				OPT3001_LOW_LIMIT);
> -			return ret;
> -		}
> +	/*
> +	 * Disable the end-of-conversion interrupt mechanism by
> +	 * restoring the low-level limit value (clearing
> +	 * OPT3001_LOW_LIMIT_EOC_ENABLE). Note that selectively clearing
> +	 * those enable bits would affect the actual limit value due to
> +	 * bit-overlap and therefore can't be done.
> +	 */
> +	value = (opt->low_thresh_exp << 12) | opt->low_thresh_mantissa;
> +	ret = i2c_smbus_write_word_swapped(client,
> +					   OPT3001_LOW_LIMIT,
> +					   value);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to write register %02x\n",
> +			OPT3001_LOW_LIMIT);
> +		return ret;
>  	}
>  
>  	exponent = OPT3001_REG_EXPONENT(opt->result);
> @@ -441,6 +401,85 @@ static int opt3001_get_processed(struct opt3001 *opt, int *val, int *val2)
>  	return IIO_VAL_INT_PLUS_MICRO;
>  }
>  
> +static int opt3001_get_processed_noirq(struct opt3001 *opt, int *val, int *val2)
> +{
> +	struct i2c_client *client = opt->client;
> +	struct device *dev = &client->dev;
> +	u16 mantissa;
> +	u8 exponent;
> +	int ret;
> +	u16 reg;
> +


> +	/* Reset data-ready indicator flag */
> +	opt->result_ready = false;
> +
> +	/* Configure for single-conversion mode and start a new conversion */
> +	ret = i2c_smbus_read_word_swapped(client, OPT3001_CONFIGURATION);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to read register %02x\n",
> +			OPT3001_CONFIGURATION);
> +		goto err;
> +	}
> +
> +	reg = ret;
> +	opt3001_set_mode(opt, &reg, OPT3001_CONFIGURATION_M_SINGLE);
> +
> +	ret = i2c_smbus_write_word_swapped(client, OPT3001_CONFIGURATION, reg);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to write register %02x\n",
> +			OPT3001_CONFIGURATION);
> +		goto err;
> +	}
> +

This chunk of code is now repeated in both functions, so could be
moved to a new common function.

> +	if (opt->int_time == OPT3001_INT_TIME_SHORT)
> +		msleep(OPT3001_RESULT_READY_SHORT);
> +	else
> +		msleep(OPT3001_RESULT_READY_LONG);
> +
> +	/* Check result ready flag */
> +	ret = i2c_smbus_read_word_swapped(client, OPT3001_CONFIGURATION);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to read register %02x\n",
> +			OPT3001_CONFIGURATION);
> +		goto err;
> +	}
> +
> +	if (!(ret & OPT3001_CONFIGURATION_CRF)) {
> +		ret = -ETIMEDOUT;
> +		goto err;
> +	}
> +
> +	/* Obtain value */
> +	ret = i2c_smbus_read_word_swapped(client, OPT3001_RESULT);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to read register %02x\n",
> +			OPT3001_RESULT);
> +		goto err;
> +	}
> +
> +	opt->result = ret;
> +	opt->result_ready = true;
> +
> +err:
> +	if (ret < 0)
> +		return ret;


> +
> +	exponent = OPT3001_REG_EXPONENT(opt->result);
> +	mantissa = OPT3001_REG_MANTISSA(opt->result);
> +
> +	opt3001_to_iio_ret(opt, exponent, mantissa, val, val2);
> +
> +	return IIO_VAL_INT_PLUS_MICRO;

This part is repeated in both functions, so can be moved to the
common function below.

> +}
> +
> +static int opt3001_get_processed(struct opt3001 *opt, int *val, int *val2)
> +{
> +	if (opt->use_irq)
> +		return opt3001_get_processed_irq(opt, val, val2);
> +
> +	return opt3001_get_processed_noirq(opt, val, val2);
> +}
> +
>  static int opt3001_get_int_time(struct opt3001 *opt, int *val, int *val2)
>  {
>  	*val = 0;
> 
> ---
> base-commit: fef4337eb2888c758c7058e1723903204f012a26
> change-id: 20260708-opt3001-unwind-cleanup-9aeede365655
> 
> Best regards,

