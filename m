Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C79E3B4EAC;
	Mon, 27 Apr 2026 10:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777284878; cv=none; b=kNrCivbAeEIy6FOsx5qp7HM/lhD1XASUIhHMUTISHka6VXU8r7tNsWAhA/072Rvbo0W8iDOdgZrpoKyfYJV58XsG/hRypwiAYeVNPoAUZEXM2IIaUUN89eqel73/CIADA2S24MvUO1X89FbXumUYkuqCluL5DoM+bGBlhOedvv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777284878; c=relaxed/simple;
	bh=ymu0eUd3YK4oXzP/gRhZgOL4MPCC2MmIsenK9sXvDSs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D7clIRsb92LsS0J763KG+TI+a7AyWm/sAwWV+TshwHqXWFh40+z3WC9ePMn0iFYYz9Dwr3ka9FAvZsI8gQu1K9nP0qCbG45uUW7Kaq44YXuKA+A+ZaK5xFz6KD7fL0Daej6RoMxPGWceXrv9zKyYK7v5sL/OkZQ7fWBUxxxkxmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYd1Ij22; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYd1Ij22"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B52C19425;
	Mon, 27 Apr 2026 10:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777284877;
	bh=ymu0eUd3YK4oXzP/gRhZgOL4MPCC2MmIsenK9sXvDSs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mYd1Ij22Y+mulmLhL1lg0ODbAtmnEqfchj4tyLA2XSj0a25y7koiZqOhOTuvZU3PQ
	 uVA/naNYn+Yq7/1Kw3pIAdNs9K93c+fjCFRExj4iH6KIf97jiUgObmLdaXXKsQL+9V
	 4fqREuRaiaXKDS3Ne5HGp94QzIWKsTmYMyFxDfag6554VPRQn+mmcG6B9cy50GqgSS
	 RYfT9gp/Ab4ZLdgcyXqxxlJYZ3JHdaOChZcNDHTEF1+3VK+R+R9oUnGEf7KFFGsh4U
	 ni1APS7bVDnJm6kE8+UH43jAi+lkPT1Y869lIA8PU2KiPCG21F0xZlcoCDGZ5VbvbD
	 MZBjWi+i14bkA==
Date: Mon, 27 Apr 2026 11:14:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, "David Lechner" <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@oss.qualcomm.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v9 0/2] Add support for AD5706R DAC
Message-ID: <20260427111425.2d7d693a@jic23-huawei>
In-Reply-To: <20260427-dev_ad5706r-v9-0-a8e4cae499d7@analog.com>
References: <20260427-dev_ad5706r-v9-0-a8e4cae499d7@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Apr 2026 14:23:15 +0800
Alexis Czezar Torreno <alexisczezar.torreno@analog.com> wrote:

> This series adds support for the Analog Devices AD5706R, a 4-channel
> 16-bit current output digital-to-analog converter with SPI interface.
> 
> This initial driver provides basic DAC functionality through standard
> IIO interfaces.
> 
> Datasheet: https://www.analog.com/en/products/ad5706r.html
Doesn't matter as no need to have tags in cover letter anyway, but that's
a tag so no line break before the SoB.
> 
> Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>

Applied to the testing branch of iio.git.  I'll push that out as togreg
in a day or two once 0-day has had a play with it.

thanks,

Jonathan

> ---
> Changes in v9:
> - Kconfig: changed REGMAP_SPI to REGMAP
> - updated cover letter and driver commit message
> - Link to v8: https://lore.kernel.org/r/20260417-dev_ad5706r-v8-0-ef87dff62b57@analog.com
> 
> Changes in v8:
> - driver:
>   - changed DAC_CODE from BIT(16) to GENMASK(15,0)
>   - removed defines for single/multi byte, replaced with number
>   - adjusted regmap_write to use if/else similar to read()
>   - reverted in_range back to open code equivalent, removed minmax.h
> - Link to v7: https://lore.kernel.org/r/20260410-dev_ad5706r-v7-0-af93a4caa186@analog.com
> 
> Changes in v7:
> - driver:
>   - Moved/added size validation before data access in write()/read()
> - Link to v6: https://lore.kernel.org/r/20260410-dev_ad5706r-v6-0-f3fda5921fe4@analog.com
> 
> Changes in v6:
> - driver:
>   - Added size validation in regmap_write()
>   - Used &st->tx_buf[0] consistently in _be32/be16 calls
>   - Added missing indent in AD5706R_CHAN
> - Link to v5: https://lore.kernel.org/r/20260407-dev_ad5706r-v5-0-a4c7737b6ae9@analog.com
> 
> Changes in v5:
> - dt-bindings:
>   - Changed out-en-gpios to enable-gpios
> - driver:
>   - Kconfig: Added select REGMAP_SPI
>   - Headers: Removed device.h, errno.h, string.h; added dev_printk.h
>   - Use IIO_DMA_MINALIGN instead of ARCH_DMA_MINALIGN
>   - Replaced memcpy/memset with put_unaligned_be* for consistency
>   - Added struct device *dev shorthand in probe()
>   - other minor style edits
> - Link to v4: https://lore.kernel.org/r/20260401-dev_ad5706r-v4-0-a785184a8d53@analog.com
> 
> Changes in v4:
> - dt-bindings:
>   - Reverted pwm and gpio entries.
>   - Added missing power supply properties
>   - Clocks not added back as they were driver specific, not device
>     properties
> - driver:
>   - Added missing includes
>   - Converted to use regmap with custom SPI bus implementation.
>     spi_write_then_read not applied as suggested, prevents future
>     need to change SPI speed
>   - removed driver speciifc mutex/guards in favor of regmap internal
>     locking
>   - Minor style cleanups
> - Link to v3: https://lore.kernel.org/r/20260318-dev_ad5706r-v3-0-5d078f41e988@analog.com
> 
> Changes in v3:
> - Added MAINTAINERS entry, files added on each patch
> - dt-bindings:
>   - Added allOf and ref to spi-peripheral-props.yaml
>   - Changed additionalProperties to unevaluatedProperties
>   - Added avdd-supply property and added it to required
> - driver:
>   - Removed redundant includes, added respective includes of APIs used
>   - Simplified bit manipulation in SPI read/write, used feedback from v2
>   - Fixed inconsistent trailing commas in device ID tables
>   - Removed zero initialization in spi_device_id
> - Link to v2: https://lore.kernel.org/r/20260311-dev_ad5706r-v2-0-f367063dbd1b@analog.com
> 
> Changes in v2:
> - Stripped driver down to basic DAC functionality (read/write raw,
>   read-only scale) as suggested.
> - Removed PWM (LDAC), GPIO (reset/shutdown), clock generator,
>   SPI engine frequency switching, debugfs streaming, and all
>   custom ext_info sysfs attributes
> - Removed regmap, IIO_BUFFER, and iio/sysfs.h dependencies
> - Simplified SPI read/write to use standard spi_sync_transfer
>   without clock mode logic
> - Scale reports default 50mA range as read-only using
>   IIO_VAL_FRACTIONAL_LOG2; writable range selection deferred
>   to future follow-up series
> - Simplified DT binding to only require compatible, reg, and
>   spi-max-frequency
> - Link to v1: https://lore.kernel.org/r/20260220-dev_ad5706r-v1-0-7253bbd74889@analog.com
> 
> ---
> Alexis Czezar Torreno (2):
>       dt-bindings: iio: dac: Add ADI AD5706R
>       iio: dac: ad5706r: Add support for AD5706R DAC
> 
>  .../devicetree/bindings/iio/dac/adi,ad5706r.yaml   | 105 +++++++++
>  MAINTAINERS                                        |   8 +
>  drivers/iio/dac/Kconfig                            |  11 +
>  drivers/iio/dac/Makefile                           |   1 +
>  drivers/iio/dac/ad5706r.c                          | 253 +++++++++++++++++++++
>  5 files changed, 378 insertions(+)
> ---
> base-commit: 3674f3ca92730d9a07b42b311f1337d83c4d5605
> change-id: 20260220-dev_ad5706r-2105e1dd29ab
> 
> Best regards,

