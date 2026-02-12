Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D367ABA21;
	Thu, 12 Feb 2026 20:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770926493; cv=none; b=D1u0YeHScSCQr/p89/cDO/8o0Nv9D76VBsHuNaMACDMtDQyYS0wKBr45R+9geOPvQVgLd0yI/Vl8R008+jik3WWYazDzDhBjJy7MQ2B6aCfV9N67WuwL1KmxEx1L6gZ8p4hfTjcQTdrnRfMT8zJ31PM+JTKbfU+h08OZqIRmvWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770926493; c=relaxed/simple;
	bh=n/vJRCrCNULp9io0l1cfIC8bcJMTWtP4uWXt+A+6sNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HthxBnl9OktzoLIc2QHcR2B96A39KwEy4kKoWxI3nm2k6W4YYcYzp3SrrAnG/++QP/lAqzqVkO15Jtwpl2Jn56kPQ3nr/GpRpb676tKUWfHh9vmbpM16FajbCWzvf4IAl+xLMFYOIO7sU/DpWYtqU3Lhd/JtWI1V5zgtRhnbQ60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AWO2y0vQ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AWO2y0vQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770926492; x=1802462492;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=n/vJRCrCNULp9io0l1cfIC8bcJMTWtP4uWXt+A+6sNk=;
  b=AWO2y0vQ1EsmlSJsUomtrN7yAixPBTQcq6c+f0L82/0oftmbRERpNauK
   fWCiM297RhOv2kxs64xHq+SaEjcfwRup2/nyHGWKg3/RFJ+hCzDWTkTC8
   x0KZZnRIc46Yao9i8IhUYZmsc1jfj1rmyuoVE7GOvoeX8/E/FIlK1ocQZ
   CIGJq4aICWBSlahIaa0LU65e6o8HqvnbyrMxSMI6716mB1eJUGECp4v+2
   LHjRyqyCkmTRhPJ6q5JeB8MhR44VEn7xs8aGF0wMPC4+LNfyNL/GtPbXr
   rDfIaIghY8sE+YpNQaF6c5luER+KWHNT+pz/EJDsmsYtDecoaAzrVORBd
   A==;
X-CSE-ConnectionGUID: v2aTbgTyQumvdvqkHn3HrA==
X-CSE-MsgGUID: Bcj0+U+ZQ4K4TMe2vjhezw==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="82837390"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="82837390"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 12:01:31 -0800
X-CSE-ConnectionGUID: XppEVrBpQP6j7L9ei68XcA==
X-CSE-MsgGUID: n1CZ5GICRzqEkVOw7gni2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="216859523"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.145])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 12:01:28 -0800
Date: Thu, 12 Feb 2026 22:01:25 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Yasin Lee <yasin.lee.x@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/4] iio: proximity: hx9023s: Protect against division
 by zero in set_samp_freq
Message-ID: <aY4xlfSJwFGt1IPA@smile.fi.intel.com>
References: <20260212-upstream-20260219-v2-0-2b28fce5d09e@gmail.com>
 <20260212-upstream-20260219-v2-2-2b28fce5d09e@gmail.com>
 <aY2xveYRXEKIBV92@smile.fi.intel.com>
 <CA+NOmzLMzWqnS0B9B96qJUU2EoYppDKO6_Rdu52_dPqWTSS+ig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+NOmzLMzWqnS0B9B96qJUU2EoYppDKO6_Rdu52_dPqWTSS+ig@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 13, 2026 at 12:44:57AM +0800, Yasin Lee wrote:
> On Thu, Feb 12, 2026 at 6:56 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Thu, Feb 12, 2026 at 02:26:53PM +0800, Yasin Lee wrote:

...

> > Not sure about this. Perhaps we should rather do
> >
> >         if (!val || !val2)
> >                 return -EINVAL;
> >
> > ?
> 
> Agreed. I will update this in v3 as below .
> ...
> if (!val && !val2)
>     return -EINVAL;

> period_ms = div_u64(NANO, val * MEGA + val2);

Then don't touch parentheses, as the line will have nothing to do with
the scope of the patch.

-- 
With Best Regards,
Andy Shevchenko


