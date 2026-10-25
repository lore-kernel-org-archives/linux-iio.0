Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792959507;
	b=Yehey8RSwmxHrYLmr2a/3fS8alLLZoKc2ARC/Rm9bZlKmvThjjMONavJbBVQ8tcj8ui3
	 exMHdb093MgNPLMn4e/OPolRyqnCf17Z7ZD622UWOJfJug+Fwl/23mstN20Gq4HmsKuHT
	 472IXrX4pycOVeY7iWC30HeOSo/jXzSJPUpyCoy7EaiAEPBJ/+J0Exvtbz/D7ilq6wTqm
	 4dlgECha6e75CWdIvSimos4xWyXbJ2nhayum06AQGz4ZYA2zQMi0zLCEPsN9BCSHDFH3x
	 RO1oczxYS0tzj5C+L8GCW2HMW5dRccXMpo3+4W9Ed0VksOUZ5rIKyGRJkLQU6F1kV3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792959507;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=gKlDBGCbH7yrkloneHjgkrYgA1FmKQUMTNRJgiOOaws=;
	b=jTxOjCs0GKEGqZ1qWsggNbNSmMfkuwWi4n5YAThUARzNskNOZ7gHeR4cqcTSO00zmRnL
	 oWIPQbXUA8okOk7BAtk3KCocndo5gwq/P+ddAZ3AtHgyHqRzEWkJzHR+0FANciMEkn8AF
	 b6UoJkiS1lwUJ8bOoAmNmolA/Esbl0zRLg2S6hn2PxlqJlBg+CSZamcJDRgkv8PA43Zit
	 kSN7l7J5HBJEc7/DHf8Zx8/NlAPPaoPsgHHuInW+XrpVxnyd46UBn8j9HNAXk2ahwFWvC
	 1Q8AxOs/qR3Fw1pMsRiTwpr2qbfR+ykB11VBRGbD5dBFO67UZVmOWzRrm47UfRvrKbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MZA7ePc4;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB4D606A31A;
	Sun, 25 Oct 2026 20:18:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DB4D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MZA7ePc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792959506; x=1824495506;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7WVWAs7SYa5fDFXgxFCwBxRVLtIZinVRwmFIpiC5h0Q=;
  b=MZA7ePc4zS/EsfSxHAhI0T8Fod16tmaaZkdoXjtsXdfq++NWiBp7CCjp
   W7arlpYP/sp5w/c+tudS8/MJkKk6KaZKsT8DtUMK78W8sApIq0YzWEXmA
   GHXycQtL+v8B3/3rkwlotWVV57K5tdF7a/E0tTfoSNr2GJwX2XdbUJguE
   PJZS3EB8uOBqSylMyKkthLSwse4KkGol6DMtTmFO8VKWFWesiX/ZzZhHp
   Mi/BmBGodd3LvKkfC8MocxMWMBiMn1z26YBLcKOCcTkZv4AmzfaCR7/Mp
   Jc1+Co9kMqQatSekP72Kt7HaDNEflS0VPatrbcPW66lvSdNHvXK4SXEuE
   w==;
X-CSE-ConnectionGUID: 037mxwaIS4aWYH/dfKUqGQ==
X-CSE-MsgGUID: IEOA2DIHSw6AQJyGyDWzPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1529075"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1529075"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 13:18:26 -0700
X-CSE-ConnectionGUID: 2MDbjEFvRgeyCu4A/zlUfQ==
X-CSE-MsgGUID: ayP8CrdYSUiNmF7vEEafAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="3994840"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.10])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 13:18:23 -0700
Date: Sun, 25 Oct 2026 22:18:20 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Stephan Costa Barros <stephanbrrs8@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] iio: adc: ti-ads1298: fix power-up and clock
 handling
Message-ID: <at5kDPzBIfwAGCNT@ashevche-desk.local>
References: <20261024231335.280955-1-stephanbrrs8@gmail.com>
 <20261024231335.280955-3-stephanbrrs8@gmail.com>
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
In-Reply-To: <20261024231335.280955-3-stephanbrrs8@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Oct 24, 2026 at 08:13:31PM -0300, Stephan Costa Barros wrote:
> Fix three issues with the power-up sequence and the device clock:
> 
> - The datasheet powers up the supplies first, then the clock, then
>   waits t_POR = 2^18 clock cycles (128 ms at 2.048 MHz) before the
>   reset. The driver enabled an external clock and the vref supply
>   before AVDD, reset right away, and did not wait for the 150 ms
>   start-up of the internal reference. Follow the datasheet. Probe takes
>   about 280 ms longer.
> 
> - The binding describes one optional clock and no clock-names, but the
>   driver asked for the clock named "clk". With a device tree that
>   follows the binding, the lookup fails, the optional getter returns
>   NULL, and a clock given in the device tree is never enabled, while the
>   sampling frequency is computed from the nominal 2.048 MHz. Ask for the
>   first clock of the node; a device tree with clock-names = "clk" still
>   gets the same clock.
> 
> - A command takes 4 cycles of the device clock to decode, the minimum
>   reset pulse is 2 cycles, and the reset takes 18 more. These were
>   converted with the nominal 2.048 MHz, so a command ends after a fixed
>   2 us, short of 4 cycles with an external clock below 2 MHz, which the
>   ADS129x allows down to 1.94 MHz. Convert them with the rate of the
>   clock in use. At 2.048 MHz the delays do not change.
> 
> The clock lookup was seen to fail on a Raspberry Pi 4, with a
> fixed-clock in the device tree. The power-up order was found by review
> and reproduced on an emulated device only. The decode time was found
> with an emulated device; it is not seen on hardware running at
> 2.048 MHz.

...

> +	clk_rate = priv->clk ? clk_get_rate(priv->clk) : 0;

Why this conditional?

> +	if (!clk_rate)
> +		clk_rate = ADS1298_CLK_RATE_HZ;
> +	priv->clk_rate = clk_rate;

...

> +	/* Power-on reset time, counted from when the clock is valid */
> +	msleep(DIV_ROUND_UP(ADS1298_TPOR_CLOCKS * MILLI, clk_rate));

Do you mean MSEC_PER_SEC?

...

> +	priv->rdata_xfer.delay.value = ads1298_clocks_to_usecs(priv,
> +							       ADS1298_DECODE_CLOCKS);

Indent it as

	priv->rdata_xfer.delay.value =
		ads1298_clocks_to_usecs(priv, ADS1298_DECODE_CLOCKS);

-- 
With Best Regards,
Andy Shevchenko


