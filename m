Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF6A3EBF2D
	for <linux-iio@vger.kernel.org>; Wed,  4 Feb 2026 00:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770166189; cv=none; b=mjb1NT8UeX/Gk2gB7I6Cs4HGRkiQUbI43Y075qGyfAHaXuHq7GT1eFy4TWfr7IAuyAoqjTgJIgaBOQLdb5r3HAWAEUJqH5ATTREQVD+e6qZTdVe/FyqID16z5pnjB+nMyT5xbGP411tfDqnM5SAACoFqWEAan4fgFq+SJ2QV+wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770166189; c=relaxed/simple;
	bh=S5wqWJ/X9o7EGRxL5LCMmAmaRUc9szYlhY95kspTChI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WeOpT5fCcJg2Ov3hcNxLVWrwJD5Pr4kzEJgZkzokF32sPsg36E4oNyxaVPdBIzBKK5MMDl7vD/aHrcjZnWkiIpPAypq8PnlzgiRXoi0+h8s/s/IfPgoyoiQoB2WAzLm6cWYWg8eaYF8qVrITjgFnGzlOEpDDfvqBDxP7/DLy7lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ik5pRCAq; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ik5pRCAq"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-45efd53148eso2261398b6e.0
        for <linux-iio@vger.kernel.org>; Tue, 03 Feb 2026 16:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770166186; x=1770770986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hMsM9JKT9K8kSTqNUb7Y1F/oUVnPtGz0MMvS4d5Lupw=;
        b=Ik5pRCAqnJIoAtkNH4wQLIZyq6mnXY5ghF2AYhA8ZKZwhENukbhE171blQZ7eO1nZ/
         jxV9CRzTAwgrLMrSM18OUFY6EaPocl9Nr+bicCtuvJSblXewPW3+91VNnVEA4PWV9SSI
         Q3Dkw8QKW9tzdYvEV+gbTsGNT7TtSYqrkXAZD05038B+/Szd6u7BhG/MHb5nkvkx5aYW
         99/k4kbzN0ilty5fTh+N9bIdbruMTc8RuKWl0fNAyjJmiN5+hbLDhErIQ9veFsGYkptP
         rmY98xsq+jLx3hB200WY+DBOjmPbMlfkYXjwcW6PqrXSl9+dpbJY0AzmkgsiQzGKDSLV
         mQrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770166186; x=1770770986;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hMsM9JKT9K8kSTqNUb7Y1F/oUVnPtGz0MMvS4d5Lupw=;
        b=ulQr5tJebJELMjp2kdj/rD3GTNnquLthal621tyxpsYAFGLAquHHqIs1KRoZECsl+4
         qZVK2BtJumjdWW2t15c5loPGJHLYG0Xf0eS3mOciX+rgT9wI+QC/Dz5qwynrzvSKFsTJ
         rTPlpIKnQg4pcVuSv7yLiZ4CK9GZhMDmvzOcZZSOUf89NkEIxVeZ7OLOv5sP71Wwp2SH
         D0GIuze7+5PNAZuwo4cMbP+9pXWUgblRt+iFWfxBkqh4mIm9K6Oi6p4oTSxZcr60ySaE
         YKCpbA43sqz+nTvrk70Y74NTMl167Qbvr/KPjGgyyRrWJG0mPkymoXdq7clQyoa70ff8
         XoEw==
X-Forwarded-Encrypted: i=1; AJvYcCXSTA2V1WqIezqaK/RHlGSI4/RMyBzxHt8aFB1YnbaOiV7znjQLoVFNdnFD6Pxs3T2OBYBHtkBv6bg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOBAXdZ16X9Irw8y0hV0dbEEvTkcY2sUl2y+U8emEvDDN1OW4J
	p3zHopmiCw0mi3B+itIaeTj+3aEUQ06XZKtEDp4Bh3Wc6Qjj83t2ni/beH0edrDyMJR2e8xXMt7
	cIET4
X-Gm-Gg: AZuq6aIGOoW6kie5U8YAU6tqPX4wVKHJqgFtRW2O/CGPQmoL88KrDxmf8h53xAEAXkK
	PJd4oTIfLgrqCdvpi7eomADwf1EHFiQl3dMsoXNx6+5NXfKIjlb6qY2HTDGA7qBJR4nbGaBy0bZ
	YFzI55TxiO70xnnC6FsmGUbTWJr1W3yIdT8Etyhf2Ix2CfR9K2cFz5dU0b/LQiBppKNmApOE2FK
	zBbGTLhg7jr6SLPWoSTkyw8msCqTDnyTLmUYfWOfZnHA3Iq6HUwqd/9Av23y+GMKN1LVzATk521
	iFnXYjuhwe6KxkYv5nczzZe/Lq5sCZO56/aT/JmBY4KdO651VUas8ouVDQ9w8S7K7YuFwYh6qt3
	toOQv+FboT69p+TJJx0JbHQEEQg7P6pcGe+AbYQJ12diIGylBKRcxQuEFyoJNBBFfUCHOEuMtge
	P9QUGssaiYVdVsz3gmKteaZYpcihcTOV5URw9Bm0Gf2xaP1/MrmermmD4=
X-Received: by 2002:a05:6808:1b11:b0:44f:e912:ea97 with SMTP id 5614622812f47-462d58a27c3mr685412b6e.18.1770166186017;
        Tue, 03 Feb 2026 16:49:46 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:8e13:880:992:e796? ([2600:8803:e7e4:500:8e13:880:992:e796])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-462d6777405sm536198b6e.13.2026.02.03.16.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 16:49:45 -0800 (PST)
Message-ID: <04336665-1766-4d93-bbe9-9b99bba48e29@baylibre.com>
Date: Tue, 3 Feb 2026 18:49:44 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: magnetometer: bmc150_magn: Used guard() for mutex
 protection
To: Neel Bullywon <neelb2403@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260204000350.25454-1-neelb2403@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260204000350.25454-1-neelb2403@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/3/26 6:03 PM, Neel Bullywon wrote:
> Replaced the manual mutex lock/unlock calls using guard() to simplify
> the error handling and reduce goto statement usage.
> 
> By using RAII-style cleanup, it ensures the mutex is always released
> when exiting the function, regardless of the return path taken
> 
> This was compiled test only
> 
> Signed-off-by: Neel Bullywon <neelb2403@gmail.com>
> ---
>  drivers/iio/magnetometer/bmc150_magn.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
> index 6a73f6e2f1f0..73d9183a354b 100644
> --- a/drivers/iio/magnetometer/bmc150_magn.c
> +++ b/drivers/iio/magnetometer/bmc150_magn.c
> @@ -796,29 +796,22 @@ static int bmc150_magn_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  	struct bmc150_magn_data *data = iio_priv(indio_dev);
>  	int ret = 0;

We can take this a bit farther and drop the init here.

>  
> -	mutex_lock(&data->mutex);
> +	guard(mutex)(&data->mutex);
> +
>  	if (state == data->dready_trigger_on)
> -		goto err_unlock;
> +		return 0;
>  
>  	ret = regmap_update_bits(data->regmap, BMC150_MAGN_REG_INT_DRDY,
>  				 BMC150_MAGN_MASK_DRDY_EN,
>  				 state << BMC150_MAGN_SHIFT_DRDY_EN);
>  	if (ret < 0)
> -		goto err_unlock;
> +		return ret;
>  
>  	data->dready_trigger_on = state;
>  
> -	if (state) {
> +	if (state)
>  		ret = bmc150_magn_reset_intr(data);

return directly here

> -		if (ret < 0)
> -			goto err_unlock;
> -	}
> -	mutex_unlock(&data->mutex);
>  
> -	return 0;
> -
> -err_unlock:
> -	mutex_unlock(&data->mutex);
>  	return ret;

and return 0 here.

>  }
>  

