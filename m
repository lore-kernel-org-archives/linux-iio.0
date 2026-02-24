Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95683A0B3E;
	Tue, 24 Feb 2026 14:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771944582; cv=none; b=ioDCknKfG1V14gBcHTCp7HLLQTbK3Dp524iWXmGos4e4g9+/BcEQVB4pHIr40OsUk4px18th+HrZbogJOhwmP7qMCuntBTmgw2N7G7MpVIkIX3vNxGnGnOxxUCIZEfl6pfrsLJv+oX1KLwWk23Kk0SiY8xIn9VISM2toCs7X7sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771944582; c=relaxed/simple;
	bh=kzKyPCKJfVhUXQ5CCK0/aW48X58OsKs9+jy2gNyjIto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsehDN58xcOVhGEASIa+J3Uod25Zv23WW1AnpK4cD1O54jN9SDGqC/m8EFcEKtNCmrtzqWT0WVS30x+SGXTqHoBwusC/OsXy15LlQK7f/PoqgUiqVlEzOQijjlxsE2QwoOFNeCanV4hJFu+5maR+S2Ic3JjKZyya+anPvS53x+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gyvmsQxH; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gyvmsQxH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771944580; x=1803480580;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kzKyPCKJfVhUXQ5CCK0/aW48X58OsKs9+jy2gNyjIto=;
  b=gyvmsQxHH0M0SWFppoZGfziXKPmDtX8XoxnZ99U/gpGWNPthDi4gCLo/
   k3HtKyPbr2fvqQ7sH5/1om3F60CctY1atjbl69Q9YLUwn/9mtHEGTRz89
   IO2njMvc4ySVO8s3nmlMuEisH8PfmflEWLhrBtQhEytWksbH8Ev4HuzAz
   UWulPl4t5KJ6y8Oy5VnbEeK5tbN+OjKJAswFmCr5akYW41VEQyAVE+x54
   aOzZ5bkyzheJicdGMILE2mQOUKgNmShhKMqRgjlMWi7UhF4iYsTkxnL14
   u+Ax4Hu7KMkCVv+1Fvtw7cWv0jPlClJkxMx8esfuVZv5to0RF5vyLP6Bn
   A==;
X-CSE-ConnectionGUID: pI2f9r9NQea+slIBg+js3A==
X-CSE-MsgGUID: y3RsJM4XSVuDuaeZPjhW+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="83670309"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="83670309"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 06:49:39 -0800
X-CSE-ConnectionGUID: nAuvNXGCQB2yJisoRR/IuQ==
X-CSE-MsgGUID: gQL3OJ/aTAihT1fRRIYJlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="215012860"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 06:49:37 -0800
Date: Tue, 24 Feb 2026 16:49:34 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	"jic23@kernel.org" <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	"Sa, Nuno" <Nuno.Sa@analog.com>,
	"andy@kernel.org" <andy@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: ade9000: fix wrong return type in streaming
 push
Message-ID: <aZ26fsmZbhiyIpcr@smile.fi.intel.com>
References: <20260224125921.70946-2-giorgitchankvetadze1997@gmail.com>
 <CY4PR03MB33991683F0E5E5212987359E9B74A@CY4PR03MB3399.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR03MB33991683F0E5E5212987359E9B74A@CY4PR03MB3399.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 24, 2026 at 01:09:49PM +0000, Miclaus, Antoniu wrote:
> > From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
> > Sent: Tuesday, February 24, 2026 2:59 PM

...

> > -			dev_err_ratelimited(dev, "IRQ0 WFB write fail");
> > +			dev_err_ratelimited(dev, "IRQ0 WFB write fail\n");
> 
> The `\n` is unrelated to the scope of this patch.

Seconded. Please, also check how many such cases in drivers/iio/* subfolders
and perhaps send one patch per the entire subfolder.

-- 
With Best Regards,
Andy Shevchenko


