Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0103F33ADAF;
	Thu,  3 Sep 2026 06:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788416847; cv=none; b=ZAOW5a8E4t2ws2hNypXBryjqJQ5sg9zBIWiRVHPLOAJwfeB/+sgRBuK8R8ZOnkIGvvJ9EOy01o29qbhmueeGcuF1WDdjfO04mkBLOoVZ3RjXgUZdqydvBrkI01Tv24evKyvZrcUrlO5KBn3IJ5bR4i015R4A0T4391w1ke0I918=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788416847; c=relaxed/simple;
	bh=Ki79UcxNaZBMPAyPc7f/vgh9ak9yOmUwDTRDIR/oO2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bY8iuAEqAXAHifQ8oFSTxSaixYhUw5oG0wSQKDEs0Rz4VzbCRcdZiMhnW7O6yw1eg+dIGz5neJG5RGy+uJH3akCGh4NmdcwJJp+6MwqGqVGPTzbvwblrdsdYhhPscsGgDF0h368WBQk/VlVTghgLeeWU6m+I3os2Yjk8gjSELnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NDtu3MNS; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NDtu3MNS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788416846; x=1819952846;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ki79UcxNaZBMPAyPc7f/vgh9ak9yOmUwDTRDIR/oO2Q=;
  b=NDtu3MNSpNTjZj1vmS0FcBtlqH0Jdzo2oehXy0eEO2AjI5wUReBcKXlp
   hNwvEbH+idAwon1mEOKajOa+gbSwPXrtIc6d7orOBgNxIfCxtv0T2/v/y
   v7Ncz+XpSfXxgOebdUKtrdfFvLDEZNK6m/LpbnOBWN3oaoEhg65v1Gf3a
   M10YshVv0hX3icQqXXQqL15BmJDCT1c5U99wPyzkLQTCsQLjG7ZLsQipa
   X9wcPnBvkG1e/VQ5Fgb16UT2ZHCbxcOwSZuYdjQEe2cPOSkyUPnSVmqgS
   oJ+/Z5q25LgUiy94Gawge7c+aGt5ul8wo9VXBP9hKaOzEG2jvYDAJ23DD
   g==;
X-CSE-ConnectionGUID: g7sGi9uSQQ6EoXDgLtCmIA==
X-CSE-MsgGUID: f2EfU20+TaGqLVOkYfBAFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="92756089"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="92756089"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 23:27:25 -0700
X-CSE-ConnectionGUID: THYI2npGR3eJIS3KwgMsYA==
X-CSE-MsgGUID: /ad5sJi5SLak/AkeA56+5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="307825894"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.28])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 23:27:22 -0700
Date: Thu, 3 Sep 2026 09:27:19 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com, jic23@kernel.org,
	nuno.sa@analog.com, dlechner@baylibre.com, andy@kernel.org,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v1 04/13] iio: adc: ad4134: Serialize single-read
 operations
Message-ID: <apkTRwJp50WCaipq@ashevche-desk.local>
References: <cover.1788368334.git.marcelo.schmitt@analog.com>
 <4e136d116b2eda46fc36f3a3ded3990972c012c4.1788368334.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e136d116b2eda46fc36f3a3ded3990972c012c4.1788368334.git.marcelo.schmitt@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 02, 2026 at 02:22:41PM -0300, Marcelo Schmitt wrote:
> Protect single-sample read operations from going wrong if two or more of
> them run concurrently. Serialize the data read operation so to avoid
> single-sample read requests disrupting each other.

...

>  	case IIO_CHAN_INFO_RAW:
> +		guard(mutex)(&st->lock);

Always delimit guard()() with a blank line.

>  		gpiod_set_value_cansleep(st->odr_gpio, 1);

...

With blank line added
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


