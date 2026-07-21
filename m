Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5746480DEF;
	Tue, 21 Jul 2026 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784630405; cv=none; b=jQLXxwUA7aORn4dkxWz1goBY7zLPseTggG4GQxGJv7HvjqQF2B8becheYQNT1RSnYVvDAxnHPOWdz2kAapNJOLvUIa8Mq4T8Q+cufbTSfB0xVFhq7ozp5pyNYBkrfK1Qmt9936POk70nHCVwJmrSlMdczzDsKiLTZYS0tqHxtnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784630405; c=relaxed/simple;
	bh=R+tTUj9HYZUPGeuHcZUO9SKzX4sk2JtOlgjcLaCexoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usr8oUfkycq62Ad14+90DvpXaxfwAznlQ9ZeY53H0ykkWXd4+4vpXLiKvrzptpVVcSK6/fvwJoWNrNOKqqQmojAn5O89tQvIL3Gk5AoCfS2KPeXFSYX3VSxGNziYhC+J8V8Kta97G7fyy/JrZdeHc8VkbCiLdgvmboESgtEO/pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XD/Af5H+; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XD/Af5H+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784630403; x=1816166403;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R+tTUj9HYZUPGeuHcZUO9SKzX4sk2JtOlgjcLaCexoA=;
  b=XD/Af5H+0tHD3BwUQMG9WZiehc4i4tpInGorpJpKvyLTJt/IHwTBs44o
   I9yLKvlYZhJtcxrySOB7qvHxCxx1tKxtK9h2boIc5qgmF6LS+58YfVJgZ
   F4RTFI/4argF/WHpD15tFD8Oy4F+rcjuCDAjEYLIZMaGR0xWMDuRKjizN
   Zd8tV4R8lgyiGFx35anAQvmLqLvg71iMFVCJjwLH2CI/4DMzX1YP+n+Z6
   ynK1Yw3UD7U0AjWZBDr3YKL4o/E8qDrB4FzvTdBt2WyrHmFm/pjbdONRE
   KU1c9dMzoVTo6NDk9ZznqYqixDAjFCCqYCUC4ZcZRBfEWJzOihVVmmh+C
   A==;
X-CSE-ConnectionGUID: ZlOOuP3fRG2WwYhipUB35w==
X-CSE-MsgGUID: p0owClQuRz2799Gw89RD2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85425226"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="85425226"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 03:40:03 -0700
X-CSE-ConnectionGUID: d1ych86WQuajYsl1BM8cgA==
X-CSE-MsgGUID: VmehXsQQTPqFv4/5s5i9qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="251402235"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 03:39:57 -0700
Date: Tue, 21 Jul 2026 13:39:55 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Yu-Chun Lin <eleanor.lin@realtek.com>
Cc: linusw@kernel.org, mwalle@kernel.org, brgl@kernel.org,
	tychang@realtek.com, wbg@kernel.org,
	mathieu.dubois-briand@bootlin.com, nuno.sa@analog.com,
	Michael.Hennerich@analog.com, jic23@kernel.org, andy@kernel.org,
	u.kleine-koenig@baylibre.com, dakr@kernel.org, bhelgaas@google.com,
	o-takashi@sakamocchi.jp, dlechner@baylibre.com,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux@analog.com, linux-iio@vger.kernel.org, cy.huang@realtek.com,
	james.tai@realtek.com
Subject: Re: [PATCH v6 1/8] Revert "gpio: realtek: Add driver for Realtek DHC
 RTD1625 SoC"
Message-ID: <al9Mexi2j4W8OcOg@ashevche-desk.local>
References: <20260721065802.689530-1-eleanor.lin@realtek.com>
 <20260721065802.689530-2-eleanor.lin@realtek.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721065802.689530-2-eleanor.lin@realtek.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 21, 2026 at 02:57:55PM +0800, Yu-Chun Lin wrote:
> This reverts commit a57e27c43b0315ee86c6896510d69be5257e093e.
> 
> The driver will be rewritten to use the gpio-regmap infrastructure
> once Andy Shevchenko's patches for gpio-regmap are applied.

Acked-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


