Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ED43BBFDA;
	Mon, 17 Aug 2026 08:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786954952; cv=none; b=pj61jf6TuOBio3S3s5oEI2LB52o7Mku8DlkDpkqZzjDbXBtiqHvRw3u+WfLpjv9H07yJylq4wO1CN9YgX5ecKY8ru+shI0TSQMADVjRZwXHP4NkehkYH35muWjIDgG+CoO3UiUxNhqVIYqr8edlSRUg+sRzCbC/QQIjfvM6l73c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786954952; c=relaxed/simple;
	bh=ffyMtGtlHS1K92WptC/XnBZNY8Kc1ucjVyI6fh+PrAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5yl32q386zyILS90kJx1+xKj88NxmFxLdIQe8YbSNsdw6wGLkdaLQSQUqLJRwW/x4S8pGD5LLp7iLelqcFR5WqBMGoWrWiwnGDvdyBZn0fBq6eGYdJ++mhBcFthZ/uwydsCH//CV6xX6DdiCS2sp7/Wsf0RFBrZ4t3sPVbhKw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PFmRIKbn; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PFmRIKbn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786954950; x=1818490950;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ffyMtGtlHS1K92WptC/XnBZNY8Kc1ucjVyI6fh+PrAA=;
  b=PFmRIKbnfq2Agb9g92bd98Jb9sSLX1B5mzjMXmw+QXVOj2xO4TXmd1YY
   vIonRD8avWzqJtOVWxBUdsLFcUNsJqCyGdGtf8024GrF471v99wabkgsI
   al++RsecqGPmB9QUf0t+u16I75CFzKNp2t1pdaKocnnKewhsUlljm2UfH
   eJimeLBRXtqedZi+kEE2LvzTAdlTffSmQQJyjrp+XX6DRZjDIHfMbGaMb
   1ogIxoNgahp054pnyKYWbGNZD0GnWaKF4g+nP4lMSYBXp0+25Ex4AYSUr
   cvNmHHFZq6PGNLzX07K2JqxYwcImOrg/QBZ0secSMNBZAYGA180W6TEbp
   Q==;
X-CSE-ConnectionGUID: TCi5mdUqTNmUd9YpiAUO+w==
X-CSE-MsgGUID: B/CSshArQRaniVVEibeZqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="87444793"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="87444793"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 01:22:29 -0700
X-CSE-ConnectionGUID: t/8dd2iSQdiKu1QzBHEqpA==
X-CSE-MsgGUID: yVELMnJHRe+oba6BNl/o3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="262223866"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 01:22:26 -0700
Date: Mon, 17 Aug 2026 11:22:23 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Kurt Borja <kuurtb@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 2/9] iio: adc: add the ti-ads1262 driver
Message-ID: <aoLEv_txdTE7SqS3@ashevche-desk.local>
References: <20260807-ads126x-v3-0-f89925d72792@gmail.com>
 <20260807-ads126x-v3-2-f89925d72792@gmail.com>
 <20260816223029.0da04d1e@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260816223029.0da04d1e@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Aug 16, 2026 at 10:30:29PM +0100, Jonathan Cameron wrote:
> On Fri, 07 Aug 2026 22:58:24 -0500
> Kurt Borja <kuurtb@gmail.com> wrote:

...

> > +static const struct reg_default ads1262_reg_defaults[] = {
> > +	{ ADS1262_INTERFACE_REG,
> > +	  FIELD_PREP_CONST(ADS1262_INTERFACE_STATUS_MASK, true) |
> > +	  FIELD_PREP_CONST(ADS1262_INTERFACE_CRC_MASK, true) },
> > +	{ ADS1262_MODE0_REG,		0x00 },
> > +	{ ADS1262_MODE1_REG,
> > +	  FIELD_PREP_CONST(ADS1262_MODE1_FILTER_MASK, ADS1262_FILTER_FIR) },
> > +	{ ADS1262_MODE2_REG,
> > +	  FIELD_PREP_CONST(ADS1262_MODE2_DR_MASK, ADS1262_DR_20_SPS) },
> > +	{ ADS1262_INPMUX_REG,
> > +	  FIELD_PREP_CONST(ADS1262_INPMUX_MUXN_MASK, ADS1262_INPMUX_AIN1) },
> > +	{ ADS1262_IDACMUX_REG,
> > +	  FIELD_PREP_CONST(ADS1262_IDACMUX_MUX2_MASK, ADS1262_IDACMUX_NO_CONN) |
> > +	  FIELD_PREP_CONST(ADS1262_IDACMUX_MUX1_MASK, ADS1262_IDACMUX_NO_CONN) },
> > +	{ ADS1262_IDACMAG_REG,		0x00 },
> > +	{ ADS1262_REFMUX_REG,		0x00 },
> > +	{ ADS1262_TDACP_REG,		0x00 },
> > +	{ ADS1262_TDACN_REG,		0x00 },
> > +	{ ADS1262_GPIOCON_REG,		0x00 },
> > +	{ ADS1262_GPIODIR_REG,		0x00 },
> > +	{ ADS1262_ADC2CFG_REG,		0x00 },
> > +	{ ADS1262_ADC2MUX_REG,
> > +	  FIELD_PREP_CONST(ADS1262_ADC2MUX_MUXN2_MASK, ADS1262_INPMUX_AIN1) },
> > +};
> I'm not particularly keen on this formatting from a readability point of view.
> Maybe using named intializers would help:
> 
> static const struct reg_default ads1262_reg_defaults[] = {
> 	{ 
> 		.reg = ADS1262_INTERFACE_REG,
> 		.def = FIELD_PREP_CONST(ADS1262_INTERFACE_STATUS_MASK, true) |
> 		       FIELD_PREP_CONST(ADS1262_INTERFACE_CRC_MASK, true),

And looking at this, this has not to be booleans! Please, use proper integers
instead (I think 1 is what you wanted).

> //extra indent fine here for readability reasons if we end up with some long lines
> 	},
> 	{ .reg = ADS1262_MODE0_REG, .def = 0x00 },
> etc or just maybe use the more open form of the first element for all of them.
> burns a bunch of lines, but is easy to read. 

-- 
With Best Regards,
Andy Shevchenko


