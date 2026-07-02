Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503972C3251;
	Thu,  2 Jul 2026 09:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985501; cv=none; b=qaqoPPZUWb6bT+ECNppQrIlhZEvBHn8pQA8zFJBXfg58M/JcvtFNqsjPUcE7hPeJTRtQZj7AEk0vS+LsStOUWqtkTH9rOat3n+dtQFMpiGTyq64fhtgpD4WFXz+AXIYqxk5NvYxAUlKnFhEDjOCsdFgddpc60ftSNPiphqPviMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985501; c=relaxed/simple;
	bh=njX6AqcZxdx+fpRpgPhZLLEkCXUSm6mASPzKGycuge0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MP8ite7UaBGwa+sVPX/AToWTiE2Ow9cHpvNdEJYWIPOd9e2rlj7NKq33hLC6WXcxwQxMD+aTztRIZS1okzHqTVa9WG1VJ2f27+/8GIPIz2dbyw/xbGe3K8eOz6z2KWpOmfqPGoCUebkUrCSixcqa2tp39jIvXTmDl2JEnaDwRTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BEt5YlMC; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BEt5YlMC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782985500; x=1814521500;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=njX6AqcZxdx+fpRpgPhZLLEkCXUSm6mASPzKGycuge0=;
  b=BEt5YlMCexLewo1Bit04XqtY8Dw/DBaaKmqD3s4VnIuAN061cV18V4FU
   0w5iTGC8HA91imrGTIm0IJYKPPiOndTup7v4n8SRSetliTGjMf6pWiiOl
   /9OCcdYAdRMoRP+xxKsd1TSB+Zm/iLjFYa6MO3q3o7ainEDJtWhnQtac8
   RT6Tev4xDmuN/N+SAYW+E1Xauk9+Bsw+sgt1SRO/xvtVd20m23WZjzBKh
   F2gkEvxRzbdd6v7AXeoJLV9wCla0jwkx3DdSyveSB117Dlw3J3NRweAtf
   NkJyV41yGhTBdeReNuRy3EjXnzrzrw7u4iIxCy9Nt8HvQFHZNqAtlmItF
   g==;
X-CSE-ConnectionGUID: xGr2AZLLTouaQn9kMlM8Kw==
X-CSE-MsgGUID: yPqO26ZKSv+QBP9MPP82Lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="94389867"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="94389867"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 02:44:59 -0700
X-CSE-ConnectionGUID: 4T265IUiRj6kFAXvvMPgrg==
X-CSE-MsgGUID: URwbqx4MQ7iWzUFg5d38+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="246462011"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.213])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2026 02:44:56 -0700
Date: Thu, 2 Jul 2026 12:44:54 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Vidhu Sarwal <vidhu.linux@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] iio: light: al3010: fix incorrect scale for the highest
 gain range
Message-ID: <akYzFtxKhq5U2kFY@ashevche-desk.local>
References: <20260702052913.114130-1-vidhu.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702052913.114130-1-vidhu.linux@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 02, 2026 at 10:59:13AM +0530, Vidhu Sarwal wrote:
> al3010_scales[] encodes the highest gain range as {0, 1187200}.
> For IIO_VAL_INT_PLUS_MICRO, the fractional part must be less than
> 1000000, so the scale 1.1872 should instead be represented as
> {1, 187200}.
> 
> Since write_raw() compares the value from userspace against this
> table, writing  1.1872 scale never matches the malformed
> entry and returns -EINVAL. As a result, the highest gain range cannot
> be selected. Reading the scale in that state also reports the malformed
> value.   

Trailing spaces in the last line of the above paragraph.

> 
> Fixes: c36b5195ab70 ("iio: light: add Dyna-Image AL3010 driver")
> Signed-off-by: Vidhu Sarwal <vidhu.linux@gmail.com>

...

>  static const int al3010_scales[][2] = {
> -	{0, 1187200}, {0, 296800}, {0, 74200}, {0, 18600}
> +	{1, 187200}, {0, 296800}, {0, 74200}, {0, 18600}

While at it, add a trailing comma.

>  };

Otherwise LGTM, thanks.

-- 
With Best Regards,
Andy Shevchenko


