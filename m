Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEA33E556D;
	Fri, 22 May 2026 13:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779456904; cv=none; b=hl9fMta0gnq71MQ2Dl0WhsnbrjlHf6Voudqo0g9hPAVaCwyLjrsVajduYu7dogUR46MO0KTisy4H74xFHdT9Yu4EzTdItdQetLkYiWtmW54GQmUA3uFxpzRx+ZofEX2AZziGuCWwy3qQu/2fL4DggSNA11vLtRaz+9lA8mA6NnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779456904; c=relaxed/simple;
	bh=7rruZx45tOPyVbdYIEsjc7Q/7/0lV10rxnT99HlP53c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mdZFMRzlfE12Uynj1PAgmMGuozayrIM4uU+14OUiNdpRefmwYdG1XWrXocut/vzNxxF3Juw3yPjjCTSt8ihXbydL/Myw2aAKNL9KiXBAa1FKxdaeJ1oP+VpPxwctNL2YVcQAh/EYAQhXkhbu3i/et0F7xHVj+hiNoJaF41MNCF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWILQPjH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWILQPjH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AED41F000E9;
	Fri, 22 May 2026 13:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779456893;
	bh=3GpTXQIXIHdMrFeuYp7k+gWxfIegiInUYwig+1FPbQ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oWILQPjH30t19XFBTZUxvvzjTtdFz5oHPyPHr4+rJbwiv0L52s8FhhsnWka/o9UEW
	 6CeCsPShxgudQVL+GQY2S+o05CR+gtp1+ocxuIsOCuunFOu4utbzmClHJtj7QfJcjH
	 OI0RdlbKdxsCqPouShkmykPOUi7KUjGDu9pZJuo56tzTRwg2tBS8BUbMYRL4BSEK7u
	 bDFRIA2LHL77rL2HL8BpwwdQc+7/TSeFXRxNtph9Nt9gD7ZN9q/jOYehrOBOE3usWa
	 7s7FIWArjhMN1dOPkUbs+2McVfRyPzgbq407Ap3+XWAMKb5QsnudE0mHnVq8755zQd
	 aXdajXhuGbS9Q==
Date: Fri, 22 May 2026 14:34:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Liviu Stan <liviu.stan@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Antoniu
 Miclaus <antoniu.miclaus@analog.com>, Francesco Lavra
 <flavra@baylibre.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux@analog.com>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 8/8] iio: temperature: ltc2983: Add support for
 ADT7604
Message-ID: <20260522143444.4582e370@jic23-huawei>
In-Reply-To: <20260521164323.770626-9-liviu.stan@analog.com>
References: <20260521164323.770626-1-liviu.stan@analog.com>
	<20260521164323.770626-9-liviu.stan@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 19:43:01 +0300
Liviu Stan <liviu.stan@analog.com> wrote:

> The ADT7604 shares the same die as the LTC2984. It repurposes the
> custom RTD sensor type (18) as a copper trace resistance sensor
> and the custom thermistor type (27) as a leak detector, and
> removes thermocouple, diode and direct ADC sensor types.
> 
> Two new software sensor type values are introduced
> (LTC2983_SENSOR_COPPER_TRACE = 32, LTC2983_SENSOR_LEAK_DETECTOR = 33)
> that map to the hardware register values 18 and 27 respectively.
> Dedicated structs (ltc2983_copper_trace, ltc2983_leak_detector) and
> parser functions are added rather than extending the existing RTD and
> thermistor paths, as the hardware configuration bits are fully
> hardcoded and several RTD/thermistor properties would need to be
> explicitly forbidden or ignored.
> 
> Custom RTD (type 18) becomes the copper trace sensor. Sensor
> configuration bits are hardcoded to 0b1001 per the datasheet.
> Two variants are supported via the adi,copper-trace-sub-ohm DT
> property: sub-ohm traces (< 1 ohm) have bits 17:0 cleared with no
> excitation current or custom table; standard traces (> 1 ohm) have
> a required resistance-to-temperature table.
> 
> Custom thermistor (type 27) becomes the leak detector. Sensor
> configuration bits are hardcoded to 0b001. The custom table uses
> a resolution of 16 instead of 64, and is specified via the
> required adi,custom-leak-detector DT property.
> 
> Both sensor types expose an IIO_RESISTANCE channel reading from
> the resistance result register bank (0x0060-0x00AF). Added a
> "base" parameter to the LTC2983_RESULT_ADDR macro and a "base_reg"
> parameter to the ltc2983_chan_read function so we can read from
> both result register banks. The resistance register encodes the
> measured resistance with 10 fractional bits, so dividing by 1024
> gives ohms. Since the sense resistor is specified in ohms, the
> output is in ohms for both sensor types and a single 1/1024
> scale applies to both. For > 1 ohm copper traces and for leak
> detectors, a secondary channel also appears: IIO_TEMP
> (millidegrees Celsius) for copper trace and IIO_COVERAGE (percent)
> for leak detector.
> 
> The ltc2983_chip_info struct is extended with a u64 supported_sensors
> bitmask using BIT_ULL() to safely represent the new sensor type bits
> 32 and 33 on 32-bit builds. A LTC2983_SENSOR_NUM sentinel is added
> to the enum so that the bounds check uses >= LTC2983_SENSOR_NUM
> rather than hardcoding the last sensor type.
> 
> Tested on EVAL-ADT7604-AZ connected to Raspberry Pi 5 via SPI.
> 
> Signed-off-by: Liviu Stan <liviu.stan@analog.com>

The sashiko comment about the completion race looks real to me.
Can you take a look at that. Might be some odd reason why we can't
reinit_completion() before triggering the capture but that would
be very unusual.

Otherwise just two really small things I missed in earlier reviews.
If everything else was ready to go I'd have tweaked these whilst
applying but seems you'll be doing a v4 so over to you!

Jonathan

>  drivers/iio/temperature/ltc2983.c | 413 ++++++++++++++++++++++++++++--
>  1 file changed, 394 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
> index 326f843f4271..e2ffeee026ee 100644
> --- a/drivers/iio/temperature/ltc2983.c
> +++ b/drivers/iio/temperature/ltc2983.c

> @@ -186,17 +188,44 @@ enum {
>  	LTC2983_SENSOR_SENSE_RESISTOR = 29,
>  	LTC2983_SENSOR_DIRECT_ADC = 30,
>  	LTC2983_SENSOR_ACTIVE_TEMP = 31,
> +	/* Sensor types for some parts only; map to RTD_CUSTOM/THERMISTOR_CUSTOM in HW */
> +	LTC2983_SENSOR_COPPER_TRACE = 32,
> +	LTC2983_SENSOR_LEAK_DETECTOR = 33,
> +	LTC2983_SENSOR_NUM,

That's a terminating entry so no trailing comma.  It always has to be last.

>  };

>  static const struct spi_device_id ltc2983_id_table[] = {
> @@ -1707,6 +2080,7 @@ static const struct spi_device_id ltc2983_id_table[] = {
>  	{ "ltc2984", (kernel_ulong_t)&ltc2984_chip_info_data },
>  	{ "ltc2986", (kernel_ulong_t)&ltc2986_chip_info_data },
>  	{ "ltm2985", (kernel_ulong_t)&ltm2985_chip_info_data },
> +	{ "adt7604", (kernel_ulong_t)&adt7604_chip_info_data },

As below.

>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, ltc2983_id_table);
> @@ -1716,6 +2090,7 @@ static const struct of_device_id ltc2983_of_match[] = {
>  	{ .compatible = "adi,ltc2984", .data = &ltc2984_chip_info_data },
>  	{ .compatible = "adi,ltc2986", .data = &ltc2986_chip_info_data },
>  	{ .compatible = "adi,ltm2985", .data = &ltm2985_chip_info_data },
> +	{ .compatible = "adi,adt7604", .data = &adt7604_chip_info_data },

Oops I missed this before. Alphabetical order. 

Jonathan

>  	{ }
