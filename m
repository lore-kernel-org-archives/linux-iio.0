Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB1A396B85;
	Mon,  2 Mar 2026 10:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772446844; cv=none; b=CI2PjwJjcX+1UH3M70hFAf7k/Go4QpjBldMsKwboXzEHvMbtYrk13aA2e94/S0Pm/ggCleEta2CQROk9lLd4vTKQUWYRkQjs8/etC0KepSKLrNvZj2YgW9mrwrDXOaq+DN1Z4Mjh1/8pdGVGfguB4RFhEVJjRCZFgRytdQsf1M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772446844; c=relaxed/simple;
	bh=JD4YIPNcb+y88+5wOOif7V+1YNyKxExUlQlWm1SJGBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCpDR73V93HzWPMLRjNSltUrp240RgHCXvCrgmcq6j1kglwgNn9bRdnuVHf1NNcUj6DW/quBr9JdcmDmIE8gqEwUkDs1s+5KQXCiUUM0ECEKPTACd+ubRlZyeumVNiQyc1AYLq7Cors0C1nEfb3rayeXdS6UGngihYoJDgGv2Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eQt4EnOt; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eQt4EnOt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772446843; x=1803982843;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JD4YIPNcb+y88+5wOOif7V+1YNyKxExUlQlWm1SJGBs=;
  b=eQt4EnOtpzi+25W42SljVewy8R+w1OgMAHlObAcSX+HVhJostpjVAkiJ
   RBbYEDIGz9vlTG+Bs/ZkQpC0ZllGH6CoSnSxDFvKX/JSeh3n6AaKjsDny
   ykQHVtx6FhBr49b5GxR1WTGPlCzksXcsAutPXEPilBt/LMgQbXwLQ7Btl
   ZJCh12t1odxxAWB5vSPgjL9IbGtGYGkDxFpVNQrVD6AbU4KakjLvu4uTQ
   J9N3wyn04oFmR9iiLP2NZyxIjn3AndMV3v9OxPgVChxwUsfgoGTFgFlfc
   DTPX8/qXvjp67qqjNuR1uKBez2tWHeQj+mOXHpaZwFRcmRGAznkVh0rUS
   Q==;
X-CSE-ConnectionGUID: KZdEgPp8R7SXy0iwUvM+pg==
X-CSE-MsgGUID: JqwsviTLRFyyVV5e0Edi/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="61020262"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="61020262"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 02:20:42 -0800
X-CSE-ConnectionGUID: syDccVPRTzm0V3agw43T/Q==
X-CSE-MsgGUID: XHLoCzA3Qie8dWjHLpFG0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="221764078"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.52])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 02:20:38 -0800
Date: Mon, 2 Mar 2026 12:20:35 +0200
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
Message-ID: <aaVkcw0g79pnXU_z@ashevche-desk.local>
References: <20260216-adf41513-iio-driver-v7-2-b0ed387ab559@analog.com>
 <20260222172912.60a103c0@jic23-huawei>
 <aZwYshRxNgSh3CWk@smile.fi.intel.com>
 <zb752y7tnjzsc35na572o4sip6efwv3i4lha4ls6fhdrr52h5v@bfgy65cmae4p>
 <CAHp75VdSV2QDMR0DueCuP=Ds-5A1NsNjqPWtmRbG4NvoJ=LjXQ@mail.gmail.com>
 <20260301122340.3fedf64e@jic23-huawei>
 <aaVKDbB_XIFmxCEM@ashevche-desk.local>
 <ct2r5wvvfowqcfe44fawbi4blkjpfle7etvaunwbsxevejsr2s@3g43wru5n6jh>
 <aaVZdgvZhaWDgU2X@ashevche-desk.local>
 <imtqtaakbz4c4pmlmb3gh2r5sjvso2fymdy4poyjvds2noqzdr@d4ia6rml6jzf>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <imtqtaakbz4c4pmlmb3gh2r5sjvso2fymdy4poyjvds2noqzdr@d4ia6rml6jzf>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 02, 2026 at 10:13:52AM +0000, Rodrigo Alencar wrote:
> On 26/03/02 11:33AM, Andy Shevchenko wrote:
> > On Mon, Mar 02, 2026 at 09:19:42AM +0000, Rodrigo Alencar wrote:
> > > On 26/03/02 10:27AM, Andy Shevchenko wrote:
> > > > On Sun, Mar 01, 2026 at 12:23:40PM +0000, Jonathan Cameron wrote:
> > > > > On Mon, 23 Feb 2026 12:41:45 +0200
> > > > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > > > > On Mon, Feb 23, 2026 at 12:37 PM Rodrigo Alencar
> > > > > > <455.rodrigo.alencar@gmail.com> wrote:
> > > > > > > On 26/02/23 11:06AM, Andy Shevchenko wrote:  
> > > > > > > > On Sun, Feb 22, 2026 at 05:29:12PM +0000, Jonathan Cameron wrote:  

...

> > > > > > > > It all depends on the series from Dmitry Antipov.
> > > > > > > > Can somebody help reviewing the patch 1 there?
> > > > > > > > https://lore.kernel.org/linux-hardening/20260212125628.739276-1-dmantipov@yandex.ru/  
> > > > 
> > > > FWIW, Andrew picked them up for Linux Next. Please, test!
> > > 
> > > The patch looks ok, but I am not seeing it solving my problem here.
> > > Here is the v8:
> > > https://lore.kernel.org/linux-hardening/aZXDSbyH8tWmTPPL@smile.fi.intel.com/T/#t
> > > 
> > > I would have to use simple_strtoull() and it would clamp the value at
> > > ULLONG_MAX in case of overflow, but it would not say that an overflow
> > > happened. Would that be fine? I understand that addressing the FIXME
> > > in simple_strntoull() is not a subject of this patch.
> > >  
> > > > > > > can we push for the exposure of that function to kernel modules?
> > > > > > > We have discussed that in v6, and I understand that:
> > > > > > >
> > > > > > > EXPORT_SYMBOL_FOR_MODULES(_parse_integer_limit, "industrialio");
> > > > > > > in lib/kstrtox.c;
> > > > > > >
> > > > > > > #include "../../lib/kstrtox.h"
> > > > > > > in drivers/iio/industrialio-core.c
> > > > > > >
> > > > > > > is not a good call...  
> > > > > > 
> > > > > > Yep, because it's a temporary band-aid. The proper solution is to have
> > > > > > shared code provided by the lib/. So, the wrapper to parse 64-bit out
> > > > > > from the constant string literal should be part of the lib/ in the
> > > > > > result.
> > > > > > 
> > > > > > > > When it's in, we can continue on this one. TL;DR: for me this is on hold.
> > > > > > > > But if you see the need to have the driver being in IIO, please add a big
> > > > > > > > fat FIXME to make sure we will get this all being sorted out in the
> > > > > > > > (nearest?) future.  
> > > > > > >
> > > > > > > I could add the FIXME into iio_safe_strntou64() doc header. It explains
> > > > > > > the context:
> > > > > > >  
> > > > > > > > + * The implementation of this function is similar to _parse_integer_limit()
> > > > > > > > + * available in lib/kstrtox.h, but that header/function is not available to be
> > > > > > > > + * used in kernel modules. Hence, this implementation may need to change or
> > > > > > > > + * removed to reuse a new suitable helper that is properly exposed.  
> > > > > > 
> > > > > > Up to Jonathan, I hope we can move the above mentioned series forward.
> > > > > > Without that, as I pointed out, this one sounds to me suboptimal and
> > > > > > unneeded double effort.
> > > > > > 
> > > > > I don't want to hold this series for another cycle, but we are still
> > > > > fairly early in this one, so some focus on moving that forwards seems
> > > > > sensible.  If we are running out of time, we can fallback to a loud
> > > > > FIXME and a plan to move to the generic version in the library next cycle.
> > > > > So let's set a rough deadline of rc5 and see how things are going then.
> > > > 
> > > > Taking into account the above, can we actually develop something
> > > > based on that?  Or at least having a temporary solution for this
> > > > cycle followed up by the better one for the next?
> > > 
> > > As mentioned above, I am not sure how consume what Andrew has over there.
> > > It seems address lib/ internal stuff. The interfaces are still the same.
> > 
> > I think it will be third time I'm repeating that this needs a wrapper in the
> > lib/. Just add the one (like with safe_strtoull() naming schema) with properly
> > formed prototype that returns an error and the result in different variables
> > 
> > int safe_strtoull(..., *result)
> > {
> > 	...
> > }
> > EXPORT_SYMBOL_GPL(safe_strtoull);
> > 
> > (Also some test cases have to be added.)
> 
> I really understood that I would need to use Andrew's work as is, but
> in fact, you encouraging me to add what we need on top of it.
> 
> Assuming that this would increase the scope of this patch series, I suppose
> that would need to be included in a separate one.
> can we just not export simple_strntoull() from lib/vsprintf.c? I mean,
> addressing its FIXME and changing its prototype?

I do not understand why we have to stick with the scope of IIO and make an
unneeded churn and double effort. We have a code that you need. Yes, it
requires an additional change that adds a glue (exported) function. How is it
out of the scope? If we hurry up with that code to be added, it increases
the chances to get the rest in sooner.

-- 
With Best Regards,
Andy Shevchenko


