Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4703F0AAF;
	Sun,  4 Oct 2026 08:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791103386; cv=none; b=Ye1VlTrouUKZZJXcqVb3I33RqBHP2uX0UX5UC6X22ZwxVTz8rGP2PnjIM+x5UBdnEpIGlsQMlFhlrhM2QSvM9SjX+Bsnw7PXkI/l06gwWBI6xudgvIi4X1O7piaE76bWmmtBQWYjUxlyV42YDsnY4V2gY0hAXBJ5O49Ees0zb/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791103386; c=relaxed/simple;
	bh=2vGAu/0YxMMlosDI7FUBatoN/q3StUPF3WWTMNiH7hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sGtZHdmrfp2vq9yP7EfCgr1EEMgMlH97AIJm+o3zTZS9Nj75bBjuAU37gyv54CDnVW4tgplY6JY7DEpjUKtC6J+37AfgrlJYG554cmyUzA6C3TLFG2PtL8mLk+3RoMQld9zmhwxlYbe2o5JpNfj8gB4kpjSs/4rKSwU5rRoHXqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iroGfBfA; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iroGfBfA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791103382; x=1822639382;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2vGAu/0YxMMlosDI7FUBatoN/q3StUPF3WWTMNiH7hk=;
  b=iroGfBfAcQ0v5B0AUrDKucjJVqXVplzixYLIUfrn1nhkBt69l7Q2pmbi
   snT+rPeeqerfY2Z6Z73iwcw2z0jNEnLWdsF6/447/lVAmqljg30a5/0PZ
   77hmbBOO9dTqynsemTh64Ps0qT4Y+QwkY4M55sdP1Msx2iXdpY6bUB+Q5
   B8K5tFm3MyCjGajKVUQ/o5LPZ7QUKU9JdRBwZEWf2uxzPtoxGB4pyyb1U
   YRaC07Yj+AV5xAZ+iD04dVqryDYUwSFM3pbg72zQHxj2l1dEZ3h1UNrDF
   RFS3xFb97A2Rz2wAFL7UuYf2N9BDf1bEoxBmf8UC3bG0UXkp4pX5GfcqZ
   w==;
X-CSE-ConnectionGUID: DryS0mB4RXyk3IrZlA3/Jw==
X-CSE-MsgGUID: dZ1qAzKZRNqWvJAf8/vYYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11924"; a="102320740"
X-IronPort-AV: E=Sophos;i="6.27,139,1787036400"; 
   d="scan'208";a="102320740"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2026 01:43:01 -0700
X-CSE-ConnectionGUID: GldCbnOhRHGw1VeubeHqHw==
X-CSE-MsgGUID: dm6UexKKRbyxv78kTMUKyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,139,1787036400"; 
   d="scan'208";a="276095244"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2026 01:42:58 -0700
Date: Sun, 4 Oct 2026 11:42:56 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: qcom-spmi-adc5-gen3: fix lock annotations on
 mutex helpers
Message-ID: <asIRkK-uUz4FKQBN@ashevche-desk.local>
References: <20261003214516.128573-1-zoone.rupert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261003214516.128573-1-zoone.rupert@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Oct 04, 2026 at 12:45:16AM +0300, Rupesh Majhi wrote:
> The __acquires() and __releases() on adc5_gen3_mutex_lock() and
> adc5_gen3_mutex_unlock() name adc, a local declared in the body. With
> context analysis enabled for this file, the build fails:
> 
>   error: use of undeclared identifier 'adc'
> 
> The lock and unlock are split across these two helpers for the ADC_TM
> driver, so mark them __context_unsafe() instead.

Doesn't sound right to me. The __acquires() and __releases() IIRC are sparse
annotations. If clang has something special, it needs to be addressed in
the compiler-clang.h, no?

-- 
With Best Regards,
Andy Shevchenko


