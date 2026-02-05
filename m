Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7513242CA;
	Thu,  5 Feb 2026 16:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770308606; cv=none; b=uBoms46/WjO6AjvAJLVu6NOD5pLMaBjGDheyTl+KFL9k6SHFHB6wTTRQJ1FlGZBKrNiLQ/nII0FjkI2gslkMuRUle+FCLk2OO04gMdAadj1r36/LJf89UZBNHdiiPleugz+90qdM4DYM71HJHHW+RvGIqlQg1Rb0Yzo39ldjr4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770308606; c=relaxed/simple;
	bh=8U2XY50k6/W+yUqSq8a5MgIO22MPS26FrWvV9He3sA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNBI6DeiZrodTNFERkLYTQfrRQgOnYk1M6+o549jr/MCtABO2OJjAUZ67LGf2on+nfMEvWj/9Qgp5fAKs1Nv+/va9QAWdYpkkYnwVdgS+vnyJXgivf0U6OowxzsF8fJx9EdaCO1yObbjA+lG+mVs78y1HU30s+qAnXlAu/keg1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XLxCLx2s; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XLxCLx2s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770308605; x=1801844605;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8U2XY50k6/W+yUqSq8a5MgIO22MPS26FrWvV9He3sA4=;
  b=XLxCLx2s49gihB4bTAaqsWJiGDvCzn3uvRwNugVMeYDACZCDe9755sCb
   DRvQCjzMC9bwHvcNcMRZT29w3KyGl01avJD85V1mkwou5+TIpRoAotb2m
   B1VgQCXT96FeTQXp1SasXHAnoKHfnKZnUOXqOyxfIRy3LkdmvUZ7SbSn2
   y6+WBqpoQ3/i5EndWSGGFsgc2rwS6d9t/v+0dk2vs/H+kvJe8SN8q9DoN
   LbpWw82VO3r7piqgRMbEB0DsNgrls2yKOu88AYLC+y5qsnDm4ywk3akZW
   HOy8NZmtTckcJYpfNS6586nnhd4jHVHYhkHx1hC8jNRMZ6cLQzgfInHJp
   A==;
X-CSE-ConnectionGUID: dCny9cz9Q8myaKsCvfiabw==
X-CSE-MsgGUID: /h4fZePiQs646KeZP9VW1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="71609021"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="71609021"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 08:23:24 -0800
X-CSE-ConnectionGUID: CJmF6fy+RI+BwPh2uPgpfg==
X-CSE-MsgGUID: EaaqL/aHQ8OYGija1NjYyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="241254736"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.142])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 08:23:22 -0800
Date: Thu, 5 Feb 2026 18:23:19 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Andrew Ijano <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v5 next 2/7] iio: sca3000: switch IRQ handling to devm
 helpers
Message-ID: <aYTD96nmDAEZd-a8@smile.fi.intel.com>
References: <20260205131234.3244467-1-harshit.m.mogalapalli@oracle.com>
 <20260205131234.3244467-3-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205131234.3244467-3-harshit.m.mogalapalli@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Feb 05, 2026 at 05:12:08AM -0800, Harshit Mogalapalli wrote:
> Convert the threaded IRQ registration to devm_request_threaded_irq() so
> that the probe and remove paths can drop manual freeing of irqs.
> 
> No functionality change.

...

> -error_free_irq:
> -	if (spi->irq)
> -		free_irq(spi->irq, indio_dev);
> -
> -	return ret;

...

> -	if (spi->irq)
> -		free_irq(spi->irq, indio_dev);

Do we need an irq member to be in the struct after this patch?

-- 
With Best Regards,
Andy Shevchenko


