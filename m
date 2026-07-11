Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654B9378830
	for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 15:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783782918; cv=none; b=hLAiyeqJrzeO/mejn3Fs8yjDM5zDVGl4x0D/Rvnk/QuDtkZ03nv9v0uqS9sG+I2ViT1i/FPVytvAZK/RDXYmW2AuDMXiTq+z5w7vq5+FOh1YLWe5rOoeYFM4UxBl4wCxb4vrM09gOBOI7dNUf4cmWfLp+ui/HyvrVNTxQ2MOLno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783782918; c=relaxed/simple;
	bh=7xqrjMGqzR9EHIB4uRKM9zPdLYD7l4XVQeSYGZXdoys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O0mUzXLuKbBulG9sGH2diuVaJ5s6Ast/toBHQnm+wdpc1xjYZtx3zBvnao96yqQJ15QUBAOc6LDE62PEodWOmT+6MOwA/xy+chDeLZnTS7Xm/z8oI363e50RMoc5CMGOpxVwteUQkQCMVKnn0XOJfyws/o7m4+4m57rAN4Qzxf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=LAp1Oqo0; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="LAp1Oqo0"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7eb5bdb50fcso1509700a34.1
        for <linux-iio@vger.kernel.org>; Sat, 11 Jul 2026 08:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783782913; x=1784387713; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OWYP02y3RjXkE4E/9yWYWof/7A/f0IuzrtUZZgCf/DU=;
        b=LAp1Oqo0UJ1LTf4bGL/ztLgpDIJl+xYO2cEW7FA0ratTnkRyD/EUV5GMOLRJu1q95c
         FGAoI2rolUEVZFh/T/8hGDb4rptJbLDXOFt+ywMnLaKAsj9v00eQsLXEexlxW1EuCIgd
         tIKcPkOMOUvPcPBcSEI7LON/O4MT9+hPJn8v8bVJJAqiOO7ch3wfRd+6PbWgjP0JHu39
         LFsMyiYrGYhNeP5eWyPJyJU8LJCimjOHuFGIAxks+6N/WwppIf7K5Mx+dFnDfN7Z3CgR
         NnqWFqCHoMp/nv9JL4oWHiyoSLza3mm7gBzOskJPCUAXOtduqfw4ESnHJGgJvpGZWCu2
         H6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783782913; x=1784387713;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OWYP02y3RjXkE4E/9yWYWof/7A/f0IuzrtUZZgCf/DU=;
        b=o3EKS09miWae7ajKTM4N/owGgWpSVw2u10QvDGjfQ/nlx9eS8c4AiZONVEkmHBJdAa
         HgDoQOZPHZWS6W3ObtAVWTcTD9a3syDvO3bVIvwMbw/bHUJfobfGitn6StIqEdsYtd//
         QUkB/U5RkY/8cUcFcaX4jfWwSZKkPuDVNVmTScuyZpjv/kFPqSG0eFUomXN9EygbRiDc
         yFRKXWFre9HCjfvcXKLkX+x0D/RG3lXHJ6fBIjV7P2oNJpHF6pEh84DzqSmv6R1CyF/j
         iAjGdbQtv3123SEY8yzzqJe3Jh4xStdh28iJ0b5IHN1TMk19i7QpHk2Craiym13sS1ci
         B3XQ==
X-Forwarded-Encrypted: i=1; AFNElJ9i2McsKxwQ4gFlngCiAS3nruqP3lkU5NS/up+ctOd/4Kl6U08xfLVb4yvQbeveJpqwP9GU+rF9Syc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr+c7hUAtCEyaaJol335e73iVbfen49bn62hdpqQl2JRUYy5gW
	lWP547c/0zDOC9TASmqBrPyYLpXFIW0aIZcc0BnMGG4YZ8XOPXBS+CPeUJOUFULH60M=
X-Gm-Gg: AfdE7cm8fZG8fw5TtTpcNbTgtj/p+AJGXrPmHxRlL8RZjOJncVVNYW+kqwwOjHF+U+H
	aVBDDJMqt6XYCGt5IGprZ4lwfjll2NGmZRGI4bsG/8csa1keKKSWZNYx6kdsauLyKn4qVKcT7nD
	w7+5FTu5TIl+SPxqb9QNxtguZXx6WnLHKwL4DzXtKQvYv0pCW9lzJixNPBeWhXf8o3lpPGoFxsW
	JswUYHnsj4Nwr1as5vZcgujTZMxhb2u4VTMZTvPj1YEJ5Ke/PAPqjfZ/Zt5Gos6USwDuTWnBBQ6
	vRtulAjMQ714edIaaNaqmcWVvhtQhk6Vh2WMtgGweUyQqbb8iOo6uYD/mN9Y0EuCdflMxc4Mhem
	dK9Y6CljDS1ySZCNO2zPoM/Pql9+Z193mCivoJ03/UUQZO5op8rzlBFwzewL8qSTEVNinbx4mVk
	pHy3Gfxuuggix7epkb7rajP5Rd1b5YJbfwSUwRxHd+90YL9rBRsfdnUPiaHY9ITTM=
X-Received: by 2002:a05:6830:6588:b0:7e9:3765:79c2 with SMTP id 46e09a7af769-7ec096ee1cbmr2107611a34.12.1783782912878;
        Sat, 11 Jul 2026 08:15:12 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:a950:74e5:81f2:8c89? ([2600:8803:e7e4:500:a950:74e5:81f2:8c89])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb2bda95sm8571375a34.24.2026.07.11.08.15.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jul 2026 08:15:11 -0700 (PDT)
Message-ID: <bbadaa66-2db1-4052-b161-39373cbe92c7@baylibre.com>
Date: Sat, 11 Jul 2026 10:15:10 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/7] iio: dac: ad5686: add triggered buffer support
To: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20260710-ad5686-new-features-v7-0-1bcc8c280e4d@analog.com>
 <20260710-ad5686-new-features-v7-6-1bcc8c280e4d@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260710-ad5686-new-features-v7-6-1bcc8c280e4d@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/26 6:20 AM, Rodrigo Alencar via B4 Relay wrote:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Implement trigger handler by leveraging the LDAC gpio to update all DAC
> channels at once when it is available. Also, the multiple channel writes
> can be flushed at once with the sync() operation.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  drivers/iio/dac/Kconfig  |  2 ++
>  drivers/iio/dac/ad5686.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 68 insertions(+)
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 17529509da9d..d6d560c09e25 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -243,6 +243,8 @@ config LTC2688
>  
>  config AD5686
>  	tristate
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  
>  config AD5686_SPI
>  	tristate "Analog Devices AD5686 and similar multi-channel DACs (SPI)"
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index df32f46db81e..eeeff5c6cf38 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -21,7 +21,11 @@
>  #include <linux/sysfs.h>
>  #include <linux/wordpart.h>
>  
> +#include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
>  
>  #include "ad5686.h"
>  
> @@ -243,6 +247,7 @@ static const struct iio_chan_spec_ext_info ad5686_ext_info[] = {
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),\
>  		.address = addr,				\
> +		.scan_index = chan,				\
>  		.scan_type = {					\
>  			.sign = 'u',				\
>  			.realbits = (bits),			\
> @@ -467,6 +472,60 @@ const struct ad5686_chip_info ad5679r_chip_info = {
>  };
>  EXPORT_SYMBOL_NS_GPL(ad5679r_chip_info, "IIO_AD5686");
>  
> +static void do_ad5686_trigger_handler(struct iio_dev *indio_dev)
> +{
> +	struct iio_buffer *buffer = indio_dev->buffer;

Only used once and doesn't save a line wrap, so no need for a local variable.

> +	struct ad5686_state *st = iio_priv(indio_dev);
> +	u16 val[AD5686_MAX_CHANNELS] = { };
> +	unsigned int scan_count, ch, i;
> +	bool async_update;
> +	u8 cmd;
> +
> +	if (iio_pop_from_buffer(buffer, val))
> +		return;
> +
> +	guard(mutex)(&st->lock);
> +
> +	scan_count = bitmap_weight(indio_dev->active_scan_mask,
> +				   iio_get_masklength(indio_dev));
> +	async_update = st->ldac_gpio && scan_count > 1;
> +	if (async_update) {
> +		/* use LDAC to update all channels simultaneously */
> +		cmd = AD5686_CMD_WRITE_INPUT_N;
> +		gpiod_set_value_cansleep(st->ldac_gpio, 0);
> +	} else {
> +		cmd = AD5686_CMD_WRITE_INPUT_N_UPDATE_N;
> +	}
> +
> +	i = 0;
> +	iio_for_each_active_channel(indio_dev, ch) {
> +		if (st->ops->write(st, cmd, indio_dev->channels[ch].address, val[i++]))
> +			break;
> +	}
> +
> +	/*
> +	 * If sync() is available, it is called here regardless of write
> +	 * failure to allow bus implementation to reset. In that case, partial
> +	 * writes are unlikely as the write operations would just queue up
> +	 * the transfers.
> +	 */
> +	if (st->ops->sync)
> +		st->ops->sync(st);
> +
> +	if (async_update)
> +		gpiod_set_value_cansleep(st->ldac_gpio, 1);
> +}
> +
