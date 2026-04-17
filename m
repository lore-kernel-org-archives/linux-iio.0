Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA243750CF;
	Fri, 17 Apr 2026 11:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776425418; cv=none; b=fAvA1w7mAfoVDliIjFQmckyIEkqP+JOXcJnDxchHE9/NvHHLss8c07/irAm1n9l7/wsAiRkUu0pu26a3NYC2jEvvZDhMFuIvKBtMdP6VKhcBHlbq96zbZeBoLJIv40P2rvZHrCeweo4LOqLBZ29yyREv0jLa1A7ZbIAuXsSNL9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776425418; c=relaxed/simple;
	bh=X0HwQ2XM2HT6sSJTIYWdqtVrXTeGfAYF2/cRAoxVLe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOrcKbgajWm2WUTRAQfLnUt+k2p5wLz0NKNGUu9je/mtBPLoyg9Ohk0mjhndyrMvQQtKRjWA49X1TIIv0Agg0ZqzOhkj2lZVNL1KzThA1gdvnFc7n75y1lsCPEGNL79/gBTyApvA5OorSnBorVfVDIBlgBgLoPcRePAhtDYnvuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iPfeWKwz; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iPfeWKwz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776425416; x=1807961416;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X0HwQ2XM2HT6sSJTIYWdqtVrXTeGfAYF2/cRAoxVLe8=;
  b=iPfeWKwzfQZwHnVdX1sMki6Qhq3jrHxoBLS3pLloWIRUKn9DYdtbSbnu
   1hZ+RokBVG65fMroKfJp2d03xD92wQEtME4MnAfXNdSkWvyDrjPJtO0XE
   YOLt50V2sBOajHCAcmU5WA+8/Bt15nYdxcHUvFWmFMgyqzLu8Zx41Z7MO
   SXF9or6lWAZ+AwTXmFb3E7v5GpT5HWJKj743BkkHK0qYHXZd4k/v3OG12
   eCBqV2tJQKCVWsf+VZKL969IRCpjkJSex4QUIDntti9yJfNcKrgr6Z+pY
   On+lYyPJDMWRjCOjTiwZLb2Hxggc/8BG0f2ULuUivHQmFYzSnhhzSRRzP
   A==;
X-CSE-ConnectionGUID: QLFzdjhrQIidqb8jN2xT3Q==
X-CSE-MsgGUID: kDUnQPFWRWmBoUGn2Lzf2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="77512547"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="77512547"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 04:30:15 -0700
X-CSE-ConnectionGUID: ZNvj0jamRtmEo4MoJEW+3w==
X-CSE-MsgGUID: 1hX8Qd1KRfGG01lABFEbYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="236000416"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 04:30:14 -0700
Date: Fri, 17 Apr 2026 14:30:11 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Junxiao Chang <junxiao.chang@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, gye976@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de
Subject: Re: [PATCH v2] iio: buffer: fix warning in requesting threaded irq
Message-ID: <aeIZw2gvbZGJEXy9@ashevche-desk.local>
References: <20260418002334.3643504-1-junxiao.chang@intel.com>
 <20260418085156.121947-1-junxiao.chang@intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260418085156.121947-1-junxiao.chang@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Apr 18, 2026 at 04:51:56PM +0800, Junxiao Chang wrote:
> IRQF_ONESHOT is for threaded IRQ. If there is no threaded IRQ
> handler, this flag should not be set.
> 
> This change fixes a warning during booting with kernel v7.0-rc3:
> 
> WARNING: kernel/irq/manage.c:1502 at __setup_irq+0x1639/0x2510, CPU#3: iio-sensor-prox/974

> RIP: 0010:__setup_irq+0x1639/0x2510

Unneeded line (it dups the previous one).

> Call Trace:
> request_threaded_irq+0x2c7/0x490
> iio_trigger_attach_poll_func+0x353/0x6b0
> __iio_update_buffers+0x2420/0x2c70
> enable_store+0x183/0x270
> dev_attr_store+0x5e/0x90

> sysfs_kf_write+0x1e8/0x290
> kernfs_fop_write_iter+0x406/0x5f0
> vfs_write+0x71c/0xea0

These 3 lines are also redundant.

> v2: using ternary and drop temp variable

Changelog should go...

> Fixes: 23f2d735a932 ("iio: Add helper function for initializing triggered buffers")
> Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
> ---

...here, when it doesn't go to the commit message. One may find this in the
lore archive.

...

Code wise now it looks good.

-- 
With Best Regards,
Andy Shevchenko


