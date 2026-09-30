Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12EC44A40B;
	Wed, 30 Sep 2026 08:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790757237; cv=none; b=fpz14Jp9tzLPCRfI9FkiQ27GT2/WgMvoJKGjQJIreF7AgJjLZiVL/Em3nQHVJdk3vxoTbWBegc8Mp/qKxoxnK3uVHpsrmcjAlWhNP1OQfqz9vv4hbHFZPyVEmW5py3Fmr/spCf80XjGlVIXwlGIPCxi2P3swDbwLh1fOwhTCtiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790757237; c=relaxed/simple;
	bh=MMtdk41NBB+Qc3t0U9od8tLeaTfZYIc2vmIwOCe7IgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZqwHUlOE1cccXW1YPWVhl8F4UgBVZ//yMCQMoyC/lXG3tjdKdint7iJbCv/mtdWPu66gF+U7SuyLkfiu7e795fLJBsS73uVRCryHXu3o4r2hf0uAEAwwGB92s9RqUYppTvtavZ9oeTateRv5JvcZad6ikZIPmXhW0dHKLU0diM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hkB5m3tN; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hkB5m3tN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790757231; x=1822293231;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MMtdk41NBB+Qc3t0U9od8tLeaTfZYIc2vmIwOCe7IgA=;
  b=hkB5m3tNy39Snvzy2IqYbgOYOQd6S4dVtvgYdwdi+NYMsxaMpzIaIhBq
   M8qW1XCxXa12ncgO8/rXri8r784NVAw/e7DCZCubGFpQabADW3mMbW/lK
   hYyc9FPJ/S98w5lyKzWedDrxsBbPJQDR7iKLEtGokig+InupSgSixUvom
   BZs4GvpCdiIHw1v2no56EH8Pgx1SeT3qVbOgaF+euX8emtNcIVCbkYTs4
   fZz+3WQRZReUTbiu6pfT8kuIyzuceaHMWBP1l1D06OyAa45hFD9LWqRKc
   eA1gS3U+pLKibDL3izByHSLZJYxKVWDbZgDQSG2WKMjS73mKVm6bmnVVk
   w==;
X-CSE-ConnectionGUID: xkD0SSvqQyqD3qF2OAA+3g==
X-CSE-MsgGUID: IHW2AefqSKu9NXL50mTD9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90443707"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="90443707"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 01:33:44 -0700
X-CSE-ConnectionGUID: T7JBMI1SSi2mJ6wrZLV/ag==
X-CSE-MsgGUID: LajcXhi9TGmpIrpaZz5Xuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="274233722"
Received: from spandruv-desk1.amr.corp.intel.com (HELO localhost) ([10.245.245.137])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 01:33:40 -0700
Date: Wed, 30 Sep 2026 11:33:38 +0300
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
Message-ID: <arzJYg3cg73vYCOE@ashevche-desk.local>
References: <20260923-adc-stm32mp25-v1-v2-0-46bc019537c6@foss.st.com>
 <20260923-adc-stm32mp25-v1-v2-7-46bc019537c6@foss.st.com>
 <arWPjx-JKt1IZCZl@ashevche-desk.local>
 <8fd19ab1-6ec4-49d7-aadc-accec6e71410@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fd19ab1-6ec4-49d7-aadc-accec6e71410@foss.st.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 29, 2026 at 06:48:28PM +0200, Fabrice Gasnier wrote:
> On 9/24/26 23:01, Andy Shevchenko wrote:
> > On Wed, Sep 23, 2026 at 05:39:10PM +0200, Fabrice Gasnier wrote:

...

> >>  		.compatible = "st,stm32mp13-adc-core",
> >>  		.data = (void *)&stm32mp13_adc_priv_cfg
> >>  	}, {
> >> -	},
> >> +		.compatible = "st,stm32mp25-adc-core",
> >> +		.data = (void *)&stm32mp25_adc_priv_cfg
> >> +	}, {
> >> +	}
> > 
> > Same issue and now it's a regression from maintenance perspective: you added an
> > unnedeed churn that has to be handled from now on... TL;DR: do add trailing
> > commas to the non-terminator entries and remove trailing commas in the
> > terminator entries.

> Do you wish I add a separate cleanup patch for existing match table ?
> This can also fit into 100 chars line now:

This is, of course, is up to you, but my comment was solely against the
trailing comma removal.

> static const struct of_device_id stm32_adc_of_match[] = {
> 	{ .compatible = "st,stm32f4-adc-core", .data = (void
> *)&stm32f4_adc_priv_cfg, },

Here is actually the opposite, no inner trailing comma should be added as it's
a one-line entry.

> 	{ .compatible = "st,stm32h7-adc-core", .data = (void
> *)&stm32h7_adc_priv_cfg, },
> 	{ .compatible = "st,stm32mp1-adc-core",	.data = (void
> *)&stm32mp1_adc_priv_cfg, },
> 	{ .compatible = "st,stm32mp13-adc-core", .data = (void
> *)&stm32mp13_adc_priv_cfg, },
> 	{ }
> };

> >>  };

-- 
With Best Regards,
Andy Shevchenko


