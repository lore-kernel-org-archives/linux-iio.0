Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B2D40D596;
	Sat, 20 Jun 2026 06:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781937393; cv=none; b=FuvyS71MXxq0fzdOZLyTymFqpjTdbL0GZQ4Zro92BIBFRHTUPoDPr8E7COFEVZ0Ti2cUVRxXB3VMcl0P7ydbz76kzNNce7RUhE4nZGLu/+Qy4hwwaoCnlYQzrUcc0EPp6RamQM86Dn0wK3Nl1dXKKQzWeELF9dzzwVfRyv7I/p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781937393; c=relaxed/simple;
	bh=34MAQUITqz9A/cjCg7HPDw9HLDNgNCXRd246f3UT9TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guA4NkfOSB1vKCGIJGIBVUrMpq0oKRtfUpcTYJ5fD2XyZpXd993Opan8hhBbMCBP73DFihucSBJqsJnY+HA6DTPya2Y+xXbQ67DnuaL0i7NixUEDZXpmGWm0SH+U1cWEKpLMA8vfrsTKkYAwhuYvY6H1vpLTnStAMjIIJODUbsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ykp5me9r; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ykp5me9r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781937391; x=1813473391;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=34MAQUITqz9A/cjCg7HPDw9HLDNgNCXRd246f3UT9TI=;
  b=Ykp5me9rNuIsw8R7mG0hDVVlbIfJi3f6oRJ6CZRBHIHZFOgfoj3VtVHE
   yyWzIhC8AgkcSdibBvw+zWfwIsLqEjPd9BhNyLoVxcp4Mp9epOOXadeBq
   0LuBTcwdQNpnvPLSI2sK7razJpngdUWYzh6qr6+UQs8EU5SJiq74Z0+cJ
   ZhtPyKcyy1m7bSEdh+FmRv0B3zZlmnFZ0eoz/HVPPovzgfxpio6wWhPCy
   IeHH6lXlJX2dW9WAcDi92Ab0n9Oyem5qVh2n6SHhMflYz7s7csKgi3O5u
   oRkrBTdc1W8byUaGFHNjTv8JartD08EaLi4Xfvo9j8ZR4e10LCCLfd31Z
   Q==;
X-CSE-ConnectionGUID: pePUbCuBSc2uJOvdEcA5mQ==
X-CSE-MsgGUID: 5tNJNtP1RZaV2kJnmJoJhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11822"; a="82867593"
X-IronPort-AV: E=Sophos;i="6.24,214,1774335600"; 
   d="scan'208";a="82867593"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2026 23:36:30 -0700
X-CSE-ConnectionGUID: NBFx1zhuShKnyE7ExYGhcg==
X-CSE-MsgGUID: H38+LS1aTIWs/ikWubIvEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,214,1774335600"; 
   d="scan'208";a="246440541"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.0])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2026 23:36:27 -0700
Date: Sat, 20 Jun 2026 09:36:25 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Paul Geurts <paul.geurts@prodrive-technologies.com>, jic23@kernel.org,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, tobias.sperling@softing.com
Subject: Re: [PATCH v2] iio: ti-ads7138: Disable STATS_EN bit while reading
 conversion results
Message-ID: <ajY0pjnnzQX0IQm1@ashevche-desk.local>
References: <20260619090004.355053-1-paul.geurts@prodrive-technologies.com>
 <af4dd7a8-4823-4f84-bc88-4b5d8d35237e@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af4dd7a8-4823-4f84-bc88-4b5d8d35237e@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 19, 2026 at 09:42:08AM -0500, David Lechner wrote:
> On 6/19/26 4:00 AM, Paul Geurts wrote:
> > The device might update channel data while it's read by the host,
> > providing a data race. Disable the update of the channel stats before
> > reading the values.
> 
> This description seems a bit short on details. It looks like this
> driver doesn't support buffered reads. So if we disable statistics
> during a direct read, why would we want to enable statistics in
> the first place?

I believe this patch is initiated by
"Until a new conversion result is available, previous values can be read from
the statistics registers. Before reading the statistics registers, set STATS_EN
to 0 to prevent any updates to this register block."
from the datasheet.

I would rather like to know if this is IRL problem, or just a datasheet reading
based code.

> (This driver suffers from the comments say "what" rather than "why"
> /* Enable statistics and digital window comparator */ so it is hard
> to say what the original intention was.)
> 
> Can you explain more what this race condition is about and what
> happens before the fix vs. after the fix? People generally do this
> with two columns showing concurrent function calls.

-- 
With Best Regards,
Andy Shevchenko


