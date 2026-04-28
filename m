Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DC524A069;
	Tue, 28 Apr 2026 15:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777391402; cv=none; b=AmCJkF6XcaATliv27D0PkK+Dq9dCAjegmNBLociOjciOCapiNlnRPyDmyK/veUscgqJL+3+1AH3AkqaRFqDqHOseiGpNpESZ6bG3GipaAwyAWI+E5b8fkiiUJ6UySkbC/UkDdeBGaic6gzQhpiVBc0g+3G8BdvItoYbDOsbBQMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777391402; c=relaxed/simple;
	bh=56U6/oK1L0sc5qPl5N8aOsF6RV27YNyk67ZjnV9e1Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aell1bvKPCBY7pxsYhY9np5LR6qSvTLReMsYQQMsgbRCvC/nRUWXAeEizegd2GiHR6n6R7kxlR2jUc079fG8V3MPYBUfL4wSaAgn+vKJHzn1AItdU/U6ksGh/MBYZud2QInpT6dqyBJh/+eKHsegcNbot2j9H73P4e8MgXZA0bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oK0iAS7c; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oK0iAS7c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777391401; x=1808927401;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=56U6/oK1L0sc5qPl5N8aOsF6RV27YNyk67ZjnV9e1Es=;
  b=oK0iAS7ctnc2/Mg2Yb/Kk5IqZjkdWLj3s6v86Q2gsuB3AlL23GWIWBef
   hYQYj6HdpkCZ7jrelTHO6K4wDPbItA39yAFyuapHvrPsHAllPZOzF4KXI
   GfJjRgXwtH6orSCtqr8u4bFjjzTerJOZkHq814ulzXtY6ErCU9e13Xw0k
   1piXV4BUug+jgEDDKbi3FcTKk6T9kVgpXmf+mfumOX1Kcy/75hkzxr8jZ
   cFWO1hBe/Qe7HjiI4sPvlNI0POqtiFLJkZeA3h3lPG9gO6L98IfUkYNSN
   XMg/rKBp8SdCYQmMdqYMMDHhmUHjdSQOOL/RQibZBi2oHYrVidPslgbJk
   g==;
X-CSE-ConnectionGUID: BpkefvoUR6+GR6JaBUGSAw==
X-CSE-MsgGUID: qlThgGlISnOt/+cUvR0FVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="77334970"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="77334970"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 08:50:00 -0700
X-CSE-ConnectionGUID: +oOB/lAXSaawGpMYgVqcTw==
X-CSE-MsgGUID: S063X2enTe+1pz3+FaSxjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="233124488"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.213])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 08:49:58 -0700
Date: Tue, 28 Apr 2026 18:49:56 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salah Triki <salah.triki@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: tsys01: fix broken PROM checksum
 validation
Message-ID: <afDXJLGYzF8uwaj5@ashevche-desk.local>
References: <20260428152239.66213-1-salah.triki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428152239.66213-1-salah.triki@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 28, 2026 at 04:22:39PM +0100, Salah Triki wrote:
> The CRC check function was incorrectly using only the first word of the
> PROM (n_prom[0]) instead of iterating through all words. This caused
> the driver to fail probing on most devices due to incorrect checksum
> calculation.
> 
> - Fix loop to use the correct index n_prom[cnt].
> - Ensure all bytes are summed as per the datasheet specification.

...

>  	u8 sum = 0;
>  
>  	for (cnt = 0; cnt < TSYS01_PROM_WORDS_NB; cnt++)
> -		sum += ((n_prom[0] >> 8) + (n_prom[0] & 0xFF));
> +		sum += ((n_prom[cnt] >> 8) + (n_prom[cnt] & 0xFF));
>  
>  	return (sum == 0);

This change makes more questions than answers. How had it been tested,
if tested at all? (This question is to before and to after, the commit
message is also unclear about what datasheet says or the real field
testing gives.)

-- 
With Best Regards,
Andy Shevchenko


