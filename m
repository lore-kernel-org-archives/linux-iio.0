Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD703B8BDA
	for <linux-iio@vger.kernel.org>; Sun,  2 Aug 2026 15:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785686080; cv=none; b=mPmDOCf42HrOk4pGv/iuU6ff3LN8l5R2/dk7scTOe+IR+3wrhNDyXRuvJuE6mvzbNtT6SDoBS93wj+n7BG35Xm+iWb/Hxn8JNuHu9+QkE2lpFLLkyiokKhAoC8mCAVlfqWxgFBa8mAsnsxFLsM4rhvbb4fLOS4mzC0jv+Xyi7gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785686080; c=relaxed/simple;
	bh=7vaMMXVmXCAjuwAXnYvuMWg3ywJvt1pzTpwRWGo/aM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=by4nJAk+BEgFcWOy9/LLTSSEY9SHAYDllbd7wJOwV+4ciexwUeIFC8AX4yBmID9s7TzTZUoUsIaLRsqSHlnaKGzV77OiX33gM/bcHZs+z4vK1tFy0FORET5W638Lp4Z9xMfM+I2e1PeyLGUEfG+Ap4i34Xg1eiVU43v7G8YwUyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=JuOpXwzr; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="JuOpXwzr"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7eb61bbeb25so1908716a34.1
        for <linux-iio@vger.kernel.org>; Sun, 02 Aug 2026 08:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785686077; x=1786290877; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4bQJiJeceLTVNfg1EzUzl1tupTNL+Y73lQoJQGnNquA=;
        b=JuOpXwzr1lR3jjgG7DtJr+WoefvEPwvWOPOTi+X5AFpz1ZaQLTR87ik8HUf3nynxW1
         DuZ9kv6L4vAveOwidzcJMgOH87WPaar+rZeOrOVHNCTi9QTfIm6ojB+gZV6e6+cj/iwO
         nj3of9SUWYPd3nZO2AtBCM5rfBdP1r6VGknN7e84F/vK5n3W19reg+fMd9u8EGvNkBG1
         JXyvlIQCcNAdJ2xhrUFuAi6NtvZDRkXB9GOb+3RL/a1FvUEREheGz8McWacTn/JoN8tF
         jIfV/UO6/t6b8EyUqDeiPyC4Y/Eop3RSMeaJMAynJ8NHgezgHoa2kLcru2e51fMtmyZI
         pOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785686077; x=1786290877;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4bQJiJeceLTVNfg1EzUzl1tupTNL+Y73lQoJQGnNquA=;
        b=Ithd5Z7kVIRjloiCAtNT1vrH8gd1In4i9R+KLJCQl3zXJpKa0it6l1mqLQrQ7O9uuU
         hPaaRBY3e+vmig/NO0OLgaC2vISWcmNwOXB9xtMxlhFY/bXdUPyPXaiKRqXvyDa9FLyl
         E5y39rsCM7uRMKVPZLmjfMrf3nf+uJ4X/YcOZAJ3p1NmShsujiGAiS6acO7eGnF1GFP0
         jKvZIlolrhYKIfwwuPSDEf91V5VUliz+30cuqmjum/lXxbhbkDkAB0CJ6aSatE8fMXwe
         nu5MuQ4omyGG/1N8AdHNN/2QUYJ0tieUlXnxm9xqTYvYN85SuiKZztPAu+YD6Mqfp00q
         fbFA==
X-Forwarded-Encrypted: i=1; AHgh+RoIHwCxb4+hX1PzFUY/+xfZUS5cBWr+GusZt1y2vTXz5jMuTZuQQsACNBRaheduiB1pNEdYrUMfD3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN5SKFRRuv3YFGU34v7nHp3SAeaJmf69rJflZf+aEq7zgWTyFB
	xBM2ql86htg1DEZZnoWPCBBW4naVipPL86E5zqZL3Csythy2wMkl9evy3kaeTAjUOe4KdGyHOJ0
	apcKUgJo=
X-Gm-Gg: AR+sD13bFtDFRyQWg4SbGPNzU9A2KGk4zT7fEVFngy/L4H2Ndbw3KfPGoKtdfx9S+kP
	A5r6nKwrUOpkEw5fTsSXQDYnNgQp3qY+1q6qu1jymbQq+woruDSRhFZhWj871Cfeazc9ZCx9a6G
	EUxMlbYNe/ERHvruQ+f0rUwgcyPz/uls3bBNS/CnxJsqlVLhirKLcIf1esWIZs9XqsKpFawlQhA
	sxIxlLD7maEBzU6aPwuO51crCTDT323eWlTljnjBYEnEjLM/h5ccxJXFYg3e4Z174Syk7hOMUaI
	JES3vxx17aOdAqKyewzE7W9AUHcPi5Hj+ssfJRkF462gQCjiMEDNepKFeF5K0JYpfASNJcI7QK5
	YqkKeYN/cMKBp5mDVxZITWw2ynMLgvaiiniuSg5G7B/VFyBp0d6MmuRUcAcj0LRIXUptuD3BAvd
	DFjZoRESZ+CjlhfOVrkTA+hjVJURwuZDMbLKGpvorn9OuxJDeDb50v+gxeJ347XgWt+DHn7IILM
	Jm+ZscOn3K6DHyytIkYFi8UUX1nwRc9OO8YEp0=
X-Received: by 2002:a05:6830:6ad4:b0:7e6:de36:3f35 with SMTP id 46e09a7af769-7f196d3eb48mr12089003a34.10.1785686076855;
        Sun, 02 Aug 2026 08:54:36 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:5487:2b6e:1057:d3d3? ([2600:8803:e7e4:500:5487:2b6e:1057:d3d3])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f18ed3e91bsm5270173a34.4.2026.08.02.08.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2026 08:54:35 -0700 (PDT)
Message-ID: <16d49ab4-fcb4-4ba5-8b91-03fde48de3f4@baylibre.com>
Date: Sun, 2 Aug 2026 10:54:35 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: gyro: mpu3050: fix sign of raw angular velocity
 readings
To: Cong Nguyen <congnt264@gmail.com>, Linus Walleij <linusw@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260802065540.8120-1-congnt264@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260802065540.8120-1-congnt264@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/2/26 1:55 AM, Cong Nguyen wrote:
> The MPU-3050 gyroscope output registers hold 16-bit two's complement
> values; the angular velocity channels are declared with .sign = 's'.
> When mpu3050_read_raw() handles IIO_CHAN_INFO_RAW it reads the register
> via a big-endian regmap_bulk_read() and assigns it with:
> 
> 	*val = be16_to_cpu(raw_val);
> 
> be16_to_cpu() yields an unsigned 16-bit quantity, so negative rates
> (bit 15 set) are reported to userspace as large positive integers
> (e.g. -1 becomes 65535) instead of the correct negative value.
> 
> Cast to s16 before the assignment, matching the temperature channel a
> few lines above which already handles the sign correctly.
> 
> Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4
> Signed-off-by: Cong Nguyen <congnt264@gmail.com>
> ---
>  drivers/iio/gyro/mpu3050-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
> index d84e04e4b431..07c0f9011c63 100644
> --- a/drivers/iio/gyro/mpu3050-core.c
> +++ b/drivers/iio/gyro/mpu3050-core.c
> @@ -356,7 +356,7 @@ static int mpu3050_read_raw(struct iio_dev *indio_dev,
>  				goto out_read_raw_unlock;
>  			}
>  
> -			*val = be16_to_cpu(raw_val);
> +			*val = (s16)be16_to_cpu(raw_val);
>  			ret = IIO_VAL_INT;
>  
>  			goto out_read_raw_unlock;

Usually, we use sign_extend32() instead of a cast for this. But this
driver already has a similar cast for the temperature channel. So to
keep it consistent, this looks fine.

Reviewed-by: David Lechner <dlechner@baylibre.com>


