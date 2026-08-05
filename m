Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C404E2D3A93;
	Wed,  5 Aug 2026 01:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785892428; cv=none; b=r8qg+VSq7GQ5o8De2G+jsF+tUefQDgsUPI0ujPWB0ja6OnXQLsfmFuVb4ywvkMA6W0Ne0M8Xucw4fyi/svVi7LXWQOb3ScP67SvC72m7Yq+qCXl6cLslIAaGFe1R6CgnS8YIP9h5rOKMvJv+ZKVps6mmXrsKQLeocLTr4IYlxYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785892428; c=relaxed/simple;
	bh=MblzNipihIKaqXhR6O2qNRqJBQ1j+x+tDwplCUWPtXo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oKr3ENAVQwp02Srow8D6gHg3AQL9bXeJr3bVUb5eNC3WilZrFETvcVJpL90eEyabxAu765UbFbzI5Yuzym90sYm4lVztV3czY0TM7Q5APiFORWIXR3rbQHiAZ8wkR37+2//lblqu6NnUGxYswmg4SuuG/nDf0i6X6UH+r5FBgtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zm3rjrcd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zm3rjrcd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF55F1F000E9;
	Wed,  5 Aug 2026 01:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785892427;
	bh=IRPMULM9cPsG7UmqJWpg6T8v4cl7nyfCUu8KZ1r4nk4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Zm3rjrcdAF3lPMdKrArQmvVa9/ajyO4XgVDmLxigfV+091zZdD2v8axyWnepBQrv1
	 Eh/l9h/RN7DRsr59H3PxZM3o673rV5LV/1RkGizNqv7XcRdD8d5LgqfdsZinyUmq9z
	 XpZ0PwF4Xcrk4aho6odOo0UtZU5Cp9cp/PjJeoDdfsqUp+fJhtIjjLfVOgjtHmNIdx
	 yRRFegMImwqeLCEUoTnJBGI2Wpa+TfLP6sN6IkTidIDr+fOoDZX5++6hh3WTn0MaOA
	 a6dGuUze0f59pKaGarldBmBVAprxYnIotfMNGnxAyMt1n/VuPR3tarj06OBsDsqlxk
	 zoFdwJ1/yoDUQ==
Date: Wed, 5 Aug 2026 02:13:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] iio: dac: mcp47feb02: refactor MCP47FEB02 I2C
 driver into two modules
Message-ID: <20260805021341.2b45e680@jic23-huawei>
In-Reply-To: <20260804-mcp47feb02_refactor-v3-1-97f8b81f3628@microchip.com>
References: <20260804-mcp47feb02_refactor-v3-0-97f8b81f3628@microchip.com>
	<20260804-mcp47feb02_refactor-v3-1-97f8b81f3628@microchip.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Aug 2026 16:29:47 +0300
Ariana Lazar <ariana.lazar@microchip.com> wrote:

> Prepare the driver for the bus-specific code by refactoring into separate
> files. The renamed file will contain the common DAC functionality shared by
> the MCP47FxBy1/2/4/8 I2C and MCP48FxBy1/2/4/8 SPI drivers. The MCP47FEB02
> driver was refactored into two modules: mcp47feb02-core.c and
> mcp47feb02-i2c.c in order to prepare the support for SPI MCP48FxBy1/2/4/8
> DAC family on top of the current implementation.
> 
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
Hi Ariana,

There are a couple of things in here unrelated to the code movement etc
and splitting of the drivers. Please pull anything like that out to
precursor patches where we can clearly see what changed.

Jonathan

> diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02-core.c
> similarity index 72%
> rename from drivers/iio/dac/mcp47feb02.c
> rename to drivers/iio/dac/mcp47feb02-core.c
> index a823c2a673a26d70e5829cb587034da435af0451..e686c511d73f2be978f3a77af7a4004194e5d284 100644
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
> @@ -15,13 +15,12 @@
>  #include <linux/bits.h>
>  #include <linux/bitfield.h>
>  #include <linux/delay.h>
> +#include <linux/dev_printk.h>
>  #include <linux/err.h>
> -#include <linux/i2c.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/kstrtox.h>
>  #include <linux/module.h>
> -#include <linux/mod_devicetable.h>
>  #include <linux/mutex.h>
>  #include <linux/property.h>
>  #include <linux/regmap.h>
> @@ -30,11 +29,13 @@
>  #include <linux/types.h>
>  #include <linux/units.h>
>  
> +#include "mcp47feb02.h"
> +
>  /* Register addresses must be left shifted with 3 positions in order to append command mask */
>  #define MCP47FEB02_DAC0_REG_ADDR			0x00
>  #define MCP47FEB02_VREF_REG_ADDR			0x40
>  #define MCP47FEB02_POWER_DOWN_REG_ADDR			0x48
> -#define MCP47FEB02_DAC_CTRL_MASK			GENMASK(1, 0)
> +#define MCP47FEB02_CMD_MASK				GENMASK(1, 0)

These renames don't belong in a patch doing anything else. Please break
them out as a precursor. 

>  
>  #define MCP47FEB02_GAIN_CTRL_STATUS_REG_ADDR		0x50
>  #define MCP47FEB02_GAIN_BIT_MASK			BIT(0)
> @@ -53,7 +54,7 @@
>  #define DAC_CTRL_MASK(ch)				(GENMASK(1, 0) << (2 * (ch)))
>  #define DAC_CTRL_VAL(ch, val)				((val) << (2 * (ch)))
>  
> -/* Gain Control and I2C Slave Address Reguster fields */
> +/* Gain Control and I2C Slave Address Register fields */

This is also an unrelated change. Precursor patch.

>  #define DAC_GAIN_MASK(ch)				(BIT(0) << (8 + (ch)))
>  #define DAC_GAIN_VAL(ch, val)				((val) << (8 + (ch)))
