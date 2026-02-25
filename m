Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9917C33D4F0;
	Wed, 25 Feb 2026 12:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772020957; cv=none; b=OgFxeU/5nx6g5V+91iuNvsccYaW1UT7JtCBREZLCs3+iG4eLzEd1x9BcCzjMXDRHdtKF8J2MsJ2PDGxea8NB9dNH3ip9NGpjIvzrWIVITyjY5dYYrwvMsBW6+V4LlABdG/gqLT1xp4bncUKPommVNBWisk2wMZnHE2TgPP+s5I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772020957; c=relaxed/simple;
	bh=Gisn7KXghgYyHkaz4uKAreWqma0Nfjm6PAR88GH32jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSfzY74kbsHGr+KCKqHQF66h8ZyTyMb4/dVD0r+ON/Rs0VlcaL96yIyFwMXOgNZBHy9XW8LwazHnNarqY3mJdM+NipVSh60is4UGuxx4PeKDeGTHq4FUzq5wf1bp4UIwBYK5n9NIYiKe5pTGOVNdp5iV2N4sTB1w2VIWAwD+Ymg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZlTLBa+t; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZlTLBa+t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772020956; x=1803556956;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gisn7KXghgYyHkaz4uKAreWqma0Nfjm6PAR88GH32jw=;
  b=ZlTLBa+tvOR9mSHayQ+KuyYH/dFBwim2x96j5R2FuG9TAD3V1lHN0gw0
   08O9mv6mP8m+cJFup0pJ4UzYFaUTGyd0S30p6EFlH7y9pVIXTE1FLFiWR
   McC/C2z/BQWDFCKokfvhIN7GbRDv/Lr9Of1ZabgTg5NKnJ+Szo2cItWge
   49kOd+w0ROk3/K82dN+OGH5hCvdt76JDXY5iCkFGHD1YZ7mY1222ux97U
   KOumUZRlDoIglGwPxZrUPnTRXu9XzffWn0DCrVrTIA8izfBIEvsGMLGYS
   hVvcMUKB07M8/jhA4koI1Q9TnOVchG2Id7S7/8I2q+GfWLT/d3Qcq8UAG
   g==;
X-CSE-ConnectionGUID: 9XJ6LjdsSASe6YvvZSIjUw==
X-CSE-MsgGUID: +bL2gRoES4qCCXKQ85JDjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="90470954"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="90470954"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 04:01:48 -0800
X-CSE-ConnectionGUID: 7bEJjjsjSceBgyhDjWcDlQ==
X-CSE-MsgGUID: P0hfRUGHQaibKnfL4VcHUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="220707082"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.71])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 04:01:46 -0800
Date: Wed, 25 Feb 2026 14:01:44 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: linusw@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] iio: gyro: mpu3050: Multiple bug fixes
Message-ID: <aZ7kqDQP1zAKgnUp@smile.fi.intel.com>
References: <20260224224818.2452675-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224224818.2452675-1-ethantidmore06@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 24, 2026 at 04:48:14PM -0600, Ethan Tidmore wrote:
> This series fixes 4 bugs:
> - Patch 1: Fix free_irq() being called with wrong handler.
> - Patch 2: Added missing free_irq() in an error path.
> - Patch 3: Moved iio_device_register() to end of probe function, in
>   doing so had to implement correct error cleanups and place
>   iio_device_unregister in beginning of remove callback.
> - Patch 4: free_irq() is after called iio_triggered_buffer_cleanup()
>   which breaks LIFO, place it before it.
> 
> I plan on doing a proper devm_ conversion of this driver, but went ahead
> and did these fixes so they could be backported.

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

The commit message in the patch 4 sounds to me as needs an improve,
but I leave this to Jonathan.


-- 
With Best Regards,
Andy Shevchenko


