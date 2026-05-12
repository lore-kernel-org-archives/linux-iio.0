Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38F32C15BE;
	Tue, 12 May 2026 11:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778584832; cv=none; b=D+rNATS02b71GMPX4jNw1XEV7vO73No3Rke52WUZwfnU6dmXgEYIwxoPjC3aXREQ14Ud+j6YDwNC96LPP9/m2dICXiyQSx3ZUJf1guGBa6wIWK9Q8MQzxw8xlcSMzvU8KHmk0H+svXccmMwlWZ8AtR22YSKkhkXfpwAbTQj9IBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778584832; c=relaxed/simple;
	bh=TGiDaSQhQRSB081/ItP6wnZ2UDfNrEKeW34ihRjMV6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kw2lbMZKAe8Pfm4BLtg4N8Jzse3DxzzG44RVV9XQZb1zw661gnVqAVnqkCr4jOLNqp63+GGTP2974eOPldR/x8/lpKR2VXlH2AGSSSCaIIDEtYFIIFw2kerpHsJL+jLvBqqnhi0mVjcXz9xthApDb8BHKr2PRNKVRSdM2g6mS+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AxnA7a25; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AxnA7a25"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778584831; x=1810120831;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TGiDaSQhQRSB081/ItP6wnZ2UDfNrEKeW34ihRjMV6Y=;
  b=AxnA7a25BccuCOZzd3QTzbwGvHLCFE8KaUoABtV1z3YavI5MMYWoiOet
   ZI2/IYlaZyjqhKIXZtnt7t5oY7JpG42WQv7losGRgDNYpAtK75WFAI2Vv
   h1bRLNCTHua/vTjNljcuoLGwbQ7NOIWQN2p75oQrG1clYmhWuXynWhqi3
   9zA8jHFFBrzQhXbhRn6WSz2bFBfJJRDWQbevEmLrHoBMeTXbNa8Q/DL88
   EHfpSUUf6FaozbuOUj/Ku+mPtBMX6HWfpM5u/l+v0OevfGoWl81igB7I6
   s9z0yKRBzlvlf7KlxOpQKQKXRytpxbMzNJZhwu3jAPnMyf/fYqGxJN/e+
   A==;
X-CSE-ConnectionGUID: xn0DGKlhTueuX0tCwiyL8g==
X-CSE-MsgGUID: pFUt4vYOTx6R0RRN75S1IA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79207659"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="79207659"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 04:20:30 -0700
X-CSE-ConnectionGUID: LlvnaGIsSGOpgmZ9mdtdmg==
X-CSE-MsgGUID: 6nvCmJoMQA6pQGsIBkQzcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="233432777"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 04:20:24 -0700
Date: Tue, 12 May 2026 14:20:22 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Yu-Chun Lin <eleanor.lin@realtek.com>
Cc: linusw@kernel.org, brgl@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, afaerber@suse.com, wbg@kernel.org,
	mathieu.dubois-briand@bootlin.com, mwalle@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	nuno.sa@analog.com, andy@kernel.org, dlechner@baylibre.com,
	tychang@realtek.com, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-realtek-soc@lists.infradead.org, linux-iio@vger.kernel.org,
	cy.huang@realtek.com, stanley_chang@realtek.com,
	james.tai@realtek.com
Subject: Re: [PATCH v3 2/7] gpio: regmap: add gpio_regmap_get_gpiochip()
 accessor
Message-ID: <agMM9soiqpG-TRSb@ashevche-desk.local>
References: <20260512033317.1602537-1-eleanor.lin@realtek.com>
 <20260512033317.1602537-3-eleanor.lin@realtek.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512033317.1602537-3-eleanor.lin@realtek.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 12, 2026 at 11:33:12AM +0800, Yu-Chun Lin wrote:
> Expose an accessor function to retrieve the gpio_chip pointer from
> a gpio_regmap instance.
> 
> This is needed by drivers that use gpio_regmap but also manage their
> own irq_chip, where gpiochip_enable_irq()/gpiochip_disable_irq() must
> be called with the gpio_chip pointer.
> 
> Add gpio_regmap_get_gpiochip() to allow drivers with complex custom IRQ
> implementations.

Hmm... Can't we rather add gpio_regmap_enable_irq()/gpio_regmap_disable_irq()
that take regmap or GPIO regmap (whatever suits better for the purpose) and
do the magic inside GPIO regmap library code?


-- 
With Best Regards,
Andy Shevchenko


