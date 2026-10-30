Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793353646;
	b=HlwdLBxIo/EpPX2MjN8e2JK9+Mq/rTOvyVFoiv9giWrNElGs8mMffzVD+WtCI5GEL6m2
	 RWoA/8FY5QsNyKL1fEBw2qfUu9657Sn4aebey+9yNgHPuFAJ3WqTTJLi7HhYoLoRXPgPf
	 HIP4NBS3AYypMEgCr2jPBdaZ3WwT848nHPf4x7N2C2Zh+ZHOkjyf1iEP4uxuKRbTsgkmO
	 TbREfdav9kzPncd9lgHOD+Z320IuFblVodbFxodX2/G14i/L7r5JVViwhud9SMtK9Ezou
	 GhBAjDnP0PQilFMijjXZjslPouYTn8Zg2kUcZdZZ4CRuPWFvb0hwp41QNtS4JoJ0rJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793353646;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=QaZJzYnrmgn/3/+MnWVhC1pUB6YQ4dkPpe2aqBqfGes=;
	b=azpemxHAb2E/cjcpHWX8p29QxBUsSs352L9Qa8VZ9W7SvBNxC4Icq7xQrGEOqn24OFEl
	 3pD6wFv5nXgQqd5q9vWDnb9g0bwzQBZhA4aSQlOcn6kxNTE03EIZ5T/WBNtKGMVgSMnQ2
	 bJgkPBkjjAJlcrohNFHJXnVVhSRqtSvwRdVI7pppVXTzZ5XB6t9zbHrg7XTLUxTGVzil7
	 7DJ1hHBWts39gZzD9xa6GkTXqPs1L8OPKQLer5LHK1wkV2SnRte1/DBTmsq6nExOXMuoz
	 wviKYEWwkfoa/t0t6MxTDYS0w/wi7QGjplFJMyKvF9hKYnizI6WwrEU+Meae6coxzWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RYK8qgmF;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C94606A31C;
	Fri, 30 Oct 2026 09:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3C94606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RYK8qgmF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793353644; x=1824889644;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cWBxoB6m9qlpzRPldiJg4DoVUNnWvIe79hiZSg3Ps1E=;
  b=RYK8qgmFnWsXl/OstC1O+MrmBKc6wCBCFdBcoZbXRvBt0W1D04/v/9GJ
   1Tpt7fOgWRbYYqLq3Fk20/POHgLcGe5Zboo6v7B22zCjHcOGNfuZhP0Fr
   5j8das1ThucUAR+5E1LhC0YB7XasUWzYpNBtVc1AC+eFFp42u7cRmmeA5
   3p+bKAKs8elqMVP0bMMu9svz7710TY2deLA/zSbm0NW4XLWmUQeHi+bKm
   EYAZAtajNOb+VFphsJjv+WXz1cwbRC7zdj4iwOSp4L1IknFYnnBIR/7Gn
   Y2ad6CkDBhTYJd/aFGFnizsk5CHD5ZlPy7mY7U95SKYaHBbPZWk1mIeGX
   g==;
X-CSE-ConnectionGUID: COEFM0R5Td6TRZIXAYEIPw==
X-CSE-MsgGUID: b7BjjgCASD6zUiK3sVgbfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="1996164"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="1996164"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 02:47:11 -0700
X-CSE-ConnectionGUID: Co0TvGOiQ9CACnqcrqQWtA==
X-CSE-MsgGUID: eY5aRmYBQ9qhKHVYjMhA7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5520571"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.247])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 02:47:09 -0700
Date: Fri, 30 Oct 2026 11:47:06 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tristan Madani <tristmd@gmail.com>
Cc: Marius Cristea <marius.cristea@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH v4] iio: adc: pac1934: validate ACPI _DSM return type and
 bounds
Message-ID: <auRnmh6129P7WY5i@ashevche-desk.local>
References: <20261029165602.3265518-1-tristmd@gmail.com>
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
In-Reply-To: <20261029165602.3265518-1-tristmd@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 29, 2026 at 04:56:02PM +0000, Tristan Madani wrote:

> pac1934_acpi_parse_channel_config() calls acpi_evaluate_dsm() four
> times to read channel configuration but does not validate the returned
> object type or array bounds:
> 
>   1. No check that the returned object is ACPI_TYPE_PACKAGE.  If
>      firmware returns a different type, accessing rez->package.count
>      and rez->package.elements on a non-package object produces
>      unpredictable values.
> 
>   2. The loop bounds use rez->package.count directly without capping
>      to PAC1934_MAX_NUM_CHANNELS (4).  A package with more elements
>      than expected causes writes past the fixed-size labels[],
>      shunts[], and active_channels[] arrays.
> 
>   3. The bipolar and sample rate DSM calls access elements[0] without
>      verifying package.count >= 1.
> 
> Use acpi_evaluate_dsm_typed() with ACPI_TYPE_PACKAGE to validate the
> return type at evaluation time.  Cap loop iterations to
> PAC1934_MAX_NUM_CHANNELS, and verify package count >= 1 before
> accessing elements[0].

...

>  static int pac1934_acpi_parse_channel_config(struct i2c_client *client,
>  					     struct pac1934_chip_info *info)
>  {
> -	acpi_handle handle;
> -	union acpi_object *rez;
>  	struct device *dev = &client->dev;
>  	unsigned short bi_dir_mask;
> -	int idx, i;
> +	union acpi_object *rez;
> +	acpi_handle handle;
> +	unsigned int count;
>  	guid_t guid;
> +	int idx, i;

No need to touch lines that are unrelated to your change. Just make sure that
your change tries to keep reversed xmas tree order as much as possible.

...

> -	for (i = 0; i < rez->package.count; i += 2) {
> +	count = min(rez->package.count & ~1u, PAC1934_MAX_NUM_CHANNELS * 2);

What is the purpose of 'u' suffix? In case if you want to keep that 32-bit
value this might be even wrong (I haven't checked the promotion rules for the
values with suffix, though).

> +	for (i = 0; i < count; i += 2) {

-- 
With Best Regards,
Andy Shevchenko


