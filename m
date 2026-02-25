Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1E9286D53;
	Wed, 25 Feb 2026 15:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772035036; cv=none; b=TWmNX70c2X5aY3o+iAOZvAtMGtDHxT5uSDVw/wN2lzcITPoSWRySuD/8k4LI7kwrJoMK772mCnQLnbWkJWfSZ3BmEb9vDzzgvwpgjATIBPLq59hQiaKyHqEv4OxYLm8lgPq2gv7HmBOCMQkB10Bvx/k7kQNosc0BiBTCZiyqAn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772035036; c=relaxed/simple;
	bh=diLnaIPP8Xv/kz9HFGKxFsF74FfLk+Rto07hzM6nSsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oy1N8t41UjtBtA/kSQwPWYLK7Fb12SnRDLmzB4ge16t+Q1mcvB90KbscxOyZOYJU8qezDqLD6Xd6qFPL5molMUrcVAZUSV5tDmmkKEul4bk/kkreuVGiZbUnFspC1vUr5ct8FXQMCwp3+pz3Tt/c+LSacXiA8/E9fZxxSw0lgCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZQ3P3OQb; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZQ3P3OQb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772035035; x=1803571035;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=diLnaIPP8Xv/kz9HFGKxFsF74FfLk+Rto07hzM6nSsI=;
  b=ZQ3P3OQbFphjspS2y2ZSJ6mmH/fXVp2TbICsLZiYAmwmY+mpp1vc7qs7
   4yXB7rIAKmt/zkQIyqXg/haGSMnKXpOaA/o0RuWoJQwlHBZT9W6LIGb8/
   SvUKTDl7yIYWh7r3OJsSZ9kxn88FqII7iFHcxYNhwqbA5ijIi4HPPCgWR
   a4vQFajtTwKNuLbSmHdMHjIT2TBXtI5xf93+DbKLPWr9Jktd5A56/BBoA
   Blvj8O5tlZS51cUfTlxUqcoDp2BrV3ujvQYcgocoWce1xWITBePWmh03b
   ZQ1bnhagu/TCRrb98OLXbfGdgY3pfgJTu48SALeWGOjNE0Xwc7iyqDL0V
   w==;
X-CSE-ConnectionGUID: pFraWKqXQ0yZ5nl7XvFtEg==
X-CSE-MsgGUID: oaaBa6cYT6my7N7sMKRJoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="75683338"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="75683338"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 07:57:14 -0800
X-CSE-ConnectionGUID: uyhpLQ7fT0WkEH9QEGhhEA==
X-CSE-MsgGUID: bVYASkJpRGCP7l1dlr7lrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="216413785"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.71])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 07:57:11 -0800
Date: Wed, 25 Feb 2026 17:57:09 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: adc: fix typos found by codespell
Message-ID: <aZ8b1WTgddo0Ip81@smile.fi.intel.com>
References: <20260225130858.108421-2-giorgitchankvetadze1997@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225130858.108421-2-giorgitchankvetadze1997@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 25, 2026 at 05:08:59PM +0400, Giorgi Tchankvetadze wrote:
> Fix various spelling mistakes in comments and error messages
> across drivers/iio/adc/, found by running codespell.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


