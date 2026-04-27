Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C51439936D;
	Mon, 27 Apr 2026 08:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777277387; cv=none; b=E5wAqTGEimWa/0e6fDLWvjRnpXJ+Z0fJTOmGC0s1oRGJ1qyWZAd3bavNV7jiMaZ2PEKMe2XKkmg0UfdWO77EYPLd9bkmpHxpL8bIsusLpKijHtKLsWE3kK/7/gFFn4i1lrIDqCNb8tNpgx7mqMMO9DQz8tkatTMHvHTcCBkT5P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777277387; c=relaxed/simple;
	bh=tXc9xXctGchVuTqHU/Stnsqf9SkKcvR4YcgI8yOLvps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ob59jhvtMOetvQbCmIhIwhnmlnnMUKvrChaRhQM/83843ldisdqk94tdyfgFwHmMQT3fL7oNgmvXoKbsgORTCByGOZDddyotwgBIu5ObVPiQZ4wLpVYG/gikm8w/V+/8SIfQhR7w//yUhHmYsgwZjVEVthj3byEmG1VdmwA18SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DLwAULPR; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DLwAULPR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777277385; x=1808813385;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tXc9xXctGchVuTqHU/Stnsqf9SkKcvR4YcgI8yOLvps=;
  b=DLwAULPRllokEghjdkk7nShTgVqCCpEPdIFVVEUMTjXKZ/+DcgXrLdeQ
   9C8BrgTB7ppBljL6T7nKwc4Xfi/jl4bjVafpq4pXaBC3WNjnsRwALR6ow
   ACl6HZ2vZoJSCuzxOWhqU+ztAor62ilGB+WahRo3r6s50Tq6vl6Zo5vQ3
   CiMn2lNgeviXkgS+RMPPQDv/DaTA5czQghse7M+P1qisBkdxRrJHY28WY
   cL4S/o+U5L+qahESCsn8ulGROYG/cF0mhcaDpzuDVBCToKOaaRvIh7yBK
   /1QsD5Un60LHDbAsz4xFdkXiFqKuUPcCdaCM2Bk6gFc4qAFxA98c3QROj
   Q==;
X-CSE-ConnectionGUID: 2KWpDEHrTa2QYn87Dr/Gpw==
X-CSE-MsgGUID: jfiqOXxDRtCznGlYFq8SUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="88851764"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="88851764"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 01:09:38 -0700
X-CSE-ConnectionGUID: lNbbvaXXQ0K4XVO4+pxpvw==
X-CSE-MsgGUID: 1IXD3UJiSNqunxYFu7p40w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="233452196"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 01:09:36 -0700
Date: Mon, 27 Apr 2026 11:09:32 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, mingo@kernel.org,
	christophe.jaillet@wanadoo.fr, nabijaczleweli@nabijaczleweli.xyz,
	kees@kernel.org, kyungmin.park@samsung.com, k.wrona@samsung.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/9] iio: ssp_sensors: use local struct device
Message-ID: <ae8ZvFokn8EoQMQa@ashevche-desk.local>
References: <20260426091710.3722035-1-sanjayembedded@gmail.com>
 <20260426091710.3722035-6-sanjayembedded@gmail.com>
 <20260426151651.48a690c9@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260426151651.48a690c9@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Apr 26, 2026 at 03:16:51PM +0100, Jonathan Cameron wrote:
> On Sun, 26 Apr 2026 14:47:06 +0530
> Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

...

> > Introduce a struct device *dev derived from &spi->dev to improve
> > readability and reorder variable(s) to follow reversed xmas tree style.
> It's really minor reordering but generally I'd not do that in a patch
> that does anything else.  So here I'd have put the new variables
> in as close to correct location as possible, then followed with
> a reorder if it was worth the churn that results. I'm not sure it is
> in this particular case.

+1. And ideally that 'i' has to be converted to unsigned type.

-- 
With Best Regards,
Andy Shevchenko


