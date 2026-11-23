Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461358;
	b=WfMi5btYBdoNTpSb8hKmDf4lInqFhQLB4cTTFIxes1+zpecUVIeUrea7H7Iy9SvfGIKU
	 E9kZ31WgXJgwBnUVHuRcPysRhlnhYq5OE7sH231exlCfjjCVb5DAB+O8ZhQSHSn7UwWCP
	 zSPPjqmOI0maE2t6+xc5pKGckI+3eGgF8UYYQUCPw6PyFNaIBrQZwhcoxbxiBdiSUUNW1
	 8R2AhFa9NrGzFFmvMLOkqIrp57JYVWrqXxjQ7gkWONU2rQP0w/R0L+BC/gebk7YOGDp/A
	 jw+MLf3ir635+8led8PUDaijSxzAawGzHSuyhqxJUtB02sIt+Eu0mss3Hif6zcIFI9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461358;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=qAs74jBfCRNPtI3AOE74mg6KQR8ffuqRFJJYUzByJPM=;
	b=VaMCIzRaTV82mR/aWrKPEYw4Jk/zdLNESynQIx/gikNHh/kWEFjItiFnEffIjkcQKlM5
	 4q/VtbUU75G4fZes9l/rzmovUt40QoypxKetpVB9FIUinOBy3rPZCwoEAKaZFvCOP5xhf
	 Soeil62juz/AfPcNs6/e7VjQUpVb0kX3UfBT7xcCv7+jP8iZoovatyAp67yBJXYFj+/I6
	 WI6v+EqU2NXpmscdoy2IDInp9hUw57lWLOYeywofhT3U305KasfJPj+vXuvKA6uiu7YS7
	 763FOY7BmYCMRrHwb+xeCWmF6UZc2lJ4pi9wvzWjZAWJYuvrGD+VRjYMz08KcnZKbSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kTHZpENp;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA38B606A321;
	Mon, 23 Nov 2026 19:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA38B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kTHZpENp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795461358; x=1826997358;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=afgsSvKNOpdLty9LX+bzFllsXyW9QCkKJpk+kJGgG0U=;
  b=kTHZpENpmeC9s1p48wU74BoumqFHCwkEmepmkCHHnesTk31Q3WycFFV3
   QJEvRq0V6MLcD+VrxV+cRBudQwDujrUEdaEMygYHaZCz6nVQXBpQfj5JZ
   tpndBk/+iplHGRwqsofgDvzOll36Nh5aqA3gCgozzc+1gn+C/vxeS1dYj
   jzD16Rw8IK/RGxdZGVnVOzWfQkyUWkmszPyaU9yq/e3O4s6XBCPV5QDTA
   xUYzmSwb9ybitasuHsZya/GgDd5OwJ4eZwWHJa8xQw9AvAnKxbTrxedzi
   ENsxVGmesANUFjDitjlJekI4EBcsrysvhN5VT+xPMCrr/SMZFd6lKk3z4
   A==;
X-CSE-ConnectionGUID: du/Is8ioRVulDFFMJMdcDw==
X-CSE-MsgGUID: cYlNzMFDTWKwyfzmIestaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4388181"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4388181"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 11:15:57 -0800
X-CSE-ConnectionGUID: auFMWyztRaix2iCl1LUAHw==
X-CSE-MsgGUID: BFpFdJ6BQeiWglTZFhWPSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11279516"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 11:15:55 -0800
Date: Mon, 23 Nov 2026 21:15:52 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Yasin Lee <yasin.lee.x@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] iio: proximity: hx9023s: check the sampling
 frequency index
Message-ID: <awSQ6HD5Y5pBhxKH@ashevche-desk.local>
References: <20261123165255.239490-1-kapoorarnav43@gmail.com>
 <20261123165255.239490-3-kapoorarnav43@gmail.com>
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
In-Reply-To: <20261123165255.239490-3-kapoorarnav43@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 23, 2026 at 10:22:48PM +0530, Arnav Kapoor wrote:
> hx9023s_get_samp_freq() uses the PRF_CFG register value as an index
> into hx9023s_samp_freq_table[], which has 32 entries, without checking
> it. The driver only writes valid indexes itself, but the configuration
> file loaded by hx9023s_bin_load() writes arbitrary register/value pairs,
> so PRF_CFG can hold any 8-bit value. Reading sampling_frequency then
> reads past the end of the table and divides KILO by whatever it finds
> there, which may be zero.
> 
> Return -EINVAL if the index is outside the table.

...

>  	odr = hx9023s_samp_freq_table[index];
>  	*val = KILO / odr;
>  	*val2 = div_u64((KILO % odr) * MICRO, odr);

Side note: Also here, strange to see 64-bit division where it's not required.

-- 
With Best Regards,
Andy Shevchenko


