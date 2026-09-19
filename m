Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E8E314B6E;
	Sat, 19 Sep 2026 14:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789827254; cv=none; b=OrPeRVQf60UBb82M0wrPYOtkm4TgcSYvNNgqkJi67/ckBEP0FyKdBNGDXy57b45uNV2EVukulSmKSfG7tGwaFf+jqsLwXtPe/pgh5hpJUTqHayiZeYRYCrnQmG4YreWbJerbgLxb7hpBzQGn2blJyd6yCzXFEOaNOWyxTzadToU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789827254; c=relaxed/simple;
	bh=flNcv4zjbzI0ut3B3QMAJ32tuV7ahu8gYnU5s7oc+wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSokCme+a4sW7iHCIyYqoV97L/UW6txsDEobuKYQ6+Ig27+L1GygJMRjM2IDvZhDbD+CD3/6Lco/8Cb4WyQ3I6Y9TFI9h96PckyFezCaTu0jOnCYCXOXKDAJjiTa56xkerGAREaIAAHXrxNzdxnxv6QxQwpC0CaX/xRLWg6z/9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B84sUww2; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B84sUww2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789827253; x=1821363253;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=flNcv4zjbzI0ut3B3QMAJ32tuV7ahu8gYnU5s7oc+wE=;
  b=B84sUww2dXIg0azsrGn1DhvPOfkv54kuXyxjrL6kInAeySJ20jUuML8S
   n0ZhY4i6YgPyw1NkzFiAonFxfzP2i2tSNNK9KtOrb+QMSABOmMj9qN7LG
   Yc0G0lDq2wMC8wpqXAihsClRp48btM2Q/Bu7laMxLcdT5pV02TFdfONg1
   C2TA2fqbAQbBSJ3MjpX3nnrmH3+IgfFpeItfZfrTdxVoXB9dr9h6Wdl/n
   MMzB133CRLRjpS0XxzEa2Pvy307HllgUtF/jMQumysbvP4kfNWahESNLO
   Eu0KRo4h41Ja7Nj3xuo38JERlEW7zdOm1gIlzQneGJvHSbJEZp5zYzAmm
   A==;
X-CSE-ConnectionGUID: fztAHAo6SeeftW2YT3UwNw==
X-CSE-MsgGUID: YcVXFYYMTFe3Nx/ymPlX7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11910"; a="115884706"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="115884706"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2026 07:14:12 -0700
X-CSE-ConnectionGUID: uQBg4NTYTayIATiXgmBXyw==
X-CSE-MsgGUID: yyt11RS2QlCqAbxsMZRsjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="3302519"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.50])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2026 07:14:09 -0700
Date: Sat, 19 Sep 2026 17:14:03 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shi Hao <i.shihao.999@gmail.com>,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: light: add AS7343 multi-spectral sensor
 driver
Message-ID: <aq6Yq6L_adUwsIce@ashevche-desk.local>
References: <20260912013912.51887-1-marcus.yu.56@gmail.com>
 <20260912013912.51887-3-marcus.yu.56@gmail.com>
 <aqepkmQS_p6K1Bd6@ashevche-desk.local>
 <aq4FioMYYiPqlhwS@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aq4FioMYYiPqlhwS@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 18, 2026 at 08:46:18PM -0700, Chang Yu wrote:
> On Mon, Sep 14, 2026 at 11:00:18AM +0300, Andy Shevchenko wrote:
> > On Fri, Sep 11, 2026 at 06:39:12PM -0700, Chang Yu wrote:

...

> > > +/* AS7343 FIFO buffer data registers */
> > > +#define AS7343_FIFO_LVL		0xfd
> > > +#define AS7343_FDATA_L		0xfe
> > > +#define AS7343_FDATA_H		0xff
> > 
> > Please, keep indentation for the registers the same. Also would be nice to have
> > them sorted by offset.
> > 
> Due to the register layout sometimes registers with similar
> functions/purposes are scattered across the address space. As a
> compromise I'll group registers by purposes and sort by offset within
> the same group.

I understand your motivation, but it makes list of the definitions harder to
follow. Are they also grouped like this in the official datasheet? If so,
no problems then, otherwise consider following the suggestion.

-- 
With Best Regards,
Andy Shevchenko


