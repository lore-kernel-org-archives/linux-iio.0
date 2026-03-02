Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C1B379996;
	Mon,  2 Mar 2026 08:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772440087; cv=none; b=A8m7ePZRKzx8RJECuHb1jM3zXdsvabh0YpxBA+a6jmk05ozJygt2xhaZ6CtOCNpACPkpQwiqmZ6JQJbWIYaAvmA9/GfCROunuRfbJmyZDv09G9pzTfDT9cftkuutLmF2WnfaCc0R1AZf3hOWICG9oI7Z128UyY04Sanu/dLe7j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772440087; c=relaxed/simple;
	bh=7FhWh7BgFISEsCBVfcdH3CNGUtd9ft2tykGuXcbos3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmeE6Pwh+fP1kYbtvPKcMAYsO/LiwP2l8vys9bRU/hcoqqyx+DXaZxqhWirxxzfUKdTi0H4GNYkFFhDvnk3SNyBYk7Z5EiRqG9iJWhATPVF9kw5wKHanb1yyd4yxaLXivl2JFFVXj6n/vqYeeOP2tCnJHnVBOVEZ7Bdjo2GzMvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XycG/f4f; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XycG/f4f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772440085; x=1803976085;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7FhWh7BgFISEsCBVfcdH3CNGUtd9ft2tykGuXcbos3A=;
  b=XycG/f4flVGwY4WMHTNmTsTuDQ20qgCy6rdmliVDyUD+xdIBk9A7JH1t
   guv5BPoFs7q3n19YPbfncb3KnGAhy25XX2P7GTKnL+RhUZ8Ud0HXiIkhg
   9h96fikGPltn1lVKf6FLUwCHlfnzq5p8suL2Rbph+2qmFEYGCdeS/wjoL
   tgaSEM93Ntdkw2RULLuxiMyeLlj1Rs9c7wWAnzpGltHPQCENGwW27ZJum
   OLMs/kgfaMMzRbZcWl9jptJVxsV79isz87D26WlSuB166Gd5xgH8yRtCK
   jbjBWs9R1pVO4DGPNGqDoUjxtRPYl8wV9g6Iu73Tu31lFsKlGe0YnW9Pz
   w==;
X-CSE-ConnectionGUID: lxBgH/Q2TU2Tg+LFwi2twg==
X-CSE-MsgGUID: WLkfxbY2QlGwLa95VhyhkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="73145121"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="73145121"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 00:28:04 -0800
X-CSE-ConnectionGUID: 8rcFrIUzT+2A00I1eMUuRQ==
X-CSE-MsgGUID: 2IZf6wnnSbyoBzutePaK4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="240599069"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.52])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 00:27:59 -0800
Date: Mon, 2 Mar 2026 10:27:57 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
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
Message-ID: <aaVKDbB_XIFmxCEM@ashevche-desk.local>
References: <20260216-adf41513-iio-driver-v7-0-b0ed387ab559@analog.com>
 <20260216-adf41513-iio-driver-v7-2-b0ed387ab559@analog.com>
 <20260222172912.60a103c0@jic23-huawei>
 <aZwYshRxNgSh3CWk@smile.fi.intel.com>
 <zb752y7tnjzsc35na572o4sip6efwv3i4lha4ls6fhdrr52h5v@bfgy65cmae4p>
 <CAHp75VdSV2QDMR0DueCuP=Ds-5A1NsNjqPWtmRbG4NvoJ=LjXQ@mail.gmail.com>
 <20260301122340.3fedf64e@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260301122340.3fedf64e@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Mar 01, 2026 at 12:23:40PM +0000, Jonathan Cameron wrote:
> On Mon, 23 Feb 2026 12:41:45 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Mon, Feb 23, 2026 at 12:37 PM Rodrigo Alencar
> > <455.rodrigo.alencar@gmail.com> wrote:
> > > On 26/02/23 11:06AM, Andy Shevchenko wrote:  
> > > > On Sun, Feb 22, 2026 at 05:29:12PM +0000, Jonathan Cameron wrote:  

...

> > > > It all depends on the series from Dmitry Antipov.
> > > > Can somebody help reviewing the patch 1 there?
> > > > https://lore.kernel.org/linux-hardening/20260212125628.739276-1-dmantipov@yandex.ru/  

FWIW, Andrew picked them up for Linux Next. Please, test!

> > > can we push for the exposure of that function to kernel modules?
> > > We have discussed that in v6, and I understand that:
> > >
> > > EXPORT_SYMBOL_FOR_MODULES(_parse_integer_limit, "industrialio");
> > > in lib/kstrtox.c;
> > >
> > > #include "../../lib/kstrtox.h"
> > > in drivers/iio/industrialio-core.c
> > >
> > > is not a good call...  
> > 
> > Yep, because it's a temporary band-aid. The proper solution is to have
> > shared code provided by the lib/. So, the wrapper to parse 64-bit out
> > from the constant string literal should be part of the lib/ in the
> > result.
> > 
> > > > When it's in, we can continue on this one. TL;DR: for me this is on hold.
> > > > But if you see the need to have the driver being in IIO, please add a big
> > > > fat FIXME to make sure we will get this all being sorted out in the
> > > > (nearest?) future.  
> > >
> > > I could add the FIXME into iio_safe_strntou64() doc header. It explains
> > > the context:
> > >  
> > > > + * The implementation of this function is similar to _parse_integer_limit()
> > > > + * available in lib/kstrtox.h, but that header/function is not available to be
> > > > + * used in kernel modules. Hence, this implementation may need to change or
> > > > + * removed to reuse a new suitable helper that is properly exposed.  
> > 
> > Up to Jonathan, I hope we can move the above mentioned series forward.
> > Without that, as I pointed out, this one sounds to me suboptimal and
> > unneeded double effort.
> > 
> I don't want to hold this series for another cycle, but we are still
> fairly early in this one, so some focus on moving that forwards seems
> sensible.  If we are running out of time, we can fallback to a loud
> FIXME and a plan to move to the generic version in the library next cycle.
> So let's set a rough deadline of rc5 and see how things are going then.

Taking into account the above, can we actually develop something
based on that?  Or at least having a temporary solution for this
cycle followed up by the better one for the next?

-- 
With Best Regards,
Andy Shevchenko


