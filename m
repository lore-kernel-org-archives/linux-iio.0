Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6904425CC63;
	Mon, 23 Feb 2026 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771855396; cv=none; b=tsXbR6SxpHDuRy6/SYgbtKpH0cyoDgTvW7TYFq+M32eHJmDA9+oewbIFfsYTpPx3/j6W7Ij7JaAq4lt3EAZ3Bye4VCVgBlYotudjKQK5LHVRqbeh4Vu8ijpCpy8DP60XzJkjJSypydOY9ACwb9ZaPOEhT4Hj5lI85RM6DdiDrG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771855396; c=relaxed/simple;
	bh=jcgawmlEYfMoE3y6SdWZVUOvputiZsY5rrn2Qz701xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+kPFWgk5krCR03DYlAi3sDqGS5hSKi0OxesYJJZWWrOsP4AoN4UYOISBGL0cPs+8klhtoX71dCROX+XYtmUtkbl4v0tjQuD1BPUynLU0YxAslxYGgw7T9hK8Zh9tU36alQO7rL7Tjyd+1KELUtB+I3Xueu5xo38MsDd4OjBoXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ns6xy/5o; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ns6xy/5o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771855394; x=1803391394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jcgawmlEYfMoE3y6SdWZVUOvputiZsY5rrn2Qz701xs=;
  b=Ns6xy/5oADYnzihIVE4i/52zoHCBOxklc2v3wojTTXwIOCbiAPKDuayF
   u9xdNTaFk7vMQ0CAe8luv4LYHmZsCn1kwffPtlSFA/Rzzqg6BxISrtjM9
   FkR6iF4rPKZ8HsMW5d79DTS4kBaaDyHDiEBFxF3kO75z+22e4Llvl5MmY
   c8FkZcMISs5out5BzzKySPiT1Cg44spfj4ao1cGVz2EWjAVWhDCWsaPm0
   jX0TKB+KS5SmrNw9caHOFT7v3/wc6a81ALlcRbBzIap44N8mMXDtCjUrc
   RecCt42pX7qs6YgsYcDxA3lCR79YmnpPHJ05yDfdRZtbn2b5MJVQxAYgd
   w==;
X-CSE-ConnectionGUID: 64sGocqkQy68LnjXZr2c1A==
X-CSE-MsgGUID: 7nAy9uCXSGaG2vvl2lP5gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="76712297"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="76712297"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 06:03:14 -0800
X-CSE-ConnectionGUID: t3CvY18+T8qYNTf3ZPhblg==
X-CSE-MsgGUID: FGQDZK8WRpm593yJgCAiDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="253289463"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 06:03:11 -0800
Date: Mon, 23 Feb 2026 16:03:09 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/12] iio: use dev_err_probe in probe path for ADI
 drivers
Message-ID: <aZxeHdygT2rXdcZT@smile.fi.intel.com>
References: <20260223131418.55414-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223131418.55414-1-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 23, 2026 at 03:13:51PM +0200, Antoniu Miclaus wrote:
> Use dev_err_probe() consistently in the probe path of several ADI IIO
> drivers. This simplifies error handling and ensures proper logging of
> deferred probes.
> 
> Each driver is updated in two patches: first introducing a local
> struct device variable to simplify repeated &spi->dev / &client->dev
> references, then converting error paths to use dev_err_probe().
> 
> Drivers updated:
>  - adrf6780
>  - admv1014
>  - admv1013
>  - adf4377
>  - ad7293
>  - admv8818

As I mentioned, use a rule of thumb:

- when devm_ is used in the function, error messages may be converted to
dev_err_probe() as devm_ is supposed to be used only at ->probe() stage

- try to avoid ping-pong type of changes when the same line is modified
2+ times in a row in the same series (there are exceptions, but not here)

-- 
With Best Regards,
Andy Shevchenko


