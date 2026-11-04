Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793806900;
	b=VejiqiPLvfp0xwclb4b9/Ia6f2ZaX8nvYk6GbamrPBeosLSHEs3g8hUde7Cgx8VNO65O
	 xKhN4YEh0229jENhsq3iFUWx9hEceCDsuL2m5j1+78jmaS6KiqLsF3oyCMiFVtJKj01Op
	 XpxLgn0S2DJIzZUE0fLLNDIE4FSlrVLsNmzGYQNAp624pqkJh5Wm+fOu7uaqbFytVu0Xe
	 xX5uc/bfNni2ltCozNORsoYMFeBTn8ZYPdeqwrWaEJ0e9ZYv3XHIrDIMkgPqHbRAgw+sZ
	 djqDCjURZsJN4SEX7QZVQ8PKzkz4RGyRqZ9EPMZ3cqbSl4oX3R8ZuABwFk9LqPsLzDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806900;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=iphqSsawpRaaen7vANjen5+GcoTtHf3xRM+kRPbqxW0=;
	b=nCD+CI9v1pOELvjkQcrF9GIHvC+JIf7ZDfzOWxmVXK+etBEPOCdqs+kfWYqqROBdfMVu
	 ziwzJRjKB8oWMoNuBgwLyUTUa5kGXxFxiYWs6YA9Y5ALCxFrgo1iQDl3LA4nlLl/13Z0p
	 kS7RN2eotPfHUru3qfpZ6LtVCfvXrLRYukxFTSAWzllUrb1wEZae5+P6azCBsZ/1e4BET
	 QSPkBY0SL2Ge00rNPh1eAUywhPbTn4XUtfMgdE158dwPK1NAHEjfh2HgSPGf981Yxi4Ys
	 bV2TXadzIH30S10bs6Ds7xgb7l0qvJi+evbPvhEITLm2cCOFggSeUQBmYTDLcka/XqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fU4ZajU6;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8C4606A331;
	Wed,  4 Nov 2026 15:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF8C4606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fU4ZajU6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793806898; x=1825342898;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0locde0rhGayPBqPOc/hjAfG1PM+Mqip+KEGed79GU0=;
  b=fU4ZajU68sAQqkWF61VeRLTcGLymZIc6QT8PJ/PuLcdvJvu4/KZKUh+a
   M2opUq0y/wFVrcU0TfWjRJtvrNqtrnCVWTUvjiPKjCCnipmBbkobdNIZx
   YmP7ccHfZSzQ+NBOdeGc9g18xAVPPMfUiRnwS+mEKTjNyp9rgu04jkfjd
   nRTd6XRxmp0XXCF7TQCfp9AbC4oKZtI0MoK21X/chPx8c6XSjhAViQBc2
   N6DiX1LG2wRQdU5C4fwpmFhyYsFNKw0qUAd8Jk7FZBppLCMatD3g3utc9
   GkzVZl9MLnUo0uTaqJjdPIjPExBn49S8pT9owqvpABcj5dgNtuQwALLmf
   Q==;
X-CSE-ConnectionGUID: ZFId9FDWRbOOw9rlB0zUCw==
X-CSE-MsgGUID: PUqg5a6pRO2QvpKGN9vt0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2560739"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2560739"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 07:41:37 -0800
X-CSE-ConnectionGUID: nSTyb77nT0e5ME8AG9dCFA==
X-CSE-MsgGUID: ENib+KKCQS+GRhxNWFZi5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6895538"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 07:41:32 -0800
Date: Wed, 4 Nov 2026 17:41:30 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <crofts@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Rodolfo Giometti <giometti@enneenne.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Angelo Dureghello <adureghello@baylibre.com>,
	Tobias Sperling <tobias.sperling@softing.com>,
	Eason Yang <j2anfernee@gmail.com>,
	Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	duje@dujemihanovic.xyz, herve.codina@bootlin.com,
	thomas.petazzoni@bootlin.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: add driver for Texas Instruments
 TLA2528 adc
Message-ID: <autSKpnh0hORsYT4@ashevche-desk.local>
References: <20261104125726.1754980-1-maxime.chevallier@bootlin.com>
 <20261104125726.1754980-3-maxime.chevallier@bootlin.com>
 <20261104145641.000070f2@kernel.org>
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
In-Reply-To: <20261104145641.000070f2@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 04, 2026 at 02:56:41PM +0100, Joshua Crofts wrote:
> On Wed,  4 Nov 2026 13:57:25 +0100
> Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

...

> > +#include <linux/types.h>
> > +#include <linux/units.h>
> > +
> > +#include <linux/iio/adc-helpers.h>
> > +#include <linux/iio/iio.h>
> 
> + #include <asm/byteorder.h> for be16_to_cpu()

Yep, but please before linux/iio/* block.

...

> > +static int tla2528_read(struct tla2528 *tla2528, u8 channel, int *val)
> > +{
> > +	__be16 data;
> > +	int ret;
> > +
> > +	guard(mutex)(&tla2528->lock);
> > +
> > +	ret = regmap_update_bits(tla2528->regmap, TLA2528_CHANNEL_SEL_ADR,
> > +				 TLA2528_CHANNEL_SEL_MANUAL_CHID, channel);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = i2c_master_recv(tla2528->client, (char *)&data, sizeof(data));
> > +	if (ret < 0)
> > +		return ret;
> 
> As rare as short reads may be, perhaps add a check whether the expected amount
> of bits have been returned from the device?

Bits? You probably mistyped bytes?

-- 
With Best Regards,
Andy Shevchenko


