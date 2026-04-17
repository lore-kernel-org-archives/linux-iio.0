Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F19D35F615;
	Fri, 17 Apr 2026 18:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776449149; cv=none; b=nYGZk0GeUiV4B6xk9+Rzx/NxhEvsq/PoSbH4uZsxJORBKb8JMp09Fn1cTrxR8dc+v5hfiwDKWlWKHMGB1LBGU+AG/yBzTEbt20Q90SGTN8xuzJUoA/op/UHbBIEDSMHZ4mMZdOCG7pFsxpkKlgWxLFugD8LXtCgDjCo0AGzMm+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776449149; c=relaxed/simple;
	bh=cmuxPYxoOsVJO8Baw+KCM1ApAfp6+CKrVlJk6aoH/NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCW3wIPSTszxk4w1tYKefpp/3Kg4K+/V6aJbI2SyLdERHf68Gb6ERW9Ua/ZXbAumCKoAJTrLHDw54oc1puTK0hnH3BritzBzGAjxW2zvlh5KRgeqfx5WHwl1DGDW9F0CpF4EXltF241PJdzFdc1DZ6p1ptISIwzezSov/TLZl+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DzfagKzh; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DzfagKzh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776449146; x=1807985146;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cmuxPYxoOsVJO8Baw+KCM1ApAfp6+CKrVlJk6aoH/NY=;
  b=DzfagKzh7vmZ3+nK9EaXw5Vpvnq7D8qKE2ZjUssFt7Jnef/jrAd9Hw7H
   KBi91Lt89tGiMsT1mN2dv16iMQ8Hnsk16RfubELhgfDJ2f4II5icCv4dT
   5Sin9grGbpgEh5BqdrzutLMhGfe1HxEy2LziwTUczOizY1qhYAkmKqPUU
   GZOI3wqYou4NCaX+isR8l1x7uDkSdDAapOmZns6sIIfHQUDbTRpPYyeVr
   6JNq/HdP/SCjKm0+TGyXTsvRbOc0iv9bZEgnOIfH+zdzsrwp52qPgPZx2
   BF4LVVh1T67K31DFaWRKak/iC/TUyPcUvGLIhP5DEqp0bUk8Y9z46tFn/
   g==;
X-CSE-ConnectionGUID: tplcULL3SMiQyvj1un8+DA==
X-CSE-MsgGUID: NS30AwEhSkyyBvl//xKFVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77648957"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="77648957"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 11:05:44 -0700
X-CSE-ConnectionGUID: 8zVf8/OETvCbThNM6RXkbg==
X-CSE-MsgGUID: eAazxJuHQB+QF1YXcLaN7g==
X-ExtLoop1: 1
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 11:05:40 -0700
Date: Fri, 17 Apr 2026 21:05:38 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/2] iio: dac: ad5706r: Add support for AD5706R DAC
Message-ID: <aeJ2clUsHk-VTr0F@ashevche-desk.local>
References: <20260417-dev_ad5706r-v8-0-ef87dff62b57@analog.com>
 <20260417-dev_ad5706r-v8-2-ef87dff62b57@analog.com>
 <aeHwwN2sFJBzQ21H@ashevche-desk.local>
 <20260417135624.000030e5@huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417135624.000030e5@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Apr 17, 2026 at 01:56:24PM +0100, Jonathan Cameron wrote:
> On Fri, 17 Apr 2026 11:35:12 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Fri, Apr 17, 2026 at 04:27:16PM +0800, Alexis Czezar Torreno wrote:

...

> > > +#define AD5706R_DAC_RESOLUTION		16
> > > +#define AD5706R_DAC_MAX_CODE		GENMASK(15, 0)  
> > 
> > I know Jonathan asked for this, hence it's comment for him.
> > I think that BIT() notation in a form of (BIT(16) - 1) is
> > also appropriate here as it gives the relationship to the
> > resolution of the given register / bitfield in HW.
> > 
> > GENMASK() works for me, but it might require an additional
> > operation to deduce the above.
> > 
> > (Note, there is no request to change or resend for you, Alexis. It's just
> >  a remark to make Jonathan to think about which one suits better. He might
> >  change that whilst applying.)
> >
> I'm not against that form.  It was more being against bare BIT(16) as that was
> 1 greater than the maximum value it can take.
> However making the relationship explicit would be even better.
> 
> #define AD5705_DAC_MAX_CODE	(BIT(AD5706R_DAC_RESOLUTION) - 1)

While that's technically correct, I would still prefer an explicit number

#define AD5705_DAC_MAX_CODE	(BIT(16) - 1)

Note, GENMASK() is also fine with me, this is really a minor difference.

> I might tweak it when picking this up.

-- 
With Best Regards,
Andy Shevchenko


