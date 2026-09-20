Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F6A48820B;
	Sun, 20 Sep 2026 22:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789944771; cv=none; b=mq+nP4VwOKAJO6SV3RWRnqWRfiHL7cHZHjcK2wRi/SYHqhlJDub4sVXC9GuQIUhkeW0BmzrONYBIB71RxxXnO1sZnno57TQUVpYfFIf09ov/32MD1hTnVIPz3jSucrMLDkQMFHX7fs7WZgKc8/oEchqwTBKyAMo7U8LDA1nuPlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789944771; c=relaxed/simple;
	bh=CK7YR4aMgsSLwgdiVFdcBBNbYFn55i7WY6nqRUkmbRY=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=ho9z3pxXf+XCw3gxmPYBi3QSgzcEfs64n/pmCzBgJgrvRty/lfhlCCWBryMNZaBiJ3f5kMpqLfeRwtMOcTLpV2u/CbBshdad2e5iedP5nQ02R8xDA8GV48L8wikLUEsibY0qlpNJqL3AQFYyRg1VwmqCP1Nc3wV5uj2W4/21Uq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fcivqyxd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fcivqyxd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667E81F0089D;
	Sun, 20 Sep 2026 22:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789944769;
	bh=If4SjmggGq429oG9m/7fSBP1RQJepPyPtI5thQxxvqY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Fcivqyxd0II+tGENUnI5IzWljEhzfCKBBmH4Oh/bmeFY/SbyDXMZ0SbTwuIzEv1lJ
	 qbRrgdP3q8KWRkIDrVVJiTElBSLdEU0AOnM72roMYwvcM1XL1X0JRuRdsuKHgt9AtK
	 gFPZ1WZ5CmwSxmn9IQa0vXS+Dq4Dst7IvNpgQoAaDbVyE0GzIHq2y3yJ8SPjzs7Z63
	 ivVLZYZRcAqClIZ8Z42aFld/m8CCZaiEp1Q+wMPFLyMdQtL/LpdupbrWjxhH1BjMky
	 F+SDytN/codDN2r2WWx3fvA1KADTvxp3OFc63r6tq5iefmcjA9hEuPlBbUSDCMFk8Q
	 wFGeeim0rP9vQ==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 09/11] iio: dac: mcp47feb02: refactor MCP47FEB02 I2C
 driver into two modules
From: Jonathan Cameron <jic23@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260918-mcp47feb02_refactor-v7-9-82ca794eafe2@microchip.com>
References: <20260918-mcp47feb02_refactor-v7-0-82ca794eafe2@microchip.com>
 <20260918-mcp47feb02_refactor-v7-9-82ca794eafe2@microchip.com>
Date: Sun, 20 Sep 2026 23:52:29 +0100
Message-Id: <178994474989.706584.9211319682095053097.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3932;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=CK7YR4aMgsSLwgdiVFdcBBNbYFn55i7WY6nqRUkmbRY=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqsGO9k4oDftq2ZoLNtVITBWwmM4pVyDMDs/5EO
 tsBp78dpuWJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCarBjvREcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiHalD/9qR8mtEPEc+CahwUS5FTwI4tZHitMm3W3uJlxA+mn4kuB
 du2rogSvQnW8XLUDAPySl9za6ilCqpjB1FupsGdZSwaRZr2ms6XetuIAJrj8XvuO2UL9xeQzfKt
 mpzCaizmMk2F+QgSL8ZHINp6Gxf7/cwZfkatpkBASRL3TyIvbpvKvslsys4rmrBtQtOY+xFFUqf
 +P8WVWmMum03+oOlMpf261MHz3RkqsmWsuU8aLSOux7It5P/b9vTSVuWp36kNzlZdXMJjW7OQ7u
 01JP1TFW4Xtf1ranZrFFjVMUoVGSOO46YneK4zu6ODtUvrA/E++qA72LUbrtZvvFGhA9VyygLsY
 SIH+UUn0WbowPzbf1WXPNvuDAGWHMSPlIh0U9/YdrrSM3KtGzzLeWV3/BM+BJRDSik2kvvpMjWV
 l/YYPPndvQgcUYjZue+Ik6pofKyUH6Pyln0rur8a5LZM6fvrDEyq/s6hVzyjUQCJcnBFQsVtnbg
 8WQX+7aoRsVo3rubHVe5+6/7OTd0GNNjuNKFreGDQl3sqo2fpEZ6GAURPP06vtJl9ERWLw1pTw9
 CZAkubpecTBMOQTEEEnm1e81SGOC/JDM+v0DYDSWt1JOVCejmDx+ZIJ+96+gkwuE9kQEaMQ/1WQ
 w4QMeSjM0bBU4SKTr1oLx0lEe53ZJnxPc+TDfxQ==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Prepare the driver for the bus-specific code by refactoring into separate
> files. The renamed file will contain the common DAC functionality shared by
> the MCP47FxBy1/2/4/8 I2C and MCP48FxBy1/2/4/8 SPI drivers. The MCP47FEB02
> driver was refactored into two modules: mcp47feb02-core.c and
> mcp47feb02-i2c.c in order to prepare the support for SPI MCP48FxBy1/2/4/8
> DAC family on top of the current implementation.
> 
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>

Sashiko makes a point about change of Kconfig symbol and make
oldconfig etc. Not ideal but we've done this before and I don't
think it has proved a signficant problem in practice.  We could
carry an extra symbol to avoid the problem but it is going to
be a long term bit of mess so I think what you have here is the
way to go.

Otherwise a few small things inline.


> diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02-core.c
> similarity index 73%
> rename from drivers/iio/dac/mcp47feb02.c
> rename to drivers/iio/dac/mcp47feb02-core.c
> index 7312c2c96141..91fad42df216 100644
> --- a/drivers/iio/dac/mcp47feb02.c
> +++ b/drivers/iio/dac/mcp47feb02-core.c

>  				      unsigned int val)
> @@ -440,8 +235,6 @@ static int mcp47feb02_write_to_eeprom(struct mcp47feb02_data *data, unsigned int
>  	 * Wait until the currently occurring EEPROM Write Cycle is completed.
>  	 * Only serial commands to the volatile memory are allowed.
>  	 */
> -	guard(mutex)(&data->lock);
> -

What is this change doing in this patch?  Looking at the code I think
is indeed a good thing to do, just shouldn't be hidden down in here.

Break this out as a separate precursor patch.

>  	ret = regmap_read_poll_timeout(data->regmap, MCP47FEB02_GAIN_CTRL_STATUS_REG_ADDR,
>  				       eewa_val,
>  				       !(eewa_val & MCP47FEB02_GAIN_BIT_STATUS_EEWA_MASK),
> @@ -467,6 +260,8 @@ static ssize_t store_eeprom_store(struct device *dev, struct device_attribute *a
>  	if (!state)
>  		return len;
>  
> +	guard(mutex)(&data->lock);
> +
>  	/*
>  	 * Verify DAC Wiper and DAC Configuration are unlocked. If both are disabled,
>  	 * writing to EEPROM is available.
> @@ -575,12 +370,10 @@ static int mcp47feb02_resume(struct device *dev)
>  	guard(mutex)(&data->lock);
>  
>  	for_each_set_bit(ch, &data->active_channels_mask, data->phys_channels) {
> -		u8 pd_mode;
>  		u32 mask;
>  		int ret;
>  
>  		data->chdata[ch].powerdown = false;
> -		pd_mode = data->chdata[ch].powerdown_mode + 1;
>  
>  		ret = regmap_write(data->regmap, REG_ADDR(ch), data->chdata[ch].dac_data);
>  		if (ret)
> @@ -588,7 +381,7 @@ static int mcp47feb02_resume(struct device *dev)
>  
>  		mask =  MCP47FEB02_VREF_PD_MASK(ch);
>  		ret = regmap_update_bits(data->regmap, MCP47FEB02_VREF_REG_ADDR,
> -					 mask, field_prep(mask, pd_mode));
> +					 mask, field_prep(mask, data->chdata[ch].ref_mode));
>  		if (ret)
>  			return ret;
>  
> @@ -668,7 +461,7 @@ static ssize_t mcp47feb02_write_powerdown(struct iio_dev *indio_dev, uintptr_t p
>  	return len;
>  }
>  
> -static DEFINE_SIMPLE_DEV_PM_OPS(mcp47feb02_pm_ops, mcp47feb02_suspend, mcp47feb02_resume);
> +EXPORT_SIMPLE_DEV_PM_OPS(mcp47feb02_pm_ops, mcp47feb02_suspend, mcp47feb02_resume);

Sashiko:
[Severity: Low]
Does this macro export the PM ops symbol without the intended IIO_MCP47FEB02
namespace?

The driver establishes a dedicated namespace IIO_MCP47FEB02 for its core
exported symbols, but mcp47feb02_pm_ops is exported using
EXPORT_SIMPLE_DEV_PM_OPS, which places it into the global namespace.

Should this use EXPORT_NS_SIMPLE_DEV_PM_OPS(mcp47feb02_pm_ops,
mcp47feb02_suspend, mcp47feb02_resume, IIO_MCP47FEB02) instead to
maintain namespace encapsulation?
-
That is a good spot.  Yes, this should use the NS variant.


Thanks,

Jonathan

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
