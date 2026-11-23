Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795463693;
	b=lGPhCaD9jJei4ry3zV3Iqlk/Cqb6rE6njxXMuc2AikPyjFwCdmHh1es1OksKsidNZLAn
	 NdxpXS1o/K2mYE7/z3LsoYgY4TdtHYATGWOdLmLH2fijg5fPn0+qwplso9TpwJENbDfzo
	 JtU9XMXrCgjsdf5csu2SnmmoFH6pcpjIO7faqLmlL3vzhuNbfopce4V3J2+AufTBYU6jG
	 6NmB76iGqj51LIv4rvybHpIIoKzF6tqPYdo49tDsyfRsbcEHyxsuUSLpq1rOfT5KTxTZi
	 N2wl+2c1WQl7dIPCnzkWo64CqMapj6eay8ZoFJVUPAUaQ0+zM7lZb4byKKiRqi7ly2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795463693;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=g1rj9K1ufUbqZ3+8WDd2PDC8BQGGeQNY2GgcRNsqjYE=;
	b=leKLKYYkipDka9wS6wDdd/fgIPz+zEsFFXxMAB4opjEYY+Ku7pzWjZ32gOB4TXSxpzrG
	 aIUcjmCHgGjD9JvFUDyjpPwkiVaNjdNwuS6zyjiOYUGP6iXWj9E0fLzK6f88PoudI2l9Z
	 +F8q6I6BOPD0mmOTchG7Bsbc+jMLznxnW7hIq2G39ddNHOBHNdR1RUGW+IMrE7FLSHnrZ
	 JCKyHaet88KQ+gL2LLRCdY/8CJPVzjcA3+mydEgGt0RwKKpfQv6jglBLNhlPKgLhXRrvW
	 FBzAqCpHqKiAAPX2JrurEr8OAVPM1uFBqQvirqoEKNDTyC8VBBogY3QQGUUGisibbjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="JK7/mi4I";
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8660A606A31E;
	Mon, 23 Nov 2026 19:54:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8660A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JK7/mi4I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795463693; x=1826999693;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=hJ0ZM2NdatffL7YZHnsJQmee+2FJa+oE3AW+dkQdS/c=;
  b=JK7/mi4Ivsw0hw1mLhT4BOxixPIGPNKNnz4z7IgwFzadWrprql5jb6ca
   gqgMGv041wyqgcbtO40Ii3rt/v4lC7o8GOxjv4xFKnYLyCIyoXAIn/y37
   bqr+9Nugx9mvUUScoWELCulR2bKtbXBAQu0yc13SxYkNOzCNuCGgxEGpf
   YD1QxStjTO6u4n6XVEOmwfRFiuAzjhdl3jWeEjgVmHdo96dWOU6t7Syfe
   s7GAE8mTVshmzPUMLzzdaE9tZW6RrnDqRvL4jwcD9UAVFrLlm8DSuAemC
   bztqwYDDz7iMcV6cZlAl1L5KvORTiPUMNV45Qg5uE8Jqw0zWAImL678by
   w==;
X-CSE-ConnectionGUID: NwQFqlksTXyuUsPffEmVkA==
X-CSE-MsgGUID: ZFTC/8GORmaEPLTfNRhdsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4126994"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4126994"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 11:54:52 -0800
X-CSE-ConnectionGUID: i1f/k3zJTZukNtVuCbIc0g==
X-CSE-MsgGUID: jsiAp24fSkOALl6yvnT1MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11719541"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 11:54:48 -0800
Date: Mon, 23 Nov 2026 21:54:46 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, mfd@lists.linux.dev
Subject: Re: [PATCH v3 3/4] iio: adc: Add support for MAX8907 ADC cell
Message-ID: <awSaBqLabqZ68ak9@ashevche-desk.local>
References: <20261123150725.212836-1-clamor95@gmail.com>
 <20261123150725.212836-4-clamor95@gmail.com>
 <awSNc2piI26LgyAU@ashevche-desk.local>
 <CAPVz0n2yBtFh-TJ13cH8WXtiyzR3tOrbhACyq8MThi_6+7DOYg@mail.gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n2yBtFh-TJ13cH8WXtiyzR3tOrbhACyq8MThi_6+7DOYg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 23, 2026 at 09:24:30PM +0200, Svyatoslav Ryhel wrote:
> пн, 23 лист. 2026 р. о 21:01 Andy Shevchenko <andriy.shevchenko@intel.com> пише:
> > On Mon, Nov 23, 2026 at 05:07:24PM +0200, Svyatoslav Ryhel wrote:

...

> > > +#define MAX8907_CHAN(_type, _idname, _datasheet_name) {              \
> > > +     .type = (_type),                                        \
> > > +     .address = MAX8907_REG_##_idname##_MSB |                \
> > > +                MAX8907_REG_##_idname##_MEASURE << 8,        \
> > > +     .indexed = 1,                                           \
> > > +     .channel = (_idname),                                   \
> > > +     .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |          \
> > > +                           BIT(IIO_CHAN_INFO_SCALE),         \
> > > +     .scan_index = (_idname),                                \
> >
> > Using () means that you expect an expression as a possible input. In such
> > a case the macro is buggy as it will evaluate it twice for _idname. The
> > simple solution is to drop these parentheses and expect that this macro
> > won't ever be used with the expressions in the parameters.

> You have a point but current state should not cause issues as well.

I know, but I saw Sashiko's complain somewhere else on a similar situation.
It might or might not complain, better to be prepared.

> > > +     .scan_type = {                                          \
> > > +             .format = IIO_SCAN_FORMAT_UNSIGNED_INT,         \
> > > +             .realbits = 12,                                 \
> > > +             .storagebits = 16,                              \
> > > +             .endianness = IIO_CPU,                          \
> > > +     },                                                      \
> > > +     .datasheet_name = (_datasheet_name),                    \
> > > +}

...

> > > +     struct regmap **regmap = iio_priv(indio_dev);
> >
> > Then logically better to go further and have
> >
> >         struct regmap *map = *regmap;
> 
> This is matter of taste, I was inspired by MAX77541 ADC which uses
> exactly this approach.

Not really, however it's very unlikely to happen IRL. When you dereference
something the compiler is in its right to do it as many times as you used in
the code. Hence theoretically (in this driver) somebody might replace the
pointer and two consequent regmap calls will get different regmap.

...

> > > +             ret = regmap_bulk_read(*regmap, MAX8907_TO_REG(chan->address), &data, sizeof(data));
> >
> > This is a bit too long.
> 
> 101 char, yeah 1 char too long, though maybe it is not wort resending
> for a single char too long?

IIO is tending to follow documentation in majority of the drivers and cases
which is 80 limit.

> >                 ret = regmap_bulk_read(map, MAX8907_TO_REG(chan->address),
> >                                        &data, sizeof(data));

...

> > > +static int max8907_adc_init(struct regmap *regmap)
> >
> > Why not name it 'map'?
> 
> Because regmap is more explicit and is used consistently across the driver.

And messes with the data type name :-)

...

> >         ret = regmap_update_bits(map, MAX8907_REG_TSC_CNFG1, GENMASK(1, 0), BIT(1));
> 
> which map? bitmap? statemap? or maybe geographical map?

Read the name of the call. This is really silly question here.

> > > +     if (ret)
> > > +             return ret;

...

> > > +     /* Check for internal reference IRQ */
> >
> > Please, make style of one-line comments consistent ("all or none" are with or
> > without period, same for the first letter — capital or small).
> 
> First comment has 2 sentences, that is why it has periods. Second only
> one, so it does not need period.  "same for the first letter — capital
> or small" - have you even checked the patch?

Then make the style equal. Two sentences can be written differently.

And please, stop being rude. Yes, I read the patch, The second part is
unrelated, I am sorry for mentioning it.

...

> > > +     ret = regmap_read_poll_timeout(regmap, MAX8907_REG_TSC_STA_INT, value,
> > > +                                    !(value & MAX8907_MASK_NREF_OK), 10, 1000);
> >
> >         ret = regmap_read_poll_timeout(map, MAX8907_REG_TSC_STA_INT, value,
> >                                        !(value & MAX8907_MASK_NREF_OK),
> >                                        10, 1 * USEC_PER_MSEC);
> >
> 
> hmm, replace 1000 (4 chars, pretty readable) with USEC_PER_MSEC (12
> chars and twice wrapped line and needs tinkering or looking into
> units.h), I don't think so.

Because the point is missed? We have tons of much longer multipliers that kill
two birds with one stone:
- avoiding possible typos when many 0:s are in them (one can be missed or too many)
- hinting reader of the units of the used values without even looking into the docs
- (and reading 1...MSEC is quite natural, without counting 0:s and thinking how
   many of them and what 1000 microseconds, after spending time on the
   documentation, means in practice)

Please, use multipliers where it's makes code better to understand for
unprepared reader.

...

> I would like to hear what Jonathan has to say.

OK.

-- 
With Best Regards,
Andy Shevchenko


