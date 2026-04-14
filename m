Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3DD3ED5C3;
	Tue, 14 Apr 2026 16:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776183531; cv=none; b=kBtZk57HMGNvlk1Zz/o+sYQiYv0bSyfEvSXP9Pcq7z2nj5HC1FEPolXDR2cogAXYSjyBL9Kn+j/4w5g8XG41YNiBaYpWw7JHxewin+vsmdBYGKz7RLyJ8Jen/hSIro6vj8I22cQ1wrtQqj5HtqyinrWEhUivhBmdky8uYv0REE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776183531; c=relaxed/simple;
	bh=CmptJ/4vYVCP3+Cz0Iy7O8CbBmkmPE3UhAacTNc0UaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crWMp7kVv8IIc/Q8qlaVgHsraKbd1rmYWUXqdvNqg4d6O/zA9fszOINLnWOeQf+pO25PKEEemeC5ixk+8QIUjGHr9nvxdC0GlEQa4BXsIDrtbGN8THvMizhSmgE90ypuBYx8JOqj4OFl5aCyeKyxBzBUI1uQLGFTZeutccx0auQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZVeA24/X; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZVeA24/X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776183530; x=1807719530;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CmptJ/4vYVCP3+Cz0Iy7O8CbBmkmPE3UhAacTNc0UaA=;
  b=ZVeA24/XJVazR+oSNv6oa2+8VqLO2Id4YyaYICeFoImFKu3VEL+StAKJ
   hK52tV8giHP8uin3K6UpMT/A8krGki9PYd7OLtdapWIheuD8egLxQwpFF
   /OMMi/aV6A2a3e6B8iWnorbQdF5fAQQqgJ7XHAQ06Xb3nrmjAro1PPcJi
   MCiaO6dJSrDW5Vk6ovHSY4m1lC8ebfZfWy/n/2OFQdo4Q4ojPUdysGJxg
   iyv/OpYuvCfXNz04n2CKVugsFDnXY5iraE09w3/7MvPc0fFIysMslPj+q
   y7aTe2U6ZdqxWYJspGUQ1bmtLCnUIa0gjHPVAPRMkXMrxLfPeZfGjMGVb
   g==;
X-CSE-ConnectionGUID: 8N0tZUOgRwyVtXIlHksgRw==
X-CSE-MsgGUID: d2CJu00qTTe91Guf5lteZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="79733027"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="79733027"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 09:18:49 -0700
X-CSE-ConnectionGUID: seA1+QG0T3Ss6shePllQMQ==
X-CSE-MsgGUID: 7Wanz3e4TNG3kBb7haeB0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="225425490"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.247])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 09:18:47 -0700
Date: Tue, 14 Apr 2026 19:18:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Ariana Lazar <ariana.lazar@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] iio: dac: Fix passing uninitialized vref1_uV for no
 Vref1 case
Message-ID: <ad5o5OTA19UvyLr2@ashevche-desk.local>
References: <20260414-mcp47feb02-fix4-v1-1-9d71badfd25e@microchip.com>
 <ad43ofFZwzEkYifY@ashevche-desk.local>
 <70eb71c1-d239-4618-a12b-e64fff8e54d2@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70eb71c1-d239-4618-a12b-e64fff8e54d2@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 14, 2026 at 08:21:00AM -0500, David Lechner wrote:
> On 4/14/26 7:48 AM, Andy Shevchenko wrote:
> > On Tue, Apr 14, 2026 at 03:33:38PM +0300, Ariana Lazar wrote:
> >> Initialize vref1_uV variable to 0 before calling
> >> mcp47feb02_init_ch_scales() in mcp47feb02_probe() to avoid passing an
> >> uninitialized value when have_ext_vref1 is false.

...

> >> +	vref1_uV = 0;
> >>  	if (chip_features->have_ext_vref1) {
> > 
> > I'm wondering what will happen if we do the below unconditionally?
> > 
> >>  		ret = devm_regulator_get_enable_read_voltage(dev, "vref1");
> > 
> > If we have no regulator, we get a dummy one, right? What is the voltage will
> > be? 0?
> 
> It will fail with -EINVAL because dummy regulator doesn't have a
> voltage specified anywhere.

Okay, and we have exactly a branch to assign 0 to the value with even useful
debug message which will answer to two questions at once: Do we have it? Yes,
since we see the debug message. Have we got it? No, as it's written in the
debug message.

That said, I think the better fix is just to drop the outer conditional.

> >>  		if (ret > 0) {
> >>  			vref1_uV = ret;
> >>  			data->use_vref1 = true;
> >>  		} else {
> >> -			vref1_uV = 0;
> >>  			dev_dbg(dev, "using internal band gap as voltage reference 1.\n");
> >>  			dev_dbg(dev, "Vref1 is unavailable.\n");
> >>  		}

-- 
With Best Regards,
Andy Shevchenko


