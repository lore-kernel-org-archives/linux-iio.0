Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B00D386571
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 21:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778361740; cv=none; b=kj1jju6M8Rll6dZ0q7l2LbT4GYd0Dkps9kHFt6KZgV83XjM/PIDdV6C7m1aBuUImh+zHI0yj/WbUsJz8dbYW333XwS1SiB6UmZzGw6um6csnn7k3umrIbbR41FxPAQbKA8w/VC0qZYiHl7xwSSUtqORuRHiqVgoIt4yaHkTchY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778361740; c=relaxed/simple;
	bh=xxKXojjZuZ8EA+mrvFSZyEAl7uuHiZwlg9zD2NgYMkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HQBCdky7p0PhA8JfsLICidTRICrCNjZJ505v3yUl7/750nl5VpvZGOXQlhixkAXCdNlef8ovmEkraj4UnLbjeJiYmvN03bUPeKTBUldIei+kO0zjzctsvz3odJevNPcm1IbXWM4J62NZAfmrPob+GlUn/3m9IWZw/kJXbMaszkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=Buchvfx8; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="Buchvfx8"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-662efd1bdd4so1758166eaf.0
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 14:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778361737; x=1778966537; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SJXKceU5ZhqPrIiFJjCPJBk20KBKY+Up01lGKB3v0/g=;
        b=Buchvfx8Y6F3bhKjTeN3LflL/1bULYsJ5wOQJnDbIfJyalLffwUwkRnMJQfytp92Gg
         yi9LOG1EZtxq/3k3U5qxc4L/mvBvDBFgfYtkqjtuI43mM2YQ3jmD95fXfPYak3vLsS9s
         P7GhqUaIQyvBjdW0NXRzT+pBlJGdt0EMFn5r8dpSr7EqA4YDfz4QGSCgPNbQVGiKX315
         hs4NhgpI9GnWdmxxgDGaL9CD03VRdlsSPsAAnerJDucsLv3xXcNso3okylao1N5bcPXC
         CFdlxL+M5iYoHme/G2lpPaWL7/4wlTSDk4vaDYNFNtMin8rGX0yEpxths73RlusTetoo
         hGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778361737; x=1778966537;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SJXKceU5ZhqPrIiFJjCPJBk20KBKY+Up01lGKB3v0/g=;
        b=NdGGhS7gTNxJBbcE3JQaKGllSu8OuDQtsUlpPQ8wDt9PUPBabsv84q6m1xlFjTNYZu
         6y03OyQnCMmD44cF/qfBSObI+g79zOzTDEksemZlyTGhrzBIPrHlMXh4mp0ZcBGtqD15
         tTRuWncr+rm27lOj3wSQ6Yx89yV0a9cpYQe3nvQ+i2zUxMUgKxIIAUUVn6msu6sNxbaE
         Aj17rx5v9zDHNFi9xD19C7iyHq31SO0vHaHZf8dySaZcGV/eDF8KqHTx62E8i7jrLtj/
         2XFv7RVx3QyUQu8wa/UYknXmHBalWAymJ7Y2EqXg6qkCXn6fXbtGdtTh/nXE6Qk/ZLLT
         /aIg==
X-Forwarded-Encrypted: i=1; AFNElJ/4wg8bQGmHeaFfaxnmZaS5smHZElAyZxPHn5ghrC4bbAu4OGkFAYObTCkotKIcyE6Dh/iIJjaiNnc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7ZIvwUHuASFaptWIuXpX5tAsKpE67vfMKHi44XNsk225EIq83
	NH7bW2qqIx7904y+tPBg+fnWkt3pXHw0SPB32pQaRO04epVs2d6gfBCG4Fc5HqgjqRo=
X-Gm-Gg: Acq92OH0uMtRyG+aQozz+lVypehMwEitWwa6VfguyzYb2wFPnlYHtvu2mr0GQncbVAu
	jCaSRPmF6Pd7Dwewdd7DqvXdnizu7JiVRCnRWsfBgtmiybt+1gJ+lMdC/qXEYBi/u3+cEkTulH6
	xnlnO0gJVYArmqZ/RIuIxh5Z7q2hw2QBHfb0cZLYTKZBvHFz7Fbdjfx0OSs2GmxKpvw0C+xbZAL
	OWGau/AbrnMYd5NuDIA12POQsotLqh874yXW89EMfLDWd8IPFDg/RxOyT/C1d+9pXa8j+bdw2NN
	miAMNc4q6zy/t+EEGsZ8SA1aMIKWIFA/9dqcJzdOEf/FQZBvv/8ny4u8sTsXfp7esJv75IL5hCa
	wAR5hhVrrFFQDEZJwZJf49MpaZ/CnQm0TQaybxTYuZ9tzlSI1HjEcFxMg3aNka7q5tCQMhlTlDT
	OsS21DZvdJU+znnM5bFmA8m3A7wrOxUIvUKU86jKWLHO+eIbwGpiRErq0WJbrqsqN18OGIS6+4y
	A==
X-Received: by 2002:a05:6820:290e:b0:696:1b18:18f3 with SMTP id 006d021491bc7-699ab661cb5mr6120843eaf.24.1778361737046;
        Sat, 09 May 2026 14:22:17 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3548:c22e:ea52:dbc7? ([2600:8803:e7e4:500:3548:c22e:ea52:dbc7])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69b25c75d08sm3260276eaf.4.2026.05.09.14.22.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2026 14:22:15 -0700 (PDT)
Message-ID: <f9c1a25b-456f-4ba9-b1c4-7958f2fd2aa8@baylibre.com>
Date: Sat, 9 May 2026 16:22:13 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: chemical: sps30: Replace manual locking with RAII
 locking
To: Maxwell Doose <m32285159@gmail.com>, tduszyns@gmail.com, jic23@kernel.org
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260509125201.29872-1-m32285159@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260509125201.29872-1-m32285159@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/26 7:52 AM, Maxwell Doose wrote:
> Replace manual mutex_lock() and mutex_unlock() calls with the much newer
> guard(mutex)() and scoped_guard() macros to enable RAII patterns,
> modernize the driver, and to increase readability.
> 
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> ---
>  drivers/iio/chemical/sps30.c | 60 +++++++++++++++++-------------------
>  1 file changed, 29 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
> index a934bf0298dd..186dec4cfd78 100644
> --- a/drivers/iio/chemical/sps30.c
> +++ b/drivers/iio/chemical/sps30.c
> @@ -5,6 +5,7 @@
>   * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
>   */
>  
> +#include <linux/cleanup.h>
>  #include <linux/crc8.h>
>  #include <linux/delay.h>
>  #include <linux/i2c.h>
> @@ -111,9 +112,9 @@ static irqreturn_t sps30_trigger_handler(int irq, void *p)
>  		aligned_s64 ts;
>  	} scan;
>  
> -	mutex_lock(&state->lock);
> -	ret = sps30_do_meas(state, scan.data, ARRAY_SIZE(scan.data));
> -	mutex_unlock(&state->lock);
> +	scoped_guard(mutex, &state->lock)
> +		ret = sps30_do_meas(state, scan.data, ARRAY_SIZE(scan.data));
> +
>  	if (ret)
>  		goto err;
>  
> @@ -136,23 +137,23 @@ static int sps30_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_PROCESSED:
>  		switch (chan->type) {
>  		case IIO_MASSCONCENTRATION:
> -			mutex_lock(&state->lock);
> -			/* read up to the number of bytes actually needed */
> -			switch (chan->channel2) {
> -			case IIO_MOD_PM1:
> -				ret = sps30_do_meas(state, data, 1);
> -				break;
> -			case IIO_MOD_PM2P5:
> -				ret = sps30_do_meas(state, data, 2);
> -				break;
> -			case IIO_MOD_PM4:
> -				ret = sps30_do_meas(state, data, 3);
> -				break;
> -			case IIO_MOD_PM10:
> -				ret = sps30_do_meas(state, data, 4);
> -				break;

We can do it like this:

  		case IIO_MASSCONCENTRATION: {
			guard(mutex)(&state->lock);

			/* read up to the number of bytes actually needed */
			switch (chan->channel2) {
			case IIO_MOD_PM1:
				ret = sps30_do_meas(state, data, 1);
				break;
			case IIO_MOD_PM2P5:
				ret = sps30_do_meas(state, data, 2);
				break;
			case IIO_MOD_PM4:
				ret = sps30_do_meas(state, data, 3);
				break;
			case IIO_MOD_PM10:
				ret = sps30_do_meas(state, data, 4);
				break;
			default:
				return -EINVAL;
			}
			if (ret)
				return ret;

		
			*val = data[chan->address] / 100;
			*val2 = (data[chan->address] % 100) * 10000;

			return IIO_VAL_INT_PLUS_MICRO;
		}
		default:
			return -EINVAL;

Make less indent and we don't have to initialize ret at the start of
the function anymore.

> +			scoped_guard(mutex, &state->lock) {
> +				/* read up to the number of bytes actually needed */
> +				switch (chan->channel2) {
> +				case IIO_MOD_PM1:
> +					ret = sps30_do_meas(state, data, 1);
> +					break;
> +				case IIO_MOD_PM2P5:
> +					ret = sps30_do_meas(state, data, 2);
> +					break;
> +				case IIO_MOD_PM4:
> +					ret = sps30_do_meas(state, data, 3);
> +					break;
> +				case IIO_MOD_PM10:
> +					ret = sps30_do_meas(state, data, 4);
> +					break;
> +				}
>  			}
> -			mutex_unlock(&state->lock);
>  			if (ret)
>  				return ret;
>  
> @@ -197,9 +198,9 @@ static ssize_t start_cleaning_store(struct device *dev,
>  	if (kstrtoint(buf, 0, &val) || val != 1)
>  		return -EINVAL;
>  
> -	mutex_lock(&state->lock);
> -	ret = state->ops->clean_fan(state);
> -	mutex_unlock(&state->lock);
> +	scoped_guard(mutex, &state->lock)

Doesn't need to be scoped. there is just return after this.

> +		ret = state->ops->clean_fan(state);
> +
>  	if (ret)
>  		return ret;
>  
> @@ -215,9 +216,9 @@ static ssize_t cleaning_period_show(struct device *dev,
>  	__be32 val;
>  	int ret;
>  
> -	mutex_lock(&state->lock);
> -	ret = state->ops->read_cleaning_period(state, &val);
> -	mutex_unlock(&state->lock);
> +	scoped_guard(mutex, &state->lock)
> +		ret = state->ops->read_cleaning_period(state, &val);
> +

IMHO, this one just make the code uglier, not really an improvement.

>  	if (ret)
>  		return ret;
>  
