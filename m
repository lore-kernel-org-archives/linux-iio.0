Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1586B4483A4;
	Fri, 11 Sep 2026 08:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789114870; cv=none; b=sksWmi7UootbDpXzHdtWEzlS5vMn4wxvV8PySec0nvDA/fHrlqtcgQ4A+U2dppUUGoEVOoi8JncDTBAgG/6Cf8f/0VtKViodFooVYnJhYSYEFQRgEKqWjoYj7nWp8wZRoxpwT/5Qll7Mev1VdHQhHbRuWWrFzGH7QO5HHD/X4n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789114870; c=relaxed/simple;
	bh=v3SqCyll3YR89/x8v+GFS6cTW8xU0bcAQpo9tyK7rl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGgPfPpRv9Z+mSnyDwOTU+5uBu0/nX2SLGkKgMQJASKDs8Sp6nlAFrMkbn7OHJjftOULOxWNgV6rnmQZHV7tIluX4e/mv4/mUBTHRC1AJJSNYRDQabCe5AsPp6Tq6Hi4xFrBLQNV3Bt6sAOzR1hIDuN6tCw2gdJvml/PH80KhUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YMNsm5gq; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YMNsm5gq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789114868; x=1820650868;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v3SqCyll3YR89/x8v+GFS6cTW8xU0bcAQpo9tyK7rl8=;
  b=YMNsm5gq/aoQL1Hgmq4stIN9AnfBJ8HguWp62T10PSC1MC/jzTV6TfQ9
   qEDufDUsGP5mO31+CtYexik2DJNIvSZwEI7piusWI7NzC2JVm0l9vwl+J
   lsmhd7MznPI4ZTXiXIxoU9vHs4J5fb1z1pt7lZhXs3T5l8bJjTeYZ8r7H
   lattlXa7dX4UL1YCidMoi51sOUANUChQUukuXMs0lPyoQtsizKUtM0pDd
   Ac6dLuzFmtcqQ5CN7M3YSH1d2hEd3sVo//kLEcNa0J00u7T2ARAAQirgc
   Zhopa9OBPOc9lZ/BVBdQ2ZLd00YvyO7m0wCTUuaxQVkuD6m5iPCTvtLKO
   Q==;
X-CSE-ConnectionGUID: Z7QPMbRDS8afqRG/z6j2bA==
X-CSE-MsgGUID: CL7U6K35TL+BfoUk7Qc1Kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89704634"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="89704634"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 01:21:06 -0700
X-CSE-ConnectionGUID: xPowJkcdRhadQuVTg+5xUw==
X-CSE-MsgGUID: eqJJohaZRKC8Ls6ewOTXrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; 
   d="scan'208";a="265662799"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.80])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 01:21:01 -0700
Date: Fri, 11 Sep 2026 11:20:59 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Michael Walle <mwalle@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org, jananisunil.dev@gmail.com,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v7 07/17] iio: adc: ad7768: Add power mode helper
Message-ID: <aqO565DUVzp7b4w5@ashevche-desk.local>
References: <20260910-ad7768-driver-v7-0-7f70b07627e1@analog.com>
 <20260910-ad7768-driver-v7-7-7f70b07627e1@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910-ad7768-driver-v7-7-7f70b07627e1@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 10, 2026 at 07:36:25PM +0200, Janani Sunil wrote:
> Describe each power mode and its internal master-clock divisor in a
> table. Replace the open-coded fast-mode setup with a helper that records
> the active mode, preparing for dynamic mode selection.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


