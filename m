Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58455 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbbCGSYP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 7 Mar 2015 13:24:15 -0500
Message-ID: <54FB4249.6070801@kernel.org>
Date: Sat, 07 Mar 2015 18:24:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Markus Pargmann <mpa@pengutronix.de>,
	Shawn Guo <shawn.guo@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>
CC: Denis Carikli <denis@eukrea.com>,
	=?windows-1252?Q?Eric_B=E9nard?= <eric@eukrea.com>,
	Sascha Hauer <kernel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v7 0/8] imx25 adc and touchscreen driver
References: <1425369498-25541-1-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1425369498-25541-1-git-send-email-mpa@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/03/15 07:58, Markus Pargmann wrote:
> Hi,
> 
> This series adds a driver for the Freescale i.MX25 SoC internal ADC unit which
> is used for touchscreen and ADC. The driver consists of three parts, the MFD
> driver which handles interrupts and some central configuration registers, the
> ADC driver and the touchscreen driver.
> 
> v7 has some modifications in the probe functions to use devres irq requests.
> irq checks were fixed to check for irqs <= 0. The header was cleaned up to have
> a more uniform presentation of the bit fields. Detailed changelogs are attached
> to the according mails.
> 
> Best Regards,
> 
> Markus
Almost there as far as I am concerned.  Just that one unbalanced regulator_enable
that needs dealing with.  The bindings are pretty simple so whilst a device-tree
ack would of course be great I guess it could be taken without.

This wants to go via mfd or I suppose the freescale/arm-soc tree.  Either is fine
with me.

Jonathan
> 
> 
> Denis Carikli (2):
>   ARM: dts: imx25: Add TSC and ADC support
>   ARM: imx_v4_v5_defconfig: Add I.MX25 Touchscreen controller and ADC
>     support.
> 
> Markus Pargmann (6):
>   ARM: dt: Binding documentation for imx25 ADC/TSC
>   ARM: dt: Binding documentation for imx25 GCQ
>   ARM: dt: Binding documentation for imx25 touchscreen controller
>   mfd: fsl imx25 Touchscreen ADC driver
>   iio: adc: fsl,imx25-gcq driver
>   input: touchscreen: imx25 tcq driver
> 
>  .../devicetree/bindings/iio/adc/fsl,imx25-gcq.txt  |  54 ++
>  .../bindings/input/touchscreen/fsl-mx25-tcq.txt    |  29 +
>  .../devicetree/bindings/mfd/fsl-imx25-tsadc.txt    |  46 ++
>  arch/arm/boot/dts/imx25.dtsi                       |  30 +-
>  arch/arm/configs/imx_v4_v5_defconfig               |   4 +
>  drivers/iio/adc/Kconfig                            |   7 +
>  drivers/iio/adc/Makefile                           |   1 +
>  drivers/iio/adc/fsl-imx25-gcq.c                    | 356 +++++++++++++
>  drivers/input/touchscreen/Kconfig                  |   6 +
>  drivers/input/touchscreen/Makefile                 |   1 +
>  drivers/input/touchscreen/fsl-imx25-tcq.c          | 593 +++++++++++++++++++++
>  drivers/mfd/Kconfig                                |  10 +
>  drivers/mfd/Makefile                               |   2 +
>  drivers/mfd/fsl-imx25-tsadc.c                      | 164 ++++++
>  include/dt-bindings/iio/adc/fsl-imx25-gcq.h        |  18 +
>  include/linux/mfd/imx25-tsadc.h                    | 141 +++++
>  16 files changed, 1459 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt
>  create mode 100644 drivers/iio/adc/fsl-imx25-gcq.c
>  create mode 100644 drivers/input/touchscreen/fsl-imx25-tcq.c
>  create mode 100644 drivers/mfd/fsl-imx25-tsadc.c
>  create mode 100644 include/dt-bindings/iio/adc/fsl-imx25-gcq.h
>  create mode 100644 include/linux/mfd/imx25-tsadc.h
> 

