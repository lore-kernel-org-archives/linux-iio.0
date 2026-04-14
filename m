Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4D12F90C5;
	Tue, 14 Apr 2026 09:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776159487; cv=none; b=OLH2dYfJhCeKfyAKXK/5fssdCVIJxK0LZVVW2MwDirgb19+2gjBsoUZYLTdnqp1TDWXVPDbmoQjX7ANToeH+jOSd/mJJ3uXRgAv/XmdMmQ6fIJA2Zkbv84uebVD6/mgrgaJiONgF/+Vrqosm5NIyua8wpEOE7wP4lNeI8QNZ1MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776159487; c=relaxed/simple;
	bh=Fmukk9SdjloevDp/tG1ja0J0e4LMhkqaQDM1HnccJyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULCR/Ba024u8zjEcbFWwVhCJpWzT9l8du4yCF4ptMgrmPFl5IKZxrArM7twAgEgxM1hVYspxNOPhXqU5Xka24WbYSMcU76TudhavvvysdE3jpLy6uJI9022i7ZBv1l+kalN1NY4/li+ee1orwvOZEFDG1y0WgOlDvEOaZXZTPjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DoH6o44X; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DoH6o44X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776159487; x=1807695487;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fmukk9SdjloevDp/tG1ja0J0e4LMhkqaQDM1HnccJyk=;
  b=DoH6o44X87dxFbEQDmS/jLs49e3cahPDEJq2i3gU2w6UZogB1Wjxme08
   7Yn3akYL41BSPgo7InReAtbGYv5Z4QWVNBtz/nKmCwdTsyMl/zF/zUKps
   UTKawu4wsGUghwIqiGyxtBKX9vbWJYj0mgY8nVy4J8l3izOGv+Us4+1HS
   Z9QLOJyd9qk/iB/wbWSqVYpUChuDNWrqiUSLrwlZHg/wVRxYJLxqVyuLb
   mqDY9kSt/wFzg6/DS+vNLe5ltLdxqbpWzq9xAzt+dwd0fQODEZ7Kt7y9M
   FxVmevbl553dHN7FSIasVQDikvYDLmOL9AeLTeLnTmJNQNTjqYanl+oPJ
   w==;
X-CSE-ConnectionGUID: fO9pbG9GSMqnEolL6DX17Q==
X-CSE-MsgGUID: +JcVZLsnQw+LOp1eY09ujw==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="94511504"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="94511504"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 02:38:06 -0700
X-CSE-ConnectionGUID: oZebxG6PQX6IER3i7uacNA==
X-CSE-MsgGUID: jbCYAYfJTfSlCf3bOBF+/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="230271427"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.106])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 02:38:02 -0700
Date: Tue, 14 Apr 2026 12:38:00 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: frequency: ad9832: remove kernel.h proxy
 header.
Message-ID: <ad4K-K3MpwD3U4F-@ashevche-desk.local>
References: <20260411123512.84739-1-joshua.crofts1@gmail.com>
 <20260411123512.84739-2-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260411123512.84739-2-joshua.crofts1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Apr 11, 2026 at 02:35:11PM +0200, Joshua Crofts wrote:
> Remove kernel.h proxy header and add bitops.h for
> better dependency control and code clarity.

...

>  #include <asm/div64.h>

While at it, you can move asm/* to go after generic linux/* ones as asm is more
custom than linux.

>  #include <linux/bitfield.h>
> -#include <linux/bits.h>
> +#include <linux/bitops.h>
>  #include <linux/clk.h>

>  #include <linux/device.h>

What about this one? Is it used?

Many drivers just need dev_printk.h + device/devres.h. Some indeed require
device.h. Please, double check.

>  #include <linux/err.h>
> -#include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>

-- 
With Best Regards,
Andy Shevchenko


