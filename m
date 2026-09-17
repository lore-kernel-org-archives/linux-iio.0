Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5815B4E2F1A;
	Thu, 17 Sep 2026 12:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789647859; cv=none; b=Q7lkhbr+g23XjY+i6mgdlXqm7Z3qpRIEyHrtywduaOtd86v/6On8ClgRY4cL02rfErGGU3x8JXNrluauCFq7XXBTIHzJlLXASWTfCivYQMedtDRf8iStGXWpg+i/0IU9gRxjAdIvzEk+Eyd7gOgKRUT4C1EcQuIXACJuseWttME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789647859; c=relaxed/simple;
	bh=OXo16oiCBmr4dHafVr7pCYQugG0elifQXvWeyQbOJmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhphJrMZpm8agPv8Ere4v54gvDRjsz2Jflsx7R6o0IqzQjWJS75qGIkyYbPHsh0t/Gka+A2Gn03HV/yg+CmooFWTgL/o7+tdzi+ZsAottnHAYCiOGwriT2pnPxlI1B9GKd1NoKRF1KSHUXmvgRtbzsghf52INTzWBa47JTeotEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R5yK/nqD; arc=none smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R5yK/nqD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789647845; x=1821183845;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OXo16oiCBmr4dHafVr7pCYQugG0elifQXvWeyQbOJmo=;
  b=R5yK/nqD6GJCpmQ/AevnxPqi2ndIVp50CdlVQk99uJUFBsZr38M+zcnC
   AqvUZeJVa8bMMjARWEqljmNIUoVSTqEOya8Mi+WiOgBJIRMkfgNSaqDm9
   2hMh0vW7FeKnnPzKeClMtLIFnoZ+qH4+FrgT9mmp4P1kI8FCOaCKDVm1U
   aoASd9Q7G7aymB6xTMJU8Ymu/W5M+WmEII3lSY1HtqCSUq7x1iW35CAYU
   inajLcrkn34HWRlHlOuus+sZJz8BnKsJneBEhM4FKxPWTZz1/EEZa28q0
   8YoKomDnN+1pyWN+u8z8uiFN31ZotW/mOUi2H0w8/NWCNUnx2UoltCLBk
   A==;
X-CSE-ConnectionGUID: suBX/nzkSTWbMiEySUnYGg==
X-CSE-MsgGUID: sNtyjk3DSIKmUkmKP81/Mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="568157"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="568157"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 05:23:59 -0700
X-CSE-ConnectionGUID: 5om26GF9QPCzbIjk+yK1mw==
X-CSE-MsgGUID: AxF30DlOR+WkodFVqqERIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="267513867"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.11])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 05:23:57 -0700
Date: Thu, 17 Sep 2026 15:23:55 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Salah Triki <salah.triki@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: temperature: tsys02d: Fix state
 desynchronization on resolution write error
Message-ID: <aqvb21uRVsGNtjjx@ashevche-desk.local>
References: <20260917091609.626043-1-salah.triki@gmail.com>
 <20260917131638.000034e5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917131638.000034e5@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 17, 2026 at 01:16:38PM +0200, Joshua Crofts wrote:
> On Thu, 17 Sep 2026 10:16:08 +0100
> Salah Triki <salah.triki@gmail.com> wrote:

...

> > -		return ret;
> > +		dev_data->res_index = i;
> 
> You're missing a return, this will just fall through to the default
> case below.
> 
> >  	default:
> >  		return -EINVAL;

...and having a such without explicit annotation will lead to a compiler
warning.

-- 
With Best Regards,
Andy Shevchenko


