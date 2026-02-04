Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DA6423143
	for <linux-iio@vger.kernel.org>; Wed,  4 Feb 2026 18:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770228959; cv=none; b=Tarf4T2TUk+BBr1AdDKELzy+MYWoepUH0hWAe7iv8yZ6ZqwmhAwy5Wx97gyJQXKoCwpD6LnYSCHSEB1qNrfhgKd2TBPKDywXsXa8pJ3XLy91s3UOoD8DAfws0DsQ+OgSMMNZs5MMfpZy7ezm93kzeemupW/vqpcQmS4a5Uja7wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770228959; c=relaxed/simple;
	bh=kv/sg/f9nbMhZFTewiOB9ZZ3yXQB2I8tUUf9Pxb6kxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RG/kvbcdtUNStif6Pp6y/eautqdwGP/HYSv4UnoNlyrwP+R7E/rPrWSgp9dWeoyAKBxVEhk4pIb1iI9h1DtW4+bYsEDUqvGltPXV4b0p1CM4qBqMKoojHc7CW6ignHt68ihFAdJJh7S2bf/SH9ptBcVwtc4z+eECMRdTzN2EPY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmeISdMu; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmeISdMu"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c648bc907ebso4489670a12.3
        for <linux-iio@vger.kernel.org>; Wed, 04 Feb 2026 10:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770228958; x=1770833758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=jOVQ+nPE416W0DPiahH1jzaA8OHm3OMY6p/VFvnPU/s=;
        b=hmeISdMua2s6SQy1BP7/qEG5bsBVf6fkPrY6tUuk43fTICIfuH25faoy/thY6/0YXa
         vedn2X2JhJGXYzRu5jHV7b4GG2UAdpbyC7/rSE4KjYSQ66ZJ9LSYRM8u8VZTYErYELYk
         gfEGUE13taFelpeFgMa9iX+u1IKMrnXl06ld+UK9SJ/JQflfnKTIXld5AMxqZGJm4iDc
         Hrn3Av5tLak6Dn0c98IM/t0bifyyXvfL/LLoRCSfwMiO28VctHchslHEJ4q3moshCuXQ
         QfH/5/V/OpUZX6tQ3pjK8C2KMgjW/nCMaA/LXu3y/t3GVaMkURDFudBbcX/9GKCF9qBn
         O3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770228958; x=1770833758;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOVQ+nPE416W0DPiahH1jzaA8OHm3OMY6p/VFvnPU/s=;
        b=Wzw17Ls7iehFLpdBMCtNHp9VNlrYd3YKyTX33cxRv0mu0iN+dRGX550TktiNSITSII
         Q96tszrcjkFxJmx+nr0gdM2XtTFm+vpgKy7El+5USCu9vLWJp5DoxliY/oSyOphtNNce
         Ar843EYov5LCEv/cdGk0tCEuzqpSouaICyME8oPa25EWoTZxWJv5/G5/WOxQHGx659jL
         ASRLLpl/0CPeiWMIk+D8rI6hGctwf4u8VzaBw5+6XP3Je1cENbLKIatePtOcDwOG0JFH
         kBIhxZLZKGP0QUiDYtdJhX5YdYRWtvok93hRQtXjCbTTPegMS1FJ17GEuCAz6Xvm3NsL
         fFzw==
X-Forwarded-Encrypted: i=1; AJvYcCUyu79oobmzHrldJvqYDsPQ3wyiWKyfefiL9FfP4w38Zkhd/5Du6ReqCipQof7m76xCKBOPbwALxCo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6BZoWAZ8ywRHbxZHshfDldqwFroEhsaxQDUG8SCjAENnZhrJy
	qzJ6QT36bKa6qongJugjiOkxVeQqH2BWOjY+O0Z/c5hESQ9J/XfC3Eg1
X-Gm-Gg: AZuq6aIzMcYKcon5sTht7BeFX6MRVTPjNn5CYbQXywr/fJkRBpB/BPznL+ta7dB+Lul
	Gwc9dIqnYZlrRhQdo2fG6Zslp3uH+94VLiIPScC+2cCatvEz2n/zg6H1IPlV6nSldTRqhLfhA8D
	eRiGmD3wn8VgxgQHW/M6HoaJMOyekFOdGbyltCGApzypDJP9awMAwD6AgIQa9IjgZbCXBsRtnHc
	RNswtelnuR56V20yvhABAGNysijzrbyB1MYZcbp04T5Ql2umBFLUDE2AGTU39zqmR99LLkRI+dQ
	2M0PuXrOcLjdbfYD4jSvov+Y9a/2+EN1ZxgRmD+SHw8c/FoZS+ZqTO2Lw3P72bXuRr7DksieO/4
	WYdo906K6K+dVA69geqoRPK9o3jkh2St2LO6lKBMYCRv7LKl1U0JvJ8zDCdJAZ9AK4TMzl7yrw7
	HTiqTiAimghtTIVyxAPVlygrhkkSWcLn7T4dsQp3VXk6UBxhIgVg6lCPZmFClk2t+UWeUpVY8=
X-Received: by 2002:a05:6a21:7016:b0:366:14ac:e1ee with SMTP id adf61e73a8af0-3937249be13mr4124349637.64.1770228958068;
        Wed, 04 Feb 2026 10:15:58 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a93397cb23sm29570185ad.93.2026.02.04.10.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 10:15:57 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b2fdaf5f-62b3-4695-aa89-b674aabefffb@roeck-us.net>
Date: Wed, 4 Feb 2026 10:15:56 -0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [v3, apply after -rc1] i3c: simplify combined i3c/i2c
 dependencies
To: Arnd Bergmann <arnd@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org,
 linux-iio@vger.kernel.org
References: <20260204164216.544409-1-arnd@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260204164216.544409-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/4/26 08:41, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> All combined i2c/i3c drivers appear to suffer from the same link
> time problem when CONFIG_I3C is set to 'm':
> 
> arm-linux-gnueabi-ld: drivers/iio/magnetometer/mmc5633.o: in function `mmc5633_i3c_driver_init':
> mmc5633.c:(.init.text+0x30): undefined reference to `i3c_driver_register_with_owner'
> 
> This was previously fixed every time by marking individual
> drivers as 'depends on I2C; depends on I3C || !I3C', but this gets
> tedious and is somewhat confusing.
> 
> Add a Kconfig symbol 'I3C_OR_I2C' to help replace those dependencies,
> and use this in all the existing drivers that had already fixed it
> as well as the new mmc5633 driver.
> 
> Fixes: 6e5f6bf2e3f0 ("iio: magnetometer: Add mmc5633 sensor")
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

For hwmon:

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v2: restore accidentally deleted lines
> v3: rebase on top of Jonathan's IIO patch in linux-next
> ---
>   drivers/hwmon/Kconfig            |  6 ++----
>   drivers/i3c/Kconfig              | 12 ++++++++++++
>   drivers/iio/magnetometer/Kconfig |  3 +--
>   drivers/misc/amd-sbi/Kconfig     |  3 +--
>   4 files changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 41c381764c2b..ecfba861f66d 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1493,8 +1493,7 @@ config SENSORS_LM73
>   
>   config SENSORS_LM75
>   	tristate "National Semiconductor LM75 and compatibles"
> -	depends on I2C
> -	depends on I3C || !I3C
> +	depends on I3C_OR_I2C
>   	select REGMAP_I2C
>   	select REGMAP_I3C if I3C
>   	help
> @@ -2392,8 +2391,7 @@ config SENSORS_TMP103
>   
>   config SENSORS_TMP108
>   	tristate "Texas Instruments TMP108"
> -	depends on I2C
> -	depends on I3C || !I3C
> +	depends on I3C_OR_I2C
>   	select REGMAP_I2C
>   	select REGMAP_I3C if I3C
>   	help
> diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
> index 30a441506f61..626c54b386d5 100644
> --- a/drivers/i3c/Kconfig
> +++ b/drivers/i3c/Kconfig
> @@ -22,3 +22,15 @@ menuconfig I3C
>   if I3C
>   source "drivers/i3c/master/Kconfig"
>   endif # I3C
> +
> +config I3C_OR_I2C
> +	tristate
> +	default m if I3C=m
> +	default I2C
> +	help
> +	  Device drivers using module_i3c_i2c_driver() can use either
> +	  i2c or i3c hosts, but cannot be built-in for the kernel when
> +	  CONFIG_I3C=m.
> +
> +	  Add 'depends on I2C_OR_I3C' in Kconfig for those drivers to
> +	  get the correct dependencies.
> diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
> index 9345fb6d5317..fb313e591e85 100644
> --- a/drivers/iio/magnetometer/Kconfig
> +++ b/drivers/iio/magnetometer/Kconfig
> @@ -143,8 +143,7 @@ config MMC5633
>   	tristate "MEMSIC MMC5633 3-axis magnetic sensor"
>   	select REGMAP_I2C
>   	select REGMAP_I3C if I3C
> -	depends on I2C
> -	depends on I3C || !I3C
> +	depends on I3C_OR_I2C
>   	help
>   	  Say yes here to build support for the MEMSIC MMC5633 3-axis
>   	  magnetic sensor.
> diff --git a/drivers/misc/amd-sbi/Kconfig b/drivers/misc/amd-sbi/Kconfig
> index be022c71a90c..30e7fad7356c 100644
> --- a/drivers/misc/amd-sbi/Kconfig
> +++ b/drivers/misc/amd-sbi/Kconfig
> @@ -1,10 +1,9 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   config AMD_SBRMI_I2C
>   	tristate "AMD side band RMI support"
> -	depends on I2C
> +	depends on I3C_OR_I2C
>   	depends on ARM || ARM64 || COMPILE_TEST
>   	select REGMAP_I2C
> -	depends on I3C || !I3C
>   	select REGMAP_I3C if I3C
>   	help
>   	  Side band RMI over I2C/I3C support for AMD out of band management.

