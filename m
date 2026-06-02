Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF59F3D1712;
	Tue,  2 Jun 2026 09:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780393223; cv=none; b=R5SMZ/nL4HeYF6nlsQi2Tii36D4+qDXPzblsc4hed5bbf5oojIIHEwwsjba3h+U9Y/ughdM0nZ9TuTiby7BjMzc6BoPEQKPUIldqm7VeHxyMGd7RWaOUT0ZrgQEmNCNxfA2xf+IWtFT5BR53yU4AdO5Vq0BVX3StlNSDIWbZC9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780393223; c=relaxed/simple;
	bh=jqR4dzKGvV3HqFH6eaz3fG39vDCQjIDVnOKaJWrWjRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIjLnyriX1NDA/rRMBcTpWC39grKL3+ztaGCayhQqk5AiFFkD2XMR1CYFZF1UnI1usSi+l3X87skzzqgQkGpXRDHSW7v9ZXCMe1u6w6SA4ySY/tkh3klRqXRseSe1joVT8pKIh0wInsj2xo0HsNcx06VP3uanljWOCnVvBNESKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HdpceHVs; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HdpceHVs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780393222; x=1811929222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jqR4dzKGvV3HqFH6eaz3fG39vDCQjIDVnOKaJWrWjRM=;
  b=HdpceHVs7TuymCc5izbZRGstBEb3h2pf7nJ6majRQm66v3U85GF8IZU2
   owOt9gKPaXZYIxHlzDIeCj/84xv35VMk6yH+7BPb/6CoDsgJ3C17pY4l9
   PF+zMD8yG927DtRSh7/kmTCb7khYqEGKqUXL6lyWdBTH80DrEi8gorQ75
   Kf76OfWC+f5wX7WRXLZpOYvXwPcxIxetwRO0H6h5L2okE9bTHjDeF41jm
   WMnFttbBoWOekFzioL6lZ1l+s53DFR/3TGME2al4EFgJ8DDVyfGFlWf+I
   L9AGmUwhn9QJBtjZa85tUr87MtOdJ7x3EY8pifgXIPFkEBbtV0xUbikPQ
   w==;
X-CSE-ConnectionGUID: W72kNrnWQSuinC4SKPuUVQ==
X-CSE-MsgGUID: xHy0Ql7UTFyVsIfySEtEEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="80909212"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="80909212"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 02:40:22 -0700
X-CSE-ConnectionGUID: h4duNntZTUmobA4ypFYP9w==
X-CSE-MsgGUID: p/6IPsYQQO+Vr1wS+/oE7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="240853439"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.229])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 02:40:17 -0700
Date: Tue, 2 Jun 2026 12:40:15 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Angelo Dureghello <adureghello@baylibre.com>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Steven King <sfking@fdwdc.com>, Arnd Bergmann <arnd@arndb.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Greg Ungerer <gerg@uclinux.org>,
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 04/11] m68k: defconfig: update stmark2 defconfig
Message-ID: <ah6k_wfIpwuussC2@ashevche-desk.local>
References: <20260531-wip-stmark2-dac-v4-0-7e65ab4215dd@baylibre.com>
 <20260531-wip-stmark2-dac-v4-4-7e65ab4215dd@baylibre.com>
 <20260531165155.13e586cd@jic23-huawei>
 <ah6hVLn_OES-ql9j@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah6hVLn_OES-ql9j@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 02, 2026 at 12:24:36PM +0300, Andy Shevchenko wrote:
> On Sun, May 31, 2026 at 04:51:55PM +0100, Jonathan Cameron wrote:

...

> TL;DR: This change has to be fixed accordingly.

After reviewing the whole series, the fix is trivial, just move this to be the
last patch in the series.

-- 
With Best Regards,
Andy Shevchenko


