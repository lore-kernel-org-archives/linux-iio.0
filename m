Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2B641754
	for <linux-iio@vger.kernel.org>; Sat, 21 Feb 2026 17:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771694506; cv=none; b=EC6SrlCue47LCv4+0ZTgONMIyDLlbRnpmugvrUXCr8Ej3UJMNtEZWiQsn8PVsApoF/W8fGL6aYD9R26cAgm+WUf7TU4KEKR6cQN/zKCXodsFCKFsU7IiznGxJhCFwHDQ8xWUUT7i+a6UBOaucogCt7jykLVRkz63QtaYYUEkS+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771694506; c=relaxed/simple;
	bh=HX8Wjejxs9SblZXe1zexUK/AgCbHBl2YK9FZzjvdrF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YzdRjZozMuZQfTyZ5sIo460NjWi/jicnXPQn8Ocq3ApN4CapoGeKuSeZTih0YXp91vwkoQW+NejFkn8s9HH+fkBI+u6wD4QIeBo5UEJ9AmtC3ncnrtjvRSXa1XjKkcub43DNsz4lU6ANYX2A0gVAfyOVy5KM03ZYHi1mhd0JltA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1dMp0pvB; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1dMp0pvB"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-45f053b7b90so1979319b6e.0
        for <linux-iio@vger.kernel.org>; Sat, 21 Feb 2026 09:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771694504; x=1772299304; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FxXe4ilYefGxi3OGmxieGZpHIIMSFQ3LuTkepN5BPTs=;
        b=1dMp0pvBBcT72yRVmnDpVDdmkyvFOhFe9V4klVqf6d2mk+UUQAZhYDMcCTF21ebmpt
         z++ZqktLNWYodL72ZYcb914pgFJHgDZz0K08ucmQkxe0wTrhVtU+tEtHAENg1rgK4qtY
         x9fx4q52HQBGw+793fo8nkuduB9kCtJ67wIuVsSMdnAFWBc8+MqnTEgYKbNUvEO9TxYN
         KRrnG/bAWD09+P/4Nrr3QeMnmPV95Kl410bx7/KzeinLAPM5YDzPSg2othCqSfukGllm
         rDVPcLPs0ItrlmIItJqxA9BcCthufi+tmsmmJ8vOvTug8NyVfyhsB8UMha5zpSuJ1yTF
         5aEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771694504; x=1772299304;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FxXe4ilYefGxi3OGmxieGZpHIIMSFQ3LuTkepN5BPTs=;
        b=p0aCj2P0RwhAe4XtsTTfTP7TCqZbxxnB8GEdiAABK7vT85D+5MzuJkSCXDxfF41X4P
         Zoe2q593Yiei43p7EeGBhUmENy0QkaMW+u9RCm4QULcnRuQMzY4ba8MtY8G2/A0y+7Mt
         oC/jwH2EnbqRXR4sjHpKsOzBzY3/yx+ZnwEL65FchzjE9YkE7hH9PlRODLP5rVfqw5rG
         u4/aSACJ+AAI3ktyUSiBPtYZprX9LKt15ClxZGbFjjpcj3mv0YmyBGtGnfICyZG05kGU
         0mOKvBS6rvj2Ptk/1sP0OCtO1yLl+DnY/mdymjp7zDSieeNAc1zJZKqOXYg1cU4cksx1
         cznw==
X-Forwarded-Encrypted: i=1; AJvYcCUajvKyP6EiOk6I7MuI0otyj7gu0IJSvzFQGDgKoiCODy33l6Z/jzKx+8C3ZC63ZLzHQWbgez48ipM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF+NclybLIxUC4nYNjH7gTAI8R3zZR5knv0rbwB5qatN+mBMoI
	zC1auKful0s2+1ZhT/K8FU6nZnUWjIsvjCwdmUFE89uiwEFHYovCTAvGtcRa1YhjXrA=
X-Gm-Gg: AZuq6aKLk+txk7v9H8Z33McVyeS+4a4yK/zeOQGsq+gqBkZHiYX2q7XqsGo8jWx3anL
	U2szeM6DocxUbVTNnTsrjGQYPhPDGIwo8BJ9OmH4BMZp+0j3JPLSqCOD5PLzXADPxUjFQbMy7Q5
	7D1mq9KAx5GtDDmcCCaJZ6Fgf1vBWPuP77PpaYLyILsZOYW7GAiqfkxvcL7l4dFgYfSc+7Z0awo
	V2E7kerDF+33EipmOariKsb9fI0/SSp1HFmSmgcRaU7IrUL7WBPDcXeG384MriXSBIDnU+c1h3Z
	TrlQqIW+VWy8ZVlgg9Ei/6Mu2M2N5PYNxXTqmrQ2ZYhm67NipDMxeB1lBtvLpbExj3aQKlh+qvM
	ALgXi7PG9783e8bkdmWhFNmimFVm9H3efPZ8pS2wBhoMRQImXohEuisNKb15SFBg05FtBBEHrOX
	lrzmg/734D6/ZUB11Pf1RTE7PJNKb6OZ0eOxif8L/RB4r68Oqfj8T31CNjFJCwCIzOQl1jhQ==
X-Received: by 2002:a05:6808:23d1:b0:462:a915:31aa with SMTP id 5614622812f47-4644640b4c0mr2054950b6e.63.1771694503792;
        Sat, 21 Feb 2026 09:21:43 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:611:96af:f385:64bf? ([2600:8803:e7e4:500:611:96af:f385:64bf])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4644a012dc7sm1839578b6e.6.2026.02.21.09.21.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Feb 2026 09:21:43 -0800 (PST)
Message-ID: <6c8809a2-04fd-4044-a07e-8b74c964ead6@baylibre.com>
Date: Sat, 21 Feb 2026 11:21:42 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] iio: adc: ti-ads7950: do not clobber gpio state in
 ti_ads7950_get()
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20260219022929.3558081-1-dmitry.torokhov@gmail.com>
 <20260219022929.3558081-3-dmitry.torokhov@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260219022929.3558081-3-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/18/26 8:29 PM, Dmitry Torokhov wrote:
> GPIO state was inadvertently overwritten by the result of sip_sync,
> reuniting in ti_ads7950_get() only returning 0 as gpio state (or error).
> 
> Fix this by introducing a separate variable to hold the state.
> 
> Reported-by: David Lechner <dlechner@baylibre.com>

This should have a Fixes: tag since it is fixing a real bug.

Also, fixes should come first in the series.

> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/iio/adc/ti-ads7950.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
> index b8cc39fc39fb..2a7d4a1d9fa9 100644
> --- a/drivers/iio/adc/ti-ads7950.c
> +++ b/drivers/iio/adc/ti-ads7950.c
> @@ -427,13 +427,14 @@ static int ti_ads7950_set(struct gpio_chip *chip, unsigned int offset,
>  static int ti_ads7950_get(struct gpio_chip *chip, unsigned int offset)
>  {
>  	struct ti_ads7950_state *st = gpiochip_get_data(chip);
> -	int ret;
> +	int ret = 0;
> +	bool state;
>  
>  	mutex_lock(&st->slock);
>  
>  	/* If set as output, return the output */
>  	if (st->gpio_cmd_settings_bitmask & BIT(offset)) {
> -		ret = (st->cmd_settings_bitmask & BIT(offset)) ? 1 : 0;
> +		state = st->cmd_settings_bitmask & BIT(offset);

I agree it would be better to put...

		ret = 0;

here.

>  		goto out;
>  	}
>  
> @@ -444,7 +445,7 @@ static int ti_ads7950_get(struct gpio_chip *chip, unsigned int offset)
>  	if (ret)
>  		goto out;
>  
> -	ret = ((st->single_rx >> 12) & BIT(offset)) ? 1 : 0;
> +	state = (st->single_rx >> 12) & BIT(offset);
>  
>  	/* Revert back to original settings */
>  	st->cmd_settings_bitmask &= ~TI_ADS7950_CR_GPIO_DATA;
> @@ -456,7 +457,7 @@ static int ti_ads7950_get(struct gpio_chip *chip, unsigned int offset)
>  out:
>  	mutex_unlock(&st->slock);
>  
> -	return ret;
> +	return ret ?: state;>  }
>  
>  static int ti_ads7950_get_direction(struct gpio_chip *chip,

