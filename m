Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D4734678D;
	Fri, 20 Feb 2026 13:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771594176; cv=none; b=WvOuSOLN0l8zGVewQ0DuCynL2AtcJfEwn5BHP6WKQll2R/06rALGYt+/KL3HLk1m4NWJvNir9ZUcQxULpraBaLBhmweMCtptDNWmNxcxHtKPUptjxGS6YaRyRiVSh3Xbr5lnRSlT2AQjTwUeSdhlmBa324gOfoHnxUruwOWqyn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771594176; c=relaxed/simple;
	bh=I8PwNEaD9hidzUf9f0KgwEbqYHly+IpZ+BznSjfFjw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEXwqcivumVNwFu1HP4wJ2mrsm1v/eWGYkIwFImK2eCpNxNyGrqeDgSl/pVCuFzNAGfQKiH7qxqflM3L/PVPo0RPLdMJvLE8j3uDEnwO3voW7PmMdsLyKSNMVNlz77WjEpPcXGhBw1a5Q1gEPmfh/0I4T+LrmgS2n3I+7UlPXvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZkTXZmEj; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZkTXZmEj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771594175; x=1803130175;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=I8PwNEaD9hidzUf9f0KgwEbqYHly+IpZ+BznSjfFjw0=;
  b=ZkTXZmEjH3ZtApas9yyKt+td9XrTMOZp8lBBMH5Sc8gFdlPWrSWFDNKq
   wwMmrIe5gM5hhSj+5u9fOqhXt48y3PPQaa92Ha8O27yF5TWOwUMkcz7Ho
   QWeJ4UlBtSyeEI5T99FpGDkiEyHFW+vhybhhrI2exmKE4x+VsGZp+uhql
   wTLbu8HL5o9f8Iq91VEL9jWcnle6gl6UAPdmvcASQwtJ+9RgK4iWURmNx
   sCGthGfNhh+xeT0Na9rHOzFW9/To3lTfrZXvhBzVlQa/e4tnuicqOGcJQ
   7gZiPPfUx6/6yhijvV1B0TVAwv9AWWoxq0BNqsfjEDing9uHA9Sw/PlGU
   A==;
X-CSE-ConnectionGUID: tBOAo/H6QZCiQz3K0rBygQ==
X-CSE-MsgGUID: nm6JOlBcQrqLfk35u10Dqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="72747467"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="72747467"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 05:29:35 -0800
X-CSE-ConnectionGUID: lB4HFlBeRyCeW90hvermXA==
X-CSE-MsgGUID: WvM8gAqYTzCT2AMZ0OiRkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="213412294"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.25])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 05:29:33 -0800
Date: Fri, 20 Feb 2026 15:29:31 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] iio: core: Simplify IIO core managed APIs
Message-ID: <aZhhuxD9YWefCAuY@smile.fi.intel.com>
References: <20260216081412.1118599-1-andriy.shevchenko@linux.intel.com>
 <20260220101844.17f3bc63@jic23-huawei>
 <CAHp75VdQufe2ANMm=FWvnGAfpe4Y-U_oocs-ax+tY39=z81g4A@mail.gmail.com>
 <20260220121450.74586f44@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260220121450.74586f44@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 20, 2026 at 12:14:50PM +0000, Jonathan Cameron wrote:
> On Fri, 20 Feb 2026 12:27:40 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Fri, Feb 20, 2026 at 12:18 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > > On Mon, 16 Feb 2026 09:14:12 +0100
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:  

...

> > > This had me briefly confused as I failed to notice it was static
> > > (no idea why I gave such a simple internal function kernel-doc!)
> > >
> > > However that brings the obvious follow up question.  Given your
> > > simplification does having a helper make sense given only a single caller?
> > >
> > > Let's just squash it and have the two calls inline + some resulting docs
> > > updates to get rid of the references to this function.  
> > 
> > Do you want to have this change inside the proposed patch? Or in a
> > separate (pre/post) one?
> Same patch would be fine I think.  It's small and coupled to the code
> getting simpler because of the main change here.  Seems like a pointless
> dance to refactor same code twice.

v2 has just been sent.

-- 
With Best Regards,
Andy Shevchenko


