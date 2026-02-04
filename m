Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E222E2874FF;
	Wed,  4 Feb 2026 01:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770170307; cv=none; b=LCHelfQsIoLxpEicpV9Io9N5OpvaDM5VIZl0aLBh6532PeEDcENmD6tFz3tKCDMvmKr33+IvT6fm5Zu1Rvp3r88WCOIJSfM0Id4kVph7rACL1H/Nyo0zwwLBfPrMGjylyNrhoMmsdjcveh4ZtSA/vqlWWJgu1+8EVQrXQdmWxhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770170307; c=relaxed/simple;
	bh=kMLf16vnG8hRWHb4YugOVcS6S0ml+h59ubq0yByHTzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/s/2JdvD5uglsJVCW+oSbSdqhZ0XfOLs5oSegTj2PKTN23+m3e75cNxf8fEl50ZX+NlTM1Vt9k+lqGE5TvS8VjPdKs7PPkHzWwG3BRaFMujhwWtFGgXNFZAKoT9As7q76ir11N9U8xOyY+O5AlkTTGKBozmrNNDhiaIRbqxEo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UsFHEl5t; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UsFHEl5t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770170306; x=1801706306;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kMLf16vnG8hRWHb4YugOVcS6S0ml+h59ubq0yByHTzw=;
  b=UsFHEl5tc9iicBbvexHk0lwdrjjuY+Sa0NxmtrBonJTi5O7L1AzGwjHT
   Lpz8HOTnNMNX//jNlv2kMwjNU/aP/AOL+Zr8IYD1FNukmmxInIBbiNlVr
   T49e2rVx5icbpDTn0db2xLrN4fjmx2zAJqBtZhHlvNtu8P/kwm9BJuS2q
   /tVSvpW0By0+sOXQbYMWK8WAEC38RiRBBFAci4Ojs8ct0ePkRTPNpyOYp
   gw0305OiAXKEVUhjWHf1Ve8dnqEQKxJKuVhrHooX5AA7gFs4PqzxPEJuk
   1hGSHJVA5/idpgX+Q6sochDebeAXhqN4yiQ0D0csUL70Hm8PNg5at+P7j
   g==;
X-CSE-ConnectionGUID: uZs5Tu7ESTqji51zImJ3mQ==
X-CSE-MsgGUID: tmPJeaxXRQCMmzzKAAD6CQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="94004145"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="94004145"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 17:58:25 -0800
X-CSE-ConnectionGUID: MINsB6ACSzyZpT6d9I/E+A==
X-CSE-MsgGUID: qRoF8C04Qzir25YOi0/5jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="210052574"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.168])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 17:58:22 -0800
Date: Wed, 4 Feb 2026 03:58:19 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v3 6/9] iio: amplifiers: ad8366: sort header includes
Message-ID: <aYKnu8_fEdXGIahE@smile.fi.intel.com>
References: <20260203-iio-ad8366-update-v3-0-5d5636b5181a@analog.com>
 <20260203-iio-ad8366-update-v3-6-5d5636b5181a@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203-iio-ad8366-update-v3-6-5d5636b5181a@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 03, 2026 at 11:24:12AM +0000, Rodrigo Alencar via B4 Relay wrote:

> Alphabetically sort include directives and drop include of linux/kernel.h.

Is it safe to be dropped? Do we have all necessary headers included?

...

> -#include <linux/device.h>
> -#include <linux/kernel.h>
> -#include <linux/slab.h>
> -#include <linux/sysfs.h>
> -#include <linux/spi/spi.h>
> -#include <linux/regulator/consumer.h>
> -#include <linux/gpio/consumer.h>
> -#include <linux/err.h>
> -#include <linux/module.h>
>  #include <linux/bitrev.h>

> -

No, please keep linux/iio/* in a separate group after linux/*.

> +#include <linux/device.h>

What about this one? If you dropped kernel.h, do you really need device.h?

> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +#include <linux/spi/spi.h>
> +#include <linux/sysfs.h>

...

I suggest to split this to two patches:
1) just pure sorting;
2) converting in accordance with IWYU principle.


-- 
With Best Regards,
Andy Shevchenko


