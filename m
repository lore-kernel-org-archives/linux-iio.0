Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EB02EF653;
	Tue, 28 Apr 2026 07:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777362865; cv=none; b=dztzfzNG/P++AyUH9y+ByACclsIIDtW4tsDPqBXNZMildBAvU+YTrF5W6HpfuHZqMlZFOdhCIBJVQk/IcNkCHkRHcn1EU5/vQ/oZE9npQpHE+c2NXkwOZv3xKpDTvspRLVJd5WeemUBoaMn9DTIQJBCuJ1LvAfpOZ2YEVwXteY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777362865; c=relaxed/simple;
	bh=gas+9P0RG9boD9XcLlb8IwKlDMFPPqrTwh7QRCC1GRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQXsqJKZAeHHLf5IqRM4KeMDLo1Zjer1lJxOYQEfN1u+2GU2rqWbZbMKXqdyzMY6tnq/nNaZxX+gmidB+/EbCSOBRxL+xeQnCmL9f/m49WG5KojGnWnbuB+Laeb4cOj7h7y77+2gsJCjnuWpaOFq4Kdwy6ehOE0WcBoWSDDjraw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LIWFgwrN; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LIWFgwrN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777362865; x=1808898865;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gas+9P0RG9boD9XcLlb8IwKlDMFPPqrTwh7QRCC1GRI=;
  b=LIWFgwrNc1fDLqDoL9osG0/rKJY0wzBG43c2FRXU/UN1UGeCvVPVAq9i
   4F9tYhOisqGWd1jvA3U/wXWbEbpxPc5JJNjvNjQ4SwQMSq/sdnZLBfW36
   Rlf7aFGwn2PAo2lB8JCglA1b4keqLoPxpWeP/aurjVCSZJtbacKbM6h1k
   0F8ISiMuLxWcHbRL7pRDr95F2xrs2U1A2i8XqxeVJmP+fZUnbYFnq8ate
   +3owUFFXsQ5F3RtMBHzqpG1TPXPvWucN1OWiRkueft1fHKakLCKEQZzo0
   JKOPLgc/0wJDGvIpKErecJklLkpVj/lfTFCzIkOjjWK1R8UIQu64Ds/lh
   w==;
X-CSE-ConnectionGUID: Fwfx9ZdPQNmGFqIeczdiXQ==
X-CSE-MsgGUID: aNjnPUDBS4qg/YTlvLg/mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78455708"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="78455708"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 00:54:25 -0700
X-CSE-ConnectionGUID: KdUng5TRSAyy8ozM808kIA==
X-CSE-MsgGUID: OPUzA4BHSOSLfITmgBzZzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="229319651"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.213])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 00:54:22 -0700
Date: Tue, 28 Apr 2026 10:54:20 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v0 14/14] iio: magnetometer: ak8975: Make use of the
 macros from bits.h
Message-ID: <afBnrJ7RaOhkvUjA@ashevche-desk.local>
References: <20260427201412.3067235-1-andriy.shevchenko@linux.intel.com>
 <20260427201412.3067235-15-andriy.shevchenko@linux.intel.com>
 <CALoEA-wEC8SPZ8Y__3nWDx1KdyA=96sYCxt4ghK5aA_m9HkxLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-wEC8SPZ8Y__3nWDx1KdyA=96sYCxt4ghK5aA_m9HkxLg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 28, 2026 at 09:23:28AM +0200, Joshua Crofts wrote:
> On Mon, 27 Apr 2026 at 22:14, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Make use of BIT() and GENMASK() where it makes sense.

...

> >  #define AK8975_REG_ST1_DRDY_SHIFT      0
> 
> Might as well remove these types of macros, as they are
> otherwise unused in the code after this patch. Either that
> or incorporate them into the BIT() and GENMASK()
> macros to prevent magic numbers.

Good catch! Please, adjust this patch accordingly in your local branch before
sending out.

-- 
With Best Regards,
Andy Shevchenko


