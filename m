Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45658 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753066AbbGSJc2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jul 2015 05:32:28 -0400
Message-ID: <55AB6EA9.7020909@kernel.org>
Date: Sun, 19 Jul 2015 10:32:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Stefan Wahren <stefan.wahren@i2se.com>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marek Vasut <marex@denx.de>,
	=?windows-1252?Q?Kristina_Mart=9Aenko?=
	<kristina.martsenko@gmail.com>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH 1/6] iio: mxs-lradc: clarify supported devices
References: <1437222646-8742-1-git-send-email-stefan.wahren@i2se.com> <1437222646-8742-2-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1437222646-8742-2-git-send-email-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/07/15 13:30, Stefan Wahren wrote:
> At the beginning the driver supported only i.MX28 SoC, but now the
> whole MXS platform. So remove any confusing comments which apply
> only to i.MX28.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Applied to the togreg branch of iio.git. Initially pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  .../bindings/staging/iio/adc/mxs-lradc.txt         |    2 +-
>  drivers/staging/iio/adc/mxs-lradc.c                |   18 +++++++++---------
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/staging/iio/adc/mxs-lradc.txt b/Documentation/devicetree/bindings/staging/iio/adc/mxs-lradc.txt
> index 3075377..555fb11 100644
> --- a/Documentation/devicetree/bindings/staging/iio/adc/mxs-lradc.txt
> +++ b/Documentation/devicetree/bindings/staging/iio/adc/mxs-lradc.txt
> @@ -1,4 +1,4 @@
> -* Freescale i.MX28 LRADC device driver
> +* Freescale MXS LRADC device driver
>  
>  Required properties:
>  - compatible: Should be "fsl,imx23-lradc" for i.MX23 SoC and "fsl,imx28-lradc"
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
> index d7c5223..1ccb367 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -1,5 +1,5 @@
>  /*
> - * Freescale i.MX28 LRADC driver
> + * Freescale MXS LRADC driver
>   *
>   * Copyright (c) 2012 DENX Software Engineering, GmbH.
>   * Marek Vasut <marex@denx.de>
> @@ -1392,7 +1392,7 @@ static const struct iio_chan_spec mxs_lradc_chan_spec[] = {
>  	MXS_ADC_CHAN(4, IIO_VOLTAGE),
>  	MXS_ADC_CHAN(5, IIO_VOLTAGE),
>  	MXS_ADC_CHAN(6, IIO_VOLTAGE),
> -	MXS_ADC_CHAN(7, IIO_VOLTAGE),	/* VBATT */
> +	MXS_ADC_CHAN(7, IIO_VOLTAGE),
>  	/* Combined Temperature sensors */
>  	{
>  		.type = IIO_TEMP,
> @@ -1411,12 +1411,12 @@ static const struct iio_chan_spec mxs_lradc_chan_spec[] = {
>  		.scan_index = -1,
>  		.channel = 9,
>  	},
> -	MXS_ADC_CHAN(10, IIO_VOLTAGE),	/* VDDIO */
> -	MXS_ADC_CHAN(11, IIO_VOLTAGE),	/* VTH */
> -	MXS_ADC_CHAN(12, IIO_VOLTAGE),	/* VDDA */
> -	MXS_ADC_CHAN(13, IIO_VOLTAGE),	/* VDDD */
> -	MXS_ADC_CHAN(14, IIO_VOLTAGE),	/* VBG */
> -	MXS_ADC_CHAN(15, IIO_VOLTAGE),	/* VDD5V */
> +	MXS_ADC_CHAN(10, IIO_VOLTAGE),
> +	MXS_ADC_CHAN(11, IIO_VOLTAGE),
> +	MXS_ADC_CHAN(12, IIO_VOLTAGE),
> +	MXS_ADC_CHAN(13, IIO_VOLTAGE),
> +	MXS_ADC_CHAN(14, IIO_VOLTAGE),
> +	MXS_ADC_CHAN(15, IIO_VOLTAGE),
>  };
>  
>  static int mxs_lradc_hw_init(struct mxs_lradc *lradc)
> @@ -1707,6 +1707,6 @@ static struct platform_driver mxs_lradc_driver = {
>  module_platform_driver(mxs_lradc_driver);
>  
>  MODULE_AUTHOR("Marek Vasut <marex@denx.de>");
> -MODULE_DESCRIPTION("Freescale i.MX28 LRADC driver");
> +MODULE_DESCRIPTION("Freescale MXS LRADC driver");
>  MODULE_LICENSE("GPL v2");
>  MODULE_ALIAS("platform:" DRIVER_NAME);
> 

