Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55056175A68
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 20:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778358985; cv=none; b=bNuwoukcK20G07GYcx3aArF+YTrCDV/JBqUE1SzXn1ByttJQVZpPobMVdXLf9cmvyYpyMA0hCmMjSxhss1+KdwDBzdLWZ9u23c6aagP7s4WSJI3jHU+2HtlXU0+X7tY4QMexgroxGqQVtGmq9lKbkNtdNNTwFAd9JK0tURFBq9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778358985; c=relaxed/simple;
	bh=ru8gswPVqF854e1txROCwOPRtjAw7vn2o1CiX7HF/2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ul/rZUMkecMlNoh/M92kLKxhDhN8EGxAGuy8lnpvuKJ7zi2+trXQ6QPbibAMPcNp/6LO3eJ0lZvxIGgTeBTFHR4tkyAvsk8z5DjC4YgvF6FHKheH5xwQHjEyg/4yQ8BtJLdAPg14XTIb7SskyMtgosWc8VpTKrs/dz59hA3RRjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=iglS1h4a; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="iglS1h4a"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-479d593a0c3so2647980b6e.0
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 13:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778358981; x=1778963781; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9NaYOqLCDY9EhKSj/IW3wkEptD9YkMkdn1A5CmapRck=;
        b=iglS1h4a+/T19eLXDZlL2E6mVND2EnUzXag+n1rKrdy5jYhzGsV3uTzGCEy0IchkXn
         J66JFoK9pyE6ZP06Mif9iQL6kBdS0EloWLcpvYVXO9UbLFvmb8wlDyEvqqq0yEYC+gHz
         X1LbFwrlyK85sVQ+jGd1AMZddzxk2QBWcCM7wWDLS82osB7irwhWbx4uz7wVgQEAiov9
         j2hDMYbWgDqn52BdRNOEAbmV/s8SFXl1EkBmlhgtXJyiDHpDUsHPXCJfEPLQiy528l47
         kF0JNVgOA7P78+JWZx3qcqUxIzj1ywTLd9CUZ3CxFIzcpiDR3lJBCZvQUjT4c16GphBV
         U+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778358981; x=1778963781;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9NaYOqLCDY9EhKSj/IW3wkEptD9YkMkdn1A5CmapRck=;
        b=WATHwgcN3HWg9TRX2rIwt0zgpY+G6jiNcepvBx63+7/zzb26RUMpL6J0eZxa+3ULK4
         JjS6sy1LFmzRRL0JOz6NTarI3U/SEOjfGeyU3OGbRCObHhKs2WjVAFqGrSQq2xmufGav
         jq5Ybm41Ge/g3tHFUF5kV0wxeqJrG5Is8/22UvO1fG3VNTQ4NALWinLmlFVW5RWOZonX
         J5N2myes7n6NBlO5z4ywro4sR1ijjlWIOQ8mHhqrwFieD7rXKReBz59TrztaV6Xol8tu
         A1dFfml+PQWpiKSOOQk7BICr2tXwQZ5TvJyYGxo1ORtb/WEX09Ou4FVyQz0Qezvn9zmR
         8DLw==
X-Forwarded-Encrypted: i=1; AFNElJ+gAGxLPyeBpN7cGFDsLy7ajaeEgqfQhTp2UjQRzq2FWxViCpsutLgTtDHfLYRjk80bLFbvt93ljKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfWvdF34oyqMmwd6n9guH6sAPpTNFLHwCiNYWoVU5ImZgn4FNv
	Yx2vnJAGPhY/y3LndkiV1uqeH6OALBVG2bd9sMYUxF3WZ5X0LJsM/VH271eJaiCSWPI=
X-Gm-Gg: Acq92OEAlKlfXijPbYsbJRxdPMjjHovxDvDgvFZEH9hqfe41seXXUfMm+J2RNS+qmpi
	G97Ygzk778VNSRHnxHBykrYIAUcXVrwYzWEjPk4UXhd6+qYAMAHJU2kS7ebVg0LQPHTFnrUGYOx
	tzIV27DD8IqAQNHK32XpIkXObscGfgx55ofW34x7NhnTQCVKrcoG88BJ77WvMvMCl0v8dWIXIG7
	OEXNFA1k+ygb6Ve0FieL/1kv13eaD24cNFtz1KBAVz1WoA7c4ZdV5B5PZXOkBbJjnQMI7DsW+S6
	bCVAqisMcLgIKxYZmQMXPTH1gb+RK3b3U7JC7XGr3Hlpxxzw0NVjk1oUgYzxksZPklvummruVBC
	StefAphYpdx7rgLGbP4j9ePeBEBuMT1bKnHvQbDH5kIG4N06Jv/hdncVtMBvUKuW5lj0HXrcALU
	jGkxP0XIb142A4sW7uuARHImhdDm2tUQFXgj0kxAyDO84qPtNsVM2DEBKnmz+amZf3tTC4o8Hir
	Q==
X-Received: by 2002:a05:6808:5087:b0:453:58dc:c006 with SMTP id 5614622812f47-48061aa68afmr6136098b6e.3.1778358981276;
        Sat, 09 May 2026 13:36:21 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3548:c22e:ea52:dbc7? ([2600:8803:e7e4:500:3548:c22e:ea52:dbc7])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c76935637sm17105945b6e.12.2026.05.09.13.36.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2026 13:36:19 -0700 (PDT)
Message-ID: <7ff89e1f-f5ef-461c-83af-18360ad5dab0@baylibre.com>
Date: Sat, 9 May 2026 15:36:19 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] iio: adc: ti-ads1298: Remove unnecessary CONFIG2
 write during init
To: Md Shofiqul Islam <shofiqtest@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, mike.looijmans@topic.nl, nuno.sa@analog.com,
 andy@kernel.org, andriy.shevchenko@intel.com
References: <20260509151959.3475-1-shofiqtest@gmail.com>
 <20260509151959.3475-4-shofiqtest@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260509151959.3475-4-shofiqtest@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/9/26 10:19 AM, Md Shofiqul Islam wrote:
> The driver was enabling the internal test signal (INT_TEST), double
> amplitude (TEST_AMP), and fast frequency (TEST_FREQ_FAST) bits in
> CONFIG2 during initialization. These bits activate an internal square
> wave generator intended for device testing and calibration, not normal
> ECG operation.
> 
> CONFIG2 defaults to having only the RESERVED bit set after reset, which
> is the correct value for normal operation. Remove the write entirely
> since it would just be writing the reset default value.
> 
> Suggested-by: Mike Looijmans <mike.looijmans@topic.nl>
> Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
> ---
>  drivers/iio/adc/ti-ads1298.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
> index 186bda3087..8957e873e1 100644
> --- a/drivers/iio/adc/ti-ads1298.c
> +++ b/drivers/iio/adc/ti-ads1298.c
> @@ -615,15 +615,6 @@ static int ads1298_init(struct iio_dev *indio_dev)
>  	if (!indio_dev->name)
>  		return -ENOMEM;
>  
> -	/* Enable internal test signal, double amplitude, double frequency */

This is why comments should say why and not what. If the original author
had a plan for this, we don't know what it was.

I look at the datasheet and the driver. Seems OK since the test signals
aren't used anywhere in the driver right now. 

> -	ret = regmap_write(priv->regmap, ADS1298_REG_CONFIG2,
> -			   ADS1298_MASK_CONFIG2_RESERVED |
> -			   ADS1298_MASK_CONFIG2_INT_TEST |
> -			   ADS1298_MASK_CONFIG2_TEST_AMP |
> -			   ADS1298_MASK_CONFIG2_TEST_FREQ_FAST);
> -	if (ret)
> -		return ret;
> -
>  	val = ADS1298_MASK_CONFIG3_RESERVED; /* Must write 1 always */
>  	if (!priv->reg_vref) {
>  		/* Enable internal reference */

