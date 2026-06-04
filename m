Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8927B368D50;
	Thu,  4 Jun 2026 09:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780565825; cv=none; b=i7vYp0llZwE11BPWDH0PXmDVs5FfGsUbSd7eTES0ybZt3GUXIWaveXeHzP/TNDI4kA7eZIYtHhb3KplT1drq/EwDfyr/j0XRKT2yjVxIu0yRSHvGGOVMa1TxjdSKYGv2h/uQHq2yZU6s62AAtWow08MN5sW5CyJqPEgWwD6WjpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780565825; c=relaxed/simple;
	bh=mcKH1td+rU55hxoN0MayIxKisg3K7myzFZKj3PPbIYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=glivMfi/mGkVR3nxDId47cdyL5ds9xXqCa8HvKJjckW0w71zXWJWMcHZKLtI1wx7bSVRkBMMv+fu9aLa2Pwqmx4QcM33rOlc/K1y9wP20pwhwj6tgSEi6Xs3zOCBJDQYeW7L0voE/GWud8BufPepE2Y4mLULBidA87mk13mni5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FVLCpC8R; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FVLCpC8R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780565825; x=1812101825;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mcKH1td+rU55hxoN0MayIxKisg3K7myzFZKj3PPbIYg=;
  b=FVLCpC8RHNRIcdeWDq4AWgtsjS9Ch7Dyj4QGaSwkyN6CnhTvhiLvJZke
   xUX8ehLW06GvTavv/Z7sCoYoB8/UPRSgrL4/hD6eQeVzez3Ok2YRYB4fL
   aRaDSZdp2MKWNw8QtcRUkg8w7oTiqZnvzyFFcLX0b1hVCqyWds++AuIX8
   KsqmkPMOaZ6ROyw1/tG+gPmmPii6usvhGOgF/x2I0Lt83Y5vH96V18Az9
   Ligl1p9f9kyPYd6wPoAuwJSsSkYhQjhUr3n4zaMtTJ1sHtx941G+J4lb3
   T0vNmxJvMKyXbCdNGNX2kvKNbyJjHshXVP70wmNrK+PkGuyWd/8HD8R7Z
   A==;
X-CSE-ConnectionGUID: 82sJGJcqQiGe66WsghP/qQ==
X-CSE-MsgGUID: pIM+WPE3QMihZm50y25m1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="81134127"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="81134127"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 02:37:04 -0700
X-CSE-ConnectionGUID: XvDdQygJTymuR+H+/ph8Wg==
X-CSE-MsgGUID: QZljXeyfROeZ7z0HRuORjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="244581732"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 02:37:00 -0700
Date: Thu, 4 Jun 2026 12:36:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 0/3] iio: dac: ad3530r: Add support for AD3532R/AD3532
Message-ID: <aiFHOj0dVv2fasD1@ashevche-desk.local>
References: <20260604-iio-ad3532r-support-v1-0-c3552f9031de@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604-iio-ad3532r-support-v1-0-c3552f9031de@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 04, 2026 at 03:13:42PM +0800, Kim Seer Paller wrote:
> This series adds support for the AD3532R/AD3532, a 16-channel, 16-bit
> voltage output DAC, to the existing ad3530r driver.
> 
> The AD3532R uses a dual-bank register architecture (bank 0 at 0x1000
> for channels 0-7, bank 1 at 0x3000 for channels 8-15), which required
> refactoring the register access paths. A table-driven register bank
> approach is introduced where per-chip register address arrays in
> chip_info are iterated by helper functions, replacing the single-register
> setup calls for existing variants and scaling naturally to the AD3532R's
> dual-bank layout.
> 
> The series also adds AD3532R-specific powerdown modes (1kohm_to_gnd,
> 10kohm_to_gnd, three_state) and a new ABI entry for the 10kohm_to_gnd
> powerdown mode.

This cover letter misses two required things:
- why do we need a brand new driver (provide an explanation)?
- where to get the datasheet (provide a link)?

Just reply to this email and if new version is required do not forget
to add it to the cover letter.

-- 
With Best Regards,
Andy Shevchenko


