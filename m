Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794266403;
	b=2mBggskTFZEOzeC1Y0cH5tciyMdXIvm5SwvygVwPqMrA6cnZSVMiqZenSKyP9Lm9t78T
	 5fevI5izv3bUkwcR8LBT054LHK/pRzqHzRfZMUq7ZoFENDhUnu/UmfunLUBphSEu2WhUG
	 j36VpLL5s7cOXgVbR1ufRFlBl2Y6GCd/8p9A+5oN8+7rBqeGbX2YeFjh3DJ4uBUJDXfHB
	 xZhUOA0tSIIExQPQsZfCNwYEKuQdJU/NuJo0RWcXGHf9AwjgVHrHaMG6CzT8ufqldARRK
	 9E9o7DGqe1r+v/2UssqZvpe2mw9p1oiRijyXdH9FXya4yTfWHj9+aQ2UCGet1ruc1dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794266403;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=xG8QHT+oPQ4nzS3cFhoe9VjDL746KBdhVtGShXs3ha8=;
	b=bO6i67Dm2wJ7b0Kpb1yk36idLMxPd6JkEIgh/zCEJszHO6+PYNXz0XOCS5TMcoz541IJ
	 oIRMtplkdqX3xXTft1VBol88K9MHiNDE0XT7eDK3W6IkeTtyNQXvsZLlYASVyruirQsG3
	 wIG8k38b163WSa5+BXOwVwanphDPjo4DzsZs+jS4slxW1JvEK1HyxHA5PWepE1/ttvVJc
	 Sr3p8GOuMPYG1hJ71VfiM+ffmYVlKcrdb9owvzp6+DMlPp0eGbjxD3ZCMANMVKrF7CtbI
	 wDJDSlrZwB+q07Y+hGcKiEPKUOSPQj/ik869jaXVWoXMUvMbFb8/o/J2GyfzyCN/ZqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=k7Ye+cT6;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98309606A31C;
	Mon,  9 Nov 2026 23:20:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98309606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=k7Ye+cT6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794266403; x=1825802403;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4SdiW0YKLT7SmKutFZL+9Aq9+GkSZhGKdLq/aN5OhL4=;
  b=k7Ye+cT6HFUUcemgPdzan9LJfIgkjZFmQHvjCark2scyR/O+/VavkJ9H
   y322wdoVisjjflC/eY8f7TSfTEcGanJym+4B/wotasbBk+vwzpiDPkI/Z
   oTcQpiLMpi6i8FOvoZ2Tk5xqehTGIyHJGi7QmczkG2zn0Q6IfKH0/TAyN
   k291vKiBylus/2YOsvSnlXaKnEmOVPxio7ubTyx96SY8hoapIrkBNrR9w
   rc57TRr8ehgW71VVTUD0ZJ8EyKRw6XKsyTQ3Nm0Sso+tpWQ0WnWIPvo8h
   0QhLBq9Ad1ZCF+04bv13NHwI0dBCcDm6f12zeKeOB2A8JrS/07Y4Ezsky
   g==;
X-CSE-ConnectionGUID: SZAO9o0BQieIDG+iMPkWDA==
X-CSE-MsgGUID: W9zPduynTNKO5ahT0MAnYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2990594"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2990594"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 15:20:03 -0800
X-CSE-ConnectionGUID: FlmBclUuSpa/cDZg+BtUnQ==
X-CSE-MsgGUID: /QbryOxGSReVt7TKEIIfvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8135492"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 15:20:00 -0800
Date: Tue, 10 Nov 2026 01:19:57 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arka Mondal <arka@arkamondal.net>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Robert Eshleman <bobbyeshleman@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: light: max44009: Report the integration time
 via read_avail()
Message-ID: <avJVHXMynrrMiSzK@ashevche-desk.local>
References: <20261109050738.93424-1-arka@arkamondal.net>
 <20261109050738.93424-3-arka@arkamondal.net>
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
In-Reply-To: <20261109050738.93424-3-arka@arkamondal.net>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 09, 2026 at 02:07:38PM +0900, Arka Mondal wrote:
> The integration times the light channel accepts are listed by a custom
> attribute named illuminance_integration_time_available. That name has
> no in_ prefix, so it is registered at the device level instead of
> beside in_illuminance_integration_time, and userspace looking for
> in_illuminance_integration_time_available finds nothing.
> 
> Report the list through read_avail() and drop the custom attribute.

Will break it user space?

> All eight values are a whole number of microseconds, so they go in as
> IIO_VAL_INT_PLUS_MICRO pairs with nothing rounded. The values do not
> change; the core prints them with six decimals, so the attribute reads
> 0.800000 down to 0.006250 instead of 0.8 down to 0.00625. read_raw()
> still reports the time itself as IIO_VAL_INT_PLUS_NANO.

...

> +static const int max44009_int_time_avail[] = {
> +	0, 800000,
> +	0, 400000,
> +	0, 200000,
> +	0, 100000,
> +	0, 50000,
> +	0, 25000,
> +	0, 12500,
> +	0, 6250,
> +};

Make it 2d array.

-- 
With Best Regards,
Andy Shevchenko


