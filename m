Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9290334D39B;
	Mon, 23 Feb 2026 08:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771835578; cv=none; b=uLwSc9jrYJJYcvrozSuBl02QdzTziIA0fId7LavZIsz6crcP7wPj7EtlCIUyt3GTtKrCPPaz9Peirw2+Bsl1zbB4PP+oA3n9YuhAhcWFByKkhdTtR3fHR7JEnIYFz7MhtIrrPUjXQ2CR+mgS1jRjaHKimlKvxNKfl+0jYqVfFHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771835578; c=relaxed/simple;
	bh=/Px38sBOwzTTCp6LwYfEICnyWhPMtc9iOcE1S79Fysc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBVS2t+hDN2nzpS/qtqxuYvkj51CcPn9UIrHnrkec5yz2dEP4udG5BFlnA2vCvrYOlZ0oemyUr4nL13pw4aWQZxm9U0ZS/kfqpMzXcobqQhgUzJrfe9IthxtJjSre1CRndzqpXDIRoUZGFUdNwcH4QagMMdiW7vYGrjOEHFqB+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AWqtwsF2; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AWqtwsF2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771835576; x=1803371576;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/Px38sBOwzTTCp6LwYfEICnyWhPMtc9iOcE1S79Fysc=;
  b=AWqtwsF20118lCFbY45GJ+GDi1VBlnuklrN72/A5kQG4D3JbrzRty+3l
   t4rySPqo1/c0tg3d5EH4QdFlQOHUDYA2/meLjG0cDmDvA/HbSXOwXY4M6
   SBayc1gzzbDRFSsAPiSzOUBsCWB+YTTXBNM2cVO+7DWpPAqhM/36M57/z
   w6zdUhyzOVE6Nc65gW72EycJ5m7jDPr5Can1xwa9mtnxYfj6sohZvugao
   3jssAsNfzl7I0i4Ew6wkyaPGMOkZbpdAC7JCjya8kblDodkv9stgFkRru
   y7RNpr/hQLqjDbcSN7iN6nUIz2gMWh0UniVt8flLfim7H6DvOzb5DFfg2
   w==;
X-CSE-ConnectionGUID: DAajRk4OSQKb5Hk4kXeS3Q==
X-CSE-MsgGUID: mUHrFeOCTRGMKD/ZekNhZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="60397080"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="60397080"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 00:32:56 -0800
X-CSE-ConnectionGUID: KoHG83tbSK+Vi68IHSZcoQ==
X-CSE-MsgGUID: BmDOeXsCTUS+2ZGlBVJOQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="220490849"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 00:32:53 -0800
Date: Mon, 23 Feb 2026 10:32:51 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7173: move opening brace to a separate line
Message-ID: <aZwQszq2o4MlXpOS@smile.fi.intel.com>
References: <20260223082359.46403-2-giorgitchankvetadze1997@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223082359.46403-2-giorgitchankvetadze1997@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 23, 2026 at 12:24:00PM +0400, Giorgi Tchankvetadze wrote:
> Place the opening brace of ad7173_calc_openwire_thrsh_raw() on its own
> line to comply with the kernel coding style for function definitions.
> Issue found by checkpatch.

Is it the only problem like this in the entire driver?
If so, feel free to add
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


