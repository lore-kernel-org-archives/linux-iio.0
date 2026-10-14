Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8BF4E36E3;
	Wed, 14 Oct 2026 13:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984546; cv=none; b=pq6BvHRYSpCQceEVwJiEsjo6X3E7puwqr92oLQk8IjToL923rxmk8+rGK+Jd7vQfBdrLKYCybQKEtVd/we3rgT7tAfEtxPEPf7PHrBMdhvsNRqilNCAK2MSn1KChjRwb/PPZGQNRXOeIKIHyz/UTxQcMRCz+ibmruL6VXJ5BODk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984546; c=relaxed/simple;
	bh=T/XiGjYe88tj1X9P4W7VzT2m6GcV6c1hLj/8FBBIfl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfOaZXzZuwkszd4zCHKf8lA71qZMB5ID25wYPf4pQjjGpAdBN4F0KLtL7dCn428DFVLYtbdyknfP0bVbReuIHNHSE0ECoDeNwrHin3K1EfHfkGvHcSk13Ag91rmdb+Tic0cPEuNtFDfpDwmeDmEmZGweY3G5wAhJ21DUmGduFFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a/N/sXi3; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a/N/sXi3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791984542; x=1823520542;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T/XiGjYe88tj1X9P4W7VzT2m6GcV6c1hLj/8FBBIfl0=;
  b=a/N/sXi3jQ5nqurY+bmxKaIaCSf4Cv3tyPpF4/57378bI7l6OHr8a8rz
   AiBFGFQnXUpte7h47W9dhinDxq88OFsDT4FGzQCHq80og+5Jm8MH+RsSe
   Ehjp1VGW3WgK4OJmxCUvZxDvly7FRBAzMLhCRoyjxNBsy2uLoMbPVKYVu
   pVrhehTCUMKyV1ZtQWnLtCwi/tvtQT5OaL6aOIdliv7eiBwjtByUbXwGc
   /C5ZqNefA5jYYEi5QWIO6xYZ5wLXfhyDpe3Y++fHwYyT/FaKkxWzprmIO
   nI7hCbRO1lCR1Nq5y/r/2Kefg02nF1oRXYvEZUdYRpvT8L4Z9gaCUsY+X
   g==;
X-CSE-ConnectionGUID: /MQ+U7FgQdS/8zcyFRcRjg==
X-CSE-MsgGUID: XkfI7UouRJyERQKo9/kWnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="720240"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="720240"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 06:29:00 -0700
X-CSE-ConnectionGUID: YA+7TZhcQ+uoNzryGOWB1Q==
X-CSE-MsgGUID: xXabCXoMRxO3rgaO8mAd7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1504394"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.236])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 06:28:57 -0700
Date: Wed, 14 Oct 2026 16:28:55 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: adc: add driver for the MAX34417
 Four-Channel High Dynamic Range Power Accumulator
Message-ID: <as-DlxY8DNaWm-PL@ashevche-desk.local>
References: <20261013-topic-sm8x50-iio-max34417-adc-v3-0-d3604ae4a229@linaro.org>
 <20261013-topic-sm8x50-iio-max34417-adc-v3-3-d3604ae4a229@linaro.org>
 <as5F1uZ3DnOPYoWV@ashevche-desk.local>
 <ba2c6e14-cb4f-47e7-92d6-7c57312daa6b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba2c6e14-cb4f-47e7-92d6-7c57312daa6b@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Oct 14, 2026 at 10:38:28AM +0200, Neil Armstrong wrote:
> On 10/13/26 16:53, Andy Shevchenko wrote:
> > On Tue, Oct 13, 2026 at 04:07:13PM +0200, Neil Armstrong wrote:

...

> > > +#define MAX34417_MIN_RSENSE		(MILLI)	/* 1 milliOhm */
> > 
> > 1 * MILLI
> > 
> > > +#define MAX34417_MAX_RSENSE		(100 * MILLI) /* 100 milliOhm */
> > > +#define MAX34417_DEFAULT_RSENSE		MAX34417_MIN_RSENSE
> > 
> > I would rather put the exact value here as well.
> 
> This would duplicate the value for no reason, right ?

Semantically they are different, default can be different at some point, no?

...

> > > +	/* Ignore byte0 */
> > > +	voltage = get_unaligned_be16(&buf[MAX34417_VOLTAGE_READ_OFFSET]);
> > > +	voltage >>= 2;
> > 
> > The above comment is odd. Please, clarify, ideally with a reference to
> > the datasheet table / section / et cetera.
> 
> Odd ? I mean it's not, we skip byte 0 and

I don't see it. >> 2 is the same as / 4, how does this related to the byte0 skip?

> get unaligned big-endian 16bit at offset 1...

here I see what the comment is meant for. In such a case it's not odd, it's
useless. Reading the above code I don't care what offset is since it's a macro
defined constant with kinda good name already. The >> 2 is what I question here.

> > Also can be folded into a single expression:
> > 
> > 	voltage = get_unaligned_be16(&buf[MAX34417_VOLTAGE_READ_OFFSET]) >> 2;

...

> > This can be simplified, right?
> 
> I don't find this really simplified TBH, just reorganized

Triple times to have condition for label replaced with a single one sounds to
me like a simplification.

-- 
With Best Regards,
Andy Shevchenko


