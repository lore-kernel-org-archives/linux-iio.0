Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6153E3168E1;
	Sat, 18 Jul 2026 06:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784356116; cv=none; b=MOOpiTs3DU+u6V0nx6GXKEeAufOfDIo9s4SxpSUKH+raGRMLwHJ2gLum1S3euGavH9ujkeI2lITKSec8HOBKe5RASHfShv5Bex2N1xUf7jPpoOEQAtSW35UXqIMGERY0ZPh5s4Xdv5aCOv7ErXlIZO88l0debYMc5mgTmNGQgxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784356116; c=relaxed/simple;
	bh=72O7p43mayACSsHgnRrmS3L0fM+EZV3vx0nMEFksMl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHIsxmfRoir+yQVr2e5XUE50/OTBxK36m9ZtZwfA6KW9nDGRXRA20GRv4MS8+84PKjlIcIIzkkaWcvQD0MzORmL3cCO+Kg5GKrjGIyvnIHvVSSvIh8SgwK1QOBC5TPK0IYmdE6RHRCOQve33Dwdj8WwwAKa/MUy7B4hFzOTKC4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RXlRwlgW; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RXlRwlgW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784356114; x=1815892114;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=72O7p43mayACSsHgnRrmS3L0fM+EZV3vx0nMEFksMl0=;
  b=RXlRwlgWqGULlMHD1wuEOr3wrmL3HuXBpdJ0q0dyxL/UNlnYHusBBIda
   gPVPxy07txckXavgfTQNkuX2h+K4OMs/XmA201Gr7IPasY4uVyFEBcTqF
   NlewbVUFGweTIvYN5KzDURWYpNBGYlz+zqCVqs47qh+F4k/48mfaIOToP
   5I+OjLThokLCzhDbt7g0tiza8DJAjxZiiTOm1rrnwfX1jVKpVY/B09KlH
   QEjEY70rZNiGG7yr4Mx6H6VpGQ2wUzZmAVpXdTUN80/hf/sbF5aD25AI/
   Gnx7YnjjAjW9t7GHXtcP5SrKJBMyOOh8YjwiT69phSaglGke70iCbh5xr
   g==;
X-CSE-ConnectionGUID: yuMnOHVsTUeBHNXB7KZRhw==
X-CSE-MsgGUID: YrNnn07kSgWZJq4Xb+s8zA==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="72554972"
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="72554972"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 23:28:33 -0700
X-CSE-ConnectionGUID: C8vRVAvmQ/m3ruZDQ6nAIQ==
X-CSE-MsgGUID: usai9vZWRq66dsqjjRzcpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="280248491"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.22])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 23:28:30 -0700
Date: Sat, 18 Jul 2026 09:28:28 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <maxwell@maxwelld.cc>
Cc: Pan Chuang <panchuang@vivo.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Gustavo Silva <gustavograzs@gmail.com>,
	Maxwell Doose <m32285159@gmail.com>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Siratul Islam <email@sirat.me>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/13] iio: chemical: Remove redundant
 dev_err()/dev_err_probe()
Message-ID: <alsdDLZmctNCeu61@ashevche-desk.local>
References: <20260717094408.509583-1-panchuang@vivo.com>
 <20260717094408.509583-4-panchuang@vivo.com>
 <DK16R0RUSGG9.2LHH6CNKD0IAV@maxwelld.cc>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DK16R0RUSGG9.2LHH6CNKD0IAV@maxwelld.cc>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 17, 2026 at 05:05:22PM -0500, Maxwell Doose wrote:
> On Fri Jul 17, 2026 at 4:42 AM CDT
> Pan Chuang <panchuang@vivo.com> wrote:

...

> > @@ -686,7 +686,7 @@ static int scd30_setup_trigger(struct iio_dev *indio_dev)
> >  					IRQF_NO_AUTOEN,
> >  					indio_dev->name, indio_dev);
> >  	if (ret)
> > -		return dev_err_probe(dev, ret, "failed to request irq\n");
> > +		return ret;
> >  
> >  	return 0;
> >  }
> 
> Please split per driver and resubmit and feel free to add
> 
> Reviewed-by: Maxwell Doose <maxwell@maxwelld.cc>
> 
> once you do that.

This is trivial enough, so this sub-treewide approach is okay. When you want to
give a tag for certain piece of such a change, use comment style

Reviewed-... # for sdc30


-- 
With Best Regards,
Andy Shevchenko


