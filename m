Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A2B28726E;
	Fri, 17 Apr 2026 06:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776408466; cv=none; b=tUf73jureVPvpjiMYFuF3037siAzPe/UACTVsN02ybBNQkhsfzGEHOb5TOvXkyGQ+aezGWJ0UMBxhi+UFcGXmnxdy5gpWCeSmxLNcHPd6+u8fVXJw/jV0LY53KLlb091mYuhvvvmcDq+pg4O5vXWpS+0jPDU6ucd1sGB3vRnfhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776408466; c=relaxed/simple;
	bh=kQ5N7h/gYvMCv9/uyfdQ58utcug4b3OFMp+6FzcfOqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LV8AxSrX60OX4NQSTM9BTEPo4rYmGGGQieNAFEc+Vf5eHF5K25uOP0w6O5Ywc+LABbmrmARAryvCODsHqCBNR4+bDOZtPqaZ4GIDkei8AK7nYg9ZjRH3Hc8EDAK/npWc6hSgPlQ2P4SjciBHB8FO0Zem2xJH+ahtqh+R4TcF7Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HLjVlqUc; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HLjVlqUc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776408465; x=1807944465;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kQ5N7h/gYvMCv9/uyfdQ58utcug4b3OFMp+6FzcfOqk=;
  b=HLjVlqUcCmkJWzOJJRFJwZJx5oTLpq6i8I1vpF1Tfj0ICg4Be5FdO4oL
   D6aMQv9I3c4/+1FdDVgXWQZxqTX4bSfpFeEHyXXg1kh36gu+OsBdhNFn6
   g+1Z5s82WuZCYvHmvjI1IkLH9B/eQO2t9WOmyifTTtAsZp+2okNFIPFla
   U2VMusAxfSknUdVD8Y8pWU1eZhfMpMfHx499kW6jSpVPgrr9jjdlTMono
   OWuJUax2Kiqm1iiKGcMUanjNlzW+/qM/fXu+VkuTTiJIKninB30yAvZT6
   Xo/k6Tq52DB66nKZThOCLwYorT4GSAtopPROb7405S/Zr8TVTDKVtcizM
   A==;
X-CSE-ConnectionGUID: SuQ7zRcTS+mJjfKQMa/Dqg==
X-CSE-MsgGUID: qGGuF4KJSui7t+m8qPLBiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="77493934"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="77493934"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 23:47:44 -0700
X-CSE-ConnectionGUID: lqXZtQxuT6SrhwTpnNc8IQ==
X-CSE-MsgGUID: gmEDLjPWTt2njqAiNtBpmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="229946277"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 23:47:42 -0700
Date: Fri, 17 Apr 2026 09:47:39 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: frequency: ad9834: clean up includes
Message-ID: <aeHXi8-zYZu-9NPr@ashevche-desk.local>
References: <20260416093240.1294-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416093240.1294-1-joshua.crofts1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Apr 16, 2026 at 09:32:40AM +0000, Joshua Crofts wrote:
> Cleanup include headers by removing proxy kernel.h header and
> unnecessary list.h, interrupt.h, workqueue.h and slab.h headers. Added
> additional headers that were previously included from kernel.h.
> 
> Verified using the include-what-you-use tool.

I'm wondering why in previous round the tool haven't noticed what I did...

...

> +#include <linux/bits.h>
>  #include <linux/clk.h>
> -#include <linux/interrupt.h>
> -#include <linux/workqueue.h>
> -#include <linux/device.h>
> -#include <linux/kernel.h>
> -#include <linux/slab.h>
> -#include <linux/sysfs.h>
> -#include <linux/list.h>
> -#include <linux/spi/spi.h>
> -#include <linux/regulator/consumer.h>
> +#include <linux/dev_printk.h>
>  #include <linux/err.h>
> +#include <linux/kstrtox.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>

> +#include <linux/string.h>

Hmm... What's used for here?

> +#include <linux/sysfs.h>
> +#include <linux/types.h>
> +
> +#include <asm/byteorder.h>
>  #include <asm/div64.h>

-- 
With Best Regards,
Andy Shevchenko


