Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96B83CB2FC
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 20:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778617522; cv=none; b=dNtyDZ2q4unlau0aWNV5X+r6/O7HlaExJEUr3iguKOhw78pHNFur3EzgbEiLVNidd1WPT9mM7aIYJOVH/pPgf9WKbUxmZ0e+yTKp8DG7wPXV/Qv4PC9V2Pc+r6DLq/X91y/snpxroOp+SUKHG20Q4OmtxMjgXioHjhchPMNwDS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778617522; c=relaxed/simple;
	bh=+teBvFmRmW15MfYGKu7DS6tSNxtew7IMu0evuCie648=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dh9UNSPoKAA+MjKVn12JidFZSPBoBYgxgzvBp0k9NZld1VcsliT6PEhEtWVsk8tz3WSojipGakoD5W+OqulqmnwneHGGRklxFaqrHYad0w9glp0rUH/Cq2lZLNK1XsISnZWp+MzyXETayKidM0RPXCQpQU8SvE0CHkpgnczXJtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ggatIrpz; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ggatIrpz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778617521; x=1810153521;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+teBvFmRmW15MfYGKu7DS6tSNxtew7IMu0evuCie648=;
  b=ggatIrpzNagAE1syJMQQZ2ICNdUt9i2EWiUcvbsKGF6HLP+MGyhPgPi6
   CR8y6EBlcw+Y5rKE1ixYoI547dAU/CRSufa8/kZ9IYA1nTr8RzZ6OwImG
   ouRcI8h42259LtvX93FJqZzCIS05sQztxHMCzLZIq6c6UAEu7flnOkwDF
   v7Ite/8kjga2D82Wf/9lVnuEWIcIGZ5RTh6hNb29zC3DyCAzofMI+Sf8F
   L7sPt3PdgtG5LgNO1s43hYgmqgVTs3bbhwC5DgDAN437xuSt6kyIeW6wq
   kpSnRgOAQ+9u3mOjERoTZOUcM8THfcQ72RMyFMya+hHr+wJOyqnU5cWZt
   w==;
X-CSE-ConnectionGUID: ZIIBYqEbR1et/dsP+DnXYA==
X-CSE-MsgGUID: SsTlCHfaQhmS/gEo8bhSAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="82106013"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="82106013"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 13:25:19 -0700
X-CSE-ConnectionGUID: 2FVEbLgHQUqmzvd6aohqwA==
X-CSE-MsgGUID: fEH6oXGnS3uQBseeC51HmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="268213127"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.244])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 13:25:17 -0700
Date: Tue, 12 May 2026 23:25:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Raffael Raiel Trindade <raffaelraiel@usp.br>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, Kim Carvalho <kim.ca@usp.br>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v5] iio: light: vcnl4000: use lock guard()
Message-ID: <agOMqrKEb02MV358@ashevche-desk.local>
References: <20260512184728.298680-1-raffaelraiel@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512184728.298680-1-raffaelraiel@usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 12, 2026 at 03:46:43PM -0300, Raffael Raiel Trindade wrote:

> Use guard() and scoped_guard() for handling mutex lock instead of manually
> locking and unlocking. Remove gotos in error handling logic. This prevents
> forgotten locks on early exits.

...

>  	ret = vcnl4000_read_data(data, data_reg, val);
>  	if (ret < 0)

May this return positive values? If not,

	return ..._read_data(...);

will do the job.

> -		goto fail;
> -
> -	mutex_unlock(&data->vcnl4000_lock);
> +		return ret;
>  
>  	return 0;
> -
> -fail:
> -	mutex_unlock(&data->vcnl4000_lock);
> -	return ret;


-- 
With Best Regards,
Andy Shevchenko


