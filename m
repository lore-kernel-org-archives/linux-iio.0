Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8818D182B7;
	Sun, 15 Feb 2026 07:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771140676; cv=none; b=kPhid9VQBCSe1xO0RZxJEa9F0zHwUQl3SzZqAQNPxlcSuaZqYb85QNvb0XmwMjrnGl56g1Cxk7UEzaV1L7bClBuwjGncIm2pX0TBqHZDQw5uPBu4esYG9xuaQS/MHzhTodpEmgL3z/h01JkiVSI5jZdQFy2GzYWgl+eOB3jBNWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771140676; c=relaxed/simple;
	bh=ObAuCStmdUZLmPdGmNRNnrvkcQZ6uHdMlheI7pXmFYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSxk8r/w7AWhIhoHnOjuzCfEC/J0YtX6d/FHW8Rn8mnxxSO4lYHpDM6/84kQrMbXN911VC4wfjUx4saMemASRCMI3XUqc0khx73+LmTsqvMM3PAlK3rxvNvJeWfsqrG83mx7Di/FsF3mWorm1LXWobwixLCV913E+Zzq878Mv8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bo885672; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bo885672"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771140675; x=1802676675;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ObAuCStmdUZLmPdGmNRNnrvkcQZ6uHdMlheI7pXmFYE=;
  b=Bo8856720Up2OmgABb9Oc3qMcrFqERYPMRGJXSTmaPiZuEGrCr/BAALb
   lE8BsJauef6EqpWEQMyMA7/mQsxd1tS7Vq6qQ5UDNphow4mpIQ5GFHXeX
   L8ICyvPrJT0K/MEn+CRyqJMejJBxxfpVzZgQUYDxnCPQHAWhLH+PThIxl
   JpVEEMKVLCplUk5Zu1yfY6sQ5xIEWyZRWJQ23oPem7WeeBjZfVbhDbvAu
   Pugj2vHyyorghuY0YfqtcqxN5l+dfks9wc390Cc8bHd5vqscV9J2AUsxz
   J2N2aXFra7wS814275AGsZqWgar/zM6/Y+zlBlbAgPijlRMhbTObtQecl
   g==;
X-CSE-ConnectionGUID: cc2QeCDLRbeXxXAZmlu/3g==
X-CSE-MsgGUID: i8W118p3TFuqP/EYVE5L2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11701"; a="82591520"
X-IronPort-AV: E=Sophos;i="6.21,292,1763452800"; 
   d="scan'208";a="82591520"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2026 23:31:15 -0800
X-CSE-ConnectionGUID: LVhitiP3Rf2nltHUrpidmg==
X-CSE-MsgGUID: yoZGOK6pSc2Jg+LEyo7Tyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,292,1763452800"; 
   d="scan'208";a="217463092"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.136])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2026 23:31:11 -0800
Date: Sun, 15 Feb 2026 09:31:08 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
	rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 03/11] iio: amplifiers: ad8366: remove unused include
 headers
Message-ID: <aZF2PLePepfGma_N@smile.fi.intel.com>
References: <20260210-iio-ad8366-update-v4-0-15505f7b15b4@analog.com>
 <20260210-iio-ad8366-update-v4-3-15505f7b15b4@analog.com>
 <aYuNr8alZt-mjd5x@smile.fi.intel.com>
 <appnjr2asjxadbvcf2fosrkvfwj3dkcnvq7tk74i4xa4ku5zr3@c7qedqneukyn>
 <aYyFpFAQcfn7Qifn@smile.fi.intel.com>
 <20260214183051.712c8c4b@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260214183051.712c8c4b@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Feb 14, 2026 at 06:30:51PM +0000, Jonathan Cameron wrote:
> On Wed, 11 Feb 2026 15:35:32 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Wed, Feb 11, 2026 at 12:55:30PM +0000, Rodrigo Alencar wrote:
> > > On 26/02/10 09:57PM, Andy Shevchenko wrote:  
> > > > On Tue, Feb 10, 2026 at 07:42:03PM +0000, Rodrigo Alencar via B4 Relay wrote:

...

> > > > Yeah, but it also means to add (a lot of) missed headers...
> > > > 
> > > > array_size,h
> > > > dev_printk.h
> > > > mod_devicetable.h
> > > > mutex.h
> > > > stddef.h  

...

> > > This is the output of the iwyu tool without this patch series:  
> > 
> > Have you applied the configuration Jonathan made for this tool in relation
> > to the Linux kernel project? By default the tool has a lot of noise, indeed.
> 
> Worth noting that I'm still evolving my config and suspect there will still
> be a bit of 'taste' applied to the output even once I conclude what the
> best combinations are.  So to give my view on the following..
> 
> > 	#include <stddef.h>                     // for NULL
> Not this one.

Why not? Here is the NULL in use, but...

> > 	#include "linux/compiler_attributes.h"  // for __aligned
> Never that one, but I sometimes feel compiler.h is fine.

...taking into account this one, I would rather include linux/types.h
instead of any of them.

-- 
With Best Regards,
Andy Shevchenko


