Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F23E2580F2;
	Tue, 31 Mar 2026 19:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774985095; cv=none; b=bOi47gg6IhEev5DI0rMNGsSMRIirQBuSMispXR6IrHG7elnodzVwQ0mJpyFXMvwy/sxrY67xftzxjAP38iLBfKqT2VAROIqfN1Xp3HsyRYj0CuUuCYVynanF2zT66vzJDkn6FpJgNqBJboN311ez2t9/RICYMfv2n4sws7Qqd2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774985095; c=relaxed/simple;
	bh=+2uB615AlPbpur3pnGoP2hcaH6P6R4XGAUTM+tK9VdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ps2JVDX3XzvpFFbSnu5li85aRKZ0auJP1IXvXTzna0V4RlcNmQdfrr6TxtfWi143sDxI/nAWQDlGqoxiUMoC+RmeYuFKLGf5cRA/DP2omx6iOpw++M5Ygjh6sliL2GStFP17AcqJgMjFI4rInvBclXrszP/FEifAWQtJGLhVwqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G//QWtvK; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G//QWtvK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774985095; x=1806521095;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+2uB615AlPbpur3pnGoP2hcaH6P6R4XGAUTM+tK9VdE=;
  b=G//QWtvK6ue7Tp21JJ6cFl166MByQ2KD+CE9RkMTUJEUR1lPS6+Aqv26
   vWUeaxhTSZHxS4JogRu4CU0/RkiYJt+Cy38peJAKKQO3rcvvfJfH9Ssim
   KIYWS+4VVcXRSoJJXTX7VU2SVm7hWKZyheU9w4D/Cn0ST1UqoCwbPkzf+
   zr5zzMf4ihaQOqAT33tJErb0B/nSlWjjkIBsF3Q9AhFnfhvJu/M7P0uva
   8cNGigomw5lSOM1db3bOIpprncTAvWcObLr3U/qrdMvgCIFU9aR56Iqib
   SnwwI4dlu14M/DxOIEN0VdDLNH1W/N92K5XndQNWd3xmbsLzZlafGyEnS
   w==;
X-CSE-ConnectionGUID: 1vYEDJWtQ8uMFhBUmArSxw==
X-CSE-MsgGUID: c9YfIJDwTL235g85go791w==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="93403680"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="93403680"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 12:24:54 -0700
X-CSE-ConnectionGUID: Bk1HLtYIRVGRwGam5PpFHA==
X-CSE-MsgGUID: a4W2oCGJToif5MXN4Iv02A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="264387929"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 12:24:51 -0700
Date: Tue, 31 Mar 2026 22:24:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Matheus Giarola <matheustpgiarola@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	matheusgiarola@usp.br, arthurpilone@usp.br,
	davidbtadokoro@ime.usp.br
Subject: Re: [PATCH v2] iio: adc: ad7280a: replace mutex_lock() with
 guard(mutex)
Message-ID: <acwfgI6LCjPZi5KS@ashevche-desk.local>
References: <20260331153159.204124-1-matheusgiarola@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331153159.204124-1-matheusgiarola@usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 31, 2026 at 12:31:59PM -0300, Matheus Giarola wrote:
> Use guard(mutex) instead of mutex_lock()/mutex_unlock(),
> ensuring the mutex is released automatically when leaving
> the function scope. The change improves error handling and
> avoids issues such as missing unlocks. It also simplifies the
> code by removing 'err_unlock' label and several mutex_unlock()
> calls.
> 
> As suggested, in ad7280_read_raw(), wrap the IIO_CHAN_INFO_RAW
> case in braces, providing a scope for the implicit variable
> declared by guard(mutex).

...

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202603210357.KTWqlL36-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202603210411.t4KwH3aX-lkp@intel.com/

It can't be right. The bugs LKP reported are in your patch and not in the Linux
kernel as of today.

-- 
With Best Regards,
Andy Shevchenko


