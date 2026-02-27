Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25BB41B34E;
	Fri, 27 Feb 2026 14:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772203732; cv=none; b=XAKUWhqDQYF1sgpa9aNRO42c3NoCA0enXglGXCOkl5bmKDT3+HC+wlhKND6MCY6yM44G5JmmQcnNb+CuACV7qxAE/DbiFylcXenRxiXxR73P48O7rN+xCzDXOfLJ0toOJkQ3agFC0HyAmoONMmfdgu0uLVhQUhmLThPzZbBqCDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772203732; c=relaxed/simple;
	bh=o2CIKvP6BgZVZbqHIwC6fwPiqZgBrGBNDCCvqtAEILM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAAP/g1xa4JGPT/WvH1MKues4wKLGvoiyhFe3EJtMPwoNNrYuw6yht2MYzzUgLIeYTaGa/YGylUDtZtG7IYLEB455QL/56kooHE+q4LCUAUNV9BMK5swnISueAJ08s87eS5kzntxstypXH7Bb0SJ+5t/HE8Me/SRAq6hFyb8rwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fl7RTTnW; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fl7RTTnW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772203732; x=1803739732;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o2CIKvP6BgZVZbqHIwC6fwPiqZgBrGBNDCCvqtAEILM=;
  b=fl7RTTnWbKfimurRHgKwW2WvZfrir7sxhr7LNLPnTE40Qz25myFdVc/5
   8WuyYLCPQxoFZAfhz/lxQoQA+WS7GZhD07x6yYBDoaWF+G5S5ds9OVASB
   V6TWnil1Ll7hgBU7B4YaqIczbYOvXS2o2GtILMYMaRhq15wtT1mjiyArN
   rc+prdGgyTBToiXA5vKl4SL5VtpX1CDFCaJF2J58+I0wF/3kJP+iFcZHD
   zcj4SluHNzh26zn2qcJG8QPdeEcBsiIyRbsZU0MaRRoBO+FOdkPyhVcVn
   UhymjAXAR9afvP0PZdwh+VajLmoa2zwPwqOs9pLn/ixceAOYOX29Bo9Js
   A==;
X-CSE-ConnectionGUID: P4TdliHGTvSMN6wlJ4KXyA==
X-CSE-MsgGUID: niZP0eYcQd2cIbaOWpw3aw==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="73158302"
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="73158302"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 06:48:52 -0800
X-CSE-ConnectionGUID: Ql3j+WgTRL6qiS/6tqkY/g==
X-CSE-MsgGUID: stH7AM2gSsuchCaqB+8fKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="221418946"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.180])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 06:48:49 -0800
Date: Fri, 27 Feb 2026 16:48:46 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	"Sa, Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/6] iio: use dev_err_probe in probe path for ADI
 drivers
Message-ID: <aaGuzkHk6kCkcyiz@ashevche-desk.local>
References: <20260225150615.274078-1-antoniu.miclaus@analog.com>
 <aZ8gCD3YXvrNscQo@smile.fi.intel.com>
 <CY4PR03MB3399CFF77F5C0051731D64989B73A@CY4PR03MB3399.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR03MB3399CFF77F5C0051731D64989B73A@CY4PR03MB3399.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 27, 2026 at 11:23:10AM +0000, Miclaus, Antoniu wrote:
> > -----Original Message-----
> > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Sent: Wednesday, February 25, 2026 6:15 PM
> > On Wed, Feb 25, 2026 at 05:05:46PM +0200, Antoniu Miclaus wrote:

> > > Changes in v3:
> > >  - Squash the struct device variable introduction and dev_err_probe()
> > >    conversion into a single patch per driver.
> > 
> > Why? Maybe my comment was unclear previous time.
> > 
> > The idea is to convert to short dev the only lines that are not being touched
> > by the second (dev_err_probe() conversion) patch.
> 
> Sure, so for the function which use dev only for the dev errors I introduce
> the struct device *dev = &spi->dev; in the dev_error_probe patch?

Whenever you use it first, there you introduce it. I believe in this case it
will in the first patch of each driver subseries. Whatever the first patch is.

-- 
With Best Regards,
Andy Shevchenko


