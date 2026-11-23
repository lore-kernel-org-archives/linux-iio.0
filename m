Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461972;
	b=XWlSgqYRz8HlPvV0ZTaeQvR4ZJjysdbo1tYa1mNB7XzwsViBg7D1xiakMAzHDpZS27GX
	 /Sm1WtVfGVeNlpvChWsWhzQeLo15gvesz5A+io0axzIoXTayb+rK6b3avnTMN1iMABEON
	 SagBT4e5eXPWhrfeQVCT49f04bBm8yrS1srOywwFkFBxSlAMgIrtS16a2AI8iO60cz4yA
	 3mu3HKObSRgt39lE9umKOe3Hvw9O90k4Z6rnyLF2hCw5V04NpNaw0XsH+jQEuBChKXWW9
	 Z50yGui9A2ICZZ0ocHF+xIvG9eugMByELnW4bWFXxPq9+GnRqN4tlaVLKWCGr61/SVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461972;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=YjcSZFIvzql0ExOJ3U+u5ipwsVhfiurClfd39n0Nb8M=;
	b=v/UA+asoXdhuCwCLkEyNEXq251eNm2wA0Eywa+tHLrsbLuTbe0NvgnU/GekJBC9Mr8pd
	 J5spJzz1pDdnBHRhImpHuBfjE9edqABHy84gx0AFuXGQ2EbbDUbIY8qZDUF2Rrq64APZz
	 DoAIdEfKYnZszDkhKOQPlIlJwDAnNCsFDuKs+HV0rOmGBECUktRTDCfMv7ajtH3pejl18
	 sa2fApwWoKUTsNITV6PcCpY7+4OwhQMyYNj7jjXr49VmTdJuvODq/FlUtezVBwBd0/fNl
	 fR2i09V1VwnUxB+aIXpw9thVnuzgvo6LrOuDwgZUMW2hbUrYt+rHr8ZCS/NoAk+zkNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aQPHE4wU;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6B5606A31A;
	Mon, 23 Nov 2026 19:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB6B5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aQPHE4wU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795461972; x=1826997972;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GzVEhTcEXjPwZr+oSMlCoQIK3KEA/n7wbtndAQlshU8=;
  b=aQPHE4wUk97G70NxMtCYGXnGIQSjHCrKhAznUudP4r82e2GZae+uz1A1
   qb2OadFXGGnVVHZXVQmivQNcvxUTAd5LWmZeAeHpUUKJ3FYccEtBtwd1t
   Smma4pumk9CJYL2taZGXGoVszYkfBH4otkHsoOtvhzIvr0SZy+gdy5zu6
   ciMavNwilzEPif/FkLn0BFRZRpLVg+T30bUVsSEu+jUHhAaztZ0L9Gmrn
   C1pDgQ3RgckaW3AP+yXKdELA7wDawxfBI7tA56LgiKnVY2jxkT4oY3cLu
   8EDXxIZ5VqXhwPskYKJymA18LhNYPrzOn0S5opk/Yds2eK9BXtJXbdLpE
   w==;
X-CSE-ConnectionGUID: FMkw8fK9Qj+L8S3cF+bvzA==
X-CSE-MsgGUID: GrfEgsBcSbahRdD6Btpouw==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4296860"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4296860"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 11:26:08 -0800
X-CSE-ConnectionGUID: AAveIKlVQSu5PcfjKt2Dqw==
X-CSE-MsgGUID: b/sca7xpS7yZYzpWAOgIFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11400313"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 11:26:05 -0800
Date: Mon, 23 Nov 2026 21:26:03 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Yasin Lee <yasin.lee.x@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] iio: proximity: hx9023s: reject out-of-range
 threshold values
Message-ID: <awSTS5G6isG9jUQN@ashevche-desk.local>
References: <20261123165255.239490-1-kapoorarnav43@gmail.com>
 <20261123165255.239490-5-kapoorarnav43@gmail.com>
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
In-Reply-To: <20261123165255.239490-5-kapoorarnav43@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 23, 2026 at 10:22:50PM +0530, Arnav Kapoor wrote:
> The proximity thresholds are 10-bit register fields in units of 32.
> hx9023s_set_thres_near() and hx9023s_set_thres_far() mask val / 32 with
> GENMASK(9, 0) instead of checking it, so a value out of range is
> silently written as a different threshold: 32768 becomes 0, the most
> sensitive threshold, and -32 becomes 1023 * 32 = 32736, the least
> sensitive one.

> Return -EINVAL for negative values and values above 32767, the largest
> value that still maps to the field.

...

>  static int hx9023s_set_thres_near(struct hx9023s_data *data, u8 ch, int val)
>  {
> -	__le16 val_le16 = cpu_to_le16((val / 32) & GENMASK(9, 0));
> +	__le16 val_le16;
>  	unsigned int reg;
>  
> -	data->ch_data[ch].thres.near = ((val / 32) & GENMASK(9, 0)) * 32;
> +	if (val < 0 || val / 32 > GENMASK(9, 0))

It's too complicated way of saying this

	val >= BIT(15)

> +		return -EINVAL;
> +
> +	val_le16 = cpu_to_le16(val / 32);
> +	data->ch_data[ch].thres.near = val / 32 * 32;

& ~GENMASK(4, 0)

In any case it might need a short comment explaining why these bits are
dropped.

>  	reg = (ch == 4) ? HX9023S_PROX_HIGH_DIFF_CFG_CH4_0 :
>  		HX9023S_PROX_HIGH_DIFF_CFG_CH0_0 + (ch * 2);


-- 
With Best Regards,
Andy Shevchenko


