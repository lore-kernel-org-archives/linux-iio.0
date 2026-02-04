Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7123D1CA0;
	Wed,  4 Feb 2026 10:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770201299; cv=none; b=goF1K+eHjT3LdintRCNSbksH0aPo4KkGoVsyQ1M9tWwJT2Hu9FZG6tXyor0RGoaVDdSTYP5xXjtYYmzGTtJeTfCt9lmNVl4sKCPn2AFsYxEt72IktoIFMjS7+Ltw42qzLVMA9ECGHvZhxkjyQOq3hphUKoXVhiqYISjtRLXte8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770201299; c=relaxed/simple;
	bh=oxc7/XTv+dXWfFn+rjSwMgQNviDMmBdkkYSOQJyG8Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYwOxfrIfWV6ECFWsmSoZ7Oq7soxvJ/krPlBWSs1bsBDiAhF3OqWXvhpzXZrN9/Ejp9FrgzNhvGNBShdEsNdkbBf8/gXDw5r7Q9pT3ZKl3myUprjhgcFvhWO3UTSogDkFoL4DheJUXxqYbn6RbF+oLadHUaGx58eA/f9UHUr89w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dZ6YIL/y; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dZ6YIL/y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770201299; x=1801737299;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oxc7/XTv+dXWfFn+rjSwMgQNviDMmBdkkYSOQJyG8Hk=;
  b=dZ6YIL/yfBz74DgGZHWGqeZrupYVBdo6/X/gNlb6NON2GWrd+LRPw3jG
   fve5Nr7X2lJkywmjMiII+t75E5J6rkG/aRWnQo3qaXqdAc49JiR5WP111
   b6g+zMC/cVK4Lo4rVp+NsAucV41FHpsW9S3lhT7U0dHyuCeJdP0cr8xRh
   VATokuhXO7lYAlkAN3qkxIQzTcrtta9EngGJ0z81oU3hrTN7MvjkL2Pjx
   boDyJtVKG2AT1fh6FqhxQ+9uph5lZauRvcH9wd+EjTCRVa8LVkHDgzeWl
   UdfFGoktuiKT7LBWyiXnPCpoZIXBc/LuKwJ1uSUpBOdtwDLz6DKU4jsy1
   w==;
X-CSE-ConnectionGUID: CnxyyDgXTXGJABKpS9QNPQ==
X-CSE-MsgGUID: IrpZPdZbQkmLcxo1sdsF7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="82754789"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="82754789"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 02:34:58 -0800
X-CSE-ConnectionGUID: a9pojmGoSlWN4ARqR3ydPA==
X-CSE-MsgGUID: VAWEqE5ISCyUQUIWcdsA0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="214308089"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.188])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 02:34:54 -0800
Date: Wed, 4 Feb 2026 12:34:52 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v6 2/8] iio: core: add fixed point parsing with 64-bit
 parts
Message-ID: <aYMgzMVcv_QALJtF@smile.fi.intel.com>
References: <20260130-adf41513-iio-driver-v6-0-cf46239026bc@analog.com>
 <20260130-adf41513-iio-driver-v6-2-cf46239026bc@analog.com>
 <aYKkv3dq9Vkm3s_3@smile.fi.intel.com>
 <7tiv33i65unu5ypk7puj3buzybykyhv2qbwp54bhcem5t4rawq@dpfedqmmxbhx>
 <aYMYJppigidPeLH4@smile.fi.intel.com>
 <hrhgmum6zdww7etc6ztchivfqecaaqeeul2bbagzyongkxpaeh@q7x4popwel6d>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hrhgmum6zdww7etc6ztchivfqecaaqeeul2bbagzyongkxpaeh@q7x4popwel6d>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 04, 2026 at 10:28:05AM +0000, Rodrigo Alencar wrote:
> On 26/02/04 11:57AM, Andy Shevchenko wrote:
> > On Wed, Feb 04, 2026 at 09:42:55AM +0000, Rodrigo Alencar wrote:
> > > On 26/02/04 03:45AM, Andy Shevchenko wrote:
> > > > On Fri, Jan 30, 2026 at 10:06:43AM +0000, Rodrigo Alencar via B4 Relay wrote:

...

> > > > There is a development in the parse_integer in the lib/. I reviewed that series
> > > > and hopefully it will go in. With that done, we better reuse the lib/ function.
> > > > 
> > > > https://lore.kernel.org/linux-hardening/20260202115451.290173-1-dmantipov@yandex.ru/
> > > 
> > > In this patch, I see that it updates the overflow check, but I am not
> > > seeing that function being exposed to other kernel modules.
> > 
> > Can the IIO be compiled as a module? If so, then we would need to export that
> > function. (Note, we may export only for the exact module(s) in question, so
> > nobody else will be able to use it. See EXPORT_SYMBOL_FOR_MODULES() macro.)
> 
> Yes, one can have an industrialio.ko.
> Then, would it be fine to use:
> 
> EXPORT_SYMBOL_FOR_MODULES(_parse_integer_limit, "industrialio");
> 
> in lib/kstrtox.c; and:
> 
> #include "../../lib/kstrtox.h"
> 
> in drivers/iio/industrialio-core.c
> 
> that does not look pretty.

Yeah, but I think it's fine as long as we have an associated FIXME.
In any case Jonathan is the one who makes a decision here.

-- 
With Best Regards,
Andy Shevchenko


