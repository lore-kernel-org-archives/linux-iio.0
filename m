Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FAA7083C;
	Wed, 13 May 2026 20:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778703528; cv=none; b=VsS5QhSlX62piSffXMi9dC991WzlC4w5VKGs4Z4OdLKFatGWaPbeFQJ5B5mLxV12T94qd/x5/12K2fpDaIkaEwvy/G79xdVQwDWxZ1s8y9dn2koOqJAPK/DiwyQ4EZP0mFCi4ylHX+C2m7txaflJgvdXYVA/XPDqjqwLWZ1QJB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778703528; c=relaxed/simple;
	bh=IfW99YHYzpUh373QPEOA4K2s4hb7mUdbwWNMEdE9QzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urFEf4uuRwlvfZXg5G9kYjYiKq8Vrvdi8oMNKnXN716oW9ohZ7OW1wux8RjNaE9s0665RmizEAblm82CZdvA2lJ+PL2xp0QSFfTAGqj1PFLDQF1URWT0U3TU3BeXzsrcNhX3Oh7iVjMh+fPDK1dSCYi9GBiM17wggjXbFNr1mIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VbCSB72k; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VbCSB72k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778703527; x=1810239527;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IfW99YHYzpUh373QPEOA4K2s4hb7mUdbwWNMEdE9QzM=;
  b=VbCSB72kwECrwA37V2fh6D9U+jepvggwMd6FjvCz9txlczr0QHn8/1lB
   dutEmrabkC7mN6dmQmOzP+fA+Opz6HoA6nSPvDFp2Ajsd2JYzHzJ5nA12
   6O3Dbp/hjl+oP1Ho+XFGUXMx0/31cjWPOrxMtxqRrOSvMjS7IYO3U1ojh
   NZh+YyW+IC6bBKURPHMfRuqi5Kj82YNmYQtYns6zek/tmrgGCJ+atXmtB
   k3eNYyLDIxVafZvxTJ/QCM53QNQVEghDHd3gfxA9ctL6ssmkcihqzsBda
   9A7K8PrxJikyxSEsUe/DnP3YMSBTy8rjudnPXMRs7fEvUzFhXLltFbkzo
   Q==;
X-CSE-ConnectionGUID: M5tYYfOdQN+wbCRtJMRhFw==
X-CSE-MsgGUID: hJJZpVlvSfmNOyJvHZ3vlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="102309104"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="102309104"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 13:18:47 -0700
X-CSE-ConnectionGUID: Er/26GkHRvy20O47F9TRWA==
X-CSE-MsgGUID: heEwA0y0TH2LkOXC67+U+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="261934359"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.106])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 13:18:43 -0700
Date: Wed, 13 May 2026 23:18:41 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Greg Ungerer <gerg@linux-m68k.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Steven King <sfking@fdwdc.com>, Arnd Bergmann <arnd@arndb.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Greg Ungerer <gerg@uclinux.org>,
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 09/11] m68k: stmark2: use ioport.h macros for resources
Message-ID: <agTcoVbImqMgfQy5@ashevche-desk.local>
References: <20260513-wip-stmark2-dac-v2-0-fcdae50cf51a@baylibre.com>
 <20260513-wip-stmark2-dac-v2-9-fcdae50cf51a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513-wip-stmark2-dac-v2-9-fcdae50cf51a@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 13, 2026 at 11:14:33AM +0200, Angelo Dureghello wrote:

> Align also other resource declaration using DEFINE_RES_.

DEFINE_RES_*()

...

>  static struct resource dspi_spi0_resource[] = {
> -	[0] = {
> -		.start = MCFDSPI_BASE0,
> -		.end   = MCFDSPI_BASE0 + 0xFF,
> -		.flags = IORESOURCE_MEM,
> -		},
> -	[1] = {
> -		.start = 12,
> -		.end   = 13,
> -		.flags = IORESOURCE_DMA,
> -	},
> -	[2] = {
> -		.start = MCF_IRQ_DSPI0,
> -		.end   = MCF_IRQ_DSPI0,
> -		.flags = IORESOURCE_IRQ,
> -	},
> +	DEFINE_RES_MEM(MCFDSPI_BASE0, 0x100),
> +	DEFINE_RES_DMA(12),
> +	DEFINE_RES_DMA(13),
> +	DEFINE_RES_IRQ(MCF_IRQ_DSPI0),
>  };

This conversion drops hard indices, would it be a problem (for example,
some code modifies the fields based on the [hard coded] index...)?

If not, perhaps good to mention in the commit message and move IRQ to be the
second one?

-- 
With Best Regards,
Andy Shevchenko


