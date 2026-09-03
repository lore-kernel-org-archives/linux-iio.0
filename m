Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C3749C4C1;
	Thu,  3 Sep 2026 11:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436298; cv=none; b=YtNOgle+IFDiFn7rKZGx3LEWbIoc9a6Pr6mx+Mh5/qjdS/I3t4zbHxBTfZ/2s4UCay7MKrNl64a5V969Q2Sp2kp6/GqqwF+2sFrupovyvtC2TMi2MQuDVULz5k77iO0KxOWohFQvyYMi7+lvj/zfqTpudOVqsikJp40KgEC99I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436298; c=relaxed/simple;
	bh=qndgYxmcXuzYm/u0er2LS1ozrlS3VNw3ChHm4+FXhiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBZMsMhuhszRt8WVtrygNWbmoYAs8BozdKIf8oqAJ0YpAmNWQRuHhL/KSCPHss30rC+xWup7C0cL0TKhTBht2brn4HJ8xnHKYutIvzyUyKICedwsKIOZXySLpWjOCuhsof2WtnUFEdcXAGvV/RZqhc4e1Azqx8TMps7fasAic3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mZ4PtkX0; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mZ4PtkX0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788436296; x=1819972296;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qndgYxmcXuzYm/u0er2LS1ozrlS3VNw3ChHm4+FXhiE=;
  b=mZ4PtkX0MvcbK+JxM2LaoJrgJC1cnNjx3FzjeJ7PkpzKsC3MtIvTZXw/
   4jgc60UVP/irnpqj/JvmpVJ0N5QyztqBFOXfZkucRtk/pSMvoqZOgUPVl
   RCqh0gUInHmWPSIMeQ+6Qvc3gEYVXNT14eyRbe3yGAHzOfTDXy/nkt7z8
   wATU7ZFGgSl3gUZwu2q2JU3bT5glqRo5QCTZISMIZcAE8brNUXg3UoG0s
   PbMYwa8S6aRlMhHLH9Z3AbgeWgbnok16u15IFPNKyhxp03176AB3LRrGL
   Rx1mt3FEdssOsAK7bkCweK4lzrwrQNr/2PQouVcVmUI5qHaJhN5i176AF
   w==;
X-CSE-ConnectionGUID: QUwZ9aQbRDiigPg1awtwwQ==
X-CSE-MsgGUID: BYZqOewvTr69ocb6ECbvIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="99514792"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="99514792"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 04:51:31 -0700
X-CSE-ConnectionGUID: z+HTm0L+S9mtlOD0I5Wm1Q==
X-CSE-MsgGUID: T2RXHN86SUym2v+GXXug6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="267107232"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.28])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 04:51:29 -0700
Date: Thu, 3 Sep 2026 14:51:27 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salah Triki <salah.triki@gmail.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] iio: adc: ad4030: fix invalid oversampling_ratio
 validation
Message-ID: <aplfP16U0pZ81Ppx@ashevche-desk.local>
References: <20260903114337.63541-1-salah.triki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903114337.63541-1-salah.triki@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 03, 2026 at 12:43:09PM +0100, Salah Triki wrote:
> In ad4030_set_avg_frame_len(), the logarithm is calculated before input
> validation. Passing zero or negative values leads to an undefined result
> from ilog2().
> 
> Validate that the input is strictly positive prior to computing its
> logarithm.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> Assisted-by: Claude:claude-sonnet-5

Assisted-by: LLM
(Documentation was updated on this. No need to resend just for this, though.)

-- 
With Best Regards,
Andy Shevchenko


