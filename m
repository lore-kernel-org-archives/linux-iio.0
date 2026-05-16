Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8500B381AF;
	Sat, 16 May 2026 17:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778951581; cv=none; b=ZnRm/yD57rQ/KXl1f/kTWHcc8My4Xm9GjOt5JjvO2hNTL1FBX7zHWOk/6lj4XACNzVLzNAcnndqBOoiCnfRz0LLGfASxacmxRXu/bNUiOWqR4geRT8IfmpELoCH6GBIPhbg3jR5IG/neqXv7PuPOnrFRBYM7gUms0TbZixUJHIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778951581; c=relaxed/simple;
	bh=cRbIw7n+NgjF1JlZVVddy1VPQHHi/621COsILiDOrN0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tpSTm0NMSMUB8z9cCKJ3gewLAJUx1nTGhtlKz33qGjfWaTXbHPm6qhMLktiGVQVHDS0HqVDtLOSLGEkfWtLj9ddpNepL9qZyPVqKK7pmxuWnVLJfKmORU0ubuLo2/7iIM0TbAPuX5e6CauxGZ+nJkK8uHXrGrc6T2uOj5Azj8e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtCZSgIO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtCZSgIO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174B9C19425;
	Sat, 16 May 2026 17:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778951581;
	bh=cRbIw7n+NgjF1JlZVVddy1VPQHHi/621COsILiDOrN0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BtCZSgIOMeZO6RG7vmliLr34ZNJfB7pF+d1UzmIP9Fl6oeo9rr5V3nqOrEAkDa5OT
	 tne/sU73kUAhFelXJ+9mURbpY92LMSh31ucBeCdRNRvZ5CcEkDCDjCKQcx5JX79HDx
	 //NokuqUbiimDpRdEhtZWTzdm+CPmSZifo56mnT/tU8i/RmUftkhN+RH79ZCfMCHah
	 KZ8zLeMSExFL1P22sZP63YWsDLM97tbkgucv1TswhT04OUsksgzEEwtNOqBRtZlI0X
	 L8cYfHKSTBfpHpdT0c1K0N1BJU+bKGLVaGbDwuUVxTF16fsx5zAO2bQ6TVLs3UQOMl
	 izKiuu7pVgpHg==
Date: Sat, 16 May 2026 18:12:50 +0100
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
Subject: Re: [PATCH v2 7/7] iio: temperature: ltc2983: Add support for
 ADT7604
Message-ID: <20260516181250.039e154a@jic23-huawei>
In-Reply-To: <20260514144712.64374-8-liviu.stan@analog.com>
References: <20260514144712.64374-1-liviu.stan@analog.com>
	<20260514144712.64374-8-liviu.stan@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 May 2026 17:46:54 +0300
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
> excitation current or custom table; standard traces (> 1 ohm) accept
> an optional resistance-to-temperature table.
> 
> Custom thermistor (type 27) becomes the leak detector. Sensor
> configuration bits are hardcoded to 0b001. The custom table uses
> a resolution of 16 instead of 64, and is specified via the
> adi,custom-leak-detector DT property.
> 
> Both sensor types expose an IIO_RESISTANCE channel reading from
> the resistance result register bank (0x0060-0x00AF). The register
> encodes the measured resistance with 10 fractional bits, so
> dividing by 1024 gives ohms. Since the sense resistor is specified
> in ohms, the output is in ohms for both sensor types and a single
> 1/1024 scale applies to both. When a custom table is provided,
> a secondary channel also appears: IIO_TEMP (millidegrees Celsius)
> for copper trace and IIO_COVERAGE_PERCENT (percent) for leak
> detector.
> 
> The ltc2983_chip_info struct is extended with a u64 supported_sensors
> bitmask using BIT_ULL() to safely represent the new sensor type bits
> 32 and 33 on 32-bit builds.
> 
> Tested on EVAL-ADT7604-AZ connected to Raspberry Pi 5 via SPI.
> 
> Signed-off-by: Liviu Stan <liviu.stan@analog.com>
Hi.
Just one trivial thing inline.

Thanks

Jonathan

> 
>  drivers/iio/temperature/ltc2983.c | 401 ++++++++++++++++++++++++++++--
>  1 file changed, 386 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
> index bf435e965c6d..acd043ed62f5 100644
> --- a/drivers/iio/temperature/ltc2983.c
> +++ b/drivers/iio/temperature/ltc2983.c
> @@ -28,6 +28,8 @@
>  #define LTC2983_STATUS_REG			0x0000
>  #define LTC2983_TEMP_RES_START_REG		0x0010
>  #define LTC2983_TEMP_RES_END_REG		0x005F
> +#define ADT7604_RES_RES_START_REG		0x0060
> +#define ADT7604_RES_RES_END_REG			0x00AF
>  #define LTC2983_EEPROM_KEY_REG			0x00B0
>  #define LTC2983_EEPROM_READ_STATUS_REG		0x00D0
>  #define LTC2983_GLOBAL_CONFIG_REG		0x00F0
> @@ -186,17 +188,43 @@ enum {
>  	LTC2983_SENSOR_SENSE_RESISTOR = 29,
>  	LTC2983_SENSOR_DIRECT_ADC = 30,
>  	LTC2983_SENSOR_ACTIVE_TEMP = 31,
> +	/* Sensor types for some parts only; map to RTD_CUSTOM/THERMISTOR_CUSTOM in HW */
> +	LTC2983_SENSOR_COPPER_TRACE = 32,
> +	LTC2983_SENSOR_LEAK_DETECTOR = 33,
Given you care about being in range of this I'd add
	LTC2983_SENSOR_NUM
>  };

> @@ -1329,7 +1649,7 @@ static int ltc2983_parse_fw(struct ltc2983_data *st)
>  	if (!st->sensors)
>  		return -ENOMEM;
>  
> -	st->iio_channels = st->num_channels;
> +	st->iio_channels = 0;
>  	device_for_each_child_node_scoped(dev, child) {
>  		struct ltc2983_sensor sensor;
>  
> @@ -1357,7 +1677,13 @@ static int ltc2983_parse_fw(struct ltc2983_data *st)
>  			return dev_err_probe(dev, ret,
>  				"adi,sensor-type property must given for child nodes\n");
>  
> -		dev_dbg(dev, "Create new sensor, type %u, chann %u",
> +		if (sensor.type > LTC2983_SENSOR_LEAK_DETECTOR ||

To make it easier to extend in future, perhaps add the NUM entry I mention
above then >= to it here.

> +		    !(st->info->supported_sensors & BIT_ULL(sensor.type)))
> +			return dev_err_probe(dev, -EINVAL,
> +					     "sensor type %d not supported on %s\n",
> +					     sensor.type, st->info->name);
> +
> +		dev_dbg(dev, "Create new sensor, type %u, channel %u",
>  			sensor.type, sensor.chan);
>  

> @@ -1445,8 +1782,9 @@ static int ltc2983_eeprom_cmd(struct ltc2983_data *st, unsigned int cmd,
>  
>  static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
>  {
> -	u32 iio_chan_t = 0, iio_chan_v = 0, chan, iio_idx = 0, status;
>  	struct device *dev = &st->spi->dev;
> +	u32 iio_chan_t = 0, iio_chan_v = 0, iio_chan_r = 0, iio_chan_c = 0;
> +	u32 chan, iio_idx = 0, status;
>  	int ret;
>  
>  	/* make sure the device is up: start bit (7) is 0 and done bit (6) is 1 */
> @@ -1493,8 +1831,26 @@ static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
>  		    !assign_iio)
>  			continue;
>  
> +		/*
> +		 * Copper trace and leak detector sensors without a custom table
> +		 * produce only a resistance result; the chip does not populate
> +		 * the temperature result register. Emit only an IIO_RESISTANCE
> +		 * channel in this case.

Do we care?  That is are they useful without the table? We could just make it
required in the binding.

> +		 */
> +		if (st->sensors[chan]->type == LTC2983_SENSOR_COPPER_TRACE ||
> +		    st->sensors[chan]->type == LTC2983_SENSOR_LEAK_DETECTOR) {
> +			if (st->sensors[chan]->n_iio_chan == 1) {
> +				st->iio_chan[iio_idx++] =
> +					LTC2983_CHAN(IIO_RESISTANCE, iio_chan_r++, chan);
> +				continue;
> +			}
> +		}
