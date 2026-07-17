Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1636301719;
	Fri, 17 Jul 2026 08:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784277531; cv=none; b=fldPusah9n8x1js+OmwpnEiFFy+Du3yah8nNvWKvbY/msJwJljmoP2OkduhzyRzAnKJx3NfDOl46brVuJMkuNgtyOkdtdo0IVI+EiUwXxHzl9eDa1BlqODHMvW6PQ7sKaR++SPWdbLbAPvo6WAIo9v4bEZnaZ9OeIjE9/9hOvMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784277531; c=relaxed/simple;
	bh=A2JhgEKXHwd6DTgUANQltUvF2hrMmXaQUk6VqGURdqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ea7if/yCQm5hnnKYfBCPxlE+yCB7Hjz6HJ5UqgVN2YMfjJU+PIBwEt4KRFV9b3cPOjMk850vDnF8wXJ3z1iic/a/Cb0fSvhTjWs0GNrtm9WFK34Zt0rqZ3aDZeQ2KrIt175VCv0E9d97yQIabeACtC2ioy+Y8D8VkZ0LHn/zjEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d9iwyHxp; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d9iwyHxp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784277529; x=1815813529;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A2JhgEKXHwd6DTgUANQltUvF2hrMmXaQUk6VqGURdqU=;
  b=d9iwyHxpBRNPB4OtO6pnRN0NqO1mWNJToLR4F8BRnu/SLn4aWP+qeMkw
   JoJKPsxHWaW8CbuetZa8QTRb15XyyGHw+h3reK8PGGlxmFLHdSQiMirQ4
   G3Iqb/dcfiaHJIzeBucgsj8JldhHAOOc6CFnV0vxxgJzIFt2RSj8mWJ8W
   r2O17VoZmN7xiqcnIg/Yr0Bsmn+WdKxtfk/u4OB8+OcofbcpUcekqcJXo
   nsYC/0qU5O3jnU9+6NLbxs9+Zze80v0XbTCA6u7YQRaEyiYLIC+adtJLh
   hTHFzqcj4VIrWqloir7aDG1oIzZchIXn1x2yA/fcZ+5mPi9nVNd0naXtP
   w==;
X-CSE-ConnectionGUID: tmiGNU16RFW9p/Sv+l7LIg==
X-CSE-MsgGUID: k8rYObyxQNCPm5wjiD8rKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="102372456"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="102372456"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 01:38:48 -0700
X-CSE-ConnectionGUID: Fz46YXghRfCGXVa4fTXzpw==
X-CSE-MsgGUID: lEkyn+ObSCufQwvwFUxXqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="261015173"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.143])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 01:38:45 -0700
Date: Fri, 17 Jul 2026 11:38:42 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Petar Stepanovic <pstepanovic@axiado.com>
Cc: Akhila Kavi <akavi@axiado.com>,
	Prasad Bolisetty <pbolisetty@axiado.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: adc: add Axiado SARADC driver
Message-ID: <alnqEnVm9rGTapFB@ashevche-desk.local>
References: <20260716-axiado-ax3000-ax3005-saradc-v4-0-810527a9d27f@axiado.com>
 <20260716-axiado-ax3000-ax3005-saradc-v4-2-810527a9d27f@axiado.com>
 <alnpMFK6_ZkdWlLi@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alnpMFK6_ZkdWlLi@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 17, 2026 at 11:35:01AM +0300, Andy Shevchenko wrote:
> On Thu, Jul 16, 2026 at 10:53:02PM -0700, Petar Stepanovic wrote:

...

> > +static void axiado_saradc_disable(void *data)
> > +{
> > +	struct axiado_saradc *info = data;
> > +
> > +	regmap_write(info->regmap, AX_SARADC_GLOBAL_CTRL_REG,
> > +		     AX_SARADC_GLOBAL_CTRL_PD);
> > +}
> 
> Supply regmap instead of info and make this simpler
> 
> static void axiado_saradc_disable(void *map)
> {
> 	regmap_write(map, AX_SARADC_GLOBAL_CTRL_REG, AX_SARADC_GLOBAL_CTRL_PD);
> }
> 
> ...
> 
> > +	regval = FIELD_PREP(AX_SARADC_GLOBAL_CTRL_CH_EN_MASK,
> > +			    GENMASK(soc_data->num_channels - 1, 0)) |
> > +		 AX_SARADC_GLOBAL_CTRL_SAMPLE_16 |
> > +		 AX_SARADC_GLOBAL_CTRL_MODE_MANUAL |
> > +		 AX_SARADC_GLOBAL_CTRL_ENABLE;
> 
> This is not used in the below call, move it closer to its user.
> 
> > +	ret = regmap_write(info->regmap, AX_SARADC_GLOBAL_CTRL_REG,
> > +			   AX_SARADC_GLOBAL_CTRL_PD);
> 
> With
> 
> 	struct regmap *map;
> 
> at the top, this and other will be shorter and easier to follow.
> And I would dare to use a single line:
> 
> 	ret = regmap_write(map, AX_SARADC_GLOBAL_CTRL_REG, AX_SARADC_GLOBAL_CTRL_PD);

Looking closer at this I think it's a leftover? Since it's an action that does
disable. This one should only enable chip, right?

> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_write(info->regmap, AX_SARADC_GLOBAL_CTRL_REG, regval);
> > +	if (ret)
> > +		return ret;
> 
> > +	ret = devm_add_action_or_reset(dev, axiado_saradc_disable, info);
> 
> 	ret = devm_add_action_or_reset(dev, axiado_saradc_disable, map);
> 
> > +	if (ret)
> > +		return ret;

-- 
With Best Regards,
Andy Shevchenko


