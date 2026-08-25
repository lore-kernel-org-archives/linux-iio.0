Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C9B3E5A0C;
	Tue, 25 Aug 2026 08:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787648379; cv=none; b=upyMUOUkbE+LFBeow16HTvmCBd3TEIxQFrFRbQywO8VgmDn2UKU98B84fahHO+ij6naVoyqlvC7CY1qffWS56Ljq2tXxJ23YJ8R/wWhhCaryV+DhCLp9OIthrcVEIM3qDtj6bx++ddQEj/rLs45h5vPmb17bEsXUqQeG7e9IXww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787648379; c=relaxed/simple;
	bh=Z5xmtRs/jH5OXHIBbTDVWAz4zFTm2UGPBtspIE6dm5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOhY6F8o10sa4sc7Gwxhfe+qhtQg0AznTujPO0NqKeC97O437KlrJa1mGPf+GWdj2VCd8je08Nh3rsf5Bj1mR7JT6feYv7UubuH3vMh7IMV2liAn8b8hwwuNQ1YuTrxqelTOFMtO5FtBdFcUfRVuXFlTIwS8hW2lCkiywa9X/u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bn/77XI9; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bn/77XI9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787648378; x=1819184378;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z5xmtRs/jH5OXHIBbTDVWAz4zFTm2UGPBtspIE6dm5o=;
  b=Bn/77XI98PLhMKGkPGaCaK1RxnGhYVoJnoFGLi/pVYCuyDF4Cr3ocglj
   gOKztspRMaeCdGh/H3pjFx9smTyyqBcVGsq4widTcqROMCOFqBh+tq0IS
   sU7K2vmqw5G13Xxo+HUhDx2hgeKS2G5Q1Xjkufs4ujJ2u5q1WkyohbrBp
   fgJNQa5osvpe3KvlDBLeyQuno2ewcx/61CDDfkHyta0wROrgoTIAi8dOO
   IIKT5KZsYJ3G/rVSSfeTlfgDovYZEOny+vCRoSA0fHgYEpHtWMypmdR8o
   gAdgU6w81gujdJkVPFMQT+w/op5RVcC2SPxVcpr8JTvFhcHxanbGK4Uhr
   w==;
X-CSE-ConnectionGUID: IEaIiekbSYy5vZIU3PKNDw==
X-CSE-MsgGUID: SqCk+croSZa0kPq2EgXjIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88031903"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="88031903"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 01:59:38 -0700
X-CSE-ConnectionGUID: twu9if2wTgyxknFxE8T+Aw==
X-CSE-MsgGUID: xmNkPoIUQtaoKJ4PsEaLKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="266687276"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.59])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 01:59:34 -0700
Date: Tue, 25 Aug 2026 11:59:31 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Bill Wendling <morbo@google.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>, Joel Stanley <joel@jms.id.au>,
	Jonathan Cameron <jic23@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v6 3/6] iio: pressure: dps310: rework the raw read paths
Message-ID: <ao1Zc-W9A6oQ-GwQ@ashevche-desk.local>
References: <20260824201203.396651-1-zoone.rupert@gmail.com>
 <20260824201203.396651-4-zoone.rupert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824201203.396651-4-zoone.rupert@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 24, 2026 at 11:12:00PM +0300, Rupesh Majhi wrote:
> Raw reads take the lock themselves, so a processed pressure read takes it
> twice: once for the raw read, then again when
> dps310_calculate_pressure() trylocks to refresh temperature. Refresh is
> skipped whenever lock is busy.
> 
> Split raw reads into variants that expect lock held, one helper per
> channel taking it once for the whole sequence. Temperature refresh is
> unconditional now. Buffered capture later in this series needs the same
> shape.

> Also use get_unaligned_be24() for 24-bit results, and mark functions that
> need the lock with __must_hold() rather than a comment.

The first part should be in a separate patch (24-bit value handling).

...

You also need cleanup.h for ACQUIRE().

>  #include <linux/math64.h>
>  #include <linux/module.h>
>  #include <linux/regmap.h>
> +#include <linux/unaligned.h>

-- 
With Best Regards,
Andy Shevchenko


