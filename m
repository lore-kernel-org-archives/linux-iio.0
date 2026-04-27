Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECA43B27C4;
	Mon, 27 Apr 2026 18:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777314246; cv=none; b=GuLs6QtogOMn28nTuzJ6LGsw9AlRdwVC0pExttIYupdr2ASHHyS9mkQWpSxCMSDez8HrZ0WyIzBt0fmP+kcVfEjxDLeVad0gJmmHGkAtjX94x7HTTO+1IjzeT1wXTZfR0PqV0ckXcmWz+ezzY9PMyetXWdf7PLZCHpR+z+TpaU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777314246; c=relaxed/simple;
	bh=Xqfy2dataEyabGZzUVMm4Q30Id3IESlUMgh5wSZ7grw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSXdr6N2QDmwcqE4iUHnoL2um2722TGLIIu+S45scj32gM6ni/4/HBUHihTlqMFjLe9QRHYg3hkDyFeH3jCazjbfSqCzdg/HYzY1t6CYNJh1EtEWrVBumshOxp4Px6b+k7M3gC3yXJx9noa80RQ6VTSs8JpyZX0zuDbtlSBh4gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mFPKzwsR; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mFPKzwsR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777314245; x=1808850245;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xqfy2dataEyabGZzUVMm4Q30Id3IESlUMgh5wSZ7grw=;
  b=mFPKzwsR3G14LIOreaRUsf9r5xwqKvB8yoHhXxlMUFwQAUZ6nmsyM0fA
   8bAlu4T9kdevxzTgJYVWI3QLVk6KPdIiY7z1BY3JjOUGpqFmSaX5kgMsP
   kJ3/SBVPaATsuUnb+jbDIuVYQx2SuBIxi0Wl9FnmSuEuV/KPfEwV//xgX
   e3AtUYf1NWQUyvH6ZBzUWReWkYZZDvjrcs8Av9x1uw/WDCKc1NhYUJuR0
   ilQBY57h5xYyqPeJZxcHmhjbJbbMlgJe0iAt79WJBQmsKbmIjV8atoFnf
   6/8WN/pQgF776K9sVVsf8pacVDCFWVtHJnjpEhEAUyjzwV2sDvrbEl6cO
   A==;
X-CSE-ConnectionGUID: wd1Ru786SKSxhGZkeZC+0Q==
X-CSE-MsgGUID: 9kIdpimQT2+plQigwUvO2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="88525633"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="88525633"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 11:24:04 -0700
X-CSE-ConnectionGUID: NiPWC2xaRJyxc3opKsL1Kg==
X-CSE-MsgGUID: J+LkTWwxSCeU+UnUOKlwsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="227193748"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 11:24:01 -0700
Date: Mon, 27 Apr 2026 21:23:59 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Liviu Stan <liviu.stan@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: temperature: ltc2983: Add support for ADT7604
Message-ID: <ae-pvxKhqmkWwXdX@ashevche-desk.local>
References: <20260427132526.272716-1-liviu.stan@analog.com>
 <20260427132526.272716-3-liviu.stan@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427132526.272716-3-liviu.stan@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

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
> 
> A has_copper_trace capability flag is introduced in
> ltc2983_chip_info to identify the ADT7604, following the
> existing has_temp and has_eeprom pattern.
> 
> Tested on EVAL-ADT7604-AZ connected to Raspberry Pi 5 via SPI.

...

>  #define LTC2983_CHAN_START_ADDR(chan) \
>  			(((chan - 1) * 4) + LTC2983_CHAN_ASSIGN_START_REG)
> -#define LTC2983_CHAN_RES_ADDR(chan) \
> -			(((chan - 1) * 4) + LTC2983_TEMP_RES_START_REG)
> +#define LTC2983_CHAN_RES_ADDR(chan, base) \
> +			((((chan) - 1) * 4) + (base))

For the sake of consistency I would see (base) also to be in the _START_ADDR()
macro.

...

> +	bool sub_ohm;

What does this mean? Perhaps rename to is_in_milliohms or something like that?

...

> +		ret = fwnode_property_read_u32(child, "adi,number-of-wires", &n_wires);
> +		if (!ret) {

Yeah, this is in the original code. Consider at some point to make it rather
returning meaningful error codes, id est

		if (fwnode_property_present(child, "adi,number-of-wires")) {
			ret = fwnode_property_read_u32(child, "adi,number-of-wires", &n_wires);
			if (ret)
				return ret; // or with message that we can't get property value

> +			switch (n_wires) {
> +			case 2:
> +				rtd->sensor_config = LTC2983_RTD_N_WIRES(0);
> +				break;
> +			case 3:
> +				rtd->sensor_config = LTC2983_RTD_N_WIRES(1);
> +				break;
> +			case 4:
> +				rtd->sensor_config = LTC2983_RTD_N_WIRES(2);
> +				break;
> +			case 5:
> +				/* 4 wires, Kelvin Rsense */
> +				rtd->sensor_config = LTC2983_RTD_N_WIRES(3);
> +				break;
> +			default:
> +				return dev_err_ptr_probe(dev, -EINVAL,
> +							 "Invalid number of wires:%u\n",
> +							 n_wires);
> +			}
>  		}

...

> +			if (sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
> +				return dev_err_ptr_probe(&st->spi->dev, -EINVAL,

Don't you have 'dev' variable to use? If not, maybe makes sense to introduce.

> +							 "Invalid chann:%d for RTD\n",

chann? Perhaps just "chan"?

> +							 sensor->chan);
>  		}

...

> +		if (st->info->has_copper_trace) {
> +			if (fwnode_property_present(child, "adi,custom-rtd")) {
> +				rtd->custom = __ltc2983_custom_sensor_new(st, child,
> +									  "adi,custom-rtd",
> +									  false, 2048,
> +									  false);
> +				if (IS_ERR(rtd->custom))
> +					return ERR_CAST(rtd->custom);
> +			}
> +		} else {
> +			rtd->custom = __ltc2983_custom_sensor_new(st, child,
> +								  "adi,custom-rtd",
> +								  false, 2048, false);
> +			if (IS_ERR(rtd->custom))
> +				return ERR_CAST(rtd->custom);
> +		}

Seeing so many indentation noise, I think this patch starves for some
preparatory ones that make helper(s) out of the existing rather long functions
and then in a new code it will much easier to follow what gets changed and how.

...

Due to above I stopped here, because patch seems unreviewable to me. If others
are motivated more than me ans see this change nice in terms of readability,
I won't object. Personally I think it must be refactored (a lot!) before actually
adding a support of a new HW.

-- 
With Best Regards,
Andy Shevchenko


