Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532213D3D18;
	Wed, 25 Mar 2026 12:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774442199; cv=none; b=Oo3BZnBAeVmr5QUWjA//XMtarPtMPHHuhY2xq/x3YOGKpRriILLcJX0rwUfCkSE/nFEgAjn2TjL2bvR5Ntf1UAIQ3b87VKcSzOOEQZOecrcJCEsUuOHpbqCbdC1Rho1JHlqNZMqck9SihsnVxJPzIMVyhVvJJnpuHlMPwezW8Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774442199; c=relaxed/simple;
	bh=4man5hbIxPpGdcVKoEV5Ed+cY08xcLbgso5K7L07aGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3xqG06ph/VgORgax59p7XuJQqsnLasuoa99yMq6F4nS3ddeo1++y/u7mIPaiOqOJoWjmnlDRR6X1KigSMFOI1E3Blcyrbcey3+08qm9i0LnZaXw68Ewd88H6Y2V+3OLJEtAT8k4Il8Cg9+qTSZ7FJnGRKyD5FTTyhD/ypWW3qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aIL1OXMs; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aIL1OXMs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774442198; x=1805978198;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4man5hbIxPpGdcVKoEV5Ed+cY08xcLbgso5K7L07aGc=;
  b=aIL1OXMsM8JBgIuXYRyA9tWERS1dMeNXfKdyE/yNbWYe/LGOvBzzVRkc
   XMMp0AdgcVLlP6zDpRoSm2uh9ksqdV7y4zHrUf9hWk5+384ninSWQolBY
   O1B1HE3iZyLUgFlky6vfbLnX/uTNpQyur7vfuw/5GJj4ptmXPVk3ugdzm
   FTE9gqK32vvnHkPi9934LddSSqt2Ejh55UL8PFAcutz5//8lbd/G+BFCW
   PgEV6BO4SAaFHZ+6XfqJEbTU0O7MIKROOJcBy/VZyuiMm07uGh7aNqrRT
   ve1FZd980nJOkyVKCzDkkdIipndMcNkDdc+Pc12dbKIFCsD3R+0ZuzvdM
   w==;
X-CSE-ConnectionGUID: JdRcl0SFQvamyscMbku6GQ==
X-CSE-MsgGUID: sqYq14DwTnG5+Lb5a/GC8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75192772"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="75192772"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 05:36:37 -0700
X-CSE-ConnectionGUID: 88v3fi6NTK6ro6buabzNiQ==
X-CSE-MsgGUID: qN7wI6ZNTciHn7ziYmK21w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="218094253"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.32])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 05:36:34 -0700
Date: Wed, 25 Mar 2026 14:36:31 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Marc Titinger <mtitinger@baylibre.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, dan.carpenter@linaro.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: ina2xx-adc: fix regmap max_register off-by-one
Message-ID: <acPWzzmdjmet7i9I@ashevche-desk.local>
References: <20260325054313.868261-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260325054313.868261-1-harshit.m.mogalapalli@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 24, 2026 at 10:43:09PM -0700, Harshit Mogalapalli wrote:
> regmap_config.max_register is supposed to store the highest valid
> register but this driver assigns the number of registers
> INA2XX_MAX_REGISTERS is 8, the highest valid register address is 7.
> 
> Fix this by subtracting 1 so max_register is inclusive.

This matches with my understanding of max_register in regmap.
But what I have noticed is that we have two drivers for the same subset
of the chips. Why? Also one may note the differences in max_register.

Taking that into account with the fact that most likely there is nothing wrong
to access that register (in the other driver they allow up to 13), I think you
can rather add a 0x07 register to the ADC driver and change the value of
_MAX_REGISTERS to be equal to 0x07 as done in hwmon driver.

> Fixes: c43a102e67db ("iio: ina2xx: add support for TI INA2xx Power Monitors")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> Found by static analysis using smatch, code review and guess work.
> NOT TESTED.  Please review carefully!

Right, see above.

-- 
With Best Regards,
Andy Shevchenko


