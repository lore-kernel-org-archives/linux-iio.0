Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1F1175A6E;
	Wed,  6 May 2026 08:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778055542; cv=none; b=dLsdbgEUPUTwb0IzAB4dJhaJElPHa/CpdflUyNic/+xljPIGYYVKfVXtE81sl8Y5NOhRN9vOZEUB7J0g5fqUeeTIhcakudMLHkL01yXKaGWpiyLqoKkNQjzAjAaxWe8Jq5+VMjApiyPgd3qGkffE3jGlhWOpNWrkZ0lWkCWOUGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778055542; c=relaxed/simple;
	bh=4GOVsIOTLRnqjh5HUSiYYoTn2kORbuBsXUN7x22fjkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKtuZdDFlrwW7S0BCwzeE0ZGMVIjcGCNic5y+O+G8woRnQ74OQzhEaNS98YWbqJKPe6cKgbqkFunEsf23+VXhWLdBMHuH+FZK6ocEbIMmN3afubfgUapD6EyxwD+2ITYdBcU+gmAdWk2Q/o56KiLqG/PRy8dUXIK8CMQ9SkSArY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DRhscTp8; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DRhscTp8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778055541; x=1809591541;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4GOVsIOTLRnqjh5HUSiYYoTn2kORbuBsXUN7x22fjkk=;
  b=DRhscTp8/d+rduivT3so//gX5beJvIDkORZUEGKF4wMvNrTaU/vVQ1rV
   VWCZcTLyg0s6jhrQ9yhPkmB5bintaCYll6SOObP6xAhMObdLICIGv8kmA
   YzVimmOrWvjnztD6U+EZGEJ1mm56f820bG00hrVMjF632Y/Nko1fpWgUl
   1Fc9Z4dVf6ZMTaBCuxcs/SAve89G6P1PZBiotEQpAPgwHxQAQr3pSiVRi
   AdRY4/3Q5NQzOys/GTRcvTcOBLKAC1Ogyz2KxH2iNYzbAJzJGJuohwIAa
   1DKbol3ASGsQFQBJTLsEgRG7snwteXrChJsVeQKY+Ik+GIsLIF652Z6Yg
   g==;
X-CSE-ConnectionGUID: 7580Vd3cRcyC9xv+7lt55Q==
X-CSE-MsgGUID: hzcH2Pe0Rv6colBA08BU5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="90356686"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="90356686"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 01:19:00 -0700
X-CSE-ConnectionGUID: WauaBz0RQwaA9iPjqBokHw==
X-CSE-MsgGUID: vjyR0myKR6639FXsevMO5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="233415401"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 01:18:59 -0700
Date: Wed, 6 May 2026 11:18:56 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salah Triki <salah.triki@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: lmp91000: fix probe order and cleanup paths
Message-ID: <afr5cCLrpiMRaPe0@ashevche-desk.local>
References: <20260505194624.98520-1-salah.triki@gmail.com>
 <afr5K9aEfOKUJm4Z@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afr5K9aEfOKUJm4Z@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 06, 2026 at 11:17:51AM +0300, Andy Shevchenko wrote:
> On Tue, May 05, 2026 at 08:46:24PM +0100, Salah Triki wrote:
> > Fix the initialization order in lmp91000_probe where the immutable trigger
> 
> lmp91000_probe()
> 
> > is set before data->cb_buffer is initialized, which would cause a NULL
> > pointer dereference.
> > 
> > Also, correct the cleanup labels in the error path to properly unregister
> > the trigger before performing the triggered buffer cleanup, following the
> > standard LIFO (Last-In-First-Out) resource release order.

...

> > +	data->cb_buffer = iio_channel_get_all_cb(dev, &lmp91000_buffer_cb,
> > +						 indio_dev);
> 
> I would go with a single line here.
> 
> > +
> 
> Despite being in the original code, please drop this unneeded blank line.
> 
> > +	if (IS_ERR(data->cb_buffer)) {
> > +		if (PTR_ERR(data->cb_buffer) == -ENODEV)
> > +			ret = -EPROBE_DEFER;
> > +		else
> > +			ret = PTR_ERR(data->cb_buffer);
> > +
> > +		goto error_unreg_buffer;
> > +	}

On top of that fix the Subject as Joshua suggested in the other patch.

-- 
With Best Regards,
Andy Shevchenko


