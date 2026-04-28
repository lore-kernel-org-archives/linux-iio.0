Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8963F54DA
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 11:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374798; cv=none; b=OdStb31rVQJnWj9Es/5c32+MNhYcQkux3hh2f48EKs649xHn+h/biwb43Yx8sf4ecvaxx5TCfIDTEmRHYb4fN+WZlhKMX7kiBkjPexbzMgkYP4Mw010AHF5b8BhpufUCpGYzKZlRS29gWoIe2vs/HuFDoN552HfQBcyGi4HGjj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374798; c=relaxed/simple;
	bh=KY/LKzoaJShkrox+8o/j+PhuR2mpqsb7kdLuplRquFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKZDmga1+Cs0wKFknxeke0JzRWNIAgYNkIsjvReFAz+pfQjqEQaHUEqYS9eGXK1Kgzyc8iAckgfzxz/GInZ8odBrGU9YNQFqK89Ve5b4arQdWK5luzZ18hUwvzb5qYHqH2xHYz+b7D1+Rdg/pxTkXkPMgTzSBZDpDK0DDy6NATw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTuAct1t; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTuAct1t"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so192569805e9.2
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 04:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777374794; x=1777979594; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z11n+PRhb7EWOxgpZ9gxX8IAfg6BMXQq4yyy1cTr18E=;
        b=fTuAct1t4vfO4BDdbaDvHSLS9gr0T/8sggpWRrBRI7VcsPbJ7RnKtmo6/uLI34Ij+y
         KFoIenyzLyw3rbDWf2d3FmalSCby753ksEC92qMwaKKzg0BifOB+AdqjTY+xt77+Gpqf
         ZY5Y9a4BDWRO/6TeGFIdlL+tafAUZmwjt+oDMCv/HxwKtMmq8NhH05lz3/PVRKt91+P7
         mBxfd7j5Pg+Cm29J6BuljijLMlWY1koctczSpX6gz2XV+aYlCea0P/wrAnnWSeMNXaYX
         5xHN1673/viTr3VAKhczBeNVhraUIP08NRoRckX6bv7nty/UW4p2iX1XFtDsKUFsBAmt
         R0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777374794; x=1777979594;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z11n+PRhb7EWOxgpZ9gxX8IAfg6BMXQq4yyy1cTr18E=;
        b=nCIj48uRX2ezux+A7O/2voZxSTzt8Sg6ph0jcwP8bLt8hSsiMCGqL/72HIEQzib0B4
         klpSCouFlRsAeAv5sq8XijhR8+i1fo2q11VMnxr5G77+5upDkzlu/PyBz9vi5hRaXsZ6
         mTJQGB1pQdxoc1SsseseoXEbGKQ85E2Huy3sICX/WjJhltURXWezuasWQwnE8RZdz/2V
         U6V4e+k5Eo3rTPjRTAVYQmXFwI/67+LhVA64OHk5Q9SN4ENMAdX736yQ0eAF54cdURHe
         ZTJj3uoA0ZaFy83xFMEIAzD9u+/wjhf1tybIH8OYqvvTXftmCF+p3tDdohUu55KwgoTb
         oT8Q==
X-Forwarded-Encrypted: i=1; AFNElJ/Xvlws+oMKrhj988iS6ezTASH0LzohzSU3z0KG24g2Dp7dDCqsjWisegsPuqlf4Fi7SoET4wQUWlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkuP5hZnEomtM6xD51itJBmzzonx37hfo2G6UmdqbVTQSg0oVg
	/nQT7PkePBd6VnCvZ0tjnav07CTte/kWFh/4/lsDkZSWLoxuomF136zN
X-Gm-Gg: AeBDieucp5For6QEAhzi08rvwqRcq1c+nj7LNY4fs15FG6NhW9nzKKm4o3LO6/iIUD/
	fVMHmtUbUlN3vSzhfQW21SfT2IMmB8xAml4m+kS5FgXAxbE+XQTKR0xfZTKgqCmt17qTbABB2GE
	vf31CIQsQBlIcwaBieOjM75G6RZsYk5HxnEFZ4gY55GrJoDv1lPz2cLjLPPHjt1DARORgjBCSIe
	3J7ReH4nCtm11y8WveC06iLjepKb1wKQXv8u/zqoVBP/Jl2PxVY8k39AXdf5uiNSG45W++Q/kE5
	0GIkmYSYZMkQEUPM9FKyayxJE3mjq6vza5P9fUeLfC8fKcsKCp1qbONF/UlhWE9zag3/RAg0I+J
	tsVxWnddgb60WkzqxG9Owsl1paurShlugJuNn7g7EuLpjUMLa1i83vScsO8amBlG6X2jEk6ZQud
	0VM3Lnu4fMOgeEv6aq2U9befsylQ==
X-Received: by 2002:a05:600c:8b52:b0:488:a882:c7 with SMTP id 5b1f17b1804b1-48a77b1a4aemr45443975e9.25.1777374793963;
        Tue, 28 Apr 2026 04:13:13 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a77b24035sm42059235e9.9.2026.04.28.04.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 04:13:13 -0700 (PDT)
Date: Tue, 28 Apr 2026 12:14:05 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Liviu Stan <liviu.stan@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: temperature: ltc2983: Add support for ADT7604
Message-ID: <afCVtXBHIIoLlsRo@nsa>
References: <20260427132526.272716-1-liviu.stan@analog.com>
 <20260427132526.272716-3-liviu.stan@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260427132526.272716-3-liviu.stan@analog.com>

On Mon, Apr 27, 2026 at 04:25:08PM +0300, Liviu Stan wrote:
> The ADT7604 shares the same die as the LTC2984. It repurposes the
> custom RTD sensor type (18) as a copper trace resistance sensor
> and the custom thermistor type (27) as a leak detector, and
> removes thermocouple, diode and direct ADC sensor types.
> 
> Custom RTD (type 18) becomes the copper trace sensor. Sensor
> configuration bits 21:18 are hardcoded to 0b1001 per the
> datasheet. Two variants are supported via the new
> adi,copper-trace-sub-ohm DT property: sub-ohm traces (< 1 ohm)
> have bits 17:0 cleared with no excitation current or custom
> table; standard traces (> 1 ohm) accept an optional
> resistance-to-temperature table.
> 
> Custom thermistor (type 27) becomes the leak detector. Sensor
> configuration bits are hardcoded to 0b001. The custom table
> uses a resolution of 16 (20+4 bit resistance field) instead of
> 64, and is specified via the new adi,custom-leak-detector DT
> property.
> 
> Both sensor types expose an IIO_RESISTANCE channel reading from
> the resistance result register bank (0x060-0x00AF), added to
> the regmap readable ranges. Scales are 1/1,024,000 for copper
> trace (result in mOhm) and 1/1024 for leak detector (result
> in Ohm).

But for userspace we report both in Ohm? That's the ABI AFAICT. In DT,
you also mention IIO_TEMP is used:

"IIO_TEMP reports coverage percentage"

Can you expand more on what the above means? Are we reporting milli
degrees celcius to userspace?

I could not find the datasheet so I guess it's not yet public?

> 
> A has_copper_trace capability flag is introduced in
> ltc2983_chip_info to identify the ADT7604, following the
> existing has_temp and has_eeprom pattern.
> 
> Tested on EVAL-ADT7604-AZ connected to Raspberry Pi 5 via SPI.
> 
> Signed-off-by: Liviu Stan <liviu.stan@analog.com>
> ---
>  drivers/iio/temperature/ltc2983.c | 347 +++++++++++++++++++++---------
>  1 file changed, 251 insertions(+), 96 deletions(-)
> 
> diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
> index 38e6f8dfd3b8..1966f6fb0305 100644
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
> @@ -58,8 +60,8 @@
>  
>  #define LTC2983_CHAN_START_ADDR(chan) \
>  			(((chan - 1) * 4) + LTC2983_CHAN_ASSIGN_START_REG)
> -#define LTC2983_CHAN_RES_ADDR(chan) \
> -			(((chan - 1) * 4) + LTC2983_TEMP_RES_START_REG)
> +#define LTC2983_CHAN_RES_ADDR(chan, base) \
> +			((((chan) - 1) * 4) + (base))
>  #define LTC2983_THERMOCOUPLE_DIFF_MASK		BIT(3)
>  #define LTC2983_THERMOCOUPLE_SGL(x) \
>  				FIELD_PREP(LTC2983_THERMOCOUPLE_DIFF_MASK, x)
> @@ -214,6 +216,7 @@ struct ltc2983_chip_info {
>  	unsigned int max_channels_nr;
>  	bool has_temp;
>  	bool has_eeprom;
> +	bool has_copper_trace;
>  };
>  
>  struct ltc2983_data {
> @@ -272,6 +275,7 @@ struct ltc2983_rtd {
>  	u32 r_sense_chan;
>  	u32 excitation_current;
>  	u32 rtd_curve;
> +	bool sub_ohm;
>  };
>  
>  struct ltc2983_thermistor {
> @@ -575,6 +579,10 @@ static int ltc2983_rtd_assign_chan(struct ltc2983_data *st,
>  		if (ret)
>  			return ret;
>  	}
> +
> +	if (rtd->sub_ohm)
> +		chan_val &= ~GENMASK(17, 0);
> +
>  	return __ltc2983_chan_assign_common(st, sensor, chan_val);
>  }

I'm not sure if we shouldn't just treat the new types as new sensors
instead of trying to push them in the existing one. I agree with Andy,
the patch does not look great with respect to if() else() and going to
deep in indentation.

>  
> @@ -758,83 +766,113 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
>  		return dev_err_ptr_probe(dev, ret,
>  					 "Property reg must be given\n");
>  
> -	ret = fwnode_property_read_u32(child, "adi,number-of-wires", &n_wires);
> -	if (!ret) {
> -		switch (n_wires) {
> -		case 2:
> -			rtd->sensor_config = LTC2983_RTD_N_WIRES(0);
> -			break;
> -		case 3:
> -			rtd->sensor_config = LTC2983_RTD_N_WIRES(1);
> -			break;
> -		case 4:
> -			rtd->sensor_config = LTC2983_RTD_N_WIRES(2);
> -			break;
> -		case 5:
> -			/* 4 wires, Kelvin Rsense */
> -			rtd->sensor_config = LTC2983_RTD_N_WIRES(3);
> -			break;
> -		default:
> +	/* ADT7604 requires hardcoding sensor configuration bits to 0b1001 */
> +	if (st->info->has_copper_trace &&
> +	    sensor->type == LTC2983_SENSOR_RTD_CUSTOM) {
> +		rtd->sensor_config = 0x9;
> +		if (sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)

Like the above, we have the following kind of condition all over the
place. In DT we can just have a different type for these and map it to
real value when creating the sensor.

...

>  
>  	/* set common parameters */
> @@ -908,17 +946,27 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
>  		return dev_err_ptr_probe(dev, ret,
>  					 "rsense channel must be configured...\n");
>  
> -	if (fwnode_property_read_bool(child, "adi,single-ended")) {
> -		thermistor->sensor_config = LTC2983_THERMISTOR_SGL(1);
> -	} else if (fwnode_property_read_bool(child, "adi,rsense-share")) {
> -		/* rotation is only possible if sharing rsense */
> -		if (fwnode_property_read_bool(child, "adi,current-rotate"))
> -			thermistor->sensor_config =
> -						LTC2983_THERMISTOR_C_ROTATE(1);
> -		else
> -			thermistor->sensor_config =
> -						LTC2983_THERMISTOR_R_SHARE(1);
> +	if (st->info->has_copper_trace &&
> +	    sensor->type == LTC2983_SENSOR_THERMISTOR_CUSTOM) {
> +		thermistor->sensor_config = LTC2983_THERMISTOR_C_ROTATE(1);
> +		if (sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
> +			return dev_err_ptr_probe(dev, -EINVAL,
> +						 "Invalid chann:%d for leak detector\n",
> +						 sensor->chan);

Same story

> +	} else {
> +		if (fwnode_property_read_bool(child, "adi,single-ended")) {
> +			thermistor->sensor_config = LTC2983_THERMISTOR_SGL(1);
> +		} else if (fwnode_property_read_bool(child, "adi,rsense-share")) {
> +			/* rotation is only possible if sharing rsense */
> +			if (fwnode_property_read_bool(child, "adi,current-rotate"))
> +				thermistor->sensor_config =
> +							LTC2983_THERMISTOR_C_ROTATE(1);
> +			else
> +				thermistor->sensor_config =
> +							LTC2983_THERMISTOR_R_SHARE(1);
> +		}
>  	}
> +
>  	/* validate channel index */
>  	if (!(thermistor->sensor_config & LTC2983_THERMISTOR_DIFF_MASK) &&
>  	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
> @@ -928,23 +976,36 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
>  
>  	/* check custom sensor */
>  	if (sensor->type >= LTC2983_SENSOR_THERMISTOR_STEINHART) {
> -		bool steinhart = false;
> -		const char *propname;
> -
> -		if (sensor->type == LTC2983_SENSOR_THERMISTOR_STEINHART) {
> -			steinhart = true;
> -			propname = "adi,custom-steinhart";
> +		if (st->info->has_copper_trace &&
> +		    sensor->type == LTC2983_SENSOR_THERMISTOR_CUSTOM) {
> +			if (fwnode_property_present(child, "adi,custom-leak-detector")) {
> +				thermistor->custom =
> +					__ltc2983_custom_sensor_new(st, child,
> +								    "adi,custom-leak-detector",
> +								    false, 16, false);
> +				if (IS_ERR(thermistor->custom))
> +					return ERR_CAST(thermistor->custom);
> +			}
>  		} else {
> -			propname = "adi,custom-thermistor";
> +			bool steinhart = false;
> +			const char *propname;
> +
> +			if (sensor->type == LTC2983_SENSOR_THERMISTOR_STEINHART) {
> +				steinhart = true;
> +				propname = "adi,custom-steinhart";
> +			} else {
> +				propname = "adi,custom-thermistor";
> +			}
> +
> +			thermistor->custom = __ltc2983_custom_sensor_new(st, child,
> +									 propname,
> +									 steinhart,
> +									 64, false);
> +			if (IS_ERR(thermistor->custom))
> +				return ERR_CAST(thermistor->custom);
>  		}
> -
> -		thermistor->custom = __ltc2983_custom_sensor_new(st, child,
> -								 propname,
> -								 steinhart,
> -								 64, false);
> -		if (IS_ERR(thermistor->custom))
> -			return ERR_CAST(thermistor->custom);
>  	}
> +
>  	/* set common parameters */
>  	thermistor->sensor.fault_handler = ltc2983_common_fault_handler;
>  	thermistor->sensor.assign_chan = ltc2983_thermistor_assign_chan;
> @@ -1167,7 +1228,8 @@ static struct ltc2983_sensor *ltc2983_temp_new(struct fwnode_handle *child,
>  }
>  
>  static int ltc2983_chan_read(struct ltc2983_data *st,
> -			const struct ltc2983_sensor *sensor, int *val)
> +			const struct ltc2983_sensor *sensor,
> +			u32 base_reg, int *val)
>  {
>  	u32 start_conversion = 0;
>  	int ret;
> @@ -1197,13 +1259,23 @@ static int ltc2983_chan_read(struct ltc2983_data *st,
>  	}
>  
>  	/* read the converted data */
> -	ret = regmap_bulk_read(st->regmap, LTC2983_CHAN_RES_ADDR(sensor->chan),
> +	ret = regmap_bulk_read(st->regmap, LTC2983_CHAN_RES_ADDR(sensor->chan, base_reg),
>  			       &st->temp, sizeof(st->temp));
>  	if (ret)
>  		return ret;
>  
>  	*val = __be32_to_cpu(st->temp);
>  
> +	if (base_reg == ADT7604_RES_RES_START_REG) {
> +		/*
> +		 * Resistance result register gives a plain unsigned value,
> +		 * D31 is always 0, no valid bit, no fault bits. Read bits[30:0]
> +		 * directly — the temperature result format does not apply here.
> +		 */
> +		*val &= GENMASK(30, 0);
> +		return 0;
> +	}
> +
>  	if (!(LTC2983_RES_VALID_MASK & *val)) {
>  		dev_err(&st->spi->dev, "Invalid conversion detected\n");
>  		return -EIO;
> @@ -1214,6 +1286,7 @@ static int ltc2983_chan_read(struct ltc2983_data *st,
>  		return ret;
>  
>  	*val = sign_extend32((*val) & LTC2983_DATA_MASK, LTC2983_DATA_SIGN_BIT);
> +
>  	return 0;
>  }
>  
> @@ -1234,7 +1307,12 @@ static int ltc2983_read_raw(struct iio_dev *indio_dev,
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  		mutex_lock(&st->lock);
> -		ret = ltc2983_chan_read(st, st->sensors[chan->address], val);
> +		if (chan->type == IIO_RESISTANCE)
> +			ret = ltc2983_chan_read(st, st->sensors[chan->address],
> +						ADT7604_RES_RES_START_REG, val);
> +		else
> +			ret = ltc2983_chan_read(st, st->sensors[chan->address],
> +						LTC2983_TEMP_RES_START_REG, val);

I think the preferred style is to also have switch() case for the above

>  		mutex_unlock(&st->lock);
>  		return ret ?: IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
> @@ -1251,6 +1329,18 @@ static int ltc2983_read_raw(struct iio_dev *indio_dev,
>  			/* 2^21 */
>  			*val2 = 2097152;
>  			return IIO_VAL_FRACTIONAL;
> +		case IIO_RESISTANCE:
> +			/* value in ohm */
> +			*val = 1;
> +			/*
> +			 * Copper trace result is in milliohm with 10 fractional
> +			 * bits: divide by 2^10 * 1000 = 1024000.
> +			 * Leak detector result is in ohm with 10 fractional
> +			 * bits: divide by 2^10 = 1024.
> +			 */
> +			*val2 = (st->sensors[chan->address]->type == LTC2983_SENSOR_RTD_CUSTOM) ?
> +				1024000 : 1024;
> +			return IIO_VAL_FRACTIONAL;

I would prefer a plain if() else

>  		default:
>  			return -EINVAL;
>  		}
> @@ -1292,6 +1382,17 @@ static irqreturn_t ltc2983_irq_handler(int irq, void *data)
>  	__chan; \
>  })
>  
> +#define LTC2983_RESISTANCE_CHAN(index, __address) ({ \
> +	struct iio_chan_spec __chan = { \
> +		.type = IIO_RESISTANCE, \
> +		.indexed = 1, \
> +		.channel = index, \
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE), \
> +		.address = __address, \
> +	}; \
> +	__chan; \
> +})
> +
>  static int ltc2983_parse_fw(struct ltc2983_data *st)
>  {
>  	struct device *dev = &st->spi->dev;
> @@ -1339,6 +1440,16 @@ static int ltc2983_parse_fw(struct ltc2983_data *st)
>  			return dev_err_probe(dev, ret,
>  				"adi,sensor-type property must given for child nodes\n");
>  
> +		if (st->info->has_copper_trace) {
> +			if ((sensor.type >= LTC2983_SENSOR_THERMOCOUPLE &&
> +			     sensor.type <= LTC2983_SENSOR_THERMOCOUPLE_CUSTOM) ||
> +			     sensor.type == LTC2983_SENSOR_DIODE ||
> +			     sensor.type == LTC2983_SENSOR_DIRECT_ADC)
> +				return dev_err_probe(dev, -EINVAL,
> +			 "sensor type %d not supported on %s\n",
> +			 sensor.type, st->info->name);
> +		}
> +

The above is also not great! Maybe see the possibility of having a
supported sensors mask that you fill in chip_info! Then we would just
test_bit() in here

>  		dev_dbg(dev, "Create new sensor, type %u, chann %u",
>  			sensor.type, sensor.chan);
>  
> @@ -1380,6 +1491,15 @@ static int ltc2983_parse_fw(struct ltc2983_data *st)
>  		st->sensors[chan]->chan = sensor.chan;
>  		st->sensors[chan]->type = sensor.type;
>  
> +		if (st->info->has_copper_trace) {
> +			if (st->sensors[chan]->type == LTC2983_SENSOR_THERMISTOR_CUSTOM &&
> +			    to_thermistor(st->sensors[chan])->custom)
> +				st->iio_channels++;
> +			else if (st->sensors[chan]->type == LTC2983_SENSOR_RTD_CUSTOM &&
> +				 to_rtd(st->sensors[chan])->custom)
> +				st->iio_channels++;
> +		}
> +

Having to go up to to_thermistor() and to_rtd() in a common path like
here also smells :). One possible solution would be to refactor things
so that:

`st->iio_channels = st->num_channels` is not necessarily true.

struct ltc2983_sensor could have a new n_iio_chan count given that now
we can (AFAIU) one sensor with more that one IIO channel. Then we could
count things in a generic way in here.

We might need to change more things that I'm missing now.

>  		channel_avail_mask |= BIT(sensor.chan);
>  		chan++;
>  	}
> @@ -1426,7 +1546,7 @@ static int ltc2983_eeprom_cmd(struct ltc2983_data *st, unsigned int cmd,
>  
>  static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
>  {
> -	u32 iio_chan_t = 0, iio_chan_v = 0, chan, iio_idx = 0, status;
> +	u32 iio_chan_t = 0, iio_chan_v = 0, iio_chan_r = 0, chan, iio_idx = 0, status;
>  	int ret;
>  
>  	/* make sure the device is up: start bit (7) is 0 and done bit (6) is 1 */
> @@ -1473,6 +1593,26 @@ static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
>  		    !assign_iio)
>  			continue;
>  
> +		/*
> +		 * Copper trace and leak detector sensors without a custom table
> +		 * produce only a resistance result; the chip does not populate
> +		 * the temperature result register. Emit only an IIO_RESISTANCE
> +		 * channel in this case.
> +		 */
> +		if (st->info->has_copper_trace) {
> +			bool resistance_only =
> +				(st->sensors[chan]->type == LTC2983_SENSOR_RTD_CUSTOM &&
> +				 !to_rtd(st->sensors[chan])->custom) ||
> +				(st->sensors[chan]->type == LTC2983_SENSOR_THERMISTOR_CUSTOM &&
> +				 !to_thermistor(st->sensors[chan])->custom);
> +
> +			if (resistance_only) {
> +				st->iio_chan[iio_idx++] =
> +					LTC2983_RESISTANCE_CHAN(iio_chan_r++, chan);
> +				continue;
> +			}
> +		}
> +

My above suggestion would also fit for the above I believe.

>  		/* assign iio channel */
>  		if (st->sensors[chan]->type != LTC2983_SENSOR_DIRECT_ADC) {
>  			chan_type = IIO_TEMP;
> @@ -1488,6 +1628,11 @@ static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
>  		 */
>  		st->iio_chan[iio_idx++] = LTC2983_CHAN(chan_type, (*iio_chan)++,
>  						       chan);
> +
> +		if (st->info->has_copper_trace &&
> +		    (st->sensors[chan]->type == LTC2983_SENSOR_RTD_CUSTOM ||
> +		     st->sensors[chan]->type == LTC2983_SENSOR_THERMISTOR_CUSTOM))
> +			st->iio_chan[iio_idx++] = LTC2983_RESISTANCE_CHAN(iio_chan_r++, chan);


I think the above can also be dropped and improved with what I
suggested.

- Nuno Sá

