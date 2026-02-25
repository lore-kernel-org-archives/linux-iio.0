Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E675230FC3E;
	Wed, 25 Feb 2026 11:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772019837; cv=none; b=oPsZCJE68WuxMwkwQamawFzC83I+YJ20YWkEWBcMYKe4PacVSM8tjDap+oneuWqlWg0IALWd+/VpUB1pprczJ18Id47NU6Q7pX3gbYWEyqRR1Hk6EUD75hUFhratMKCbIuEtW7OiHHZkG+DFBh9tvRKB1muHK2V839WZgDiaQO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772019837; c=relaxed/simple;
	bh=ZzLSbzpnsbBQLnDSqoXfja7qtPDrTYwZG1roPagsCug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQeoaG3ZdMm+9iLLBuGtSi06k2v8yiF2XTPHfHjWBPJA2JosAbVKwQ3hPeosCEg5nBTN2Ds3i/AAd0eaVkcr2QO9vM8b0b942OFglVdYtNdAOBLuAQXzr7KbbIpByRE7TXIq/rMR6uIyl99ySkein1XLnV4oK4ztwFmrrb8TqOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OLAvTzUi; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OLAvTzUi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772019834; x=1803555834;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZzLSbzpnsbBQLnDSqoXfja7qtPDrTYwZG1roPagsCug=;
  b=OLAvTzUiCnRsfKdAdhUA3E88b6cltyJBqj/82UAZ4ghEGA25pjNcGEFM
   yOpMmGUq9pTQjZaZ9TqZwKDBKQo608DW0RfvIUChM3VJKPM1f8Mwlq31p
   WY+vN3I2q1PQ/6COmr0feSlasajtizs/kQgAPbsS4CWHSUXF4tG2GK1pM
   rV9tNFQq0Zdd6ZEAAn9yuxFixqtjoi8I9TyazU2pXkpO2AyCMt8TX1wxq
   eQI+lE5rDNz3qBt1kPmh9cweFb67QA5q1eZ/rMnzymzo4YajTVd1XoPv1
   XOXnsX1IVrPLcD24L2hPoNI0cb25ZRkcK2jyJqVr1V5IE4XAc+GMeJPBb
   w==;
X-CSE-ConnectionGUID: Xmpw4X4WTXqHdlWs7P09MQ==
X-CSE-MsgGUID: KG1mj3xDT62N4ztbWjrkQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="90633225"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="90633225"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 03:43:53 -0800
X-CSE-ConnectionGUID: wfVO8pH7Tj+ysokv2mKLqw==
X-CSE-MsgGUID: lbdmligsQ/Kz2Le8geJSsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="246764624"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.71])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 03:43:51 -0800
Date: Wed, 25 Feb 2026 13:43:48 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/7] iio: ABI: Add custom data type
Message-ID: <aZ7gdO58NV6gjgWC@smile.fi.intel.com>
References: <20260225100421.2366864-1-flavra@baylibre.com>
 <20260225101806.2368391-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225101806.2368391-1-flavra@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 25, 2026 at 11:18:06AM +0100, Francesco Lavra wrote:
> This type is used when the data received from or sent to a device cannot be
> identified with a standard type and must be processed by custom userspace.
> Any driver using the custom type must provide a driver-specific document
> that explains what the data represents and how it is to be interpreted by
> userspace.

This rises the same Q as for other firmware-hidden algos, et cetera: How
can we prevent the kernel from being just a simple proxy between HW and
the userspace? What would be the point of having the "driver" in the kernel
space?

...

> static const char * const iio_chan_type_name_spec[] = {

>  	[IIO_CHROMATICITY] = "chromaticity",
>  	[IIO_ATTENTION] = "attention",
>  	[IIO_ALTCURRENT] = "altcurrent",
> +	[IIO_CUSTOM] = "custom"

No more channel types after this? Why?

>  };

...

> enum iio_chan_type {

>  	IIO_CHROMATICITY,
>  	IIO_ATTENTION,
>  	IIO_ALTCURRENT,
> +	IIO_CUSTOM

Ditto.

>  };

-- 
With Best Regards,
Andy Shevchenko


