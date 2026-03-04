Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91AF26AF4;
	Wed,  4 Mar 2026 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772631612; cv=none; b=TFZa/bBtor3s/D3cYjmVypxE6QJDwxSVtGL4t/6X4K8JzJniiww7IusoQw5aYFDbYfOq9AY3wxbcshOcIe6YznNXQ0cvGsJGBc2BG2o+2LpyIWgBnJHCghZ7ytpJPmWVJRZBEuXpruv2PgZKmCeywMH3eJ1Gz8Dge0gO4s2s/wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772631612; c=relaxed/simple;
	bh=bsf7B5BIfmLnSGKb0te7TGmSKf659fCCwB8op44vRBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlbnSH+wLNEZpcUj/VLiNYNqT31dr9IhBWX1X7ymOlDOaXD5KAOCqZJXwQod3SUHfhs/S+iplfK8GvpxuNgX6epm4ias6YG1VC49ipobQvsN+zu8BntGW8dKa5Vfmc9WI1Qx03qEkQlK00DBasg3u5k4aRV5jCrm6ueARL/Rqrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vg8zyYfG; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vg8zyYfG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772631611; x=1804167611;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bsf7B5BIfmLnSGKb0te7TGmSKf659fCCwB8op44vRBc=;
  b=Vg8zyYfGHBRbImsWnFhNtjqvxnalzTrUjW6oo7Op95qCJZJubQg/5dF5
   WFOYVBGAJo+Dh4bMVR6YOJTZj9J/8CYC5mNHTYb+40sIvHNCMTAO11RZ9
   kbysrXxnK+iDA1t03DsHu096AusmS4pjiuH3Ye2Rs/LlFNNXI1ZRsFukO
   OWbhLjj0puHE61Orz/Ba2fwp4TlMC/coxEieIoZMDqaiJkmRw1wWDI1nn
   G5p7yDK2q9nVMlL/a7cFAy2Yt9eoOuMSFIMkwZOHCXJuwLw4AoyZc5Euu
   3PxK+33vdHKatz91qDb5VDQd1J7u/IOH7Mc7YDCIIuw1brn7unrxzgaXm
   Q==;
X-CSE-ConnectionGUID: Q5cuCX23SiW8OoEwO3pFBg==
X-CSE-MsgGUID: Go06XY54TV6QZObIxpnB4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="73388959"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="73388959"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 05:40:11 -0800
X-CSE-ConnectionGUID: G3suj1SrQaS914RpDC0FCw==
X-CSE-MsgGUID: 0pq5Dn1tS4W65Mys0QLAQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="218305788"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.127])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 05:40:07 -0800
Date: Wed, 4 Mar 2026 15:40:05 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Christofer Jonason <christofer.jonason@guidelinegeo.com>
Cc: jic23@kernel.org, lars@metafoo.de, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, michal.simek@amd.com,
	victor.jonsson@guidelinegeo.com, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: xilinx-xadc: Fix sequencer mode in
 postdisable for dual mux
Message-ID: <aag2NQTBysQYMU--@ashevche-desk.local>
References: <20260304090727.1800289-1-christofer.jonason@guidelinegeo.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304090727.1800289-1-christofer.jonason@guidelinegeo.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Mar 04, 2026 at 10:07:27AM +0100, Christofer Jonason wrote:
> xadc_postdisable() unconditionally sets the sequencer to continuous
> mode. For dual external multiplexer configurations this is incorrect:
> simultaneous sampling mode is required so that ADC-A samples through
> the mux on VAUX[0-7] while ADC-B simultaneously samples through the
> mux on VAUX[8-15]. In continuous mode only ADC-A is active, so
> VAUX[8-15] channels return incorrect data.
> 
> Since postdisable is also called from xadc_probe() to set the initial
> idle state, the wrong sequencer mode is active from the moment the
> driver loads.
> 
> The preenable path already uses xadc_get_seq_mode() which returns
> SIMULTANEOUS for dual mux. Fix postdisable to do the same.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


