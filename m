Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D720E29827E
	for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2026 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769612079; cv=none; b=NTiz+Z6U2BDT9AivyWklBZYzODWTZ/lk5hX6FkBG++v2aoNyGrIxntIp9Zz1BehPpnu7zUkkI8wwu8zppzQvuJiYWq7N1oWuQe6nYhJuWSTUmDN8hYMP42w19nB7KzkKs5VdaFQhvOVooQfCp+cI0aDHpX7fKsTR5WM6Fz5GWW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769612079; c=relaxed/simple;
	bh=jc9ranfakkTAVv9CLCKWcZD6dANoaE2NFONtCCEvW88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l2eX3N/UMQtlB8j0gijkIv/O/NWMmKOlkGULZKzK/hIxw3ReTBHWjmBZNkktQw/Hdcmoz4WPf2MAFq1EL4Md+RIQrH1bk3vh7gEMX7pNUXnsRyzws817vnzRIoNPqZGJgjhPQt7vqfMF1ZuBGk1l1rF7v2rUb0+d8HzZkbSUW5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UzmwiNxi; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UzmwiNxi"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-40946982a78so503239fac.2
        for <linux-iio@vger.kernel.org>; Wed, 28 Jan 2026 06:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769612075; x=1770216875; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oYtdG7Fy7XA+gCMCZdJyF3PQXuXW+OCHxSJlfNsLv2Q=;
        b=UzmwiNxiPmDcnd2FfZmWgEBbGHWzujwHwBC/478Mm30FiqUvRIHlaD/LpUWJtqQRnY
         2Wx9ZIqlk8SuiFClEeNoAdnhPfd+UsWuvmCu7AIb+2vqippiLu7LRW6ZLqIWeXWQ8qsa
         QMxu+RLspCEzjw5xtq6ZMbsOA8+rOX7ZqCTzvrmqADDglCQkzh9unfe93YfiT9hCDp8C
         O4v1GLCaHIhLLaIugj918GfyIvxw1kUvcjeyzZgI2L5dN3gSN2DnImMQU2DoHysipQWd
         KDlflbFqJZnmr/4clxywFCx45zZRuQrCcLZiAafj9Zon6L6p8RdVYK0mIPB24/7+u7bd
         OM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769612075; x=1770216875;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oYtdG7Fy7XA+gCMCZdJyF3PQXuXW+OCHxSJlfNsLv2Q=;
        b=EATIEuhpmaEaiAMtKOuKGvcpeJhW/hA45tEuwja/NWAjN+eL/vxhmPWucLMo5eG57K
         AvV2m72mbEXwqM6F5oKmD1oSaRlUVO9EvfzgskeXnew1nf6XhURAyjz1gXjwGDZlSSaS
         sGEQK+AVmo3NDL08n/uKoFazB21b7Au6WZAesaAdUFJH8MQLvBg+b0IbTK411vbf1uce
         DBJDpyuTJprbheIpna9DE+lLzlIWF9bcsTSe/iML5l256+ydSoIs4iSthmCN+OALDYC4
         sbhQ9XbRU4PodIzriqra4CcXT2dto/rsF3hpgBtgzx7Vv/SvXMym89+g4G1X06g9J3d2
         exow==
X-Forwarded-Encrypted: i=1; AJvYcCXTklwtJABH7tK0IwgkqzDcsAx7yCdxGOVCHagaVmJYFT3SH3YbTNoI8qkHfvI5o9iXwLMKAnMboV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPNLSbqp8NgOW3wXCDAy5h0winfoK2JKNrQOeldAt6GuG3DAoH
	FnLiBANotBWbT9t3FIZVF2kpuJysjhHj0W8MX2QKs1KwsJbyzedFDSUT75WUBA1Gxq4=
X-Gm-Gg: AZuq6aKSfCtZbrqRM/H/QMdMOHNQ381Ui45tmn4SuL6BxDmjbYL9fxABSHleFeQvTLj
	Ijge0tmEkW+iczxfNILINSYEhhgA7CA4C3dmArwC0JzxqhwmIIRCo7+jHGc2aakeMK4WmFiUHQf
	Kcm9Xpz6U6FJ3S19ZC2n0w/y2lV9/L6h0+JCZlpEsjS7LTZFvXhGD+Jp4VfUyxUX2/cODLXhxNU
	yuVzjnlBQSsLsYscZg7QRcfnhuzZXpjVFfaBaqU8XntPzmobuffUHmm6o2OvBOzUzY89K6zaPeY
	mVOdgMJvNtYG4ArTJWxyUGvs5rUgooVluCwad2zUID+Uhmmorj6wCuexCYbixThzuZM9YePiJxk
	PZvYOjhY6Hpem2wR/QhQs2qw1Acjq4b28Ep4MJGJOGzfhhuWj/R6AxvGGE+KFVS8BuYhdVycrDl
	s0YKQ+gQoq1NA+aX+d60YnSYirxlOWJzRkFZEqaUVRKEQiKdIkpmQD9JY=
X-Received: by 2002:a05:6870:2250:b0:3ec:5e47:8553 with SMTP id 586e51a60fabf-4093f6fa5a3mr3398699fac.0.1769612075503;
        Wed, 28 Jan 2026 06:54:35 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:375d:266:abd:feed? ([2600:8803:e7e4:500:375d:266:abd:feed])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-409575baf6dsm1824952fac.21.2026.01.28.06.54.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 06:54:35 -0800 (PST)
Message-ID: <beadc1df-050a-40ae-af7d-409b2f13f30e@baylibre.com>
Date: Wed, 28 Jan 2026 08:54:34 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: dac: ad5360: convert to guard(mutex)
To: Menderes Sabaz <sabazmenderes@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org
Cc: nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org
References: <20260128113751.258219-1-sabazmenderes@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260128113751.258219-1-sabazmenderes@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/28/26 5:37 AM, Menderes Sabaz wrote:
> Converting mutex_lock and mutex_unlock to guard(mutex)
> Simplify the locking logic by using guard(mutex).
> This removes the need for explicit unlock calls in error paths and
> simplifies the code by removing goto labels.
> 
> Signed-off-by: Menderes Sabaz <sabazmenderes@gmail.com>
> ---
>  drivers/iio/dac/ad5360.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5360.c b/drivers/iio/dac/ad5360.c
> index 8271849b1..a22bafa45 100644
> --- a/drivers/iio/dac/ad5360.c
> +++ b/drivers/iio/dac/ad5360.c
> @@ -209,10 +209,8 @@ static int ad5360_write(struct iio_dev *indio_dev, unsigned int cmd,
>  	int ret;
>  	struct ad5360_state *st = iio_priv(indio_dev);
>  
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
>  	ret = ad5360_write_unlocked(indio_dev, cmd, addr, val, shift);
> -	mutex_unlock(&st->lock);
> -
>  	return ret;
>  }
>  

All of the `return ret` can be removed now and function calls can return
directly. Otherwise, this isn't really an improvement. Same applies below.

> @@ -232,7 +230,7 @@ static int ad5360_read(struct iio_dev *indio_dev, unsigned int type,
>  		},
>  	};
>  
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
>  
>  	st->data[0].d32 = cpu_to_be32(AD5360_CMD(AD5360_CMD_SPECIAL_FUNCTION) |
>  		AD5360_ADDR(AD5360_REG_SF_READBACK) |
> @@ -243,8 +241,6 @@ static int ad5360_read(struct iio_dev *indio_dev, unsigned int type,
>  	if (ret >= 0)
>  		ret = be32_to_cpu(st->data[1].d32) & 0xffff;
>  
> -	mutex_unlock(&st->lock);
> -
>  	return ret;
>  }
>  
> @@ -264,7 +260,7 @@ static int ad5360_update_ctrl(struct iio_dev *indio_dev, unsigned int set,
>  	struct ad5360_state *st = iio_priv(indio_dev);
>  	int ret;
>  
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
>  
>  	st->ctrl |= set;
>  	st->ctrl &= ~clr;
> @@ -272,8 +268,6 @@ static int ad5360_update_ctrl(struct iio_dev *indio_dev, unsigned int set,
>  	ret = ad5360_write_unlocked(indio_dev, AD5360_CMD_SPECIAL_FUNCTION,
>  			AD5360_REG_SF_CTRL, st->ctrl, 0);
>  
> -	mutex_unlock(&st->lock);
> -
>  	return ret;
>  }
>  

