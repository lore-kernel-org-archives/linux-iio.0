Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029DA421A13;
	Wed,  1 Jul 2026 10:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782903326; cv=none; b=QcCS8sh/4swluh75QECeyWEWw9Rvs9tQixGfK/215qXyWBJZDurhRv0pq/wmPKxVNP+YiJyCaTfZwT/cVCuj9hulRcKwYbsQVbwB/8/Mn1+aVgAAiVeHu0SLWa4BpIqZ/17orWoOmxCy4/9CoNL174uzjUKAeDWQ/1/srdw9wek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782903326; c=relaxed/simple;
	bh=ZjS6liPi1NdySjNIcGtNItMWzhUoGpTQ0kusW/xwebI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hR7TVhvyIaxz7M79if9E1DZ9uDHw7hjbYb5fcZsyNq4CQpihQFPfSYqpXP94ii8A7ygHJY2XWFqPmnyd9oeZsr+AMprPS0OSpftqMY7A/sJTyxKz38fiXIb1dcqa6g7jnbTfXldxSZixZU8x3F0uFZqlqi6+O5mhpQ3Wa6IEKys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZgjFkdN5; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZgjFkdN5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782903322; x=1814439322;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ZjS6liPi1NdySjNIcGtNItMWzhUoGpTQ0kusW/xwebI=;
  b=ZgjFkdN5dnG2WqJqpfN/iHc6GCfvmK8GCgtfPjJ/WuFtlItGq5FXHHrR
   1w3RhEIz1t9PtaYylQ5sHVrCf6ux7Qr2wpq6AQeC+5yQ0CiIMa12UvRqt
   oNe3gCKgRSArxw7dRTGI+fRqaU8t44kDgJmc9M0XJfXTkPFzz0kwFrsIp
   hf9wZDwTgIk6FpfMzHdR/OEo9oagCaVQyqGuwmTxgabccVMgBMoLWAWpN
   11o7WQX9nZC7LE2bSNhXql7CcEiN/6jtl4haLw3Ire9RnN19YCrjkCzFt
   x4fcDuz7zNOzqAlDfr1fkBVcDCkIKk+nGh99mOlckHiLPFdwKOHLTvLGf
   A==;
X-CSE-ConnectionGUID: rU4yg8+sTiyDHZY4U0ZDzg==
X-CSE-MsgGUID: jl5hVJ+TQ0u/xA83yeV7qQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="106422865"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="106422865"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 03:55:20 -0700
X-CSE-ConnectionGUID: ci0GyTkQQvCRryiMH+9o2g==
X-CSE-MsgGUID: GVB/dza0RKCoTJodXYYUyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="252114244"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.65])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 03:55:14 -0700
Date: Wed, 1 Jul 2026 13:55:11 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Michael Walle <mwalle@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"afaerber@suse.com" <afaerber@suse.com>,
	"wbg@kernel.org" <wbg@kernel.org>,
	"mathieu.dubois-briand@bootlin.com" <mathieu.dubois-briand@bootlin.com>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"nuno.sa@analog.com" <nuno.sa@analog.com>,
	"andy@kernel.org" <andy@kernel.org>,
	"dlechner@baylibre.com" <dlechner@baylibre.com>,
	=?utf-8?B?VFlfQ2hhbmdb5by15a2Q6YC4XQ==?= <tychang@realtek.com>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-realtek-soc@lists.infradead.org" <linux-realtek-soc@lists.infradead.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	=?utf-8?B?Q1lfSHVhbmdb6buD6Ymm5pmPXQ==?= <cy.huang@realtek.com>,
	Stanley =?utf-8?B?Q2hhbmdb5piM6IKy5b63XQ==?= <stanley_chang@realtek.com>,
	James Tai =?utf-8?B?W+aItOW/l+WzsF0=?= <james.tai@realtek.com>,
	Yu-Chun Lin =?utf-8?B?W+ael+elkOWQm10=?= <eleanor.lin@realtek.com>
Subject: Re: [PATCH v3 2/7] gpio: regmap: add gpio_regmap_get_gpiochip()
 accessor
Message-ID: <akTyDzdrt949VnWK@ashevche-desk.local>
References: <20260512033317.1602537-1-eleanor.lin@realtek.com>
 <20260512033317.1602537-3-eleanor.lin@realtek.com>
 <agMM9soiqpG-TRSb@ashevche-desk.local>
 <adff3a2d21a64d3ea3b408d62157ee1e@realtek.com>
 <ah92oEavMu4QRn8y@ashevche-desk.local>
 <CAMRc=MdA24z-tB_D8CTw68Di8e4OVQJ1QH4+rDskFzq=xjJ5BQ@mail.gmail.com>
 <DJ3QVMZ6XLW9.1M9W541O92QWJ@kernel.org>
 <CAD++jLncD2ZjH3aedOkGNYP3FyZ=i7Pb0OcKKZKuMOPGNjM_nQ@mail.gmail.com>
 <DJN3PDTPJ3L6.24P71OQFB6C98@kernel.org>
 <CAHp75VeTp4eYQ4QBoeH2VyVhUivxNn1CaC9jskmeg-1zTAOYLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VeTp4eYQ4QBoeH2VyVhUivxNn1CaC9jskmeg-1zTAOYLQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 01, 2026 at 01:01:10PM +0300, Andy Shevchenko wrote:
> On Wed, Jul 1, 2026 at 11:44 AM Michael Walle <mwalle@kernel.org> wrote:
> > On Fri Jun 19, 2026 at 11:08 PM CEST, Linus Walleij wrote:
> > > On Mon, Jun 8, 2026 at 4:41 PM Michael Walle <mwalle@kernel.org> wrote:
> > >
> > >> >>> Without an accessor like gpio_regmap_get_gpiochip(), we cannot retrieve the
> > >> >>> gpio_chip instantiated inside gpio-regmap.c to fulfill these requirements in our
> > >> >>> map() function.
> > >>
> > >> Why is gpiochip_irq_reqres() called in the first place? Isn't that
> > >> only called if the irq handling is set up via gc->irq.chip and not
> > >> via gpiochip_irqchip_add_domain() like in gpio-regmap?
> > >
> > > Not really, the gpiochip_irq_reqres() is called to mark that a
> > > GPIO line is used for IRQ, so the gpiolib cannot turn this
> > > GPIO into an output line, gpiod_direction_out() will fail
> > > on lines used for IRQ. So it's a failsafe.
> > >
> > > You can live without it of course, but then you don't get
> > > this failsafe.
> >
> > Thanks for the explanation! So did I make a mistake years ago by
> > adding the gpiochip_irqchip_add_domain(), see commit 6a45b0e2589f
> > ("gpiolib: Introduce gpiochip_irqchip_add_domain()")
> >
> > As Yu-Chun found, gpiochip_irq_reqres() expect the irq chip data
> > to be a gpio_chip, which isn't the case (in general) for an
> > externally allocated domain, is it?
> 
> So the whole issue comes from the fact that the IRQ chip is not marked
> as immutable. For immutable IRQ chips (which all GPIO provides should
> have) there is no such issue to begin with, id est there is no
> gpiochip_irq_reqres() callback assigned (and respective _relres).

Ah, for immutable chips we put either custom ones or
GPIOCHIP_IRQ_RESOURCE_HELPERS which actually refers to those callbacks.

So, if the domain is external, it should also provide irq_request_resources
and release callbacks. In the custom case we can wrap gpiochip_reqres_irq()
and gpiochip_relres_irq() respectively.

But we need to have a struct gpio_chip pointer for them. And note, the
IRQ chip data can be anything in that case, so it's not a requirement.

-- 
With Best Regards,
Andy Shevchenko


