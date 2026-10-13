Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BB33EC699;
	Tue, 13 Oct 2026 14:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900205; cv=none; b=lTGYLwoSUX0BSLm3chroAXCDj54i03zmHWgE5VTWiRh9eBbQVR0JasWXJ7hId1QLCTwiY5AaSDxXTXMfsOEewE72XrpJdDoQzvf39cofQJnlt57XvEp6z+KN1O5cmoVcskvbqCSP++9WX2GtGOWVAVOLei9joHiL9wlX07q09oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900205; c=relaxed/simple;
	bh=u+V/iK8jw/8LANpRM3jBSBG3EkByTpLSxWUoc3Org94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjmyMJ83asV3/fEjBbMO+p5+aCqa0FGZbueM8TwtJrx6F2uHyGjEpyzrPcv51i9/cxJ/ZNIsZiVgh3hu1QybgG6y3HElZh44/qIprJGRWWzYu84DGcOcoONPOpjl2MJqZlcCi1ffsR1/Wf/aK5VtWbrREQdKvqApRxe+ydk6oUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ncYu1Cg2; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ncYu1Cg2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791900205; x=1823436205;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u+V/iK8jw/8LANpRM3jBSBG3EkByTpLSxWUoc3Org94=;
  b=ncYu1Cg2HvHw4wdaqppp+M4HRjoeC1hOTxqQv0P7veyF3/uqecFs3+CJ
   c6B452Idi3vUxL672/9WnBEvlvqVfrH6BVELo2smoYbiQYGDTNWVtJbW6
   MbjMdpU527c3DfAYIPeY+J09dmEH5AyE3A1NEyyNztOzhasRZhZAw+PwP
   Czel2SbrJr7Mr97ucH/wfwXVa5uMySBMfG4lwId6C0dUErlC2pWoymSw4
   m5HA4w+P0SOJa9fcK4PpgfhNLXksesX2I9rxgcRQ4jBxUHkqL54br/AX9
   OmUGaNiC09wb5y0L6uQWYexSEUQs8q77XMGb35Yn8Et3uO7vyWVFVJIsJ
   w==;
X-CSE-ConnectionGUID: 9VYMGr5jQlKGuIOCmDGusA==
X-CSE-MsgGUID: efYogt2FRH6XcrRGFthkuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="500104"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="500104"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 07:03:24 -0700
X-CSE-ConnectionGUID: v0W2HnSAQqelZQCTHreGWg==
X-CSE-MsgGUID: cNa3D2sUTJ+3wWDWrzfblQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1240681"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 07:03:21 -0700
Date: Tue, 13 Oct 2026 17:03:18 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>,
	Kurt Borja <kuurtb@gmail.com>
Subject: Re: [PATCH] iio: adc: ti-ads112c14: add gpio support
Message-ID: <as46JtMAij8yqcVQ@ashevche-desk.local>
References: <20260925-iio-adc-ti-ads112c14-gpio-v1-1-2a2b218ebf3a@baylibre.com>
 <arom9T0azKX9jV5m@ashevche-desk.local>
 <f4ddbc02-1fdd-4205-b511-fb39329fa5f3@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4ddbc02-1fdd-4205-b511-fb39329fa5f3@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 09, 2026 at 06:04:21PM -0500, David Lechner wrote:
> On 9/28/26 3:36 AM, Andy Shevchenko wrote:
> > On Fri, Sep 25, 2026 at 04:50:47PM -0500, David Lechner (TI) wrote:

...

> >> +static int ads112c14_gpio_init(struct iio_dev *indio_dev)
> >> +{
> >> +	struct ads112c14_data *data = iio_priv(indio_dev);
> >> +	struct device *dev = indio_dev->dev.parent;
> >> +
> >> +	for (unsigned int i = 0; i < ADS112C14_NUM_GPIO; i++) {
> >> +		data->gpio_names[i] = devm_kasprintf(dev, GFP_KERNEL, "%s:GPIO%u",
> >> +						     dev_name(&indio_dev->dev), i);
> >> +		if (!data->gpio_names[i])
> >> +			return -ENOMEM;
> > 
> > Wondering if you can utilise devm_kasprintf_strarray().
> > 
> That uses "%s-%zu" internally, so would add a "-" where I don't want it.

What's the problem with a dash?

-- 
With Best Regards,
Andy Shevchenko


