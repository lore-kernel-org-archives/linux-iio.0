Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7101399023;
	Tue,  3 Feb 2026 09:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770112100; cv=none; b=hw+RlTbmGwuHNdB5V43HVurlagJeMgsmPcVfkiXGaL2hsWQVpGo7vFyctx3VUSP2HJaOCLnFYi2+IWU5+J/4xHte3rcImgej7CJs4cjWyPGxIkIaING6rb2UNS6wIilERRuli9KwjkHoPr2smPpIz8cqJ61DgjQPYgH/vMSxIqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770112100; c=relaxed/simple;
	bh=CEq4LbWx/F8doQ6jmeGXZaCiv3sjboYjRC1sNgbWjqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjkC4R4H/t+UcgHedb0uaAtZesQwcbuxzPahypPPaDcyDyZsWvBQ5cNoTg655yC5ZMKf3HBUs9LWtdoPjf5mE8s/YN1QRGKRxHbga7GjPOJ3Nk8DEuzGm/YLv8cMkRqp0HlzNcXucMhPwP7gqsF8gQPWmpDdEaxpVtzb9yloPJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EOj7H9B9; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EOj7H9B9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770112099; x=1801648099;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CEq4LbWx/F8doQ6jmeGXZaCiv3sjboYjRC1sNgbWjqQ=;
  b=EOj7H9B9MvbXKEZhGpizK/zW/gs9y8UX9CJTsCoWRLeO+Ch8jwT0aYxO
   pFIjZ7Ss4L3k7K5Nz0UkG2YBXXh41ZiUVqWv1HgvYPDodwlMs+xuSSNGh
   6AUSHsoKHh7EkgH8Qwez8Vj9Pvp/G9aSdJt3561/+U4AmXR63Lv+G3V1H
   tCAoHyFaxSu/1zSWVE5t9E0eSSbZbHTZe0Y0eEL4v++5nYSW0cOk3FCIK
   vg0Kj0BdRpaAA/CwSY7PsMTWyakfTX6/MkcnBcMRYZR3XfLLHfBebX3yY
   211xY2y9i2f7nAXIS1vZQtU+FXGAxkink7YZFE2yNoRHoYPF3VdygC1dO
   A==;
X-CSE-ConnectionGUID: /+/cQ19xRM2Sv2HUsW++wg==
X-CSE-MsgGUID: Fl+vY/EgS+eWqkr0nhm42g==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="75133408"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="75133408"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 01:48:19 -0800
X-CSE-ConnectionGUID: 4hZHrNRtRFOPNd5Kd+w3bA==
X-CSE-MsgGUID: wNg7F1PgS3yOAqZf/jjMiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="214282221"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 01:48:16 -0800
Date: Tue, 3 Feb 2026 11:48:13 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Ijano <andrew.ijano@gmail.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, error27@gmail.com
Subject: Re: [PATCH v2 next 0/5] IIO: sca3000: devm resource management
Message-ID: <aYHEXc2QjMAus5Bt@smile.fi.intel.com>
References: <20260202194033.627967-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202194033.627967-1-harshit.m.mogalapalli@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 02, 2026 at 11:40:07AM -0800, Harshit Mogalapalli wrote:
> Hi,
> 
> This is an attempt to update sca3000 accelerometer driver to make use
> of devm_ based helpers where needed. I have split it into 5 patches.
> 
> Patch 1 - some refactoring and simplification.
> Patch 2 - switches request_threaded_irq() over to the devm helper
> Patch 3 - Used devm_add_action_or_reset() for disabling interrupts.
> (Ensured the ordering of teardown bits remain same)
> Patch 4 - manage device registration with devm helper
> Patch 5 - Make use of guard() in sca3000_stop_all_interrupts() function.
> 
> Thanks a lot to Jonathan for detailed review of V1.
> 
> During v1 review comments, Jonathan Cameron kindly provided some great
> suggestions to improve this driver. One of them is making use of
> gaurd(mutex) - autocleanup style, patch 5 does that for one function.
> 
> Yet to be addressed tasks:
> 1. We shouldn't be using the spi_device_id at all.
> 2. Modernize other fucntions to make use of autocleanup style locking
> which simpifies the code and makes error paths cleaner.
> 
> I will be working on these two above tasks and will be sending a
> different patches for those.
> 
> The series builds cleanly and I have performed static analysis with
> smatch checker but haven't tested on actual hardware.

David already reviewed and v3 is anticipated, so I try to look into that one.

-- 
With Best Regards,
Andy Shevchenko


