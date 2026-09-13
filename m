Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3553C35F184;
	Sun, 13 Sep 2026 21:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789336272; cv=none; b=Rack+gA1NOSyGDM0fVwYe9lEXxCGVo8tDLvetoLzfxfUhxwFsGX/skL+A4m/GE5ogM6SKkbUXOPmtgcfQM7QpWy1wQV5tJrbPlxXohGhDKaYFY2c83rDCaBOIAxvZ3gEsQ+fglcGQY0pyVt+i2e4bvv7O0Dn9E9cgpl2CZAlrEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789336272; c=relaxed/simple;
	bh=8rg2eNOTtt+zLL4lGwFAEGPEP1P8+2A8Dn6MGVVNcic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Whh35KE9e3jnhpytIVx70VXIrj4yWJzGLC5Y4OGT3MMgl8W40Y+F25sa2qyUTatCCAgTfSRLMXo3YAKqmlk87lN18qLJcFonTcryZVMgT2MXtxpBFDKoxwHCf4tjIcH6nQ0bd8ttCRnyinYUtpPJOLSJMKvgCSfQLJKqN4yElyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVx2DUeA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVx2DUeA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF7F1F000FF;
	Sun, 13 Sep 2026 21:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789336270;
	bh=udMt21nwWf9/TleZjkb2wzEX6bNIyeF8qHE5tvvW1qA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jVx2DUeAkPA+HHl2H+C2NWQ4j1+leNTqHynShnZ/F+ZuKWK8GpwajwAlD8KYwEBWx
	 rcOkI/17eOULo5lpq0UcFjpKsjOc+8DIiQ8w4vLw1US8O9Z4iSwi6Tz7acT+FbXg/W
	 6UuoU1627fip7OKvLPdecJnhl0Iwzt2Ogz13q3ajwkQ57xa9hmLD9Xf5zTKk/kkkzE
	 HflUaMmnyT0MlypNU7Cf3sZuS/q5DgwdD64CL1OZ3sJGncfStHWVRnCqui0P58M3eM
	 sj6BjI4jXkHKdaUE1X4QvDZ+ckwgIavOvL3PBvpZipRy+haF9CoIX1eGxAIiYFuzfU
	 jbCspstmqFsEA==
Date: Sun, 13 Sep 2026 22:51:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 08/10] iio: dac: mcp47feb02: refactor MCP47FEB02 I2C
 driver into two modules
Message-ID: <20260913225108.7356ccb2@jic23-hlaptop>
In-Reply-To: <20260909-mcp47feb02_refactor-v5-8-8b67bcab93d1@microchip.com>
References: <20260909-mcp47feb02_refactor-v5-0-8b67bcab93d1@microchip.com>
	<20260909-mcp47feb02_refactor-v5-8-8b67bcab93d1@microchip.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Sep 2026 17:18:51 +0300
Ariana Lazar <ariana.lazar@microchip.com> wrote:

> Prepare the driver for the bus-specific code by refactoring into separate
> files. The renamed file will contain the common DAC functionality shared by
> the MCP47FxBy1/2/4/8 I2C and MCP48FxBy1/2/4/8 SPI drivers. The MCP47FEB02
> driver was refactored into two modules: mcp47feb02-core.c and
> mcp47feb02-i2c.c in order to prepare the support for SPI MCP48FxBy1/2/4/8
> DAC family on top of the current implementation.
> 
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>

One thing inline.

> diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02-core.c
> similarity index 73%
> rename from drivers/iio/dac/mcp47feb02.c
> rename to drivers/iio/dac/mcp47feb02-core.c
> index fb66bd2664a9e6dd938eacc90547403041e258a4..4ef64a3408033501c724c7c52fd20686cc53722a 100644
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
> @@ -16,12 +16,10 @@
>  #include <linux/bitfield.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
> -#include <linux/i2c.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/kstrtox.h>
>  #include <linux/module.h>
> -#include <linux/mod_devicetable.h>
This surprised me because I thought this was no longer included
from any drivers using i2c.  Indeed it is gone since :
995832b2cebe "(Replace <linux/mod_devicetable.h> by more specific <linux/device-id/*.h> (c files)")

Hence please rebase on 7.3-rc1. I don't think we have anything
more recent that touches this driver and a mainline rc is an
easy base to deal with.


>  #include <linux/mutex.h>
>  #include <linux/property.h>
>  #include <linux/regmap.h>
> @@ -30,6 +28,8 @@
>  #include <linux/types.h>
>  #include <linux/units.h>
>  
> +#include "mcp47feb02.h"

