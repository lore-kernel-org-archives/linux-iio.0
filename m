Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D8B32C8B;
	Tue,  1 Sep 2026 06:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245506; cv=none; b=aKr+e8uNjuTrVVk0IgLc5AUbXkhF03S/g5Cqn38mZAnNq+xSWW+a6cY1sD3IY/ABAkCIIFM7ki+lu17lpK27OrsCinyI6ElsT7li1gJWEF24fd9juMO+vMROfxmMxPFL2JZIyWo3LfJ8pAusOF9bpARcgOhLSXRxmOxoERr+gwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245506; c=relaxed/simple;
	bh=EubD39YqsL7iOOzLVbICCurKyiXRQOqe+nNODXJleUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=un8y72QqO9hqDuDMekI2GYzf3z/YqkMAf1e+s0v9zo7MUzO8/uDIjGY1mVcE/ER6DaeK1ODRgoPJ+tnIEmeM1f+Plv+ufVwGtWAvdl58EeWVtvq1bmAugKkXxkVxX3qDh/gadADmPY5gVYNhTx0wPfnc3ujMY8v7FvsLL7YRlik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lpIE3eNB; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lpIE3eNB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788245504; x=1819781504;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EubD39YqsL7iOOzLVbICCurKyiXRQOqe+nNODXJleUU=;
  b=lpIE3eNB7AdH2Lm1i4+7+VLDDiY/Yg33xNgJJWvBkM9vDQpZXTIATzCp
   /8vjtmeG4bPb3gsK5Ui1Lw8gRJbHVtNBsOUVrs9okywBiKW3JDq1ZgiZ7
   t2tAv2AjTZx/kroio0R6WxL/2SZ0/WwQxxmvLYwFbME2eUuKB22UV28Zm
   DzYp4W0sygztQjK5rydfdml+os9xEf3cdYGAz3oRDm0lkvD+QfF7/k1YQ
   qG3HnNQta++/CjCRrmNa3Gc/gwLssMmv+9AjTLXoykMbNWPi/B0mKGHY8
   8Y8+WO5kTySSTr1wNwoL/uN/o+NzKCbdn1BydxurRvxBNgAs6rwYJfWcy
   w==;
X-CSE-ConnectionGUID: 7Dl+bIRcR4SvpMIM9+ElAQ==
X-CSE-MsgGUID: YZbM4usdQj+CDzNPP2W9rA==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88674813"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="88674813"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 23:51:44 -0700
X-CSE-ConnectionGUID: I50rmJ/JR1ad/nMsiPk4PQ==
X-CSE-MsgGUID: lhmhMWZmRouPT7A4jFAoTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="264723559"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.222])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 23:51:41 -0700
Date: Tue, 1 Sep 2026 09:51:39 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Chris Hall <c-hall@ti.com>,
	Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: adc: ti-ads112c14: add burnout current
 support
Message-ID: <apZ1-9WHcIynqmXS@ashevche-desk.local>
References: <20260827-iio-adc-ti-ads112c14-burnout-v2-0-00a1fab9e2d1@baylibre.com>
 <20260827-iio-adc-ti-ads112c14-burnout-v2-1-00a1fab9e2d1@baylibre.com>
 <apE7BEGrIzJd1_zx@ashevche-desk.local>
 <70c2d36d-b079-411f-a454-a62061e395cf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70c2d36d-b079-411f-a454-a62061e395cf@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 31, 2026 at 04:14:47PM -0500, David Lechner wrote:
> On 8/28/26 2:38 AM, Andy Shevchenko wrote:
> > On Thu, Aug 27, 2026 at 05:27:02PM -0500, David Lechner (TI) wrote:

...

> >> +				return dev_err_probe(dev, -EINVAL,
> > 
> > I would use different error code, EINVAL is abused and overloaded a lot in the
> > kernel, and basically errors like ENODEV and EINVAL are synonyms to "*an* error"
> > happened. Unfortunately, reading the errno*.h I haven't found anything better.
> 
> There is an error message to disambiguate.
> > 
> >> +						     "invalid burn-out-current-nanoamp value\n");

While this is true, there might be the case when it won't help. When the kernel
is compiled without printk() support and run in production the userspace still
may decode an error from the number representation. That's why in a tricky cases
(this one probably not that tricky, but just saying) it's very important to use
better granularity for the error codes.

-- 
With Best Regards,
Andy Shevchenko


