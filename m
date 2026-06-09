Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C4B33C1B4;
	Tue,  9 Jun 2026 18:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781028932; cv=none; b=qBDLHuSU+EAKj4GWNCSm+hDCSkl9wtrSqfmj8NLFwXA6Ki8Aeexp21YJMv3o9LrhfUHstySwpGrSjrCZvJP0SbM8/7HQJwxZNln0h/eNHSm9UNpcCYRviTnCB1pbDoZz07vRmPh1O0+O/7sYTsOhwLmWQw9MYwFTFS8DmrZl5aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781028932; c=relaxed/simple;
	bh=j0UdTejC7lDY6owPw/rHcM5IerPjB3ei0m6x7ygaqeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btbl47VtPHb0ff0iG8+gu2i1zr6srYngsyhVKzmleBch0INQ2PMtsItDzLYuBG2OkUk7kxjL/t1IaO+Uscq1ayPc/ylfSfI6wlhKT2C+HkJvmkBVDqbKaB6uWsQofogJSaro/QWD7ksYZ3JHZ47ZmYGWC9sUBlDC3OzTeM3ap8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I5l27M27; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I5l27M27"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781028931; x=1812564931;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j0UdTejC7lDY6owPw/rHcM5IerPjB3ei0m6x7ygaqeo=;
  b=I5l27M27KISj/ih++qrKuaE5HIKMqIOK6uhWyriSms+NWd1DKqnw5ALs
   gmnH7mv9AyQFg5abykO+OEhpIRv44p8HhQG6G07eq/Th6/7smm6+D6iM1
   Xq16HRrJtwOo5MgXFhdroJjSCFza8hmzqaVao2rkKcQM4Rni7/NHJZJtu
   IKjGnVsX4xYBUJg9Y7a8EmF2ezi33/EukI2f24O2/CWEigbxyuRhgGirO
   TtkRb8vg298gu7m0tgdWF5F1dRUSuh2p9IisdvkHkcSIKTLTcKhe4yqkI
   +3KsD7/uU/HQ0PAq96j+dtp6DqLKtmPhV2Ox7ZbSfXuY6kmmldulFC8Oa
   Q==;
X-CSE-ConnectionGUID: qmFGsM+0Sm6GoKPssamscg==
X-CSE-MsgGUID: iCAI51w3QuqlUH4TEK1+CA==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81809195"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="81809195"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 11:15:30 -0700
X-CSE-ConnectionGUID: 9kniI4o8RyKcX0xGasrMTA==
X-CSE-MsgGUID: pMo0qlBaQIOaUKcLim9kUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="245791285"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.162])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 11:15:26 -0700
Date: Tue, 9 Jun 2026 21:15:23 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: Michael Auchter <michael.auchter@ni.com>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v2 12/12] iio: dac: ad5686: add gain control support
Message-ID: <aihYO_X9YEqabaFi@ashevche-desk.local>
References: <20260609-ad5686-new-features-v2-0-70b423f5c76d@analog.com>
 <20260609-ad5686-new-features-v2-12-70b423f5c76d@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609-ad5686-new-features-v2-12-70b423f5c76d@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 09, 2026 at 11:13:07AM +0100, Rodrigo Alencar via B4 Relay wrote:

> Most of the supported devices rely on a GAIN pin to control a 2x
> multiplier applied to the output voltage. Other devices, e.g. the
> single-channel ones, provides a gain control through a bit field in the
> control register. Some designs might have the GAIN pin hardwired to
> VDD/VLOGIC or GND, which would still be fine for this patch, that allows
> the scale property to be configurable with two available options.
> vref_mv field is moved down in the ad5686_state struct, so that

Slightly better to use same terminology as in C and documentation, id est

"...the struct ad5686_state, ..."

> overall size increase is reduced.

...

> +	case IIO_CHAN_INFO_SCALE:
> +		if (val == st->scale_avail[0] && val2 == st->scale_avail[1])
> +			st->double_scale = false;
> +		else if (val == st->scale_avail[2] && val2 == st->scale_avail[3])
> +			st->double_scale = true;
> +		else
> +			return -EINVAL;
> +
> +		switch (st->chip_info->regmap_type) {
> +		case AD5310_REGMAP:
> +			return ad5310_control_sync(st);
> +		case AD5683_REGMAP:
> +			return ad5683_control_sync(st);
> +		case AD5686_REGMAP:
> +			/*
> +			 * Even if the gain pin is hardwired on the board, the
> +			 * user is able to control the scale such that it
> +			 * matches the actual gain setting.

Rebalance the line lengths to

			 * Even if the gain pin is hardwired on the board,
			 * the user is able to control the scale such that
			 * it matches the actual gain setting.

makes it more consistent.

> +			 */
> +			gpiod_set_value_cansleep(st->gain_gpio,
> +						 st->double_scale ? 1 : 0);
> +			return 0;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +	unsigned short			vref_mv;

_mV


-- 
With Best Regards,
Andy Shevchenko


