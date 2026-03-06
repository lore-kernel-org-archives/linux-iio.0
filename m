Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B26E3FFAB4
	for <linux-iio@vger.kernel.org>; Fri,  6 Mar 2026 22:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772835011; cv=none; b=rKdx0Ar47nz0AmXHEeqT38Kdab6ZSUVmk/AOx1NG4XaK19JpALZaxKQ55bYsqutsXZAAQNmZLCLt4bus3JrBzAztM00J4MvRQ2SVhdRWP1JpFjVqAKhFHi7DHykmJ8nnPk+jGYOVak+jujiy3whTJqa8bCJAhDE5LgiVx67Otyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772835011; c=relaxed/simple;
	bh=4P/xm8FEu5eq/Y160CoyYXo2WJWicbC2FprXYR4M3dQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T+L1Oex0wr8fVXOfD0fdEOcgCeVM4P/rGf7KtSpkLHWedtERb+huw3jSIfiYZtti7X30svBqcd3kHMlSEhTyBAftJtNsUDqIRJrh5Q4uOwHcIKPlOctB+ajgt5oZDDHswBgVHiNtKNKKSiYz60rRWUdWRj2EUbtsyP/ybAV4dO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZIjSK9ec; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZIjSK9ec"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-40ee486a76eso3248661fac.2
        for <linux-iio@vger.kernel.org>; Fri, 06 Mar 2026 14:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772835008; x=1773439808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AETatfqfDS1XREX9cs1Ig1MjMauK60I6x4pBlhW5zqc=;
        b=ZIjSK9ecE1fkFwIGEBBFqeD9DnWInVPy9CvOlY3J4kGCSl7xHyBrQzzWZFcs2h/+kP
         W7QWy/PaMCVvdyRjS6G8ZFwxpuFGXbwbM772TtWVcwNHtetQwj2I045RPMjJ3o1xSUIM
         7MCdz4mBTOKow1EicRW3K3PqmPzfaafFIZQ+RXJNChUQa4BfT5kDSvKxDMDufb6RlgpY
         AbLmCfOafwqepUX8oO3rBBel1EQjOWEeAXUoAsfdrHI5dZB7IIGRDql1AjzD+ZDAB5En
         40YrOSl/GgX2eUmR/ExGE0UrE+1cokNv4BrTBZBdH1DzfT1rgb5GCGL+rRZZQ7WkTaAw
         viGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772835008; x=1773439808;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AETatfqfDS1XREX9cs1Ig1MjMauK60I6x4pBlhW5zqc=;
        b=ZrWKLcuN30oI4dB2+KSyPEZOQ3iKA9F2sQ66chN2Iv6wp9MMWU6Hv0DZvqcWVYFTz0
         so+TXP/WqPCjOOGgIthDdDZEgqihZ6hIuMuzjiaRAuw1UfMBBfUTwRNH4rLSBbVt+b6c
         0foQ93iMVyHy11IntBFg/2JtVsYb929pp82mdZnNiBD++6WsngPrFDldboJQXhIggTdO
         o3D0E1xTPi7ZiYOizJAy2xvPKoHrWnkdm2CAQvNFl2ycIgjBCOSmSEkPelsGtcRsQns1
         6zRE/tOrOv4bhj124l/6wv4q3HErMg4+ES7mHLaUIBNGOUsHibhr9F++zjqlUcJk/lpZ
         PraA==
X-Gm-Message-State: AOJu0YyHLva3EYuTMmB8SNbwCbqXJ+DODfB2m2HVFrDoZPZQMO0j1GhQ
	/y5PPd1wZS6ZeEKb66ZrPpFyHx/0QyXe3tbRUp3a6Hd6MclN6fMWaZ46VLPOoN7WiQo=
X-Gm-Gg: ATEYQzwbli8EFFltGpoBNq5h6AgLOpX7hxFxhhGAaQAYOgRS/+zcHU/Td3/gcznR4zO
	nawZbVsti/N9Cdui2lJImYgCQFBBZwReY0eJzi0iXa4Rnp0yrXVzBpv32FBbECpfk7LMuLZT3eN
	WwiSBvHdYXeadFUSTdCFWRovK9SGWJMaIbxG1x261oepFduI/NvUQPlPx+3KBF6+N/7ud7eTdf0
	5CEsY1N1sRWd57Wx+vuUxLHE5AUbHbEEUFc1bZeza/pNuU+slh6OV5NLrkJbSpCBAR2hMvucsa5
	wA6zD/9u2QzL4pbu2LXWsPsi9sY6IvAi5BKPN4tGF5o5vrFJhrup0aQoAMBK+P9K85GbVOZVH8e
	Clg4ld6vxD9zUFWMRx79ZreZGv9h42V6uTJ6GuSaOE/jJlJBqZ3zOrXGZEQFOrHg4QK5dJl8djo
	ObNtxLuvtKao2IskCwmkgbvgBM8lDrPzjJB/oRrcRcNxRUUtFAIm9YUv181IKLaIRyjgM5jG3qS
	Q==
X-Received: by 2002:a05:6870:810c:b0:3e8:8e56:6718 with SMTP id 586e51a60fabf-416e451e07dmr2320208fac.52.1772835008402;
        Fri, 06 Mar 2026 14:10:08 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:6d78:b98b:fc05:ddbe? ([2600:8803:e7e4:500:6d78:b98b:fc05:ddbe])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-416e68368a8sm2410513fac.14.2026.03.06.14.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 14:10:08 -0800 (PST)
Message-ID: <da67d80a-d6a7-46e2-a625-ce73ac167661@baylibre.com>
Date: Fri, 6 Mar 2026 16:10:07 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] iio: accel: adxl313: convert to guard(mutex)
To: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>,
 lucas.p.stankus@gmail.com, lars@metafoo.de, Michael.Hennerich@analog.com,
 jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org, puranjay@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <d587dd07-ce23-49f1-9a38-ea741e4ef14c@baylibre.com>
 <20260306211152.65109-1-rajveer.chaudhari.linux@gmail.com>
 <20260306211152.65109-2-rajveer.chaudhari.linux@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260306211152.65109-2-rajveer.chaudhari.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/26 3:11 PM, Rajveer Chaudhari wrote:
> ---
>  drivers/iio/accel/adxl313_core.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
> index 9f5d4d2cb325..94c6023af487 100644
> --- a/drivers/iio/accel/adxl313_core.c
> +++ b/drivers/iio/accel/adxl313_core.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #include <linux/bitfield.h>
> +#include <linux/cleanup.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/overflow.h>
> @@ -356,18 +357,16 @@ static int adxl313_read_axis(struct adxl313_data *data,
>  {
>  	int ret;
>  
> -	mutex_lock(&data->lock);
> +	guard(mutex)(&data->lock);
>  
>  	ret = regmap_bulk_read(data->regmap,
>  			       ADXL313_REG_DATA_AXIS(chan->address),
>  			       &data->transf_buf, sizeof(data->transf_buf));
>  	if (ret)
> -		goto unlock_ret;
> +		return ret;
>  
>  	ret = le16_to_cpu(data->transf_buf);

This can be simplifed:

	return le16_to_cpu(data->transf_buf);

>  
> -unlock_ret:
> -	mutex_unlock(&data->lock);
>  	return ret;
>  }
>  

