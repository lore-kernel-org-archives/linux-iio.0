Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4EB2BE053;
	Fri, 17 Jul 2026 08:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784276234; cv=none; b=S6pt/ker0NyWQ3alvrygefkULT4tCFpGfK52LGxDthOKAtir69/FsN53QZqpuAd0nLMAIVExFQ2g9KKvotQN0TfYJYUwfnSzEt4TiK+GFo42ktjwuwm0rNgHcN/9UQhPfZTkV/mpZEYORcGlI/LGkIx8i3rnsC1hnIQScMczKow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784276234; c=relaxed/simple;
	bh=nB+3Yg7rIBaeQzI0V+Ucj+GzODhLVyRBZYK+U0KQlUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A73TJVktmQeOpy7YYYdeCb92FCCKMib8UB2SefdwcBVP7fimdQhMX9fofewKGeFJ0hMTt8eYh7ibru6g9toyGDAkexS/QkdLOyt4Qm0bXNRDYVz2UaYP8fCqD9zpWTBvDRN/kGyZqELK+DhQbWRDOu30qsDQ6GCyiIhbDGOhvf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EcXWHGg5; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EcXWHGg5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784276233; x=1815812233;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nB+3Yg7rIBaeQzI0V+Ucj+GzODhLVyRBZYK+U0KQlUY=;
  b=EcXWHGg5fqckrGqM4H4U8Kp8msZJk8bfY45fmnoechVGOJewlRtSPIeU
   eIO09q5VF5Vhc6ZlBZbHMnmEivRjIFcP/4jOyOAO+kfsm2LyYZUMKWzND
   5j8pPbHVYCMdnLnDLr10Bq+cJc8yEvrpS2SxumIzhFKjeFRtmP+EtrW4y
   nmDUSmU0YedWErZid+IS7YnDBIlBo0l+7GPZcWUJLy92Mg2oLoPRFszug
   KeeILgkvz3s+SbqTHUJYysml2nOa0O68GD3D9b/YxdYJXslcQiGwQfCMY
   51mRKdynvJl0ERitNILqu5M+Log2U2XnBaU0+7D/OFBjXCuq0nmS+3/cs
   g==;
X-CSE-ConnectionGUID: VTayLpelTZelp3ni0BmGYw==
X-CSE-MsgGUID: m/Kqq8S5Q+mxN8lPexYu+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="72479016"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="72479016"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 01:17:12 -0700
X-CSE-ConnectionGUID: AMr/tyC5S3uFcmU34LsXiQ==
X-CSE-MsgGUID: jqoo8digTxyN4Ifni2aS+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="294924405"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.143])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 01:17:10 -0700
Date: Fri, 17 Jul 2026 11:17:07 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Babanpreet Singh <bbnpreetsingh@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Angelo Dureghello <adureghello@baylibre.com>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: ad3552r-hs: fix scnprintf() buffer bound in
 data source show
Message-ID: <alnlAxxL8pSfTDpw@ashevche-desk.local>
References: <20260717040024.7-1-bbnpreetsingh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717040024.7-1-bbnpreetsingh@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 17, 2026 at 04:00:24AM +0000, Babanpreet Singh wrote:
> ad3552r_hs_show_data_source_avail() formats the available data source
> names into a 128-byte stack buffer, but bounds each scnprintf() with
> PAGE_SIZE instead of the buffer size, so the bound does not protect
> the destination at all.
> 
> This cannot overflow today - dbgfs_attr_source[] has two entries,
> "normal" and "ramp-16bit", 18 bytes formatted - but the bound stops
> protecting the stack the day the table grows. Use sizeof(buf) so the
> bound matches the destination.
> 
> Found by smatch:
> 
>   drivers/iio/dac/ad3552r-hs.c:593 ad3552r_hs_show_data_source_avail()
>   error: scnprintf() 'buf[len]' too small (128 vs 4096)

Nice, but please use sysfs_emit_at() instead. This will fix the above issue as
well while moving towards the modern and recommended API.


-- 
With Best Regards,
Andy Shevchenko


