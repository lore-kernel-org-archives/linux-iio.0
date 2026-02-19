Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017A0332EC4;
	Thu, 19 Feb 2026 07:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771487766; cv=none; b=criZpEthC3IBmfzFXLN2XcmkPzGs8+FpuyI+kVY0y1UhXKAG5cG+CBMaYTKpnuBoJt5GaFIs2EgrQ52hVFqAoFhUSNY/iu3jkhPl/SDTKfuXf2sVzo+9rw8eebj9Avdj0bKXcQj9z/RQ1Ist1VK1R1DPzq0mnv3MMuZAcLoNj78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771487766; c=relaxed/simple;
	bh=qVQVpq/JoKEU9hFxtncLZmC+yD+E7AObS+MPyFpvYqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0RlofbfelAy71znI9iQg03nw771CBBrwTiggHg5JHyM/FJzxtv2Gou6e1vHuKUPe6V10Nls7+7/a7Dvn9GWdtiDoJ+RV85giFeLuTbw3FGu58tWO4YfL6IjGiCSQKh60D2qDk+qi9G1pV7VjrHH20Pboaf8lN+pNbWr3uBVF/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vjyorz5W; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vjyorz5W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771487765; x=1803023765;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qVQVpq/JoKEU9hFxtncLZmC+yD+E7AObS+MPyFpvYqM=;
  b=Vjyorz5WRMxkAtahFOn9a25xYtk+QThjgeG1Ddj9ief7xjTSDLmMEjWP
   OF/y7cT2dp/7/HpmIpPnVNoZm3Rihyw3YrLXqf0Qnwn1T7iXNAKxvK3zP
   jflTE1oQvQ0xNGHfrEHdjxRXEp9NntL+2HR1EgNnN/shA0IgDhcQHpftl
   +JYnX0u5wIfxFFJezqXUCnnOcMQ3zaI6F1W+9H8o2PIcXbv1xMbwak3hS
   2QDp2GYSlaq0zcvGjgYGDaXEy8m0OxQhoEkxvehmg9T9xWKhMO/RVAcTq
   gylOMbh9aNj2LC0arrcIkGIX7YK/zVhlmhZLpXAiOXBQj1x69ByWGoQwQ
   w==;
X-CSE-ConnectionGUID: 73Hmhd4BR9i+8T6HI3ZlJg==
X-CSE-MsgGUID: Rl18le8dSBCmav5NUcJgfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="72470755"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="72470755"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 23:56:04 -0800
X-CSE-ConnectionGUID: MR649aziSz+mriipj3Tr7g==
X-CSE-MsgGUID: wfjXRQv5T1GhUR5kGNMNPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="213531050"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.114])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 23:56:02 -0800
Date: Thu, 19 Feb 2026 09:55:59 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 2/4] iio: adc: ti-ads7950: do not clobber gpio state
 in ti_ads7950_get()
Message-ID: <aZbCDz8CdW5f_3y3@smile.fi.intel.com>
References: <20260219022929.3558081-1-dmitry.torokhov@gmail.com>
 <20260219022929.3558081-3-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219022929.3558081-3-dmitry.torokhov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 18, 2026 at 06:29:26PM -0800, Dmitry Torokhov wrote:
> GPIO state was inadvertently overwritten by the result of sip_sync,

sip?

> reuniting in ti_ads7950_get() only returning 0 as gpio state (or error).

GPIO

> Fix this by introducing a separate variable to hold the state.

...

> -	int ret;
> +	int ret = 0;

This kind of assignment is harder to maintain, because it leaves a room for
subtle mistakes (when it's reused by a newly injected code, quite similar,
actually, to what this change tries to address). Please, decouple definition
and assignment.

> +	bool state;

Not sure about this (yes, I know it was suggested). I would leave it still
the same type as one that is returned by the function or a compatible one
that is the same as st->* (if the used ones are all of the same type).

-- 
With Best Regards,
Andy Shevchenko


