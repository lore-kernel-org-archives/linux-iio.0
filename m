Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D843921F1;
	Wed, 13 May 2026 11:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778671530; cv=none; b=SB+M/gvB320p2GEzeXOA97GEb/iiRDo7RJWv7DHZWo5lmhA8vZ5SPAV+efOsOChi4rO8vMpMm4XHvVBeA2NsXKm0+oYgE40qbukW6PikeIQCVbD1eD1Z4jk59I/ArDkLlG/gR76spCVy6uGLy533WPCuB79BygrAIGLylb+QWh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778671530; c=relaxed/simple;
	bh=sYwpw2HJD2TzkCKHDWNgQ2irhxl4vnaPF1E4Elfkk84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqYotL77z3zj4DFtIAcNOmP7HPwijrpN/8rKjoGdx2HgdDCi1kB2Ic7djs2GgUKfYQtihYKx9HM9f0cBxai5HSj+p/6J9GurwSLWUI8tHBZm7i+UIOns27VPgdxJ+MPo0L9HZWE1dj9gMI/YeROtR/L0JYonOHCSDq7X2hh3i0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B3MrAknl; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B3MrAknl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778671529; x=1810207529;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sYwpw2HJD2TzkCKHDWNgQ2irhxl4vnaPF1E4Elfkk84=;
  b=B3MrAknlb+zm2q21vDC9THMS5GpKDN3kPODOd7QDC+YaXp9T3+glUEvy
   D2RN/a63DfTORP4GFUK0KvUhx5T7R10caJB+IoGU+kgizLpGuf7bR60yu
   TUPnh8v9CUkTqn7xMVJ5EeamdjHJzhVlm++jNdUDIKj9EBZNszEjVfOyS
   B+fByJyGiYC5uh2t9nRsbOzPw7Uj5u/wBaaCBX95qqdHLqaaWc1l5Jm7n
   oIdZ1KPzMZqUgSA16kjsyoGTEVwvpOtMHG3d1nyMVnq0HGzmufzjaZjrs
   MuVClWsdVcCbLkiVYIAEXZu04MHIS5fdpcA3+mhop0VlmyfAFlE2uzAcq
   Q==;
X-CSE-ConnectionGUID: dSR7zmxpTVGSl39HUCgXZg==
X-CSE-MsgGUID: Pa/P0XZtT/2Lt1Xu6DQbIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="83210959"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="83210959"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 04:25:29 -0700
X-CSE-ConnectionGUID: w4RvVCw7RDmrZVAQd4H1NA==
X-CSE-MsgGUID: XPgqELt8SGyUGBBY9gIMrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="231671978"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.106])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 04:25:27 -0700
Date: Wed, 13 May 2026 14:25:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: jic23@kernel.org, sashiko <sashiko-bot@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Daniel Baluta <daniel.baluta@intel.com>,
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: imu: kmx61: Fix potential time-of-check to
 time-of-use race
Message-ID: <agRfpI_eqG7QHYas@ashevche-desk.local>
References: <20260513013638.147606-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513013638.147606-1-m32285159@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 12, 2026 at 08:36:38PM -0500, Maxwell Doose wrote:

The Subject can be made better:

  iio: imu: kmx61: Fix potential TOCTOU race in kmx61_write_event_config()

> A time-of-check to time-of-use race condition exists in
> kmx61_write_event_config(). If two threads enter the function at the
> same time, both threads may pass the check and get to the lock. Thus,
> when the first thread releases the lock allowing the second thread to
> start execution after the first thread modifies data->ev_enable_state to
> force returning from the function, the second thread continues execution
> regardless. Fix this by moving the data->ev_enable_state check inside of
> the critical section.

-- 
With Best Regards,
Andy Shevchenko


