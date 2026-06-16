Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7487239B94C;
	Tue, 16 Jun 2026 07:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781595590; cv=none; b=rUkK7rIRSP3bKWuEmvXT8UfYkXmecl0U1pgAqVptWl6FWlvnQUuSugQfzMbkrty43FGBuWDxQY7EiXF7f8PNmjLPor2LesbsooswvY2j+Lbv4W7NmU/gIBAFr7ZY14WIoAnKGWBHGlHe1OpsHGLDqZzQgcEqnJbJ04by6sCf4w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781595590; c=relaxed/simple;
	bh=XVqiUOBvZAdvUVzTw7607+3tmKSuVZXXU95d6rhIkNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4KKfX3++7v4qQctFd0mheW09TvXnWgVIPQ+L6eFAlxWJO/MbQYRvNk2div6Rqi+lDDCDYRCPow7MknIs50d2iF4/0heiBHuzD2t67flHxD0y2bKUSETsKetBMDd+QeZSilo7/kolDhfbczizM9w100+0S8VreCql1IIxnp0xtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GG5jBC+5; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GG5jBC+5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781595590; x=1813131590;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XVqiUOBvZAdvUVzTw7607+3tmKSuVZXXU95d6rhIkNk=;
  b=GG5jBC+5sm/vh7dB5rBJ87XEt9AXniLv39NBB5rqglGjT2Cc73b6e/xX
   7eA6DbNCv7MPfKrdL+IMQMyCBGSTTCuQvIIOZNbWoNVC81kjWx9ZSYKMu
   iN9jIn+n2LPnKrpiohx+ULDEGqPiE91zTGGD0tHeUIxr5HCFuntm6xTpe
   mfI9bRzi89C1w5tl3B8WBNROqgi9HzMTYiLy2oHOv8p+vtv4vBhGzYHsT
   vhKManROaMgera2ho4z3zHtKfMpwKgbCur7pWd+3fFpiPXxpqubw5wttN
   l5Fyom6WWrf77zyoLzDUynkasif+sbzMDVB1NC/IobfRCsC3BXGx5oBrs
   g==;
X-CSE-ConnectionGUID: E9AMGyDuSga1E/GLpnNMCQ==
X-CSE-MsgGUID: ad77vwcWT4WoMfJmBKui7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="84916090"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="84916090"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 00:39:49 -0700
X-CSE-ConnectionGUID: If4//IMaRNitadQVzMyk6A==
X-CSE-MsgGUID: hMVixmGFQaispkxdgEHXEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="285809706"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.153])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 00:39:48 -0700
Date: Tue, 16 Jun 2026 10:39:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] lib: math: test_mul_u64_u64_div_u64: define div64_s64_rem
Message-ID: <ajD9wGjqFo9UHGed@ashevche-desk.local>
References: <20260615-test-mul-div-u64-fixup-v1-1-ea186d825745@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615-test-mul-div-u64-fixup-v1-1-ea186d825745@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 15, 2026 at 04:51:15PM +0100, Rodrigo Alencar via B4 Relay wrote:
> 
> Define div64_s64_rem to avoid multiple definition or exports.

Thanks for fixing this.

> ---
> Recently added div64_s64_rem() is causing issues in a the
> test build. This could be a fixup patch amended to:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=adebf76278116a06166d0b5f8b4112ad5dd6389a

I agree with this. Since the testing branch is subject to rebase on top of
-rc1, this can be also injected before or during that time.

-- 
With Best Regards,
Andy Shevchenko


