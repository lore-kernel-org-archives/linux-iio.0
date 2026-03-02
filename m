Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319D630F934;
	Mon,  2 Mar 2026 09:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772444031; cv=none; b=gSzfYXAFps8m75KP9G8z5hsOkfUm2qbKnijET80gEmnFrnxUl+X6Fyc2IKFy1Q/ABsIUnij3lgrkAMkgB6ycxmPmKEl7nimZkCAqING3U4IAg3SJhCyYmz1DqkmKqehpFYvjp94Ig1taLstaoNScyraZtgC7gIqMeam/V7vS92s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772444031; c=relaxed/simple;
	bh=L5wlsipJX/hRemiikjSCzNo6/d0K6+87GRLKe3dB9X4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJUfc7gFGx4HIClHge3gym0E2AEvo1ePDq6opZt3Nij8V8jWbxNzheQ7O2OT9mM17y9VsguOPCs2trZSumYbkhZhTshfwmO5+2YA7twKbSmnTX7a/AzQBGBhW+Rp9jFMA8R/ha7e/Ylns+4wVdJBU3mSt6hUFKUP8sOHXw3phFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h5vKZmAc; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h5vKZmAc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772444030; x=1803980030;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=L5wlsipJX/hRemiikjSCzNo6/d0K6+87GRLKe3dB9X4=;
  b=h5vKZmAczhj3Hvbs04xTuV6KQoiyeG2BrFeoRVg6xPg0dLoxXVwLoehU
   vRgrqFYK9Go8QDqYjai0or4K5YdrQI8T/Z828ZK0a2IulLThOz4ABc7Xq
   8w3dI/iUYKAUrD8sZwPj/6cHmdULehtD2pPz+VwnCuu+dpBAmjW384fig
   Bg2Th+XhjRKMWOM7CuSlXEsGARRUgzfUnTcP4er4qxg53awMkviTupZyX
   vd3sxRelpP/TadQk9GL1d2M0esy9SBmvo1k57yUWS/pq2VWY7s8EDN652
   AQfXBeu7fXcUT0ln4sHaihCqqy8M4TzvKCH39T6Y1HV+ygSQYJCS9UChB
   A==;
X-CSE-ConnectionGUID: KvtwCNtMQIi4JMYWiVh7Lw==
X-CSE-MsgGUID: eBz7/q1UST+fk7sVDFgq5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="84912219"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="84912219"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 01:33:49 -0800
X-CSE-ConnectionGUID: HnQNMirVRBK07EBz+CwPTQ==
X-CSE-MsgGUID: mFwFMDJWQJS5k3OVM56syw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="214089996"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.52])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 01:33:44 -0800
Date: Mon, 2 Mar 2026 11:33:42 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>,
	rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH v7 2/8] iio: core: add fixed point parsing with 64-bit
 parts
Message-ID: <aaVZdgvZhaWDgU2X@ashevche-desk.local>
References: <20260216-adf41513-iio-driver-v7-0-b0ed387ab559@analog.com>
 <20260216-adf41513-iio-driver-v7-2-b0ed387ab559@analog.com>
 <20260222172912.60a103c0@jic23-huawei>
 <aZwYshRxNgSh3CWk@smile.fi.intel.com>
 <zb752y7tnjzsc35na572o4sip6efwv3i4lha4ls6fhdrr52h5v@bfgy65cmae4p>
 <CAHp75VdSV2QDMR0DueCuP=Ds-5A1NsNjqPWtmRbG4NvoJ=LjXQ@mail.gmail.com>
 <20260301122340.3fedf64e@jic23-huawei>
 <aaVKDbB_XIFmxCEM@ashevche-desk.local>
 <ct2r5wvvfowqcfe44fawbi4blkjpfle7etvaunwbsxevejsr2s@3g43wru5n6jh>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ct2r5wvvfowqcfe44fawbi4blkjpfle7etvaunwbsxevejsr2s@3g43wru5n6jh>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 02, 2026 at 09:19:42AM +0000, Rodrigo Alencar wrote:
> On 26/03/02 10:27AM, Andy Shevchenko wrote:
> > On Sun, Mar 01, 2026 at 12:23:40PM +0000, Jonathan Cameron wrote:
> > > On Mon, 23 Feb 2026 12:41:45 +0200
> > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > > On Mon, Feb 23, 2026 at 12:37 PM Rodrigo Alencar
> > > > <455.rodrigo.alencar@gmail.com> wrote:
> > > > > On 26/02/23 11:06AM, Andy Shevchenko wrote:  
> > > > > > On Sun, Feb 22, 2026 at 05:29:12PM +0000, Jonathan Cameron wrote:  

...

> > > > > > It all depends on the series from Dmitry Antipov.
> > > > > > Can somebody help reviewing the patch 1 there?
> > > > > > https://lore.kernel.org/linux-hardening/20260212125628.739276-1-dmantipov@yandex.ru/  
> > 
> > FWIW, Andrew picked them up for Linux Next. Please, test!
> 
> The patch looks ok, but I am not seeing it solving my problem here.
> Here is the v8:
> https://lore.kernel.org/linux-hardening/aZXDSbyH8tWmTPPL@smile.fi.intel.com/T/#t
> 
> I would have to use simple_strtoull() and it would clamp the value at
> ULLONG_MAX in case of overflow, but it would not say that an overflow
> happened. Would that be fine? I understand that addressing the FIXME
> in simple_strntoull() is not a subject of this patch.
>  
> > > > > can we push for the exposure of that function to kernel modules?
> > > > > We have discussed that in v6, and I understand that:
> > > > >
> > > > > EXPORT_SYMBOL_FOR_MODULES(_parse_integer_limit, "industrialio");
> > > > > in lib/kstrtox.c;
> > > > >
> > > > > #include "../../lib/kstrtox.h"
> > > > > in drivers/iio/industrialio-core.c
> > > > >
> > > > > is not a good call...  
> > > > 
> > > > Yep, because it's a temporary band-aid. The proper solution is to have
> > > > shared code provided by the lib/. So, the wrapper to parse 64-bit out
> > > > from the constant string literal should be part of the lib/ in the
> > > > result.
> > > > 
> > > > > > When it's in, we can continue on this one. TL;DR: for me this is on hold.
> > > > > > But if you see the need to have the driver being in IIO, please add a big
> > > > > > fat FIXME to make sure we will get this all being sorted out in the
> > > > > > (nearest?) future.  
> > > > >
> > > > > I could add the FIXME into iio_safe_strntou64() doc header. It explains
> > > > > the context:
> > > > >  
> > > > > > + * The implementation of this function is similar to _parse_integer_limit()
> > > > > > + * available in lib/kstrtox.h, but that header/function is not available to be
> > > > > > + * used in kernel modules. Hence, this implementation may need to change or
> > > > > > + * removed to reuse a new suitable helper that is properly exposed.  
> > > > 
> > > > Up to Jonathan, I hope we can move the above mentioned series forward.
> > > > Without that, as I pointed out, this one sounds to me suboptimal and
> > > > unneeded double effort.
> > > > 
> > > I don't want to hold this series for another cycle, but we are still
> > > fairly early in this one, so some focus on moving that forwards seems
> > > sensible.  If we are running out of time, we can fallback to a loud
> > > FIXME and a plan to move to the generic version in the library next cycle.
> > > So let's set a rough deadline of rc5 and see how things are going then.
> > 
> > Taking into account the above, can we actually develop something
> > based on that?  Or at least having a temporary solution for this
> > cycle followed up by the better one for the next?
> 
> As mentioned above, I am not sure how consume what Andrew has over there.
> It seems address lib/ internal stuff. The interfaces are still the same.

I think it will be third time I'm repeating that this needs a wrapper in the
lib/. Just add the one (like with safe_strtoull() naming schema) with properly
formed prototype that returns an error and the result in different variables

int safe_strtoull(..., *result)
{
	...
}
EXPORT_SYMBOL_GPL(safe_strtoull);

(Also some test cases have to be added.)

-- 
With Best Regards,
Andy Shevchenko


