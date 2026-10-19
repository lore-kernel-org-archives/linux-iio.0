Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E014A64D5;
	Mon, 19 Oct 2026 10:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792404073; cv=none; b=okMb+LR6J91YsX42UplCGGJlmjO8CXWFw5XUBIbZdRV6oNgY+arK2Io4mwNrVsPMyuG3YKONAM5HEY0soUjkvS0NmMzY0Hc5C6f/cRe9oRHHrvf9Gfrjn+WpVkHL8v44fzPF5boni4CrlP8Gerl34SXGf0qZ4Q9i5b8CbxhhteM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792404073; c=relaxed/simple;
	bh=v9zWVpP/Pj6t7su6xUkNFwPtMw0gEO+RRveJOnB/Tpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlXADLKcoTiOIuH4mzv7j6UfD3uh0BAZUYvUCzJnXGFesCCPrjy419uN0hmqNzWIF/e6eYanwsq1MfzS6+RVmg1pOY37+xG94pUhx1p8uKuivTLuWuzBN4x4qM9yKivbQARnSzA6JyuS/a2X6sQsSjJjP8x56qFpbOYAKxXoP6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dQS+APxY; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dQS+APxY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792404073; x=1823940073;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v9zWVpP/Pj6t7su6xUkNFwPtMw0gEO+RRveJOnB/Tpo=;
  b=dQS+APxYerIm8pLwcrMmhMF3chu2efssNes58P7/XpM5Y+RPnxNJ77bb
   esHth1gciC3WjrKMColeTGTkFV016cfm573BkNxfYa/k1Y6iCJ2xtujr0
   5Wi7GGvFh41B8a7VbQ92WlMdAgPN24EuF7fCYuhsh9hjBrf3+xta0s7g8
   Bk+j/UZMReGrZLj2lvCTc+D/V6Ih02yR+bOg1a/eyBiRPgU7kPMYv4eIi
   r+a18fHLT1x71eqXN1x8CHQoGjKjA67RjBZtvseS77WzfzAdYlzwZIpPE
   uZZ6qVnouobsbGZI93jubiSjcTzODT4lgv4qzQHPgkRug7cRwK0MM8oM2
   A==;
X-CSE-ConnectionGUID: LSKZD1QWSMuSHN66FlOl9A==
X-CSE-MsgGUID: q+5tRHTVQeuYgf5FEo604A==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="976270"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="976270"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 03:01:11 -0700
X-CSE-ConnectionGUID: Lsv40espTV6RYB+/qJN6jw==
X-CSE-MsgGUID: tV1kMOEPS9uk7TP+4wDmRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2857067"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 03:01:08 -0700
Date: Mon, 19 Oct 2026 13:01:06 +0300
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
Message-ID: <atXqYlmzlDaLJ214@ashevche-desk.local>
References: <20261018213812.56858-1-zoone.rupert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018213812.56858-1-zoone.rupert@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 19, 2026 at 12:38:12AM +0300, Rupesh Majhi wrote:
> On Sun, Oct 04, 2026 at 11:42:56AM +0300, Andy Shevchenko wrote:
> > On Sun, Oct 04, 2026 at 12:45:16AM +0300, Rupesh Majhi wrote:
> > > The __acquires() and __releases() on adc5_gen3_mutex_lock() and
> > > adc5_gen3_mutex_unlock() name adc, a local declared in the body. With
> > > context analysis enabled for this file, the build fails:
> > >
> > >   error: use of undeclared identifier 'adc'
> > >
> > > The lock and unlock are split across these two helpers for the ADC_TM
> > > driver, so mark them __context_unsafe() instead.
> >
> > Doesn't sound right to me. The __acquires() and __releases() IIRC are sparse
> > annotations. If clang has something special, it needs to be addressed in
> > the compiler-clang.h, no?
> 
> Sparse support for them went away in v7.0 with 5b63d0ae94cc
> ("compiler-context-analysis: Remove Sparse support"). They are now
> defined in compiler-context-analysis.h and expand to clang's
> acquire_capability() and release_capability(), or to nothing.
> 
> The argument is parsed at the declaration, where only dev is in scope,
> so no header change can make adc visible there.

You need to summarise that in the commit message.

-- 
With Best Regards,
Andy Shevchenko


