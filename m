Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028ED4A2E2E;
	Wed, 17 Jun 2026 15:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781710950; cv=none; b=sldNbPxwZGwfiiF0ACny09LhycgELXOujUNUmiSwPrNljUJyczh4wrs/imbXfrloskOrFXPrxJsYj8IaKIoJXeZ1mYjxMHDf6EQF8zE0Sy/wVRP5gaOVhxAUQ6NVGgRRWIYRnCswBjalKxic0ckLjvmjNBxAo3HxL1ZjBFkSTNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781710950; c=relaxed/simple;
	bh=8Boq7TKXlKga3wA/+27M+gqT3gyzG2VJzHPSGDcRqy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwTtnJukXfrQ4qRULt1AMvv7Y2IKohS+2QhXDT9gKUBGnx7/Htnb4vcjHESTBZt58nplh5HWoiT+I9/0KR3y++/L4phMr2qJ+etkWgAd9TXRU2V4QNKh1BRmms3jXkWjH16Ckcl/8WA0wfP0EPhv8kCe69BS71fUEd3LCq2Xnc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZWPG0kAd; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZWPG0kAd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781710937; x=1813246937;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8Boq7TKXlKga3wA/+27M+gqT3gyzG2VJzHPSGDcRqy0=;
  b=ZWPG0kAdfJYeKnYMTTKAatoL2abrhwn+iDEYIUYU1N3hk8fA2J9YNHRL
   /i0H7is+cTLjS/S29D25Mu3gexGtnALUI02JAxqQrKhFRZL0WVrcH7xfS
   0obMP/XxP8pLCi7U/ZVvJ7o+iCCBU0yZo18AIDxhm1AZHXJdiAC7flJLR
   8hT/nWswwyxdyK740gjEQekNWPn3UHkX66zwNN1lj+Rm5eZn9+08AQ0Ic
   iArMpxg/Hj6ad2aP6XA7AXOH3qvrz6RqGpH2mIl1vLM82n+OOap/NMOLK
   nlLzgV2f3ouEzWA6NU5GJYj8/jPAHTin7B4dg40n14s+KSDaovDxOqEMD
   g==;
X-CSE-ConnectionGUID: qAt/Y5onTWWsMmL9UPhbjg==
X-CSE-MsgGUID: lGbOxAIzQR+jkJbDtewVZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="99921982"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="99921982"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 08:42:16 -0700
X-CSE-ConnectionGUID: bRLLYjT8TMe0LmKMdgFj3g==
X-CSE-MsgGUID: FzVitsAkRXiFBZHPrcnSKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="252407703"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.69])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 08:42:12 -0700
Date: Wed, 17 Jun 2026 18:42:08 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salih Erim <salih.erim@amd.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, conall.ogriofa@amd.com, michal.simek@amd.com,
	linux@roeck-us.net, erimsalih@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 5/5] iio: adc: versal-sysmon: add oversampling support
Message-ID: <ajLAUJPpdaf8lJqG@ashevche-desk.local>
References: <20260616131559.3029543-1-salih.erim@amd.com>
 <20260616131559.3029543-6-salih.erim@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616131559.3029543-6-salih.erim@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 16, 2026 at 02:15:59PM +0100, Salih Erim wrote:
> Add support for reading and writing the oversampling ratio through
> the IIO oversampling_ratio attribute. The hardware supports averaging
> 2, 4, 8, or 16 samples, plus a ratio of 1 (no averaging).
> 
> Temperature and supply channels share oversampling configuration at
> the type level (all temperature channels share one ratio, all supply
> channels share another), exposed through info_mask_shared_by_type.
> 
> The hardware encoding uses sample_count / 2 in a 4-bit field within
> the CONFIG register. Per-channel averaging enable registers must also
> be updated to activate or deactivate averaging.

This one LGTM now,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


