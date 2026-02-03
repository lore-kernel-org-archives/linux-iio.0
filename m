Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672923EBF0F
	for <linux-iio@vger.kernel.org>; Tue,  3 Feb 2026 10:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770113869; cv=none; b=Z0+mwtdKgDd9+nwC6/b6pNamw6n4R2a/m6PSuiVjFtJR076cG5SBPHjP8dQS9daFtM9FXpyNvBRUYTCgqWljb+fuhhvpy1QOGMp6LehTjxKZwITcxPDZpYrlFmhjcstx4bhoYNIjQli0v4lK72Erm2zPHd0uD7iv8rQccudrwYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770113869; c=relaxed/simple;
	bh=SZVVaNK2h+OzP2xP9j3rsyTuU0KZcRKEQdhlEvG7ebo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WY7m0ZrOy/LdsRbaWuiVc5SiH6yQWw7Ywx9F/Ct5RMnFWkIcAs5tFH7HnY/yIRynT6QdNFGwtYydhTyPy+bPlPrR+3wbM2xXBSU0oyG+asYYzKCZNODES3r1/VnnqSpnSyslLBEhFKNhrKwlVjPEn0Zg+AF+uCB6rfWcqh1BRx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vnDTb-0001pH-Fs; Tue, 03 Feb 2026 11:17:43 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vnDTb-003tAm-0D;
	Tue, 03 Feb 2026 11:17:42 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vnDTa-00E2EQ-0p;
	Tue, 03 Feb 2026 11:17:42 +0100
Date: Tue, 3 Feb 2026 11:17:42 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: Re: [PATCH v4 06/13] iio: dac: ds4424: use device match data for
 chip info
Message-ID: <aYHLRvfJH54XumUA@pengutronix.de>
References: <20260203093434.2548978-1-o.rempel@pengutronix.de>
 <20260203093434.2548978-7-o.rempel@pengutronix.de>
 <aYHH69gXyuwmQR03@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aYHH69gXyuwmQR03@smile.fi.intel.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

On Tue, Feb 03, 2026 at 12:03:23PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 03, 2026 at 10:34:26AM +0100, Oleksij Rempel wrote:
> > Refactor the driver to use device match data instead of checking ID enums
> > in a switch statement.
> > 
> > Define a `ds4424_chip_info` structure to hold variant-specific attributes
> > (currently just the channel count) and attach it directly to the I2C and
> > OF device ID tables.
> > 
> > Use `client->name` instead of `id->name` to decouple the probe function
> > from the legacy `i2c_device_id` structure.
> > 
> > This simplifies the probe function and makes it easier to add support for
> > new variants like DS4402/DS4404.
> 
> ...
> 
> > -	indio_dev->name = id->name;
> 
> > +	indio_dev->name = client->name;
> 
> Isn't this an ABI breakage?

I can't confirm it.

before all patches:
root@DistroKit:~ cat /sys/bus/iio/devices/iio:device3/name 
ds4424

after:
root@DistroKit:~ cat /sys/bus/iio/devices/iio:device3/name 
ds4424



-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
