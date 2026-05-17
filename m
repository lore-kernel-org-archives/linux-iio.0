Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452942D8DA8;
	Sun, 17 May 2026 10:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779014574; cv=none; b=RiqCQ6E30XjbmJQLNvVC6CKe7D4fgm1gfTvQCOAoiGSwTYBzJyAChDBKyigCTmTHydGE2ptD8kbENSWSxyFMXQnxDCV3mEYujwHKa2edskq1rha352yQpGRPY1P/lNGTLRtsTTxvx0zJc5nd+0putzlxw5cFM6DBB+tRsWu+GuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779014574; c=relaxed/simple;
	bh=2mK3XOvJnlCp6WMKByrqnYyniq34b0wgXrBMPKs1Bxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgbSl5eloacEuk05aIlQOb5m9KZ2ewv7hWoI5EKfesLD+bZxldGoVfX2VEJSFNb0BZ+DqLVZEqLgdqVr07qzlxZb2Ko+dTII5LA1+nhaFNgZGo/+Gqp7qVc1BwLtMcG6p+J7o5KpZ6zeMx183g+XXzgBeogSclrSA+SwRTnevaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KCzBLYVh; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KCzBLYVh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779014573; x=1810550573;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2mK3XOvJnlCp6WMKByrqnYyniq34b0wgXrBMPKs1Bxo=;
  b=KCzBLYVhtHt4zr2ef8JVTCMutCXCyyXb5O+ttCuVpsqgFs0ITfIcFyCI
   t2hQ7IJM2FJMkkenPQMnwKGkYFxVpwM0ii1PRhjOgxjUAlTdnbvxain1x
   Tp/CSlpo+/7i/3kqQpq+LRZnPJ2vkABUMF+RWVeeKJZxcBNmChKjq/Xse
   UcFvkxnbMowa31N0rATGgFtDH7kCm4BfemK0CDC8M/9CCAbNkThDF/jdb
   fM6Tq5V8os3nXWE+F5exfUj20pM6cVcF27N6FbRZmQxgonZUGxpoBxQmI
   GEa5dwLNFe8EU/UzUjEgIXejiAPg9FVpoSiVbE6WaVTa8B9M4P/cr+Vtp
   w==;
X-CSE-ConnectionGUID: IrD6DI8/T0eJ89QlDf/UQA==
X-CSE-MsgGUID: 2u2ez3xKRqKoZWbqLChCxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="90475155"
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="90475155"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 03:42:53 -0700
X-CSE-ConnectionGUID: +YPDP+DCSA2VTm+jzS9SSw==
X-CSE-MsgGUID: sFu3YuWaS5e/Z2zRchOUGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="244122705"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.182])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 03:42:49 -0700
Date: Sun, 17 May 2026 13:42:47 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, tglx@kernel.org, christophe.jaillet@wanadoo.fr,
	mingo@kernel.org, kees@kernel.org,
	nabijaczleweli@nabijaczleweli.xyz, kyungmin.park@samsung.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 09/12] iio: ssp_sensors: use guard() to release mutexes
Message-ID: <agmbp-ypdMWJCb_F@ashevche-desk.local>
References: <20260515174017.3962168-1-sanjayembedded@gmail.com>
 <20260515174017.3962168-10-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515174017.3962168-10-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, May 15, 2026 at 11:10:14PM +0530, Sanjay Chitroda wrote:

> Replace explicit mutex_lock() and mutex_unlock() with the guard() macro
> for cleaner and safer mutex handling.

...

>  #include "ssp.h"
> +#include <linux/cleanup.h>

Generic headers comes earlier, the more custom they are the lower in the list
they are being placed.

-- 
With Best Regards,
Andy Shevchenko


