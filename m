Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52669 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754703Ab3FBRkc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jun 2013 13:40:32 -0400
Message-ID: <51AB838B.5060602@kernel.org>
Date: Sun, 02 Jun 2013 18:40:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	Samuel Ortiz <sameo@linux.intel.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Felipe Balbi <balbi@ti.com>,
	Pantelis Antoniou <panto@antoniou-consulting.com>
Subject: Re: [PATCH 11/19] iio & mfd: ti_tscadc: Update with IIO map interface
 & deal with partial activation
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de> <1369681926-22185-12-git-send-email-bigeasy@linutronix.de>
In-Reply-To: <1369681926-22185-12-git-send-email-bigeasy@linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/27/2013 08:11 PM, Sebastian Andrzej Siewior wrote:
> From: Pantelis Antoniou <panto@antoniou-consulting.com>
>
> Add an IIO map interface that consumers can use.
>
> While we're here fix the mfd device in the case
> where a subdevice might not be activated.
Any time I read 'while we're here' it rings alarm bells.
Two issues -> Two patches please.

The level of reworking here is rather high. Probably better
to do the structural changes in one patch then follow with the
new functionality in another.

Other comments inline.
>
> Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/iio/adc/ti_am335x_adc.c      |   53 +++++++++++++++++++++++++++++-----
>  drivers/mfd/ti_am335x_tscadc.c       |   29 ++++++++++++-------
>  include/linux/mfd/ti_am335x_tscadc.h |    8 ++---
>  3 files changed, 67 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index d821d88..cceff09 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -20,16 +20,19 @@
>  #include <linux/slab.h>
>  #include <linux/interrupt.h>
>  #include <linux/platform_device.h>
> -#include <linux/io.h>
why? Not immediately obvious this has anything to do with the rest of this patch.
>  #include <linux/iio/iio.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/iio/machine.h>
> +#include <linux/iio/driver.h>
>
>  #include <linux/mfd/ti_am335x_tscadc.h>
>
>  struct tiadc_device {
>  	struct ti_tscadc_dev *mfd_tscadc;
>  	int channels;
> +	char *buf;
> +	struct iio_map *map;
>  };
>
>  static unsigned int tiadc_readl(struct tiadc_device *adc, unsigned int reg)
> @@ -76,25 +79,59 @@ static void tiadc_step_config(struct tiadc_device *adc_dev)
>  static int tiadc_channel_init(struct iio_dev *indio_dev, int channels)
>  {
>  	struct iio_chan_spec *chan_array;

> -	int i;
> -
> -	indio_dev->num_channels = channels;
> -	chan_array = kcalloc(indio_dev->num_channels,
> -			sizeof(struct iio_chan_spec), GFP_KERNEL);
> +	struct iio_chan_spec *chan;
> +	char *s;
> +	int i, len, size, ret;
>

This is less than beautiful... It'll cost you marginally more to
allocate a separate array for the strings, but will be a lot nicer
to read.  If we are dealing with a relatively small maximum number
then just do it as a static const char * array of all possible
strings.

> +	size = indio_dev->num_channels * (sizeof(struct iio_chan_spec) + 6);
> +	chan_array = kzalloc(size, GFP_KERNEL);
>  	if (chan_array == NULL)
>  		return -ENOMEM;
>
> -	for (i = 0; i < (indio_dev->num_channels); i++) {
> -		struct iio_chan_spec *chan = chan_array + i;
> +	/* buffer space is after the array */
> +	s = (char *)(chan_array + indio_dev->num_channels);
> +	chan = chan_array;
> +	for (i = 0; i < indio_dev->num_channels; i++, chan++, s += len + 1) {
> +
> +		len = sprintf(s, "AIN%d", i);
> +
>  		chan->type = IIO_VOLTAGE;
>  		chan->indexed = 1;
>  		chan->channel = i;
>  		chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> +		chan->datasheet_name = s;
> +		chan->scan_type.sign = 'u';
> +		chan->scan_type.realbits = 12;
> +		chan->scan_type.storagebits = 32;
> +		chan->scan_type.shift = 0;
>  	}
>
>  	indio_dev->channels = chan_array;
>
> +	size = (indio_dev->num_channels + 1) * sizeof(struct iio_map);
> +	adc_dev->map = kzalloc(size, GFP_KERNEL);
> +	if (adc_dev->map == NULL) {
> +		kfree(chan_array);
> +		return -ENOMEM;
> +	}
> +
> +	for (i = 0; i < indio_dev->num_channels; i++) {
> +		adc_dev->map[i].adc_channel_label =
> +			chan_array[i].datasheet_name;
> +		adc_dev->map[i].consumer_dev_name = "any";
> +		adc_dev->map[i].consumer_channel = chan_array[i].datasheet_name;
> +	}
> +	adc_dev->map[i].adc_channel_label = NULL;
> +	adc_dev->map[i].consumer_dev_name = NULL;
> +	adc_dev->map[i].consumer_channel = NULL;
> +
> +	ret = iio_map_array_register(indio_dev, adc_dev->map);
> +	if (ret != 0) {
> +		kfree(adc_dev->map);
> +		kfree(chan_array);
> +		return -ENOMEM;
> +	}
> +
>  	return indio_dev->num_channels;
>  }
>
> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> index 5b324e5..bd127bd 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -175,26 +175,35 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  	ctrl |= CNTRLREG_TSCSSENB;
>  	tscadc_writel(tscadc, REG_CTRL, ctrl);
>
> +	tscadc->used_cells = 0;
> +	tscadc->tsc_cell = -1;
> +	tscadc->adc_cell = -1;
> +
>  	/* TSC Cell */
> -	cell = &tscadc->cells[TSC_CELL];
> -	cell->name = "tsc";
> -	cell->platform_data = tscadc;
> -	cell->pdata_size = sizeof(*tscadc);
> +	if (tsc_wires > 0) {
> +		tscadc->tsc_cell = tscadc->used_cells;
> +		cell = &tscadc->cells[tscadc->used_cells++];
> +		cell->name = "tsc";
> +		cell->platform_data = tscadc;
> +		cell->pdata_size = sizeof(*tscadc);
> +	}
>
>  	/* ADC Cell */
> -	cell = &tscadc->cells[ADC_CELL];
> -	cell->name = "tiadc";
> -	cell->platform_data = tscadc;
> -	cell->pdata_size = sizeof(*tscadc);
> +	if (adc_channels > 0) {
> +		tscadc->adc_cell = tscadc->used_cells;
> +		cell = &tscadc->cells[tscadc->used_cells++];
> +		cell->name = "tiadc";
> +		cell->platform_data = tscadc;
> +		cell->pdata_size = sizeof(*tscadc);
> +	}
>
>  	err = mfd_add_devices(&pdev->dev, pdev->id, tscadc->cells,
> -			TSCADC_CELLS, NULL, 0, NULL);
> +			tscadc->used_cells, NULL, 0, NULL);
>  	if (err < 0)
>  		goto err_disable_clk;
>
>  	device_init_wakeup(&pdev->dev, true);
>  	platform_set_drvdata(pdev, tscadc);
> -
>  	return 0;
>
>  err_disable_clk:
> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
> index 9624fea..50a245f 100644
> --- a/include/linux/mfd/ti_am335x_tscadc.h
> +++ b/include/linux/mfd/ti_am335x_tscadc.h
> @@ -128,11 +128,6 @@
>
>  #define TSCADC_CELLS		2
>
> -enum tscadc_cells {
> -	TSC_CELL,
> -	ADC_CELL,
> -};
> -
>  struct mfd_tscadc_board {
>  	struct tsc_data *tsc_init;
>  	struct adc_data *adc_init;
> @@ -143,6 +138,9 @@ struct ti_tscadc_dev {
>  	struct regmap *regmap_tscadc;
>  	void __iomem *tscadc_base;
>  	int irq;
> +	int used_cells;	/* 0-2 */
> +	int tsc_cell;	/* -1 if not used */
> +	int adc_cell;	/* -1 if not used */
>  	struct mfd_cell cells[TSCADC_CELLS];
>
>  	/* tsc device */
>
