Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35984396D05
	for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 08:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772095356; cv=none; b=iIhAZJLugRzOg2LGjTv+kd+kwGBy7Tj/Y72bMRfqTlocr0QkEavvcxwvJkYHmmnBTE/oUkdLq22bHex/JdJbnI2xddDNihXCFng9iYNojT6FRFt8IYUmPeO4XECY3618yGtJDMZlhnaSmluYePQQhEmK88WjU7Itbf0uoNx8GNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772095356; c=relaxed/simple;
	bh=pYjIX6gfN4dYFc0TBFsUfvbwxQcrKEuznQzs6IWNZYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mlo4pAUoMHqDkAmXlTpv83TlA9ghoH7Nsh7v67IqMVHWGxNhDQImK+f1oUklyOSx5vtOAA1JOch+94C+QOOVTqZgVxaSasnkkzku1pWsZh2lUh+0/A9bFYVVyIDcbgrP2Steo224ABWxwAkOZ+7bBpd1twZhvBh7kdJmzrUlmV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vvWwv-0002CJ-U6; Thu, 26 Feb 2026 09:42:21 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vvWwt-002hUN-2P;
	Thu, 26 Feb 2026 09:42:21 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vvWwu-00000006izX-460j;
	Thu, 26 Feb 2026 09:42:20 +0100
Date: Thu, 26 Feb 2026 09:42:20 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, kernel@pengutronix.de,
	David Jander <david@protonic.nl>,
	David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v6 00/12] iio: dac: ds4424: add DS4402/DS4404 support and
 scale
Message-ID: <aaAHbOVL-83tgIEc@pengutronix.de>
References: <20260210135110.2027073-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260210135110.2027073-1-o.rempel@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

Hi Jonathan,

Should I resend this patch series?

On Tue, Feb 10, 2026 at 02:50:58PM +0100, Oleksij Rempel wrote:
> changes v6:
> - rebase on top of iio/fixes-togreg
> - drop "iio: dac: ds4424: reject -128 RAW value", already included
> 
> This series extends the ds4424 IIO DAC driver and its devicetree binding
> to support the DS4402 and DS4404 current DAC variants.
> 
> DS440x devices share the same register map as DS442x but use a different
> resolution (5-bit vs 7-bit) and a different full-scale current formula.
> The full-scale current depends on external Rfs resistors connected to
> the FS pins, so a new optional DT property is added to provide the
> per-channel Rfs values and allow the driver to report a correct IIO
> SCALE (mA/step).
> 
> While adding DS440x support, a few related issues were addressed:
> - Port to regmap
> - Reject -128 in RAW writes on DS442x, which cannot be represented with
>   sign-magnitude encoding and could silently program an unintended
>   output.
> - Preserve preconfigured values on probe.
> - Ratelimit read error logging and use device context.
> 
> David Jander (1):
>   iio: dac: ds4424: add DS4402/DS4404 device IDs
> 
> Oleksij Rempel (11):
>   iio: dac: ds4424: refactor raw access to use bitwise operations
>   iio: dac: ds4424: ratelimit read errors and use device context
>   iio: dac: ds4424: sort headers alphabetically
>   iio: dac: ds4424: rename iio_info struct to avoid ambiguity
>   iio: dac: ds4424: use device match data for chip info
>   iio: dac: ds4424: use fsleep() instead of usleep_range()
>   dt-bindings: iio: dac: maxim,ds4424: add ds4402/ds4404
>   iio: dac: ds4424: support per-variant output range limits
>   iio: dac: ds4424: convert to regmap
>   dt-bindings: iio: dac: maxim,ds4424: add maxim,rfs-ohms property
>   iio: dac: ds4424: add Rfs-based scale and per-variant limits
> 
>  .../bindings/iio/dac/maxim,ds4424.yaml        |  42 +-
>  drivers/iio/dac/Kconfig                       |   1 +
>  drivers/iio/dac/ds4424.c                      | 375 ++++++++++++------
>  3 files changed, 287 insertions(+), 131 deletions(-)
> 
> --
> 2.47.3
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
