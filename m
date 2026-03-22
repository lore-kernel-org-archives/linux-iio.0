Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDC036B071
	for <linux-iio@vger.kernel.org>; Sun, 22 Mar 2026 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774200193; cv=none; b=F2T6eS9oUxBYGfONLhJIt9Cp/ZJJ17Ie/MDcyl+pvwr3KViigjFqzYWfQ4R/hB9/K1pzZ2wQrETrhRp0TqmrbiNsJxzj4vgP8AgWB06499DwEAtrK3DTJEeegHC+CeRjv4/i8gZD/uqVuXDU2P91+XQ3EbME90g3Ipz65r32caI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774200193; c=relaxed/simple;
	bh=eX0bMyQPn5KGVvIqo0BQQ1L5w7k5BdKAxmTmGe4uD70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzsMeZapxfUTa8oeNL4ICiuuxW95rUf5AOj/uJS7N+FtkU10VpHmqWy8mbsnqBWf9ufZ57MXFOxfOB/fbSn2nobNEeiqqVCJYPJRfa5phM/BUuW43hoVEzY2ozV6qAtHrtle5X5juiRTzk6mGKZ9a9TEYzDZsKByAmD/KcES85E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1w4MVj-0005Wx-5u; Sun, 22 Mar 2026 18:22:47 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1w4MVi-001awa-0G;
	Sun, 22 Mar 2026 18:22:46 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1w4MVh-0000000GaXd-45Vq;
	Sun, 22 Mar 2026 18:22:45 +0100
Date: Sun, 22 Mar 2026 18:22:45 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andy@kernel.org>, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, kernel@pengutronix.de,
	David Jander <david@protonic.nl>,
	David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v6 00/12] iio: dac: ds4424: add DS4402/DS4404 support and
 scale
Message-ID: <acAlZe8Y5Qj5a_Vf@pengutronix.de>
References: <20260210135110.2027073-1-o.rempel@pengutronix.de>
 <aaAHbOVL-83tgIEc@pengutronix.de>
 <20260226100833.24fa15b5@jic23-huawei>
 <20260322124539.64485997@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260322124539.64485997@jic23-huawei>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

On Sun, Mar 22, 2026 at 12:45:39PM +0000, Jonathan Cameron wrote:
> On Thu, 26 Feb 2026 10:08:33 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Thu, 26 Feb 2026 09:42:20 +0100
> > Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> > 
> > > Hi Jonathan,
> > > 
> > > Should I resend this patch series?  
> > No need.   For future reference I use patchwork.kernel.org to track
> > status of series.   This one is sat there because I need to do a pull
> > request for the precursor fix (which I'll do shortly).  That then needs
> > to loop around into a suitable upstream tree before I can pick this
> > series up on top of it.
> > 
> I merge 7.0-rc4 into the testing branch of iio.git and applied this on top.
> If the build bots are happy I'll push that out as togreg in the next few days.
> A little bit of fuzz in a few patches but otherwise it went on pretty cleanly.
> 
> Please take a quick look to make sure I didn't mess anything up.

LGTM. Thank you!

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
