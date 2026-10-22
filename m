Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792687323;
	b=LFYw2RU/z/kI82cWG9dpgN1neZAClEJ5N6faqNZUeuJ3YkgjXrjpUc2yTc6Fu1iFDDgA
	 MA5DYI77MVXrUvH7snpU1Q086DIPjYLFisiG6xvtvGLp02B2X9GAtJerFvVdgi9M+FUMu
	 q3ErrDrxD94n3k24I9TnBvaQ6/gFOzDOq8LrRCCXIP4J6vTPjZjPnRSch4KMKRAe8wh8Z
	 HHRrsXntT76Nwb29s+w9M3FFV5Uw4j9nGWxLIlmekWbKqWqE7QO49VCPrpYMLBVG+MB/1
	 5Mr1NdZS0eU+u5K4wNp3gRWNJBjv4yHrn4dcb6omR9YvjRQz2N9C+2QW2/yYwY31fuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792687323;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=E2wdDEekVy0P+07Vs6ycsqQnxnT7EjSZRxjLJlJ2A6A=;
	b=jJ4zdYi3oIHoNuUlhZmBueOw9aeyecaNrNbp6DiCNh8sM4n72tV83G5XkhfLl/jV0jMA
	 iClTspjgJyCfar2cDLtJXm7JMsWTeWOGQZaIuv5bK0o84nfeymCH4GjzWEIjVAQUevNbH
	 Unxlminsufb0zPuFemn88cGkRGT05jshyI6odZ2HnmqN+aQZwQM90hnONSprJXf/PheGe
	 M4w10xZynvkPsBRQ6eQwWY4xuZlqtlIX6vmI5P7nmxIALBMOrD6vCaZmNUK1On4smfid2
	 J5Za0kcp05eaHfv4MLRppghDuCvY3bcpkH4MbDfYcGK4u7hQ6JsyCllebD765Q74MXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lxqKsZ4A;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21295606A319;
	Thu, 22 Oct 2026 16:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21295606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lxqKsZ4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792687323; x=1824223323;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JdD/KTg8XZ2fzdF8q8aX0Q/Ay4pr03yaweqTC9tcWbE=;
  b=lxqKsZ4AMFnlgyNLtpzC7Sf9QijhO9/jCBxnbwTelqJqukPVSylHTjJL
   4/m8kui4qAJ0rtdJPRW2uPR1Ga1jQdMbutca4f3jl0i97It3K6TfYLDKo
   at7H+SO92In48Qeuo214iK05s4jUI07Vy2iXnGm5Y45QecB1HX7YmAT8R
   GIQ6rO7K1EHuxJAd4MmrcKI1i8aLIjWWdXq4F7ww28G4xTxJgXFI/AB5n
   d2KebResR8ngFDJ+LePq5jAVV8afnRXp2JCXeHmWdijYYx+vsQseFtQ19
   SUqLF6GstvsgaQVwbt5WZvfaovFob9flrL//v4s56IohThVOZfQb7VnHh
   Q==;
X-CSE-ConnectionGUID: ZR4KyjPARMSsz6pgp7AwXQ==
X-CSE-MsgGUID: hkS/f78iQ/q1Adq2fx4xmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1316639"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1316639"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 09:42:02 -0700
X-CSE-ConnectionGUID: i8QMZGsTRGW2Ilg89RdqkA==
X-CSE-MsgGUID: v7XsLAGoT/qoSGz/PSwyug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3392790"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 09:42:00 -0700
Date: Thu, 22 Oct 2026 19:41:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Marius Cristea <marius.cristea@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: mcp3564: reject devices without match data
Message-ID: <ato81kWiI4gnI5xK@ashevche-desk.local>
References: <20261021225431.627718-1-kapoorarnav43@gmail.com>
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
In-Reply-To: <20261021225431.627718-1-kapoorarnav43@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 22, 2026 at 04:24:28AM +0530, Arnav Kapoor wrote:
> The driver identifies the chip by reading its ID registers. If that
> fails, e.g. for a newer part number, it falls back to the match data
> provided by the device tree.
> 
> spi_get_device_match_data() returns NULL when the device is bound with
> the "spi: override" property, as in that case no match data is set and
> the device name doesn't match any of the entries of the driver's id
> table.
> 
> The driver dereferences the returned pointer without checking it, which
> leads to a NULL pointer dereference and a kernel oops.
> 
> Return -ENODATA if no match data is available, like the other IIO SPI
> drivers do.

Fine, but I hope we will have something to land to actually do it differently
for the drivers that don't want to use driver_override mechanism.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Please, shrink the commit message to the point.

-- 
With Best Regards,
Andy Shevchenko


