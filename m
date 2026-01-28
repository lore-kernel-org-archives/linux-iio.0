Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86532298CC0;
	Wed, 28 Jan 2026 09:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769593385; cv=none; b=SPKEBpFC8ZuVoe+Fmq5F52c1kEa1hiOPyHGaXlqIWEVtcYSSwIgakUftzXb2McjDUJ6PJIq/9kXQmTd2bpni0FY8M1Cry0rV7xuaY1JqWNBASRTnjCJoJ1m36SPxOmyo3fTYTXQU+jNMcDNgW/8AI/g1kEgtPAlRjaQt+GRySPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769593385; c=relaxed/simple;
	bh=miePcFkWdAQfLfDTea+uOX7xi976vML139H1+aBqkyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhlS/OZpXkEL2sdPPWzDWWfMetics6hkwkksLDeEQw4jXF1/n8DTMnSuYLQiSGVAxI1I8Tl01CQ+IbgTb8pOKH8Ui5IIZTiwvBv+PWkZSfO0MYJI5sTTOXmAtGmiXUslRtsRlSr0SslVc8MYqbb/B+UJn12AxHziSlIEfsdO2xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JjV/zUl2; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JjV/zUl2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769593384; x=1801129384;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=miePcFkWdAQfLfDTea+uOX7xi976vML139H1+aBqkyk=;
  b=JjV/zUl2k2TOlEyayD/BpniIHu0C6ouJiigtH1HXJehvtTNAyA9JzfdB
   C0zFMkOYqTH8l5pD3fzwXilaf/at4U0NawtyAm1sLuwvfbH0HVMTWAIlq
   8a6HviCwlEzWq1DnjGAZfJ66vU1obCT6OwvLv+ilaGKiq1HMkZzl0ao/l
   sMR6g1UGxUc/1HTlSk+Kvrec70EncTLoYZq/goU2m6nnVRsNL8hFpWjsu
   7hNxQjj3TnQzLxy8OYvldmB5oB+AhG3Ni3XtTkD16QRnsPaAGR0mkUDi6
   1BFDcJN9XmdCNEEYbQmtymjjpv/61E+lr8ux1Ah/AcdU/AlHFNklvxVra
   g==;
X-CSE-ConnectionGUID: +EtSkYEgSS2YeD9iQLBYCw==
X-CSE-MsgGUID: NqvzslxoSvaDX6s5OywCJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="70701474"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="70701474"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 01:43:04 -0800
X-CSE-ConnectionGUID: yv5NKxYQQ/OmwQos7EoG1Q==
X-CSE-MsgGUID: Sheq1nArSrCK2PPuW9efRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="207467238"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.196])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 01:43:02 -0800
Date: Wed, 28 Jan 2026 11:42:59 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: frequency: ad9523: correct kernel-doc bad line
 warning
Message-ID: <aXnaI6B3panV7QW3@smile.fi.intel.com>
References: <20260128062539.404595-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128062539.404595-1-rdunlap@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 27, 2026 at 10:25:37PM -0800, Randy Dunlap wrote:
> Insert a "*" in the kernel-doc line to resolve a warning:
> 
> Warning: include/linux/iio/frequency/ad9523.h:47 bad line:
>  LSB = 1/2 of a period of the divider input clock.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

-- 
With Best Regards,
Andy Shevchenko


