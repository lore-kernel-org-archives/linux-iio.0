Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9104F3B6BEB;
	Mon, 17 Aug 2026 07:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786952646; cv=none; b=TDJ/MlTSwCnco4ce/BMqZWUPh+QQUFYj657YRebTSmCdCM6nwecuvVpNtKAVmCHgNExmIcq0bfkyix4VdEa0T35YbmAAcJ3AA7OA5jhVHs4yNDvA/1WbYzNkEG916gzX/aREnlb4P0K7WknJt3cwXzFehN257HXmmFPQ67RqlVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786952646; c=relaxed/simple;
	bh=XysWw+HgpgCpFzUNyX30UaghhxFZ82RjxLlh24SgGWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHvjGYBf2NXF2TLbn+7fBdwcKC73zN8c4HFPwN+f2wZWr0TAbHrCmVAUVbHZiP522n5EXUwGGWhOVr5mqhAKJ1gqF9zfm/z0iD8Fo6oLgJ/qwvKuLUmgz98cxz4630XGEJSf1vQkC931hgHpO/19PYzTgDMZFBVOLR7KGDOeb64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aHOXRPlx; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aHOXRPlx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786952645; x=1818488645;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XysWw+HgpgCpFzUNyX30UaghhxFZ82RjxLlh24SgGWo=;
  b=aHOXRPlxtB849zpsv1U3Cs4SulLiX0c605lI357bCJmnImhDVsi2jVCm
   VHG2U7YjDHTp6u3Isd3YMGHXfEvCWybUCCMKKoHzd19JXsfaTESNPbg8V
   4K7mzOYMt98pcLSxnKQMBs1X09ecN9RE0A/4AuKZO3YpaLkt66+GygVWX
   SXMU1D2PlZ2NznPf4QxCVSGcepXMt10Rd+OGR/Jpg1Gx89uUgqg0G8KW/
   3xxFFw7VsyrDjDnWnWP6nx/u4nviTnKd3aMDHQmbL9y7Eyq5eHB3/IFbo
   Jq6GYsmPBoK3wDsXjAvl9x+3YYW1oKKA0Xi934H6oWevbZTdOZRccr8Dq
   w==;
X-CSE-ConnectionGUID: BtR8705GTQ+rCGDq5jeExg==
X-CSE-MsgGUID: rf7d/c+JSUS9cKn38N9yDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="104802158"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="104802158"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 00:44:04 -0700
X-CSE-ConnectionGUID: gDDBsaQ/RLm2rKNgQzJyPQ==
X-CSE-MsgGUID: 0hPaPlHwTQKyCTmygjKVzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="263502794"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 00:44:01 -0700
Date: Mon, 17 Aug 2026 10:43:59 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: gts-helper: fix error headers
Message-ID: <aoK7vz62nvmw0FJ9@ashevche-desk.local>
References: <20260815-iio-gts-err-headers-v1-1-3a668373aaae@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260815-iio-gts-err-headers-v1-1-3a668373aaae@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Aug 15, 2026 at 12:23:47AM +0200, Javier Carrasco wrote:
> Both industrialio-gts-helper.c and iio-gts-helper.h use error codes
> defined in <asm-generic/errno-base.h> (usually included via
> <linux/errno.h>), but only industrialio-gts-helper.c includes it. On the
> other hand, that file also uses error macros like IS_ERR() and
> PTR_ERR(), which are included in <linux/err.h>.
> 
> Add the right includes to provide the used elements from the error
> headers:
> 
> - <linux/errno.h> in iio-gts-helper.h
> 
> - <linux/err.h> in industrialio-gts-helper.c, which in turn includes
>   <asm/errno.h>, which only includes <asm-generic/errno-base.h>

Makes a perfect sense.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

> ---
> I stumbled upon this while refactoring veml6031x00.c
> (which uses IIO GTS) just because clangd threw a couple of errors where
> -EINVAL is returned in iio-gts-helper.h
> 
> In the end everything compiles anyway, and therefore I have not
> added a "Fixes:" tag, but please let me know if that is really required
> for something like this.

Yes, sounds good to me.

> It is also true that if the gts header is
> included first, the compiler will throw the same error clangd showed me
> and the kernel won't compile... Unlikely to ever happen, though.

-- 
With Best Regards,
Andy Shevchenko


