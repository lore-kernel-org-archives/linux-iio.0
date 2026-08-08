Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BAF1A9F91;
	Sat,  8 Aug 2026 20:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786220489; cv=none; b=d1g0tr3xYShvf2MA7uUXz3PpymJvJ1w9s0K1G03ac+7W8QKxvRs2whBTs41jYlR7RLqvcdOYiglAgtJj7MWmpHp0GcijTGURKomTP9KMDkhq/p1BoWv5M/IjofgUfxDoIunIKz2vqS/QRBkRVHykSt6eX+hPyHQ7eH32ySlrG/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786220489; c=relaxed/simple;
	bh=AKclGaNLUskbQeh9Z1Vh18Hb3hbuoaoxxiMAuMFVMPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXa4Be/RIEISadap9dyl6pYbbJ+sjZg8wdTX0zJQLQI8a/tvxI+ctpSdyXcpGjfuT4n20BeT7SFw0Fw9TsfDdCAKK5Btm1oGS2Jqlh1+aahTKUJEnj9id3FwEwCs1ENHXzcDGN7lC+varZFW5JcYg6Oo+cyaNbaNC76NoZSkLZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uot02xt8; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uot02xt8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786220488; x=1817756488;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AKclGaNLUskbQeh9Z1Vh18Hb3hbuoaoxxiMAuMFVMPQ=;
  b=Uot02xt8VpPvt6Lt0wF6T0Hj5+828d89XVrnd5CyruSGJGzncLzOQ7GX
   /+TaJPfDseXQVk11szH1cucJmUW4m2xeGHrTrnPKTdCt1iD9uaplljxCk
   8PKKiMhD97n4Q8DMHc24ufphbHER7G0cR+DmHGR2K1mkm11XIlQ0ivLw4
   DMoUxFkg0cc3X7EWjfDXK+FQM9DUIZaAl2Y/WZl7R86Nn1RTI/Hb0YPwP
   kEOF/9tRYDQYXZ/rQ8xfmajeL+AnMdqDrP3RUkYD1ogWbTlX8NSyU2Hv8
   hFOT+FU5h4lb6igkrOMrph11yfsgMs//HWR33rpLl9CH0fUjPCcwHmrne
   Q==;
X-CSE-ConnectionGUID: Ek4Ne9PPQXaYhnwC9n7RMA==
X-CSE-MsgGUID: qDLvfgEJTC2ZUtNPipRm4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11869"; a="90473379"
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="90473379"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 13:21:28 -0700
X-CSE-ConnectionGUID: 9Z4gJDvvS16/PX3J8KgErQ==
X-CSE-MsgGUID: niV5Xq0yQC6bSeJSCSMNZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,212,1779174000"; 
   d="scan'208";a="261383506"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 13:21:25 -0700
Date: Sat, 8 Aug 2026 23:21:22 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>,
	Maslov Dmitry <maslovdmitry@seeed.cc>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] iio: light: ltr501: Fix sorting order of device
 arrays
Message-ID: <anePwmLumk4k8l9e@ashevche-desk.local>
References: <20260804-liteon-ltr329-v3-0-c6b768c7c745@geanix.com>
 <20260804-liteon-ltr329-v3-6-c6b768c7c745@geanix.com>
 <XtotGdyhZvQIq-19qWwYJ2t9CGaZ4kcJXvUUcRmfXmC7YVRVj4wVkAttk_2tgzsuymMdFgL7wMAWYgvA8RFcuA==@protonmail.internalid>
 <anT_KYZjkX2Tcnqu@ashevche-desk.local>
 <87ecgaxt0i.fsf@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ecgaxt0i.fsf@geanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 07, 2026 at 09:57:17AM +0200, Esben Haabendal wrote:
> "Andy Shevchenko" <andriy.shevchenko@intel.com> writes:
> > On Tue, Aug 04, 2026 at 07:02:17PM +0200, Esben Haabendal wrote:

...

> >>  enum {
> >> -	ltr501 = 0,
> >> -	ltr559,
> >> -	ltr301,
> >
> >> +	ltr301 = 0,
> >
> > Is the 0 required? Why?
> 
> As for the code produced, it should not make any difference.
> 
> I assume it was put here for improved code readability, and I did not
> see any reason to change that.
> 
> I don't care about it myself, so will be happy to remove it if that is
> the preferred style now.

It's not about the style, it's about understanding the C language.
As per style, we have only one requirement in IIO, if the value is used
in communication with HW (part of protocol or a bitfield) *all* enum
values must be explicitly assigned, otherwise (Linux only case) none
(with, of course some exceptions, which are not the case here).

> >>  	ltr303,
> >>  	ltr329,
> >> +	ltr501,
> >> +	ltr559,
> >>  };

-- 
With Best Regards,
Andy Shevchenko


