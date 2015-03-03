Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:56216 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753534AbbCCJGG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 3 Mar 2015 04:06:06 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Denis Carikli <denis@eukrea.com>,
	Eric =?ISO-8859-1?Q?B=E9nard?= <eric@eukrea.com>,
	Sascha Hauer <kernel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v7 1/8] ARM: dt: Binding documentation for imx25 ADC/TSC
Date: Tue, 03 Mar 2015 10:02:12 +0100
Message-ID: <2620642.Qp1W4O8uh6@wuerfel>
In-Reply-To: <1425369498-25541-2-git-send-email-mpa@pengutronix.de>
References: <1425369498-25541-1-git-send-email-mpa@pengutronix.de> <1425369498-25541-2-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tuesday 03 March 2015 08:58:11 Markus Pargmann wrote:
> +Example:
> +       tscadc: tscadc@50030000 {
> +               compatible = "fsl,imx25-tsadc";
> +               reg = <0x50030000 0xc>;
> +               interrupts = <46>;
> +               clocks = <&clks 119>;
> +               clock-names = "ipg";
> +               interrupt-controller;
> +               #interrupt-cells = <1>;
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +
> +               tsc: tcq@50030400 {
> +                       compatible = "fsl,imx25-tcq";
> +                       reg = <0x50030400 0x60>;
> +                       ...
> +               };
> +
> +               adc: gcq@50030800 {
> +                       compatible = "fsl,imx25-gcq";
> +                       reg = <0x50030800 0x60>;
> +                       ...
> +               };
> +       };
> 

I wonder if we should just treat this MFD as a single IIO device
that also registers to the input layer.

Are there any other registers in the 0x50030000-0x50031000
range, or could the fsl,imx25-tcq and fsl,imx25-gcq devices
be reused outside of a fsl,imx25-tsadc device?

	Arnd
