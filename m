Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E80317A2F6;
	Sat,  9 May 2026 06:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778309553; cv=none; b=QgiqAvncjH5Al3lTEwMn2yZe2dgnwkRny5KiHP2T3uGaH2IGrmJ6nG8DIpjC2XJm1lDMDrb52VmQSiPVkReITgk/ZgCugopw0MNabqFPFPA3DDIlNJVHla4GKRjjyO3yvsUqxBGmDWh+w88vWT5pnH5QWeb/5Q0YsXz0aBlglcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778309553; c=relaxed/simple;
	bh=q3YuQqCN1FLJVM9GtzbgG7SjwqyrmjDbdg3Pb4iPCUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTwuNwZYl9GUHl9O2aCPm+1cCs6UL5jzxyvn1lAFjt9vWg7usaV0jXfK4dy5x5sPW8sAdwgUsvnBKZ8VizMkVefclEzI9MMilgT4yKu9JsC2BGcIRdEuuzjWLRii0yNW4+fbktG7Vs8OurdMKAz84MynyUfCPak7sqyVxnYEWe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FBOL+Bnp; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FBOL+Bnp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778309552; x=1809845552;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q3YuQqCN1FLJVM9GtzbgG7SjwqyrmjDbdg3Pb4iPCUA=;
  b=FBOL+Bnp9UqaQDmr3Dz/pbtoEmhhnkGv0bOQ7lrWnd37qjeBGraAOdRc
   atm1+31iOFysq03WdY137GxHtjqhDu5gng+w2je4DnkWc4wpnMbzRpcol
   woabo2EbZsW7ve8WTQhooTgQn52I88GQTqk954r1804OvV8D0VWooJXSv
   SX++YEGgSS3+BHF+hPEDCO187YwAU2EFrNCEabtgUoP+MLrxUyfPkOJ0o
   i/FM20w6bSPE1SYq6TQHsLw7HxMStdyayT6k8VyGFU8A/ACTgYP6unEDB
   dmfljCc2VOtJ29DC/9bCSheSpMLyMkcDC2V3Q1HqF6g80WNuJu1Id7nFx
   g==;
X-CSE-ConnectionGUID: reZus18aTUaCWHScK3ugoA==
X-CSE-MsgGUID: G2xVvflCQ+K9knCPDYC2OA==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="101949108"
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="101949108"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 23:52:31 -0700
X-CSE-ConnectionGUID: pxee5zvOSg+Lnbv1yTJWDA==
X-CSE-MsgGUID: H+F6bgXzT36Xq+lTdGXOQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,225,1770624000"; 
   d="scan'208";a="241967419"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 23:52:29 -0700
Date: Sat, 9 May 2026 09:52:26 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] iio: magnetometer: ak8975: switch to using managed
 resources
Message-ID: <af7Zql3NkhDwKWBc@ashevche-desk.local>
References: <20260507-magnetometer-fixes-post-pickup-v1-0-37827ca68fb3@gmail.com>
 <20260507-magnetometer-fixes-post-pickup-v1-3-37827ca68fb3@gmail.com>
 <af2zup3PFlgs2DtE@ashevche-desk.local>
 <CALoEA-y-Qg22NSfVBLtqx4VFp0q=xqLOuL5Wf8TxW1AswW1+hQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-y-Qg22NSfVBLtqx4VFp0q=xqLOuL5Wf8TxW1AswW1+hQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, May 08, 2026 at 03:51:06PM +0200, Joshua Crofts wrote:
> On Fri, 8 May 2026 at 11:58, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, May 07, 2026 at 04:35:52PM +0200, Joshua Crofts via B4 Relay wrote:

...

> > > +     /* Only power down if currently active */
> > > +     if (pm_runtime_status_suspended(dev))
> >
> > Is this one a correct one?
> > We also have pm_runtime_suspended(), which is different.
> 
> As we only require the status of the device and not the power.disable_depth,
> pm_runtime_status_suspended() seems adequate.

Last time I have checked the code on this I remember that probably this one
doesn't guarantee that immediately after returning to the caller the device is
still in a suspend status.

The difference between two as documentation said is in "...if runtime PM
is enabled for @dev..." for the pm_runtime_suspended(). So the
pm_runtime_suspended() is stricter in that sense.

-- 
With Best Regards,
Andy Shevchenko


