Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57840 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063AbcGCLyl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Jul 2016 07:54:41 -0400
Subject: Re: [PATCH 2/3] iio: adc: add support for Allwinner SoCs ADC
To: Quentin Schulz <quentin.schulz@free-electrons.com>,
	jdelvare@suse.com, linux@roeck-us.net, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net,
	maxime.ripard@free-electrons.com, wens@csie.org,
	lee.jones@linaro.org
References: <1467101897-15946-1-git-send-email-quentin.schulz@free-electrons.com>
 <1467101897-15946-3-git-send-email-quentin.schulz@free-electrons.com>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	thomas.petazzoni@free-electrons.com,
	antoine.tenart@free-electrons.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <9cdd20cd-8e73-762a-0684-4f42afe3d652@kernel.org>
Date: Sun, 3 Jul 2016 12:54:34 +0100
MIME-Version: 1.0
In-Reply-To: <1467101897-15946-3-git-send-email-quentin.schulz@free-electrons.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/06/16 09:18, Quentin Schulz wrote:
> The Allwinner SoCs all have an ADC that can also act as a touchscreen
> controller and a thermal sensor. This patch adds the ADC driver which is
> based on the MFD for the same SoCs ADC.
> 
> This also registers the thermal adc channel in the iio map array so
> iio_hwmon could use it without modifying the Device Tree.
> 
> This driver probes on three different platform_device_id to take into
> account slight differences between Allwinner SoCs ADCs.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Hi Quentin.

I'm a bit in two minds about some of this.  That temperature sensor is
so obviously meant for hwmon purposes, I'm tempted to suggest it might
actually make sense to put it directly in hwmon rather than using the
bridge.  That obviously makes it less flexible in some ways (i.e. for
use within the thermal subsystem at some point).

Guenter, what do you think?

I'm guessing detailed docs for this part aren't avaiable publicly? :(

So the rest of my comments are kind of predicated on me having roughtly
understood how this device works from the structure of the driver.

The temperature sensor is really effectively as separate ADC?
The main interest in this is for key detection?

Anyhow, if the data flow for the temperatures sensor is not synced with
the other ADC channels, adding buffered (pushed) output from the driver in
future will be fiddly and with a 250Hz device you'll probably want it.
Basically IIO buffered supports assumes each iio device will sample data
at a particular frequency. If channels are not synchronized in that fashion
then you have to register multiple devices or only pick a subset of channels
to export.

For the key detection you have already observed that IIO needs some
additions to be able to have consumers of what we term 'events' e.g. threshold
interrupts.

Looking at the lradc-keys driver in tree, it looks like we only really have
really simple threshold interrups - configured to detect a very low voltage?
+ only one per channel.

So not too nasty a case, but you are right some work is needed in IIO as
we simply don't have a means of passing these on as yet or configuring them
from in kernel consumers.
If we take the easy route and don't demux incoming events then it shouldn't
be too hard to add (demux can follow later).  Hence any client device can try
to enable events it wants, but may get events that other client devices wanted
as well.

Config interface should be much the same as the write support for channels.
Data flow marginally harder, but pretty much a list of callbacks within
iio_push_event.

Not trivial, but not too tricky either.

The events subsystem has a few 'limitations' we need to address long term
but as this is in kernel interface only, we can do this now and fix stuff
up in future without any ABI breakage. (limitations are things like only
one event of a given type and direction per channel - main challenge on
that is finding a way of doing it without abi breakage).

Anyhow, sounds fun - wish I had the time to do it myself!

Otherwise, your remove is never going to work as indio_dev is always NULL.

Jonathan

> ---
>  drivers/iio/adc/Kconfig           |  12 ++
>  drivers/iio/adc/Makefile          |   1 +
>  drivers/iio/adc/sunxi-gpadc-iio.c | 371 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 384 insertions(+)
>  create mode 100644 drivers/iio/adc/sunxi-gpadc-iio.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 82c718c..b7b566a 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -328,6 +328,18 @@ config NAU7802
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called nau7802.
>  
> +config SUNXI_ADC
> +	tristate "ADC driver for sunxi platforms"
> +	depends on IIO
> +	depends on MFD_SUNXI_ADC
> +	help
> +	  Say yes here to build support for Allwinner SoCs (A10, A13 and A31)
> +	  SoCs ADC. This ADC provides 4 channels which can be used as an ADC or
> +	  as a touchscreen input and one channel for thermal sensor.
> +
> +          To compile this driver as a module, choose M here: the
> +          module will be called sunxi-gpadc-iio.
> +
>  config PALMAS_GPADC
>  	tristate "TI Palmas General Purpose ADC"
>  	depends on MFD_PALMAS
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 0cb7921..2996a5b 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -32,6 +32,7 @@ obj-$(CONFIG_MCP3422) += mcp3422.o
>  obj-$(CONFIG_MEN_Z188_ADC) += men_z188_adc.o
>  obj-$(CONFIG_MXS_LRADC) += mxs-lradc.o
>  obj-$(CONFIG_NAU7802) += nau7802.o
> +obj-$(CONFIG_SUNXI_ADC) += sunxi-gpadc-iio.o
>  obj-$(CONFIG_PALMAS_GPADC) += palmas_gpadc.o
>  obj-$(CONFIG_QCOM_SPMI_IADC) += qcom-spmi-iadc.o
>  obj-$(CONFIG_QCOM_SPMI_VADC) += qcom-spmi-vadc.o
> diff --git a/drivers/iio/adc/sunxi-gpadc-iio.c b/drivers/iio/adc/sunxi-gpadc-iio.c
> new file mode 100644
> index 0000000..5840f43
> --- /dev/null
> +++ b/drivers/iio/adc/sunxi-gpadc-iio.c
> @@ -0,0 +1,371 @@
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/machine.h>
> +#include <linux/iio/driver.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/sunxi-gpadc-mfd.h>
> +#include <linux/regmap.h>
> +
I'm fussy about this:  Please prefix all defines as some of these
are generic enough they may well end up defined in an included header
sometime in the future.

> +#define TP_CTRL0			0x00
> +#define TP_CTRL1			0x04
> +#define TP_CTRL2			0x08
> +#define TP_CTRL3			0x0c
> +#define TP_TPR				0x18
> +#define TP_CDAT				0x1c
> +#define TEMP_DATA			0x20
> +#define TP_DATA				0x24
> +
> +/* TP_CTRL0 bits */
> +#define ADC_FIRST_DLY(x)		((x) << 24) /* 8 bits */
> +#define ADC_FIRST_DLY_MODE		BIT(23)
> +#define ADC_CLK_SELECT			BIT(22)
> +#define ADC_CLK_DIVIDER(x)		((x) << 20) /* 2 bits */
> +#define FS_DIV(x)			((x) << 16) /* 4 bits */
> +#define T_ACQ(x)			((x) << 0)  /* 16 bits*/
> +
> +/* TP_CTRL1 bits */
> +#define STYLUS_UP_DEBOUNCE(x)		((x) << 12) /* 8 bits */
> +#define STYLUS_UP_DEBOUNCE_EN		BIT(9)
> +#define TOUCH_PAN_CALI_EN		BIT(6)
> +#define TP_DUAL_EN			BIT(5)
> +#define TP_MODE_EN			BIT(4)
> +#define TP_ADC_SELECT			BIT(3)
> +#define ADC_CHAN_SELECT(x)		((x) << 0)  /* 3 bits */
> +
> +/* TP_CTRL1 bits for sun6i SOCs */
> +#define SUN6I_TOUCH_PAN_CALI_EN		BIT(7)
> +#define SUN6I_TP_DUAL_EN		BIT(6)
> +#define SUN6I_TP_MODE_EN		BIT(5)
> +#define SUN6I_TP_ADC_SELECT		BIT(4)
> +#define SUN6I_ADC_CHAN_SELECT(x)	BIT(x)  /* 4 bits */
> +
> +/* TP_CTRL2 bits */
> +#define TP_SENSITIVE_ADJUST(x)		((x) << 28) /* 4 bits */
> +#define TP_MODE_SELECT(x)		((x) << 26) /* 2 bits */
> +#define PRE_MEA_EN			BIT(24)
> +#define PRE_MEA_THRE_CNT(x)		((x) << 0)  /* 24 bits*/
> +
> +/* TP_CTRL3 bits */
> +#define FILTER_EN			BIT(2)
> +#define FILTER_TYPE(x)			((x) << 0)  /* 2 bits */
> +
> +/* TP_INT_FIFOC irq and fifo mask / control bits */
> +#define TEMP_IRQ_EN			BIT(18)
> +#define TP_OVERRUN_IRQ_EN		BIT(17)
> +#define TP_DATA_IRQ_EN			BIT(16)
> +#define TP_DATA_XY_CHANGE		BIT(13)
> +#define TP_FIFO_TRIG_LEVEL(x)		((x) << 8)  /* 5 bits */
> +#define TP_DATA_DRQ_EN			BIT(7)
> +#define TP_FIFO_FLUSH			BIT(4)
> +#define TP_UP_IRQ_EN			BIT(1)
> +#define TP_DOWN_IRQ_EN			BIT(0)
> +
> +/* TP_INT_FIFOS irq and fifo status bits */
> +#define TEMP_DATA_PENDING		BIT(18)
> +#define FIFO_OVERRUN_PENDING		BIT(17)
> +#define FIFO_DATA_PENDING		BIT(16)
> +#define TP_IDLE_FLG			BIT(2)
> +#define TP_UP_PENDING			BIT(1)
> +#define TP_DOWN_PENDING			BIT(0)
> +
> +/* TP_TPR bits */
> +#define TEMP_ENABLE(x)			((x) << 16)
> +#define TEMP_PERIOD(x)			((x) << 0)  /*t = x * 256 * 16 / clkin*/
> +
> +#define ARCH_SUN4I			BIT(0)
> +#define ARCH_SUN5I			BIT(1)
> +#define ARCH_SUN6I			BIT(2)
> +
> +struct sunxi_gpadc_dev {
> +	void __iomem			*regs;
> +	struct completion		completion;
> +	int				temp_data;
> +	u32				adc_data;
> +	struct regmap			*regmap;
> +	unsigned int			fifo_data_irq;
> +	unsigned int			temp_data_irq;
> +	unsigned int			flags;
> +};
> +
> +#define ADC_CHANNEL(_channel, _name) {				\
> +	.type = IIO_VOLTAGE,					\
> +	.indexed = 1,						\
> +	.channel = _channel,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +	.datasheet_name = _name,				\
> +}
> +
> +static struct iio_map sunxi_gpadc_hwmon_maps[] = {
> +	{
> +		.adc_channel_label = "temp_adc",
> +		.consumer_dev_name = "iio_hwmon.0",
> +	},
> +	{},
> +};
> +
> +static const struct iio_chan_spec sunxi_gpadc_channels[] = {
> +	ADC_CHANNEL(0, "adc_chan0"),
> +	ADC_CHANNEL(1, "adc_chan1"),
> +	ADC_CHANNEL(2, "adc_chan2"),
> +	ADC_CHANNEL(3, "adc_chan3"),
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +		.datasheet_name = "temp_adc",
> +	},
> +};
> +
> +static int sunxi_gpadc_adc_read(struct iio_dev *indio_dev, int channel)
> +{
> +	struct sunxi_gpadc_dev *info = iio_priv(indio_dev);
> +	int val = 0;
> +
> +	mutex_lock(&indio_dev->mlock);
> +
> +	reinit_completion(&info->completion);
> +	regmap_write(info->regmap, TP_CTRL1, SUN6I_TP_MODE_EN |
> +					     SUN6I_TP_ADC_SELECT |
> +					     SUN6I_ADC_CHAN_SELECT(channel));
> +	regmap_write(info->regmap, TP_INT_FIFOC, TP_FIFO_TRIG_LEVEL(1) |
> +						 TP_FIFO_FLUSH);
> +	enable_irq(info->fifo_data_irq);
> +
> +	if (!wait_for_completion_timeout(&info->completion,
> +					 msecs_to_jiffies(100))) {
> +		disable_irq(info->fifo_data_irq);
> +		mutex_unlock(&indio_dev->mlock);
> +		return -ETIMEDOUT;
> +	}
> +
> +	val = info->adc_data;
> +	disable_irq(info->fifo_data_irq);
> +	mutex_unlock(&indio_dev->mlock);
> +
> +	return val;
> +}
> +
> +static int sunxi_gpadc_temp_read(struct iio_dev *indio_dev)
> +{
> +	struct sunxi_gpadc_dev *info = iio_priv(indio_dev);
> +	int val = 0;
> +
> +	mutex_lock(&indio_dev->mlock);
> +
> +	reinit_completion(&info->completion);
> +
> +	regmap_write(info->regmap, TP_INT_FIFOC, TP_FIFO_TRIG_LEVEL(1) |
> +						 TP_FIFO_FLUSH);
> +	regmap_write(info->regmap, TP_CTRL1, SUN6I_TP_MODE_EN);
> +	enable_irq(info->temp_data_irq);
> +
> +	if (!wait_for_completion_timeout(&info->completion,
> +					 msecs_to_jiffies(100))) {
> +		disable_irq(info->temp_data_irq);
> +		mutex_unlock(&indio_dev->mlock);
> +		return -ETIMEDOUT;
> +	}
> +
> +	if (info->flags & ARCH_SUN4I)
> +		val = info->temp_data * 133 - 257000;
> +	else if (info->flags & ARCH_SUN5I)
> +		val = info->temp_data * 100 - 144700;
> +	else if (info->flags & ARCH_SUN6I)
> +		val = info->temp_data * 167 - 271000;
> +
> +	disable_irq(info->temp_data_irq);
> +	mutex_unlock(&indio_dev->mlock);
> +	return val;
> +}
> +
> +static int sunxi_gpadc_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val, int *val2, long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +		*val = sunxi_gpadc_temp_read(indio_dev);
> +		if (*val < 0)
> +			return *val;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_RAW:
> +		*val = sunxi_gpadc_adc_read(indio_dev, chan->channel);
> +		if (*val < 0)
> +			return *val;
> +
> +		return IIO_VAL_INT;
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const struct iio_info sunxi_gpadc_iio_info = {
> +	.read_raw = sunxi_gpadc_read_raw,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static irqreturn_t sunxi_gpadc_temp_data_irq_handler(int irq, void *dev_id)
> +{
> +	struct sunxi_gpadc_dev *info = dev_id;
> +	int ret;
> +
> +	ret = regmap_read(info->regmap, TEMP_DATA, &info->temp_data);
> +	if (ret == 0)
> +		complete(&info->completion);
> +
> +	return IRQ_HANDLED;
> +}
Interesting that it's a separate data flow for the temperature sensor.
That means that if you add buffered (pushed data) support in future either
you'll need to split the device in two or not allow the temperature channel
to go through the buffer interface.
> +
> +static irqreturn_t sunxi_gpadc_fifo_data_irq_handler(int irq, void *dev_id)
> +{
> +	struct sunxi_gpadc_dev *info = dev_id;
> +	int ret;
> +
> +	ret = regmap_read(info->regmap, TP_DATA, &info->adc_data);
> +	if (ret == 0)
> +		complete(&info->completion);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int sunxi_gpadc_probe(struct platform_device *pdev)
> +{
> +	struct sunxi_gpadc_dev *info = NULL;
> +	struct iio_dev *indio_dev = NULL;
> +	int ret = 0;
> +	unsigned int irq;
> +	struct sunxi_gpadc_mfd_dev *sunxi_gpadc_mfd_dev;
> +
> +	sunxi_gpadc_mfd_dev = dev_get_drvdata(pdev->dev.parent);
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*info));
> +	if (!indio_dev) {
> +		dev_err(&pdev->dev, "failed to allocate iio device.\n");
> +		return -ENOMEM;
> +	}
> +	info = iio_priv(indio_dev);
> +
> +	info->regmap = sunxi_gpadc_mfd_dev->regmap;
> +	init_completion(&info->completion);
> +	indio_dev->name = dev_name(&pdev->dev);
> +	indio_dev->dev.parent = &pdev->dev;
> +	indio_dev->dev.of_node = pdev->dev.of_node;
> +	indio_dev->info = &sunxi_gpadc_iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->num_channels = ARRAY_SIZE(sunxi_gpadc_channels);
> +	indio_dev->channels = sunxi_gpadc_channels;
> +
> +	info->flags = platform_get_device_id(pdev)->driver_data;
> +
> +	regmap_write(info->regmap, TP_CTRL0, ADC_CLK_DIVIDER(2) |
> +					     FS_DIV(7) |
> +					     T_ACQ(63));
> +	regmap_write(info->regmap, TP_CTRL1, SUN6I_TP_MODE_EN);
> +	regmap_write(info->regmap, TP_CTRL3, FILTER_EN | FILTER_TYPE(1));
> +	regmap_write(info->regmap, TP_TPR, TEMP_ENABLE(1) | TEMP_PERIOD(1953));
> +
> +	irq = platform_get_irq_byname(pdev, "TEMP_DATA_PENDING");
> +	if (irq < 0) {
> +		dev_err(&pdev->dev,
> +			"no TEMP_DATA_PENDING interrupt registered\n");
> +		return irq;
> +	}
> +
> +	irq = regmap_irq_get_virq(sunxi_gpadc_mfd_dev->regmap_irqc, irq);
> +	ret = devm_request_any_context_irq(&pdev->dev, irq,
> +					   sunxi_gpadc_temp_data_irq_handler,
> +					   0, "temp_data", info);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev,
> +			"could not request TEMP_DATA_PENDING interrupt: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	info->temp_data_irq = irq;
> +	disable_irq(irq);
> +
> +	irq = platform_get_irq_byname(pdev, "FIFO_DATA_PENDING");
hohum.  A fifo?  This part is getting more interesting ;) I'll have to
dig out the datasheet at some point (if public).
> +	if (irq < 0) {
> +		dev_err(&pdev->dev,
> +			"no FIFO_DATA_PENDING interrupt registered\n");
> +		return irq;
> +	}
> +
> +	irq = regmap_irq_get_virq(sunxi_gpadc_mfd_dev->regmap_irqc, irq);
> +	ret = devm_request_any_context_irq(&pdev->dev, irq,
> +					   sunxi_gpadc_fifo_data_irq_handler,
> +					   0, "fifo_data", info);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev,
> +			"could not request FIFO_DATA_PENDING interrupt: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	info->fifo_data_irq = irq;
> +	disable_irq(irq);
> +
> +	ret = iio_map_array_register(indio_dev, sunxi_gpadc_hwmon_maps);
As mentioned for previous patch I think this should be described externally.
Chances are that some of those other adc channels are also going to be
in reality used for hwmon anyway so doing it in the device tree will give
you more flexibility.

> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to register iio map array\n");
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "could not register the device\n");
> +		iio_map_array_unregister(indio_dev);
> +		return ret;
> +	}
> +
This is kind of self evident when the device turns up so I'd not bother
cluttering up the logs with it as no additional information is given.
> +	dev_info(&pdev->dev, "successfully loaded\n");
> +
> +	return ret;
> +}
> +
> +static int sunxi_gpadc_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev = NULL;
?  If it's null the below isn't going to work as intended.
Missing a platform_get_drvdata which I'd just roll into the above
local variable definition.

> +	struct sunxi_gpadc_dev *info = NULL;
> +
> +	iio_device_unregister(indio_dev);
> +	iio_map_array_unregister(indio_dev);
> +	info = iio_priv(indio_dev);
I'd roll this into the local variable declaration above
(it's only a trivial bit of pointer arithemetic after all.
struct sunxi_gpadc_dev *info = iio_priv(indio_dev);

> +	regmap_write(info->regmap, TP_INT_FIFOC, 0);
> +
> +	return 0;
> +}
> +
> +static const struct platform_device_id sunxi_gpadc_id[] = {
> +	{ "sun4i-a10-gpadc-iio", ARCH_SUN4I },
> +	{ "sun5i-a13-gpadc-iio", ARCH_SUN5I },
> +	{ "sun6i-a31-gpadc-iio", ARCH_SUN6I },
> +	{ /*sentinel*/ },
> +};
> +
> +static struct platform_driver sunxi_gpadc_driver = {
> +	.driver = {
> +		.name = "sunxi-gpadc-iio",
> +	},
> +	.id_table = sunxi_gpadc_id,
> +	.probe = sunxi_gpadc_probe,
> +	.remove = sunxi_gpadc_remove,
> +};
> +
> +module_platform_driver(sunxi_gpadc_driver);
> +
> +MODULE_DESCRIPTION("ADC driver for sunxi platforms");
> +MODULE_AUTHOR("Quentin Schulz <quentin.schulz@free-electrons.com>");
> +MODULE_LICENSE("GPL v2");
> 

