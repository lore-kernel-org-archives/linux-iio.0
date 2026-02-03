Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7D3314B62;
	Tue,  3 Feb 2026 11:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770119490; cv=none; b=ut1uTBReaTgjuOjf2WTsVDyFwvhXrf/L1ZsSqHLq5yV65XEKslOyMrKe+sgW/SIWyT3m4ExNAF70q7+IC7ZaeKukkvzsrJjnNgcbkXQGmlDvz9xb5NaptsJjwX/6PUzgEtM9iwedD1BvK27eYQ0bhkM4gqGRZ3HWBLGBFnWXhE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770119490; c=relaxed/simple;
	bh=A34JWucoG45gavin3FDo5KzkRp3oWq3aimc7IqO5Fzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYulc3S09eWsr4f8p1PxooX2HIrPIo1/I94KuORTB4C5WT3SEJ9iBltmr9n4Xw4ba5Qu9Od6H10dpPekA8X4zc00IYJlqwab3ej3UnYLL6I+1+vq40Nk5SxsLIbmZ4IhfRNmUzQuFKknN1/yFFU52fs+6xd0Z3KAIXN5Rse2ReE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZrA+5ii8; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZrA+5ii8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770119488; x=1801655488;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A34JWucoG45gavin3FDo5KzkRp3oWq3aimc7IqO5Fzo=;
  b=ZrA+5ii8+xNKnEbWskt2vyRdUfyqQG2zQHgNIIuGhnQZtcKXHxaLMTQZ
   qSV/XJnn/QF33EOtAsfEbob80ibE7NGQtbHOABxCYWAkru/xoaQ/TLiel
   JsgL9FYRGduwG32I8bWM65AGCThDEn4LE+gEuGaW0Xl8NH/ZnW+2OlgJ2
   gnh53lYxZTdGrldIvZlNAgsdfbCH+rbz2XxbX9yQ4zA8lcKnW5cgMDMf+
   eBdMxxjpfeUDbui24LMjTtfTelQucVSIQsfrUJCNv6t+gbkvhJBgR2xJ6
   hlPJ7imUTI3/gnisVjrwpo2h6yP5ugablUDRJS6hcqsKdSdCP7enDtbxU
   g==;
X-CSE-ConnectionGUID: Iog0TLMeTl6vhHS3zsoTSw==
X-CSE-MsgGUID: As8flh34SGqS2zz/FhfI6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="93940012"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="93940012"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 03:51:28 -0800
X-CSE-ConnectionGUID: QHRcRJihSi6tJmKzRDGg4Q==
X-CSE-MsgGUID: vEZE85TlTiGcGlrNJm/E6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="209846293"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 03:51:25 -0800
Date: Tue, 3 Feb 2026 13:51:23 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: Re: [PATCH v4 06/13] iio: dac: ds4424: use device match data for
 chip info
Message-ID: <aYHhO7pJPEew7QMC@smile.fi.intel.com>
References: <20260203093434.2548978-1-o.rempel@pengutronix.de>
 <20260203093434.2548978-7-o.rempel@pengutronix.de>
 <aYHH69gXyuwmQR03@smile.fi.intel.com>
 <aYHLRvfJH54XumUA@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYHLRvfJH54XumUA@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 03, 2026 at 11:17:42AM +0100, Oleksij Rempel wrote:
> On Tue, Feb 03, 2026 at 12:03:23PM +0200, Andy Shevchenko wrote:
> > On Tue, Feb 03, 2026 at 10:34:26AM +0100, Oleksij Rempel wrote:

...

> > > -	indio_dev->name = id->name;
> > 
> > > +	indio_dev->name = client->name;
> > 
> > Isn't this an ABI breakage?
> 
> I can't confirm it.
> 
> before all patches:
> root@DistroKit:~ cat /sys/bus/iio/devices/iio:device3/name 
> ds4424
> 
> after:
> root@DistroKit:~ cat /sys/bus/iio/devices/iio:device3/name 
> ds4424

In ACPI case it might look differently, but I have no means to test this.

id->name comes strictly from an i2c table, while client->name is constructed
using specifics of the firmware enumeration. In DT due to some (historical?)
reasons the client->name has no vendor substring and hence matches 1:1 to
id->name. In ACPI, IIRC, the client->name is ACPI device instance name,
something like ABCD0123:00.


-- 
With Best Regards,
Andy Shevchenko


