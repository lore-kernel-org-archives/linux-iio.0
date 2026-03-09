Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D926345757;
	Mon,  9 Mar 2026 11:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773056618; cv=none; b=kq+9Wf8/NnOeoVWDO2XAlRd8vU93SZ1dJFQ+BEn6gE1SRyvTUTtHvXW4jtDfg2I120WLMTQUF9O+q+fLqZbVGY+rmrl7x3/9peM17FQQzPCOQHhdFe5U0afwnVuvqygmEixEfFcUOScLloHGqlU+96mbLLtDJca0gNw2OIEZYgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773056618; c=relaxed/simple;
	bh=qGUACVi5Fkt1Z6oxs3ZQZuMX3mY8/lVl2yU0DC3+5g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARKcuNER6LXg7BElUyGGLAaRtQTZQGLfrwGJ28ZxSGY6f9aJZ9UP4GSXDtKXhUZz4EWXfkV/4dX3swXFaBtjVcvno9O0j/2dH/joagRLNa9cgFukSDqp+1qS+DGTsuHgfmjEzKtYtFaNSZALl2/+TzYdpGPhOCdILBr2RatGdM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B/CIfkC5; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B/CIfkC5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773056618; x=1804592618;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qGUACVi5Fkt1Z6oxs3ZQZuMX3mY8/lVl2yU0DC3+5g4=;
  b=B/CIfkC5xYOSS4ayf6GeBpeX533pIFSGbXxBFl46q7A1iY/K5rk+UMTa
   Wifc96SBMYoqPnWWFU4ypJX0slMHpZBmlA1TBEVTlq1joK15/bqHgpceL
   65RUScpbrXflj8tZC2PN+FBRrcbOP2vDeJN/za/aPhtRgBkkYnFupyhD7
   UuahDjagpo7nGVB16Jmy6AvVSgciDRGjLBs7RlZdKCcxLd6tXkDMXWpKC
   ORG7tMu3679fC5Ks/XWK3qINDP7BJHcNot3nMwoyIr7AEGM60B/htXrvt
   o8yU5v9En6acwvEVI38yVqVUskZEEPFWRADjXuNFiSNAasZHCKSr0F29m
   w==;
X-CSE-ConnectionGUID: R9xcdsKaSvK1vTwAv5oauA==
X-CSE-MsgGUID: MMKsVoklTK+7FFwdbVYGbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="84399200"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="84399200"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 04:43:37 -0700
X-CSE-ConnectionGUID: l+bRkiGkRral/sRxiWBecw==
X-CSE-MsgGUID: PVcwWj2XSnyXhMy06EowiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="219709107"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.181])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 04:43:34 -0700
Date: Mon, 9 Mar 2026 13:43:32 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Shi Hao <i.shihao.999@gmail.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	marcelo.schmitt@analog.com, mazziesaccount@gmail.com,
	nuno.sa@analog.com
Subject: Re: [PATCH v3 4/6] iio: cdc: fix spelling mistakes in comments
Message-ID: <aa6yZIx2MlIC08Rr@ashevche-desk.local>
References: <20260309104513.40359-1-i.shihao.999@gmail.com>
 <20260309104513.40359-5-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309104513.40359-5-i.shihao.999@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 09, 2026 at 04:15:11PM +0530, Shi Hao wrote:
> fix incorrect spelling in comments
> 
> - becaue -> because
> - reenable -> re-enable
> - irq's -> IRQs

Same comment as per patch 6.

...

> -		/* reenable any irq's we disabled whilst changing mode */
> +		/* re-enable any IRQs we disabled while changing mode */

'whilst' is okay, no?

-- 
With Best Regards,
Andy Shevchenko


