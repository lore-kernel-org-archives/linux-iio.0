Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A403364EA4;
	Mon, 27 Apr 2026 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777312391; cv=none; b=Ae7+yDfbXYVBq93x2DwKltpTCuTi86oNPSnc3Z2e2ehMzCEkTM95K9/tddF/J+ViYO42M0jiCQ3uKaTUe0CXyPtnxhIaHYoWUG0Cj3CwgzoBDguYjo/DpUcDcTrt0IGC4AG1UH+DhNB+SFSaclIQbz59blQMPMttWxEfwJvSTG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777312391; c=relaxed/simple;
	bh=UVQKdWBjUE5GkLKUNtX7rtIo3DhENc4jPq7k7cHCyAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsXWghFDhJ8dNiHEqei1NICj7RRYhsM0yzT9Q44EDH0Gcz1AL16QlkrP6ui9BKKRTdFrqxjm+CRAv/u/XLVd5LtFwTTf/CGRmmaawS4NAf8bEUFMV3d20ITzCNOu+r9jmX0gv1UtyugYpvzS/q9NGLEh1tR8JoBUIzZUofNisp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fum7paMt; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fum7paMt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777312390; x=1808848390;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UVQKdWBjUE5GkLKUNtX7rtIo3DhENc4jPq7k7cHCyAo=;
  b=Fum7paMt2YJFB7dR9+ed2OrN8o+GalM8wWBrlwqYoDIkpsaNMhxzi1/c
   G0WiH2XWmdE14/yKSReU6eHNaFFN6nvXQbVC+lwpzRAN4DHJzEf6E1Vuw
   2SSrBCBCPx0qy1mHcb9m9gD7OMbYNUPaLrCfhJWAOQlNYGI1/MVsaOJ4d
   DOYjVUI6QaoKulOA4V2NmSH7mRezNZqP/0hudZDcBGXlAjGMsRZDRkZ0T
   VjDko4ly1Ug+JayebJnEi2p1vFQR8TTwjgbZfry7tUEkr3SAEvwPeyf1O
   wbae5vDnVIj++A6eiW0Og0fYtXpWsQN+URwkzHEnoVE/FWpUc4MJ6qFY7
   w==;
X-CSE-ConnectionGUID: 8aiG/b0QRSOU66yloEag3w==
X-CSE-MsgGUID: TwDsc7qiQa65pMmwOVeRQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="80785032"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="80785032"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 10:53:10 -0700
X-CSE-ConnectionGUID: Kz9XC4GYQNCIsNfB921rnQ==
X-CSE-MsgGUID: /9523K4ZQyebsB2WLyUHdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="231060808"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 10:53:06 -0700
Date: Mon, 27 Apr 2026 20:53:04 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stefan Popa <stefan.popa@analog.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Michael Auchter <michael.auchter@ni.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 01/11] iio: dac: ad5686: fix ref bit initialization
 for single-channel parts
Message-ID: <ae-igOGbCcdoNMV5@ashevche-desk.local>
References: <20260427-ad5686-fixes-v2-0-188e05199368@analog.com>
 <20260427-ad5686-fixes-v2-1-188e05199368@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427-ad5686-fixes-v2-1-188e05199368@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 27, 2026 at 12:30:08PM +0100, Rodrigo Alencar via B4 Relay wrote:

> The reference bit position was ignored when writing the register at the
> probe() function (!!val was used). When such bit is 1, internal voltage
> reference is disabled so that an external one can be used. For
> multi-channel devices, bit 0 of the Internal Reference Setup command
> behaves the same way, so AD5686_REF_BIT_MSK is created. The issue exists
> since support for single-channel devices were first introduced.

...

> -	val = (has_external_vref | ref_bit_msk);
> +	val = (has_external_vref) ? ref_bit_msk : 0;

Too many parentheses. If the former had something in mind, the latter really
doesn't need them.

...

Otherwise LGTM!

-- 
With Best Regards,
Andy Shevchenko


