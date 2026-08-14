Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0707943933D;
	Fri, 14 Aug 2026 08:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786695269; cv=none; b=PFgA29f+lxBxQe7Tf2HUV2xWQYx96FWJNfOZ8aAbpKXybHDBkOKfFzeMO2Wvhad0r/acxQHBkCM/gw4GiwScWdPvZYceuzYb1FkFKRkulPpZLoUruGGUkLSqAxRFKlVxag5P1/S+6n9NsnpjOYG6exLkxev3jbzhHo503HC7bwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786695269; c=relaxed/simple;
	bh=Vp6kwkD7UKHHTmZ4lwIepeL3WFGNoFCpelZ68nOcF0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=suxARKVi8ivOcPoq6/QyvUzHhgCW6aOuxRNna6SFpF62QPeO0h+J068IHdkmX+bH6cVnqVVpBnwo+xBVh5SxAc4lvkRaJahy+QmudnICB0m9hmk65VbvmT2Byx40ti66yyG3dssindddOjAuWCJpuk06cBPNhIPv5Gj/NmlZA80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PWO263Jp; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PWO263Jp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786695257; x=1818231257;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Vp6kwkD7UKHHTmZ4lwIepeL3WFGNoFCpelZ68nOcF0A=;
  b=PWO263JpoTnV2GxU3jsBGbaP9/cDzVUJBAmxlJEND2oy3kERpnaauomT
   dNvRwYoxk3ghryJHyaeH+V/2KSFT/pcyeyNGGcLnigov64UegiW+d5jpn
   Sqn39rip8xRPcnF2zVwFb4gnZSXWZZDU1laSZ5L7IeQ5H76cFRblex+RU
   HQfIlbCGdKEZXxDu6madFzO7F8kB8i8tFbmww4h3NTweNFV9XrwjWk7dB
   PU1qRKS5rZeI5mLjGqk4VUtQG+1mElZBzCiOvyq95dkeQk1RXPxpq3D2L
   L0mDnWwYaDx4B4Um8s4Nk19I6sBTW8JadGJYZ+6ofCF8DdQxN1HIFDqEh
   A==;
X-CSE-ConnectionGUID: 4Tj1MeOWSZGczJlQJrqUnA==
X-CSE-MsgGUID: LRZ0NpSFSiiaKGkvVbTs+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="91084642"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="91084642"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 01:14:06 -0700
X-CSE-ConnectionGUID: cx4P2/ToSbGXXPrfDrxRFg==
X-CSE-MsgGUID: KRxPjzO6QQi4vpqZZZ1wiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="268433929"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.134])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 01:14:02 -0700
Date: Fri, 14 Aug 2026 11:14:00 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Maxwell Doose <maxwell@maxwelld.cc>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marius Cristea <marius.cristea@microchip.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: Re: [PATCH v1 1/4] iio: light: Unshadow error codes in ->store()
Message-ID: <an7OSM04kiviu9xL@ashevche-desk.local>
References: <20260813071912.2465208-1-andriy.shevchenko@linux.intel.com>
 <20260813071912.2465208-2-andriy.shevchenko@linux.intel.com>
 <DKO09O8T0FGE.2WMX1VNQN5C7J@maxwelld.cc>
 <CAHp75VdDgBcieBdd9q2u75oFCu+w5tAF_L3YNHV5Ra5biHxcsg@mail.gmail.com>
 <DKOBND0GKI21.2843OFKP0KR40@maxwelld.cc>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DKOBND0GKI21.2843OFKP0KR40@maxwelld.cc>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 13, 2026 at 09:47:00PM -0500, Maxwell Doose wrote:
> On Thu Aug 13, 2026 at 3:47 PM CDT
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Thu, Aug 13, 2026 at 8:52 PM Maxwell Doose <maxwell@maxwelld.cc> wrote:

...

> > Note, that kernel.h shouldn't be there at all, but that is definitely out
> > of scope here.
> 
> Makes sense. I wonder if it may be worth doing a patch series removing
> all of the kernel.h inclusions in IIO all at once (or maybe some drivers
> have a legitimate use for it, but that seems highly unlikely).

Yes, for sure! I have simply had no time to do it myself, but I have a low-prio
item in my always grown TODO list. So, if you do that, I will really appreciate!
But be careful, the actual patches should care about the whole bunch of the
inclusions, and not just about kernel.h. This means each driver should be
carefully inspected in accordance with the IWYU principles.

-- 
With Best Regards,
Andy Shevchenko


