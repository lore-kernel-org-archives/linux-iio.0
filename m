Return-Path: <SRS0=AxjO=3W=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB73BC3524B
	for <linux-iio@archiver.kernel.org>; Sun,  2 Feb 2020 09:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E872086A
	for <linux-iio@archiver.kernel.org>; Sun,  2 Feb 2020 09:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580637134;
	bh=WnuHvcNhi03J05r188dBuWuqXjZDCK2ppNbVC9tfFh8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Xpq0bJYaYgjIHhbsltd3lL9WRbgvb4ICAVNzu7cvgwD5PGgKyebO/GBwuOC3mvYqB
	 QRxt4PLxNsBpbOka80s5wrD7TZ+u2cDWNXmZOu7DAdKlcml50r16PinJ0dxQcNlLPZ
	 Xv9yDBIFIipdcc4kGQ1ramH6XR+C98vCbdzRl124=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgBBJwN (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 2 Feb 2020 04:52:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:49308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbgBBJwN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 Feb 2020 04:52:13 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E6E0206D3;
        Sun,  2 Feb 2020 09:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580637133;
        bh=WnuHvcNhi03J05r188dBuWuqXjZDCK2ppNbVC9tfFh8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BIm2sGfYkS6UpmfgyjQba1JbzQzkHRfs0f0cgL2bghUB2LdP61ythvtqVChnqqu0v
         H/KrU7zFgV72gFoXV1UoXwfwp6znPGo2RSa5om868p46vnbGuqniCi9NRvAClpVsZl
         8vfh1Qs5Jnmh6a3I9YO2SwtZHezJvj31NCoVe32s=
Date:   Sun, 2 Feb 2020 09:52:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>,
        Silvan Murer <silvan.murer@gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: iio: ltc2632: expand for ltc2636
 support
Message-ID: <20200202095207.511afbf1@archlinux>
In-Reply-To: <20200130131549.1170-1-u.kleine-koenig@pengutronix.de>
References: <20200130131549.1170-1-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 30 Jan 2020 14:15:47 +0100
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> wrote:

> The ltc2636 family of devices is register compatible with the ltc2636
> chips, it just features 8 instead of 2 channels.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/iio/dac/ltc2632.txt | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/dac/ltc2632.txt b/Docu=
mentation/devicetree/bindings/iio/dac/ltc2632.txt
> index e0d5fea33031..9d114957a28b 100644
> --- a/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
> +++ b/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
> @@ -1,4 +1,4 @@
> -Linear Technology LTC2632 DAC device driver
> +Linear Technology LTC2632/2636 DAC device driver

Whilst we are here, can we clear out the reference to 'driver'.
It's a binding so describes the hardware, not the driver talking
to it.

Linear Technology LTC... DAC

If that's all that comes up, I can tidy this up when applying.

Jonathan

> =20
>  Required properties:
>   - compatible: Has to contain one of the following:
> @@ -8,6 +8,12 @@ Required properties:
>  	lltc,ltc2632-h12
>  	lltc,ltc2632-h10
>  	lltc,ltc2632-h8
> +	lltc,ltc2636-l12
> +	lltc,ltc2636-l10
> +	lltc,ltc2636-l8
> +	lltc,ltc2636-h12
> +	lltc,ltc2636-h10
> +	lltc,ltc2636-h8
> =20
>  Property rules described in Documentation/devicetree/bindings/spi/spi-bu=
s.txt
>  apply. In particular, "reg" and "spi-max-frequency" properties must be g=
iven.

