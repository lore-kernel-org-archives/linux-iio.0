Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D49529B79B;
	Tue, 28 Apr 2026 08:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777364674; cv=none; b=ejJtKZ2IsAeDkDVRvSOYZtRoFQMdcvOCAbjl6AKm/o4i7CfAQhoqfzoJt50mA30bUfQU5fE4b3g+YtiJ3R7Jn27XXOH6VI2YKofum6Ug0FJacon6JrcDoTJlbs9ZToj2EogkzKKThrz/C4NQbplX7roRLvQ8gLXvK9b3HkCroXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777364674; c=relaxed/simple;
	bh=oa+TaqDYFkkkEhNGT22HZuSkkLpYjiJxNXruzvmBnH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Znr+fGYJ7eV1gd9r3TkRvp39ygFybxETDfgHATzkWZYNwjCIsFe50j9KYmaYrSDYYqlSaKDyopxvAnDeP7+I8paXRhvRfXgNE3r5URMgTpyjoqgCuw8CAHqmJH2FqrSOxUQ+O9/YlxtgKhS/4KTHgFEP9YGAgjRJ5TVEx+pgLGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TsrKb2m+; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TsrKb2m+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777364672; x=1808900672;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oa+TaqDYFkkkEhNGT22HZuSkkLpYjiJxNXruzvmBnH8=;
  b=TsrKb2m+mfyXgDb/H4t+BYky7peVrEdopUes3JFQhv+R9xhwFyTeb2+r
   IWVN4HLppgQLKW8kMozOp2Ge5nsubBVMQs0THqLzqRnQk/+xrKNtR4iVb
   TAebl5cfyVS5bRV7xmuOp+e4J4meJVMUbhcPblg7giE1N2zG3s01VUnKa
   hfAXkt++UnrWQZfsp6H2pJqLZ/N8m78XeUNATS4c5w0LE1W7QcQw2ZwpN
   g3Xeqh3YmiE5H/RHw+gdlMNQAuSkR4N5N67V6dv2Yq+5Ut6+NqHUqQEkE
   6hEl6KNN7rjffgaDx4X8T0uW5IHxRiSmWAQwM0IJusaaSXIppOr44RjsV
   g==;
X-CSE-ConnectionGUID: wpAXMGBUQwe1MiyIRQ/khg==
X-CSE-MsgGUID: 1iaABD4BSqqQSN5RnVdhFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="89646752"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="89646752"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:24:31 -0700
X-CSE-ConnectionGUID: lDSNoagNROScsVoT7RWcyA==
X-CSE-MsgGUID: MUsynVSCRoecE8BdB7tR5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="264279359"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.213])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 01:24:29 -0700
Date: Tue, 28 Apr 2026 11:24:26 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: songqiang1304521@gmail.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: magnetometer: rm3100: Use scoped_guard() in
 rm3100_get_samp_freq()
Message-ID: <afBuugpBK_OqRKHz@ashevche-desk.local>
References: <20260428024339.45109-1-m32285159@gmail.com>
 <20260428024339.45109-3-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428024339.45109-3-m32285159@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 27, 2026 at 09:43:37PM -0500, Maxwell Doose wrote:
> Replace mutex_lock() and mutex_unlock() calls in rm3100_get_samp_freq()
> with the more modern scoped_guard(). This will help modernize the
> driver and bring it up-to-date with modern available macros/functions.

...

> -	mutex_lock(&data->lock);
> -	ret = regmap_read(data->regmap, RM3100_REG_TMRC, &tmp);
> -	mutex_unlock(&data->lock);
> +	scoped_guard(mutex, &data->lock) {
> +		ret = regmap_read(data->regmap, RM3100_REG_TMRC, &tmp);
> +	}

{} are mot used for the single statement, but...

>  	if (ret < 0)
>  		return ret;

...move this inside the body instead.

-- 
With Best Regards,
Andy Shevchenko


