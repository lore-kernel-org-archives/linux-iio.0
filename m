Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706752;
	b=M3eqaBuyVuRmrqB6SXQ3/6Mm9MPZD1OhHwXafSi0gRiUSULMStExgFkU0PqoVxISBgO+
	 l8s/9T7Bq2L+U4K70dADyFOZiNmxvY3R5Y2FWduhYHc0LuJ1C+PXcsIjXb5eM8q8rvJ+6
	 VYsGWJxHJ1KHgNSqTiWB/XX5Fw43oqXOjbZzhTtxhbB1bcMubF6hi2LyTIZEnGLCfGIXy
	 CLN2VdBo7uIMd56ByYzNfIDVL9p+Q/VKvwJB/u6q5zetoF9bI7FA42JWeKO2QIr4tGKNc
	 y9DuAOGVu2wVgxwyINI3An2sQNDi0BU6xYDvF8c+9EIsgB350x9k5xHyCEF0x3t/tlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706752;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=zb0ra8F4z1oJwV+jl/q/Ivgid5QKOvgM37fMrbY/TEk=;
	b=XLRJjpChI9GcEyQG6EksjFOWz/me3eL1CiJDN7xwMHEXd9CG0zTOcAVZv/OXlSYwpiKo
	 F/7nqhuwBVonwnbxPelpOkUbmlDz4Z1t+KY99fPOwJV3S8buwFDcuqKtZCn+wvtnFnCAT
	 /OGoNcNQQH482d4X8tLAgUVOfV0Y8CdNhg04/kok/62OWv0bopS+4qDVV39QhzoCyLFLj
	 SpAHCpqtM4jCPVogmolNPnXCnEb7IlJA9dcSCHMEb05QcCACyb5j2Hc3H6GFg6p/mWFTn
	 6cYXrpG/A8p2aeIjmE6gtCdRWSL7xB8eICQ1YVdoA8WPICJnO97GiNZ69tcQb7DfPdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kUvcUA89;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB11E606A337;
	Tue,  3 Nov 2026 11:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB11E606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kUvcUA89
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793706751; x=1825242751;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ykfe23YasqmB0JlJCK/c+B5CbBjcPOG62Ef3O9sjCSM=;
  b=kUvcUA89n3ZOr9pZQFznB94wbFLVXnCkIUJ/ePwIblG5wjk1r8g9jeYG
   iMY4f0BILFSoIbunllPVKjKcmjv/xjemXVmqWsCw4YeLvn2e9f8+P82PF
   SRgjDnG/lR+aVP9uGU1GBK2EJq3WRUjA376RS0HSLS1pmLB4d3JRH1+/n
   ZWEayBKd/jfS2IE3173jzq0s9o42CSpqBMt9a1kpdy5ERK0qqHIIvh4Hd
   WMn4DttxUoMS1kUvt+0oCKsfTAPHkOZjdtzQdST+pSlvplrwV2CiH3nz1
   LpuKwpQmTfoaFirLugBta6doHdgtuuZMYeqe/pgBfCD2EN3GtZqAJ3Hsj
   w==;
X-CSE-ConnectionGUID: nLgTqxh0QAeZ7iyk/SebvA==
X-CSE-MsgGUID: bmrTSOw5QH6GZi9fD9XgXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2456405"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2456405"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 03:52:30 -0800
X-CSE-ConnectionGUID: K5UjyLdZS5a9XPzh4t82mg==
X-CSE-MsgGUID: mzNrLGlERW291EJPQqaM9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6524505"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 03:52:28 -0800
Date: Tue, 3 Nov 2026 13:52:25 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kang Chen <k.chen@smail.nju.edu.cn>
Cc: Matteo Martelli <matteomartelli3@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Victor Duicu <victor.duicu@microchip.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: pac1921: validate the ACPI description
Message-ID: <aunK-dEwsK-X_lpr@ashevche-desk.local>
References: <20261103114115.74662-1-k.chen@smail.nju.edu.cn>
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
In-Reply-To: <20261103114115.74662-1-k.chen@smail.nju.edu.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 03, 2026 at 07:41:15PM +0800, Kang Chen wrote:
> pac1921_match_acpi_device() reads elements[0] of both _DSM replies
> without checking the top-level object type, the package count, or the
> element type.  An empty package makes elements[0] an out-of-bounds
> read.  A string reply to the shunt query, or an integer reply to the
> label query, makes the driver interpret unrelated union members; for
> the label query this can pass a firmware-chosen pointer to
> devm_kstrdup().
> 
> Require a package with at least one element of the expected type before
> reading it.  Also reject a shunt value that does not fit in the int
> range checked by the driver before it is truncated to u32.

Check mailing list for potential prior work.

...

> +	if (status->type != ACPI_TYPE_PACKAGE || status->package.count < 1 ||

What's wrong with _typed() variant of acpi_evaluate_dsm()?

> +	    status->package.elements[0].type != ACPI_TYPE_INTEGER) {
> +		ACPI_FREE(status);
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid shunt value from ACPI table\n");
> +	}

-- 
With Best Regards,
Andy Shevchenko


