Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D877DA66
	for <linux-iio@vger.kernel.org>; Sat,  4 Apr 2026 13:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775310600; cv=none; b=m/n2/b7s6cd4wzhe5/4DNdv5/wFgLqkDva5uOsZ5YW8E6StDzPIZtzHsR+XoBSCv2NGMnhU8YPktr4meR9y4QMj/uyKcjTWnvedMx3jviDGWyePRPkDdWU9SzSAGzc15Cc4cavTyLKEp1ZUhARG9X5z0Xe+nkYwtODN1u6mF/RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775310600; c=relaxed/simple;
	bh=ZRPIOngPQqPu5nK5SdxVdEth9J3ofsOv3/LQED0NPug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JSX19VyCBWBYJeMBpfYTnWHRJgt6SodVK6kLzLvISdgitZ09XX5ySTOTOlo+mPQYy5nK4FxiLH2yO4YIAcd3ZfpGSmXZqVfBvUtqt/xjKYeWOZxrfvJ/MGmoACbFypOfL/3d6c0x2POABta+TqH5kP2t8auEPF0SkjKr1J9SRt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=ZMfPlG9G; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="ZMfPlG9G"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-40f0e14b9f9so1902563fac.1
        for <linux-iio@vger.kernel.org>; Sat, 04 Apr 2026 06:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775310597; x=1775915397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6M9b8o09OMGhGzqfrb7bU4Z45lKmeNQHUj4rfqjUhME=;
        b=ZMfPlG9GXWS6x9AhykwYqWS/pHr2hkb8fzOebEXFqf0cYmSofSkskdRDqzK9Uxbqmf
         V/9GG2Hd7dkukKyKAdSkScTz8ejQkbUCHgroYaJuySbix66HXV8Z7stMGd7zNd6FzW9K
         TVyG/WjDxXotCtfZYNvqsRgRyzpWoOhChBkp7XkTfUiOyRkNEyNjd+S/yMEfIa/Sk7Zl
         km3moA/Vh3kav31TtT4qyFt6gXXOtZGpxEzG0zJmiAsx6ixqP2ZiDQ9wewi/KGIGsIjs
         ItI73+7CpU3fbjfiA4qE7F17b9D2FPwToj0gDXqZy4JSbcTzPPF2AVmS0SfywAk3ahbv
         1CuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775310597; x=1775915397;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6M9b8o09OMGhGzqfrb7bU4Z45lKmeNQHUj4rfqjUhME=;
        b=FiEUjaewB0UD/N5++t6BtegZ2ruUUhLRXWTBpY1S+GkJbPZOEAw2seUtC85h6KIWyk
         t+zo8egCke9aBW5zcQvY3JeXW1oVoAxGDR5j86/ZIVpS4jPampDnLsKn3qNyWjmE11BD
         yRW1IKZbqBz8GviIZQr1YQi5GKjpEJ1P9g3yOAvJlau1IecDujZEIrCVOmG+bDLF0VU7
         buVZdqAwoNQYqJ475VqbQXhPd92hTyxkEbD+BAAkdtrFjYljZLRHw0wBOvPyA8HPeiaC
         sh7QwBb9LzM7JRuCpQ+12K7OXmvwPhqix6ycboJ8WJFMI1kFxGWza26BEOir5Gbu8LAO
         bb3A==
X-Forwarded-Encrypted: i=1; AJvYcCVnvyJy4CQ14zpLhi6NFsL9YMmftgnKhWbaIZWlDEKf09OwuIxzqJf/ZnYx6Y+J8D/WMA3BB14jKSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwbVnX4a7Y0mlEhCLnMXS3dF+NVyM+5Xvm+UDk0m/adWwB9kXr
	T4u9enpYqNjzqrkgas8mO/1rgh1mIH0JKECTJfMSSdRUpIDefEJ14QaFvrZrerW7COE=
X-Gm-Gg: AeBDievOPEF8WGSc31bBvIArRb/nULkxEdnN6D/7DnfHkxvatOLXjPv3DlBntanE+9Y
	kVyyzCWqI+z+BjuG1U+8yEQnNmr8IU6H2/u2pHUC+9fvQE0QjtrDrhHtJ5uptOeAX/tBtJtCh7j
	XmMJueyFNI+vMzEJdPBViJj8mx07zYRWSj1Ip8qYfbynvs1QpC4DhjXY5gd7P4UYK/9+jlXqnuz
	4nOpmWCyN+h6O4JZxtZyBKI0HOnVatUXKSyar/ItvhaLhgt636BgrB1EFng2alZMJxB27yWAwzv
	zdKw6W6IMPTF3BR939XGy3Yo3yCQTDURJsDXTQIobiIcoSM/Qx+IyZOMnrIONoFinZeb4H0z7MF
	z3at9/CTyX023GSyyp5ZAtulrYcLI3/Syw+T/nn0kB7sajB3dUSE9lRsveBYKK46GxlByveW0d0
	gBYTbN0w6O3MxPHQYlp3s05RW4X9Knir5s64acDlLHdr5tRfeIeYZDaMi2ZPWUIsPy9rfWvnZH2
	g==
X-Received: by 2002:a05:6870:b1c1:b0:3f1:6d93:4386 with SMTP id 586e51a60fabf-4230fc7bed0mr3574752fac.1.1775310597071;
        Sat, 04 Apr 2026 06:49:57 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:e14e:bcc6:3f95:26eb? ([2600:8803:e7e4:500:e14e:bcc6:3f95:26eb])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-422eb42db1bsm7906203fac.17.2026.04.04.06.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2026 06:49:56 -0700 (PDT)
Message-ID: <1e05b8f9-e95e-458d-9179-ac8268023ae5@baylibre.com>
Date: Sat, 4 Apr 2026 08:49:55 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: dac: mcp47feb02: add MCP48FEB02 SPI driver to
 MCP47FEB02 I2C driver
To: Ariana Lazar <ariana.lazar@microchip.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Conor Dooley <conor.dooley@microchip.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260403-mcp47feb02-fix2-v1-0-da60c773550e@microchip.com>
 <20260403-mcp47feb02-fix2-v1-2-da60c773550e@microchip.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260403-mcp47feb02-fix2-v1-2-da60c773550e@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/3/26 5:50 AM, Ariana Lazar wrote:
> This is the iio driver for Microchip MCP48FxBy1/2/4/8 series of
> buffered voltage output Digital-to-Analog Converters with nonvolatile or
> volatile memory on top of MCP47FEB02. The families support up to 8
> output channels and have 8-bit, 10-bit or 12-bit resolution.
> 
> The MCP47FEB02 driver was split into three modules: mcp47feb02-core.c,
> mcp47feb02-i2c.c and mcp47feb02-spi.c in order to support both DAC families
> - I2C (MCP47F(E/V)BXX) and SPI (MCP48F(E/V)BXX).
> 
> Fixes: bf394cc80369 ("iio: dac: adding support for Microchip MCP47FEB02")
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
> Link: https://lore.kernel.org/all/aY4yaVP2TQFRI1E4@smile.fi.intel.com/
> ---
>  MAINTAINERS                       |   4 +
>  drivers/iio/dac/Kconfig           |  29 +-
>  drivers/iio/dac/Makefile          |   3 +
>  drivers/iio/dac/mcp47feb02-core.c | 845 ++++++++++++++++++++++++++++++++++++++
>  drivers/iio/dac/mcp47feb02-i2c.c  | 145 +++++++
>  drivers/iio/dac/mcp47feb02-spi.c  | 145 +++++++
>  drivers/iio/dac/mcp47feb02.h      | 158 +++++++
>  7 files changed, 1328 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5997cf04b0732beaf69ac78cb762c42c56e4fcd6..af747c5449681807d3d74014dc11dffea5acc012 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15850,6 +15850,10 @@ M:	Ariana Lazar <ariana.lazar@microchip.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
>  F:	Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
> +F:	drivers/iio/dac/mcp47feb02-core.c
> +F:	drivers/iio/dac/mcp47feb02-i2c.c
> +F:	drivers/iio/dac/mcp47feb02-spi.c
> +F:	drivers/iio/dac/mcp47feb02.h
>  
>  MCP4821 DAC DRIVER
>  M:	Anshul Dalal <anshulusr@gmail.com>
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index cd4870b654153e91c3c44860be43d231ee3b5519..5bec52552d263532ffe357666a64a1c6bb968d85 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -539,8 +539,12 @@ config MCP4728
>  	  will be called mcp4728.
>  
>  config MCP47FEB02
> +	tristate
> +
> +config MCP47FEB02_I2C
>  	tristate "MCP47F(E/V)B01/02/04/08/11/12/14/18/21/22/24/28 DAC driver"
>  	depends on I2C
> +	select MCP47FEB02
>  	help
>  	  Say yes here if you want to build the driver for the Microchip:
>  	  - 8-bit DAC:
> @@ -556,7 +560,30 @@ config MCP47FEB02
>  	  (DAC) with I2C interface.
>  
>  	  To compile this driver as a module, choose M here: the module
> -	  will be called mcp47feb02.
> +	  will be called mcp47feb02_i2c and you will also get
> +	  mcp47feb02_core for the core module.
> +
> +config MCP47FEB02_SPI
> +	tristate "MCP48F(E/V)B01/02/04/08/11/12/14/18/21/22/24/28 DAC driver"
> +	depends on SPI
> +	select MCP47FEB02
> +	help
> +	  Say yes here if you want to build the driver for the Microchip:
> +	  - 8-bit DAC:
> +	    MCP48FEB01, MCP48FEB02, MCP48FEB04, MCP48FEB08,
> +	    MCP48FVB01, MCP48FVB02, MCP48FVB04, MCP48FVB08
> +	  - 10-bit DAC:
> +	    MCP48FEB11, MCP48FEB12, MCP48FEB14, MCP48FEB18,
> +	    MCP48FVB11, MCP48FVB12, MCP48FVB14, MCP48FVB18
> +	  - 12-bit DAC:
> +	    MCP48FEB21, MCP48FEB22, MCP48FEB24, MCP48FEB28,
> +	    MCP48FVB21, MCP48FVB22, MCP48FVB24, MCP48FVB28
> +	  having 1 to 8 channels, 8/10/12-bit digital-to-analog converter
> +	  (DAC) with SPI interface.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called mcp47feb02_spi and you will also get
> +	  mcp47feb02_core for the core module.
>  
>  config MCP4821
>  	tristate "MCP4801/02/11/12/21/22 DAC driver"
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index 2a80bbf4e80ad557da79ed916027cedff286984b..d2a2279b15499e1b43ed0e3e1f180b5b1ff72785 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -54,6 +54,9 @@ obj-$(CONFIG_MAX5821) += max5821.o
>  obj-$(CONFIG_MCP4725) += mcp4725.o
>  obj-$(CONFIG_MCP4728) += mcp4728.o
>  obj-$(CONFIG_MCP47FEB02) += mcp47feb02.o

Shouldn't we be removing this old file?

The patch series would be eaiser to understand if it was split into
one commit to split the existing driver into two files and then
another commit to add support for the new parts.


> +mcp47feb02-objs := mcp47feb02-core.o
> +obj-$(CONFIG_MCP47FEB02_I2C) += mcp47feb02-i2c.o
> +obj-$(CONFIG_MCP47FEB02_SPI) += mcp47feb02-spi.o
>  obj-$(CONFIG_MCP4821) += mcp4821.o
>  obj-$(CONFIG_MCP4922) += mcp4922.o
>  obj-$(CONFIG_STM32_DAC_CORE) += stm32-dac-core.o
