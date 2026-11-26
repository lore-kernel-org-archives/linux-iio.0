Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795701001;
	b=hY45rBMAfFitF6cof03wxASQS+Os7JIU342K+0/3TLPdzsXpdGbK3k8aFXQwppJYX+af
	 fuPw32MADP2k9rKezw52xnH2finp3VjvrhvZWDFP3j+CytQSFkyzRuyHAKA/+O10SG375
	 93RQ7dh8eBY2CusWtLn9n3wiwYi9ZyDDEHvEErexNzD142WcPezMlg6zLFSpsOkfTGCpP
	 O2IaHZBeFoiiVfA1C9HTevXAPMkTUfrykEazo+9IcFGbzg7OnOnFPrBJlVkvNhdS4XYqO
	 /QlJ0Fo86xSMjLy+oqd2KL7DvuA/q+b9IIirA5Vwp59znFcLZ5NE7u2v8tYpPsMsLfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795701001;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=KfKv+gom4Vfyy0XIcPxap9vzEq8Eny63gPvQeJKZAGQ=;
	b=w0ZMpwzjLDi5sELU79ZEdxLb4cgOSLh1sxL6u1QvnRI2ob5PEXtlKX/3vctgNjOc5G3C
	 ppObt6/umyo79PMR3/678SBRd8aYf/NbIoHNx3ZF9msGMuAdnXZh435tFVkNWnoy0oFbw
	 Vfwc8/LesgBOaJYgrngEX+g4yYxWY9U2NocAqWypBl2o5aP/kTecs9EZx6ikC1CG61BKk
	 8CWCWZZVH4NykvE72ZJzRtBgfpneCpXKbHO29mvsUnIYEGq2ysGvU/2Ut0fug4RHTp1EJ
	 hXusFYTWrDmh2lXbKWa5Axha7QVgW+tsAbVjeAsssTc5BcWHV0eAy85yW9F9p3HfN0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="hg9Hx/dO";
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79C8606A31C;
	Thu, 26 Nov 2026 13:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E79C8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hg9Hx/dO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795701001; x=1827237001;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=urS5pNA0Hqd4JZRNanAoPNZfU3nTVQSHy2lbSowFCvA=;
  b=hg9Hx/dOIpvDNp3Yi3qFsDLsC7LNBHVOjvE3Cu3qwq1pReqTCs5wddGb
   mgULkgdbiIjGgXk74dNDI6JWwKO0D3iutNVXQEeCcVyPPpPCBgpMg96cm
   iSgC46JAptPg8rjhPrjhVwPLL7OVEnI3Wwv2/31A7jLX6d8fhJy9Lc+Ny
   gOZyoO74YQviMH5yCkHL7R8SXyuRQypOEswfgXzGFfTkrh9zeFIAfWarN
   sK3xShGXO15CV1M35Yt8MjdvAlrek05KuDGH8KSZt5POhqvswZi5Z2FYt
   nl0nY+KeFfy+Xqb2+hMNNz5UZPDik1tXFzq/+ImO5p80nrlpUWbfq8dmm
   g==;
X-CSE-ConnectionGUID: dfLv4ISVS8qYY8d4waZn7Q==
X-CSE-MsgGUID: FcoxvGBCQ4yAtu9d0gc/lQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4567239"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4567239"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 05:50:01 -0800
X-CSE-ConnectionGUID: hoqPHfelTDCUAMsDBwCpsA==
X-CSE-MsgGUID: fyJST6irTiuFDa1M+Hqbdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="12208936"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.208])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 05:49:58 -0800
Date: Thu, 26 Nov 2026 15:49:56 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] iio: pressure: dps310: use time unit macros for
 sleeps and timeouts
Message-ID: <awg5BNdDDHunJDj2@ashevche-desk.local>
References: <20261126121331.10438-1-zoone.rupert@gmail.com>
 <20261126121331.10438-6-zoone.rupert@gmail.com>
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
In-Reply-To: <20261126121331.10438-6-zoone.rupert@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 26, 2026 at 02:13:28PM +0200, Rupesh Majhi wrote:
> Write the microsecond values as multiples of USEC_PER_MSEC, like the
> poll timeout next to them already uses USEC_PER_SEC.
> 
> After a reset wait 20 ms with msleep() instead of 15 to 55 ms. The
> specification says 15 ms, so this keeps some margin.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


