Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177F82F3621;
	Tue,  3 Feb 2026 15:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770131967; cv=none; b=FLoAtV+V1LMe1PlEZjdSuB2dNE61//Po2MtXZnU27xZg9IM00IEMAc1L+FgvoCDHJA8/SH++1B/Anxu9Ja6mfEGwAdl4BwxASq2GXJIFCqwInB7XQBGRND7ASgNc3scerFtzvPJPG9KPyhg/cvHWl1BeGoFRMWOj+lfmVgyrIAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770131967; c=relaxed/simple;
	bh=ZXHC4aCZ04biloa4kFf/C83DMRF22FoFOsqpEA3islU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOvJKoMa7jM9ZrNv+aXploKkZXzydW0pUFRMkvUso3mj5P+vBJxSTq6SLgZwL+KG0Gh7seVub2uO9O8fnU8wAjeHP7Qq32Pxu7ZXoCz7MJCPev4EeMEBBQVCBn2UVjw9SZocmIW1B8e0feQExzNam3tSzfC1COlGQa+bAvLQMqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qp0P/mku; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qp0P/mku"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770131966; x=1801667966;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZXHC4aCZ04biloa4kFf/C83DMRF22FoFOsqpEA3islU=;
  b=Qp0P/mkum5hyH9h20gqjFFXeVulFf7e01x0dR1WSohn3W2L9g/C9KvGW
   NUPC3ynijQT4cv5ztLpXZMjpMkMOLJm7d4ai+IwWFachKJO8mGGUdvp8F
   2iVKKFzhvPUsAJZPBpM+1dM2o98PzrLehveqXjGL1+uaiQW+TSguAc0O5
   CW5I0OswTylOSv+Q/BxXnpgBh2CTWRXwRD8rowOgP8FUcaVuLonRnXiuP
   uDjwdTOwY3llAoDrO+WVyUaamf6nBmnGvqtT7b9OgF6iTXz1t31bKubIL
   YJKRFrN+2zOufVpfI3uYJV65o+gZpkXEB0Fba4NSQlIPd18GQAWGSw5Jo
   w==;
X-CSE-ConnectionGUID: x8kLWUITTQq6yeGc7CYJFQ==
X-CSE-MsgGUID: cWC9h/x8RsSoxy8to5+GIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="71385002"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="71385002"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 07:19:25 -0800
X-CSE-ConnectionGUID: irwJ5LvXRJKPtv42w6Fz3Q==
X-CSE-MsgGUID: C+bOSay6RcGPl+GNzfPVBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="214407232"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 07:19:23 -0800
Date: Tue, 3 Feb 2026 17:19:20 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Andrew Ijano <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	error27@gmail.com
Subject: Re: [PATCH v3 next 1/6] iio: sca3000: cache SPI device ID in probe
Message-ID: <aYIR-LAq9iJETwjK@smile.fi.intel.com>
References: <20260203122109.689669-1-harshit.m.mogalapalli@oracle.com>
 <20260203122109.689669-2-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203122109.689669-2-harshit.m.mogalapalli@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 03, 2026 at 04:20:45AM -0800, Harshit Mogalapalli wrote:
> Store the spi_device_id at probe entry and reuse it for the name and
> chip info instead of calling spi_get_device_id() repeatedly.
> 
> While at it, reshuffle variable list in a reverse Christmas tree
> order. No functional change intended.

Did you miss David's comment? AFAIU the suggestion was to convert to
chip_info(). With that done, this should use spi_device_get_match_data()
(or something like that, I don't remember the correct spelling of that API).

-- 
With Best Regards,
Andy Shevchenko


