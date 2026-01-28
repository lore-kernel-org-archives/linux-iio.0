Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D5421D3C5
	for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2026 22:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769640432; cv=none; b=c3gTOCBfWaZVV9WuoEJNBa3XgW7VZ91EX7w1wCq9hTR4ABcnb+25g82DrOvEaK8q+nGXkFfTsm8pJ1eQZc9lfc+Nyk3oqU9cGv6s+oEOfxhyIevk2NHfdMMBrGPGWArqbJ6f581TTbucpNpN8BGOyf1cOtKtt7Gr4RYNUKQusc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769640432; c=relaxed/simple;
	bh=sQ+YeXuVASjSng413cnbJRGMXpnhurgGjpVHPDLadqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tfJsTU3BHm3sUlHQ5xsqFZKEbyjvUFg1AR5xsXJIjj4pu84CRHMEOwUz2AthNwlUC+nws5L7VCsD4pFiiiyfzW8q+oMfmN2zl3gjkqIDIDgl6twpSLFX0EUg8X0D9fsJGhK5oPwgDZrrM52TqnZoBi//36C0dOmHl/AGNQFMbwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2ZW69TN4; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2ZW69TN4"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-45c8b850f96so267463b6e.0
        for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2026 14:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769640429; x=1770245229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uUNYd1YODdFvOduu+eDABGvq5fA8TgWLW9jR+0Y8swY=;
        b=2ZW69TN4H2OXezCBF092ufQ+aEk4GL1TB2nnOMDjWCRz04LLPJg8MjI1c2LzHqtNrN
         QZzwQVBwuh4WToYH8JTKq13FGr+v4EOzDgysuc3y+37pi7mEZvM8bUCLP11Ip0yTjeQY
         Ly3MR41Pqq3PYyuxubik7zSGG4BHyivxejyUf3ipxrcObX6zIo4s7nV6C0tyFe/pIz4O
         qzsp/u3oEYlBfpPj1GsXKdraKz5RsDzkwGDQ/U00ntp7Xd3eMP+xNgS4rmFTwJFMp7qy
         N70vvBcwKBD4PKxKzY9qPmyT/Z8HjACdCX4EzUCa4zg/AN4iRXUMbCM/zdBNQMiZ+udR
         fgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769640429; x=1770245229;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uUNYd1YODdFvOduu+eDABGvq5fA8TgWLW9jR+0Y8swY=;
        b=DyrpeLhBFOy0TU+hM+P8u9zck8u5HB8WPzXu/d71tp1vI2a4W3hI30dnzofJA42wgM
         COzpgqNlhZ4GABXMyF0kXkqUo6mVLTyOp1UHG5u7bRn461jBh6CTM0QvLK19YlMFtBuq
         YodgBXVAtmlEOHlrCE2l+/OCccCmlFkGRJQaoGOeK7ErSXlMPppwGSKAHlWi9qB4iHNt
         VFgwc8Yg92EL6OjLI8v5CBPf3kRcT94RODaL7xGlEVFYRa/BjDchC83pojpRadE4AnNf
         spq+pb9TbtQRaddNuR6LcSXmTSaeNUw8zAh4nlPWIoUJ1U3OmUGi2/r9+0ZI8vD5wnMD
         9k3w==
X-Forwarded-Encrypted: i=1; AJvYcCVRZJVG/oLaRkHTWKbD38s9ZV7k9q7l2iWRtPkgTp3GAtmmCeA7Hrs/76XZ+sUgak3XEsKKDI6pNfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZJj2pWznMaTAXTU/tcCATMnARy2M0/LvkHDx8MCBF0xghyRWA
	ngGPljG27rlh9xLPQJnKvDj9IXHGVeQnoPgSe5N//rW7f20+undAXgdf+b/32YxnLVE=
X-Gm-Gg: AZuq6aJfb/y6e4oanWRqiD0TdmN5cELwN0ER/ANQ97qvwjHypMwHVbW2VbHSCrufRy3
	C/DnodQ2PX5wllG0f8EV8dZ3EYWHI2tvv36XTDFVvPLCgLevXZDbrNhiz/na4dYlWOQ3JYeMiRz
	PlC2rj/bm1GsF8wsSqybdegmF2Jt3cjwO5rFDHutcYzMMjXa7utWpaSjvhD6ppWPSYiQ2BII4xU
	zDICZhRjMOINQmXdv0rp7til4L99wATC2D3nTF7boeFz57kRp6DxAZ6sQzgPxkbhm+DCXldg2li
	F3uujRqt/ADkqJg+Exdjav7XAr7r8qW0VYz/HvIoOigOHA0zSDbvcumYKDpVO4aAOr5yXAU3Ar5
	lIEK2vyIs7NUpNSNISGwwYeXtFKxMpgvC1NkO9ibcvUorGOtlu+c0Wiil7TnWsjC+XiGe6jfsVK
	rzDqKbqXhpeIsMz0soP+xJWNlFgHhY1K1lI82c3MZ8riYHUoGYClyazT0=
X-Received: by 2002:a05:6808:13d5:b0:455:daf0:9998 with SMTP id 5614622812f47-45efc6a7212mr4147810b6e.41.1769640428708;
        Wed, 28 Jan 2026 14:47:08 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:375d:266:abd:feed? ([2600:8803:e7e4:500:375d:266:abd:feed])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4095716e7f9sm2834503fac.6.2026.01.28.14.47.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 14:47:07 -0800 (PST)
Message-ID: <61fdf5ed-5cb0-4030-b956-1eedfd678e82@baylibre.com>
Date: Wed, 28 Jan 2026 16:47:06 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: dac: ad5360: convert to guard(mutex)
To: Menderes Sabaz <sabazmenderes@gmail.com>
Cc: Michael.Hennerich@analog.com, andy@kernel.org, jic23@kernel.org,
 lars@metafoo.de, linux-iio@vger.kernel.org, nuno.sa@analog.com
References: <20260128113751.258219-1-sabazmenderes@gmail.com>
 <20260128153221.327987-1-sabazmenderes@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260128153221.327987-1-sabazmenderes@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/28/26 9:32 AM, Menderes Sabaz wrote:
> Converting mutex_lock and mutex_unlock to guard(mutex)

Usually we phrase this as "Covert" instead of "Converting".
And should have period at end of sentence.

> Simplify the locking logic by using guard(mutex).

This sentence is a bit redundant.

> This removes the need for explicit unlock calls in error paths and
> simplifies the code by removing goto labels.

Can leave out this sentence since it doesn't apply to this patch
(e.g. no gotos were removed).

> 
> Signed-off-by: Menderes Sabaz <sabazmenderes@gmail.com>
> ---
> Changes in v2:
> - Removed unnecessary local variables
>  drivers/iio/dac/ad5360.c | 27 ++++++++-------------------
>  1 file changed, 8 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5360.c b/drivers/iio/dac/ad5360.c
> index 8271849b1..15df5dd2a 100644
> --- a/drivers/iio/dac/ad5360.c
> +++ b/drivers/iio/dac/ad5360.c
> @@ -206,14 +206,10 @@ static int ad5360_write_unlocked(struct iio_dev *indio_dev,
>  static int ad5360_write(struct iio_dev *indio_dev, unsigned int cmd,
>  	unsigned int addr, unsigned int val, unsigned int shift)
>  {
> -	int ret;
>  	struct ad5360_state *st = iio_priv(indio_dev);
>  
> -	mutex_lock(&st->lock);
> -	ret = ad5360_write_unlocked(indio_dev, cmd, addr, val, shift);
> -	mutex_unlock(&st->lock);
> -
> -	return ret;
> +	guard(mutex)(&st->lock);
> +	return ad5360_write_unlocked(indio_dev, cmd, addr, val, shift);
>  }
>  
>  static int ad5360_read(struct iio_dev *indio_dev, unsigned int type,
> @@ -232,7 +228,7 @@ static int ad5360_read(struct iio_dev *indio_dev, unsigned int type,
>  		},
>  	};
>  
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
>  
>  	st->data[0].d32 = cpu_to_be32(AD5360_CMD(AD5360_CMD_SPECIAL_FUNCTION) |
>  		AD5360_ADDR(AD5360_REG_SF_READBACK) |
> @@ -240,12 +236,10 @@ static int ad5360_read(struct iio_dev *indio_dev, unsigned int type,
>  		AD5360_READBACK_ADDR(addr));
>  
>  	ret = spi_sync_transfer(st->spi, t, ARRAY_SIZE(t));
> -	if (ret >= 0)
> -		ret = be32_to_cpu(st->data[1].d32) & 0xffff;
> -
> -	mutex_unlock(&st->lock);
> +	if (ret < 0)
> +		return ret;
>  
> -	return ret;
> +	return be32_to_cpu(st->data[1].d32) & 0xffff;
>  }
>  
>  static ssize_t ad5360_read_dac_powerdown(struct device *dev,
> @@ -262,19 +256,14 @@ static int ad5360_update_ctrl(struct iio_dev *indio_dev, unsigned int set,
>  	unsigned int clr)
>  {
>  	struct ad5360_state *st = iio_priv(indio_dev);
> -	int ret;
>  
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
>  
>  	st->ctrl |= set;
>  	st->ctrl &= ~clr;
>  
> -	ret = ad5360_write_unlocked(indio_dev, AD5360_CMD_SPECIAL_FUNCTION,
> +	return ad5360_write_unlocked(indio_dev, AD5360_CMD_SPECIAL_FUNCTION,
>  			AD5360_REG_SF_CTRL, st->ctrl, 0);
> -
> -	mutex_unlock(&st->lock);
> -
> -	return ret;
>  }
>  
>  static ssize_t ad5360_write_dac_powerdown(struct device *dev,

Patch looks better now.

With a bit more tidying (commit message and alignment that Andy
pointed out):

Reviewed-by: David Lechner <dlechner@baylibre.com>


