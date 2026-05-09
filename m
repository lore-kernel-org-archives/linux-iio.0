Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2878003D;
	Sat,  9 May 2026 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778347014; cv=none; b=JCBkrLIjlOvL9LYBEcTbAciZbATYRxmUo4wh4+/6blAohZGdbugz1Nk4EI0u7A4HiTnR7b1jATeD8tnaZjR9nkISZrT6HvHRHZRAn6RlvHkUZschA5CqVChUUjGh5wI7IK85RL30i2q5L8dZGx2LGZ60CWT5NSvhwD/TQrC9ce4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778347014; c=relaxed/simple;
	bh=oakGKa3mPzrEro4zTVMxfCF3Rb/4/bXQXReM8fMDK5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlgZvJMBocolHUw5CDjDXsJQ8uY9whDNKhpdP608BDlXWhYD61kxcfe0/Z5pWlEhALdeo5xrHgUvLBQJ9duJKvz/rLrq3E/SZMYR3pd7gCrecVcEHF9K55VM4uzM9HTz9W3L9Gnmaw++lJObbWIkxAuaKi0QJcWYr7UDwtpU4TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jx04XEhY; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jx04XEhY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778347013; x=1809883013;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=oakGKa3mPzrEro4zTVMxfCF3Rb/4/bXQXReM8fMDK5k=;
  b=Jx04XEhYWEX3A7VKmMr8L0jyWDbKHZElsAArrzzYHIsaw+9fUoRjUQ4M
   /XoH8xIaN9/9Hbpr+nC8oIw4Zi1rnFx1FJs443ENgFJ6cSTyfzDnWsFaf
   MX1VcaJcPTDLgLRvCzvepBM66SLpqKig4qS+o+oXDQczXzK5UvSdwzw1J
   GK2uYLX1UR7ntuATfGrpVlD04q9CsKuPa65GxqhM85CN15MMGtoMD7OJu
   JQbdN3NUj/gmg1pdAhReM7EXz7xyERUXtlqArBNkIV3IryfeBnji1K3HW
   g8kYPqsE/ypAP641wUMvKmALRReIgw/nhJtcG4+6xGIb3D87EJxS6AxVG
   w==;
X-CSE-ConnectionGUID: hO3aoruxQ2ebvGIwag+nFA==
X-CSE-MsgGUID: o/XvlhyfRjmVU43JqCWbQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="96863455"
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="96863455"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 10:16:53 -0700
X-CSE-ConnectionGUID: +vI5qXllTmmPGR1SvlksnQ==
X-CSE-MsgGUID: dfxOTjWITDG+h16lF+oFsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="236988318"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 10:16:51 -0700
Date: Sat, 9 May 2026 20:16:48 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: joshua.crofts1@gmail.com, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] iio: magnetometer: ak8975: make use of the macros
 from bits.h
Message-ID: <af9sANQiuS_AFLPl@ashevche-desk.local>
References: <20260507-magnetometer-fixes-post-pickup-v1-0-37827ca68fb3@gmail.com>
 <20260507-magnetometer-fixes-post-pickup-v1-8-37827ca68fb3@gmail.com>
 <c0909d796cc6568be96e6afa795c83e2f9892524.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c0909d796cc6568be96e6afa795c83e2f9892524.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, May 09, 2026 at 10:09:03AM +0100, Nuno Sá wrote:
> On Thu, 2026-05-07 at 16:35 +0200, Joshua Crofts via B4 Relay wrote:

> > Make use of BIT() and GENMASK() where it makes sense.

...

> > -static const unsigned long ak8975_scan_masks[] = { 0x7, 0 };
> > +static const unsigned long ak8975_scan_masks[] = {
> > +	BIT(AK8975_SCAN_X) | BIT(AK8975_SCAN_Y) | BIT(AK8975_SCAN_Z),
> 
> Small nit: But maybe GENMASK().

Jonathan explained that this is *not* a bitmask while looks and feels like it.
So it is his request to not do a GENMASK() here.

> > +	0
> > +};

-- 
With Best Regards,
Andy Shevchenko


