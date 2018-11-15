Return-Path: <SRS0=oamY=N2=pschenker.ch=dev@kernel.org>
Message-ID: <661efd2b18199d0f47a67290315237b5a5dc1168.camel@pschenker.ch>
Subject: Re: [PATCH 1/3] iio: adc: add STMPE ADC driver using IIO framework
From: Philippe Schenker <dev@pschenker.ch>
Reply-To: dev@pschenker.ch
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter
 Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Stefan Agner
 <stefan@agner.ch>, Max Krummenacher <max.krummenacher@toradex.com>
Date: Thu, 15 Nov 2018 10:38:00 +0100
In-Reply-To: <20181111160043.2fd0d229@archlinux>
References: <20181106164116.6299-1-dev@pschenker.ch>
	 <20181111160043.2fd0d229@archlinux>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Sun, 2018-11-11 at 16:00 +0000, Jonathan Cameron wrote:
> On Tue,  6 Nov 2018 17:41:14 +0100
> Philippe Schenker <dev@pschenker.ch> wrote:
> 
> > From: Stefan Agner <stefan@agner.ch>
> > 
> > This adds an ADC driver for the STMPE device using the industrial
> > input/output interface. The driver supports raw reading of values.
> > The driver depends on the MFD STMPE driver. If the touchscreen
> > block is enabled too, only four of the 8 ADC channels are available.
> > 
> > Signed-off-by: Stefan Agner <stefan@agner.ch>
> > Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> > Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> We are a bit limited in here I think by how it interacts with the mfd
> and most of my comments are about the related DT bindings.
> 
> A few comments inline.
> 
> thanks,
> 
> Jonathan

Thank you for these comments. I am preparing a v2 right now with your
suggestions. Please see my comments inline. As soon I have v2 ready I will send
it.

Philippe

> 
> > ---
> >  drivers/iio/adc/Kconfig              |   7 +
> >  drivers/iio/adc/Makefile             |   1 +
> >  drivers/iio/adc/stmpe-adc.c          | 383 +++++++++++++++++++++++++++
> >  drivers/input/touchscreen/stmpe-ts.c |  11 -
> >  drivers/mfd/Kconfig                  |   3 +-
> >  drivers/mfd/stmpe.c                  |  27 ++
> >  include/linux/mfd/stmpe.h            |  11 +
> >  7 files changed, 431 insertions(+), 12 deletions(-)
> >  create mode 100644 drivers/iio/adc/stmpe-adc.c
> > 
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index a52fea8749a9..d2845472b6c2 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -734,6 +734,13 @@ config STM32_DFSDM_ADC
> >  	  This driver can also be built as a module.  If so, the module
> >  	  will be called stm32-dfsdm-adc.
> >  
> > +config STMPE_ADC
> > +	tristate "STMicroelectronics STMPE ADC driver"
> > +	depends on (OF || COMPILE_TEST || MFD_STMPE)
> > +	help
> > +	  Say yes here to build support for ST Microelectronics STMPE
> > +	  built in ADC block (stmpe811).
> > +
> >  config STX104
> >  	tristate "Apex Embedded Systems STX104 driver"
> >  	depends on PC104 && X86
> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > index a6e6a0b659e2..cba889c30bf9 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -69,6 +69,7 @@ obj-$(CONFIG_STM32_ADC_CORE) += stm32-adc-core.o
> >  obj-$(CONFIG_STM32_ADC) += stm32-adc.o
> >  obj-$(CONFIG_STM32_DFSDM_CORE) += stm32-dfsdm-core.o
> >  obj-$(CONFIG_STM32_DFSDM_ADC) += stm32-dfsdm-adc.o
> > +obj-$(CONFIG_STMPE_ADC) += stmpe-adc.o
> >  obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
> >  obj-$(CONFIG_TI_ADC0832) += ti-adc0832.o
> >  obj-$(CONFIG_TI_ADC084S021) += ti-adc084s021.o
> > diff --git a/drivers/iio/adc/stmpe-adc.c b/drivers/iio/adc/stmpe-adc.c
> > new file mode 100644
> > index 000000000000..891ad838ab3c
> > --- /dev/null
> > +++ b/drivers/iio/adc/stmpe-adc.c
> > @@ -0,0 +1,383 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + *  STMicroelectronics STMPE811 IIO ADC Driver
> > + *
> > + *  4 channel, 10/12-bit ADC
> > + *
> > + *  Copyright (C) 2013-2018 Toradex AG <stefan.agner@toradex.com>
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/completion.h>
> > +#include <linux/delay.h>
> > +#include <linux/err.h>
> > +#include <linux/iio/events.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mfd/stmpe.h>
> > +#include <linux/module.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regulator/consumer.h>
> Not seeing any regulators in here.  Please do a quick
> sanity check on the other headers as well. This is a
> long list for a fairly short bit of code!
> 
> > +#include <linux/slab.h>
> > +
> > +#define STMPE_REG_INT_STA	0x0B
> > +#define STMPE_REG_ADC_INT_EN	0x0E
> > +#define STMPE_REG_ADC_INT_STA	0x0F
> > +
> > +#define STMPE_REG_ADC_CTRL1	0x20
> > +#define STMPE_REG_ADC_CTRL2	0x21
> > +#define STMPE_REG_ADC_CAPT	0x22
> > +#define STMPE_REG_ADC_DATA_CH(channel)	(0x30 + 2 * (channel))
> > +
> > +#define STMPE_REG_TEMP_CTRL	0x60
> > +#define STMPE_START_ONE_TEMP_CONV (0x08 + 0x02 + 0x01)
> 
> This is oddly put.. Is it a mask or 3 things we can otherwise
> define?
> 
> > +#define STMPE_REG_TEMP_DATA	0x61
> > +#define STMPE_REG_TEMP_TH	0x63
> > +#define STMPE_MAX_ADC_CH	8
> > +
> > +#define STMPE_ADC_CH(channel)	((1 << (channel)) & 0xff)
> > +
> > +#define STMPE_ADC_TIMEOUT	(msecs_to_jiffies(1000))
> Outer brackets don't add anything that I can see.
> 
> > +
> > +struct stmpe_adc {
> personally I always think aligning structure elements is a bad idea as
> breaks far too often with later additions.  Still I don't care
> that much if you really want to do this...
> 
> > +	struct stmpe		*stmpe;
> > +	struct clk		*clk;
> > +	struct device		*dev;
> > +
> > +	struct iio_chan_spec	stmpe_adc_iio_channels[STMPE_MAX_ADC_CH];
> > +
> > +	struct completion	completion;
> > +
> > +	u8			channel;
> > +	u32			value;
> > +	u8			sample_time;
> > +	u8			mod_12b;
> > +	u8			ref_sel;
> > +	u8			adc_freq;
> > +	u32			norequest_mask;
> > +};
> > +
> > +static int stmpe_read_raw(struct iio_dev *indio_dev,
> > +				struct iio_chan_spec const *chan,
> > +				int *val,
> > +				int *val2,
> > +				long mask)
> > +{
> > +	struct stmpe_adc *info = iio_priv(indio_dev);
> > +	long ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +	case IIO_CHAN_INFO_PROCESSED:
> > +
> > +		mutex_lock(&indio_dev->mlock);
> > +
> > +		info->channel = (u8)chan->channel;
> > +
> > +		switch (chan->type) {
> > +		case IIO_VOLTAGE:
> > +			if (info->channel > 7)
> lock held.
> 
> > +				return -ENOENT;
> > +
> > +			stmpe_reg_write(info->stmpe, STMPE_REG_ADC_INT_EN,
> > +					STMPE_ADC_CH(info->channel));
> > +
> > +			stmpe_reg_write(info->stmpe, STMPE_REG_ADC_CAPT,
> > +					STMPE_ADC_CH(info->channel));
> > +
> > +			*val = info->value;
> > +			break;
> > +
> > +		case IIO_TEMP:
> > +			if (info->channel != 8)
> lock held...
> > +				return -ENOENT;
> > +
> > +			stmpe_reg_write(info->stmpe, STMPE_REG_TEMP_CTRL,
> > +					STMPE_START_ONE_TEMP_CONV);
> > +			break;
> > +		default:
> > +			mutex_unlock(&indio_dev->mlock);
> > +			return -EINVAL;
> > +		}
> > +
> > +		ret = wait_for_completion_interruptible_timeout
> > +			(&info->completion, STMPE_ADC_TIMEOUT);
> > +
> > +		if (ret <= 0) {
> > +			mutex_unlock(&indio_dev->mlock);
> > +			if (ret == 0)
> > +				return -ETIMEDOUT;
> > +			else
> > +				return ret;
> > +		}
> > +
> > +
> > +		switch (chan->type) {
> > +		case IIO_VOLTAGE:
> > +			*val = info->value;
> > +			break;
> > +
> > +		case IIO_TEMP:
> > +			/*
> > +			 * absolute temp = +V3.3 * value /7.51 [K]
> > +			 * scale to [milli °C]
> > +			 */
> > +			*val = ((449960l * info->value) / 1024l) - 273150;
> > +			break;
> > +		default:
> > +			break;
> > +		}
> > +
> > +		mutex_unlock(&indio_dev->mlock);
> > +		return IIO_VAL_INT;
> > +
> > +	case IIO_CHAN_INFO_SCALE:
> > +		*val = 3300;
> > +		*val2 = info->mod_12b ? 12 : 10;
> > +		return IIO_VAL_FRACTIONAL_LOG2;
> > +
> > +	default:
> > +		break;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static irqreturn_t stmpe_adc_isr(int irq, void *dev_id)
> > +{
> > +	struct stmpe_adc *info = (struct stmpe_adc *)dev_id;
> > +	u8 data[2];
> > +
> > +	if (info->channel > 8)
> > +		return IRQ_NONE;
> > +
> > +	if (info->channel < 8) {
> > +		int int_sta;
> > +
> > +		int_sta = stmpe_reg_read(info->stmpe, STMPE_REG_ADC_INT_STA);
> > +
> > +		/* Is the interrupt relevant */
> > +		if (!(int_sta & STMPE_ADC_CH(info->channel)))
> > +			return IRQ_NONE;
> > +
> > +		/* Read value */
> > +		stmpe_block_read(info->stmpe,
> > +			STMPE_REG_ADC_DATA_CH(info->channel), 2, data);
> > +
> > +		stmpe_reg_write(info->stmpe, STMPE_REG_ADC_INT_STA, int_sta);
> > +	} else if (info->channel == 8) {
> 
> That 8 is pretty magic, perhaps a define given it keeps being used?
> 
> > +		/* Read value */
> > +		stmpe_block_read(info->stmpe, STMPE_REG_TEMP_DATA, 2, data);
> > +	}
> > +
> > +	info->value = ((u32)data[0] << 8) + data[1];
> > +	complete(&info->completion);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static const struct iio_info stmpe_adc_iio_info = {
> > +	.read_raw = &stmpe_read_raw,
> > +};
> > +
> > +static void stmpe_adc_voltage_chan(struct iio_chan_spec *ics, int chan)
> > +{
> > +	ics->type = IIO_VOLTAGE;
> > +	ics->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> > +	ics->info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE);
> > +	ics->indexed = 1;
> > +	ics->channel = chan;
> > +}
> > +
> > +static void stmpe_adc_temp_chan(struct iio_chan_spec *ics, int chan)
> > +{
> > +	ics->type = IIO_TEMP;
> > +	ics->info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED);
> > +	ics->indexed = 1;
> > +	ics->channel = chan;
> > +}
> > +
> > +static int stmpe_adc_init_hw(struct stmpe_adc *adc)
> > +{
> > +	int ret;
> > +	u8 adc_ctrl1, adc_ctrl1_mask;
> > +	struct stmpe *stmpe = adc->stmpe;
> > +	struct device *dev = adc->dev;
> > +
> > +	ret = stmpe_enable(stmpe, STMPE_BLOCK_ADC);
> > +	if (ret) {
> > +		dev_err(dev, "Could not enable clock for ADC\n");
> > +		goto err_adc;
> > +	}
> > +
> > +	adc_ctrl1 = SAMPLE_TIME(adc->sample_time) | MOD_12B(adc->mod_12b) |
> > +			REF_SEL(adc->ref_sel);
> > +	adc_ctrl1_mask = SAMPLE_TIME(0xff) | MOD_12B(0xff) | REF_SEL(0xff);
> > +
> > +	ret = stmpe_set_bits(stmpe, STMPE_REG_ADC_CTRL1,
> > +			adc_ctrl1_mask, adc_ctrl1);
> > +	if (ret) {
> > +		dev_err(dev, "Could not setup ADC\n");
> > +		goto err_adc;
> > +	}
> > +
> > +	ret = stmpe_set_bits(stmpe, STMPE_REG_ADC_CTRL2,
> > +			ADC_FREQ(0xff), ADC_FREQ(adc->adc_freq));
> > +	if (ret) {
> > +		dev_err(dev, "Could not setup ADC\n");
> > +		goto err_adc;
> > +	}
> > +
> > +	/* use temp irq for each conversion completion */
> > +	stmpe_reg_write(stmpe, STMPE_REG_TEMP_TH, 0);
> > +	stmpe_reg_write(stmpe, STMPE_REG_TEMP_TH + 1, 0);
> > +
> > +	return 0;
> > +err_adc:
> > +	stmpe_disable(stmpe, STMPE_BLOCK_ADC);
> > +
> > +	return ret;
> > +}
> > +
> > +static void stmpe_adc_get_platform_info(struct platform_device *pdev,
> > +					struct stmpe_adc *adc)
> > +{
> > +	struct stmpe *stmpe = dev_get_drvdata(pdev->dev.parent);
> > +	struct device_node *np = pdev->dev.of_node;
> > +	u32 val;
> > +
> > +	adc->stmpe = stmpe;
> > +
> > +	if (!np) {
> > +		dev_err(&pdev->dev, "no device tree node found\n");
> > +		return;
> > +	}
> > +
> > +	if (!of_property_read_u32(np, "st,sample-time", &val))
> > +		adc->sample_time = val;
> > +	if (!of_property_read_u32(np, "st,mod-12b", &val))
> > +		adc->mod_12b = val;
> > +	if (!of_property_read_u32(np, "st,ref-sel", &val))
> > +		adc->ref_sel = val;
> > +	if (!of_property_read_u32(np, "st,adc-freq", &val))
> > +		adc->adc_freq = val;
> > +	if (!of_property_read_u32(np, "st,norequest-mask", &val))
> > +		adc->norequest_mask = val;
> I commented on these in the dt-binding patch, so I won't mention
> them any more here.
> 
> > +}
> > +
> > +static int stmpe_adc_probe(struct platform_device *pdev)
> > +{
> > +	struct iio_dev *indio_dev = NULL;
> > +	struct stmpe_adc *info = NULL;
> > +	int irq_temp, irq_adc;
> > +	int num_chan = 0;
> > +	int i = 0;
> > +	int ret;
> > +
> > +	irq_adc = platform_get_irq_byname(pdev, "STMPE_ADC");
> > +	if (irq_adc < 0)
> > +		return irq_adc;
> > +
> > +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(struct stmpe_adc));
> > +	if (!indio_dev) {
> > +		dev_err(&pdev->dev, "failed allocating iio device\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	info = iio_priv(indio_dev);
> > +
> > +	init_completion(&info->completion);
> > +	ret = devm_request_threaded_irq(&pdev->dev, irq_adc, NULL,
> > +					stmpe_adc_isr, IRQF_ONESHOT,
> > +					"stmpe-adc", info);
> > +	if (ret < 0) {
> > +		dev_err(&pdev->dev, "failed requesting irq, irq = %d\n",
> > +				irq_adc);
> > +		return ret;
> > +	}
> > +
> > +	irq_temp = platform_get_irq_byname(pdev, "STMPE_TEMP_SENS");
> > +	if (irq_temp >= 0) {
> > +		ret = devm_request_threaded_irq(&pdev->dev, irq_temp, NULL,
> > +						stmpe_adc_isr, IRQF_ONESHOT,
> > +						"stmpe-adc", info);
> > +		if (ret < 0)
> > +			dev_warn(&pdev->dev, "failed requesting irq for"
> > +					" temp sensor, irq = %d\n", irq_temp);
> > +	}
> I'd like a comment here that perhaps says what the result of not having an
> irq for the temperature sensor is?

Basically the STMPE device has only one hardware interrupt. This is initialized
in drivers/mfd/stmpe.c (1171). So if there is no error in mfd, we can expect it
to work in here.

> 
> > +
> > +	platform_set_drvdata(pdev, indio_dev);
> > +
> > +	indio_dev->name = dev_name(&pdev->dev);
> > +	indio_dev->dev.parent = &pdev->dev;
> > +	indio_dev->info = &stmpe_adc_iio_info;
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +
> > +	stmpe_adc_get_platform_info(pdev, info);
> > +
> > +	for_each_clear_bit(i, (unsigned long *) &info->norequest_mask,
> > +				STMPE_MAX_ADC_CH) {
> > +		stmpe_adc_voltage_chan(&info->stmpe_adc_iio_channels[num_chan],
> > i);
> > +		num_chan++;
> > +	}
> > +	stmpe_adc_temp_chan(&info->stmpe_adc_iio_channels[num_chan], i);
> > +	num_chan++;
> > +	indio_dev->channels = info->stmpe_adc_iio_channels;
> > +	indio_dev->num_channels = num_chan;
> > +
> > +	ret = stmpe_adc_init_hw(info);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = iio_device_register(indio_dev);
> > +	if (ret)
> > +		return ret;
> one blank line is plenty.
> > +
> > +
> > +	dev_info(&pdev->dev, "Initialized\n");
> This is just noise in the log. There are lots of ways of finding
> out if this came up if you actually want to so no need for the print here.
> 
> > +
> > +	return 0;
> > +}
> > +
> > +static int stmpe_adc_remove(struct platform_device *pdev)
> > +{
> > +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> > +	struct stmpe_adc *info = iio_priv(indio_dev);
> > +
> > +	iio_device_unregister(indio_dev);
> > +	stmpe_disable(info->stmpe, STMPE_BLOCK_ADC);
> > +
> > +	return 0;
> > +}
> > +
> > +static int __maybe_unused stmpe_adc_resume(struct device *dev)
> > +{
> > +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > +	struct stmpe_adc *info = iio_priv(indio_dev);
> > +
> > +	stmpe_adc_init_hw(info);
> > +
> > +	return 0;
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(stmpe_adc_pm_ops, NULL, stmpe_adc_resume);
> > +
> > +static struct platform_driver stmpe_adc_driver = {
> > +	.probe		= stmpe_adc_probe,
> > +	.remove		= stmpe_adc_remove,
> > +	.driver		= {
> > +		.name	= "stmpe-adc",
> > +		.pm	= &stmpe_adc_pm_ops,
> > +	},
> > +};
> > +
> > +module_platform_driver(stmpe_adc_driver);
> > +
> > +MODULE_AUTHOR("Stefan Agner <stefan.agner@toradex.com>");
> > +MODULE_DESCRIPTION("STMPEXXX ADC driver");
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_ALIAS("platform:stmpe-adc");
> > diff --git a/drivers/input/touchscreen/stmpe-ts.c
> > b/drivers/input/touchscreen/stmpe-ts.c
> > index 2a78e27b4495..05674e0e233f 100644
> > --- a/drivers/input/touchscreen/stmpe-ts.c
> > +++ b/drivers/input/touchscreen/stmpe-ts.c
> > @@ -49,17 +49,6 @@
> >  
> >  #define STMPE_IRQ_TOUCH_DET		0
> >  
> > -#define SAMPLE_TIME(x)			((x & 0xf) << 4)
> > -#define MOD_12B(x)			((x & 0x1) << 3)
> > -#define REF_SEL(x)			((x & 0x1) << 1)
> > -#define ADC_FREQ(x)			(x & 0x3)
> > -#define AVE_CTRL(x)			((x & 0x3) << 6)
> > -#define DET_DELAY(x)			((x & 0x7) << 3)
> > -#define SETTLING(x)			(x & 0x7)
> > -#define FRACTION_Z(x)			(x & 0x7)
> > -#define I_DRIVE(x)			(x & 0x1)
> > -#define OP_MODE(x)			((x & 0x7) << 1)
> > -
> 
> Given the need for prefixes in the header (see below) I would
> do this move as a precursor patch including renames in the
> touchscreen driver...
> 
> >  #define STMPE_TS_NAME			"stmpe-ts"
> >  #define XY_MASK				0xfff
> >  
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 8c5dfdce4326..bba159e8eaa4 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -1204,7 +1204,7 @@ config MFD_STMPE
> >  
> >  	  Currently supported devices are:
> >  
> > -		STMPE811: GPIO, Touchscreen
> > +		STMPE811: GPIO, Touchscreen, ADC
> >  		STMPE1601: GPIO, Keypad
> >  		STMPE1801: GPIO, Keypad
> >  		STMPE2401: GPIO, Keypad
> > @@ -1217,6 +1217,7 @@ config MFD_STMPE
> >  		GPIO: stmpe-gpio
> >  		Keypad: stmpe-keypad
> >  		Touchscreen: stmpe-ts
> > +		ADC: stmpe-adc
> >  
> >  menu "STMicroelectronics STMPE Interface Drivers"
> >  depends on MFD_STMPE
> > diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
> > index 566caca4efd8..00b98f75f7dd 100644
> > --- a/drivers/mfd/stmpe.c
> > +++ b/drivers/mfd/stmpe.c
> > @@ -463,6 +463,28 @@ static const struct mfd_cell stmpe_ts_cell = {
> >  	.num_resources	= ARRAY_SIZE(stmpe_ts_resources),
> >  };
> >  
> > +/*
> > + * ADC (STMPE811)
> > + */
> > +
> > +static struct resource stmpe_adc_resources[] = {
> > +	{
> > +		.name	= "STMPE_TEMP_SENS",
> > +		.flags	= IORESOURCE_IRQ,
> > +	},
> > +	{
> > +		.name	= "STMPE_ADC",
> > +		.flags	= IORESOURCE_IRQ,
> > +	},
> > +};
> > +
> > +static const struct mfd_cell stmpe_adc_cell = {
> > +	.name		= "stmpe-adc",
> > +	.of_compatible	= "st,stmpe-adc",
> > +	.resources	= stmpe_adc_resources,
> > +	.num_resources	= ARRAY_SIZE(stmpe_adc_resources),
> > +};
> > +
> >  /*
> >   * STMPE811 or STMPE610
> >   */
> > @@ -497,6 +519,11 @@ static struct stmpe_variant_block stmpe811_blocks[] = {
> >  		.irq	= STMPE811_IRQ_TOUCH_DET,
> >  		.block	= STMPE_BLOCK_TOUCHSCREEN,
> >  	},
> > +	{
> > +		.cell	= &stmpe_adc_cell,
> > +		.irq	= STMPE811_IRQ_TEMP_SENS,
> > +		.block	= STMPE_BLOCK_ADC,
> > +	},
> >  };
> >  
> >  static int stmpe811_enable(struct stmpe *stmpe, unsigned int blocks,
> > diff --git a/include/linux/mfd/stmpe.h b/include/linux/mfd/stmpe.h
> > index 4a827af17e59..90700013f56d 100644
> > --- a/include/linux/mfd/stmpe.h
> > +++ b/include/linux/mfd/stmpe.h
> > @@ -10,6 +10,17 @@
> >  
> >  #include <linux/mutex.h>
> >  
> > +#define SAMPLE_TIME(x)		((x & 0xf) << 4)
> > +#define MOD_12B(x)		((x & 0x1) << 3)
> > +#define REF_SEL(x)		((x & 0x1) << 1)
> > +#define ADC_FREQ(x)		(x & 0x3)
> > +#define AVE_CTRL(x)		((x & 0x3) << 6)
> > +#define DET_DELAY(x)		((x & 0x7) << 3)
> > +#define SETTLING(x)		(x & 0x7)
> > +#define FRACTION_Z(x)		(x & 0x7)
> > +#define I_DRIVE(x)		(x & 0x1)
> > +#define OP_MODE(x)		((x & 0x7) << 1)
> 
> I assumed that these were in keeping with naming in this file but
> they aren't.  Should have a prefix to avoid potential name clashes
> in the future.
> 
> STMPE_SAMPlE_TIME etc would make sense.
> 
> > +
> >  struct device;
> >  struct regulator;
> >  
