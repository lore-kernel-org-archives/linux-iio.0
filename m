Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9610133AD88
	for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 09:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773307996; cv=none; b=Io6SRLMtknbh4Adjgiv0wqpVpnoEMypOCBZR8RUW7DkjkclXSEWEJTQlKnpVHlAkV09Z0TxrqFzyL7pcbVCoqwheIL0cMraN6GZJDZdS2DNZ/bs2griD6yEJLPkEWgy05k3XVS+6mC91hKEJW0SWHZZoVnu5H/3Sgj4plM0doK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773307996; c=relaxed/simple;
	bh=cJHDQqk+snEsMubbCnMV9xi3nDrrJOnh/ELdJ8DPTgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ou01gtbj9S79XwmXdneDVjdrNBU0QCjdWlnJlHoVpk0QbIu32IL1hSbaaBF5KSZckx1oSl09gpZsjUFhuv4ocd8pt0iB6CjnlQHMkOgNDkmEYah+V5y1gKJRJ8Vckt0fSEcEXO5oGhwOxvB81rXh0q2T5MHI5wwQskzwk8dBhhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kv1MwsEt; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kv1MwsEt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773307996; x=1804843996;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cJHDQqk+snEsMubbCnMV9xi3nDrrJOnh/ELdJ8DPTgk=;
  b=Kv1MwsEtmDwHJiipVgYE/U//4/u6WgCf5IegQJ6EAFuBQerX9Nh8l3pL
   G+1tSwfJ5tIG0HOQ4hageH/+Y4RIVRNHXH+nPDSV9+NRLsYvTV8l4oRma
   2et+9PmW1Tt6Cu2Ee92eN2oSzXuvxQdXzZkBSU/f/e9ObsueHlRjkrjXY
   358fWmgWNML7slPWOSSd3OQik9c1vM70Grjmw+jSl1bQxf9CmgZ++Xrus
   VhSaw+PfS0/RKKRaQFd2zywqPwNmwBnac7elRn25aydMEFLe3hzGRWTiT
   izWXdrbhYDxp8SfSr+mTEA2CebAlmKPg2n4SXeLFn8lhE+dfNrOPcjVpO
   Q==;
X-CSE-ConnectionGUID: CoZsP2lFRl+RwSvlyPNUAA==
X-CSE-MsgGUID: gpdCRYlyRA+GIK5yMthQBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="85869193"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="85869193"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 02:33:16 -0700
X-CSE-ConnectionGUID: TYhPLtTOSIGpDaCoKpgV5w==
X-CSE-MsgGUID: 8qOK77U7SI+eFJe+5u+K8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="220027080"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 02:33:13 -0700
Date: Thu, 12 Mar 2026 11:33:10 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: adc: ad_sigma_delta: Format block comments
Message-ID: <abKIVj9jCqBxgDeM@ashevche-desk.local>
References: <20260312080752.48091-3-giorgitchankvetadze1997@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312080752.48091-3-giorgitchankvetadze1997@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 12, 2026 at 12:07:51PM +0400, Giorgi Tchankvetadze wrote:
> Move the trailing "*/" of multi-line block comments to a separate
> line to comply with the kernel comment style.
> 
> This resolves checkpatch warnings:
> 
>   WARNING: Block comments use a trailing */ on a separate line
> 
> No functional change.

...

>  	/* Some variants use the lower two bits of the communications register
> -	 * to select the channel */
> +	 * to select the channel
> +	 */

/*
 * Please, make sure the proper style for multi-line
 * comments is in use. You may take this example for
 * consideration.
 */

-- 
With Best Regards,
Andy Shevchenko


