Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DA342CAEF;
	Tue, 11 Aug 2026 10:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786444050; cv=none; b=iTQZlV+ZneOX8iAA0M5OOC6CTFaJG3XDYtCui/I0An2It101SUNWGt0HTQv9zKdG9ugGgqCCHVYjFwUS6NLsnBk+6SHUFNzGoDVIxJgg75rzKN3H0CmzTXnqHPD0oODp4TJhqt6mXL4atYm0Ptoqfs/YBeyLBoSoiXrtzDK/Oaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786444050; c=relaxed/simple;
	bh=f/FF/HmFixyeXAFRWPauGVCFVxMdFnLtXERcRTY6L6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFCswTyz9b8iYtVOdbqjYeXXW20cCU9t4twg9++3VJfajOHDyl7jltnsJmcxAtNqykVCkTHKygwHUYmuOoLCcFdOJBGhzHRTwQnZ5AugWEP9odTJW0fOgNvIBBZ5umdlHgU2wE1qao9q2xxOMHke4JHiIjkNn6HmuQjylaFh5jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V6hi1m4T; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V6hi1m4T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786444046; x=1817980046;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=f/FF/HmFixyeXAFRWPauGVCFVxMdFnLtXERcRTY6L6A=;
  b=V6hi1m4TiLVlSysK9PJMVyJB+fvsezODfYeudP1xkqxLWOK7Gfotm/5S
   Io3l1YM1BxIBp3QGfyQODeEakKm9df9F49jqMzYfYOf9cg22kVf+wa3Z7
   plyays0c7HT1gfQkg8ftzrvq5dz4tCzbx5FEJTXz6/j8KFcgKumKjGpH9
   9BocBTPZvcPEzaROYJhk7ugssPXnNwMHGbC+nAjUj3a6r/PbZz+b8Te+2
   w6Q04/Sg2n2RYnBl/KeH2qRPBOGLddFIUJp4Uvgf1+VknjlLHtCd8+LDW
   yZJ5RAHq2LvhCRLDhn2EeRRbB7Lb4gALmrfaLFnx+trTYXZF7MoB7CsGG
   A==;
X-CSE-ConnectionGUID: OYIRUsGMR4OMTuIW1UBGzQ==
X-CSE-MsgGUID: oSF4TgXITACeC35kaFXzLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="90653822"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="90653822"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 03:27:23 -0700
X-CSE-ConnectionGUID: Ty2AYhTyQmi8KlMkwvQXrQ==
X-CSE-MsgGUID: GJfZIQ/pQ3utjd8FaHD4jQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="259991747"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 03:27:20 -0700
Date: Tue, 11 Aug 2026 13:27:17 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [PATCH 2/3] iio: light: stk3310: add per-chip match data
Message-ID: <anr5BeHK-dboSBl3@ashevche-desk.local>
References: <20260810110423.41697-1-jorijnvdgraaf@catcrafts.net>
 <20260810110423.41697-3-jorijnvdgraaf@catcrafts.net>
 <anoZwgq6ZO_VY064@ashevche-desk.local>
 <20260810215157.154384-1-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260810215157.154384-1-jorijnvdgraaf@catcrafts.net>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 10, 2026 at 11:51:57PM +0200, Jorijn van der Graaf wrote:
> On Mon, Aug 10, 2026 at 09:34:42PM +0300, Andy Shevchenko wrote:
> > > +	chip_info = i2c_get_match_data(client);
> > > +	if (!chip_info) {
> > > +		/*
> > > +		 * Clients instantiated through the sysfs new_device
> > > +		 * interface under the lowercase compatible-derived name
> > > +		 * have no firmware node and do not match the uppercase
> > > +		 * id table entries.
> > > +		 */
> > > +		chip_info = &stk3310_chip_info;
> >
> > This is an interesting comment and approach.
> >
> > > +	}
> >
> > - Where does this lowercase come from? Is it Linux forced conversion?
> 
> No conversion - the client name is whatever is echoed into the sysfs
> new_device file, and the lowercase spelling is the one that binds via
> the OF table: for a client with no firmware node,
> i2c_of_match_device() falls through to i2c_of_match_device_sysfs(),
> which matches the client name against each compatible and its part
> after the vendor prefix, so "stk3310" binds through
> "sensortek,stk3310" - the same lowercase name a DT client gets from
> of_alias_from_compatible(). The id table lookup stays case-sensitive,
> which is why i2c_get_match_data() comes back NULL for such a client:
> device_get_match_data() needs the firmware node it does not have, and
> i2c_match_id() only knows the historic uppercase names.
> 
> > - What's wrong with simply failing the probe?
> 
> It would break a path that works before this patch: probe consumed no
> match data, so "echo stk3310 0x48 > new_device" bound and probed fine
> (we used exactly that during bring-up, before the DT node existed).
> Failing it would be a userspace-visible regression in a patch that
> claims no functional change.
> 
> > As far as I understand the problem is preexisted. Or was there any default
> > taken? How do we know that the chosen default is a good one?
> 
> The path preexists; only this patch makes probe care about match
> data. Before it the driver had no per-chip data at all - every client
> got the same two channels and the hardcoded "stk3310" name however it
> matched. The fallback selects stk3310_chip_info, which is exactly
> that, so a client that probed before this patch behaves identically
> after it. What the default cannot give is the new part's extra
> channels: an STK36C61 instantiated under the lowercase name gets the
> reduced legacy profile, and the id table spelling "STK36C61" selects
> the full one.

The problem preexists. I just looked into the Git history of this rather broken
table IDs and what I have to say and state is the following:

- the driver initially was written for ACPI and the author blindly (cargo cult?)
  used the same IDs as for ACPI _HID, while they have different rules

- there is no existing in kernel driver that supports enumeration based
on I2C ID table

With that being said, I think we may just lower the case for the I²C ID
table and fail enumeration when there is no chip_info provided.
Yes, it will break very weird use case with capital letters via sysfs,
but TBH it's a niche and people should know that most of the devices
are enumerated as part number of OF compatible in that case.

Also note that the DT users should also not use sysfs, and instead call
DT overlay.

I can take all the blame on very unlikely event of a breakage of somebody's
setup in the future. TL;DR: just add a first patch to lower case the IDs
with Suggested-by my name and I will give a Rb tag with full conscience and
responsibility.

-- 
With Best Regards,
Andy Shevchenko


