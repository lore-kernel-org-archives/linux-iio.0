Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E13226B2D7;
	Fri,  6 Mar 2026 12:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772799871; cv=none; b=WQU8NcaGcssY5JotbwudEp7ZzA4kfkCp6r9+/ulsdcpfgeln9ZxhbmaTPJHB11FZoLVTvD5UDZ8N0UxgqbYgqPZc22eoQxjlNzBpaxv9pfFMG6uN/5cbftn85Jw2ZO7tzwN4luYzk1WOU4JF0t61pTo5mLkCQs3Ct1ekzQqHvqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772799871; c=relaxed/simple;
	bh=ZpVt9zW1oxQ/GlDT08tM19qlumaeZjiMRW7zdrIbVqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NactVC4OWLB3d7VyKn3FyN9Nlv2xrLBcHkXNPzlWYshG2cJ/JMP40wd4v+1kFZ7KbYinzZbTgfstNBhUzjaabw5yQM09+E4RhlHLAD3vmNb2VoV/FO+g02gEskhALSTfyhf0VJBSrvSVd9l9DKVH+LtspVbXw+HE/BU/+iBAees=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NBK5Kb3H; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NBK5Kb3H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772799871; x=1804335871;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZpVt9zW1oxQ/GlDT08tM19qlumaeZjiMRW7zdrIbVqo=;
  b=NBK5Kb3HSB0Q6U3YmvMb8ftRvXaTijtJDas0+3mqk02x4VlJDElTOit7
   ENOU1zAFcAkWaU3E0TXtQkGmzNoN0biHSojm5PNRJqYX2bwvov6mUbRrC
   T3OjB2rVsFjkPm/7T7LQ3XIlL7MvHkyUY34SWvCqlY3gVYG+cj8UgevL0
   k2pkJRdGLIzag6KfzoK/armJLMI1QYpDJ4/5dF1lkgwowfXrLhEN0anG6
   Ecbo6wigD59ABLsdCIKjXJhcMWiKgheoXn9lL0shnEVea+U2192+nxxOU
   CeOdxAoQ6TpnJO0ridGShh5WUVo/PnOxbTzaSRdwDxGRcES1tufTYVS3a
   Q==;
X-CSE-ConnectionGUID: A4XRu2waTF2MGcgeW79PDw==
X-CSE-MsgGUID: ZusICuRtRVuTBzgqnFj1xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="73808472"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="73808472"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 04:24:30 -0800
X-CSE-ConnectionGUID: iZZc6MApRcezERWtfrwlPw==
X-CSE-MsgGUID: kP64BKnbReOZZyIyuVe9Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="216136079"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.1])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 04:24:27 -0800
Date: Fri, 6 Mar 2026 14:24:25 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: frequency: ad9523: use dev_err_probe
Message-ID: <aarHeQbq-Ml-ZjqR@ashevche-desk.local>
References: <20260306102504.42395-1-antoniu.miclaus@analog.com>
 <20260306102504.42395-5-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306102504.42395-5-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Mar 06, 2026 at 12:24:48PM +0200, Antoniu Miclaus wrote:
> Use dev_err_probe() instead of dev_err() in the probe path to ensure
> proper handling of deferred probing and to simplify error handling.

...

> -	if (!pdata) {
> -		dev_err(dev, "no platform data?\n");
> -		return -EINVAL;
> -	}
> +	if (!pdata)
> +		return dev_err_probe(dev, -EINVAL, "no platform data?\n");

Platform data?! Maybe we can get rid of it entirely?

-- 
With Best Regards,
Andy Shevchenko


