Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3160186334;
	Fri, 27 Feb 2026 07:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772175896; cv=none; b=e2M+BmHlG600JLlR2cdbt+nQiBghzZLT5xtUvX+q5J1cLUTEo/0cwRWetX4GK5LSp3NA5A2FixUUXPLF+rDhwcMoM7cJGoFNkhBWXxGsX/cSJ36Cf34ALJVdMT7qkgd41YjJY6i6IxD0lL17icTipBFuRNGbrbkJYr3radUC+is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772175896; c=relaxed/simple;
	bh=rQR3CUnNIl+xB5W9Mi5sFblr+B9905nWk0jpPEOpr3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XjxUeJhoF0PRk8ROjEke5P/FurHUJat7coa/2WDWAPT1IRlbxjTCR3EpNLzFnzB9uwPWGkAFxnTk925YHQGFECNSw4IV+hXFGxZZL7+UzHWLSYu9YZAaDE+2rZs8ZIu4Y6UbjDv3JZWb75s7nUv7cAZqi5sjGsFitMUeq1ueLas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DEIPrZKO; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DEIPrZKO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772175895; x=1803711895;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rQR3CUnNIl+xB5W9Mi5sFblr+B9905nWk0jpPEOpr3g=;
  b=DEIPrZKO1e+QJDX0kUc1+lVsSuUxscLRgQE1fjHRCobPTdZLNNhuqd7e
   qa6o9KQVVwbDpmEoiIvbiskQ0BsigxTeNapCh7tgsrW4IQlyl+8Ijsl8I
   tD2P+ek8Pzn3IJU5BUC55EDGncspksU/MGEF/8yVv117/oOsKmZRlHgc0
   yt4qGMk3r5QE8kLEpSfoYRMKTZS9rhEsXE7fCEbE93QF7yvd/vIbBImfA
   vTohrsOa6wSV7zoZCG79P33StV0zJu0vrqQX2R6sao39KFrXMazWvDcvZ
   p+3aEQvbpha3gOQp+JU2PZI/ZUQB3WMjUaoK+t4VMLrTMuQfNShRQQEMb
   A==;
X-CSE-ConnectionGUID: k9cg8alPQYu4M4AUfgDH5w==
X-CSE-MsgGUID: Y8QmpvhEQ4KgY4BccyRO+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="75854988"
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="75854988"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 23:04:54 -0800
X-CSE-ConnectionGUID: WgLhFKN8RTmK/g52AVVkmg==
X-CSE-MsgGUID: ax2WnOQyQRuD4qeaR0cIxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="216046058"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.65])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 23:04:51 -0800
Date: Fri, 27 Feb 2026 09:04:49 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: filter: admv8818: Add missing error code
Message-ID: <aaFCEbGbcT-DpuyS@smile.fi.intel.com>
References: <20260227061424.1135505-1-ethantidmore06@gmail.com>
 <20260227061424.1135505-2-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227061424.1135505-2-ethantidmore06@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 27, 2026 at 12:14:22AM -0600, Ethan Tidmore wrote:
> If the macro FIELD_GET() returns an error code the function returns
> with 0 because ret was just confirmed to be 0 a few lines above.
> 
> Add error code.
> 
> Detected by Smatch:
> drivers/iio/filter/admv8818.c:335 __admv8818_read_hpf_freq() warn:
> missing error code? 'ret'
> 
> drivers/iio/filter/admv8818.c:376 __admv8818_read_lpf_freq()
> warn: missing error code? 'ret'

...

> @@ -332,7 +332,7 @@ static int __admv8818_read_hpf_freq(struct admv8818_state *st, u64 *hpf_freq)
>  	hpf_band = FIELD_GET(ADMV8818_SW_IN_WR0_MSK, data);
>  	if (!hpf_band || hpf_band > 4) {
>  		*hpf_freq = 0;
> -		return ret;
> +		return -EINVAL;

Looking at the nature of the check I would rather change the condition
to use in_range() and respectively return -ERANGE.

>  	}

...

>  	lpf_band = FIELD_GET(ADMV8818_SW_OUT_WR0_MSK, data);
>  	if (!lpf_band || lpf_band > 4) {
>  		*lpf_freq = 0;
> -		return ret;
> +		return -EINVAL;
>  	}

Ditto.

-- 
With Best Regards,
Andy Shevchenko


