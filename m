Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926395111AD;
	Wed, 16 Sep 2026 15:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572172; cv=none; b=uo8uQUfTXvSJmcv45EktRx6FL26gd6hq1316wPrWGXJX13uZ8MrK6k6A+MVzhBAZjRN/CF/9WkIT+88gCIW8QmGzZb3oIr+JrLGFfEysxYU3tN0zNLg8dJ4XCXJ7nXWAA9kCt/LgwbGwYxS6FjGAcb19h8uIOSg3VpIgU2Mnqmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572172; c=relaxed/simple;
	bh=jzRtSYoksLHY6s/FW90PYWZcawNIi4SGlE+Jml4M2mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxGuYAqRDQJ49TaM+GsVjoHP2smKUhUBCsitHVcezA/AIdigmih43j33jsy/+ELRRjYy2n5fW3qthl0nuhGPPHM+5J/1VICiP4mP8Dydip8Ygkl/8BIG5etFCXX3M/+S1myMQnX96eUNiHYs0NLNw6kWes22P4mpiKhs2f1lypk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HW+/WFw4; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HW+/WFw4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789572169; x=1821108169;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jzRtSYoksLHY6s/FW90PYWZcawNIi4SGlE+Jml4M2mM=;
  b=HW+/WFw4E2Yx2rzHESX/UIqf5jTsotuYvKHJFpBS21H8Qoz8K2ZpQe/j
   yFccjgy0BOOF55ilV3oUMMULwqLJL5CrErNq4bm04PxroRk/aIf+KOUY0
   yDj6RA+7/o0dsKyJhAviVe+9KtiJJD4og5WrQLn9Yvar2KYgPRGJQX8+f
   gBsxpzbw90rRgknHP40J0fFGd6IJWERhvY/D5REaJCxlDnWcw4ZEoRGn5
   KETPDNgpmjOwk8kO+s8/Tehtjx9+LPLgfh5aKUkNmHiQf4iKSKvej+k3u
   uq8OE1p/lvcaj2Aa4CZQONbNKIJ3iExIu9iwas9vNdbqxhDDR838ll4rd
   w==;
X-CSE-ConnectionGUID: LOx5p5ClRP+eFFutuA8MiQ==
X-CSE-MsgGUID: FFuMj93RR46/xzKBf7gL+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93823591"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="93823591"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 08:22:46 -0700
X-CSE-ConnectionGUID: jUjyDGFnTSGVbJFBQu7k7w==
X-CSE-MsgGUID: ZTsNaIA4R/SiCjJy1MpTYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="273906164"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.145])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 08:22:43 -0700
Date: Wed, 16 Sep 2026 18:22:40 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 03/11] iio: dac: mcp47feb02: use field_get() instead
 of custom dynamic macros
Message-ID: <aqq0QI6JM8GNBqsq@ashevche-desk.local>
References: <20260916-mcp47feb02_refactor-v6-0-285464651f89@microchip.com>
 <20260916-mcp47feb02_refactor-v6-3-285464651f89@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916-mcp47feb02_refactor-v6-3-285464651f89@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 16, 2026 at 05:16:29PM +0300, Ariana Lazar wrote:
> Replace manual bit operations which select channel corresponding bits
> from a control register in mcp47feb02_init_ctrl_regs() with field_get()
> macro used with masks already defined for regmap operations within the
> driver.

> Reported-by: Jonathan Cameron <jic23@kernel.org>

If it's a fix then better to add a Fixes tag, otherwise I would use Suggested-by.

> Link: https://lore.kernel.org/all/20260913224339.490d89ba@jic23-hlaptop/

Again, if it's a fix, this should be Closes:.

> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>

-- 
With Best Regards,
Andy Shevchenko


