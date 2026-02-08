Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F28A27D77D;
	Sun,  8 Feb 2026 13:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770557095; cv=none; b=PzvlvRfto2cM3uAGdXTZJyW1Jk9r3eqgd/H5G1vFUBKt1m7o8ADt/uVPOtJe/ps85O3zPNkeHSzgm2XZ2acFsj9io+EKtDMnem7zf40joqDWCmFCgjVhdxgTX24VrKirURtSrYsTTO5XgYBEI6u6ain/9eD5a4M/712lLf2yJKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770557095; c=relaxed/simple;
	bh=r9gkFRCzEOb1h4nKqkUwgVKmowLhlaAuvj7Xx2k+NcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eshuFm/U1DaN0Se4g7qi3EFbfu4qq960+zj4KNyOvo9ih86nLaMAanBNHGUAuIY59he4NydArCVKSoQWcVvj5HNrQ+2YbhFrDfWoO5JB+NI086VsSbfRiZI3mrvS3/ibEpzjlP161KSdzkID+Nlxt9b0BauudWvI1fAzaBBGNYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oANrs1Ub; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oANrs1Ub"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770557095; x=1802093095;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r9gkFRCzEOb1h4nKqkUwgVKmowLhlaAuvj7Xx2k+NcA=;
  b=oANrs1Ub4VLJYVk3hf+s+HOI07qISO3kScQlalgZev5vIG6zSyoxhfn7
   kJ2+5lZa/4whPDb58JrJCvWVRRkASsLv+RZZIPL/NJJnVf6zgWmlSqadC
   hCvaVnwSkEYRjbbFOEIqLdkmYDCZdxW91VInbkXuXXRAcW6ehNaOAWews
   bAeQtKHfOhCMtQ58cbw490cBGKBG0P068PqpTBj76gbkdr61z25We6QFJ
   V8ljJ66i/h/LvR/OXDjT7/nd804mzJp+q8gyWs1N91nEi1O2imm9cxXPa
   OoAwf7TCXKkSjkKsO6GHb0+nnY4tc/TJlWTmvblQUVmYQ1KjDRWlEigO4
   w==;
X-CSE-ConnectionGUID: YfhyvntIQQukSAbPRR6+Yw==
X-CSE-MsgGUID: WJl2OnLVQ3iYKfTeCn94aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="83064599"
X-IronPort-AV: E=Sophos;i="6.21,280,1763452800"; 
   d="scan'208";a="83064599"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 05:24:55 -0800
X-CSE-ConnectionGUID: GgxqGVi1Q+iso5D2FbD6+Q==
X-CSE-MsgGUID: uKX408q9StamNKiXcMNe2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,280,1763452800"; 
   d="scan'208";a="210566497"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 05:24:51 -0800
Date: Sun, 8 Feb 2026 15:24:49 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
	rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v6 2/8] iio: core: add fixed point parsing with 64-bit
 parts
Message-ID: <aYiOoZMkq_d48vCZ@smile.fi.intel.com>
References: <20260130-adf41513-iio-driver-v6-0-cf46239026bc@analog.com>
 <20260130-adf41513-iio-driver-v6-2-cf46239026bc@analog.com>
 <aYKkv3dq9Vkm3s_3@smile.fi.intel.com>
 <7tiv33i65unu5ypk7puj3buzybykyhv2qbwp54bhcem5t4rawq@dpfedqmmxbhx>
 <aYMYJppigidPeLH4@smile.fi.intel.com>
 <hrhgmum6zdww7etc6ztchivfqecaaqeeul2bbagzyongkxpaeh@q7x4popwel6d>
 <aYMgzMVcv_QALJtF@smile.fi.intel.com>
 <20260207170228.2f2bfb35@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260207170228.2f2bfb35@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Feb 07, 2026 at 05:02:28PM +0000, Jonathan Cameron wrote:
> On Wed, 4 Feb 2026 12:34:52 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Wed, Feb 04, 2026 at 10:28:05AM +0000, Rodrigo Alencar wrote:
> > > On 26/02/04 11:57AM, Andy Shevchenko wrote:  
> > > > On Wed, Feb 04, 2026 at 09:42:55AM +0000, Rodrigo Alencar wrote:  
> > > > > On 26/02/04 03:45AM, Andy Shevchenko wrote:  
> > > > > > On Fri, Jan 30, 2026 at 10:06:43AM +0000, Rodrigo Alencar via B4 Relay wrote:  

...

> > > > > > There is a development in the parse_integer in the lib/. I reviewed that series
> > > > > > and hopefully it will go in. With that done, we better reuse the lib/ function.
> > > > > > 
> > > > > > https://lore.kernel.org/linux-hardening/20260202115451.290173-1-dmantipov@yandex.ru/  
> > > > > 
> > > > > In this patch, I see that it updates the overflow check, but I am not
> > > > > seeing that function being exposed to other kernel modules.  
> > > > 
> > > > Can the IIO be compiled as a module? If so, then we would need to export that
> > > > function. (Note, we may export only for the exact module(s) in question, so
> > > > nobody else will be able to use it. See EXPORT_SYMBOL_FOR_MODULES() macro.)  
> > > 
> > > Yes, one can have an industrialio.ko.
> > > Then, would it be fine to use:
> > > 
> > > EXPORT_SYMBOL_FOR_MODULES(_parse_integer_limit, "industrialio");
> > > 
> > > in lib/kstrtox.c; and:
> > > 
> > > #include "../../lib/kstrtox.h"
> > > 
> > > in drivers/iio/industrialio-core.c
> > > 
> > > that does not look pretty.  
> > 
> > Yeah, but I think it's fine as long as we have an associated FIXME.
> > In any case Jonathan is the one who makes a decision here.
> 
> You've lost me. Why do we need to restrict this function to use
> by specific modules?

Because it should not be used outside the lib/* to begin with.
The mentioned series relaxed that a bit, but the idea behind is
still the same. We rather should have a front-end wrappers like
safe_strtox() or so to do the job, not the parse_integer*() one(s).

> We normally only bother with that dance when
> there is a big footgun or something deep in core kernel code where
> we want to be very careful who uses it.

That's exactly the case.

> To me it doesn't seem appropriate here.

-- 
With Best Regards,
Andy Shevchenko


