Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCA637F729;
	Tue, 21 Jul 2026 10:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784630819; cv=none; b=Zrzk51tOjHlEUm6apXLmkhpKD4apxdbkWHIdxhNUCQcs5f3goAWDY1SbIge761vMw9tuKwAa3+nSFg0ZSbPcWb3voDiqV2UB3BBpmMGkavY2kwOzteR+io4wh2cR/TYbBSL7D1LWCRNeAsUWJBcrh2B2lgsH1PCwJwntBMsdFCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784630819; c=relaxed/simple;
	bh=3LvY0jIDyubfhJysisQ3Pd7plsZEArEau3djJTlyXmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D44iYKi+CQApdeiKOqK8r+fP6QP0ECPvVUHbZAqIx61z6BWdLxA8OzXBDvpg57FyLaX76Jv61f4bCxeBjAaOq1QJnsVOlDBp+H++fhvnFglk5DKYDecd8GqLOHcGp25tciEJGuf22vk8yPfPDivfzT9bY8ctYxd47f5QuP2SBnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RRKIUdkJ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RRKIUdkJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784630811; x=1816166811;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3LvY0jIDyubfhJysisQ3Pd7plsZEArEau3djJTlyXmk=;
  b=RRKIUdkJWyUg5XESbYlzamLL7t435hk2ua5JEIad+iY+t19iTLy5wq4P
   OTH7sdb2smlJhJAAzK+KgQi8hN9E/FGtGHiIBUScjg4iV7b5xjBQPrkUx
   xIIS3DERXbGL+lGmApmz2OYO5Nfxrv6S30zEeVirNxPACoYIzOZEVtucB
   o1ugGu7qn+8zhAdI5OfddsctwbWQFqIlotK0v7HpgzBNX8hNooSRDKZjK
   poMfq/EK3+nR4Y1HCyCqi9RJBeWZfxKag9o9uJgc5Y8APo5+C1N0VyEQB
   V92Stgtr41IMDKAT6AyJwD9qgRdpWYRx4O//vMDgBpp/fWnPew7zzMQE1
   g==;
X-CSE-ConnectionGUID: kt5VLDLCQzqfR6niVckCag==
X-CSE-MsgGUID: TY1hBDC7QLGlrrXQmsquWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="96587243"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="96587243"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 03:46:43 -0700
X-CSE-ConnectionGUID: wOmUUl54Q5Sc6FVVDhmgAw==
X-CSE-MsgGUID: jMttIXbjT/OtQTCfTYZZJw==
X-ExtLoop1: 1
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 03:46:39 -0700
Date: Tue, 21 Jul 2026 13:46:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Yu-Chun Lin <eleanor.lin@realtek.com>
Cc: linusw@kernel.org, mwalle@kernel.org, brgl@kernel.org,
	tychang@realtek.com, wbg@kernel.org,
	mathieu.dubois-briand@bootlin.com, nuno.sa@analog.com,
	Michael.Hennerich@analog.com, jic23@kernel.org, andy@kernel.org,
	u.kleine-koenig@baylibre.com, dakr@kernel.org, bhelgaas@google.com,
	o-takashi@sakamocchi.jp, dlechner@baylibre.com,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux@analog.com, linux-iio@vger.kernel.org, cy.huang@realtek.com,
	james.tai@realtek.com
Subject: Re: [PATCH v6 5/8] gpio: regmap: Add gpio_regmap_operation and
 value_xlate support
Message-ID: <al9ODO4j0y3hgb-D@ashevche-desk.local>
References: <20260721065802.689530-1-eleanor.lin@realtek.com>
 <20260721065802.689530-6-eleanor.lin@realtek.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721065802.689530-6-eleanor.lin@realtek.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 21, 2026 at 02:57:59PM +0800, Yu-Chun Lin wrote:
> Extend the reg_mask_xlate callback with an operation type parameter
> (enum gpio_regmap_operation) to allow drivers to return different
> register/mask combinations depending on the specific GPIO operation.
> 
> In addition, introduce a new optional 'value_xlate' callback. This routine
> allows drivers to translate or modify the register value and mask
> immediately before a write operation. It is particularly useful for
> hardware that requires additional control bits, such as a write-enable bit,
> to be appended to the data dynamically.
> 
> Consequently, update all existing drivers utilizing the gpio-regmap
> framework (across drivers/gpio, drivers/iio, and drivers/pinctrl)
> to accommodate the new reg_mask_xlate function signature.

...

> +/**
> + * enum gpio_regmap_operation - Operation type for reg_mask_xlate callback
> + *
> + * This enum is used to distinguish between different types of GPIO operations
> + * so that the reg_mask_xlate callback can return the appropriate mask for each
> + * operation type.
> + *
> + * Value operations:
> + * @GPIO_REGMAP_GET_OP: Mask for reading direction to detect if GPIO is input or output.
> + *                      Used in gpio_regmap_get() to determine the GPIO direction.
> + * @GPIO_REGMAP_IN: Mask for reading input value. Used when GPIO is configured as input.
> + * @GPIO_REGMAP_OUT: Mask for reading output value. Used when GPIO is configured as output.
> + *
> + * Output operations:
> + * @GPIO_REGMAP_SET_OP: Mask for setting GPIO output value.
> + *
> + * Direction operations:
> + * @GPIO_REGMAP_GET_DIR_OP: Mask for reading GPIO direction (input/output).
> + * @GPIO_REGMAP_SET_DIR_OP: Mask for setting GPIO direction (input/output).

> + *

Unneeded blank line. Also not the big deal. Update only if new version is needed.

> + */
> +enum gpio_regmap_operation {
> +	GPIO_REGMAP_GET_OP,
> +	GPIO_REGMAP_SET_OP,
> +	GPIO_REGMAP_GET_DIR_OP,
> +	GPIO_REGMAP_SET_DIR_OP,
> +	GPIO_REGMAP_IN,
> +	GPIO_REGMAP_OUT,
> +};

-- 
With Best Regards,
Andy Shevchenko


