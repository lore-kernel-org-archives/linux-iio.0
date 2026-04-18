Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EDE40DFB4;
	Sat, 18 Apr 2026 00:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776471339; cv=none; b=MjMOyPUMDOpz0Jv6MYuSbnyF76ndMHDw5k2rcvqBcEdDSQnfjlwtXJztxJkpwghJNXiBzMDk6nIxus8lNj+uO251CwEpKSsTEkIUNK+/qLPLELzkm16ORSaIcVlY5hpNbsH7bMh/4jldyw761itrD/YKY/ZTG5SXJyrKcVVvXIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776471339; c=relaxed/simple;
	bh=5j6Tz867UdKYk+HXFgQjPA1qnDGCEj1alvrSm2Eqaxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+hcvhyIlsHxuKEswIg86x53PBXOgPaYUpUgxwkrAKNUU6e7jlGZHusLUrisxovfY6d/WOi7xHMl2GLh+b+lCE2fDhGQo/fcppQI2qhbL1cebyubwWj7ZuSXq9iwYg7fWYTnjZVbpWBe4PX8CTL7ZI4LjH/yxH/7PulgAAzQxWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oBTtDOCh; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oBTtDOCh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776471337; x=1808007337;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=5j6Tz867UdKYk+HXFgQjPA1qnDGCEj1alvrSm2Eqaxc=;
  b=oBTtDOChWCTC21BLenYocZ0Xga8xO1hnlWrjJanGZBdFiclE8ZRI/xUq
   Gll8RFNMHbdRSNxVD0Xhdvq1Rm8Y4Y0syFPJPRg1F2ei+EIGQsjm1MDas
   hHmEp/bGk5tnPpqY1E777LZS6UT5DSztUxTNi9XPp+DOZGkyKFLyG0hbd
   eQm76Prctj8mIeFR2T3smjyTdTRieQWjBIo7oNgUYkna6xcWyPjlRlOfI
   ypW7mbDzQhqaTqo18OeMW0HNjAJrzGLIX/7wyonLgXO/IdTVLf569Vcvg
   /QJgHgaWVN4Qt3cq/Dm9j+BqJFEB8Re7GIwcy2iEFLLa8O2Jk3ehB1l9C
   g==;
X-CSE-ConnectionGUID: dDlYvdhPSRCbp06tVnlESQ==
X-CSE-MsgGUID: gXZYRUsHS5+5cURtyeGMmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="88867585"
X-IronPort-AV: E=Sophos;i="6.23,185,1770624000"; 
   d="scan'208";a="88867585"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 17:15:36 -0700
X-CSE-ConnectionGUID: ABuI7TuKTOKw5GQICzodGQ==
X-CSE-MsgGUID: H/+lCEIvTgGbORkAOD74uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,185,1770624000"; 
   d="scan'208";a="231094067"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 17:15:33 -0700
Date: Sat, 18 Apr 2026 03:15:30 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: lucas.p.stankus@gmail.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, puranjay@kernel.org,
	cosmin.tanislav@analog.com, marcelo.schmitt@analog.com,
	antoniu.miclaus@analog.com, ramona.gradinariu@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/8] iio: accel: adxl313: Use dev_err_probe
Message-ID: <aeLNIudilS_IkZbu@ashevche-desk.local>
References: <20260417124924.353189-1-sanjayembedded@gmail.com>
 <20260417124924.353189-3-sanjayembedded@gmail.com>
 <aeJ9j6g9J7JUdg8p@ashevche-desk.local>
 <459F7B97-4FC2-4418-BCB6-DAACE1B49BC9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <459F7B97-4FC2-4418-BCB6-DAACE1B49BC9@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Apr 18, 2026 at 12:17:34AM +0530, Sanjay Chitroda wrote:
> On 18 April 2026 12:05:59 am IST, Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> >On Fri, Apr 17, 2026 at 06:19:18PM +0530, Sanjay Chitroda wrote:


...

> >> +	return adxl313_core_probe(dev, regmap,
> >>  				  chip_data, &adxl313_spi_setup);
> >
> >Now it may be a single line.
> >
> 
> It was the single line, length is reduced.
> 
> dev_err() was multi line in few driver; however with your input on dev
> dev_err_probe(dev, ...) become single line.

I haven't commented on that one, I left the line I commented on above.
And I have checked, it's perfectly fits 80 characters.

-- 
With Best Regards,
Andy Shevchenko


