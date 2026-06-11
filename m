Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07B09443;
	Thu, 11 Jun 2026 07:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781162329; cv=none; b=GxE+h0rHK2G4CE8QmXPHP1h/Gfkj9kEmXDJIHu9ORh/ljIaRygRNuiLaukm3moX432Pob+pp5a8s3ibOOQEhsnLy+9SbptcgzbFzlfnOxXs793uWQrQzAZm4Y0EcyMD46unUW1gcWUqTk1P+M3DarAsAEPXtTEyurWcOf4s3MeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781162329; c=relaxed/simple;
	bh=CR47QW2aqYQi3jjpuH+JWQWF89PSQdAAS2jmeVBQZyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPkk6Otwd8MfIlCzsEW2PAnHwbme25HJH6zCsFiMDvrdPy1WH7c+/j1jGMTPRPHksBaUDqZT9r35Ch3E4anDR5gkCLhbtm+eTARpnfxVXOA/nWOqcSmYu+ROKJCe/JpMDdCjy0wOzFXqkfMg3gMYAFQOJK2eEDXscGCEd+rGzeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gt3dN2fC; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gt3dN2fC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781162328; x=1812698328;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CR47QW2aqYQi3jjpuH+JWQWF89PSQdAAS2jmeVBQZyk=;
  b=Gt3dN2fCK2ivIDU1syRBFnYYmNySsYUXDLcKehqyGDgfrZkGh6M0gCyu
   kh46Tnp+sgbo67uZIsg0mLi0D+t6eY4IeSuVWkFy4PSp8OJ8MbYA9LIMc
   9F3hO1+cnp1p7locK3MTeka8zxlU//gQo03C6aQGHgsmWAZooY+eYnlex
   BYc/odg2SZ+9tVtMX4/QeGOuJCV96ggo4qF9mSrgt7WcihZmmhZC0xIl6
   Kgnv4vDWIimQipDpSo8pqSaCuxXBRLZgzlEy+2XRjknbdWhPO7h45BHKA
   Cn+RrkIwc8moTiL2M/uYxSuhjdnEdpgC85kQgCh9Z7jezFzUle0L+WThL
   g==;
X-CSE-ConnectionGUID: I3lou6b4SN2UoLanD90/Uw==
X-CSE-MsgGUID: /ZsTVR3NQjmEtr+47g7LlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82076698"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="82076698"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 00:18:47 -0700
X-CSE-ConnectionGUID: WyffcMEbQ3ya3qcBYdFtvw==
X-CSE-MsgGUID: hStgdhTMQNqoCp3tMzGfrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="243456670"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.123])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 00:18:43 -0700
Date: Thu, 11 Jun 2026 10:18:41 +0300
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
Subject: Re: [PATCH v5 06/10] m68k: stmark2: use ioport.h macros for resources
Message-ID: <aiphUQvNzzaoTjxX@ashevche-desk.local>
References: <20260610-wip-stmark2-dac-v5-0-b76b83366d5c@baylibre.com>
 <20260610-wip-stmark2-dac-v5-6-b76b83366d5c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610-wip-stmark2-dac-v5-6-b76b83366d5c@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 10, 2026 at 10:35:11PM +0200, Angelo Dureghello wrote:

> Change resource declaration using DEFINE_RES_*() macros.
> DEFINE_DMA_RES() is for a single dma channel, not a range, so used twice.
> 
> Also, some drivers assume IRQ resources are from index 1, so just to stay
> uniform, moved IRQ resource at index 1.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


