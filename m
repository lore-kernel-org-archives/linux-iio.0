Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047FC3AA9F8;
	Tue,  2 Jun 2026 07:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780384483; cv=none; b=Gm4dUgEvt/9fVRtwOJ+Uqb6b80J7fXqc6Zv1xl2E5yS8O7KZwWPzlHA7/GuS92oKjD2Tf6rXS4eyeZFF7qmXajql8FsYXEiznjHShASQCkSNtrs5cARssTOi8Dsd3sueMvEZr7PZhgEecCdadhjSRvTD/hDpiznaMZ4AA1+AlnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780384483; c=relaxed/simple;
	bh=/O4EHfUTId8Kc0lzTp+jTcH6Nz1Ul6n+I4iwV4ldZfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJSMihqExEE1r+2emydMcKqhEks0ru5Tbfe66VsKUsI0uYqdBc3w7mHQjM0ROgFL9RxEPTWRWFELVvI9N/LMK3YNrUz1rx3nJW3j0ih87r8ZFuTv8EdMHpr60Z7H4/N2R2f1VHL1YJ/vRlKDNnAk8o/kLavrdSn9vzu9jG2FfKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hsaziog+; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hsaziog+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780384480; x=1811920480;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/O4EHfUTId8Kc0lzTp+jTcH6Nz1Ul6n+I4iwV4ldZfI=;
  b=Hsaziog+B4n+3zFlWd8j058VrFclsE7W5y065w2o/dEtAWP3zCouSbqT
   nCowLOAUgH/OMmuCllZtoMneCAlxdtsz1b6qSzOsJ4YpIB1tFMGBPMt2m
   RzDbXXvJdWf06QZSGcIBD7IJPN3dJqKwrUbixlzPz2c6jbCMgxbpgUCmy
   RPtKdc2xDPoy/60RuD7NmK7MlCmR+tVhX0+yj9XFxLKvb5HYhekdylMcE
   W29J/DbflegrjNR7DDpW2lqux1Q4OA14XJ/G4azooY+N1Tu+10tkKl1le
   TLIAi+zsh83XyLO3L4E0z48gViU4y4WX/mnxcID00oiIpR3hK/uDGLcqK
   Q==;
X-CSE-ConnectionGUID: GbB8hjTdQHC4Z4/R+anCLw==
X-CSE-MsgGUID: r8m/SiyjTpaG7IwwzCzq3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="80307965"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="80307965"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 00:14:39 -0700
X-CSE-ConnectionGUID: DVqkrYshRjeBhkXa81bC6Q==
X-CSE-MsgGUID: U29l8T7oRl6oZ+aDYuVgvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="274089500"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.229])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 00:14:37 -0700
Date: Tue, 2 Jun 2026 10:14:34 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: jic23@kernel.org, Tomasz Duszynski <tduszyns@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] iio: chemical: sps30: Replace manual locking with
 RAII locking
Message-ID: <ah6C2vFPiflM7Qvg@ashevche-desk.local>
References: <20260523181536.5254-2-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523181536.5254-2-m32285159@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, May 23, 2026 at 01:15:36PM -0500, Maxwell Doose wrote:
> Replace manual mutex_lock() and mutex_unlock() calls with the much newer
> guard(mutex)() and scoped_guard() macros to enable RAII patterns,
> modernize the driver, and to increase readability.
> 
> Move mutex locking into sps30_do_meas() and tune it up to use guard()(),
> as every caller takes the lock anyways.

...

> -	mutex_lock(&state->lock);
> +	guard(mutex)(&state->lock);
> +
>  	ret = state->ops->write_cleaning_period(state, cpu_to_be32(val));
> -	if (ret) {
> -		mutex_unlock(&state->lock);
> +	if (ret)
>  		return ret;
> -	}
>  
>  	msleep(20);

Same question as per v4 (yes, I see that it was in the original code).

-- 
With Best Regards,
Andy Shevchenko


