Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA96C34F247;
	Sun, 27 Sep 2026 18:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790534098; cv=none; b=VraifzOiyTZqLUUIg5/rYWyzedPhtkWxeABlOwkKEJzkAxFfFXgJChMNZM3MHEKSeFh8E0se1zg4GKC5RwtLp7qVvpgalQzDgxj6z8Yd1MrEsmTlpbo6Xx/LITnLBpKsmRr5VEd9J2zmFXxzWDsqzdan+tApRTsO+gr0oeEHHAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790534098; c=relaxed/simple;
	bh=LvcS0JKXC46z1TSbO+BXmr/cZWADTy03GpGh/3hkxtw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EccE0JoRGRuWXqwewMpASgM7U9OR6+V2kLswU04G0/Wf+HznxONG+/XXNu9smHvNzjfBQRMxwr1eIXihgw5jHx3L/tAomPrhKehOSlBQ1kD9+7M7EKLZ5BshURr65Z3qi3kksvU9GBzNz2V+dYAfkzRGcwQaiLUi0vVc7SXfz48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nE9p8kr+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nE9p8kr+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867161F000FF;
	Sun, 27 Sep 2026 18:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790534096;
	bh=am9VniJEmyfGzsG1gWjCA6fA1rdIrRtt9qLvlf27FLM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nE9p8kr+m4dQ5zmeOECIJZtZqIhhi5dcDPcwBXnneNJMBc+IzAlEJk0VlP79WNsl3
	 0CzkD2hNvCn2kPLgQYQdKlsLnzJNSJF8aT5jFk/26oPKqjQJOsUmmO6RPA3r+RVYEc
	 ds1nD1X8JHZ6xXE2Ng1eiw+cazwuIVLItV3BWU230qlryvHpXWySGfVPxP0WClBgt6
	 EdW92prej5oSbG55TiSRjeBG1Mu5265ytQMOWXME1mVAQjcDenA3wpL5uYETjC0XM0
	 lQcw2QSt2L7d0Uh4q2OTmedWt0hp87DS7vF21wYMKnrqFF4FAbjByMKOUxhm65QHkT
	 GKMkX+5+vSBwg==
Date: Sun, 27 Sep 2026 19:34:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v8 3/5] iio: dac: mcp47feb02: refactor MCP47FEB02 I2C
 driver into two modules
Message-ID: <20260927193450.733ea26a@jic23-hlaptop>
In-Reply-To: <20260924-mcp47feb02_refactor-v8-3-17dc2ce3485e@microchip.com>
References: <20260924-mcp47feb02_refactor-v8-0-17dc2ce3485e@microchip.com>
	<20260924-mcp47feb02_refactor-v8-3-17dc2ce3485e@microchip.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Sep 2026 15:59:21 +0300
Ariana Lazar <ariana.lazar@microchip.com> wrote:

> Prepare the driver for the bus-specific code by refactoring into separate
> files. The renamed file will contain the common DAC functionality shared by
> the MCP47FxBy1/2/4/8 I2C and MCP48FxBy1/2/4/8 SPI drivers. The MCP47FEB02
> driver was refactored into two modules: mcp47feb02-core.c and
> mcp47feb02-i2c.c in order to prepare the support for SPI MCP48FxBy1/2/4/8
> DAC family on top of the current implementation.
> 
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
> ---
>  MAINTAINERS                                        |   2 +-
>  drivers/iio/dac/Kconfig                            |   9 +-
>  drivers/iio/dac/Makefile                           |   3 +-
>  .../iio/dac/{mcp47feb02.c => mcp47feb02-core.c}    | 322 ++-------------------
>  drivers/iio/dac/mcp47feb02-i2c.c                   | 145 ++++++++++
>  drivers/iio/dac/mcp47feb02.h                       |  43 +++
>  6 files changed, 219 insertions(+), 305 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2e98d052fbdcf43f70376fdb3a553e97bf91dc82..ecc22d1149d19ae7798ebd54c52b1b2486d1f9f1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16352,7 +16352,7 @@ M:	Ariana Lazar <ariana.lazar@microchip.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
>  F:	Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
> -F:	drivers/iio/dac/mcp47feb02.c
> +F:	drivers/iio/dac/mcp47feb02*
>  
>  MCP4821 DAC DRIVER
>  M:	Anshul Dalal <anshulusr@gmail.com>
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index b6c8873c68c54d13f80ea7116bee1ac00f374574..8121a71945f63a23b35fcab010fda1d03d0afba0 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -611,9 +611,13 @@ config MCP47A1
>  	  will be called mcp47a1.
>  
>  config MCP47FEB02
> -	tristate "MCP47F(E/V)B01/02/04/08/11/12/14/18/21/22/24/28 DAC driver"
> +	tristate
> +
> +config MCP47FEB02_I2C
> +	tristate "MCP47F(E/V)B01/02/04/08/11/12/14/18/21/22/24/28 I2C DAC driver"
>  	depends on I2C
>  	select REGMAP_I2C
> +	select MCP47FEB02
>  	help
>  	  Say yes here if you want to build the driver for the Microchip:
>  	  - 8-bit DAC:
> @@ -629,7 +633,8 @@ config MCP47FEB02
>  	  (DAC) with I2C interface.
>  
>  	  To compile this driver as a module, choose M here: the module
> -	  will be called mcp47feb02.
> +	  will be called mcp47feb02_i2c and you will also get
> +	  mcp47feb02_core for the core module.
>  
>  config MCP4821
>  	tristate "MCP4801/02/11/12/21/22 DAC driver"
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index 8dc644522b1e52152abacc32cacb6ee90881ef9a..4394278d9fd874b94ae2d680378fb3b043ac8672 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -57,7 +57,8 @@ obj-$(CONFIG_MCF54415_DAC) += mcf54415_dac.o
>  obj-$(CONFIG_MCP4725) += mcp4725.o
>  obj-$(CONFIG_MCP4728) += mcp4728.o
>  obj-$(CONFIG_MCP47A1) += mcp47a1.o
> -obj-$(CONFIG_MCP47FEB02) += mcp47feb02.o
> +obj-$(CONFIG_MCP47FEB02) += mcp47feb02-core.o
> +obj-$(CONFIG_MCP47FEB02_I2C) += mcp47feb02-i2c.o
>  obj-$(CONFIG_MCP4821) += mcp4821.o
>  obj-$(CONFIG_MCP4922) += mcp4922.o
>  obj-$(CONFIG_STM32_DAC_CORE) += stm32-dac-core.o
> diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02-core.c
> similarity index 73%
> rename from drivers/iio/dac/mcp47feb02.c
> rename to drivers/iio/dac/mcp47feb02-core.c
> index 8f8a67919cc2ecdb203ad350174bac2be1a307dc..29d69cb2f68b5d7c6a615481bb1045aed468e9cf 100644
> --- a/drivers/iio/dac/mcp47feb02.c
> +++ b/drivers/iio/dac/mcp47feb02-core.c
> @@ -1,8 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * IIO driver for MCP47FEB02 Multi-Channel DAC with I2C interface
> + * IIO driver for MCP47FEB02 Multi-Channel DAC with I2C and SPI interface
>   *
> - * Copyright (C) 2025 Microchip Technology Inc. and its subsidiaries
> + * Copyright (C) 2025-2026 Microchip Technology Inc. and its subsidiaries
>   *
>   * Author: Ariana Lazar <ariana.lazar@microchip.com>
>   *
> @@ -16,7 +16,6 @@
>  #include <linux/bitfield.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
> -#include <linux/i2c.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/kstrtox.h>
> @@ -29,6 +28,8 @@
>  #include <linux/types.h>
>  #include <linux/units.h>
>  
> +#include "mcp47feb02.h"
> +
>  /* Register addresses must be left shifted with 3 positions in order to append command mask */
>  #define MCP47FEB02_DAC0_REG_ADDR			0x00
>  #define MCP47FEB02_VREF_REG_ADDR			0x40
> @@ -82,220 +83,12 @@ enum mcp47feb02_gain_bit_mode {
>  	MCP47FEB02_GAIN_BIT_X2 = 1,
>  };
>  
> -static const char * const mcp47feb02_powerdown_modes[] = {
> +const char * const mcp47feb02_powerdown_modes[] = {

Why is this change here?  Whilst you add the extern to the
header, I'm not seeing it used outside of this file.


>  	"1kohm_to_gnd",
>  	"100kohm_to_gnd",
>  	"open_circuit",
>  };

Thanks,

Jonathan

