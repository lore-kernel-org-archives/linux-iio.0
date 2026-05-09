Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C62A22541C;
	Sat,  9 May 2026 14:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778338572; cv=none; b=NW3G0Oa3kccdgdUgb/J9vejHvQb/6udZeDkYdqDj2KGVQ2Yyi1jcuZ3hNUH3Fxkozovd/76VYaIrgmkb22svXYHA2E3ftADxLfOutlH9BlChf5jRb3qjfSQG2BvwYTx0RxAUUjtqZmx7nsjzKhAu1q0VXYGlexTcgnQ+jgzq1Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778338572; c=relaxed/simple;
	bh=0mD18srFz5oGXQRcHy60yAweHbafkRnFu79BrmupUH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjE2niPq10J5zQqEuZB5VFQIAItI83USnGg3OYT/UN9GfHANOhMJhz0ucSjw+JKsJHfKOvC6UrVg/QzzXr8UHyiAgV3xhl19ZHrw2IdXZH1+JtlVapClW0zq0UjouMjE4/W7Pg5URzLlC4l5gJ2MZhr8K4gjRX1Tb4POzLCq6XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A+Ntlywd; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A+Ntlywd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778338571; x=1809874571;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0mD18srFz5oGXQRcHy60yAweHbafkRnFu79BrmupUH4=;
  b=A+NtlywduEThv0eTsE1QILL/u0yiVeKMOSoo+Fxb0+aQoeC86pHu9xZk
   ofEr3kVsXeQtN1FmaRg3Af7B7fuTnHnmCa8cCRcqXpBTy5rIwV0W3rWmY
   LDghiOk+nG7uiTceMIBAeS7WkIZa9KAAL0UczghruptwZR0W5+V6Wb0Na
   WXn2RSQ2L7lm33bHRPadLR6BA/0LQJoVVtHMfskpUHFINhp2urKBbpNko
   79NaYDeQEWgwo//u6Fr0C053Sq04BNkl+U+wvJRkMvMfCk1A7mofbXAWb
   XhDleHWUjlTxjFqoX2OLwqZUXNKOmeqHla7jxW9vmcwNpIyic+FlJV8cA
   w==;
X-CSE-ConnectionGUID: lZ3Pr5mlT8yXDNHcaAwMgw==
X-CSE-MsgGUID: 2TH+cFJdRViwa0cpN1iPWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="79317786"
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="79317786"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 07:56:11 -0700
X-CSE-ConnectionGUID: sdXES4WLRqWMLy9ohXrWng==
X-CSE-MsgGUID: +WnTRi6eTOCYId41Qqhf5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="238835889"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 07:56:08 -0700
Date: Sat, 9 May 2026 17:56:06 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: jic23@kernel.org, mike.looijmans@topic.nl, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH v3 1/3] iio: adc: ti-ads1298: Add parentheses around
 macro parameter
Message-ID: <af9LBoAipzhZ9PxH@ashevche-desk.local>
References: <20260507191129.25924-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507191129.25924-1-shofiqtest@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, May 07, 2026 at 10:11:26PM +0300, Md Shofiqul Islam wrote:
> ADS1298_REG_CHnSET() is missing parentheses around the parameter 'n'.
> Add them to follow kernel macro coding style and prevent potential
> operator precedence issues if the argument is an expression.

This is series of three patches and missed the cover letter which has to
provide the purpose of the series and the changelog (it's v3).

Please, always provide that message. You can use my "smart" script [1]
that helps with that.

[1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh

-- 
With Best Regards,
Andy Shevchenko


