Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A84030CDA6
	for <linux-iio@vger.kernel.org>; Thu, 29 Jan 2026 14:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769697513; cv=none; b=BfZkbgoNwfkhLOPtJ4SHVlof0LRes1lnLpQXWtp9ctzAMefCLZMdIkGnIzu0iEG4+lVeFB1vAGgu5FItsYAWFy/BJLDS3Y0R18NG9abgBN3QofN+ksKIIHzts/qlxHeDJ+pcZSZJvWE+XsVoswmlhE8vK3wXhtx+dJMFfZI/fF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769697513; c=relaxed/simple;
	bh=G7XQ1YC+dzkHSQrt/tD79gQPku8f09T2jva2xujm2VY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QoCg4gQPaUUT+nhnbiJE9PSGyY/xvJEnw2Ot7CRc1s+dl0Keps2cogMQfUCDWewuErIPllZdlSliQ2ow/bBwxod64bvo/+HMqLRo4FTw1nrXxrgELYuA7XgXsXxlKuHSFB8XV9+nhHj91wCqGyEJd0WFaS8/eu73wqMjnwgEplU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=emGS0MSY; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="emGS0MSY"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d18d02af68so609283a34.2
        for <linux-iio@vger.kernel.org>; Thu, 29 Jan 2026 06:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769697510; x=1770302310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V8aEj0HPo/Y+pc1fV1luyntUEbddFSOlsQMNoSjTbWU=;
        b=emGS0MSYJ8vHUSXUup4ISAw+bl2Shdf/EeiWZbdelC9Ptx0dsheWmCFjSIw1nGK2y8
         WupYf6roFbx9wI94GZ38vgY6qf7IQmhqdyvFCt4iQT459LXvDpIhR+IJkt8O8ClPDhHr
         HxVJz0/cjXifLKf+kUlUr57apKSoVcXTXysUMRvRT1ZOcH70OWeC2LSITcLr+xzjOPJK
         7oRQYa9gQyjHuw6d6qyEQbakQfBMzB9LJzdUxXjz7oUPPHR4rv1BD4yK5gp81OW7wub7
         wGEQ94tsMrqRk7or4o/qQ05c4VIqbJL28IW5V2rXwxl/bNE92XoRT7M8NXZKZ+bFHEzx
         aVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769697510; x=1770302310;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V8aEj0HPo/Y+pc1fV1luyntUEbddFSOlsQMNoSjTbWU=;
        b=BV25kwPPgAapK1O6tDHQyKOdEm/djh+ToFWWDHayJqg2p8OxPogeoDHRC0ix2Xcn2B
         CF/2kJNaTeqP+Snj4ecChIQVu4nE5A6H5DVJrQ3miAigTAdPGyZXMwzm79WFlbV6rA9z
         /y5sWy1aY2oRM2wR2UaVs18wn7o2L7k1q55CtfH/56A0ASLwURZrJxRogDHlsfc0usbC
         G77UBxvlZzoyylUNDJCvUDsaYcX1AP+o3wCsbHZp6h4IRa/e+CD2Xwk40cdRLezolHig
         rusFYxz1omrfmwNmf8Ebqy612Rq0limGc8+Wpm2jPjo+Maau5Drvbc6ORJXFuLRroOfg
         nqbw==
X-Forwarded-Encrypted: i=1; AJvYcCUv2zjFgwkiMiw7R0AoNtT+XaHONxPckLHMbFrHaYyVJc73zGmLBuUiY+Ie3xsbNpGbRZsb1SajP5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrUDBPIz2PReRXKEcyFBOdrE1HOxGeKM4ny9upLxuPKuBMPJj/
	XaHdBbK7uhsm36eDx4OKEfTIOkVkW3lAun6PxiY5nGI54RIQQSiFXMI1ViJqpGtv7TJPtAf/D14
	80iCn
X-Gm-Gg: AZuq6aK2xgglVENAC9cYxm4Zpre9oFCA0Fp9J+WY1bYeUslJsiR3NCMg2JJbP1p9f5r
	30U7RS2/P4qzJT4McgFPehMG84AGk1WFlX0ppFNKJbRuYxInOwenieMtY1mFwtyA86ez5Go2ezi
	EqipQbvqd8FgpbqGLyMJVNypKIGRNxxDEovKyonmy8CjFdWDYq54BShXNyqDokAOmkpC3hTG5Vc
	WhbLAFhN1XSoTswAIBkestSouFmwXk97IoK49nZhIwK2CYqfJRQJ59xw+1WNPSeQdW9RPRHQgcl
	dKnMrYen9RfiENYWWPCEbO+gzt9lbv8A3N+Yf/Wj43kEXGWyFgdLH6VYsFYDpTEF7A7edM+UOm6
	j8shAF3G7gJcle4AaroWgP2MFXmXLBrgXTOXZcEVJh4WsrvcO9cuFiKwg1oW6WoeyS8iO3mhk9v
	oi4TkdOuTA5T14XRpbK9Z9N70VqpFaHoTI+dLAfLDIcQlWMhRBWFIRi2HbZGW0
X-Received: by 2002:a05:6830:2b0b:b0:7c9:5ac6:12de with SMTP id 46e09a7af769-7d184fbd87bmr6294822a34.5.1769697509921;
        Thu, 29 Jan 2026 06:38:29 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:eca6:912e:45a4:4837? ([2600:8803:e7e4:500:eca6:912e:45a4:4837])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d18c67100fsm3829616a34.3.2026.01.29.06.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 06:38:29 -0800 (PST)
Message-ID: <17ea7d4b-e5aa-459b-8ae8-57343206c1f9@baylibre.com>
Date: Thu, 29 Jan 2026 08:38:28 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: dac: ad5360: converting to guard(mutex)
To: Menderes Sabaz <sabazmenderes@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org
Cc: andy@kernel.org, linux-iio@vger.kernel.org
References: <20260129113716.43479-1-sabazmenderes@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260129113716.43479-1-sabazmenderes@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I'm confused. Is this supposed to be v3 or v4?

See https://www.kernel.org/doc/html/latest/process/submitting-patches.html

On 1/29/26 5:37 AM, Menderes Sabaz wrote:
> Converting mutex_lock and mutex_unlock to guard(mutex)
> 

I gave my Reviewed-by: tag. It should have been picked up here
or an explanation given why it was not. (Also explained in the link
above.)

> Signed-off-by: Menderes Sabaz <sabazmenderes@gmail.com>
> ---

A changelog should go here on what was changed since the last
revision. (Also explained in the link above.)

>  drivers/iio/dac/ad5360.c | 29 +++++++++--------------------
>  1 file changed, 9 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5360.c b/drivers/iio/dac/ad5360.c
> index 8271849b1..5f51f0c12 100644
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
> -			AD5360_REG_SF_CTRL, st->ctrl, 0);
> -
> -	mutex_unlock(&st->lock);
> -
> -	return ret;
> +	return ad5360_write_unlocked(indio_dev, AD5360_CMD_SPECIAL_FUNCTION,
> +				 AD5360_REG_SF_CTRL, st->ctrl, 0);

Not sure the alignment is still quite right here. "indio_dev" and
"AD5360_REG_SF_CTRL" should be starting on the same column. Running
./scipts/checkpatch.pl should give a warning if they are not.

>  }
>  
>  static ssize_t ad5360_write_dac_powerdown(struct device *dev,

