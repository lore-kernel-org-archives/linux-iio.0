Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4748F3AE6E9;
	Wed,  8 Jul 2026 19:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783540679; cv=none; b=Meu6JoSbHNzl7OwH9jnOBmJCWSrDVIIXdcY/htcaVKC7LN/H536YrHCQ5BUrP1SXZSbE5pr8mpV2c6IW8sy3IUtm8t93OvTfv1re7vE29knxN9157yPZafHCGSLgNH9fzjrz8jZXOn82ZMMJSso80WFf+L+xmMwpveoisQo6ADA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783540679; c=relaxed/simple;
	bh=HM2D121xC3MIpyco4xPo75p8ZgVxTT2VrWYeZduVT2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aawOC/wkPiHf5Kb3yXfQpX/ZxAlJnkc5c9OtqqFiwwjBlarwhV3Cws5M/Lwmmu9NQsnTnUJujBshr+FMu+4qC1/yOkhbN6ukyeJPvwrXAKKvTtvBRwQOsfKc2RKm/01ayhzXW9SOj0l650dcz1592JTb5w3dBZHhN3EfZjL3sis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nsMkdDd7; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nsMkdDd7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783540679; x=1815076679;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HM2D121xC3MIpyco4xPo75p8ZgVxTT2VrWYeZduVT2c=;
  b=nsMkdDd75j6h3YlUm6BvyxqrLW1mx3ShPGbBGwGOpOUvF89aH0c/GCQJ
   rwr9kMcIhPiMavfIl76U6Raqlg+SzpE8j3vf8lbLmdDMHubtDjxyY6QCJ
   4kJjmjhgWnvHMkOdadS/4he3Tn7xCtEX8/oAdvOvxroFStQ9LndHCgfzd
   b029wlwzPeR0pSJvV3ffJpuZOzPqwhlnoSE97P8H5qn9w0bVsPT7ceyMt
   0VUZgjeU6rHi9KcK3hTRWYrbkmbiZOJBOSsBzWAYpUFujuZJyvQNlByXZ
   evF/H7UG0PZUd+O1lsNZYctzTHojn2Hk543Ribu6vrdtxhatvaDQgBY1k
   Q==;
X-CSE-ConnectionGUID: vNOCRf4wS8a0t44x7v30Xg==
X-CSE-MsgGUID: 6sp7a+GeSe+3NRz2wXp0vA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84073149"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84073149"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 12:57:58 -0700
X-CSE-ConnectionGUID: 896B5yMOQlqrknYlDau6Kg==
X-CSE-MsgGUID: 6GsgIUbYT8iZ5A302Jw56g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="248017551"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 12:57:55 -0700
Date: Wed, 8 Jul 2026 22:57:53 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: opt3001: split opt3001_get_processed() logic
Message-ID: <ak6rwTyFy25_Ztjo@ashevche-desk.local>
References: <20260708-opt3001-unwind-cleanup-v1-1-900b2cfddb6a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708-opt3001-unwind-cleanup-v1-1-900b2cfddb6a@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 08, 2026 at 09:33:20PM +0200, Joshua Crofts wrote:
> Split the logic inside the opt3001_get_processed() function, as the
> current flow is hard to read, mixing IRQ and non-IRQ code blocks.
> 
> Separate the IRQ code path into its own function, same for the
> non-IRQ path.

> +	timeout = (opt->int_time == OPT3001_INT_TIME_SHORT) ?
> +		   OPT3001_RESULT_READY_SHORT : OPT3001_RESULT_READY_LONG;
> +	msleep(timeout);

It's not used after, so

	if (opt->int_time == OPT3001_INT_TIME_SHORT)
		msleep(OPT3001_RESULT_READY_SHORT);
	else
		msleep(OPT3001_RESULT_READY_LONG);

-- 
With Best Regards,
Andy Shevchenko


