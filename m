Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794925406;
	b=Vb7v5ng49S0P5dCFx8ORJNycrrPBohRB31Oj5fXOZcs4pCs7pMnNAMnrKKxDTcT+OWJr
	 Tque96h70lSaCJ0HdoEgtaZKXMeUBS3VbIhJvs31WrgXqllSadpwiK0X5eSyaoc96LG3k
	 dfGaZztx0Ta1Y/XutVCU27qxzi3pz5NFVwQV3z+kfcfFN3+R6jmZrBku4RkaWzFDi6M10
	 7fpyRYWIBizLuk2JYAdiEoYM5Al3eNXOs6wFtGpjg4gq1Fj3gnnWO9DflWaWm2XOYxbm5
	 zOBwoSPPTJNC+vGL3kf+2n1asGK1ejSI7eipRBSu1OqVzcSiEchhEHNS7W1pc4/MmxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794925406;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=oZw2MGzQ8IiVz0OwiT75c7iVj9qPAFfh3XVzGDxfLaA=;
	b=iDWDRJnSnq2jVYliJ6FgCjCaHffgAzLlMczi9vVzpTnIMx8lS61ZUX9uAmRLfVkD4PXC
	 4LhNgSqjRGZNm10tUAvXhHY+HJpVjfIPC5Yj57ZLJW550RYcyPl7uHD/6w2YNEu+wkbIl
	 SWFQUmez96w8dWDoVMd/rtDlJkJiQYMw0WMkRtSSt5gmbCkElfJozCLWfa78jyLc6hFW7
	 4NgcEwdRXz/t0RuoqfWmFD0rjpbMf8MIE7OwDaHCs8zvCgxNd7vEu9uwhBBtBg43mrxUs
	 YSKOBpU6G06YoiNr3p6MZBxpkRjAMMaVqK1XUKRD+OfqN2HmBC6UHLzNl+t2rLrD49A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IVoXwPlz;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BCE606A88F;
	Tue, 17 Nov 2026 14:23:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7BCE606A88F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IVoXwPlz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794925406; x=1826461406;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0SCvhruwfEKBRvjoqvuX7ypR5M6kKuNlKf+m/n4V7VU=;
  b=IVoXwPlztMtFE6A8/m7e63m1VMLxnJM0UHW1oqDOJf232CeiSjw8YWV4
   8YH9jtGj1S7Cyz0exe8ceR8x9vYHVa/gmr6uIE0/rX5q7akDmYg1OOz1Z
   adHTWnHo140U5lTeTgGxMABUGh3zyAdisnOwyUelIbwtDy+5Xlq91m+th
   +mgSq+C5b9W5myDAIwEkSi3Qt4N5E/b+WTKoos1YAoYeF8XV/ChRWCXvA
   ulJPCyC6eRqcEdOAxad8xXbZeJTyvqCeKk76c2u8vHQiN2NNimHUpL5ze
   +qsHxjimZgzd13iFEzWYL4rj4/RCE9JFtI6lp8Dg8Ij6RN2ln9wzzpd3d
   A==;
X-CSE-ConnectionGUID: xL5pmV+gQPa4Vr360lXBQQ==
X-CSE-MsgGUID: y1/nek3oQDKFIu69Wi70+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3804208"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3804208"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 06:23:26 -0800
X-CSE-ConnectionGUID: H0Cg++A6Smajjab1DEtR/Q==
X-CSE-MsgGUID: FNCTtjpoQFqyBnfPm3A4Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9922167"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.254])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 06:23:23 -0800
Date: Tue, 17 Nov 2026 16:23:20 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: bh1745: fix 16-bit register accesses
Message-ID: <avxjWFUiacnYrfsJ@ashevche-desk.local>
References: <20261117110327.198084-1-kapoorarnav43@gmail.com>
 <avxi4BBJ_Ztg-aN7@ashevche-desk.local>
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
In-Reply-To: <avxi4BBJ_Ztg-aN7@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 17, 2026 at 04:21:25PM +0200, Andy Shevchenko wrote:
> + Cc: Matti (even he is not listed as maintainer) for possible another pair of
> eyes and/or having an answer why this was missed at the time of the driver
> submission (from my perspective this patch is correct).
> 
> On Tue, Nov 17, 2026 at 04:33:25PM +0530, Arnav Kapoor wrote:

...

> >  #include <linux/bits.h>
> >  #include <linux/bitfield.h>

Looking again at this, I just realise that we also need

+ types.h here.

> >  
> > +#include <asm/byteorder.h>

-- 
With Best Regards,
Andy Shevchenko


