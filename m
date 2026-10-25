Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792962369;
	b=i4pL1qsveT6SD8M1QulKgq6YFTM6PE7xPb/8sqyI6lCkGkMw/o29M/ggborxmjWfMvIT
	 8pftGFg91hmX24WeveZxOyIRxhqcwBAIGEHxmMuicfleP4Wn7FxT8wbDHf7qSkiXtoJJ0
	 vwdVir2RPRo7vrBGohOHcfAzdGTTHRgCkhwVwF5S0psCm+Iy04QfwpIWILZgc+r6My8os
	 NzhH7Wo0CHYcx4VV3dGeGErDFq+6lE3Z3jWv6Wn/drKAn3kG3mtxXKk2dnzEvRuA5gTm5
	 P6Gt7YL9XiPPHX8BSBIT8X9tqrz9pDuNedg+F0+QfiB17JuYIlwJdiYqaq8szXpDITA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792962369;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=6wD6ViJZIX7Gac7Zcx13IxxK3neW9bpvdzGuV99IOA8=;
	b=C2OpFeVE9U5FSjFnuEJDXArnSPX9/5pMusUBZLR6FA5smtZx3r01yswKPJ3/tVREHFQC
	 stc6JzeP94avGaUbQhvgGYYk1a/czIDGtn0ZYEz7SWVG9rSm+2o6ykC95mTNKCXDPVl7A
	 9GbV4BZ7WFVy/FaDxq07eEc2k9VpJyha35gT7uGbRgk0vEmnx9gw4wFOMPSoyhsaPdaTs
	 Z+GcaYe30OY1exQph3uuWIuiazBK5xIe1psjFHx0c07rjodRUQSS3v4u4Z40Th9rSFUx4
	 trOklS0tq5rocwWjZavarxDocBSd0JIYmc8fmjMh4OZZgAv1nBbV4vBnRP34VpfMQQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CUZexOG3;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85195606A31A;
	Sun, 25 Oct 2026 21:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85195606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CUZexOG3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792962369; x=1824498369;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MzMOxRbwyaLOZeW+tuhICcRCWldoOO4jcl9W23pMIIA=;
  b=CUZexOG3Vp1bYVqVAfZLbagLqw7h8IiY7pfoXrk825e4MeGCwT1/UNsg
   HQtLtoS4ruOE26zl1e/mENQcqSNrVs1qHj2L4Coie1uON/gVVOnYmYyIb
   igI6zWbLZHZvUKu4kuL3FoV0xriRxrmoq3xcdlKV1sjbMoEeuwMppbg58
   yBksxyqWYTYeMcV9X96JY7slyzgrytbuBmjSZv5eNCkGkkijXhS0gw2gs
   EhD6ohoNahfT6Ombt53cRQ9yRi76MRKcFEdzJlRQmkju9jDZlVwzpUL8y
   3fWQ/49XbVlLkEwCjSY7Az39GGwR9Q+aTfBxXlt61+AA4jnXsuGtGKdiL
   Q==;
X-CSE-ConnectionGUID: /SWS+8gjSFqQFLCieRVwgw==
X-CSE-MsgGUID: QiEt74U9RQqi+GMx/jkbDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1523316"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1523316"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 14:06:08 -0700
X-CSE-ConnectionGUID: qW4PMKpYSRKWyjd03f+JWQ==
X-CSE-MsgGUID: OAsvGWH7R2e7TuYVgDc09w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="4451921"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.10])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 14:06:05 -0700
Date: Sun, 25 Oct 2026 23:06:03 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: raffaele.tranfaglia@gmail.com
Cc: Rodrigo Alencar <rodrigo.alencar@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: test: iio-test-format: add test case for char format
Message-ID: <at5vO5kLgVj-nWUW@ashevche-desk.local>
References: <20261025-iio-test-format-char-v1-1-e2c208f90e87@gmail.com>
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
In-Reply-To: <20261025-iio-test-format-char-v1-1-e2c208f90e87@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Oct 25, 2026 at 04:59:41PM +0000, Raffaele Tranfaglia via B4 Relay wrote:
> From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
> 
> IIO_VAL_CHAR is used by thermocouple drivers to report the
> thermocouple type, but iio_format_value() has no test for it.
> 
> Add a test case that checks a single character is printed followed
> by a newline.

> Assisted-by: LLM

Already outdated tag, please drop. Instead mention the AI usage in the comment
block (after '---' line).

> Signed-off-by: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>

...

> +static void iio_test_iio_format_value_char(struct kunit *test)
> +{
> +	char *buf;
> +	int val;
> +	int ret;
> +
> +	buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
> +
> +	val = 'K';
> +	ret = iio_format_value(buf, IIO_VAL_CHAR, 1, &val);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "K\n");
> +
> +	val = 'j';
> +	ret = iio_format_value(buf, IIO_VAL_CHAR, 1, &val);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "j\n");
> +
> +	val = '0';
> +	ret = iio_format_value(buf, IIO_VAL_CHAR, 1, &val);
> +	IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0\n");
> +}

Add non-printable, special, et cetera test cases.
Make sure that IIO_TEST_FORMAT_EXPECT_EQ() check the entire buffer against
poison so we will know that iio_format_value() in the case of IIO_VAL_CHAR
doesn't write more than it is supposed to.

-- 
With Best Regards,
Andy Shevchenko


