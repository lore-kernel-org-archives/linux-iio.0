Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE6419B5A3;
	Thu,  5 Feb 2026 17:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770311491; cv=none; b=M5ulKvuKKhtwh0Tavk5ZzwGJNklK/4mG8gdXEiulqeSXwEuc49Bnz0zFmjmsYmu/vyM1nGgX1EI5Unf2Kyvh2m8o0x/qYlW9QNYGSkARG1q1N4WJcpN0v76pUlGLgD0itq60mLw00uvY6GfIXrdOwz5r1/ap/9INeIzo+PkNcrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770311491; c=relaxed/simple;
	bh=y0jB2c9ICDeGO1cljybtZvyi60TwiToin7vEuvO9/TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELxyScgZW8evxhy4j0EjEp3AMIISQZPAXEboRz6DYkASHh0AYgPI7B6o1c8CXbIIOqngO+T/ESe0TLPaZ9KcB+ElfQt7lgdxuyLo5+Lx8mFT0uLyO6N3XLvSDsc6sFHtESHqfrdzzOBRi9D5xHlZKT9MOrLaf1WTYSGxWUM4N0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OR8jilcc; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OR8jilcc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770311492; x=1801847492;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y0jB2c9ICDeGO1cljybtZvyi60TwiToin7vEuvO9/TI=;
  b=OR8jilccJ53suNR6q4wFcqf/Q9CRNpw5eXo6LSG/twi5+7NaOUDFqgYP
   ZB+hgeYWXyXM8DSN3SpwUoP6ah+m9T//QaoQHaSTy1lHInMKTthSvnil/
   iicg7371zODy6l2CpU65emim0feQ38mSixUv974wKq1ovM3LguCXlaDwr
   jMpEUyVok0xHnovRiqsqa88oFBkYfDl84u9PXuQiFoWMSfcv9P827IyOD
   kKJvJWuwdrN/1JEbjzHDeKbFx2HhkHRwTv4gvL300voIesSIqifLhFO9L
   dlp3sezX0cb2RMgLzFW27UvXjcuEKWXNOIbLYEJnPDH5a+nAWAG3ZteOY
   A==;
X-CSE-ConnectionGUID: CBlKt3AvREi5eyozK6DG9w==
X-CSE-MsgGUID: jVRVM9cDS4GRicvsXWflpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="71506178"
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="71506178"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 09:11:31 -0800
X-CSE-ConnectionGUID: fAC+TRCaQsOVCN5XrBLY/Q==
X-CSE-MsgGUID: M0b0EUteTS6x1L1rio/vMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="215566137"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.142])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 09:11:27 -0800
Date: Thu, 5 Feb 2026 19:11:24 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, michael.hennerich@analog.com, nuno.sa@analog.com,
	eblanc@baylibre.com, dlechner@baylibre.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	corbet@lwn.net, marcelo.schmitt1@gmail.com,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Axel Haslam <ahaslam@baylibre.com>
Subject: Re: [PATCH v7 5/8] iio: adc: ad4030: Add SPI offload support
Message-ID: <aYTPPNE-GxkeokjV@smile.fi.intel.com>
References: <cover.1770309522.git.marcelo.schmitt@analog.com>
 <21652a067efac362c05f628d56b4880d07c51457.1770309522.git.marcelo.schmitt@analog.com>
 <aYTOmc32Q4Iuv-Gi@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYTOmc32Q4Iuv-Gi@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Feb 05, 2026 at 07:08:48PM +0200, Andy Shevchenko wrote:
> On Thu, Feb 05, 2026 at 01:48:40PM -0300, Marcelo Schmitt wrote:

...

> > +	cnv_wf.period_length_ns = DIV_ROUND_CLOSEST(NSEC_PER_SEC, cnv_rate_hz);

> > +	offload_period_ns = DIV_ROUND_CLOSEST(NSEC_PER_SEC, freq_hz);

^^^ for the context to the below remark.

...

> > +	config->periodic.frequency_hz = DIV_ROUND_UP_ULL(NSEC_PER_SEC,
> > +							 offload_period_ns);
> 
> The point of having _ULL version here is...?

And for the consistency with the above this should be HZ_PER_GHZ.

-- 
With Best Regards,
Andy Shevchenko


