Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9640D37B00C;
	Fri, 17 Apr 2026 07:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411311; cv=none; b=iiFS7zrJEn6ciGjoiMtNp4gl81oSRNan3sSrfPekKL4gZ0CHQkpyMWPAkykbceXsK+OKdxJe7BrZDO4PdLVC63AWsK2vUF0LyEBmPVzivANrqNcRl4EzvBzAKg4WUFFUh36GAQsnuF5kG/iG/EgszMGz3AssXCsg6mWatk5Pop8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411311; c=relaxed/simple;
	bh=QHfYkfTgK5DyKLUULFN74kuqiloQX9YqOXY2Uec7Opg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGFbSQ3gxi/J1HdYz1SIf3iCiT3wtF64aefRAbKJu/f5ggNo1mNTwSRw7Uk97TKB0tS+0RQ27MEEgEMfrLl4mmNaFAbnFxs5ZetvMulz32gph+7a1rE0/lBPJ+/YJ8PH2gd577uHn7Nrc7J7DPBUYZmq7gs8zgrGy/Y+Inl4lPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g1wNB6Fq; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g1wNB6Fq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776411310; x=1807947310;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QHfYkfTgK5DyKLUULFN74kuqiloQX9YqOXY2Uec7Opg=;
  b=g1wNB6Fq7gWff6lcxqbzvL+PFEuI6YtgiHYRSA6WMCzphjN5Y9K+gknJ
   h8pXpdCY5nmzyceHmzkcwxYCfX5OafBiy0+zdwb8kDEt8qAVU8/qaXLU+
   /oWwJLbHFdRlVyTiytlu/+mcoxAMSLA3OoaERdPxUtGzrHckHEK3EMrGo
   s3t79QiFuUNki8sZsA6jI1AAW3vTHxRVw0BBhnAc4A+anRCk91mT1c/QR
   KHMrxpdvVTjevNJVyoeCQexI3Fguq2dutVAYlu9d6WG4LKQOQYuVWJJ7+
   BgT5/2Rrz0D8L8ExFjCyEEvZg9iYt9VxU60ON4VrznmPvPmUtBEFMHCII
   g==;
X-CSE-ConnectionGUID: +Ynuoo3bST+vDCeiaeJeCg==
X-CSE-MsgGUID: BTqKrC9bR2esdQoUlOjd2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="77123381"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="77123381"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:35:09 -0700
X-CSE-ConnectionGUID: ip/7HorXRpG2p70oWvXnIA==
X-CSE-MsgGUID: 93Z7ZUSGS6yprgrMwJWUJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="232718734"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:35:06 -0700
Date: Fri, 17 Apr 2026 10:35:04 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Junxiao Chang <junxiao.chang@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, gye976@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de
Subject: Re: [PATCH] iio: buffer: fix warning in requesting threaded irq
Message-ID: <aeHiqJ5WZp4tT-xa@ashevche-desk.local>
References: <20260418002334.3643504-1-junxiao.chang@intel.com>
 <aeHgVChKIZpz541S@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeHgVChKIZpz541S@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Apr 17, 2026 at 10:25:08AM +0300, Andy Shevchenko wrote:
> On Sat, Apr 18, 2026 at 08:23:34AM +0800, Junxiao Chang wrote:

...

> >  	struct iio_buffer *buffer;
> > +	unsigned long flags = 0;
> 
> This is less maintainable. When the assigned value is used in a conditional,
> it's always better to have the assignment there.
> 
> >  	int ret;

...

> > +	if (thread)
> > +		flags |= IRQF_ONESHOT;
> 
> 	if (thread)
> 		flags = IRQF_ONESHOT;
> 	else
> 		flags = 0;

Note, alternatively you can completely drop this temporary variable and use
ternary directly in the call. I think it will be even better from readability
p.o.v.

-- 
With Best Regards,
Andy Shevchenko


