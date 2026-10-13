Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C99E3B7B8C;
	Tue, 13 Oct 2026 08:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791881689; cv=none; b=rf+eFVTbxjj7EjDhrXVAwrtIFQ6/AG0qPvZbeRBmm1nXvFXjZOPy/VJH3USWzcGIRYPxDGFz5S/oy4OPxy1aAuV61NhEjRmJCKSga9W0/3rLcYMaZHcHxB+jlTBKRO+BcotRXMfkGMEZeoFLvOWnZHyAS6juqSZOuAz8L7v9/Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791881689; c=relaxed/simple;
	bh=qWCA0PkyTTsMxMXq2rZe1oUT1Vl6h90lQ16AJeWvkM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bc1i27ZiYAIIfwmIh+96bX4f9W7XfXLzxeYTVI3PGBmPZqv5cPgVP34oEBVDRTjUUMQZIbqL8v0IEDo7/aUKeRFBvc8uG5X0ua5GmpNq6UneL+F0SJJa8yL2VX8plEmbKOF11Xh2RDyJdWvydgN9SjQAaXfxNHgMQ2SdRcE0/Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YH1l+1gL; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YH1l+1gL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791881686; x=1823417686;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qWCA0PkyTTsMxMXq2rZe1oUT1Vl6h90lQ16AJeWvkM8=;
  b=YH1l+1gLKLjT+x9ESFvtQ0ap3BsmeIXw6D4l7FOzVskY6h2g3VwdkOac
   WQHMrnMqej+UjGtKmSpR9Q2OToHBsRLA+sNuOuWQoUlW9qg7vBjMqTP8f
   oYTJ8nf9BrNf+1xqmUXP4iEYw3Iv8iR//qW9N1F2c87cEPGoqV/2F+mSl
   G7g+vrPCLS8qghOs0cDCyiYVMmc8lrbUA8cxegIYIUfm43aEol+AWAerz
   leKa7taykMSwmdFlR+UqtZXHOB6Dj2jaG5cQrRbRVKGKM1H3sSGxhGxjm
   XnqDDvUM033cPNSWiuHq1P9a9CUqKTWyEnrXWAdwF2oXXhHmXH/ntxIyK
   w==;
X-CSE-ConnectionGUID: 61JNGzXYRLiv73bzDAMElg==
X-CSE-MsgGUID: KRB3nHJHTl2hj9hLnBqkFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="497006"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="497006"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 01:54:46 -0700
X-CSE-ConnectionGUID: kOQg4wxqSH6IrsWUAwr+GA==
X-CSE-MsgGUID: DcM9YuwRRm2zuBNdjRl+Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1068482"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 01:54:43 -0700
Date: Tue, 13 Oct 2026 11:54:40 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: raffaele.tranfaglia@gmail.com,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: addac: adt7316: use dev_err_probe() for
 ldac GPIO
Message-ID: <as3x0NQ9QXlg5-Kr@ashevche-desk.local>
References: <20261011-adt7316-dev-err-probe-v1-1-27a4a8ac74f3@gmail.com>
 <as1Q-au8dpp9YFeG@ashevche-desk.local>
 <20261013095007.000052ae@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013095007.000052ae@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 13, 2026 at 09:50:07AM +0200, Joshua Crofts wrote:
> On Tue, 13 Oct 2026 00:28:25 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Sun, Oct 11, 2026 at 07:56:22PM +0100, Raffaele Tranfaglia via B4 Relay wrote:
> > 
> > > Use dev_err_probe() when requesting the ldac GPIO fails. This
> > > avoids logging an error when the GPIO controller is not ready yet
> > > and the request returns -EPROBE_DEFER, and records the deferral
> > > reason. It also simplifies the error path.  
> > 
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > 
> > Although not sure if we need a Fixes tag as it might be an annoying (but quite
> > rare) case of flooding in the dmesg.
> 
> AFAIC this is a cleanup rather than a fix. dev_err_probe() conversions
> don't add Fixes tags.

I think it depends if one sees that problem IRL (see below examples),
but I am fine with or without Fixes tag for this.

59b991990a04 ("spi: hisi-kunpeng: Use dev_err_probe() for host registration failure")
5ff5505b9a2d ("drm/panel: novatek-nt35950: Don't log an error when DSI host can't be found")
ad1abe476995 ("power: supply: cw2015: use dev_err_probe to allow deferred probe")

-- 
With Best Regards,
Andy Shevchenko


