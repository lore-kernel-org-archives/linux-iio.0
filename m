Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D8C36CDFA
	for <linux-iio@vger.kernel.org>; Sat, 31 Jan 2026 21:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769894398; cv=none; b=peNMmRAbMieLPk1aVPe9RzwCcMaV1X0zJrL0CRRAuryy1Qym3GugAWuPlF0t1qSQOodXJW7js/iyvsp8mz+QFdRRkqKVYl94P6Fqs1ypVUehPgQ5gP3x2g1B5/y5Hpq4Z0pdtKuBK9XBe3rgOwTZvygTmMrVPuPrpwDA+Swlj2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769894398; c=relaxed/simple;
	bh=poj6PE5KMZ/ErBJ2AjpBgqaRlabIT4vEYCpL9olBjqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RKiPOAi49juxnAy9LOGrhEDD6pa/wAyY3dOK4il/8dc/4sd/qjHOjWdzwwx2H2XX4uyEIleAxfhHSQnANOYA6/8Eoe2gtDyaHNmZz/VIVKMb6xkAYmy00pKhWJa1ldKivLSB5UAC8U3r7e1uYsrn2EBh4qC+Z9YuSPqVabhZxJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=APXX6qzo; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="APXX6qzo"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d1890f5cafso1127763a34.1
        for <linux-iio@vger.kernel.org>; Sat, 31 Jan 2026 13:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769894396; x=1770499196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zv8qyk+XnBBQd5VL0I95A+dxGWu5ApGoL74XEX3UOy8=;
        b=APXX6qzovNmviYTxtn/VtlpSMMfUSV6UjWxzclGMT7XYtX2Kgrk+V24H7180M0M1yf
         JOYdkhHsbD3Qs1bmpHNSf91yWouklfWNPAZCqa1nu4OJ3eKLjW5d88d5k5T/w+l7RZhv
         R2ka8DS+iFjhH5n0wbvYb03BK+TMAb6WI1FtB084n6SrwUIUY4lWdd+sR+SRljvTNHNA
         tlzxF9PZehrhNcKRtfE/U7IjZSqax9/HHcAjVaebr0cMRVzPTTsOa3Oe2YZXWXsVccZD
         LQQOLGxuHjTkHDsokVMk1L/uiSL70Szb3Ww5KOLzePnJ87RxJA2jdpxpCIYQ07lzwsDH
         uYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769894396; x=1770499196;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zv8qyk+XnBBQd5VL0I95A+dxGWu5ApGoL74XEX3UOy8=;
        b=Bu4elXlpuDNn3Y0D4MQpiEvpGWKAlFHD1shy2C1BfFngqvkdKXzFO/6hPJsakIsdJT
         QV5FvmIFQ0zC7fovTn8Tz0IZ8mMVju172befPoDHxg/o8KBYnPd/PaQzVQdkmh7wkm7u
         msqYayLcEoXQRWCFRg7NuKZoF4/IeykXgfs2K4RXZ2qvDOB2vUdXYAt7H/XS3ukyrL47
         jQG3s/iJ7rFZLxDGLub2ZpToj3310AYM9Izl4UlqP1weGYf9VTSyc5dIiAJySxPI4dG+
         yC/7A0tcUhMEhmLFHNleEwf7rLbuiw8f0WL2LEmMBiBTEQTEEYvtgRFiVRp6G/5iLN28
         qKXA==
X-Forwarded-Encrypted: i=1; AJvYcCU/p6nHgWgrCev5S/Eb5Trmr3BFEsG1oH5KyHPppyDIYE9BLiNm9Iw+HZWSVo6lqUMQt4FkbGxa4vU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEZLjleg9WQCyTqH9OtfJ5KulWpMFmRHugxvPAhhT30gha5L4e
	9uTdqFGbjutU/xNCS0XHVxWJeighTHeKT4i31ELL6yf4iCHU2UPreIf5n+ToU9y8Jaw=
X-Gm-Gg: AZuq6aL0lgKsZWLA+jX9K0peJzMvAJwyG3Iqg6cieENzJS00YziFSzxygEi9kN/Apmh
	Qj9junTvmfJhsaT5EIP7pdbP/0SyVZAFJHRazJT4dFAPnPaVEsofP+3zkm8CvOuUtesMfigzncb
	uaoz7iC10VCCgQ67VrY6UR2FRf52qXwEhOjJwGyJ0CBW9of8PRtkZaJHhw/Tp9M2zrjxrgiBQTe
	qyh2jptWov+qItMzBBeQaj30JBtoHguSkaC6Jkhok2JLrXUFdXe+JmWKt5sTbx4yCdoDfgIXtFv
	77DJY+owqRJiOsicbIaqYI9M9nKpXB84PE4zosGOyGJTxSl6C7xLCWrvz7lG+U+GhfGXUbCYww7
	kQWn6Uh4U9YYdjaMcrpAumuq1iVnfm3dlFvpZVNO4NBwafH5DcMpkzraS0l1eW5Ne0wDiB5egf2
	Ux54o0Oqfpw1DVHPiGigkgnjIh5ItSlHb9LaL1C/IJqBGnCwhclYiOEGrR/MK9
X-Received: by 2002:a05:6830:4984:b0:7d1:a028:4464 with SMTP id 46e09a7af769-7d1a534bf38mr3733443a34.36.1769894396196;
        Sat, 31 Jan 2026 13:19:56 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:c7ef:51f2:4f7a:6cd7? ([2600:8803:e7e4:500:c7ef:51f2:4f7a:6cd7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d18c6b9c8dsm8456703a34.13.2026.01.31.13.19.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jan 2026 13:19:55 -0800 (PST)
Message-ID: <9504cab4-8881-4f38-bacf-a7a4f52c3f1b@baylibre.com>
Date: Sat, 31 Jan 2026 15:19:55 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] iio: amplifiers: ad8366: consume enable gpio
To: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
References: <20260126-iio-ad8366-update-v2-0-c9a4d31aeb01@analog.com>
 <20260126-iio-ad8366-update-v2-5-c9a4d31aeb01@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260126-iio-ad8366-update-v2-5-c9a4d31aeb01@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/26/26 7:51 AM, Rodrigo Alencar via B4 Relay wrote:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Some parts may consume enable GPIO to enable serial mode
> (HMC1119's and HMC792A P/S pin) or powerup the device
> (e.g. ADA4961's PWUP pin).
> 
> Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  drivers/iio/amplifiers/ad8366.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
> index 134188db2e15..9ad6a628376c 100644
> --- a/drivers/iio/amplifiers/ad8366.c
> +++ b/drivers/iio/amplifiers/ad8366.c
> @@ -41,6 +41,7 @@ struct ad8366_state {
>  	struct spi_device	*spi;
>  	struct mutex            lock; /* protect sensor state */
>  	struct gpio_desc	*reset_gpio;
> +	struct gpio_desc	*enable_gpio;

This isn't needed since it is never used outside of the probe function.
It can be a local variable.

>  	unsigned char		ch[2];
>  	const struct ad8366_info *info;
>  	/*
> @@ -230,6 +231,11 @@ static int ad8366_probe(struct spi_device *spi)
>  		return dev_err_probe(dev, PTR_ERR(st->reset_gpio),
>  				     "Failed to get reset GPIO\n");
>  
> +	st->enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_HIGH);
> +	if (IS_ERR(st->enable_gpio))
> +		return dev_err_probe(dev, PTR_ERR(st->enable_gpio),
> +				     "Failed to get enable GPIO\n");
> +
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  	indio_dev->info = &ad8366_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> 

