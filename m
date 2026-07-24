Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8B718C2C;
	Fri, 24 Jul 2026 00:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784851957; cv=none; b=REKKfRW+sioP8i8Ihl5qL6AX1sOe8xk/y/6u0UOijW2QXMRAJS1/t0T5eTjYFKaqkzUJa1sQ4SSR3cD+b9GM1tWoQihS/rqN1IeKQ7DlQX2shhGwnhxzkt1EZolEX18Ez/y27FsXa5s0c3cDGCt4vuVCFXq8IwjfqIi+0Pa10Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784851957; c=relaxed/simple;
	bh=RijWPijSELfAMNskmeymRlmzvI/vbXDNB4JaFLLO5fc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bdkW2r6OB1ZUDtH5wzV2A1LvG+xT5kQ0lIrur5COhjqEXFxIfclqFUsnjzzqGYug5aBrZIdbSKtYM5dzy0t/LU7g5M+JeDhhwKtPs5mDbGnKyjW8AafrlHNvFpYPclU8oNCLxyuYrM8kARjNs2z4a+LM4PojHqvPMBG95hQqK8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMukKwYn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMukKwYn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0428A1F000E9;
	Fri, 24 Jul 2026 00:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784851956;
	bh=j9ytTub8B5/hmzLBElh6YnxbvziYVLhMAPUYdY5veYk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BMukKwYnknPeiALCDznIjvAdXtECFO4GbMB83Vm0EnxEqsyOmwHhESsdktLYJzdkh
	 ZM7Qdjx60hfvXCalhz1tRkHwBWX418lvsT4ElINOoBCp6Td24ZzI7dWTyt86rxSpVr
	 2dBh43mi/BCRMH3uVphXM+aENlt7fnQH4PHR1TR1PRd6mg7Y0e5PkLkkfyiq5nXoUQ
	 ziu3koqDjSA7kcZVJtWiYBQ/4lrfpBHzDVb4+X3DjmeYM1oOFo+4ws2Dfk9eW0Zlg2
	 l8XrXgbFXN7fD4r1wEIEAG/bjnT5Ip5D7EWvlngWx7DPo+ckSv1HLmkbVDwCmcGpZP
	 zxLPrsxWoQ0JA==
Date: Fri, 24 Jul 2026 01:12:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Radu Sabau <radu.sabau@analog.com>, Jorge Marques
 <jorge.marques@analog.com>, Matti Vaittinen <mazziesaccount@gmail.com>,
 Jonathan Santos <Jonathan.Santos@analog.com>, Jishnu Prakash
 <jishnu.prakash@oss.qualcomm.com>, <linux-iio@vger.kernel.org>,
 <linux@analog.com>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 3/4] iio: adc: ade9000: add support for ADE9078
Message-ID: <20260724011229.0cebaf62@jic23-huawei>
In-Reply-To: <20260720110754.7674-4-antoniu.miclaus@analog.com>
References: <20260720110754.7674-1-antoniu.miclaus@analog.com>
	<20260720110754.7674-4-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jul 2026 14:07:46 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The ADE9078 is a polyphase energy metering device that is register
> compatible with the ADE9000. The main differences relevant to the driver
> are the absence of the on-chip dip/swell detection and slightly different
> full-scale ADC codes.
> 
> Add a dedicated channel table that omits the swell/dip voltage events and
> a matching chip_info describing the ADE9078 full-scale codes. The RMS
> voltage channel macro is split into a shared base and two variants so the
> event-less table can reuse the common definition.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Hi Antoniu. Just a couple of minor comments below.

Jonathan

> ---
>  drivers/iio/adc/Kconfig   |  14 ++---
>  drivers/iio/adc/ade9000.c | 121 +++++++++++++++++++++++++-------------
>  2 files changed, 86 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index d1b198cb8a80..33f2c281b1aa 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -573,20 +573,20 @@ config AD9467
>  	  called ad9467.
>  
>  config ADE9000
> -	tristate "Analog Devices ADE9000 Multiphase Energy, and Power Quality Monitoring IC Driver"
> +	tristate "Analog Devices ADE9000/ADE9078 Multiphase Energy, and Power Quality Monitoring IC Driver"
>  	depends on SPI
>  	select REGMAP_SPI
>  	select IIO_BUFFER
>  	select IIO_KFIFO_BUF
>  	help
> -	  Say yes here to build support for the Analog Devices ADE9000,
> -	  a highly accurate, multiphase energy and power quality monitoring
> -	  integrated circuit.
> +	  Say yes here to build support for the Analog Devices ADE9000 and
> +	  ADE9078, highly accurate, multiphase energy and power quality
> +	  monitoring integrated circuits.

Do you think you are likely to end up adding a bunch more supported parts
to this driver over time?  Might be worth moving to a generic 'and similar'
title and a bulleted list in here if so.
>  
> -	  The device features high-precision analog-to-digital converters
> +	  The devices feature high-precision analog-to-digital converters
>  	  and digital signal processing to compute RMS values, power factor,
> -	  frequency, and harmonic analysis. It supports SPI communication
> -	  and provides buffered data output through the IIO framework.
> +	  frequency, and harmonic analysis. They support SPI communication
> +	  and provide buffered data output through the IIO framework.
>  
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called ade9000.
> diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
> index 38a5c7e043b3..0de55b7ad1ea 100644
> --- a/drivers/iio/adc/ade9000.c
> +++ b/drivers/iio/adc/ade9000.c
> @@ -502,7 +502,7 @@ static const struct iio_chan_spec_ext_info ade9000_ext_info[] = {
>  	.scan_index = -1						\
>  }
>  
> -#define ADE9000_ALTVOLTAGE_RMS_CHANNEL(num) {				\
> +#define ADE9000_ALTVOLTAGE_RMS_CHANNEL_BASE(num)			\

I'd prefer we just duplicated the common stuff.
It's not big enough to be worth nesting multiple macros to fill up the structure

>  	.type = IIO_ALTVOLTAGE,						\
>  	.channel = num,							\
>  	.address = ADE9000_ADDR_ADJUST(ADE9000_REG_AVRMS, num),		\
> @@ -512,9 +512,18 @@ static const struct iio_chan_spec_ext_info ade9000_ext_info[] = {
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
>  			      BIT(IIO_CHAN_INFO_SCALE) |		\
>  			      BIT(IIO_CHAN_INFO_CALIBBIAS),		\
> +	.scan_index = -1
> +
> +/* With swell/dip (sag) events - ADE9000 only */
> +#define ADE9000_ALTVOLTAGE_RMS_CHANNEL(num) {				\
> +	ADE9000_ALTVOLTAGE_RMS_CHANNEL_BASE(num),			\
>  	.event_spec = ade9000_rms_voltage_events,			\
>  	.num_event_specs = ARRAY_SIZE(ade9000_rms_voltage_events),	\
> -	.scan_index = -1						\
> +}
> +
> +/* Without swell/dip events - parts lacking DIP_LVL/SWELL_LVL hardware */
> +#define ADE9000_ALTVOLTAGE_RMS_CHANNEL_NO_EVENTS(num) {			\
> +	ADE9000_ALTVOLTAGE_RMS_CHANNEL_BASE(num),			\
>  }
>  
>  #define ADE9000_POWER_ACTIVE_CHANNEL(num) {				\
> @@ -598,48 +607,65 @@ static const struct iio_chan_spec_ext_info ade9000_ext_info[] = {
>  	.scan_index = -1						\
>  }
>  
> -static const struct iio_chan_spec ade9000_channels[] = {
> -	/* Phase A channels */
> -	ADE9000_CURRENT_CHANNEL(ADE9000_PHASE_A_NR),
> -	ADE9000_VOLTAGE_CHANNEL(ADE9000_PHASE_A_NR),
> -	ADE9000_ALTCURRENT_RMS_CHANNEL(ADE9000_PHASE_A_NR),
> -	ADE9000_ALTVOLTAGE_RMS_CHANNEL(ADE9000_PHASE_A_NR),
> -	ADE9000_POWER_ACTIVE_CHANNEL(ADE9000_PHASE_A_NR),
> -	ADE9000_POWER_REACTIVE_CHANNEL(ADE9000_PHASE_A_NR),
> -	ADE9000_POWER_APPARENT_CHANNEL(ADE9000_PHASE_A_NR),
> -	ADE9000_ENERGY_ACTIVE_CHANNEL(ADE9000_PHASE_A_NR, ADE9000_REG_AWATTHR_LO),
> -	ADE9000_ENERGY_APPARENT_CHANNEL(ADE9000_PHASE_A_NR, ADE9000_REG_AVAHR_LO),
> -	ADE9000_ENERGY_REACTIVE_CHANNEL(ADE9000_PHASE_A_NR, ADE9000_REG_AFVARHR_LO),
> -	ADE9000_POWER_FACTOR_CHANNEL(ADE9000_PHASE_A_NR),
> -	/* Phase B channels */
> -	ADE9000_CURRENT_CHANNEL(ADE9000_PHASE_B_NR),
> -	ADE9000_VOLTAGE_CHANNEL(ADE9000_PHASE_B_NR),
> -	ADE9000_ALTCURRENT_RMS_CHANNEL(ADE9000_PHASE_B_NR),
> -	ADE9000_ALTVOLTAGE_RMS_CHANNEL(ADE9000_PHASE_B_NR),
> -	ADE9000_POWER_ACTIVE_CHANNEL(ADE9000_PHASE_B_NR),
> -	ADE9000_POWER_REACTIVE_CHANNEL(ADE9000_PHASE_B_NR),
> -	ADE9000_POWER_APPARENT_CHANNEL(ADE9000_PHASE_B_NR),
> -	ADE9000_ENERGY_ACTIVE_CHANNEL(ADE9000_PHASE_B_NR, ADE9000_REG_BWATTHR_LO),
> -	ADE9000_ENERGY_APPARENT_CHANNEL(ADE9000_PHASE_B_NR, ADE9000_REG_BVAHR_LO),
> -	ADE9000_ENERGY_REACTIVE_CHANNEL(ADE9000_PHASE_B_NR, ADE9000_REG_BFVARHR_LO),
> -	ADE9000_POWER_FACTOR_CHANNEL(ADE9000_PHASE_B_NR),
> -	/* Phase C channels */
> -	ADE9000_CURRENT_CHANNEL(ADE9000_PHASE_C_NR),
> -	ADE9000_VOLTAGE_CHANNEL(ADE9000_PHASE_C_NR),
> -	ADE9000_ALTCURRENT_RMS_CHANNEL(ADE9000_PHASE_C_NR),
> -	ADE9000_ALTVOLTAGE_RMS_CHANNEL(ADE9000_PHASE_C_NR),
> -	ADE9000_POWER_ACTIVE_CHANNEL(ADE9000_PHASE_C_NR),
> -	ADE9000_POWER_REACTIVE_CHANNEL(ADE9000_PHASE_C_NR),
> -	ADE9000_POWER_APPARENT_CHANNEL(ADE9000_PHASE_C_NR),
> -	ADE9000_ENERGY_ACTIVE_CHANNEL(ADE9000_PHASE_C_NR, ADE9000_REG_CWATTHR_LO),
> -	ADE9000_ENERGY_APPARENT_CHANNEL(ADE9000_PHASE_C_NR, ADE9000_REG_CVAHR_LO),
> -	ADE9000_ENERGY_REACTIVE_CHANNEL(ADE9000_PHASE_C_NR, ADE9000_REG_CFVARHR_LO),
> -	ADE9000_POWER_FACTOR_CHANNEL(ADE9000_PHASE_C_NR),
> -};
> +/*
> + * Declare a full channel array. @altvoltage_rms picks the RMS voltage channel
> + * variant so parts without dip/swell hardware (e.g. ADE9078) omit those events.
> + */
> +#define ADE9000_DECLARE_CHANNELS(_name, altvoltage_rms)			      \
> +	static const struct iio_chan_spec _name[] = {			      \
> +		/* Phase A channels */					      \
> +		ADE9000_CURRENT_CHANNEL(ADE9000_PHASE_A_NR),		      \
> +		ADE9000_VOLTAGE_CHANNEL(ADE9000_PHASE_A_NR),		      \
> +		ADE9000_ALTCURRENT_RMS_CHANNEL(ADE9000_PHASE_A_NR),	      \
> +		altvoltage_rms(ADE9000_PHASE_A_NR),			      \
> +		ADE9000_POWER_ACTIVE_CHANNEL(ADE9000_PHASE_A_NR),	      \
> +		ADE9000_POWER_REACTIVE_CHANNEL(ADE9000_PHASE_A_NR),	      \
> +		ADE9000_POWER_APPARENT_CHANNEL(ADE9000_PHASE_A_NR),	      \
> +		ADE9000_ENERGY_ACTIVE_CHANNEL(ADE9000_PHASE_A_NR,	      \
> +					      ADE9000_REG_AWATTHR_LO),	      \
> +		ADE9000_ENERGY_APPARENT_CHANNEL(ADE9000_PHASE_A_NR,	      \
> +						ADE9000_REG_AVAHR_LO),	      \
> +		ADE9000_ENERGY_REACTIVE_CHANNEL(ADE9000_PHASE_A_NR,	      \
> +						ADE9000_REG_AFVARHR_LO),      \
> +		ADE9000_POWER_FACTOR_CHANNEL(ADE9000_PHASE_A_NR),	      \
> +		/* Phase B channels */					      \
> +		ADE9000_CURRENT_CHANNEL(ADE9000_PHASE_B_NR),		      \
> +		ADE9000_VOLTAGE_CHANNEL(ADE9000_PHASE_B_NR),		      \
> +		ADE9000_ALTCURRENT_RMS_CHANNEL(ADE9000_PHASE_B_NR),	      \
> +		altvoltage_rms(ADE9000_PHASE_B_NR),			      \
> +		ADE9000_POWER_ACTIVE_CHANNEL(ADE9000_PHASE_B_NR),	      \
> +		ADE9000_POWER_REACTIVE_CHANNEL(ADE9000_PHASE_B_NR),	      \
> +		ADE9000_POWER_APPARENT_CHANNEL(ADE9000_PHASE_B_NR),	      \
> +		ADE9000_ENERGY_ACTIVE_CHANNEL(ADE9000_PHASE_B_NR,	      \
> +					      ADE9000_REG_BWATTHR_LO),	      \
> +		ADE9000_ENERGY_APPARENT_CHANNEL(ADE9000_PHASE_B_NR,	      \
> +						ADE9000_REG_BVAHR_LO),	      \
> +		ADE9000_ENERGY_REACTIVE_CHANNEL(ADE9000_PHASE_B_NR,	      \
> +						ADE9000_REG_BFVARHR_LO),      \
> +		ADE9000_POWER_FACTOR_CHANNEL(ADE9000_PHASE_B_NR),	      \
> +		/* Phase C channels */					      \
> +		ADE9000_CURRENT_CHANNEL(ADE9000_PHASE_C_NR),		      \
> +		ADE9000_VOLTAGE_CHANNEL(ADE9000_PHASE_C_NR),		      \
> +		ADE9000_ALTCURRENT_RMS_CHANNEL(ADE9000_PHASE_C_NR),	      \
> +		altvoltage_rms(ADE9000_PHASE_C_NR),			      \
> +		ADE9000_POWER_ACTIVE_CHANNEL(ADE9000_PHASE_C_NR),	      \
> +		ADE9000_POWER_REACTIVE_CHANNEL(ADE9000_PHASE_C_NR),	      \
> +		ADE9000_POWER_APPARENT_CHANNEL(ADE9000_PHASE_C_NR),	      \
> +		ADE9000_ENERGY_ACTIVE_CHANNEL(ADE9000_PHASE_C_NR,	      \
> +					      ADE9000_REG_CWATTHR_LO),	      \
> +		ADE9000_ENERGY_APPARENT_CHANNEL(ADE9000_PHASE_C_NR,	      \
> +						ADE9000_REG_CVAHR_LO),	      \
> +		ADE9000_ENERGY_REACTIVE_CHANNEL(ADE9000_PHASE_C_NR,	      \
> +						ADE9000_REG_CFVARHR_LO),      \
> +		ADE9000_POWER_FACTOR_CHANNEL(ADE9000_PHASE_C_NR),	      \
> +	}
> +
> +ADE9000_DECLARE_CHANNELS(ade9000_channels, ADE9000_ALTVOLTAGE_RMS_CHANNEL);
> +ADE9000_DECLARE_CHANNELS(ade9078_channels, ADE9000_ALTVOLTAGE_RMS_CHANNEL_NO_EVENTS);

Given this one would be much larger to duplicate I'm fine with the slightly
more complex macros here.

>  
>  /*
> - * Full-scale codes referred from the datasheet. These are the digital codes
> - * produced when the ADC inputs are at full scale.
> + * Full-scale codes referred from the respective datasheets. These are the
> + * digital codes produced when the ADC inputs are at full scale.

Can just use this when bring in chip info and avoid the churn.

>   */
>  static const struct ade9000_chip_info ade9000_chip_info = {
>  	.name = "ade9000",
> @@ -650,6 +676,15 @@ static const struct ade9000_chip_info ade9000_chip_info = {
>  	.pcf_full_scale_codes = 74770000,
>  };
>  
> +static const struct ade9000_chip_info ade9078_chip_info = {
> +	.name = "ade9078",
> +	.channels = ade9078_channels,
> +	.num_channels = ARRAY_SIZE(ade9078_channels),
> +	.rms_full_scale_codes = 52866837,
> +	.watt_full_scale_codes = 20823646,
> +	.pcf_full_scale_codes = 74680000,
> +};
> +
>  static const struct reg_sequence ade9000_initialization_sequence[] = {
>  	{ ADE9000_REG_PGA_GAIN, ADE9000_PGA_GAIN },
>  	{ ADE9000_REG_CONFIG0, ADE9000_CONFIG0 },
> @@ -1800,12 +1835,14 @@ static int ade9000_probe(struct spi_device *spi)
>  
>  static const struct spi_device_id ade9000_id[] = {
>  	{ .name = "ade9000", .driver_data = (kernel_ulong_t)&ade9000_chip_info },
> +	{ .name = "ade9078", .driver_data = (kernel_ulong_t)&ade9078_chip_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, ade9000_id);
>  
>  static const struct of_device_id ade9000_of_match[] = {
>  	{ .compatible = "adi,ade9000", .data = &ade9000_chip_info },
> +	{ .compatible = "adi,ade9078", .data = &ade9078_chip_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, ade9000_of_match);

