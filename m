Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795643841;
	b=Be5o8h+AarI+46B9m0UgqipHTzyHC5yj17VsB7uP1rLT5Jq06jjecz9OTGGvYtugmuu0
	 F9kAYul6+ueZ8e81+fzTaYqBl0XGMml8LQMQwT5cuM6+xj9s/1SfsGCVvcwRYF6HAOTb0
	 SrDss5xBQIQm8fnG9WxjDgMTUW4Nub7u87Wjv8TCTekw1louDBFlT1iiM0oO5HFp5n9Bl
	 5sbsUE/dmGhzguKBW1G0XAPqEW5hjylzW18+h57TfctNkjxL+adV/H0BZeefkTj+iH2Zs
	 chRpj+LpaBnJrEhgMBvYFaMNDw4HUCx1a4/+DKpkmZljaPjGw9tAWZb5kNJORGd+NVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795643841;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=qmP5Jdad07O6ks3WIceH4SrcsGPpZ6VnUNTz1k+Kn9k=;
	b=Acic3vImIYFDadj8hQJ22Yti7VBPvmSXsQZlmXd50HJqJ4gGm16vdpdM6YiLrwylLl5y
	 wwqXyREZ//kk9BaIvv2OdVFHYXg5iHhlvNmrCWL7VpCAjfdz54hkL5fXxCFbzvwtjbjII
	 uro/DfZvEpOs535TwrpJVIWAFzFG6z2jjjDou2YDB46jdES993yWoafPlBqf9LZmURc5d
	 0P4TW9ikvz0127hXQwy9xwmVcd5YkQJ/uWJxaCKHosxGvLTW6a9WuRGrIG4dwHsykA2bg
	 yidhaqVdUuQ6JhiVR84HLPik/4RZE1fjmXIjfYUU533acUpeEmE1pYT21cd4Ws/0wtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YTQDnlrr;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2659606A321;
	Wed, 25 Nov 2026 21:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2659606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YTQDnlrr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795643840; x=1827179840;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YsGA109JKb0XGyZ0iIgbqFxSMZl8ygNh3OSlEMQPl+g=;
  b=YTQDnlrrqSOmkXfgXhsKyaI2Pwwas4oAkXtrqCSpIxDSs9RBQmg+XbRf
   39GfELFOjKSJQH6WRmHgc/xOEq2CjJpvN03JjlEgVY8kb2AEl8pJKfMjd
   JwZuKpPcsuHdnPxe55mrCM9TS7jXEwXYg/jv2imcaImYULx2OZVeagPdH
   rMZGH+kKeCBkgHoTgCRMritHHv2zVMq7b5snzEAeU5VbplBBIlQJQN2PC
   3aWlozX7pnxBBTimOVCWuRLU6m23j1myTzM+76ceOus7jvCEKB2KHUEHP
   pCENV4Hc7iXZ/YkqFeiO7YBNAgQsceWYgwzOtxa6DsC1gNb2bXF6sr8Tk
   Q==;
X-CSE-ConnectionGUID: N/nMkPwySSK9MXzJnyyxgA==
X-CSE-MsgGUID: Xlm9CKkIRgSHT6vFb9AZ1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4429601"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4429601"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 13:57:19 -0800
X-CSE-ConnectionGUID: RqhCKDMyS7SzIoZAlwDHyQ==
X-CSE-MsgGUID: X48KgJsnRfOCT5HDrja9jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="12228271"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.73])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 13:57:16 -0800
Date: Wed, 25 Nov 2026 23:57:13 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <crofts@kernel.org>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Nishant Malpani <nish.malpani25@gmail.com>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] iio: gyro: adis16130: apply iwyu principle
Message-ID: <awdZuWcPTXQ35SMX@ashevche-desk.local>
References: <20261125-gyro-kernel-header-removal-v1-0-969b3e668d35@kernel.org>
 <20261125-gyro-kernel-header-removal-v1-4-969b3e668d35@kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125-gyro-kernel-header-removal-v1-4-969b3e668d35@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 25, 2026 at 08:24:05PM +0100, Joshua Crofts wrote:
> Remove the catch all kernel.h header and add/remove the remaining
> headers in accordance with the IWYU principle.

...

> -#include <linux/kernel.h>
>  #include <linux/spi/spi.h>
> -#include <linux/module.h>

> -

Leave this blank line before iio/ group as it originally was.

> +#include <linux/unaligned.h>
> +#include <linux/types.h>
>  #include <linux/iio/iio.h>
>  
> -#include <linux/unaligned.h>

-- 
With Best Regards,
Andy Shevchenko


