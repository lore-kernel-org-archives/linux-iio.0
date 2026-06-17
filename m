Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98F93B71D7;
	Wed, 17 Jun 2026 06:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781679511; cv=none; b=H+/OqjUvav82NOYWCGH+FbQPPxFsGHLhAoYXYd0LR/VQwSu+1PzgZUiisXrUlYZcMPMH8BIZTTHd8cALjj41U0D2peJpqD9YEyLJAvxcCZ485RiSndUL3stMIkhk7pLuojXktNSPY8g5wyH8hNWMiuTUk6PXC5xU36meEjYaeNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781679511; c=relaxed/simple;
	bh=4R368YpNVYB1CWV1mCfHtFsvqsW1qk2EINSBEFTplX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oob+OCyn5VQSCbjG7tdgppFCY4NVbDqhaxtNzmlyl89NvgCV8AfGPt4J0BkAtbVmWdeZQR4xVskCA539zD4y5v6U27X1y0TBGplYOuZ2BdTms7D091Mv9KVC1ucxJj8P/2qP6bJ/+lv62CsK0/nlnT3F49gXphDIhWD1P1+/E7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dm5mLjLg; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dm5mLjLg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781679510; x=1813215510;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4R368YpNVYB1CWV1mCfHtFsvqsW1qk2EINSBEFTplX8=;
  b=Dm5mLjLg762wD7sZkx7KdwURmPVUIVoXMQxQ/ui86kAlPvSOAmNr4uip
   8Aq+JK8v2ydSDG9JSlU3undTzHtBvnbHMN/YC4pZt5qWTxPino+3dz42/
   K8lMVFfKwmGEz1ZvICzqvNoNYugRN1c3+GIShdlBEWJ+rfwKszF4ri3uX
   L7DhNmxxskPe2OmSwQ2cYQg51S9GeuATKrMYG4U/qSuXcJSZ21Z1R7ygJ
   FpRg51nqk06Qsr7QNLX56em5j8KzoXzzmkW8UVXdaR26iYmtSkW4r9qcM
   yrgDBjUPykLdyALznkHtf63vz4Ida8ls+9S+JXBr0YMDxaezLwTjs70e5
   A==;
X-CSE-ConnectionGUID: OwZKKos1SWCX4z2j+wBJuA==
X-CSE-MsgGUID: RwhAtgEaRfiY+5yomjF8EA==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="82343274"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="82343274"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 23:58:29 -0700
X-CSE-ConnectionGUID: G8A4cpSMTwOtl3CIbEzCXw==
X-CSE-MsgGUID: +sgGFyW5SG+EMqoAwpEM1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="278185515"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.69])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 23:58:26 -0700
Date: Wed, 17 Jun 2026 09:58:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Yash Suthar <yashsuthar983@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, salah.triki@gmail.com,
	sakari.ailus@linux.intel.com, Achim.Gratz@stromeko.de
Subject: Re: [PATCH v2] iio: pressure: bmp280: return on runtime PM resume
 failure
Message-ID: <ajJFkNWEdLaIMUcX@ashevche-desk.local>
References: <20260616093126.66312-1-yashsuthar983@gmail.com>
 <20260616114621.16480-1-yashsuthar983@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616114621.16480-1-yashsuthar983@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 16, 2026 at 05:16:21PM +0530, Yash Suthar wrote:
> Replace pm_runtime_get_sync() with pm_runtime_resume_and_get() and
> propagate error.
> 
> Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>
> ---

v2? Where is the changelog, please?

(This time just reply to this email with a changelog text, next time put it for
 a single patch after the '---' line.)

-- 
With Best Regards,
Andy Shevchenko


