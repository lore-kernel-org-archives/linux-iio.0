Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BD923184A;
	Tue,  3 Feb 2026 11:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770117242; cv=none; b=hgTqQW+eXw9VoFxZIwjOLb0Uc2jt8Av4yEAmWO3VdCs94NIzeQiJUdNc1e06rSWP20VJDBmoiJi12RKbq+3P27pwtoYJniJiqEr7e1ghezv+Wf/gyOq2/PPziA5vs9G3+yX53ULjQZjQEIsOD+y/LiHPayRIL1OgkbnYFJeHDSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770117242; c=relaxed/simple;
	bh=KsOrOyG9JbMlwTK5D6n6A+1RqAGY1/PgIxL71Hfk+E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0nL+molw5NTSUSlQ7JTbzvoIUfwRCIEKYHhsVt7ptgdXn6DFP/z523iAXKFpyACxIuTGPRoualPBySibAkxQvi+5IkC9aWLRnd+VnPgAndYxNKuZF4c2oHgIFqLVJZHh/XuQ4qikaWxNcttqJXss/4vLAHQl9BF3/wDCDt7Nu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cPdqrpfN; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cPdqrpfN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770117240; x=1801653240;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KsOrOyG9JbMlwTK5D6n6A+1RqAGY1/PgIxL71Hfk+E0=;
  b=cPdqrpfN61MAZZRTsAb/XCV30q4eQswy78OxSUn7MYl8CYewsRwsfzJk
   l2PZhKzUyCZlx5R8XIMCKgwBQBe5HL42Z97EPdrxeF6Z3Krezgm0iwKuB
   dZ664sNTqZuEfefoZFks3ATkv1MrynLEls013AjAF9p8907eruBbH26j/
   CRewboTNa8kBq3HGNLyByc7dkWhwWcNZAF4tHkLLfBki9poir/usCT6a9
   QvFHwhpG6CP3UgTBMKAqlNCH+eXHVrZ7o9qh5zu2TyNzTyuZPZYMrZm4X
   kefxdar2qgqr/lm7boeoB+6fwAit4y1fH8Fa/DlPdZyBe6ijJ3S1A4yIs
   g==;
X-CSE-ConnectionGUID: /FHq0IcvQTe/7qzGhU83pw==
X-CSE-MsgGUID: t3x6nV7qTTW4p1xYYsQwAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="71007742"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="71007742"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 03:14:00 -0800
X-CSE-ConnectionGUID: v6cxmktKQqingYsXGs9qkQ==
X-CSE-MsgGUID: QhuGL3mYSPmFYCph0wOjig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="214306062"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 03:13:58 -0800
Date: Tue, 3 Feb 2026 13:13:56 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: mpu3050-i2c: use pm_runtime_resume_and_get()
Message-ID: <aYHYdIISTPbB6Qh8@smile.fi.intel.com>
References: <20260130153227.213413-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130153227.213413-1-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 30, 2026 at 05:32:26PM +0200, Antoniu Miclaus wrote:
> Use pm_runtime_resume_and_get() in bypass_select() and return its
> result directly. Unlike pm_runtime_get_sync(), it doesn't increment
> the refcount on failure.

...

>  	/* Just power up the device, that is all that is needed */
> -	pm_runtime_get_sync(mpu3050->dev);
> -	return 0;
> +	return pm_runtime_resume_and_get(mpu3050->dev);

Will it also return positive values?

...

Same Q to the next change.

-- 
With Best Regards,
Andy Shevchenko


