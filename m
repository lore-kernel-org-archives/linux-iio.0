Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbeJ2AUw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Oct 2018 20:20:52 -0400
Date: Sun, 28 Oct 2018 15:35:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dan O'Donovan <dan@emutex.com>
Cc: linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Carlos Iglesias <carlos.iglesias@emutex.com>,
        Javier Arteaga <javier@emutex.com>
Subject: Re: [PATCH v3 1/3] iio: adc128s052: Add pin-compatible IDs
Message-ID: <20181028153551.6f2cccac@archlinux>
In-Reply-To: <1540481742-23596-2-git-send-email-dan@emutex.com>
References: <20180423213805.12591-1-javier@emutex.com>
        <1540481742-23596-1-git-send-email-dan@emutex.com>
        <1540481742-23596-2-git-send-email-dan@emutex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 25 Oct 2018 16:35:40 +0100
Dan O'Donovan <dan@emutex.com> wrote:

> From: Javier Arteaga <javier@emutex.com>
> 
> The datasheets for ADC122S021 and ADC124S021 list two more
> pin-compatible alternatives for each device.
> 
> Add their IDs as compatible strings.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Javier Arteaga <javier@emutex.com>
> Signed-off-by: Dan O'Donovan <dan@emutex.com>
> ---
>  .../devicetree/bindings/iio/adc/ti-adc128s052.txt        |  9 ++++++++-
>  drivers/iio/adc/ti-adc128s052.c                          | 16 ++++++++++++----
>  2 files changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt b/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt
> index daa2b2c..c07ce1a 100644
> --- a/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/ti-adc128s052.txt
> @@ -1,7 +1,14 @@
>  * Texas Instruments' ADC128S052, ADC122S021 and ADC124S021 ADC chip
>  
>  Required properties:
> - - compatible: Should be "ti,adc128s052", "ti,adc122s021" or "ti,adc124s021"
> + - compatible: Should be one of:
> +   - "ti,adc128s052"
Hmm.  Ideally I think these should be in 'alphabetical' order. However
I can see a certain logic to having the part whose name we are using for
the driver listed first..

Not important enough to change.

> +   - "ti,adc122s021"
> +   - "ti,adc122s051"
> +   - "ti,adc122s101"
> +   - "ti,adc124s021"
> +   - "ti,adc124s051"
> +   - "ti,adc124s101"
>   - reg: spi chip select number for the device
>   - vref-supply: The regulator supply for ADC reference voltage
>  
> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> index 7cf39b3..e6716c3 100644
> --- a/drivers/iio/adc/ti-adc128s052.c
> +++ b/drivers/iio/adc/ti-adc128s052.c
> @@ -186,15 +186,23 @@ static int adc128_remove(struct spi_device *spi)
>  static const struct of_device_id adc128_of_match[] = {
>  	{ .compatible = "ti,adc128s052", },
>  	{ .compatible = "ti,adc122s021", },
> +	{ .compatible = "ti,adc122s051", },
> +	{ .compatible = "ti,adc122s101", },
>  	{ .compatible = "ti,adc124s021", },
> -	{ /* sentinel */ },
> +	{ .compatible = "ti,adc124s051", },
> +	{ .compatible = "ti,adc124s101", },
> +	{ }
Dropping then sentinel shouldn't have occurred in this patch.
I don't really care if it is there or not personally but we shouldn't be
making changes without clear benefit.  I'll put it back.
>  };
>  MODULE_DEVICE_TABLE(of, adc128_of_match);
>  
>  static const struct spi_device_id adc128_id[] = {
> -	{ "adc128s052", 0},	/* index into adc128_config */
> -	{ "adc122s021",	1},
> -	{ "adc124s021", 2},
> +	{ "adc128s052", 0 },	/* index into adc128_config */
> +	{ "adc122s021",	1 },
> +	{ "adc122s051",	1 },
> +	{ "adc122s101",	1 },
> +	{ "adc124s021", 2 },
> +	{ "adc124s051", 2 },
> +	{ "adc124s101", 2 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, adc128_id);
