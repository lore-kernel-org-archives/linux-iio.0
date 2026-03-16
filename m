Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9112874FB;
	Mon, 16 Mar 2026 20:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773691521; cv=none; b=liLHxX/axgfzpk+Pri9Ni3C7eBlph6B4xHvmXIcKJqh4MaPc8qGeAZUJnFhrdJ+zTC8r5ELbbUumYOaF/m1dtjJMstLysBeMk3Wh4q8bkWx5lkp5nt7s2U5CJ2ESPgoVzPTn1pcIDuplS0U4c4ZEnwpQ+67mJZ7XOd/wdgVnXJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773691521; c=relaxed/simple;
	bh=638skbVIn0DAkoP3JK1HeFCzxHBpKM83DUAvIob7Ohc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSDu9x5D9pk3ouk3HOzz2Q4wVGtia5Te06G8yw078mWRB7mzhWRDj/3cBFA76HhfIArYtC+sn+1W7kxC/W1VinU1T1otjnqhzRN0mC/jbBitNdarz+2w+Mt2DOmusNnTq0vDDlAosN4MzNozOY5yraOzwSQrcSQ53GDA1160C6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rq9PZyw1; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rq9PZyw1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773691519; x=1805227519;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=638skbVIn0DAkoP3JK1HeFCzxHBpKM83DUAvIob7Ohc=;
  b=Rq9PZyw1eWep0aNj5eSo+5DIueKMHcMLqYJSiIgL4eqcwHTbeU4E4X/L
   onZ1b5U1XCqHw44DPAMj81+1S8HdCV3NOQupBy4InWO5F4XyK9dAUZMEt
   0g3DRsBDusvZOT9X7dSPPHYhxTM1IHKKb6+nvzVQgiDje3/ZXhP5mxC9h
   oYDJy+bRhbokErrpRONIzltKt6ADsyDSF64WIA3MHZ1m0P5KICrSWk1n+
   F92VDUxAwafJ0YqLeKxLGUEj/GExDKSzxfyH+vpBdSksl3IwtC089Pu2e
   wuJ2wpq3m7A+3mer6a8PzN9bx4lNOzm9L4D97YZ1kLUlLI1wwPKm9l8mv
   w==;
X-CSE-ConnectionGUID: VpovVNS9QZ6oZAsD1mxB6w==
X-CSE-MsgGUID: ZWle/7GNThyL100OKZQFVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86195912"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="86195912"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 13:05:19 -0700
X-CSE-ConnectionGUID: Rj+Up9r9ROaukiVc2XF40w==
X-CSE-MsgGUID: qrORxW75TOmEpuALbY26zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="217809876"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 13:05:15 -0700
Date: Mon, 16 Mar 2026 22:05:13 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	Raymond Hackley <raymondhackley@protonmail.com>
Subject: Re: [PATCH v4 7/7] iio: light: vcnl4000: add support for regulators
Message-ID: <abhieY9gFHhMo8iO@ashevche-desk.local>
References: <20260316-vcnl4000-regulators-v4-0-854fc2eaf54b@gmail.com>
 <20260316-vcnl4000-regulators-v4-7-854fc2eaf54b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316-vcnl4000-regulators-v4-7-854fc2eaf54b@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 16, 2026 at 07:19:51PM +0200, Erikas Bitovtas wrote:
> Add supply, I2C and cathode voltage regulators to the sensor and enable
> them. This keeps the sensor powered on even after its only supply shared
> by another device shuts down.

...

> +	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulator_names),
> +					     regulator_names);

I was suggesting just to fix an indentation in your original approach,
but okay, this is not a big deal to have less logical split between lines.

> +	if (ret)
> +		return ret;

-- 
With Best Regards,
Andy Shevchenko


