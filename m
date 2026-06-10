Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEC3407CE8
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 13:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781098921; cv=none; b=TO+R/coo9cc1D7wngLHjOi6SYAwZoVlXwCj/X7ewDXtj/CwlZwSbdM2M/2yKC4JlLxlJe+zpK8pJKu6f6tB2rwRl1gBvh1SNnr0v5i6cVMZXhwgSwwOsPpjuFq5IwZvk8vFvCCP0vvfblNctUx37/fuXg7dQhUEpX+kCVOAiDgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781098921; c=relaxed/simple;
	bh=JbgH2vjeNXAYPeBLMuiK/bFUXIaif+j7YwH+UiOBSL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ase0mR8JkOSGmcw4R+rx9B4jQq2N85pYZ/ntaMKYyT9Z5o0EX4jyCLfP1FJy/ZxqpnoiMhcUNV2Ywas/6yNdkBhmzqyU4slyTyammROe9KLDAA1xAuNaXm6mBDYDvM4tUiKz9IqNfktl65gZWJQJbQb0L1YGUNq3JdIc/jw1nnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aTb2GD1B; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aTb2GD1B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781098919; x=1812634919;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JbgH2vjeNXAYPeBLMuiK/bFUXIaif+j7YwH+UiOBSL4=;
  b=aTb2GD1BX7xlo8a3xRDJ0z38rED63KQVOA6sjuY/lo1El06o4/6KDWbq
   QHREAZ7w9sSS/uZNbGHMnvRo4a0tU0pUaQzDtabyzynhX93NkI8rxhS/A
   1X0Aksnk7jfCwEgl+T6ZUWGt3cikYF3zAW6+Q8gTG8Wzju1WRuNKb3BvX
   1eOwkDO07GzKf/cWnab5IB3eh3rm8SIZ/vRLVq0gn/NoN+bevhlPBp2s+
   vhqgTVY0NHe0zlc/vunyWRgUfmo5VufnFk0L8xsHYv7j+agnIRKNB2VY/
   AtxOl2pJzdHKY7b90cGVHgKSGBubgPFQRPUBIDlPqttiJ+Gi0rLCLhLkG
   w==;
X-CSE-ConnectionGUID: 4TKpEE4VT3Kp5Qvp8rB0FQ==
X-CSE-MsgGUID: Lhx6KYbWTDm6c7o5k4QmNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81021193"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="81021193"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 06:41:58 -0700
X-CSE-ConnectionGUID: iNAkvPd3QH+QJCuqushTJw==
X-CSE-MsgGUID: CTL25fDbQWWnrDjq5D8igw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="270181672"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.38])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 06:41:57 -0700
Date: Wed, 10 Jun 2026 16:41:54 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: core-trigger: correct CONFIG_IIO_TRIGGER macro name
 in #endif comment
Message-ID: <ailpoosKZwGskxUo@ashevche-desk.local>
References: <20260610040501.204967-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610040501.204967-1-enelsonmoore@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 09, 2026 at 09:05:01PM -0700, Ethan Nelson-Moore wrote:
> A comment in drivers/iio/iio_core_trigger.h incorrectly refers to
> CONFIG_TRIGGER_CONSUMER instead of CONFIG_IIO_TRIGGER. Correct it.
> 
> Discovered while searching for CONFIG_* symbols referenced in code but
> not defined in any Kconfig file.

(Btw, did you do that manually or using some scripts?)

Wow! This line is from 2009

  commit 1637db44413e32a0f100dd4bd164644e641842f7
  Author: Jonathan Cameron <jic23@cam.ac.uk>
  Date:   Tue Aug 18 18:06:26 2009 +0100

    Staging: IIO: Trigger support added to core.

and that time it might have been correct one, dunno. In any case your change is
correct. The new header split was done in

  commit a980e046098b0a40eaff5e4e7fcde6cf035b7c06
  Author: Jonathan Cameron <jic23@kernel.org>
  Date:   Wed Apr 25 15:54:59 2012 +0100

    IIO: Move the core files to drivers/iio

and kept till now.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


