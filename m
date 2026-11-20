Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795168154;
	b=Unr2wDNP1SpsMG/OYznP/WPCXIfPqtFQIajmBRpawkEwBvwWaivpkRnorenQ0/lYJd2U
	 Btjy1w4b61ULL1gAyeOqAi/+jlkRGISXBG9RLGIThc79UhAl8OqPm/sYjvT1UK4pLH7Bw
	 Yu+a3/NiE5gyZZ/d+5PKbTf2MCGkgU97oidkb4xkGa6+HOJO+Rr0nvu1FwYYxdt3AYdSf
	 yDVBe8BvE4L8LEp/ON0z7ghOVHWdmLm0hbHqyl7sdt05CLZkW1+9J/vCC3llTV3Mj7R5z
	 xOUMFivOtnNxDs+O96COY9wdch8AcvACMPJGz81AuYpbjanUt5FqyZsYE2mh/NQEcqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795168154;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=zkvLKIiosUV0d7XChOK0Fd8QeJ73tgsFN4rutaaKy3c=;
	b=GId9RGSWtj0D9lrN3AbJlFgBRFR8ttKx/YQXTlK6ex6t/R88dgYcha0pWI3T7vMsHUfP
	 heYi1qz/dAe7C9/Mp2DL7/tR6dan0pALq63Yrnjpu9odsr1A127ENpZdX5XnS+j4jkmWP
	 +4EsdS/F3n8C6HDYTQCzgTL39L7953URF7/bNR0zd2D3fDYkI7cPRKQhDIOgMKPZPAiAf
	 szsVMB3F2Km1sE/oRRTlpjGYAmYtcWje3duWTx12pSM2cHB1Y1F53jDjxwiLn5Y588y/Q
	 5fPi2WuyBoSluJmGx9vsHFl/IzYiRxWnE9AwArAZMMlWwuJKrJSIkI601tJh9EseyqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UZFhqPT0;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423F7606A320
	for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 09:49:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 423F7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UZFhqPT0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795168154; x=1826704154;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=UqF0VYK2YoPZz82eoO9FWeGbw+ye8dZ1r7B+PiHzobE=;
  b=UZFhqPT050ZhDjpPDsJ5+gqdb/yP2zGd1DivKZutiNraULck2IP5etpC
   OrrDBt8Gnj0fbhPt7uezMVw1IIklsaK1qWXz0MA/KssYm6dKJe47PerpG
   8CMpEO5AzAZaIzOHA1WglgmKDwl6HUC8kWniMt+mj4kDlLymfvyPPeXXK
   3A7uUNltEbEYs9V3EpuyPFk5g5pjwkdc9g4CEDACK1Vyg7MWotdLfL4aO
   UA18kkVb2/vvnVVAgWlYhbOCnBHno4ySJioQAh1qOzYOkk/NMi6zjp1Xr
   pCBWmdzeLckU5eElUVnIozyOcebGnLWvQTO+tjmbiITObPhS9Pd4XLdAa
   w==;
X-CSE-ConnectionGUID: 6yQ44zwTT+6xHmXNgEyCMw==
X-CSE-MsgGUID: //ttRBLsQhq1zzaK8iFrnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3927634"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="3927634"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 01:49:13 -0800
X-CSE-ConnectionGUID: JIsHjqWUTMy/WeJGpB5jIQ==
X-CSE-MsgGUID: 4eGZd81tRESgG0uY5m+/Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="10739810"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.218])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 01:49:11 -0800
Date: Fri, 20 Nov 2026 11:49:08 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Oscar Alejandro =?iso-8859-1?Q?S=E1nchez?= Lucero <aleszlucero@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Marcin Malagowski <mrc@bourne.st>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: pressure: abp060mg: Fix max pressure value for
 abp001pg
Message-ID: <awAXlEUSlbFlNSYS@ashevche-desk.local>
References: <20261120-b4-abp060mg-fixes-v1-0-2baf026cde47@gmail.com>
 <20261120-b4-abp060mg-fixes-v1-1-2baf026cde47@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261120-b4-abp060mg-fixes-v1-1-2baf026cde47@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 20, 2026 at 01:11:37AM -0600, Oscar Alejandro Sánchez Lucero wrote:
> 1 psi is approximately 6895 Pa, as stated in the comment and used in
> the differential variant ABP001PD. Fix the transposed digits
> (6985 -> 6895) in the ABP001PG configuration entry so its scale is
> calculated properly.

No. The comment is not a good source of information, the datasheet is.
Please, make sure your commit message has a reference to datasheet that
confirms that the comment is correct.

-- 
With Best Regards,
Andy Shevchenko


