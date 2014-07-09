Return-Path: <lee.jones@linaro.org>
Date: Wed, 9 Jul 2014 14:06:30 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Denis Carikli <denis@eukrea.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>,
	Sascha Hauer <kernel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Markus Pargmann <mpa@pengutronix.de>, devicetree@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v4 1/6] mfd: fsl imx25 Touchscreen ADC driver
Message-ID: <20140709130630.GA479@lee--X1>
References: <1403621195-9622-1-git-send-email-denis@eukrea.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1403621195-9622-1-git-send-email-denis@eukrea.com>
List-ID: <linux-iio@vger.kernel.org>

On Tue, 24 Jun 2014, Denis Carikli wrote:

> From: Markus Pargmann <mpa@pengutronix.de>
> 
> This is the core driver for imx25 touchscreen/adc driver. The module
> has one shared ADC and two different conversion queues which use the
> ADC. The two queues are identical. Both can be used for general purpose
> ADC but one is meant to be used for touchscreens.
> 
> This driver is the core which manages the central components and
> registers of the TSC/ADC unit. It manages the IRQs and forwards them to
> the correct components.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
> Changelog v3->v4:
> - Added Jonathan's Ack
> - ARCH_MXC Kconfigdependency removed.
> - mx25_tsadc_get_regmap and mx25_tsadc_get_ipg contents have been moved
>   in the caller function.
> - mx25_tsadc_irq_chip has been removed.
> - Register definitions are now more humain readable.
> - Many other code and style cleanups.
> 
> Changelog v2->v3:
> - None
> ---
>  .../devicetree/bindings/mfd/fsl-imx25-tsadc.txt    |   46 ++++++
>  drivers/mfd/Kconfig                                |    8 +
>  drivers/mfd/Makefile                               |    2 +
>  drivers/mfd/fsl-imx25-tsadc.c                      |  170 ++++++++++++++++++++
>  include/linux/mfd/imx25-tsadc.h                    |  140 ++++++++++++++++
>  5 files changed, 366 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt
>  create mode 100644 drivers/mfd/fsl-imx25-tsadc.c
>  create mode 100644 include/linux/mfd/imx25-tsadc.h
> 
> diff --git a/Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt b/Documentation/devicetree/bindings/mfd/fsl-imx25-tsadc.txt

You need to split the DT documentation out into a separate patch.

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index af0e83f..d354547 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig

[...]

> +static int mx25_tsadc_domain_map(struct irq_domain *d, unsigned int irq,
> +			     irq_hw_number_t hwirq)
> +{
> +	struct mx25_tsadc *tsadc = d->host_data;
> +
> +	irq_set_chip_data(irq, tsadc);
> +	irq_set_chip_and_handler(irq, &dummy_irq_chip,
> +				 handle_level_irq);
> +	set_irq_flags(irq, IRQF_VALID);

This is only valid on ARM based systems and the Kconfig options do not
limit this driver enough for that to hold true.  In other words, this
code should easily run on X86, PPC, etc etc.

> +	return 0;
> +}

[...]

> +#ifdef CONFIG_OF
> +static const struct of_device_id mx25_tsadc_ids[] = {
> +	{ .compatible = "fsl,imx25-tsadc" },
> +	{ /* Sentinel */ }
> +};
> +#endif

Can this actually work without device tree?

> +static struct platform_driver mx25_tsadc_driver = {
> +	.driver = {
> +		.name = "mx25-tsadc",
> +		.owner = THIS_MODULE,

Remove this line, it's done for you.

> +		.of_match_table = of_match_ptr(mx25_tsadc_ids),
> +	},
> +	.probe = mx25_tsadc_probe,
> +};
> +module_platform_driver(mx25_tsadc_driver);

[...]

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
