Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com [209.85.167.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C217D357A25
	for <linux-iio@vger.kernel.org>; Mon,  2 Feb 2026 23:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770073492; cv=none; b=CgHkI4Ontj46GoU2+jN2/DrzIVqICwjKPtXV8Epr3JAx6HaZ6WgK+FV0Yt7B8xyweTULAyhLFPefsmrHVVOHynWgdo7qEJw09+ipEDLFpZBRT9rGlyBoWRkV3hPZdj6z61lrLzV05sJs/cS+w/wmtqDp8jakKt6SWTu8fZCUv8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770073492; c=relaxed/simple;
	bh=RrYK91e1d4Hg5dQpXBUERxUtJltrtqPXxfWMgFQ1YVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UONmg+mGsbbtMKFFRC2lw/3ipbrBhCbMWa7nQuNbRWq6gbmz5FKhGCOq2QNK1XpDTtYb3sbyzki3HXwA53+xs3oeBM1us4/V3XiblXBVuXxEg9V4kteESJA+F08Yc6gA8lMvg1pSznyc2nsrsvvHLnLvvW7G/zUV5iRENg8o1CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=J1WoCkP4; arc=none smtp.client-ip=209.85.167.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="J1WoCkP4"
Received: by mail-oi1-f193.google.com with SMTP id 5614622812f47-45f18e8f2f5so3350341b6e.3
        for <linux-iio@vger.kernel.org>; Mon, 02 Feb 2026 15:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770073490; x=1770678290; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZNrvca2KmyrBJFwTPI4WrLSrUbTKwX2CYNCzHFOP/iM=;
        b=J1WoCkP4t8JauuH3cH6Xqj3jZ3tHFTxoI/xNcDIb0iTh+aKivoy22zcXuWWNLzX008
         Bd6A8/6fvTm+9v49UlEGdhRXkS4DMASYRuAIO7D6Cd8Xlt+oQIAX/fv6B6eXQL0qz6GY
         EYtn7eJCr3E9gmEf9x8LUJOZR8F86yeUZO053Zo7kv2pN/cJqtOVQovgrMUJZD3gmUdo
         ZXp8Hw4IKs2gz9VjCYlMFXW+GaXvM+M0aIQmEFoyxTFCntDpqzAdYaTEw5eWe1Aqnk5l
         ahzC854TyqOD9c0qTLSVCZcwoUqtXXmC+MnrsbdMk5v44yNmjqvEuS3SQHC276/o4NbI
         4Wfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770073490; x=1770678290;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZNrvca2KmyrBJFwTPI4WrLSrUbTKwX2CYNCzHFOP/iM=;
        b=Wx2Cfgfqa8P30f1yAQr6oLTj9sS3+2zZ4qI/KHHvAu76XN9URCn3NvZATgYwUF8RoI
         Bk9fAXXFKT908y73AScK1pX3G3YZC47bbbw4437yc5xUgRjMW2xo48uBPiHBplt91P71
         vvL7tl+uX3lR755yRjb8plIuvdv5PL9NtNhYVLBIggM3Oab7Ii104YdMqkg85Mgz7IAF
         hQbWoGESCnZ41X/WzciyK/Kwm2KzKwEPumNOwYb1kYjJ4V7RSviTSz4WasYbu6XDZa1w
         sbNy2e+DQjMzoeG1owXSpMrcSoi6S+MhThCBCBrMoweCnS6xdLgpjMynQ4z2gEL0uG5D
         y1SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWe+mUfjwVZ7ZRpMBlxkD9haqJ6lL7Igk09wxmMseR315rPWQXHmSqSbkhmf+srSy5KhKmhGvxBtWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWpGR+5nDqiwRlUpekapRk3Ra57uXaKrEETvUhQ2m1su48YBob
	nOXLdMYNQ3T4fsBEjEULTMemzgdQQMoZmogGrLfl+QTVa8Jr6wDRwcC5mQEiYDd8iFM=
X-Gm-Gg: AZuq6aL24Uxo7dXDYvbdjL96EuECYwyrCXsSoDI4aWvX/S3t/qLCNO61h+Shh17ohpP
	KtgEjh1K5UM2geoUOjjuAFGjW5ErO3HWbaNvO20UXPp+4YASjRsqKFciSsNkdXEKxQe3EPFgVBf
	XOGaeVeX1p1KcRTdVDQ4Gd+L8wLIULY7AbIAoDDvJsBAXG9//tcyTlDqVmP8nlpVsKxoX2ae+fe
	ynLUvEp4Xce0XhYQhOFNTNi5RMjAtYSm6XeGBpEdDsatabZ77Tu7MbnME1lXY1DOLGbgZnIgWik
	0AtZ08zuRzftrbWjQEwSjjzdgY1TyT84f6c1apdhVZXptmpwS0F0/jpbxYpVG+tKFOMjTeZ7tzO
	eNg19MMaJ+7k1R/oyFqXZ45GghmVh71Q1sj5JEORHR3QYyTnWMeXunC1uQ4mzJfawhsaka1i4bS
	5IkYMLggPvYh8aywwsVnVF1RNA9KYYF7WBWX9p2I8GGGij2k84nHtmAIjN63S3
X-Received: by 2002:a05:6808:c177:b0:450:bab2:4ae9 with SMTP id 5614622812f47-45f34cd634dmr6082161b6e.36.1770073489742;
        Mon, 02 Feb 2026 15:04:49 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:3695:6954:27c2:42ef? ([2600:8803:e7e4:500:3695:6954:27c2:42ef])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45f08fb82f5sm9957544b6e.22.2026.02.02.15.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 15:04:48 -0800 (PST)
Message-ID: <59105c6f-67b1-435c-aa08-5f440745b1b4@baylibre.com>
Date: Mon, 2 Feb 2026 17:04:48 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 next 3/5] iio: sca3000: stop interrupts via
 devm_add_action_or_reset()
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Andrew Ijano <andrew.ijano@gmail.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, error27@gmail.com,
 andriy.shevchenko@intel.com
References: <20260202194033.627967-1-harshit.m.mogalapalli@oracle.com>
 <20260202194033.627967-4-harshit.m.mogalapalli@oracle.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260202194033.627967-4-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/2/26 1:40 PM, Harshit Mogalapalli wrote:
> sca3000_stop_all_interrupts() is moved above the probe routine so the
> new function sca3000_disable_interrupts() used in probe can directly
> call it without additional declaration.
> 
> Used devm_add_action_or_reset() for shutting down the interrupts.
> 
> No functional change intended.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> v1->v2: Jonathan found a broken tear down sequence that was introduced
> by my ptach 3 in v1: https://lore.kernel.org/all/20260131163218.2a4b93e5@jic23-huawei/
> 
> So first converted the interrupt disabling task to devm based call,
> order of tear down is as follows after this patch: iio_unregister_device
> is called in the remove() callback, post which any interrupts will be
> disabled with devm_add_action_or_reset() call.
> ---
>  drivers/iio/accel/sca3000.c | 53 ++++++++++++++++++++++---------------
>  1 file changed, 31 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> index 37ef724d5dc5..4faffeea328c 100644
> --- a/drivers/iio/accel/sca3000.c
> +++ b/drivers/iio/accel/sca3000.c
> @@ -1437,6 +1437,33 @@ static const struct iio_info sca3000_info = {
>  	.write_event_config = &sca3000_write_event_config,
>  };
>  
> +static int sca3000_stop_all_interrupts(struct sca3000_state *st)

Return value is ignored now, so we can make this void and not return.

> +{
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +	ret = sca3000_read_data_short(st, SCA3000_REG_INT_MASK_ADDR, 1);
> +	if (ret)
> +		goto error_ret;
> +	ret = sca3000_write_reg(st, SCA3000_REG_INT_MASK_ADDR,
> +				(st->rx[0] &
> +				 ~(SCA3000_REG_INT_MASK_RING_THREE_QUARTER |
> +				   SCA3000_REG_INT_MASK_RING_HALF |
> +				   SCA3000_REG_INT_MASK_ALL_INTS)));
> +error_ret:
> +	mutex_unlock(&st->lock);
> +	return ret;
> +}
> +
> +static void sca3000_disable_interrupts(void *data)
> +{
> +	struct iio_dev *indio_dev = data;
> +	struct sca3000_state *st = iio_priv(indio_dev);
> +
> +	/* Must ensure no interrupts can be generated after this! */
> +	sca3000_stop_all_interrupts(st);
> +}

This wrapper doesn't seem necessary. We can combine to two functions
above into one.

