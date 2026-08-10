Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D043AA4F6;
	Mon, 10 Aug 2026 09:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786352411; cv=none; b=QzARuNQvaYJpHGVBvMYGBfbWVmQxPN5RR81iMUdIxWYKtmCTAnK6Rl3xoolOn8QRaoNTdXiXaMdZf8y83olaGAMDGUCQwxA2a3vSN+1aSd5q25+ebLKLhKSJl6bPqnmrLbhqQPPvrGvdr4+oxrKydACF0O8PB1L7bWL+0Z2gGto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786352411; c=relaxed/simple;
	bh=f9xBgsQ70irpRMjIC0ZCcH6v1VxV5FpTqpl7QnHtPxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4Dh7H69ffJV7QM+Zj2QLoGh2Z4mVEgpBbowep5LxszCL899RFL+HExSXg+URaM0IkUnQrVUgk69QY4UK9Rglr0CVq45CR4e8yhiGIdNZITt2IvKcqp2Qc/NyQy7MLl43BcehQw27VeVFi8UFgJlIQfYJhAk82qRvLEAT77+N4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TZrZ/dDg; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TZrZ/dDg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786352410; x=1817888410;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f9xBgsQ70irpRMjIC0ZCcH6v1VxV5FpTqpl7QnHtPxI=;
  b=TZrZ/dDgxMx+O41mdnEsLc8QtRHJsMWL7ZgCN9trt2xqFTuYjVTj0cho
   feSHIri0l7JbBi2it15SKnHXsUHyojTPbU5J9gzWcrSG2JSZ7ZHDCLJqR
   vrXynQor6hF0DIpDu7VuLuwnkE/3Tw+3GoByb6PljZWcNeXrNOl3iUIAg
   tB/kgQKXWXBxXfMyvtP68YvbW8IsGvJMk2ratfuWhzhx/Xm7HMJ2h3TMd
   Dg9Uc8U8LgR+YDogtCmSK0m6HGn8fTpuBapfQ1rR89Kl5omJ5wmtU3ndS
   tI3IyYy4kelHxbqAHy3mlkpsvotkPAe4NvNdkGk6+bw8nwkoDO7J5mY8B
   w==;
X-CSE-ConnectionGUID: uPZc4wEnTqmIyJvGmFWYgA==
X-CSE-MsgGUID: OHgw6NZCQkukG+WlgyHjFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="98374103"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="98374103"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 02:00:09 -0700
X-CSE-ConnectionGUID: ZyxJ4HHuRW6bKGjRhIHZTQ==
X-CSE-MsgGUID: M/NIvVepSsGRiskw69oK4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="263599639"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 02:00:07 -0700
Date: Mon, 10 Aug 2026 12:00:05 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Yash Suthar <yashsuthar983@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: accel: bmc150: use IIO_DECLARE_BUFFER_WITH_TS
Message-ID: <anmTFZkbbSqZ-5CY@ashevche-desk.local>
References: <20260808220236.421832-1-yashsuthar983@gmail.com>
 <20260809055442.434972-1-yashsuthar983@gmail.com>
 <20260809235934.6045eab8@jic23-huawei>
 <20260810001852.6afc2c2e@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810001852.6afc2c2e@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 10, 2026 at 12:18:52AM +0100, Jonathan Cameron wrote:
> On Sun, 9 Aug 2026 23:59:34 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> > On Sun,  9 Aug 2026 11:24:42 +0530
> > Yash Suthar <yashsuthar983@gmail.com> wrote:

...

> Actually no. I've backed that out. 
> 
> Given the data alignment is fixed, if we were going to do this it would
> be clearer as 
> struct {
> 	s16 chans[3]; //see later, I believe this should be __le16
> 	aligned_s64 timestamp;
> };
> 
> But that is very similar to the structure that follows immediately after
> this, but that has __le16 chans[] 
> 
> So what is going on here?

AI slop?

-- 
With Best Regards,
Andy Shevchenko


