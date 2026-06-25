Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A3735E1BD;
	Thu, 25 Jun 2026 14:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782397377; cv=none; b=e/gpTLVlk8I5350bg1MZi034eDPYbEKwmADrpIJdBrQWfspbjX7dANkoxVHpzOj4cJXoA/Y3RTNeiZE8X7kjmlK4AgCKy2mFPHx3ygfoOiL4KwJgDexfIJ0tHgxWvsAse4Tt/fud4B9oMYp5pl4RLuM13KhmyaTy2+SfB7NJBCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782397377; c=relaxed/simple;
	bh=7MQDuU8o9MSiYQtpjtzQhldLHBjQL3SGB2tbC/LnfCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPvUXggRcff2N0hfmEIBqLwnEi6e/TeTuEaxwKjN7EYsFM1lw1V+MUK+Qfx5nBDw6pQc9epeKF9wpv30XSYZasbZCY18A2mFjqodVieuLEtF+NFypFIq7kG2jbONui2JAqQmNgF0rWoRJBnR7EG/ZujliH44itOirhucnSNH3GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RsNFaEL/; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RsNFaEL/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782397376; x=1813933376;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7MQDuU8o9MSiYQtpjtzQhldLHBjQL3SGB2tbC/LnfCI=;
  b=RsNFaEL/rUmqjgw3jxqMFB8xoaqeiIyWMUXpIcKbFZThYQDg5YNAeN7f
   1leHmsocsgnhUveLf3G/iHFsEq2j1QMc8RA89QHIn4Ow+8819eIVvBA35
   na5aHciRyE3ODmO94EzD00eCkYTRT14y0Z5qSkv88fbiTj2GA4+L3yTkI
   xIc1EveGCi7MZB9puq7XeHm83KyuPBN7xpjUBqnT4QQXmvg8ov35kmwnM
   nwRJpwG6YeAHPOVprip5y0yrze6fMcuyjIRWTVs+mm1+oCDY1adsqqYml
   f745j2tojdJgmlpV0mF5E1DgE8xlJLcSZPuW891WXTOcxLP7Ta89B5IdZ
   w==;
X-CSE-ConnectionGUID: KoCG9b7mTByznsPUi48R2w==
X-CSE-MsgGUID: cNQSrG24TRGl/FLGsAOKxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="82159077"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="82159077"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 07:22:55 -0700
X-CSE-ConnectionGUID: 5JAQpopbRnaCYesx+RHT3Q==
X-CSE-MsgGUID: 4+1dM9C7TgSLfRex6BG5MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="246372054"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 07:22:52 -0700
Date: Thu, 25 Jun 2026 17:22:50 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Paller, Kim Seer" <KimSeer.Paller@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	"Sa, Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux <linux@analog.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] iio: dac: ad3530r: Add support for AD3532R/AD3532
Message-ID: <aj05uiprjLOFzzvx@ashevche-desk.local>
References: <20260615-iio-ad3532r-support-v2-0-84a0af8b83fa@analog.com>
 <20260615-iio-ad3532r-support-v2-4-84a0af8b83fa@analog.com>
 <ai_OeEegWavHcNF1@ashevche-desk.local>
 <20260621174548.5eca5db6@jic23-huawei>
 <PH0PR03MB7141524D6546CD0FF1EF43FAF9EC2@PH0PR03MB7141.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR03MB7141524D6546CD0FF1EF43FAF9EC2@PH0PR03MB7141.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 25, 2026 at 10:07:47AM +0000, Paller, Kim Seer wrote:
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Monday, June 22, 2026 12:46 AM
> > On Mon, 15 Jun 2026 13:05:44 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > > On Mon, Jun 15, 2026 at 02:20:18PM +0800, Kim Seer Paller wrote:

...

> > > > +#define AD3532R_MAX_REG_ADDR			0x30F9
> > Whilst we are here, Sashiko thinks there is an off by one on that value as it's
> > the lower of the two registers that make up channel 15.
> > https://urldefense.com/v3/__https://sashiko.dev/*/patchset/20260615-iio-
> > ad3532r-support-v2-0-
> > 84a0af8b83fa*40analog.com__;IyU!!A3Ni8CS0y2Y!88afCOStwucx32wuoeR
> > SyZ9GpkZge9YDw5_PIMAf7SLs3OLykUC_qNRDUCnRw7wTwsxiIT1V-
> > R8sH17sTg$
> > It also suggests an existing bug that it would be good to look into.
> 
> I don't think it's off-by-one. INPUT_CHn registers are listed by LSB, so
> channel 15 is 0x30F8 (LSB) / 0x30F9 (MSB).  The driver addresses the MSB and
> the part defaults to descending mode, so the access goes 0x30F9 -> 0x30F8.
> 0x30F9 is also the highest valid address per the datasheet, so max_register
> looks correct same for AD3530R's 0xF9.  Does that match our understanding, or
> am I missing a case?

If it's the value for .max_register in regmap configuration, then it's fine.

> > > Hmm... I dunno if it's better to sort by values (so the "bank" 0 goes
> > > together followed by "bank" 1). Jonathan, what's your preference here?
> > Nuno, David?
> > That is how people will typically check them vs the datasheet so I agree with
> > numeric order.  Maybe with a comment at the top about there effectively
> > being two banks. Many of the registers are effectively copies for the new
> > channels but not all of them, so a macro approach would probably be even
> > more confusing.

-- 
With Best Regards,
Andy Shevchenko


