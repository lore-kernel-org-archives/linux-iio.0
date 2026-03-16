Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F3B30148C;
	Mon, 16 Mar 2026 14:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773672868; cv=none; b=IePeZSb23fHVtE9g6lqk3BFiMWXWvgVIlZhK8+iJ3kGIRMUs/OyR67YjDnkMOlTHtf8hyiHcbWm76mUqgYNiCBXWHablZxKI3Xz+Wtis7fH61ATK4bDFEkWzSfP4K7NpHbRwNBXsTejVWe63cuQWAuemvpWyqvMxAT+8yFVJXHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773672868; c=relaxed/simple;
	bh=vf3mVA+XrmOzSCd0GVzyTmwLAAd+uL6rxRIxQ78+ALo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RrI0ePLU+oEQbyz6r0HU4Ql2pzsvSg5D8zTpc28P3Wj8gSn7bDbL1omKuoj433yca1Jub9Mc19EqnhMzbcRnhXoj6Gv5NhsnkAFGD6hrheVf4rgqmgh15RNgHvtJfMG0novfE7IMvdaqFLPct8AvE1w5k4Hr1cz3BDQ/IfLRgI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xe8SrVyF; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xe8SrVyF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773672867; x=1805208867;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vf3mVA+XrmOzSCd0GVzyTmwLAAd+uL6rxRIxQ78+ALo=;
  b=Xe8SrVyFr99iEv90wZ2iI8Rc5BxZe+lb6C+A/Z1YrNl2TtaB1Y3MYA2e
   0mv7oTqGYmPkz9zmBhS40bevKYCpAKvygf0tEOEvHhUbRNDqLXj4d66DH
   I0EoYoRZfSpGvqhv45j1+Qp5rPwarJYU4ZonXXxz3KJpOw7ULXuVB7584
   d3z66gL3NacXFmeLuQjOQSLLzOykdM8mnXC27zMHW0Vi8Qv+9pCK3qOod
   QVHymFpSMsAxINhqzo1IDPun4EDvNZbgr13uU3DOTsHbwa2ihH1sAE2wE
   8OL+PpkeIwo9qYWkRRjIxk656deM2c/CDtT8QZZ4kAn6hAls7nBHKcd/p
   Q==;
X-CSE-ConnectionGUID: XiHQYmWtSWeRdl90yMFIzg==
X-CSE-MsgGUID: 91CAbB3eTpqVWwqFzcw+uQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="85318574"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="85318574"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 07:54:27 -0700
X-CSE-ConnectionGUID: XCNAlw1ARTyKp5PPog04vQ==
X-CSE-MsgGUID: IrOJmf3+S3W4YqOQ8yYq7Q==
X-ExtLoop1: 1
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 07:54:25 -0700
Date: Mon, 16 Mar 2026 16:54:22 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: imu: bno055: add explicit scan buf layout
Message-ID: <abgZnpVPfKxDURzv@ashevche-desk.local>
References: <20260314-iio-imu-bno055-repeated-element-v3-1-2baca42290de@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314-iio-imu-bno055-repeated-element-v3-1-2baca42290de@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Mar 14, 2026 at 04:38:25PM -0500, David Lechner wrote:
> Move the scan buf.chans array into a union along with a struct that
> gives the layout of the buffer with all channels enabled.
> 
> Although not technically required in this case, if there had been a
> different number of items before the quaternion, there could have been
> a subtle bug with the special alignment needed for the quaternion
> channel data and the array would have been too small.

This looks good to me,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


