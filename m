Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4F638B7CD;
	Tue, 31 Mar 2026 06:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774938470; cv=none; b=n4tFbvMv+98CiQeh+D/4zp1tn8vTkjOvna5DEV8UgMIO6kJPoq1iPM/cqbYIuMTwy9x2TsKDI8IXcp4myqIL/ALbP7TRB8XXoT2vk733KlLC4H01J9JHYs/A62Ul9dspnvtO3iQXmoiYFMM9/uo0Z7PyisUBklT834lnC67/X/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774938470; c=relaxed/simple;
	bh=3ayVFhSCxjupB2O9fO2RigfHf2mliUX4XaznGtg7Szs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMx6+jbNYl043tRmDTH+tIe4f6l5DtuBAFZcpcK5wZNRN8Fxw1urXrRROnKkWX8eLFw8mmMbikHh3BD7GjmEVFy61OlpkD+lSoxAbS8higYdj9CJB4RLKQDq2PbcWvtZ1WMAhZd6uBPWc7A172yeii3ljTBWNb35c7cL2txg2lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kK7g7Hzv; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kK7g7Hzv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774938469; x=1806474469;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3ayVFhSCxjupB2O9fO2RigfHf2mliUX4XaznGtg7Szs=;
  b=kK7g7HzvbgCZIpuLjN1XcIMMzqqwI7ZQZil6XT8QI4J+9Dr76CBKHeJ1
   nB72XGtyvMbB9O3tOXVORCs2k8X5eyytx05TYkoP/ugvj2+2DtzlSb7Ne
   LaJJE+AFFNQ3ebeSm7gOEOVGBUSPOtb/CJzAN6Ok7HOPpeXP5sdyYa23E
   iT36GLUkgaaK43Dt+jMJiPi/alAuzO2NG4FqeBeHFaI+8q5wZ677Z/Rel
   gVJqhtH0alt/tNxETORHhlzekfd8vximYEzcYBx6HZtH67YhaJE42wv6+
   XMHfmQiwzWErbiwYilGNGioWI/punm3+TpAmTKw14h5I0Dy3QsNKk2b78
   A==;
X-CSE-ConnectionGUID: P3MGKbgRRxS+JC9dlKHxTA==
X-CSE-MsgGUID: L84Fu5SjSxa5GOcJ3bVm0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="75113460"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="75113460"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 23:27:48 -0700
X-CSE-ConnectionGUID: NQcK/0R4SDCUqFgADnhTCw==
X-CSE-MsgGUID: AjoozeAcSWaTPjRQVEh5yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="221864358"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 23:27:46 -0700
Date: Tue, 31 Mar 2026 09:27:43 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: radu.sabau@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad4695: Fix call ordering in offload buffer
 postenable
Message-ID: <actpX0qnbbQYtbZz@ashevche-desk.local>
References: <20260330-ad4696-fix-v1-1-e841e96451b2@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330-ad4696-fix-v1-1-e841e96451b2@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 30, 2026 at 04:34:39PM +0300, Radu Sabau via B4 Relay wrote:

> ad4695_enter_advanced_sequencer_mode() was called after
> spi_offload_trigger_enable(), meaning a regular SPI transfer could be in
> flight while the offload was already active. When the offload fires its
> completion interrupt concurrently with the regular transfer, the SPI
> engine interrupt handler is not designed to handle both at once, leading
> to a kernel panic.

Please, provide ~3-5 (the most important) lines of that panic.

> Fix this by calling ad4695_enter_advanced_sequencer_mode() before
> spi_offload_trigger_enable(), ensuring all SPI bus accesses are complete
> before the offload becomes active. This is consistent with the same
> constraint that already applies to the BUSY_GP_EN write above it.
> 
> Update the error unwind labels accordingly: add err_exit_conversion_mode
> so that a failure of spi_offload_trigger_enable() correctly exits
> conversion mode before clearing BUSY_GP_EN.

-- 
With Best Regards,
Andy Shevchenko


