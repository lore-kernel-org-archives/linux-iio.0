Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9BB33C195;
	Sun, 23 Aug 2026 01:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787446981; cv=none; b=HaJyaB3GRzpikl7quT8MxeG+1hLLn/53xAvcl5ttNnnXhY+DzSAd+QjouKWezNyRSkP6uPcWqDolvvajrL4dQn6M7IUPbEudCtQNrWGngdosY5pKTXAB+fErQB1BANlISBdQyEirUVk5+zsVnJSifnH5daK8ScQUCBaKKHAiJ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787446981; c=relaxed/simple;
	bh=A3+hN8Kucghg/yblzOTS3HoAsQqd1pyl76XjJ7mwr2U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QDRiaQcugzFIMzJscsTaGjTnYKp4RzT3vw+8PPZg45ocxKg59W8tHFFTHeatnXafdD4Bu1LuNJNO7jxcPQqIOaYE3/T2eBOsM429yNkZBjHI6Ed7dzquL4R73lqq5TOqgv31waPwnUA5v5ZPv/b/AdiB79Yw5+nWLLO9XbL6FF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCSpnHrk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCSpnHrk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC531F00A3A;
	Sun, 23 Aug 2026 01:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787446961;
	bh=GrcnR9gzqcCGFW9UlNemOxZjTWMtfauhXWKhoK0wv+8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lCSpnHrk2RX6Aase9vUh6aRpGO9SPDitNDOuraWm1OfbNVwNkqjAv5bOvAJc5uWwK
	 ejg1NhJvezX/esHUjR6X7nqIIGc7YykA/jeqSaNYO367BZc6rpmaT/GjAvjPXzTL+j
	 FJPcG88ehQdQTRbl7jTZDcTDAQuYbgvgisHI8BX9q4zTrqVaVurjl+bL7CRi1Nx+u7
	 SXZSeYLGkQzk547o//2EF3BlNCWEBjP60SraoXJft5Lde+EWk75KFCKCoPPFy7OV5K
	 U9OVjyB9dtl4qmHzKU2yyfEFc/eEfJGqsR+WccdUvO/W1I77+pF7lWk9dyDwc9VDzk
	 NYbNs6QZ//BZg==
Date: Sun, 23 Aug 2026 02:02:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 7/9] iio: dac: mcp47feb02: refactor MCP47FEB02 I2C
 driver into two modules
Message-ID: <20260823020234.3f4bed1c@jic23-huawei>
In-Reply-To: <20260819-mcp47feb02_refactor-v4-7-beb2aa3bfd09@microchip.com>
References: <20260819-mcp47feb02_refactor-v4-0-beb2aa3bfd09@microchip.com>
	<20260819-mcp47feb02_refactor-v4-7-beb2aa3bfd09@microchip.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Aug 2026 15:41:11 +0300
Ariana Lazar <ariana.lazar@microchip.com> wrote:

> Prepare the driver for the bus-specific code by refactoring into separate
> files. The renamed file will contain the common DAC functionality shared by
> the MCP47FxBy1/2/4/8 I2C and MCP48FxBy1/2/4/8 SPI drivers. The MCP47FEB02
> driver was refactored into two modules: mcp47feb02-core.c and
> mcp47feb02-i2c.c in order to prepare the support for SPI MCP48FxBy1/2/4/8
> DAC family on top of the current implementation.
> 
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
A few trivial things inline.

Thanks,

Jonathan

> ---
>  MAINTAINERS                                        |   4 +-
>  drivers/iio/dac/Kconfig                            |  10 +-
>  drivers/iio/dac/Makefile                           |   3 +-
>  .../iio/dac/{mcp47feb02.c => mcp47feb02-core.c}    | 327 ++-------------------
>  drivers/iio/dac/mcp47feb02-i2c.c                   | 145 +++++++++
>  drivers/iio/dac/mcp47feb02.h                       |  46 +++
>  6 files changed, 227 insertions(+), 308 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6b4560681b51cfabf0b0e98fd89b69d8c527228b..fc87609865f26a9f484edc42058f7df659a0fa4f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16118,7 +16118,9 @@ M:	Ariana Lazar <ariana.lazar@microchip.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
>  F:	Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
> -F:	drivers/iio/dac/mcp47feb02.c
> +F:	drivers/iio/dac/mcp47feb02-core.c
> +F:	drivers/iio/dac/mcp47feb02-i2c.c
> +F:	drivers/iio/dac/mcp47feb02.h
>  

Can use wild cards. We should probably do this more often!

F:   drivers/iio/dac/mcp47feb02* 

....

> diff --git a/drivers/iio/dac/mcp47feb02.h b/drivers/iio/dac/mcp47feb02.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..64620c865871254f5db373f951ffad3b9c273f29
> --- /dev/null
> +++ b/drivers/iio/dac/mcp47feb02.h
> @@ -0,0 +1,46 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +#ifndef __DRIVERS_IIO_DAC_MCP47FEB02_H__
> +#define __DRIVERS_IIO_DAC_MCP47FEB02_H__
> +
> +#include <linux/pm.h>
> +#include <linux/types.h>
> +
> +extern const char * const mcp47feb02_powerdown_modes[];
> +
> +/* Macro used for generating chip features structures */

That seems kind of obvious. I'd drop the comment!

> +#define MCP47FEB02_CHIP_INFO(_name, _channels, _res, _vref1, _eeprom) \
> +static const struct mcp47feb02_features _name##_chip_features = { \
> +	.name = #_name, \
> +	.phys_channels = _channels, \
> +	.resolution = _res, \
> +	.have_ext_vref1 = _vref1, \
> +	.have_eeprom = _eeprom, \
> +}
> +/* Properties shared by I2C and SPI families */

I wouldn't call the following function a property.  Probably just drop this comment
as not that useful.

> +int mcp47feb02_common_probe(const struct mcp47feb02_features *chip_features,
> +			    struct regmap *regmap);
> +
> +extern const struct dev_pm_ops mcp47feb02_pm_ops;
> +
> +#endif /* __DRIVERS_IIO_DAC_MCP47FEB02_H__ */
> +

Seems to be an extra trailing blank line. Delete it.

