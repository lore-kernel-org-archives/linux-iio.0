Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793025635;
	b=Gr8lzUF+rCzb6a1bKaCNJ5xC+51WrRvTl8rMo3DjXKtq79m9hil9BXKAxPamFEtVsFDb
	 ff7N6pip6RlNMe8QDY0lXpgXYHDrtZK2r/jYgYgpeIGMUPl3VWsHq44LmC8BJwmj+jy3e
	 RaRn5cJmgPe/Fw1ocSLg/A70f6DYAkNoavVzOJZaJqJg8yhmiYA2jF3LoY5hvSELas6yP
	 9CqjXq6Kdt53pwkvbuVzLmrskEVXWwSe37I/nw4gbsNb0tl9JJflbGKGAAICx2RYwQxeW
	 b8iMSM4RxsmRHAF9ZNtpQ1ZSMR/lToIEfmipLnvTCiveGGxRxb3+AXhItd3b/wfL5JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793025635;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=F5us/NfKXPDNTHhAYC35aaKem6Di7MpGF6aT1zqz7t8=;
	b=rD+gX1OLFIz/iFvcbKauAqJe+YrqPJ3vMO1nj7hdI/mdZRvJKOMgtuqwxyuZ0y2nnge7
	 v76sduHkO4TdVZZyhnxg46JC4HIVTgGmd771mePYtRCcjDTKQBcHRLjtz+0CKlDu/xk6H
	 Esul27zEQz19DYoarw3I2CZLN3lMxNGnslKH6spGOnZlaleDXKZn02g48YAUfNtCZ1hH0
	 NatxV8IZRfkWlUktoTCP6ZINd1hthSIJ23getZmNg1ODdVx+OkuDJXX9WRjcytF3aZAPp
	 6b+rgRAqErPJKKIVsdDIlLY9ZvhgkAJSnHdT/aHpDy18elWIonQMhc4Ke9OjOZMGVdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=A0Ni4yu+;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0781606A31A;
	Mon, 26 Oct 2026 14:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0781606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=A0Ni4yu+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793025635; x=1824561635;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6jc8Jbaf9Kdvp5Op6EZFBAdH72w4QRhrxSuuw3RIqFA=;
  b=A0Ni4yu+4k+lHW19MqYPl3KiDVIOb6ThhtBFKOLZ/d2K1OMYXdLByhbM
   RoBIyrW9/x4tQ6VkgD5JvBKgxcU46bETDvA9wEIJMK/SrEPg61itn8+mi
   qGBi031/DwZ2TyuHQxLzWVvhwzy0WtFcbN6z8jZkl0zNghG4ZGAdPo1bE
   gaRbQCe0XvbqVd3YLtfw0U7l0mpWHOS90JPl8vsAi9bbJHKSxIndpJWl/
   IJ7kAvrnL1e+GkY22bT/bZ8GOc+eDKJjjXTmljAHaD3MGtxdPej2kqhf3
   JmU0ANaOcy4956jHKFsAlLnreIUOXJniSYQzPP8+kLeay6uESVHVD1PJ3
   A==;
X-CSE-ConnectionGUID: Sa+Lz83GSzqfrkBuhtYLzw==
X-CSE-MsgGUID: BkdATaWeQG2mV+W8gpFhqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1571176"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1571176"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 07:40:34 -0700
X-CSE-ConnectionGUID: UdR2FaPCTb+ZtJWssi7leg==
X-CSE-MsgGUID: fXaTc6KjS9O2IqiUWYzQ1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4357913"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 07:40:32 -0700
Date: Mon, 26 Oct 2026 16:40:29 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v4 4/6] iio: test: rescale: compare scales against the
 precision of the output
Message-ID: <at9mXdRhiM-9TVyg@ashevche-desk.local>
References: <20261026-e-notation-v4-0-a366a6d14d57@analog.com>
 <20261026-e-notation-v4-4-a366a6d14d57@analog.com>
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
In-Reply-To: <20261026-e-notation-v4-4-a366a6d14d57@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 26, 2026 at 08:54:08AM -0300, Rodrigo Alencar via B4 Relay wrote:
> 
> The scale tests format the rescaled value with iio_format_value(), which
> prints at most nano precision, and require the relative error to the
> expected value to be below 1 ppm. Both strings are parsed back with
> iio_str_to_fixpoint() at nano precision, so for the small scale cases the
> check only passes because the expected value, like the formatted one, is
> truncated to nano. For example, "0.000000033594" is parsed as 33 nano,
> equal to the formatted "0.000000033", although the actual error is about
> 1.8%. If the expected value were rounded instead, it would be parsed as
> 34 nano and the test would fail even though the output is as accurate as
> the format allows.
> 
> Parse both values with kstrtodec64() at a scale of 10, one digit more
> than the output precision, so the expected value keeps the digits lost
> when formatting. Scale 10 is the largest that still fits the overflow
> cases (about 2.1e8) in an s64. Compute the relative error with
> mul_u64_u64_div_u64(), as the product with 10^6 no longer fits in 64 bits
> for those cases.
> 
> Then allow a relative error up to the relative size of one nano of the
> expected value, the precision of the formatted output. This is 0 ppm for
> values of 0.01 and above, so those cases are checked as before, and it
> accepts the formatting error for the small scale cases.

...

> +/*
> + * iio_format_value() prints scales with up to nano precision. Parse values
> + * with one more digit, so the expected values keep the precision lost there.
> + * Scale 10 is the largest that fits the overflow test cases in an s64.
>   */
> +#define IIO_TEST_DEC_SCALE	10
> +#define IIO_TEST_NANO		10	/* one nano at IIO_TEST_DEC_SCALE */

I would put them as (9 + 1) to show that actually show that "with one more digit".
I also don't follow the comment near to the last definition. What does it mean?

-- 
With Best Regards,
Andy Shevchenko


