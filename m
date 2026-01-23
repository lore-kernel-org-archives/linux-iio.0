Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B7430F92E
	for <linux-iio@vger.kernel.org>; Fri, 23 Jan 2026 09:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769162388; cv=none; b=ahk5/4hkIABFncslej8Nsiz6uWOo65uXq6ujS5jKyd8S6CHvqHnwr25dr4n8cycHzLSfTqNchE06xUNiUJnBfhRQXL9R76LCZ0J1IF2UbEFcyGeHb4Z3ejPTpJwhsyGRdsIJ48UMUdpBVxt/98OYSQwPEGx/07RiTT26w3NS29w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769162388; c=relaxed/simple;
	bh=yyDwabrTYrJpFXvPN1Y+Tn8xXCiOdVIuaECjT5c3qc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzCjiGTvYpVPhERB5DZYNq60DtGiQ10FA9F/lruByEPpZKlH993tPC7VQIvrBglsDIfOMRKMqSqt0nmFxO3+mcz5xSqfNLQLR3EQR/PFufds29zOMDi3wSQsc751bk6GDjqEsCcB1LtbB+h0CIIVWXKTDfGyJgIuu9bJRUyzbvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vjDx0-0002hV-LR; Fri, 23 Jan 2026 10:59:34 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vjDx0-0024Ql-0v;
	Fri, 23 Jan 2026 10:59:33 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vjDwz-00Atke-1e;
	Fri, 23 Jan 2026 10:59:33 +0100
Date: Fri, 23 Jan 2026 10:59:33 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: Re: [PATCH v1 6/8] iio: dac: ds4424: clear outputs on probe
Message-ID: <aXNGhVTuzJpzQkxV@pengutronix.de>
References: <20260119182424.1660601-1-o.rempel@pengutronix.de>
 <20260119182424.1660601-7-o.rempel@pengutronix.de>
 <20260123093804.139f0409@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260123093804.139f0409@jic23-huawei>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

On Fri, Jan 23, 2026 at 09:38:04AM +0000, Jonathan Cameron wrote:
> On Mon, 19 Jan 2026 19:24:22 +0100
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> > The DS44xx devices have no reset pin or reset bit, so output registers
> > may retain preconfigured values across reboot or warm reset.
> > 
> > Also, the driver suspend/resume path restores from data->raw. When the
> > device is first probed, data->raw is zero-initialized and may not match
> > the actual hardware state. A later suspend/resume can therefore change an
> > output from a preconfigured non-zero value to 0 mA.
> 
> For DACs we often want to retain settings from before kernel load (or
> on exit of the driver).  Can we just read them back from the device to
> fill in the cached versions?  If we can I think that would be preferred
> option.

ACK, i was not sure what is the best way here.

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
