Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751313BFE50;
	Thu, 10 Sep 2026 06:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789021140; cv=none; b=esMxGSwjUBcZCC6SAGUAAwozfoOZlRuRkNqidzyD+Z2tCTCvlr4WQs0tp82IoCh/aORTFUzTMY41d5y/9jyDX7wluf5VU8IvSxTAjgr8dcQRlwtfOzk5ciUE6HiRZzj/Ns6XL/KSUjTQDkQ4xIUCns+X1P0dp4b/8IEDryYxnOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789021140; c=relaxed/simple;
	bh=4Z2aNs/WtsBom8rfZQn9lhOGeiji611YV6/m2sscbYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=koTgrMxOlsJpDvSnaDVehgfoompdDEUbVqq2Qz70ALTZ4bSCfD29Ht2rfwya1Js1pWcqOnxz78rWTvV4o7vZy++Vf5cKOTGmmuNoRGw8m9R6nxnYXftD2O9kYILkb/dg01jhB1u1IcdcBGgMRs6fK3RlGb0V5FG7/BIhytX3r24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f0NTZLM6; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f0NTZLM6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789021135; x=1820557135;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4Z2aNs/WtsBom8rfZQn9lhOGeiji611YV6/m2sscbYE=;
  b=f0NTZLM6gXLVWVFDFSQs3e/IaEixe18SHQOpDjHGG15mpXSZQlOpnMuA
   ygpBdMsUXycAiE9fXgE9kll/M36b3qBwIhjs2pnSU4A3MY2urObFnhvzX
   FervEG9SxjRVzvSf+nXxrXocLV5Kko1xVaW0hblmrhFWhjZHQgl8yZiSp
   H9QuVsKe5+xlnYUr5ZJvOQRTHGSEhl3QYgP0+wmIeMm+77uS08s1GQ9VC
   6/TTCIE+UDXGHif9ffk/ndH7/uXrc9kbude7sQksEGaSFG2ZVbDkAaCzS
   R3wG1uSjWRZeM9+rgfwLj16ptxzuuPskKZfsq/UhLjpsfPTuxz/xMThBe
   A==;
X-CSE-ConnectionGUID: SxjPh/AWRSevctWoC/Bw+w==
X-CSE-MsgGUID: vZNCkCGcRt+RfHG0A7OnNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="112233692"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="112233692"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 23:18:42 -0700
X-CSE-ConnectionGUID: kRTYCzrMSQ6t2m3BddUnDg==
X-CSE-MsgGUID: aHqKcekzSkaTybY/GMagtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="276778970"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.177])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 23:18:39 -0700
Date: Thu, 10 Sep 2026 09:18:37 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 00/10] Refactor Microchip MCP47FEB02 I2C driver in
 separate modules to add support for MCP48FEB02 SPI driver
Message-ID: <aqJLvet2-6YUDYDF@ashevche-desk.local>
References: <20260909-mcp47feb02_refactor-v5-0-8b67bcab93d1@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-mcp47feb02_refactor-v5-0-8b67bcab93d1@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 09, 2026 at 05:18:43PM +0300, Ariana Lazar wrote:
> Refactor I2C driver implementation into separate modules in order to add
> support for SPI MCP48FxBy1/2/4/8 DAC family on top of the I2C implementation.
> The I2C and SPI devices have the same memory map and supported
> functionalities.

> ---
> Changes in v5:
> - improve commit messages by justifying the changes made
> - increase polling time for EEPROM writes
> - delete unnecessary comments and extra blank line from header file
> - Link to v4: https://lore.kernel.org/r/20260819-mcp47feb02_refactor-v4-0-beb2aa3bfd09@microchip.com

I have a felling that the first few patches are actual fixes and they lack of
Fixes tag (and possible Cc to stable@).

-- 
With Best Regards,
Andy Shevchenko


