Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795650429;
	b=Ht30ASxTMiHNflvqJ3Ub4qG9Gql29f94qy9T5FI3hSD6OJ8BYc6FkTG9Mhwr+V3e1KcX
	 Fhf0Px1egm3Z7cF4uHskTOsuWMipp6SM5KXCVuBmmT0iC3QN6jz4VeI+GMYB/N2qRwY0j
	 ms6I34LmnRv/Bf75gp8xJZsUhZdyJR4Mq66bW4XyhQ7YoEn+pAA1PAd7E4r0N3WwzNx37
	 AxFyXf97drPi7ToTxtaGOVhraD6Dq01N7l5gMRXYGnnAz6KpGO68XWM8njYKTgfLeXCXy
	 1RKYs7LLPMKRSqUQXVQQ98a3yaqoN0+8F16oY/Ou25jq1RnZdx4xkDnZjzzdBoGh+hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795650429;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=BxJQ9RTde9zhtYKI8cDL1uBMhNAR5lSVHRue2TFjuBY=;
	b=BBG7WUxe/KmMU2fI7LHD6W9Dr6T9odxUhgzsFoyHX1KYzHibo5VRiKRWij/a58RS5LIx
	 KsQEzKlvXVh3FJ3deESuDcajPizxXfH8kAB/HAUU1vbkDHnVGRCItjhLGkYkYXhdbwsb6
	 +FugtCgMO5/xP9uXSbNqCUVECDTkcAlKzTovomJf0FxmjjRgpmWIcBxIlH6lKXbaw22az
	 2PBapaW8y0jEdAZf0FHNKLcmeBdD4TxDAhIziZlAF0SgLFE0G2qnAeseDgOZciiEY6q6Z
	 QwLRP00Bi4t5RdnY4f6V61KBeG8d3EbcR1SV13e/iSoFWycRZAJTkskYKTRW0veMypg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fyu3kSUD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11984606A31E;
	Wed, 25 Nov 2026 23:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fyu3kSUD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A8D1F000C4;
	Wed, 25 Nov 2026 23:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795650428;
	bh=BxJQ9RTde9zhtYKI8cDL1uBMhNAR5lSVHRue2TFjuBY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Fyu3kSUDWUlSJ2StkcFRKL7LK1Bh3C01Gc/V/vjkA1XtDsD8OzFmZtMCdsSfLD+Fo
	 yB/TRSFqHcSiJm0GvuRZJGvWbSGCq5sDI4ajjrl85BulFinRouDkc75cho8Wu7xY6Q
	 3xqV2CbyI340hCAmYyynoHOKwiGfpI3sm1LdlJQpVIojmUfu6+7y9UhdcJMX4WVsIV
	 NfuQFTp+ZzV3vBXeT2iSc+dTXeGcYImZmpaHpov18re/j0MirPqhglohTyf0nTeHSg
	 2MD2619bWQMV1zxzCBUpDp8Stf/OJDk4M7FD11UH1a5P4MMgUqySsDXiGpIyMO9gSW
	 LwOKRUylHgw6A==
Date: Wed, 25 Nov 2026 23:46:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Joseph Telaak <joseph@telaak.dev>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Peter Rosin
 <peda@lysator.liu.se>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@analog.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 6/6] iio: potentiometer: mcp4018: Add Analog Devices
 AD5246
Message-ID: <20261125234658.30fc80b4@jic23-hlaptop>
In-Reply-To: <20261125-iio-ad5246-v2-6-8feeb630f0b6@telaak.dev>
References: <20261125-iio-ad5246-v2-0-8feeb630f0b6@telaak.dev>
	<20261125-iio-ad5246-v2-6-8feeb630f0b6@telaak.dev>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Nov 2026 15:22:33 -0500
Joseph Telaak <joseph@telaak.dev> wrote:

> The AD5246 is a 128-position digital rheostat with the same I2C
> interface as the MCP4017/18/19: a single data byte writes the 7-bit
> wiper and a single-byte read returns it, with no command byte. Add its
> four resistance options.
> 
> Its resistance is D/128 of the end-to-end value, where the MCP401x's is
> D/127. Name the driver for the MCP4018 and compatible parts.
> 
> The misc ad525x_dpot driver also knows the AD5246, by I2C id only and
> through its own sysfs files. It can't provide an IIO channel, which a
> consumer such as dpot-dac needs. The AD5272 is likewise in both drivers.

For this I want a view from the analog devices folk. What's the plan for
that misc driver?

However I'm not going to let a custom misc driver block this in the
meantime so that is mostly a long term question / satisfying my curiosity
thing.

> 
> Tested on an AD5246 at 0x2e, described as adi,ad5246-010 with a
> vdd-supply. It probes, out_resistance0_raw_available reads [0 1 127] and
> out_resistance_scale reads 78.125000000. Raw writes of 0, 64, 100 and
> 127 read back the same value, and 128 is rejected. Writes through
> iio_write_channel_raw() from an in-kernel consumer of the channel read
> back as well (127, 38, 0 and 76).
> 
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/AD5246.pdf
> Signed-off-by: Joseph Telaak <joseph@telaak.dev>
> ---
>  drivers/iio/potentiometer/Kconfig   | 10 ++++++----
>  drivers/iio/potentiometer/mcp4018.c | 24 ++++++++++++++++++++++--
>  2 files changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/potentiometer/Kconfig b/drivers/iio/potentiometer/Kconfig
> index e6a9a3c67845..05833455e82a 100644
> --- a/drivers/iio/potentiometer/Kconfig
> +++ b/drivers/iio/potentiometer/Kconfig
> @@ -70,12 +70,14 @@ config MAX5487
>  	  module will be called max5487.
>  
>  config MCP4018
> -	tristate "Microchip MCP4017/18/19 Digital Potentiometer driver"
> +	tristate "Microchip MCP4018 and compatible Digital Potentiometer driver"
>  	depends on I2C
>  	help
> -	  Say yes here to build support for the Microchip
> -	  MCP4017, MCP4018, MCP4019
> -	  digital potentiometer chips.
> +	  Say yes here to build support for the following digital
> +	  potentiometers and rheostats:
> +
> +	  - Analog Devices AD5246
> +	  - Microchip MCP4017, MCP4018, MCP4019
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called mcp4018.
> diff --git a/drivers/iio/potentiometer/mcp4018.c b/drivers/iio/potentiometer/mcp4018.c
> index 75a63a01acef..b593082db4bb 100644
> --- a/drivers/iio/potentiometer/mcp4018.c
> +++ b/drivers/iio/potentiometer/mcp4018.c
> @@ -1,12 +1,15 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Industrial I/O driver for Microchip digital potentiometers
> + * Industrial I/O driver for Microchip MCP4018 and compatible digital
> + * potentiometers
>   * Copyright (c) 2018  Axentia Technologies AB
>   * Author: Peter Rosin <peda@axentia.se>
>   *
>   * Datasheet: http://www.microchip.com/downloads/en/DeviceDoc/22147a.pdf
> + * Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/AD5246.pdf
>   *
>   * DEVID	#Wipers	#Positions	Resistor Opts (kOhm)
> + * ad5246	1	128		5, 10, 50, 100
>   * mcp4017	1	128		5, 10, 50, 100
>   * mcp4018	1	128		5, 10, 50, 100
>   * mcp4019	1	128		5, 10, 50, 100
> @@ -31,6 +34,10 @@ struct mcp4018_cfg {
>  };
>  
>  enum mcp4018_type {
> +	AD5246_005,
> +	AD5246_010,
> +	AD5246_050,
> +	AD5246_100,
>  	MCP4018_502,
>  	MCP4018_103,
>  	MCP4018_503,
> @@ -38,6 +45,11 @@ enum mcp4018_type {
>  };
>  
>  static const struct mcp4018_cfg mcp4018_cfg[] = {
> +	/* The AD5246's resistance is D / 128 of the end-to-end value */
> +	[AD5246_005] = { .kohms =   5, .div = 128, },
> +	[AD5246_010] = { .kohms =  10, .div = 128, },
> +	[AD5246_050] = { .kohms =  50, .div = 128, },
> +	[AD5246_100] = { .kohms = 100, .div = 128, },
>  	[MCP4018_502] = { .kohms =   5, .div = MCP4018_WIPER_MAX, },
>  	[MCP4018_103] = { .kohms =  10, .div = MCP4018_WIPER_MAX, },
>  	[MCP4018_503] = { .kohms =  50, .div = MCP4018_WIPER_MAX, },
> @@ -130,6 +142,10 @@ static const struct iio_info mcp4018_info = {
>  }
>  
>  static const struct i2c_device_id mcp4018_id[] = {
> +	MCP4018_ID_TABLE("ad5246-005", AD5246_005),
> +	MCP4018_ID_TABLE("ad5246-010", AD5246_010),
> +	MCP4018_ID_TABLE("ad5246-050", AD5246_050),
> +	MCP4018_ID_TABLE("ad5246-100", AD5246_100),
>  	MCP4018_ID_TABLE("mcp4017-502", MCP4018_502),
>  	MCP4018_ID_TABLE("mcp4017-103", MCP4018_103),
>  	MCP4018_ID_TABLE("mcp4017-503", MCP4018_503),
> @@ -152,6 +168,10 @@ MODULE_DEVICE_TABLE(i2c, mcp4018_id);
>  }
>  
>  static const struct of_device_id mcp4018_of_match[] = {
> +	MCP4018_COMPATIBLE("adi,ad5246-005", AD5246_005),
> +	MCP4018_COMPATIBLE("adi,ad5246-010", AD5246_010),
> +	MCP4018_COMPATIBLE("adi,ad5246-050", AD5246_050),
> +	MCP4018_COMPATIBLE("adi,ad5246-100", AD5246_100),
>  	MCP4018_COMPATIBLE("microchip,mcp4017-502", MCP4018_502),
>  	MCP4018_COMPATIBLE("microchip,mcp4017-103", MCP4018_103),
>  	MCP4018_COMPATIBLE("microchip,mcp4017-503", MCP4018_503),
> @@ -214,5 +234,5 @@ static struct i2c_driver mcp4018_driver = {
>  module_i2c_driver(mcp4018_driver);
>  
>  MODULE_AUTHOR("Peter Rosin <peda@axentia.se>");
> -MODULE_DESCRIPTION("MCP4018 digital potentiometer");
> +MODULE_DESCRIPTION("Microchip MCP4018 and compatible Digital Potentiometer driver");
>  MODULE_LICENSE("GPL v2");
> 

