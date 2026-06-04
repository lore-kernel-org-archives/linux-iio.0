Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91962E65D;
	Thu,  4 Jun 2026 07:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780559943; cv=none; b=oGSx2faeeaxo5iy6VSyvOdK3s3NnwNk3ZKmKozjJA5FjPu1My0Hv0IRr9B6YHyQ+KhkRy7qihqMw7vmYD+jNdFBMm11Cxj7xpzTIeXb6EAouFADxJCTgItcwS46OUiUWrUA9sslyP6Z3nf8eAdQ3kWOZGpw6116XOjm8BK5KV/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780559943; c=relaxed/simple;
	bh=/2Y8ZUM2slpMBxKrMrCa4JVbzzaFNKK3bH/fmA1FtC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxAKAXx5arBMk3L8vc0vZzIDvsP3li7pdv+hh+o5Sp7PFPCCCJnEbgO44+oFbKEudnbluPPzGPmpofJ7/qnDxgUT+V/VvuicrsCw3DM0fQWu4NQCfYNrMcAxCyB4fqwysDdKQGuUn9pbt5PJqhNxckf9Y1CZd3EglpPlcnZZ4OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GTSO3LsG; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GTSO3LsG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780559942; x=1812095942;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/2Y8ZUM2slpMBxKrMrCa4JVbzzaFNKK3bH/fmA1FtC8=;
  b=GTSO3LsGkR1r8lvX1gUNPSyBkaEK5tkwJYYrELhAz2tQbPvgm5vlBD7g
   NoY8/x4k+HCiB4bnnh13KzQDlc3QN05jrMFMvZhrVfPQ5az3gwxZGkWBM
   jwtruS/3xENZjFDbMrLNb6zsdKSLFIgBWUnq9nLrSPZDw59h4oGIxmcgX
   drS4fIePazcmYwo7HVI4om76n+Rs8h414xWRkS4nWRU7Q8RQcTl8gxzHy
   oAKGer7+b8iEB9K2utAPjIsBqF+tAd0Jh/Lc2oI20BvAm66GUSQeqc2jN
   BDT6uKJKWIzkocagclja+rw9Z+a+d7IOOW5Vl0Cv8pRf2cTPW6tw8uQGZ
   g==;
X-CSE-ConnectionGUID: s2PJgF4WSXmJD6O4w6z2HQ==
X-CSE-MsgGUID: 5VK15jgKTtWPts+iV7dNOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="98802002"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="98802002"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 00:59:02 -0700
X-CSE-ConnectionGUID: C6PNSqS7SIaJ7Tl1IYh/aA==
X-CSE-MsgGUID: ELWEmfB6TAaL/rOevhFtWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="241977046"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 00:58:58 -0700
Date: Thu, 4 Jun 2026 10:58:56 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v3] iio: dac: mcp47feb02: Fix passing uninitialized
 vref1_uV for no Vref1 case
Message-ID: <aiEwQLq1RQW1OfZq@ashevche-desk.local>
References: <20260603-mcp47feb02-fix4-v3-1-ed09975cad15@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603-mcp47feb02-fix4-v3-1-ed09975cad15@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 03, 2026 at 05:44:48PM +0300, Ariana Lazar wrote:
> Ensure that if a device has Vref1 but reading the regulator returns an
> error, mcp47feb02_init_ctrl_regs() is not called with an uninitialized
> vref1_uV value.
> 
> Also add a device_property_present() check for the Vref1 supply before
> reading the regulator.

...

> +static void mcp47feb02_regulator_disable(void *d)
> +{
> +	struct regulator *reg = (struct regulator *)d;

Unneeded casting, then for the maintenance it's better to have assignment and
definition to be split as we have a validation check.

> +	if (reg)
> +		regulator_disable(reg);
> +}

With the above being said, there are two alternatives:

static void mcp47feb02_regulator_disable(void *d)
{
	struct regulator *reg;

	reg = d;
	if (reg)
		regulator_disable(reg);
}

OR (my preference)

static void mcp47feb02_regulator_disable(void *reg)
{
	if (reg)
		regulator_disable(reg);
}

...

> +static bool mcp47feb02_ref_mismatch(struct mcp47feb02_data *data, unsigned int ch)
> +{
> +	bool use_vref, use_bandgap;
> +
> +	if (data->chdata[ch].ref_mode == MCP47FEB02_VREF_VDD)
> +		return false;
> +
> +	use_vref = (data->phys_channels >= 4 && (ch % 2)) ?  data->use_vref1 : data->use_vref;

Too many spaces.

> +	use_bandgap = (data->chdata[ch].ref_mode == MCP47FEB02_INTERNAL_BAND_GAP);

(Unneeded parentheses.)

> +	return use_vref == use_bandgap;

I would rewrite this as

	bool use_bandgap;

	if (data->chdata[ch].ref_mode == MCP47FEB02_VREF_VDD)
		return false;

	use_bandgap = data->chdata[ch].ref_mode == MCP47FEB02_INTERNAL_BAND_GAP;

	if (data->phys_channels >= 4 && (ch % 2))
		return data->use_vref1 == use_bandgap;
	else // redundant, but left for the formatting purposes
		return data->use_vref == use_bandgap;

> +}

...

> +				data->phys_channels >= 4 && (i % 2)) {

This idiom is repeated so many times that I would rather see

static inline bool is_...(data, ch)
{
	return data->phys_channels >= 4 && (ch % 2);
}

and be used everywhere. If required, add also a comment on top to explain the logic,
why we need it to be done this way.

-- 
With Best Regards,
Andy Shevchenko


