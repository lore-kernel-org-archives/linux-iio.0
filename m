Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794821015;
	b=d9rvG6dptcjNN8vEV8or16ZbRDOHoISOTqzbywXv4TGmlkTuImEXnMKpxxPxtfD2U/Zf
	 uEtjIVAiutAPu4ePqyc9RLMfCaUzpWNBk4KfKpxlKjyCHwZiOFJvI+sucWsyeskeyo+es
	 mdhsVWbXhc+a++6icqapjFr4cd8I/ybFWSbgfHqyKDan4JYxyXL0Z+qYAWWTOw4prJXrj
	 +fqJppxzLtr544IowqyKmdpz1VH9LuAJsW/fu7L5lZQvpPWEIIGDTMrQsz1SkJad9zi81
	 bG+bGJOp2LYQHZpOxEdQgWgMzYLXjccPMAXfMEqzleG1xdGSy9qZ6z1++8Ysm9Rxo2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794821015;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=U7QGeUHPLaOKaTFmRwI4vSzvwc9pnqiaJV8xvo3ZyVo=;
	b=mWIjz0Lr5FvP+23Lmc+z3bzzexbOTZtEZHcTaOxcPuqzaycj/4f3JP2E8IRGOlpXBo69
	 7tAG2ujIVtqE5jyKFQa/dWDVHkZBYDel/wLVy46ug+tih2B8vo5CUFHRXqfpWoNR9DfKL
	 3R418tNbdiwctlYcHLuBznCae1p2H6yZ23O9VNKHx9Cyc3Z8RC+wiM/M1ccsXRBYoe5/x
	 cYWqqSYDgbbA8HvSOqh+kkyI8MCIVAZkzu1yrAu6xbmllVxxIzPHM3XENBGaAYornBYhY
	 IjzNpnkdM8vLIPHNCg0PxoTJuThvPppu7fLPXF/pbkw+RGAFhMsMVbDge6imi16i/pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EMsJFdki;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48263606A323;
	Mon, 16 Nov 2026 09:23:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48263606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EMsJFdki
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794821015; x=1826357015;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nGUJYj/3FEkggBBxupS2Xofdcl6yEIq2D4ZxSGaqdUc=;
  b=EMsJFdkigzLsi6ZEeuIW2dcB/m6Jps55ShWQPeKbZB6BQnCR2mfPAz3b
   77E93W5ooEuuc0+DdaB46xypCKSVOtoUoO9aJaQCFNKhwCsN8xWQy+NaG
   feC8IV7wSZwr3xuSHJaIw+FvMSFZv6EFcRR09qCUlfYESraKtYjzN4jba
   3M1IoYkLE3LD03r9d+k1YpoITz0QeMIJBGQCsg/rLn7GqxoIQwNO1/lWc
   GUv/vLPW+MJuceAGlSc5NhoJRsQ3ZliEzy3Dl6spRomCedjr/cf799FiR
   iz8LcfjQAujxntZSqJ/f2zIdvB5Fibt8w9XZtdKYggZCFuzysvOhWiy/7
   Q==;
X-CSE-ConnectionGUID: OqQqt/28ThaED4EDJP/eCg==
X-CSE-MsgGUID: tv97WclHRnqWwsMB0ilEHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3580053"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3580053"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 01:23:35 -0800
X-CSE-ConnectionGUID: L03AtofEQZiAP50YHomc3A==
X-CSE-MsgGUID: 2p72z+SJSqyRVDyz+zkqRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9578043"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 01:23:31 -0800
Date: Mon, 16 Nov 2026 11:23:28 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Patrick Fischer via B4 Relay <devnull+admin.tsv-stahl-riesa.de@kernel.org>,
	admin@tsv-stahl-riesa.de, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Kevin Tsai <ktsai@capellamicro.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: light: Add Capella CM3217 ambient light
 sensor driver
Message-ID: <avrLkP1IR449AwLy@ashevche-desk.local>
References: <20261113-upstream-iio-cm3217-v3-0-c4d5b2485dff@tsv-stahl-riesa.de>
 <20261113-upstream-iio-cm3217-v3-2-c4d5b2485dff@tsv-stahl-riesa.de>
 <20261114012906.6f66edce@jic23-hlaptop>
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
In-Reply-To: <20261114012906.6f66edce@jic23-hlaptop>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Nov 14, 2026 at 01:29:06AM +0000, Jonathan Cameron wrote:
> On Fri, 13 Nov 2026 20:59:00 +0100
> Patrick Fischer via B4 Relay <devnull+admin.tsv-stahl-riesa.de@kernel.org> wrote:

...

> > +static int cm3217_probe(struct i2c_client *client)
> > +{
> > +	struct device *dev = &client->dev;
> > +	struct cm3217_data *data;
> > +	struct iio_dev *indio_dev;
> > +	u16 addr_lsb = CM3217_ADDR_CMD2_LSB;
> > +	u32 reg[2];
> > +	u8 cmd1, cmd2;

Keep reversed xmas tree order.

> > +	int ret;
> > +
> > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	data = iio_priv(indio_dev);
> > +	data->client = client;
> > +	i2c_set_clientdata(client, indio_dev);
> > +
> > +	ret = devm_mutex_init(dev, &data->lock);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = devm_regulator_get_enable(dev, "vdd");
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "failed to enable vdd supply\n");
> > +
> > +	/* Without a firmware node (e.g. sysfs new_device) use the fixed one */
> 
> I'd rather we handled that explicitly.
> 
> 	if (dev_fwmode(dev))
> 
> That way we can return an error if there is firmware but it's broken.

I think here we want

	if (device_property_present()) {
		...
	} else {
		addr_lsb = CM3217_ADDR_CMD2_LSB;
	}

I really discourage people to check for FW node presence with dev_fwnode(dev).
This is a corner case which is in most cases needs better granularity (like
distinguishing the fwnode by type). But in general ideally it has not to be
used at all.

> > +	if (!device_property_read_u32_array(dev, "reg", reg, ARRAY_SIZE(reg)))
> > +		addr_lsb = reg[1];

-- 
With Best Regards,
Andy Shevchenko


