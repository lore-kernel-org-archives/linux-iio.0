Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F62E3DA7EC;
	Thu,  6 Aug 2026 21:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786050713; cv=none; b=isr6dYljLPLWcZC71//x4lGWkO9l+sleoRwwMK59qu5r77wmbbqjf/1g3fDI6rJj9NKjnS5YV5Scmiec5pXQWFUz10eOFpPP/T2tO39yO82YP1wuze+0nBjy4H3H0daPMu8o28vBTPJu6ObGvw2JpSZH1NvQyGTItfg7YRnniQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786050713; c=relaxed/simple;
	bh=x2rQb314pR3Vm2MohHbZ7PSj9MuzwmuxbVUnDp2wV/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzJZ5naLOoMTgHvddvAdnUOBlTLrTDDoLq4D+Z1uX7lY4RcEdbkfBqnYbnnCkwd+Pi7l7l4ZShXLR+gcM/uNpCWFfVyCbLWoed7b5x7Pp28m8TAJYJWmS+QuY2u5k2ow45xCIBwtUu6JsEOIiwWUVN7bmv+ni5JB20DD5kXpmF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K9l1qych; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K9l1qych"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786050712; x=1817586712;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x2rQb314pR3Vm2MohHbZ7PSj9MuzwmuxbVUnDp2wV/E=;
  b=K9l1qychFf/Io4OPUAF0hU1KR9/Us8QxH1495P/LvO0AHxpEH163aOLo
   G8XdboKGpidmwgtJSc7BJvlnbCWkTowZxFYsKOZOE3aHZvCxcY3rx0F6G
   H1vURNQK7CI7ymxiBpGX+Z//Pl1sxNiel2el780Z6lfjgps+LEeME+byc
   KpiB9xM5JyNgpu8aqEcjin4IkwSFBH1/fmfeu/zxJvoFx9Gu4gTwDc9K4
   5p93W6g1ssoxLfKorEGmpSe1dRmB7GmUfXOBJ5X3JyFwpRgrHEZuZeRjY
   Edw47lAwmvUDB5IPECrlN5NVRrkW4iicmf7e0hNCVq6r48wxtOgsJrh0A
   w==;
X-CSE-ConnectionGUID: N+dnxA+tQf6ioJ0EfiG4YQ==
X-CSE-MsgGUID: W2jS63i7S+OI9pNw0fkszg==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86508136"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="86508136"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 14:11:51 -0700
X-CSE-ConnectionGUID: 8f1Y5hePR2qrjrvUVj0c9A==
X-CSE-MsgGUID: zqfIlHQORmGL0STo0ZidtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="262275447"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.50])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 14:11:48 -0700
Date: Fri, 7 Aug 2026 00:11:45 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Kim Seer Paller <kimseer.paller@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: dac: ad3530r: add support for AD5710R/AD5711R
Message-ID: <anT4kb1dZbYY7UzA@ashevche-desk.local>
References: <20260721-iio-ad5710r-upstream-v2-0-324949dc72da@analog.com>
 <20260721-iio-ad5710r-upstream-v2-4-324949dc72da@analog.com>
 <20260724232659.269b610a@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724232659.269b610a@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 24, 2026 at 11:26:59PM +0100, Jonathan Cameron wrote:
> On Tue, 21 Jul 2026 16:47:13 +0800
> Kim Seer Paller <kimseer.paller@analog.com> wrote:

...

> > +static ssize_t ad5710r_get_dac_powerdown(struct iio_dev *indio_dev,
> > +					 uintptr_t private,
> > +					 const struct iio_chan_spec *chan,
> > +					 char *buf)
> > +{
> > +	struct ad3530r_state *st = iio_priv(indio_dev);
> > +	unsigned int reg_offset, ch_in_reg, reg, mode, mask;
> > +	int ret;
> > +
> > +	reg_offset = chan->channel / AD3530R_CH_PER_REG;
> > +	ch_in_reg = chan->channel % AD3530R_CH_PER_REG;
> > +	reg = AD3530R_OUTPUT_OPERATING_MODE_0 + reg_offset;
> > +	mask = AD3530R_OP_MODE_CHAN_MSK(ch_in_reg);
> > +
> > +	ret = regmap_read(st->regmap, reg, &mode);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return sysfs_emit(buf, "%d\n", !!(mode & mask));
> 
> For consistency with the prep below, perhaps field_get() is appropriate here
> rather than !! trickery.

FYI: we have regmap_test_bits().

> > +}

-- 
With Best Regards,
Andy Shevchenko


