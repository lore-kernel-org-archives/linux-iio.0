Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAA43630A9;
	Mon, 11 May 2026 11:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778497652; cv=none; b=hrcKYf2Up0wlBxoi5Cqj9GqqC/hKMQdtNl1HBZRoV26lDvdpo4lmMQUQ8tAJ9dAULOLkmUtFTCHtK6G7RpfpgghkxEjexMoHK986wDC+tMIhW4K4pEQOMnCO3P80S5TKp2919UpPMsNp8blqbp5s0FDG5KtksXfMDckS42v3pKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778497652; c=relaxed/simple;
	bh=SgeoA54b65hPj1q5eDYAyVpBmedyKFmwGlX5T8VgADg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQrUTCDfluStWr1JzBvVRoZL31KQW6TNwoVM4ZRu4WtfRCP4VMTmRIh0B55nPA0F7wP/ZZzJZSO8gwPLMlW/jF6WjKKMRszoaTon9fAAfe4K6eknMW449GJX9OIosHof45qMJYYZXegYwniBbLyBZKi/IbnoEExlCSUHuiuj2Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i7jhvGOJ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i7jhvGOJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778497651; x=1810033651;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SgeoA54b65hPj1q5eDYAyVpBmedyKFmwGlX5T8VgADg=;
  b=i7jhvGOJ8c0aPSW5Cth1sbp5A9W8lfFevBdPEpVRuroDIaRXdcvYnbs0
   vsiXlhOoXA0zhGEd/D8K41JL2n08+vzEMhRwhltgV33YSSLVE2pC7rDKc
   iZT4r1duFl0yPjqjFeWpKkRqUDwfqXSra2tBYJcdsclT6gVMiHq+SQjPm
   XeGE611BWzCLQMYeU7njrIg2Bj34X7NmWhLK8v8QRKFabDLHC4Y/R/GTh
   GUR6QjZHHGHe7CD+28JNSMeBINZ3d2wc3VQqDP6VVMDsX41T2EppctJzi
   CgINQD7DdoCB7A2hxr6C7M9c6e8sM8rZy4EhrGj+z2AyjjGnWQBKdaPpR
   w==;
X-CSE-ConnectionGUID: GBX20V0QTYOTjJEJD5cImA==
X-CSE-MsgGUID: dpLJXt3uTWq0YzhpiiDVtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="79102010"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="79102010"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 04:07:30 -0700
X-CSE-ConnectionGUID: w2I+tT4lS9WFpLNF4aso1g==
X-CSE-MsgGUID: ULmflyQuQryPYjkumrOpgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="261155243"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 04:07:28 -0700
Date: Mon, 11 May 2026 14:07:26 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] iio: light: opt3001: move driver to guard(mutex)()
 use
Message-ID: <agG4bt8mboTd6N_g@ashevche-desk.local>
References: <20260511-opt3001-cleanup-v1-0-f7879dc3455c@gmail.com>
 <20260511-opt3001-cleanup-v1-4-f7879dc3455c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-opt3001-cleanup-v1-4-f7879dc3455c@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 11, 2026 at 12:04:09PM +0200, Joshua Crofts via B4 Relay wrote:

> Move driver to use guard(mutex)() macro, to facilitate automatic
> locking/unlocking of resources. This modernizes the driver and
> improves code style.

This one LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

Side note for the additional patch, in case you want to address that.

>  		dev_err(opt->dev, "failed to read register %02x\n",
>  				OPT3001_CONFIGURATION);

Broken indentation.

...

>  	ret = i2c_smbus_write_word_swapped(opt->client, OPT3001_CONFIGURATION,
>  			reg);

Ditto.

...

>  		dev_err(opt->dev, "failed to write register %02x\n",
>  				OPT3001_CONFIGURATION);

Ditto.

...

There may be more, I haven't checked, but maybe we want to clean this up as
well at some point.


-- 
With Best Regards,
Andy Shevchenko


