Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:62388 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755893AbcECLIG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2016 07:08:06 -0400
Subject: Re: [PATCH 1/3] iio: mxs-lradc: Add regulators for current sources
To: Harald Geyer <harald@ccbib.org>
References: <1461333147-11873-1-git-send-email-harald@ccbib.org>
 <1461333147-11873-2-git-send-email-harald@ccbib.org>
Cc: Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Marek Vasut <marex@denx.de>,
	linux-arm-kernel@lists.infradead.org
From: Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <57288674.9050601@i2se.com>
Date: Tue, 3 May 2016 13:07:32 +0200
MIME-Version: 1.0
In-Reply-To: <1461333147-11873-2-git-send-email-harald@ccbib.org>
Content-Type: text/plain; charset=iso-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Harald,

Am 22.04.2016 um 15:52 schrieb Harald Geyer:
> The hardware has two current sources ISRC0 and ISRC1 to allow measuring
> resistors without additional circuitry. This commit makes them available
> as regulators.
>
> Tested on an imx233-olinuxino board.
>
> Signed-off-by: Harald Geyer <harald@ccbib.org>
> ---
> The current regulator API doesn't fit this type of device very well: Typically
> consumers will want to set a defined current, ie. min_uA == max_uA, but they
> can't without help from configuration data, because the valid values aren't
> reported by the API for current regulators. I have been thinking about
> extending the API, but currently AFAIK no such consumers exist and most
> users, like myself, will force the regulator to a defined value in
> devicetree anyway.
>
>  .../bindings/staging/iio/adc/mxs-lradc.txt         |  29 ++++
>  drivers/iio/adc/Kconfig                            |   1 +
>  drivers/iio/adc/mxs-lradc.c                        | 152 +++++++++++++++++++++
>  3 files changed, 182 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/staging/iio/adc/mxs-lradc.txt b/Documentation/devicetree/bindings/staging/iio/adc/mxs-lradc.txt
> index 555fb11..983952c 100644
> --- a/Documentation/devicetree/bindings/staging/iio/adc/mxs-lradc.txt
> +++ b/Documentation/devicetree/bindings/staging/iio/adc/mxs-lradc.txt
> @@ -19,6 +19,15 @@ Optional properties:
>  - fsl,settling: delay between plate switch to next sample. Allowed value is
>                  1 ... 2047. It counts at 2 kHz and its default is
>                  10 (= 5 ms)
> +- ISRC0: A node describing the regulator of internal current source 0
> +- ISRC1: A node describing the regulator of internal current source 1
> +
> +Required properties for the ISRCx sub-nodes:
> +- regulator-max-microamp: See standard regulator binding documentation.
> +                          Valid values are from 0 to 300 in steps of 20.
> +
> +Optional properties for the ISRCx sub-nodes:
> +Any standard regulator properties that apply to current regulators.
>  
>  Example for i.MX23 SoC:
>  
> @@ -31,6 +40,16 @@ Example for i.MX23 SoC:
>  		fsl,ave-ctrl = <4>;
>  		fsl,ave-delay = <2>;
>  		fsl,settling = <10>;
> +
> +		isrc_lradc0: ISRC0 {
> +			regulator-max-microamp = <300>;
> +		};
> +
> +		isrc_lradc1: ISRC1 {
> +			regulator-max-microamp = <120>;
> +			regulator-min-microamp = <120>;
> +			regulator-always-on;
> +		};

IMHO the binding should represent the direct connection between the
current source and the physical channel. I think a node label isn't
enough. Unfortunately i don't have an idea to do it the "right way".

>  	};
>  
>  Example for i.MX28 SoC:
> @@ -44,4 +63,14 @@ Example for i.MX28 SoC:
>  		fsl,ave-ctrl = <4>;
>  		fsl,ave-delay = <2>;
>  		fsl,settling = <10>;
> +
> +		isrc_lradc0: ISRC0 {
> +			regulator-max-microamp = <300>;
> +		};
> +
> +		isrc_lradc6: ISRC1 {
> +			regulator-max-microamp = <120>;
> +			regulator-min-microamp = <120>;
> +			regulator-always-on;
> +		};
>  	};
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 5937030..1968d1c 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -319,6 +319,7 @@ config MXS_LRADC
>          tristate "Freescale i.MX23/i.MX28 LRADC"
>          depends on (ARCH_MXS || COMPILE_TEST) && HAS_IOMEM
>          depends on INPUT
> +        depends on REGULATOR

Any chance to avoid this dependency for an optional feature?

Stefan

>          select STMP_DEVICE
>          select IIO_BUFFER
>          select IIO_TRIGGERED_BUFFER

