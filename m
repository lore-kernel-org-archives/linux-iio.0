Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794899706;
	b=ELeMj0pZxA8CDPWx9L7MhO+PFzYX45Dr+VfVl1NJGq/y+em3cOdTGPf6wZIj2uPHd57O
	 UCPJI6zv+d+hoj66VSpE1PTHDZG65LQ7i4nKWhuu2ha3w3Ae1U3BFf6wrJa8n3VPYTe6w
	 723fyttYm95nkcpSfG9VkhJ88VqF73F0dI2LpMVOgnJVKjmkreHG27qcGTqqdEO++icvI
	 ZmkPo98SBmqrj4mKCyfMz2h1AXCAZwvbFiadkj9Wz2lFEBSX0IYT5jZ/Z/5IdHFLb9yAS
	 FswN33Sy0XGNS63ljZF+UZBKJqbAL6EpQF0zOSrs0ncS/UXUjJynZmpoNUK7scMEcvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794899706;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=FTbJEAhqZIW4NLhm9jKEdLqW9ExXzaFWa84qqGKJy7c=;
	b=Fr+GoHNPZ25bkKxuAZn4lcHP8Jz9WyOdd4H3eyqtwv48ewzlCLjQ/vCmSoHRDhGnQwww
	 9eTv850OgCCPxiOy9qzEE8f++0f4XMHCHdOIUtTXAKBH5lmZksjqzpiJ8zpyoQ5EeCfP5
	 BB7dtBmRsQZE5EPfIM/JYX9X99lSEG7TgQQ3M1ALgDf7RPMQS0ZpIZlVEEVS4u3jWLInT
	 sG9rO9+tlGzC7xsx7uo4IDI1Ag24wi9JuErwe224NdsfFdqzv9JlVIVZHgsVC08H5Xk5H
	 Hvv0qwx8ubq6uKJ8PX2S2ULMdDfEuwQIzNHEATPInIF7w0WbFKDisKwEaJrtuUsqf6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=APx97lIS;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E507606A336;
	Tue, 17 Nov 2026 07:15:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E507606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=APx97lIS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794899705; x=1826435705;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fZqhVkjqwdNlur7QBA2RZUDCkBynb9PS3UgexHcsD0s=;
  b=APx97lIS/2i7RVYV77HyxH3aaQOQ5NTammwBy2NE3x0gUA67RGxtW2R1
   l3DtJDt2hqyLpX6mqif8g+Rxo/TylUTD1Rhn3UtxLqaUvBQKpAs2lx5Ke
   EALyy2T5I2F2EgEhMaqAlDBZ9DoRlvKSoBqnjWZ+994H85SIjZbGJ4GnS
   mC/qZdMIzEp1Dtpgmmqx04RNaF/Pn1NjnK0v1QbknNhFo0cWAB5qVWZya
   b/GfQe7okPkeNHYqUqD/ACXwSOMMmwH9G9m/wyjWDXt1dy+Rjmjl2se2+
   yK1M5iZGqEaZiO6k8n6NvQi2x9hQs+aEPSDxnpGh9lGR6odfBLUol1WNj
   A==;
X-CSE-ConnectionGUID: cd69gsmASIiDGjrhEFS9bQ==
X-CSE-MsgGUID: k4nfjh5NQa2+8tyyBKeiiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3699546"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3699546"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 23:15:04 -0800
X-CSE-ConnectionGUID: TMQ8AhdWQNibrVZIKm7Mng==
X-CSE-MsgGUID: 9HT4e7rSTR+dUf2/DaWitQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9809880"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.254])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 23:15:00 -0800
Date: Tue, 17 Nov 2026 09:14:57 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, mfd@lists.linux.dev
Subject: Re: [PATCH v2 3/4] iio: adc: Add support for MAX8907 ADC cell
Message-ID: <avv-8RT_btJ6dTzi@ashevche-desk.local>
References: <20261115091120.108684-1-clamor95@gmail.com>
 <20261115091120.108684-4-clamor95@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261115091120.108684-4-clamor95@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Nov 15, 2026 at 11:11:19AM +0200, Svyatoslav Ryhel wrote:
> The MAX8907 PMIC has a dedicated ADC cell, which provides 8 ADC channels
> with information about different parts of the power system, including the
> battery, charger/plug, jack and thermal readings.

...

> +config MAX8907_ADC
> +	tristate "Maxim MAX8907 ADC driver"

Make MODULE_DESCRIPTION() to use the same text.

> +	depends on MFD_MAX8907
> +	help
> +	  Say yes here to build support for 8 channel 12-bit ADC
> +	  interface found in the Maxim MAX8907 PMIC.
> +
> +	  To compile this driver as a module, choose M here:
> +	  the module will be called max8907-adc.

...

IWYU, please. + bits.h, types.h, et cetera.

> +#include <linux/iio/iio.h>
> +#include <linux/module.h>

> +#include <linux/mfd/max8907.h>

It's better to move to a separate group, as this is related to the certain HW.
But since it's a single header I'm not too picky about it.

> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>

Should be also a group for asm/byteorder.h.

> +#define MAX8907_TO_REG(n)			((n) & 0xff)
> +#define MAX8907_TO_MEASURE(n)			(((n) >> 8) & 0xff)

...

> +enum {
> +	TDIE, THM, ISNS, VMBATT, VBBATT, VCHG, AUX2, AUX1

Leave trailing comma, but what is this? Is it HW related or pure Linux
abstraction? In other words, is the order strict? Looking at the code
below I think you have to initialise all of them to make the order strict.

> +};

...

> +static const u32 max8907_default_ref[] = {
> +	[TDIE] = 4096,
> +	[THM] = 4096,
> +	[ISNS] = 4096,
> +	[VMBATT] = 8192,
> +	[VBBATT] = 8192,
> +	[VCHG] = 8192,
> +	[AUX2] = 2500,
> +	[AUX1] 4096,

Funny thing, actually we used to have an interesting case in the kernel,
id est 113ec87b0f26 ("pinctrl: npcm8xx: Fix incorrect struct npcm8xx_pincfg
assignment").

> +};

...

> +static int max8907_adc_init(struct regmap *regmap)
> +{
> +	u32 value;
> +	int ret;
> +
> +	/* Enable internal voltage reference. Exact purpose of bits is not known. */
> +	ret = regmap_update_bits(regmap, MAX8907_REG_TSC_CNFG1, GENMASK(1, 0), BIT(1));
> +	if (ret)
> +		return ret;
> +
> +	/* Check for internal reference IRQ */
> +	ret = regmap_read_poll_timeout(regmap, MAX8907_REG_TSC_STA_INT, value,
> +				       !(value & MAX8907_MASK_NREF_OK), 0, 1000);

0? This makes it a tough loop. Needs a comment why.

> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(regmap, MAX8907_REG_ADC_SCHED,
> +				  MAX8907_ADC_SCHED_AUTOSCH_ENABLE |
> +				  MAX8907_ADC_SCHED_AUTOSCH_TIME,
> +				  MAX8907_ADC_SCHED_AUTOSCH_ENABLE);
> +}

-- 
With Best Regards,
Andy Shevchenko


