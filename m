Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC61345CAF
	for <linux-iio@vger.kernel.org>; Tue, 27 Jan 2026 10:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769510960; cv=none; b=sLXxtHZAlgNC2zLyYdAhyhryqc2Z4alZB2MUfuzLObiuuKrSzT+Y/AuQd0sPnWVhaTZhNfaJfD4+G7vKaA7HclpqojpaysG3WZ/jHHI7tUAytWh2wPVmFkn2nD5SVkEWMoiNv0Z9mAjIbWLR0OmQM7FcULwt0vYgTGAxrslV6VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769510960; c=relaxed/simple;
	bh=RLNOplt5iqFZ0f2CGEMaBfKeBIgV7AUHRe1T32MXLrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boTE/HEhT9SWW4j1WGoUmHz0hv+zTuBGisSgBUblkjdcHHOPUyKZQnUVCbPddXrmX6lUcJRgy9RYHotYMYeNPn1S7wl2dqyZ4hKnGfJx03mBtaX4d2TU6hdCokgGGd8JdVGFXhqIJWLF9v+PIT7mUY/z+FpnZtZ0CvaGBncHFG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vkgd8-0008Jo-W0; Tue, 27 Jan 2026 11:49:07 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vkgd8-002jZH-0H;
	Tue, 27 Jan 2026 11:49:05 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vkgd7-000o8s-0s;
	Tue, 27 Jan 2026 11:49:05 +0100
Date: Tue, 27 Jan 2026 11:49:05 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, stable@vger.kernel.org,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: Re: [PATCH v2 6/8] iio: dac: ds4424: fix -128 rejection and refactor
 raw access
Message-ID: <aXiYIYd08vFfLoIQ@pengutronix.de>
References: <20260127060939.3914006-1-o.rempel@pengutronix.de>
 <20260127060939.3914006-7-o.rempel@pengutronix.de>
 <aXiWkF04r7FkLPRx@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aXiWkF04r7FkLPRx@smile.fi.intel.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

On Tue, Jan 27, 2026 at 12:42:24PM +0200, Andy Shevchenko wrote:
> On Tue, Jan 27, 2026 at 07:09:37AM +0100, Oleksij Rempel wrote:
> > The DS442x DAC uses sign-magnitude encoding, so -128 cannot be represented.
> > Previously, passing -128 resulted in a truncated value that programmed 0mA.
> > 
> > Fix this by validating the input against the 7-bit magnitude limit.
> > Additionally, refactor the raw access logic to use symmetrical bitwise
> > operations, replacing the union structure.
> 
> > Fixes: d632a2bd8ffc ("iio: dac: ds4422/ds4424 dac driver")
> > +		/*
> > +		 * Currents exiting the IC (Source) are positive.
> > +		 * Canonicalize 0 to sink; datasheet treats sign as don't-care.
> > +		 */
> > +		if (val > 0)
> > +			abs_val |= DS4424_DAC_SOURCE;
> 
> Hmm... Maybe 0 should be excluded as invalid?

0 is valid value for no current flow (power off). The direction bit
DS4424_DAC_SOURCE  will just make no difference if value is 0.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
