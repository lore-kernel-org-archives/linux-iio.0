Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794942587;
	b=WzRGw4ayUYj6uKAgwygjmFgGqcd3/SnHIhyFN3O/QYTM/OWqMmgU9j61IeogTYGr0go9
	 stkbXyAJcMmw+cSuSVSmUErTLYR1Dokddke30hJ0cbOgYseNcCTwuR5ZZTsKeAINwoscn
	 MYZI5I1AbaY12lKZROg+d1rVp/D+ADnuiRYBv9d8VAm8Nlbd+MOhyMn5OtxP4mzP5lGEj
	 hwYqXMuZyvyxmO5ovi4vwZzAQCWZqIUZo08rF+mpx1hqghZP6/s6SCUjbhKvyQfF/cunG
	 1HBOhc3yo8Xhm0ijQoAL4VD+Mc/vpmV2NE9jr3xsjVy+q7IuPPM9+ehe/mbqPwlLYjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942587;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=99djJjetdd6bvswpVzAEPR34uNCEOMwFtcP9/EutTY8=;
	b=FZrB/YbAsO2USi5lcEjocTTDORq2ooRf3paqpmQOz7dVt5Pi69Xl1j2lsgRjndgYTmym
	 m+ZD2JyJ9ROxCEMfsImoZo9+kZpF2KGjSOyAt9eUE9c3Qe5g/+WrN9RV4zp3wnowbdMtd
	 W2EUNyODIqtWuDpuYBqtntcfeo0SlXHSuIZBCewbYyAI8HD/kWnM2c6Ul/0lRkjKZrWWI
	 fzA734ygYZiOP3sTCNssnm1s60Fl0MOdUK1JpEwnegeD5/Ps5eJPUH9jemNkTKgV19GtQ
	 XU8cCu1AUIUEeEm+akurXIBjTp5TSG3OUElfOPs4kFWDQotY8ICewqv/h2qzfu5Cikg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RveA28T1;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F79606A337;
	Tue, 17 Nov 2026 19:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38F79606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RveA28T1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794942587; x=1826478587;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z2PIup23YXnOUw4dzxNjrnUotlSB4rZdT/oJ3YjauOw=;
  b=RveA28T1K/EfOuPlOYxOYU9iau8TnFPJ+ZvkwDB9dTiDm93RMnpAVa2q
   efez/MbPBQ2r7XVJOWJxdFdT8Ho7iObmjjc/syJHIT/VqXsTWaZKamGCR
   i2O1E0zCXBo0869q6r70jT+QANo+ySVMVosTMHl7vlarzWHb9Z0zr+B5O
   TY09O42AclhUJwaD5rR4t3p5BsnYB1O/oM0DsUd/SGRgNn3SCCNoFgeyI
   9emd3AyX1IF5imHaMNKfxffn6wGiKcw8llp5JUMvu5ZpuQkcUDF1Ev7Mf
   yQ5FmitLN9WjN7YaKrwVmATqtSPcUaeYD3QNI9j7bmB/2hC8KyIxYdVKI
   Q==;
X-CSE-ConnectionGUID: ItUlNBloTpaeK7xl1IjHSg==
X-CSE-MsgGUID: NkMMt9CTTSqZi1IfOGFKuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3770638"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3770638"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 11:09:47 -0800
X-CSE-ConnectionGUID: MhT5wEcpRM6fzHLAa4Nh1g==
X-CSE-MsgGUID: IUcAWrNOT8+L9w9XlzjjxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9808164"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.254])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 11:09:44 -0800
Date: Tue, 17 Nov 2026 21:09:42 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] iio: proximity: sx9324: reject negative hysteresis
 values
Message-ID: <avymdpJluGiOnZEC@ashevche-desk.local>
References: <20261116205320.26070-1-kapoorarnav43@gmail.com>
 <20261116205320.26070-4-kapoorarnav43@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116205320.26070-4-kapoorarnav43@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 17, 2026 at 02:23:11AM +0530, Arnav Kapoor wrote:
> sx9324_write_hysteresis() copies the value into an unsigned int before
> comparing it with the threshold, so a negative value becomes a large
> one, passes the "val >= pthresh >> 2" check and sets the largest
> hysteresis instead of being rejected. Return -EINVAL for negative
> values.

As noticed earlier not all cases might have this issue, please elaborate if
this is for 32- and 64-bit cases or only for the former.

...

>  	unsigned int hyst, val = _val;
>  	int ret, pthresh;
>  
> +	if (_val < 0)
> +		return -EINVAL;

Same (semantic) issue, you are checking variable after its use.

...



-- 
With Best Regards,
Andy Shevchenko


