Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE40B3EFFA6;
	Thu, 15 Oct 2026 13:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792070562; cv=none; b=TU2Ax4Ygze9aPpr0Ku9lL1KCRlZbZEyYPOkQaBJsgB+d0ZAg016CsJ5+1JC8ePXuCXKY04zL9HUvR8wKCJxAB3ZSw8dyk0tk+h4okv+PePnU2vY9AZwxA9ja/brHwU5OUvpcDhXJ2YeWDrLGmrEwCUbX19G9Py9XuhEXjabUoFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792070562; c=relaxed/simple;
	bh=IXlVNMDkpK0+fZ4y8gNuDI1b+nRai2Bib1MjbJiOSTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PnVv/e02Ho7fSceaBNkqIvgvDR9WEinH8+CZtsE8RS2C044N5dio9UYpkCJ0LMQvjFemOZ1CR7f2y/y9VZU9YzSgJp1o8iSEgcrmr2vqdmcn6ltZyFCxJRLLSm3QILuLMheUX4jDC1dMgfrkbYjWU5XrTYdwOCJFZF3oKGRgCn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IOfDvkpe; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IOfDvkpe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792070561; x=1823606561;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IXlVNMDkpK0+fZ4y8gNuDI1b+nRai2Bib1MjbJiOSTk=;
  b=IOfDvkpeJBoFLWC0eSprE0VlbP4tf71qVDAAL0us0mObKwFokhPuLCYV
   xlY7touIsLei4AUV12O2paBOIvVuMkPkj2tTihf+Ifotsf9TW8syYSF09
   Fw2hlWicBiuIp6tZbIZq4y0JM01D5NrFAjfQrMNj0eql5FWxgBd6tnt+n
   KSBrmd/gjYVQNCZs2ODbo3Ip97cKW8T1v4XGXlhYR7SrIdaKDqbodjFkz
   KvippXyx0jW3BxWvCcmXEMAGOHTT0eJ0Ib4BqVLpnuIDaTz4gC5TItSfj
   xwPm7x7o0QmWndVaKZxW5fxcfr38bgEBas3oW8LKezinAEk5Gw2gyWGLM
   A==;
X-CSE-ConnectionGUID: ICbIEr04TbCizcJatjn6yA==
X-CSE-MsgGUID: 5SEWSCGzSVKbB3fv25IKUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="870429"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="870429"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 06:22:41 -0700
X-CSE-ConnectionGUID: 2wjwuFS8S5GhOWuEL3J+tQ==
X-CSE-MsgGUID: YrQLcR/uTtSgUIOFoTCGoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="2018679"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.117])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 06:22:38 -0700
Date: Thu, 15 Oct 2026 16:22:35 +0300
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
Message-ID: <atDTmxEp2KmTRUYf@ashevche-desk.local>
References: <20260925-iio-adc-ti-ads112c14-gpio-v1-1-2a2b218ebf3a@baylibre.com>
 <arom9T0azKX9jV5m@ashevche-desk.local>
 <f4ddbc02-1fdd-4205-b511-fb39329fa5f3@baylibre.com>
 <as46JtMAij8yqcVQ@ashevche-desk.local>
 <f8b97c1c-7dae-4eea-9d64-c2c81ab4ef49@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8b97c1c-7dae-4eea-9d64-c2c81ab4ef49@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 15, 2026 at 08:00:04AM -0500, David Lechner wrote:
> On 10/13/26 9:03 AM, Andy Shevchenko wrote:
> > On Fri, Oct 09, 2026 at 06:04:21PM -0500, David Lechner wrote:
> >> On 9/28/26 3:36 AM, Andy Shevchenko wrote:
> >>> On Fri, Sep 25, 2026 at 04:50:47PM -0500, David Lechner (TI) wrote:

...

> >>>> +static int ads112c14_gpio_init(struct iio_dev *indio_dev)
> >>>> +{
> >>>> +	struct ads112c14_data *data = iio_priv(indio_dev);
> >>>> +	struct device *dev = indio_dev->dev.parent;
> >>>> +
> >>>> +	for (unsigned int i = 0; i < ADS112C14_NUM_GPIO; i++) {
> >>>> +		data->gpio_names[i] = devm_kasprintf(dev, GFP_KERNEL, "%s:GPIO%u",
> >>>> +						     dev_name(&indio_dev->dev), i);
> >>>> +		if (!data->gpio_names[i])
> >>>> +			return -ENOMEM;
> >>>
> >>> Wondering if you can utilise devm_kasprintf_strarray().
> >>>
> >> That uses "%s-%zu" internally, so would add a "-" where I don't want it.
> > 
> > What's the problem with a dash?
> 
> I want to match the datasheet pin name.

I see. Sounds like we might need something more universal for
devm_kasprintf_strarray(). (Yeah, I understand that that is out
of the scope of your series.)

-- 
With Best Regards,
Andy Shevchenko


