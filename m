Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B557D48CD63;
	Thu, 24 Sep 2026 21:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790283673; cv=none; b=dC65XeXdZFiYYCevzqIzhHb7Z0TsdSu9MSU3t/DTRoA1OXgsFUENi4d0iesA9c1OGAc0CX7cpns0dvNtWHnOGfNploSztZHC9czwcEfiQmSgGjvYW4W961bEGyV+MjHYdr8aDvTTbWLOoD6kL9dJmzjeLDWBbbW5YvpxLMyGc9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790283673; c=relaxed/simple;
	bh=xM/HOyTXOTMzd4xSah3RzjepvrxWG6pv5hFkASgDHCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6GQdCibuZgnIRsOMFS+1iMiLbi9TIyu4912LTtWS5++rKQGntNn8YZmGqU/XSrlTK6rd+s9Lw7vTaUFMwVlJukEyz0cahEcXYbBGlqcKs2HhtYOYDgDIZXIJT8Kqpki5zCpORf8/9jHUMZpXjrL0EFrfG0PP5svL9ve7F6EQsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ku9LSOMI; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ku9LSOMI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790283670; x=1821819670;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xM/HOyTXOTMzd4xSah3RzjepvrxWG6pv5hFkASgDHCk=;
  b=Ku9LSOMIJ488cPxJ8W2V7DeyzOYQy0TN/8Z8EbMPxuIBh4fVdR4gcnYl
   K9O25YW0OQjtwclfbYMMiO50glICqMAlWiPT4+KLlsBIVlOZLLXDO3iHP
   zhchkMsWs9RAwvvrp9NgHLz5mlsOQYUCuX2oDLvXTr8DaNkB+B2Ihmgbm
   ZLI+o0VZ+DuTs3dkbkYWm0gwG1iv1VyEELNEA1bShPCsqXQkZ3DqXz/dU
   S89J9hjGfaNnl5xHOWqojk0i2rtAdL8ooEyIIccCq2UP/7Qy5+i/Z3hUQ
   oIM/AzlhhtUOleGexE2llie9JvWroiErJZ06lMxjyFSYXOGSgkwxlxPdJ
   w==;
X-CSE-ConnectionGUID: RFtFVbs4SvSNxcjeMlkzIA==
X-CSE-MsgGUID: iaHKTmj1SiOdvAh3S8p1RA==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="108561059"
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; 
   d="scan'208";a="108561059"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 14:01:10 -0700
X-CSE-ConnectionGUID: KaXIAxNuT+uIWKqO3zxKTQ==
X-CSE-MsgGUID: 6+3k7mcATAS/hVk7vgb3Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; 
   d="scan'208";a="272260995"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.199])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 14:01:06 -0700
Date: Fri, 25 Sep 2026 00:01:03 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Marek Vasut <marex@nabladev.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Cheick Traore <cheick.traore-ext@st.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH v2 07/14] iio: adc: stm32-adc: add support for stm32mp25
Message-ID: <arWPjx-JKt1IZCZl@ashevche-desk.local>
References: <20260923-adc-stm32mp25-v1-v2-0-46bc019537c6@foss.st.com>
 <20260923-adc-stm32mp25-v1-v2-7-46bc019537c6@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923-adc-stm32mp25-v1-v2-7-46bc019537c6@foss.st.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 23, 2026 at 05:39:10PM +0200, Fabrice Gasnier wrote:
> Add support for ADC on STM32MP25 SoC. It has 3 ADCs, split into two blocks:
> - ADC1 & ADC2 are tightly coupled.
> - ADC3 is managed independently.
> 
> Trigger list slightly changes between these blocks (ADC1 & ADC2). Other
> differences are found on channels interconnects (similar between ADC2
> and ADC3):
> - ADC1 is connected to 18 external channels + 2 internal channels
> - ADC2 is connected to 14 external channels + 6 internal channels
> - ADC3 is connected to 14 external channels + 6 internal channels
> 
> Each ADC is a 12-bits successive approximation analog-to-digital converter,
> with up to 20 multiplexed channels that can be configured as single ended
> or differential. ADC resolution ranges from 6 to 12 bits.
> 
> It introduces diversity regarding IRQs, clocks, software calibration
> procedure, internal voltage channels, sampling time (prescaler) and
> trigger list. Most of the architecture, and the driver engine remains
> similar. So, handle the differences w.r.t. other STM32 ADCs family with
> a dedicated compatible and compatible data.

...

>  		.compatible = "st,stm32mp13-adc-core",
>  		.data = (void *)&stm32mp13_adc_priv_cfg
>  	}, {
> -	},
> +		.compatible = "st,stm32mp25-adc-core",
> +		.data = (void *)&stm32mp25_adc_priv_cfg
> +	}, {
> +	}

Same issue and now it's a regression from maintenance perspective: you added an
unnedeed churn that has to be handled from now on... TL;DR: do add trailing
commas to the non-terminator entries and remove trailing commas in the
terminator entries.

>  };

...

> +	STM32_EXT23,
> +	STM32_EXT24,
> +	STM32_EXT25,
> +	STM32_EXT26,
> +	STM32_EXT27,
> +	STM32_EXT28

Same issue and so on...

>  };

...

Are you doing patches with an assistance? LLMs might have a problem with the
style issues.

...

> +retry:
> +	/* Clears or set CALADDOS (also clear old calibration data if any) */
> +	stm32_adc_writel(adc, STM32MP25_ADC_CALFACT,
> +			 FIELD_PREP(STM32MP25_CALFACT_CALADDOS, *add_offset));
> +
> +	ret = stm32mp25_adc_calib_get_average_data(indio_dev, &average);
> +	if (ret)
> +		return ret;
> +
> +	/* Add offset and retry single-ended calibration if the averaged data is zero */
> +	if (!average && !*add_offset) {
> +		*add_offset = true;
> +		goto retry;
> +	}

Refactor to avoid a label. It's possible to achieve.

> +	if (!average) {

Why not positive conditional?

> +		/* If average data is still zero with additional offset, just warn about it */
> +		dev_warn(&indio_dev->dev, "Single-ended calibration average: 0\n");
> +	} else {
> +		u32 calfact = stm32_adc_readl(adc, STM32MP25_ADC_CALFACT);
> +
> +		calfact |= FIELD_PREP(STM32MP25_CALFACT_S_MASK, average);
> +		stm32_adc_writel(adc, STM32MP25_ADC_CALFACT, calfact);
> +	}

...

> +static int stm32mp25_adc_calib(struct iio_dev *indio_dev)

> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +	bool add_offset = false;
> +	bool diff_below_zero;
> +	u32 average, calfact;
> +	int ret;
> +
> +	stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADCAL);
> +	/* Use default resolution (e.g. 12 bits) */
> +	stm32_adc_clr_bits(adc, STM32H7_ADC_CFGR, STM32MP25_RES_MASK);
> +
> +retry:
> +	/* Single ended input calibration */
> +	ret = stm32mp25_adc_calib_single_ended_offset(indio_dev, &add_offset);
> +	if (ret)
> +		goto out;
> +
> +	/* Differential input calibration (keep previous CALADDOS value) */
> +	stm32_adc_set_bits(adc, STM32H7_ADC_CR, STM32H7_ADCALDIF);
> +	ret = stm32mp25_adc_calib_get_average_data(indio_dev, &average);
> +	if (ret)
> +		goto out;
> +
> +	/* Averaged diff data is below 0x800 (half value in 12-bits mode) */
> +	diff_below_zero = average < BIT(adc->cfg->adc_info->resolutions[0] - 1);
> +
> +	if (diff_below_zero && !add_offset) {
> +		/* Retry the whole calibration with additional offset */
> +		add_offset = true;
> +		goto retry;
> +	}

Same comment, refactor to avoid label.

> +	calfact = stm32_adc_readl(adc, STM32MP25_ADC_CALFACT);
> +
> +	if (diff_below_zero) {
> +		/*
> +		 * Averaged data is still below center value. It needs to be clamped to zero,
> +		 * so don't use the result here, warn about it.
> +		 */
> +		dev_warn(&indio_dev->dev, "Differential calibration clamped(0): 0x%x\n", average);
> +	} else {
> +		calfact |= FIELD_PREP(STM32MP25_CALFACT_D_MASK, average);
> +		stm32_adc_writel(adc, STM32MP25_ADC_CALFACT, calfact);
> +	}
> +
> +	dev_dbg(&indio_dev->dev, "set calfact_s=0x%03lx, calfact_d=0x%03lx, calados=%ld\n",
> +		FIELD_GET(STM32MP25_CALFACT_S_MASK, calfact),
> +		FIELD_GET(STM32MP25_CALFACT_D_MASK, calfact),
> +		FIELD_GET(STM32MP25_CALFACT_CALADDOS, calfact));
> +out:

In any case if you ever have a label in the code, name it as an answer to the Q:
"What will be done if I goto *this* label?"


Here it is something like 'out_calibration_stop_and_reset'
(I haven't checked the real code and datasheet, just used below short context).

> +	stm32_adc_clr_bits(adc, STM32H7_ADC_CR, STM32H7_ADCAL);
> +	stm32_adc_set_res(adc);
> +
> +	return ret;

-- 
With Best Regards,
Andy Shevchenko


