Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FEA352942
	for <linux-iio@vger.kernel.org>; Mon,  2 Feb 2026 17:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770054662; cv=none; b=o3OVWBhlVfr3/ZGiMGztgcMEquPESkjes3Kb6aKb3enwddA4qWYcX/O1mLr3Gn0tbf7hBgBzTgSiRD56oObb8VVlDEBEDl/MiD9KRKIU68VLaoWDPrs90kO020C0AU3RUmYZRXHvp+vf/QpvWhBDejdwSCuzkUIW7Ns1hctGYok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770054662; c=relaxed/simple;
	bh=vknwjL0TKYnUIle6ZbiLxm1hyGJ42HW/MSeJYODsj9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YzWzZeLjnJ1G2TZ9jpTmeBqVuQHaZB+uKyu49k+18qCvTd2I94uFFdpxb7K7LqqDhUq6v6lvtRG5ot+Z9M2JU14QvQjCk4XK9On1l/4lcszUC5Cc9n8R4dDI2cYMRGgLHk9UDGTAKRTqvBbU/HDso5AVv0A5/ehyRKJZFAcGJyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhYZFYfY; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhYZFYfY"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-81df6a302b1so4437305b3a.2
        for <linux-iio@vger.kernel.org>; Mon, 02 Feb 2026 09:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770054661; x=1770659461; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=IYzMM+PDFT0S0J7fPI3P9GPnIxCBaLx35Q93v5Nih6A=;
        b=hhYZFYfYj3ugTQIiYmqEgwXs5aA42gkEfIVZcU6qJGralFKRe6HDRLXnJykKVV7MZ3
         x4pYDiu4sva2Ni8MdxqCIXBzd7U4VM7inXnisK3MMiM/qnWCAQ3SmeLxgP7w0jzkd6CL
         F1nAL3R4kZMJrynsN+mrF2jeMk+kp/7huOP/NmQwXqhRPBWGZsUQA3DidrkY1wSRXheo
         R6xOfBbp1R6YHmslI2848ercydLrGmafR4hUr/otmmnOejj0a86sAnLzQ12XWCVn1szv
         NK3+XkfFCKjNlCGFhN/9Jh+Hg2RuSqEkduIgthOX+Iqpq/t3gfstE+V5p22S2gR7KR8c
         HLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770054661; x=1770659461;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IYzMM+PDFT0S0J7fPI3P9GPnIxCBaLx35Q93v5Nih6A=;
        b=fl7a4DvYIJkXoCzaxUbSlMgFzgFX992g+uaLUKfKHK+bnZks6IYnf1xJ1Lr7vxysVf
         leq5jfnSGHhVpi9r42yjKDI+uM8Q6Aql4616Q3mmx4/2dACBLKwkB6LeRtBTQct8H+f/
         dc+91yFMiVzrbLQCTDEhkrUx4Y3LoB7cuvzoeZ+oEUCU7rrGDJwIkdCO8oSatWqrS5nO
         RDfD8bstr7N1wH5FrPgjzKVhmIF/PzjNpYPFbTuj5piM8N0GK0s3SQo+FOTav6L/hg55
         tcDMh5Yf6gCaaJU5R+m5I04DXBHkw2IMdjIi4rJQObKrfSxUTyA1dhtdi9wF+34n3lTV
         rzLg==
X-Forwarded-Encrypted: i=1; AJvYcCUFpZntXp8ZQsWNkSS9Vmq4zFdLW2IEC5yZTiUhYyB59anoAJ48nI0qq7SZlf+8JOXdq4VEoQHjwuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8+zZh0YsY7JGusuL0+A4jvLikLXsILD2pmNW6Lr78o0Ql7+1S
	AlZiYm9VmAqEexb0QnYLcdAKhAztz+TCH6YC0OOvbVxQdpRFLl5AJ1/G
X-Gm-Gg: AZuq6aJZqVCFAVwRaIq3Ae5G2YYFX1hpQELIboU/odRojffiBWSwHmSlR5iI9XTOM6q
	QuhIPLxM3kVBYhl8hL1EL+GEgoqoEvBVFwfMt9h5MBo0c4mNtyDxRMhovTdTDhn9d4u5bLCpvZ4
	aiBZ6+g3ZXiWYvbkLrvUJHex4zxCrRvG89RvrVcQV6uJJQDmJL2XiANqTltKK/RgmD8NvZHaauz
	4W5Plvmp4BD++nCYW6YijKN9fz/g1cVaiPiMMfTiVgu2w6armtw1yaAU7yv2QWMQvM4Ev9zLler
	uGokE3AjbJub8BlSfc7z7by2OP9GDUCuS/tFuFCdAd8NwYYlcHpclW5YzZYgZYNfS5+KMfEzGnK
	KBRqKzTxvbhELBkXiIQwRDIZ15+JSfQHFY0RFoYdZluvft6vkvJ+hIQfBApO5dnVw+VxI8jCNXO
	pa6eD60KaZvYfZtWyBqladMH29yZvaggeOGxEFczVg1WGaCut4KrNnKJVeIFyHRibfDlUIKCU=
X-Received: by 2002:a05:6a21:7748:b0:393:39a0:f1e5 with SMTP id adf61e73a8af0-39339a1024dmr2759691637.48.1770054660584;
        Mon, 02 Feb 2026 09:51:00 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642b0b4c07sm14937334a12.36.2026.02.02.09.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 09:51:00 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a8f8ee55-3c87-4e9c-a5a9-12929855b86f@roeck-us.net>
Date: Mon, 2 Feb 2026 09:50:58 -0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [v2] i3c, iio: fix i3c driver dependencies
To: Arnd Bergmann <arnd@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Jonathan Cameron <jic23@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>, Frank Li <Frank.Li@nxp.com>,
 Adrian Fluturel <fluturel.adrian@gmail.com>,
 Carlos Song <carlos.song@nxp.com>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Jean Delvare <jdelvare@suse.de>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org,
 linux-iio@vger.kernel.org
References: <20260202160543.3654499-1-arnd@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260202160543.3654499-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/2/26 08:04, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> All combined i2c/i3c drivers appear to suffer from the same link
> time problem when CONFIG_I3C is set to 'm':
> 
> arm-linux-gnueabi-ld: drivers/iio/magnetometer/mmc5633.o: in function `mmc5633_i3c_driver_init':
> mmc5633.c:(.init.text+0x30): undefined reference to `i3c_driver_register_with_owner'
> 
> This was previously fixed several times by marking individual
> drivers as 'depends on I2C; depends on I3C || !I3C', but this gets
> tedious and is somewhat confusing.
> 
> Add a Kconfig symbol 'I3C_OR_I2C' to help replace those dependencies,
> and use this in all the existing drivers that had already fixed it
> as well as the new mmc5633 driver.
> 
> Fixes: 6e5f6bf2e3f0 ("iio: magnetometer: Add mmc5633 sensor")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: restore accidentally deleted lines
> ---
>   drivers/hwmon/Kconfig            |  6 ++----

For hwmon:

Acked-by: Guenter Roeck <linux@roeck-us.net>

>   drivers/i3c/Kconfig              | 12 ++++++++++++
>   drivers/iio/magnetometer/Kconfig |  2 +-
>   drivers/misc/amd-sbi/Kconfig     |  3 +--
>   4 files changed, 16 insertions(+), 7 deletions(-)
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
> index 2b81b22c9550..448fef4e5716 100644
> --- a/drivers/iio/magnetometer/Kconfig
> +++ b/drivers/iio/magnetometer/Kconfig
> @@ -143,7 +143,7 @@ config MMC5633
>   	tristate "MEMSIC MMC5633 3-axis magnetic sensor"
>   	select REGMAP_I2C if I2C
>   	select REGMAP_I3C if I3C
> -	depends on I2C || I3C
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

