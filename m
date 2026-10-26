Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793011229;
	b=BvDCqCdeKN8N6URYJ+As0F6P6P0QVK8qm6kWE+dC/StCQsG06TuRnpZvaWdbUR8e94KW
	 8jzyWrghUztTZCGdkNqecrVPL88hMukDgSYtC/E6QNcmp9toR3V/z+TH3VqUTIMQx+wrQ
	 R1kEXkw5HPBfi1LoH+xfF8CfPmCnD2Hg/3u7Goh4c5pSkoCXjigUR+VqJ9/dHdTKf9eNm
	 uM7x2lEqUXTllOuqJOVQcJyE2Db9tYbNS4oyJVaSELghXZjHt/p1q7XXDQ6arbnPzYZms
	 Ae4o94gfM0V9p2aj9vkaogqyv/ieNvcJs7bf+x4yryQh/08qIOeDyVp3vMxb30gFNtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793011229;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=cV0613HkIy6oDcHR5pHciUveYweuUKAGb8FXSxW3Ddk=;
	b=UCfXo7TPsovEsjSBdTI5rH8FdWi/WFFYkH6of3r7u8JpgxzJQ1bRKqYY+ZMQNEJNmpkL
	 7cBCx0NIQEng3iSPIjnJWVhMQ0lbYSkW81INvrfrQIkzlOkFIgZwQAjFr04TjmJrIseb+
	 AH97x4Wrh4KMveFaGxWVNUnS965QcaIE+3ysZcDiGJw7xLkqBfy7hCF4pE2gN1EM7AMh4
	 yHtRPZKqMYQfHTndULR16t9CdUx7jNMyL4A181NsYRCKQq+Mcrm9OBgrStty8tA3ld1Z4
	 kamk5GW2o1hABEHwGaN4eKEKNik3utKtRRtB7Q2SH4ZEaglyqvgeNZcBQPPUfZJ7H2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OlxKvaFx;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033DE606A31A;
	Mon, 26 Oct 2026 10:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 033DE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OlxKvaFx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793011228; x=1824547228;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0/Q8KSTo0adxm5V8+rvOuCbruYkK+f5oqI4EGetOZUs=;
  b=OlxKvaFxaseF7IbyPAACeHlZln3IUETOIKKYPxuF5CfSh3Pw+WQV+eU5
   1FjgRiGQ8tUfJwmEl4JETDjNg2Uxx8NLwVhtfx2Xz3kx3PeZ+0bOY6Jhp
   82smqGvJvLQOflV/643Pqecr69/lsVSzpMMF18A7wBBCEsbl7ZHGFIK6O
   a933mFZCszCF2JdmKg9h7jodrDsszN7BkKAUREFRnWJGKFNs+SPORWh5I
   /zhzu4bgPuEu0kYAYrP/gLwhXxD03W0Vpl2R+yxhiaOInRSMBQYfC8i3S
   GUTgTAa2y+FY9qCa/KTdPVHOiBFsFKqeUKXfzkmyiIR6mVKadkXWRKOVP
   g==;
X-CSE-ConnectionGUID: yOm/syLARwOOhgEkmkfsxA==
X-CSE-MsgGUID: PCwhZI6tSaWNuXh3PMwg4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1564747"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1564747"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 03:40:27 -0700
X-CSE-ConnectionGUID: uynkbYzyQsm+WZ1I78OQRA==
X-CSE-MsgGUID: 2U+XNF39ROSidvrT8TCMtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="6089682"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 03:40:23 -0700
Date: Mon, 26 Oct 2026 12:40:20 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Prabhakar <prabhakar.csengg@gmail.com>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3 8/8] iio: adc: rzt2h: Add support for RZ/V2H(P) SoC
Message-ID: <at8uFFHk7DHH9e1l@ashevche-desk.local>
References: <20261023175919.160103-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20261023175919.160103-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <atyKo0pTYZyt5XJc@ashevche-desk.local>
 <CAMuHMdV8Q9UKrpoZuZfDUutrG=bOwcNWLnht1bufv0YVXJPNDw@mail.gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdV8Q9UKrpoZuZfDUutrG=bOwcNWLnht1bufv0YVXJPNDw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 26, 2026 at 11:14:53AM +0100, Geert Uytterhoeven wrote:
> On Sat, 24 Oct 2026 at 12:38, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Fri, Oct 23, 2026 at 06:59:19PM +0100, Prabhakar wrote:

...

> > > +static int rzt2h_adc_write_scale(struct iio_dev *indio_dev,
> > > +                              struct iio_chan_spec const *chan,
> > > +                              int val, int val2)
> > > +{
> > > +     struct rzt2h_adc *adc = iio_priv(indio_dev);
> > > +     u64 req_scale, scale;
> > > +     unsigned int i;
> > > +
> > > +     if (!(adc->chip_info->features & RZT2H_ADC_FEATURE_RES_SELECT))
> > > +             return -EINVAL;
> > > +
> > > +     req_scale = mul_u32_u32(val, NANO) + val2;
> >
> > But what's wrong with the simple 1ULL * val * NANO?
> 
> IMO that looks like a useless multiplication, which will be removed
> again in some future "cleanup"...
> 
> There is a reason the mul_u32_u32() helper exists...

I don't see that. The 9e3d6223d209 ("math64, timers: Fix 32bit
mul_u64_u32_shr() and friends") tells a different story.

> > > +     for (i = 0; i < chan->num_ext_scan_type; i++) {
> > > +             scale = mul_u32_u32(RZT2H_ADC_VREF_mV, NANO) >>
> >
> > Similar Q.

-- 
With Best Regards,
Andy Shevchenko


