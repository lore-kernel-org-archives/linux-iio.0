Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6586F40F8F4
	for <linux-iio@vger.kernel.org>; Fri,  5 Jun 2026 19:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780687097; cv=none; b=qCfFh5hSyiFnMSxMMRTCNcv1jep0cb6deK2jYE0TjQf/Ok9w3PAaiMXcv/RA886lIG3aN0uM1MRk1u6n9AdIDddI1Fl+dLCN2MKNVbATnEllrxMpm0nabuo1LtUfrEhvsw5wX3iJ6ef9h8dwd6XiFFnXW7R+d3xAwTYyZjAYbP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780687097; c=relaxed/simple;
	bh=8ylB3rlC41NFungz6bMGKN6KJ1Twfg/MRXfgYoGCa0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHjstY1Fr4Gv6baBXvbbprrD/SS61Lp3s37KFRUbsRAydhx3WPbv31frN/LsIHpRCFIkaJVXjNC0Lsyj3gysKaZqWfjQ3VnD7bU9KJxWHzeQrqYS8oPX0oUZT526TpYMQAknscMbWsOwdk5hgGiP5RNnqdo/MVRMzTtZOI29sR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W1R2Ebk5; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W1R2Ebk5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780687092; x=1812223092;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8ylB3rlC41NFungz6bMGKN6KJ1Twfg/MRXfgYoGCa0Q=;
  b=W1R2Ebk54BNtt6mjl3uDNJTTs1ZcWdMIGFJm+ouvIBNqfLmhlh3Al/zK
   t5ccSSAPPr8zjgtCzV5ePN9i3mCr4Ch1A7N9mqnaJWUiVN614ZyObtVV9
   sExpFNxh2k0gRWvMgO0EZdCZdKWTxdWWjL9ycZFimY6hnnLnake1dOHzo
   hVCcyGDNKu9lda/8uPlHBR7EBksiMP9sboEJYpYxH2UiaIVQ0DIIT7+CY
   o2hpZr0V5eXDF1oUfRhzGrl2YqTchXF9g+eARHPhmxFi75LHHygscWfSv
   o+dCgUNYe6FzAm6N/IgCDb4d064/x64oXCadAvSscSy0XrntdSxQOGru1
   g==;
X-CSE-ConnectionGUID: ia4+0tiSRneb0adibhJRYg==
X-CSE-MsgGUID: 8W9RADL4SLmIRWT38jC7SQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11808"; a="85379743"
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="85379743"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 12:18:11 -0700
X-CSE-ConnectionGUID: moRiP4L+Q9SsO7ZeIHQErQ==
X-CSE-MsgGUID: 297YXmXiQE+SgacElZuO6A==
X-ExtLoop1: 1
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.178])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 12:18:09 -0700
Date: Fri, 5 Jun 2026 22:18:07 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Jinseob Kim <kimjinseob88@gmail.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Sanjay Chitroda <sanjayembeddedse@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, sashiko-bot@kernel.org
Subject: Re: [PATCH v2] iio: buffer: Ensure bounce buffer used for unaligned
 case is zeroed.
Message-ID: <aiMg71I2O6a94g3o@ashevche-desk.local>
References: <20260604084307.640053-1-jic23@kernel.org>
 <aiFBEn_DKx5f6ekv@ashevche-desk.local>
 <20260605145000.0ae0356e@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605145000.0ae0356e@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 05, 2026 at 02:50:00PM +0100, Jonathan Cameron wrote:
> On Thu, 4 Jun 2026 12:10:42 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Thu, Jun 04, 2026 at 09:43:07AM +0100, Jonathan Cameron wrote:

...

> > >  				   indio_dev->scan_bytes, GFP_KERNEL);
> > >  		if (!bb)
> > >  			return -ENOMEM;
> > > +		memset(bb, 0, indio_dev->scan_bytes);  
> > 
> > May I suggest different approach, id est use __GFP_ZERO instead of hunting
> > correct pointers?
> 
> That's a weird beast when combined with a krealloc so I was a bit
> nervous about readability (and less so whether it was correct).
> It should be fine in that we will either get stale data or zeros
> because we always use this path to allocate the buffer so if you
> think it is obviously fine then I don't mind.
> 
> The oddities are that if an object grows within a slab but doesn't need
> a new one we are relying on those bits happening to be zero based on the
> original allocation doing __GFP_ZERO as well (as it's the same call)
> 
> I'm nervous though as that region off the end is sometimes used for
> debug objects and I really don't understand that bit of slab well enough.
> If it actually does this, then seems like we'd end up with a lot of
> nasty corner cases so I assume it doesn't.

Such a bug will be a serious issue in mm. I don't think it exists.
But, of course, chances are not completely 0.

Current users (not a comprehensive list)

arch/arm64/kvm/nested.c:92
drivers/firmware/efi/capsule-loader.c:61
drivers/gpio/gpiolib.c:5198
drivers/media/platform/amphion/vdec.c:329
drivers/net/ethernet/intel/ice/ice_lib.c:3044
drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c:785
drivers/net/wireless/ti/wl18xx/main.c:1582
drivers/nvme/target/pci-epf.c:708
drivers/spi/spi.c:1411
drivers/usb/gadget/function/uvc_configfs.c:880
fs/ceph/mdsmap.c:322
fs/smb/server/ksmbd_work.c:123
lib/tests/slub_kunit.c:273
sound/soc/meson/meson-card-utils.c:49

Also note the kernel-doc for krealloc_array(). It has some note WRT __GFP_ZERO
and it means the flag must be supported. Also there is a note in mm/slub.c.

> However, I couldn't convince myself enough not to just force a memset of the
> whole thing.

I personally would go with __GFP_ZERO.

-- 
With Best Regards,
Andy Shevchenko


