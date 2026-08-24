Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CDD36F91B;
	Mon, 24 Aug 2026 15:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584018; cv=none; b=L+RyImYmZ8spZPtoINXz7bWFBaoC7XBaQkN2qsH0PAYkv+89X8iV8N0tDznCNuIFA4HkS1UyLGD9abb2+VT20mOOk1ccLYgxYYCbSBqoujSjl9QTgGU3sg6BH7uFllr1mVupq2rRltVHgNbaj1LwNDNpBuoqrNY9jrcj0/HmA2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584018; c=relaxed/simple;
	bh=yKUnYbg/8SK/30O7cmDvkg9NK7A9m6n/C5vk+v6dJaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2tNztccTFnLMtsnM/ZUD7yCZGqi0yqJfjF0juGwYIYwP404otnwknEoU7U6R/03dEVFsPfmu+8qN9e29v1YKjRUl2ry5OQqyEnU58I9i/5aPrH+u2llsEBkhagXut0NgEWSzghFhq6Vnb+VHqAVKC6k8qHFXxoWJyrBxghPVzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ewS9Wosn; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ewS9Wosn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787584018; x=1819120018;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yKUnYbg/8SK/30O7cmDvkg9NK7A9m6n/C5vk+v6dJaA=;
  b=ewS9WosnODLF/VYBuEmrVNHfBF4C6eO93400sJFcaNO6+Myfw0CNbDIx
   RlY6pochOBvvre9SDjI7MpsNUmUvAUa67APtn6P5P6EAAusWzTk3T/Ol1
   hX0o3D896WprwB7CRNnm8FG6Vvv7Ze/OUg4ASf+HIvmWe1UnUMarsOEqy
   TCC3WPVW6FGi1PQq8jGRvV1PjEj4d6XciYNM7roy4i416EIgRovbZAtsj
   SnsU5M0M2yxYX4h9QkcbcdhtiOLR7V/+zIi2TKg4r00hV3Ek2ZfVC6M7c
   hdGfVKHuj212Dy52y73n/KSogfBDzSFXx1ODDWZMFbUIsZfq6TrQQHP8g
   w==;
X-CSE-ConnectionGUID: MIBa/CrrSSasyrCDepUOhQ==
X-CSE-MsgGUID: r/yeLOQ4T2W7G19Yfi0kXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88051817"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="88051817"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 08:06:57 -0700
X-CSE-ConnectionGUID: +O3VUrxiRTKEzR8XNqG2Sw==
X-CSE-MsgGUID: tE2pJXz3QTetpGJ5NTAsyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="271235995"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.130])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 08:06:50 -0700
Date: Mon, 24 Aug 2026 18:06:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Janani Sunil <janani.sunil@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Michael Walle <mwalle@kernel.org>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org, jananisunil.dev@gmail.com,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v3 05/14] iio: adc: Add AD7768 and AD7768-4 core support
Message-ID: <aoxeCDspYo_jaBhx@ashevche-desk.local>
References: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
 <20260813-ad7768-driver-v3-5-cb554399ad26@analog.com>
 <20260816201049.480143e1@jic23-huawei>
 <31aa140058fde422c12e34fe926e7df01ba448df.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31aa140058fde422c12e34fe926e7df01ba448df.camel@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 24, 2026 at 04:45:01PM +0200, Philipp Zabel wrote:
> On So, 2026-08-16 at 20:10 +0100, Jonathan Cameron wrote:
> > On Thu, 13 Aug 2026 15:56:58 +0200
> > Janani Sunil <janani.sunil@analog.com> wrote:

[...]

> > > +static int ad7768_reset(struct ad7768_state *st)
> > > +{
> > > +	struct reset_control *reset_ctrl;
> > > +	unsigned long reset_low_us;
> > > +	unsigned long mclk;
> > > +	int ret;
> > > +
> > > +	reset_ctrl = devm_reset_control_get_optional_exclusive(regmap_get_device(st->regmap),
> > 
> > Probably use a local variable for struct device *dev = regmap_get_device(st->regmap);
> > to reduce line length.
> 
> Or just pass dev into ad7768_reset() as an additional parameter.

It might make code be less understandable as this function is not something
like devm_*(). I slightly prefer my suggestion over this one.

-- 
With Best Regards,
Andy Shevchenko


