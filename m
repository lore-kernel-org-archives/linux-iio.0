Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930F433507D;
	Fri, 20 Feb 2026 08:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771574981; cv=none; b=sOjIW0ZDM1E87LNiAjelPJQA6BoSH3yWPT9dv80uUMe8Vfxczdecf9l1T6X3WtAS60aoIvpGmG63V9npNhzXVYLCwkWvWoQooao2OrMRmLd1WtmOSjDP0auXwmvc2hfKbV5Pzl8rnY/+gez+OUvA4WTHupS+Q3uX6xXPPu0s26g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771574981; c=relaxed/simple;
	bh=k+Nn6h3w6tcNXtGfFrHNQpODw0l7JijVpV0PqpUPkDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqb43xUHsODzk2xF0lzwBsxU0B42tvAmvTauzjA8AoV/rUo7iCmaZp3XCUlsHutuQiDnuI4JndMDOAHTsUeUBV3sOo5pgG4TdU3MxbgaFTMV7uqKQRy/oNm/fc2u/BWV5l5ti6jjf87bGXPjwtFrnBu3TU5dtXXW/L3g0+XaTyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K7MisqLF; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K7MisqLF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771574981; x=1803110981;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k+Nn6h3w6tcNXtGfFrHNQpODw0l7JijVpV0PqpUPkDI=;
  b=K7MisqLFYgb7RwGZq+SUn0UyyBx3ssdHx7c99JljyeUMUAnwhSrirT8v
   UJVzgkKfnH64M7j4/8meqiREqpVwXJA8qXt9DusH+fPY5k1nqZlac0cRy
   zeqlm/WMsjZRT0hFs/x5evijOQ5tO0UXpF+tagTyv1IwuEBhrPEyYz9ry
   /rfDVkKKT4sdLXS38Xiuguap6FkCHYvggRaEAdn+KtvgwS2uKbR+Mh95j
   f47WucJBInhYo3qUKo5hHkZo5J5S2sQUsU5NuXarOtKr6Ko27qNp7nzBi
   mJnviVqUv5AyDjCiwup3JaLwdBAEoDhEd735OdgMMOEjiA4Pdr6oRf+CY
   w==;
X-CSE-ConnectionGUID: maRGwUfqRUG6GQ8i9voJXA==
X-CSE-MsgGUID: Dr6kLfPkRbGFBD1uXTPDEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="72370100"
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="72370100"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 00:09:41 -0800
X-CSE-ConnectionGUID: Bu6Ho8eLSmaxjN84JdfduA==
X-CSE-MsgGUID: oDSMhlRYTg+Px/GACX7hTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,301,1763452800"; 
   d="scan'208";a="219796663"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.25])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 00:09:37 -0800
Date: Fri, 20 Feb 2026 10:09:34 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, saikrishna12468@gmail.com,
	git@amd.com
Subject: Re: [PATCH 3/5] iio: adc: xilinx-xadc: Replace module macro with
 custom init/exit functions
Message-ID: <aZgWvjWBusT_JQgE@smile.fi.intel.com>
References: <20260220053941.611415-1-sai.krishna.potthuri@amd.com>
 <20260220053941.611415-4-sai.krishna.potthuri@amd.com>
 <aZgS2c45nGTozHkv@smile.fi.intel.com>
 <fab2599c-e749-4aa1-8157-c7ac358c6f36@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fab2599c-e749-4aa1-8157-c7ac358c6f36@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 20, 2026 at 08:54:26AM +0100, Michal Simek wrote:
> On 2/20/26 08:52, Andy Shevchenko wrote:
> > On Fri, Feb 20, 2026 at 11:09:39AM +0530, Sai Krishna Potthuri wrote:
> > > Replace module_platform_driver() macro with custom init and exit functions
> > > to prepare for supporting multiple bus interfaces (platform + I2C).
> > 
> > No, this is not how it should be done.
> 
> And how should it be done? separate file?

I answered somewhere else, but I can elaborate here as well.

The idea, yes, to have the driver in the parts:
 _core.c
 _platform.c
 _i2c.c

To achieve that, it needs first to split the driver followed by likely
conversion to regmap. With that done it may be used in i2c with a little
code added into _i2c.c.

We have examples in kernel for that.

0daede80f870 ("i2c: designware: Convert driver to using regmap API")
fcb82a939df8 ("i2c: designware: Add Baikal-T1 System I2C support")



-- 
With Best Regards,
Andy Shevchenko


