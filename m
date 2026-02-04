Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5494A25776
	for <linux-iio@vger.kernel.org>; Wed,  4 Feb 2026 15:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219490; cv=none; b=SJH5ySPFXAKDto2UdN89ue4bAPFHjG/SzPCMk6UABJxzX6bkbl6AzEPbC7hYODkj0v8zd78GTYMXy56Lzml2drNE+w0hMakk0CUCoyeyC8VStI3sobkf+Ocgqv/TzFN4b7Fm+kLiw4mz2SA5cLRQWb5uvbSzASjO0CunsMKPpLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219490; c=relaxed/simple;
	bh=2U0ZLbRGRuxcfWWhFBar0DXXzr1V5+bpp9z4zXRGikA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HY5h6yUiwo5HQ2v27F41bwGc4GpBkWRk+x40rB0dubaEn7RJYzD8sbm8d+YOT0UfFLRY2sTEytV/79aWXZV9KxlPPAbnAAM6PVom/nbvaLDVZpMFFz8+d86KGsWbE65jYxssvQY6WQb/TPmY9N96vFkJ4zSbJIuxXZeEq+txL0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rFdMelO7; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rFdMelO7"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7cfd95f77a3so4494099a34.0
        for <linux-iio@vger.kernel.org>; Wed, 04 Feb 2026 07:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770219488; x=1770824288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=blkfjw5Kfqdb7kT/8wrUlXk97uMbSySck24pBd+yHrc=;
        b=rFdMelO7VKg0o2peev5uoTkOQwY8hCWrPxop6cnScyOcPjzih1/ii58WX8/+uAz2bL
         HicdCo1mnE+cih5M5deOx+sCNoLUmboxw06qIPaAbz91GgQQyUEaY8BKz6YpqxsjSRIp
         owvRvr+DQGb9urqR+GGyMLV0Y0endNq55GCoOARV3Hg5KUnZB3fKjQ7/XEx1yc2LfKwZ
         L6MffVLYBm16BP6rwLe2aJf9DHluPKI34Mzbi/AbbsrxxFRrQohBfYTACcy7NgdPvxuK
         +6tK9YCbCRTiBlLnD4XcAywdCgjPHFPruy3QItZ1LIoKrOpSc67XBjamyvDvgSRtaCDG
         2jCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770219488; x=1770824288;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=blkfjw5Kfqdb7kT/8wrUlXk97uMbSySck24pBd+yHrc=;
        b=nvObrNUC7pkzhBfufEcwfXD3J3uULjlPPhOcv06Ni4RcF/mdxvXfdEgfkoIFoEV9G4
         CwtaA8Vj0O1fZJ7/+H4+f3DRpNoEgrWWt4sAbngvJrzjfi3tGq7+sHpmZSXxMjkmT703
         YRbHrEIMiLYA0VB/QEwiFatIqgq9kem9Yqb/L9CXnMroAuwOopg4ONmnSLiJ7KH4hXL4
         Lj6b2HCYB7piN1kWM2hbc3sMun/HidRwd57nrC9X137yYXcVsA+miuJq6PaBUOZBd8mC
         ZlKoiDKY72LiVnF3kjRjOtMu1h7YWyHYETPsA8f+7z3aDWXeYsD0SeCMCM5ERfHbndq6
         xZhw==
X-Forwarded-Encrypted: i=1; AJvYcCXX57kAQWFFrC4aXrBroqLi/5+nhyLFB9DkFSDhzB0lpta/R1JltqKgad3CDRGW2CoWckXnoXTAdYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YybpDS2Zb8tIa9qAEswb9HTyUuQzzgMv/sPQbKXbh/iQ1w1ndA+
	R6MgsZvArH+N/jBGhewN7nPNzMe+q2ZPeq/KY3aQdZTfMDGiXtEWIYMiT7YCl1EDMow=
X-Gm-Gg: AZuq6aJgOvFhXYa4Wnohhv6oIYCXgPcXFVK+SOHFCXiBeIQxlXZhHEKQhtJnMcf7huw
	0IJJ22/YhvBQ/AXw/dE3aLrU/OkxduUoCIpxHb8qxVmmbZrca7emqK0h7AeLv8jUHJfEUAWsOvN
	EZfX6+QIIkTHk6wljzvSQ9uHDet0sQwQNxpyROqO/FvM8IIleNcgE/iVDK136m76GyPoQ0jx8/G
	AQ7NSAO3FffMdcksloBiMuENy62PRDGYM/GAjc4AjrZwsLAr6IU3GHrdPMiHvu8npTjWxS8V92A
	k1XmmBeXqey4SzOhZw+BiSNWteVwQLTnW1/wduxPjc4kiHCAaQ4jxrHlhif6nRqKaWD2BZC1egi
	p154ainieBKTudBVZGLarFtdtNPrph///nFNNZpZukEcJNoRgBLVxVrW9u9cQwFWbJHGc0bkx2X
	7u7IInvN7uYeME1wq9/l2yep4Ty6cyr/1ptC20eCoiOWC3qzGLHHAfIpqeLA==
X-Received: by 2002:a05:6830:2541:b0:7cf:e57f:def6 with SMTP id 46e09a7af769-7d448972675mr2135095a34.6.1770219488069;
        Wed, 04 Feb 2026 07:38:08 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:319e:ed90:d5d:7e61? ([2600:8803:e7e4:500:319e:ed90:d5d:7e61])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4490f3c06sm1849081a34.2.2026.02.04.07.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 07:38:07 -0800 (PST)
Message-ID: <b52a3013-4878-4054-8b71-edc35f32c4e2@baylibre.com>
Date: Wed, 4 Feb 2026 09:38:06 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] iio: adc: ad7768-1: add support for SPI offload
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Michael.Hennerich@analog.com, lars@metafoo.de, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org
References: <cover.1769889074.git.Jonathan.Santos@analog.com>
 <9f9aedbe374461e48f1f1e64d5487b5b6c1fc992.1769889074.git.Jonathan.Santos@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <9f9aedbe374461e48f1f1e64d5487b5b6c1fc992.1769889074.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/31/26 7:35 PM, Jonathan Santos wrote:
> The AD7768-1 family supports sampling rates up to 1 MSPS, which exceeds
> the capabilities of conventional triggered buffer operations due to SPI
> transaction overhead and interrupt latency.
> 
> Add SPI offload support to enable hardware-accelerated data acquisition
> that bypasses software SPI transactions using continuous data streaming.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---

...

>  struct ad7768_state {
>  	struct spi_device *spi;
> +	struct spi_offload *offload;
> +	struct spi_offload_trigger *offload_trigger;
>  	struct regmap *regmap;
>  	struct regmap *regmap24;
>  	int vref_uv;
> @@ -306,8 +325,11 @@ struct ad7768_state {
>  	struct gpio_desc *gpio_reset;
>  	const char *labels[AD7768_MAX_CHANNELS];
>  	struct gpio_chip gpiochip;
> +	struct spi_transfer offload_xfer;
> +	struct spi_message offload_msg;
>  	const struct ad7768_chip_info *chip;
>  	bool en_spi_sync;
> +	bool offload_en;

offload_en makes it sound like the offload could be enabled or disabled
at runtime, but that doesn't seem to be the case. I would just check if
offload != NULL rather than add a new field. Or change this to has_offload.

>  	struct mutex pga_lock; /* protect device internal state (PGA) */
>  	/*
>  	 * DMA (thus cache coherency maintenance) may require the
> @@ -1139,6 +1161,10 @@ static int ad7768_get_current_scan_type(const struct iio_dev *indio_dev,
>  {
>  	struct ad7768_state *st = iio_priv(indio_dev);
>  
> +	if (st->offload_en)
> +		return st->oversampling_ratio == 8 ?
> +			AD7768_SCAN_TYPE_OFFLOAD_HIGH_SPEED : AD7768_SCAN_TYPE_OFFLOAD_NORMAL;
> +
>  	return st->oversampling_ratio == 8 ?
>  	       AD7768_SCAN_TYPE_HIGH_SPEED : AD7768_SCAN_TYPE_NORMAL;
>  }
> @@ -1320,7 +1346,7 @@ static irqreturn_t ad7768_interrupt(int irq, void *dev_id)
>  	struct iio_dev *indio_dev = dev_id;
>  	struct ad7768_state *st = iio_priv(indio_dev);
>  
> -	if (iio_buffer_enabled(indio_dev))
> +	if (iio_buffer_enabled(indio_dev) && !st->offload_en)

I would expect that the interrupt is just disabled when doing a buffered
read with SPI offload. No sense in wasting CPU time. So no special handling
should be needed here.

>  		iio_trigger_poll(st->trig);
>  	else
>  		complete(&st->completion);
> @@ -1357,6 +1383,72 @@ static const struct iio_buffer_setup_ops ad7768_buffer_ops = {
>  	.predisable = &ad7768_buffer_predisable,
>  };
>  
> +static int ad7768_offload_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	struct spi_offload_trigger_config config = {
> +		.type = SPI_OFFLOAD_TRIGGER_DATA_READY,
> +	};
> +	const struct iio_scan_type *scan_type;
> +	int ret;
> +
> +	scan_type = iio_get_current_scan_type(indio_dev, &indio_dev->channels[0]);
> +	if (IS_ERR(scan_type))
> +		return PTR_ERR(scan_type);
> +
> +	st->offload_xfer.len = roundup_pow_of_two(BITS_TO_BYTES(scan_type->realbits));

We have spi_bpw_to_bytes() for this.

> +	st->offload_xfer.bits_per_word = scan_type->realbits;
> +	st->offload_xfer.offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
> +
> +	/*
> +	 * Write a 1 to the LSB of the INTERFACE_FORMAT register to enter
> +	 * continuous read mode. Subsequent data reads do not require an
> +	 * initial 8-bit write to query the ADC_DATA register.
> +	 */
> +	ret =  regmap_write(st->regmap, AD7768_REG_INTERFACE_FORMAT, 0x01);
> +	if (ret)
> +		return ret;
> +
> +	spi_message_init_with_transfers(&st->offload_msg, &st->offload_xfer, 1);
> +	st->offload_msg.offload = st->offload;
> +
> +	ret = spi_optimize_message(st->spi, &st->offload_msg);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "failed to prepare offload, err: %d\n", ret);

Do we need to do someting to undo AD7768_REG_INTERFACE_FORMAT write if this fails?

> +		return ret;
> +	}
> +
> +	ret = spi_offload_trigger_enable(st->offload,
> +					 st->offload_trigger,
> +					 &config);
> +	if (ret) {
> +		spi_unoptimize_message(&st->offload_msg);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +

...

> +static bool ad7768_offload_trigger_match(struct spi_offload_trigger *trigger,
> +					 enum spi_offload_trigger_type type,
> +					 u64 *args, u32 nargs)
> +{
> +	if (type != SPI_OFFLOAD_TRIGGER_DATA_READY)
> +		return false;
> +
> +	/* Requires 1 arg to indicate the trigger output signal */

The DT bindings allow 1 or 2 args, so we should also allow nargs == 2 even (the
2nd arg is just ignored).

> +	if (nargs != 1 || args[0] != AD7768_TRIGGER_SOURCE_DRDY)
> +		return false;
> +
> +	return true;
> +}
> +
> +static int ad7768_offload_trigger_request(struct spi_offload_trigger *trigger,
> +					  enum spi_offload_trigger_type type,
> +					  u64 *args, u32 nargs)
> +{
> +	/* Should already be validated by match, but just in case. */
> +	if (nargs != 1)

As above.

> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
