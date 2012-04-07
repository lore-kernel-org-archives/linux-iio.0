Return-Path: <plagnioj@jcrosoft.com>
Date: Sat, 7 Apr 2012 05:27:42 +0200
From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Patrice Vilchez <patrice.vilchez@atmel.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 2/5] ARM: AT91: IIO: Add AT91 ADC driver.
Message-ID: <20120407032742.GD16641@game.jcrosoft.org>
References: <1333641684-20325-1-git-send-email-maxime.ripard@free-electrons.com>
 <1333641684-20325-3-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333641684-20325-3-git-send-email-maxime.ripard@free-electrons.com>
List-ID: <linux-iio@vger.kernel.org>

On 18:01 Thu 05 Apr     , Maxime Ripard wrote:
> Add the IIO driver for the AT91 ADCs. It only supports and has
> been tested on the SAM9G20 evaluation boards, but support for
> other boards will come eventually.
> 
> This ADC is a multi-channel ADC with support for both hardware
> and software triggers.
> 
> This first version only supports software triggers.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/adc/Kconfig    |    6 +
>  drivers/staging/iio/adc/Makefile   |    1 +
>  drivers/staging/iio/adc/at91_adc.c |  382 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 389 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/staging/iio/adc/at91_adc.c
> 
> diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
> index 592eabd..1494838 100644
> --- a/drivers/staging/iio/adc/Kconfig
> +++ b/drivers/staging/iio/adc/Kconfig
> @@ -169,6 +169,12 @@ config AD7280
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad7280a
>  
> +config AT91_ADC
> +	tristate "Atmel AT91 ADC"
> +	depends on SYSFS && ARCH_AT91
> +	help
> +	  Say yes here to build support for Atmel AT91 ADC.
> +
>  config MAX1363
>  	tristate "Maxim max1363 ADC driver"
>  	depends on I2C
> diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
> index f83ab95..8cb6d1c 100644
> --- a/drivers/staging/iio/adc/Makefile
> +++ b/drivers/staging/iio/adc/Makefile
> @@ -38,3 +38,4 @@ obj-$(CONFIG_ADT7310) += adt7310.o
>  obj-$(CONFIG_ADT7410) += adt7410.o
>  obj-$(CONFIG_AD7280) += ad7280a.o
>  obj-$(CONFIG_LPC32XX_ADC) += lpc32xx_adc.o
> +obj-$(CONFIG_AT91_ADC) += at91_adc.o
> diff --git a/drivers/staging/iio/adc/at91_adc.c b/drivers/staging/iio/adc/at91_adc.c
> new file mode 100644
> index 0000000..c76516a
> --- /dev/null
> +++ b/drivers/staging/iio/adc/at91_adc.c
> @@ -0,0 +1,382 @@
> +/*
> + * Driver for the ADC present in the Atmel AT91 evaluation boards.
> + *
> + * Copyright 2011 Free Electrons
> + *
> + * Licensed under the GPLv2 or later.
> + */
> +
> +#include <linux/bitmap.h>
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/interrupt.h>
> +#include <linux/jiffies.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +#include <linux/wait.h>
> +
> +#include "../iio.h"
> +#include <linux/platform_data/at91_adc.h>
> +
> +#include <mach/at91_adc.h>
> +#include <mach/cpu.h>
> +
> +/**
> + * struct at91_adc_desc - description of the ADC on the board
> + * @clock:		ADC clock as specified by the datasheet, in Hz.
> + * @clock_name		Name of the ADC clock as defined in the clock tree
> + * @num_channels:	global number of channels available on the board (to
> +			specify which channels are indeed in use on the
> +			board, see the channels_used bitmask in the platform
> +			data)
> + * @startup_time:	startup time of the ADC in microseconds
> + */
> +struct at91_adc_desc {
> +	u32			clock;
> +	char			*clock_name;
> +	u8			num_channels;
> +	u8			startup_time;
> +};
> +
> +struct at91_adc_state {
> +	unsigned long		channels_mask;
> +	struct clk		*clk;
> +	bool			done;
> +	struct at91_adc_desc	*desc;
> +	int			irq;
> +	u16			last_value;
> +	struct mutex		lock;
> +	void __iomem		*reg_base;
> +	u32			vref_mv;
> +	wait_queue_head_t	wq_data_avail;
> +};
> +
> +static struct at91_adc_desc at91_adc_desc_sam9g20 = {
> +	.clock = 5000000,
why 5Mhz?
> +	.clock_name = "adc_clk",
> +	.num_channels = 4,
> +	.startup_time = 10,
> +};
> +
this is soc specific nedd to be in the soc not in the driver
> +static int at91_adc_select_soc(struct at91_adc_state *st)
> +{
> +	if (cpu_is_at91sam9g20()) {
> +		st->desc = &at91_adc_desc_sam9g20;
> +		return 0;
> +	}
> +
> +	return -ENODEV;
> +}
ditto
> +

> +
> +static int __devinit at91_adc_probe(struct platform_device *pdev)
> +{
> +	unsigned int prsc, mstrclk, ticks;
> +	int ret;
> +	struct iio_dev *idev;
> +	struct at91_adc_state *st;
> +	struct resource *res;
> +	struct at91_adc_data *pdata = pdev->dev.platform_data;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&pdev->dev, "No resource defined\n");
> +		ret = -ENXIO;
> +		goto error_ret;
> +	}
> +
> +	idev = iio_allocate_device(sizeof(struct at91_adc_state));
> +	if (idev == NULL) {
> +		ret = -ENOMEM;
> +		goto error_ret;
> +	}
> +
> +	platform_set_drvdata(pdev, idev);
> +
> +	idev->dev.parent = &pdev->dev;
> +	idev->name = dev_name(&pdev->dev);
> +	idev->modes = INDIO_DIRECT_MODE;
> +	idev->info = &at91_adc_info;
> +
> +	st = iio_priv(idev);
> +	ret = at91_adc_select_soc(st);
> +	if (ret) {
> +		dev_err(&pdev->dev, "SoC unknown\n");
> +		goto error_free_device;
> +	}
> +
> +	st->irq = platform_get_irq(pdev, 0);
> +	if (st->irq < 0) {
> +		dev_err(&pdev->dev, "No IRQ ID is designated\n");
> +		ret = -ENODEV;
> +		goto error_free_device;
> +	}
> +
> +	if (!request_mem_region(res->start, resource_size(res),
> +				"AT91 adc registers")) {
> +		dev_err(&pdev->dev, "Resources are unavailable.\n");
> +		ret = -EBUSY;
> +		goto error_free_device;
> +	}
> +
> +	st->reg_base = ioremap(res->start, resource_size(res));
> +	if (!st->reg_base) {
> +		dev_err(&pdev->dev, "Failed to map registers.\n");
> +		ret = -ENOMEM;
> +		goto error_release_mem;
> +	}
> +
> +	/*
> +	 * Disable all IRQs before setting up the handler
> +	 */
> +	at91_adc_reg_write(st, AT91_ADC_CR, AT91_ADC_SWRST);
> +	at91_adc_reg_write(st, AT91_ADC_IDR, 0xFFFFFFFF);
> +	ret = request_irq(st->irq,
> +			  at91_adc_eoc_trigger,
> +			  0,
> +			  pdev->dev.driver->name,
> +			  idev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to allocate IRQ.\n");
> +		goto error_unmap_reg;
> +	}
> +
> +	st->clk = clk_get(&pdev->dev, st->desc->clock_name);
use a fixed clock name
> +	if (IS_ERR(st->clk)) {
> +		dev_err(&pdev->dev, "Failed to get the clock.\n");
> +		ret = PTR_ERR(st->clk);
> +		goto error_free_irq;
> +	}
> +
use clk_prepare & co
> +	clk_enable(st->clk);
> +	mstrclk = clk_get_rate(st->clk);
> +
> +	if (!pdata) {
> +		dev_err(&pdev->dev, "No platform data available.\n");
> +		ret = -EINVAL;
> +		goto error_free_clk;
> +	}
need to be check first

Best Regards,
J.
