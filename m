Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792836769;
	b=KrRaZevXMllYnZmNaXf9gHWAm94VjEATgELyCBVPFPbtEOHcV8ye8s6XO5kkgCgoLDxo
	 7i2xV+Y1aq5JSLGviYQu0U16vRyqIecuvbMH0R1LE08YYbt632C99LvRO9EKlhW5xDrf1
	 WEDQz9grcNraxFkOgWO0ZD2oCW0I3Fu2VacBMbVOL8TVc4QXBnLkk4idVG74+u3AuMhAO
	 2lWjwhwAKQuVxHJ0/mkWYuIULYMLgxMLpZq30YcH1VEh/Kc+uW//9n2YisNK3mcFbVi6T
	 UZIUpT+Din8UA7Bwo5nkc3j4IEBEcHmcIYiklGqoxTsaYV+C+gudh+uqmvYhcRrCCGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792836769;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=6qEolPCd+FIDEdvDW5rn9Pcg+lhQtBbgEWH4D9yZSJc=;
	b=pAP1hL4W8lmjmPAVyc51EQGVtbkX4oCm7s3Z+l2eldPWQmaik/mDD2oSSuF0smfT+/pK
	 SLpgQu1LM9KYPC/e8pelFTVl59vsOv8fnVixjxZbBA4vNY80HwmonEt0Tb/ZOBM5BNWYB
	 09pAJFEd9cXtCSiuMuOpLSRfjnJ4dMt153tIuBZnwvb5nz/HQcIDNoBSqjz4r08FJHEwW
	 hXWlZR+qddeIOAtL6EojmVAQt/Dfya/z4alm3qDKKUUymg0lJ0wiDGtuEPIu9goVJLRGn
	 yCwGVULv7ZoyR/faQ89ntc+x7mcKBYe08nsJu7mo7dRGvZW4JQ/mtuenlZudmGLqGYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UpBtbyfD;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D85606A31A;
	Sat, 24 Oct 2026 10:12:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35D85606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UpBtbyfD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792836768; x=1824372768;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jmzw3oy5IsJnayq6obhuhIQ3HrlE0gEKvphfs8NF1/I=;
  b=UpBtbyfDoBNZ0jO+ggSjP+FCoahuQCrreUGbGPSYuHMhi7/ivnNNIylB
   YBNgi8CVfAy5G6P/4v3tKY42TTDwcGarGWVK1Imd5HhIEIJjQQgM4x35S
   PU0tEWKnRRvmt7xZwp1+c8ucDg+hVkZiqd09pstW3ii43WNY+qA2UwpCA
   0VVfaU8UX99u3ftWgKfD2KZpxqAGRCdsrJlLj/DSgyTJCBpdldEB7sSLD
   8LgFBS/ZAj4M+l9qF54UP82KFjZZpROmP3kXqjj6mD+2NdC7t2ZpioM+Z
   3USpj/tQQOLaNxXzeY3d91cHQFOuUevkZWdZB/mF5+wplc7i4cmGMQzSa
   A==;
X-CSE-ConnectionGUID: aeFSJlraQ82yBQH97eRMYA==
X-CSE-MsgGUID: eufke7ahRYueM2oG7wdCFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1598201"
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="1598201"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2026 03:12:47 -0700
X-CSE-ConnectionGUID: 2xeI12+9QAiNMSqDWYMpMA==
X-CSE-MsgGUID: gLDQp0wbTtWmmfWLXsiEVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="3907642"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.221])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2026 03:12:44 -0700
Date: Sat, 24 Oct 2026 13:12:42 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Olivier Louvignes <olivier@mgcrea.io>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: Add a driver for the Ingenic X1600 ADC
Message-ID: <atyEmgH7jqY0cM7A@ashevche-desk.local>
References: <20261024041357.34346-1-olivier@mgcrea.io>
 <20261024041357.34346-2-olivier@mgcrea.io>
 <20261024090006.00002720@gmail.com>
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
In-Reply-To: <20261024090006.00002720@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Oct 24, 2026 at 09:00:06AM +0200, Joshua Crofts wrote:
> On Sat, 24 Oct 2026 06:13:57 +0200
> Olivier Louvignes <olivier@mgcrea.io> wrote:

Olivier, I also missed the cover letter, can you make sure it's there in v3,
please?

...

> > +	case IIO_CHAN_INFO_RAW:
> > +		ret = x1600_adc_read_raw_channel(adc, chan->channel, val);
> > +		return ret ? ret : IIO_VAL_INT;
> 
> You can use the Elvis operator here.

While true, Jonathan preference to open code this type of cases

		if (ret)
			return ret;

		return IIO_VAL_INT;

...

> > +	/*
> > +	 * Powered up for good: the keys poll it every few tens of milliseconds,
> > +	 * and powering up takes 2 ms.
> > +	 */
> > +	writel(0, adc->base + X1600_ADC_REG_ENABLE);
> > +	fsleep(2000);

	fsleep(2 * USEC_PER_MSEC);

(will require time.h to be included).

> > +	writel(0, adc->base + X1600_ADC_REG_CTRL);

-- 
With Best Regards,
Andy Shevchenko


