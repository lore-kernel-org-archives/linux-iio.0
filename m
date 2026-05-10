Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7B22F2607;
	Sun, 10 May 2026 13:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778418074; cv=none; b=V4OGRkDNFBjx5RcYuKKWoMbsqXTTxJGf3JHUdthFifCnORo1YA6xl3ECndKIx4gEfY38f+eNSlxjlNzhYZNphzCRCwqgqY3zl19vxvRM1XVBaNo0PqJBH7oejaFiMdsAOdCoQQLU1VEsNfcoZB/paAgdbvptaIm2KTF59WXA6X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778418074; c=relaxed/simple;
	bh=ohfNp77KjdgCA7mQ1Fkvkn62PIgd11xb+5KtSKUUIBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XEaXlQ7zaEEd//3zMOCtFIvBL0SMfY2RfxbrxyaJQUqTt0LcXkzMH9Mk6oNybjPOSeEAyCIoxTcY0TkPdTEz0FBN3fXp2RwaHJqmkxsI20WTyiLyrRD8GE+45wi6OV2gEe3OgS0V48lZNoLGUleZ8ddhdSaq5R/Rse76e0xkwtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WYYXe5VA; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WYYXe5VA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778418072; x=1809954072;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ohfNp77KjdgCA7mQ1Fkvkn62PIgd11xb+5KtSKUUIBs=;
  b=WYYXe5VA9lOI6L4/c5NZt9webTAMa50eo6ycISrh1miIB6aXXmbbfeTM
   L42FiyvUQ+8EzKedKt1qvctvd1U3ioIN8IHI5XFqMOrBmpLoMfSdduKNO
   xolWOAzMK4l7HVenUla39amdXuzjWAk4fBed9UsSlMHQpWnCRrMMZdcGF
   BgQB6+dR/KvBkJLM9As34M/0cV+NtLLSbNO+Lwjysmgto4Txq8sJncyty
   3D1pUoQH+F7mljyDFTrepCiZy1am7hyzYH+Ye3iLWpVbxvBbTY1TaUwmx
   U4RPk+AtHmsLYFWZqAeJd/o6lKGJB+jiJtLkawLttm0l0MsRTVru3F2Mw
   Q==;
X-CSE-ConnectionGUID: jWJxq5/CSKezo2i5UxrHmQ==
X-CSE-MsgGUID: XELJjA3dThuFf0egtxpV9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="81892127"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="81892127"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 06:01:11 -0700
X-CSE-ConnectionGUID: csFtdEpLSzu5P/CIdiIwhA==
X-CSE-MsgGUID: DuiKoNT1QQKRlwke33gRuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="237314764"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.171])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 06:01:09 -0700
Date: Sun, 10 May 2026 16:01:07 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, andy@kernel.org,
	nuno.sa@analog.com, mike.looijmans@topic.nl,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: adc: ti-ads1298: Fix incorrect timeout comment
Message-ID: <agCBk1KgtEcsBpfp@ashevche-desk.local>
References: <20260509071910.12345-1-shofiqtest@gmail.com>
 <20260510123801.4066-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510123801.4066-1-shofiqtest@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 10, 2026 at 03:38:01PM +0300, Md Shofiqul Islam wrote:
> At the lowest supported data rate of 250Hz, one conversion period is
> 4ms, not 40ms. The 50ms timeout is deliberately conservative to allow
> for kernel scheduling latency, which can be significant under load or
> on slow machines.
> 
> Fix the comment to state the correct conversion time, use "lowest sample
> rate" for clarity, and explain that the extra margin exists to absorb
> scheduling latency so that no one is tempted to shrink the timeout to
> match the conversion period.
> 
> Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
> ---

Here should be a changelog. What's different to v2 to v1?

> -	/* Cannot take longer than 40ms (250Hz) */
> +	/*
> +	 * One conversion takes at most 4ms at the lowest sample rate (250Hz).
> +	 * Use 50ms to allow for kernel scheduling latency.
> +	 */
>  	ret = wait_for_completion_timeout(&priv->completion, msecs_to_jiffies(50));
>  	if (!ret)
>  		return -ETIMEDOUT;

It's also better to drop a ret assignment here as it's counter intuitive.

	if (!wait_for_completion_timeout(&priv->completion, msecs_to_jiffies(50)))
		return -ETIMEDOUT;

(This might require more changes related to this ret drop.)

-- 
With Best Regards,
Andy Shevchenko


