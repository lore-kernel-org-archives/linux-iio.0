Return-Path: <Shawn.Guo@freescale.com>
Date: Thu, 18 Sep 2014 21:34:27 +0800
From: Shawn Guo <shawn.guo@freescale.com>
To: Sanchayan Maity <maitysanchayan@gmail.com>
CC: <stefan@agner.ch>, <jic23@kernel.org>, <B38611@freescale.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] Implement temperature sensor for vf610-adc
Message-ID: <20140918133426.GI4796@dragon>
References: <cover.1411039381.git.maitysanchayan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <cover.1411039381.git.maitysanchayan@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Thu, Sep 18, 2014 at 05:23:22PM +0530, Sanchayan Maity wrote:
> Vybrid ADC peripheral includes a temperature sensor
> which is connected to channel number 26. The patch
> adds support for the sensor. The raw value is read
> and the temperature calculated in milli degree Celsius,
> which is returned using IIO_CHAN_INFO_PROCESSED option.
> 
> Sanchayan Maity (1):
>   ARM: imx: vf610-adc: Add temperature sensor support

This is not an arch/arm/mach-imx patch, so shouldn't be prefixed with
"ARM: imx: ".  And also it's more appropriate to put Jonathan Cameron
<jic23@kernel.org> on "To:", since he is responsible for picking
drivers/iio/adc patches.

Shawn

> 
>  drivers/iio/adc/vf610_adc.c |   28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> -- 
> 1.7.9.5
> 
