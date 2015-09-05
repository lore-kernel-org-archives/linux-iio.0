Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41351 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034AbbIEPrZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Sep 2015 11:47:25 -0400
Subject: Re: [[PATCH v2] 2/2] Altera Modular ADC driver support
To: Chee Nouk Phoo <cnphoon@altera.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1441144199-20231-1-git-send-email-cnphoon@altera.com>
 <1441144199-20231-3-git-send-email-cnphoon@altera.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
	cnphoon.linux@gmail.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55EB0E89.60402@kernel.org>
Date: Sat, 5 Sep 2015 16:47:21 +0100
MIME-Version: 1.0
In-Reply-To: <1441144199-20231-3-git-send-email-cnphoon@altera.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/09/15 22:49, Chee Nouk Phoo wrote:
> From: Chee Nouk Phoon <cnphoon@altera.com>
> 
> Altera Modular ADC is soft IP that wraps the hardened ADC block in a Max10
> device. It can be configured to dual ADC mode that supports two channel
> synchronous sampling or independent single ADCs. ADC sampled values will be
> written into memory slots in sequence determined by a user configurable
> sequencer block.
> 
> This patch adds Altera Modular ADC driver support
> 
> Signed-off-by: Chee Nouk Phoon <cnphoon@altera.com>
Sorry, I wrote a review of version 1 but for some reason seem not have
sent it.  Anyhow, will comment on this version now.

I'm feeling rather guilty about this as there are a number of elements
in this driver that are major issues and I meant to get back to you on
them over a week ago!  Oops.

Anyhow, big ones in here are unusual uses of the ABI.  One point to note
is that if you ever add any ABI not documented in Documentation/ABI/testing/*
then you MUST document it as part of your patch.  It saves a lot
of time whilst the reviewer figures out what the ABI being presented
actually is.

Dual ADCs should not have their two elements passed out through a single
sysfs attribute.  If you need to maintain their relationship it must
be done by using the buffered interface not the sysfs one.  Doing it
any other way leads to inconsistent and confusing userspace ABI which
would be a disaster.

Extended naming (tied up with the above) has very limited use cases and
must be documented.  It confuses userspace applications by encoding
information in a freeform way within the attribute name. As such the
form must be clearly documented and justified.  The use case here is
not justified.

Anyhow, whilst these sound major, the driver is actually in pretty good
shape and the other stuff is minor tidy ups / formatting suggestions.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/Kconfig           |   11 ++
>  drivers/iio/adc/Makefile          |    1 +
>  drivers/iio/adc/alt_modular_adc.c |  322 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 334 insertions(+), 0 deletions(-)
>  mode change 100644 => 100755 drivers/iio/adc/Kconfig
>  create mode 100755 drivers/iio/adc/alt_modular_adc.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> old mode 100644
> new mode 100755
> index 50c103d..e1a67cb
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -118,6 +118,17 @@ config AD799X
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called ad799x.
>  
> +config ALT_MODULAR_ADC
> +	tristate "Altera Modular ADC driver"
> +	select ANON_INODES
> +
> +	help
> +	  Say yes here to have support for Altera Modular ADC. The driver
> +	  supports both Altera Modular ADC and Altera Modular Dual ADC.
> +
> +	  The driver can also be build as a module. If so the module will be
> +	  called alt_modular_adc.
> +
>  config AT91_ADC
>  	tristate "Atmel AT91 ADC"
>  	depends on ARCH_AT91
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index a096210..d7f10e0 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -38,3 +38,4 @@ obj-$(CONFIG_VF610_ADC) += vf610_adc.o
>  obj-$(CONFIG_VIPERBOARD_ADC) += viperboard_adc.o
>  xilinx-xadc-y := xilinx-xadc-core.o xilinx-xadc-events.o
>  obj-$(CONFIG_XILINX_XADC) += xilinx-xadc.o
> +obj-$(CONFIG_ALT_MODULAR_ADC) += alt_modular_adc.o
> diff --git a/drivers/iio/adc/alt_modular_adc.c b/drivers/iio/adc/alt_modular_adc.c
> new file mode 100755
> index 0000000..3d2d870
> --- /dev/null
> +++ b/drivers/iio/adc/alt_modular_adc.c
> @@ -0,0 +1,322 @@
> +/*
> + * Copyright (C) 2015 Altera Corporation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include <linux/iio/iio.h>
> +
> +/* Constant Definitions */
Please prefix all constants iwth ALT_MODULAR_ADC_ or similar
to avoid potential name clashes in the future.

> +#define MAX_SLOT		64
> +#define MAX_ADC			2
> +#define MAX_CHANNEL		18
> +#define MODE_SINGLE_ADC		1
> +#define MODE_DUAL_ADC		2
> +#define ADC_BITS		12
> +#define ADC_STORE_BITS		16
> +#define ADC_MAX_STR_SIZE        20
> +
> +/* Register Definitions */
> +#define ADC_CMD_REG		0x0
> +#define ADC_IER_REG		0x100
> +#define ADC_ISR_REG		0x104
> +
> +#define ADC_RUN_MSK		0x1
> +#define ADC_SINGLE_MKS		0x2
> +#define ADC_STOP_MSK		0x0
> +#define ADC_LOW_MSK		0xFFF
> +#define ADC_HIGH_MSK		0xFFF0000
> +
I'd like to see kernel-doc description fo this structure.
It's not immediately obvious what all the parts are!

> +struct altera_adc {
> +	void __iomem		*seq_regs;
> +	void __iomem		*sample_regs;
> +
> +	unsigned int		mode;
> +	unsigned int		slot_count;
> +	unsigned int		slot_sequence[MAX_ADC][MAX_SLOT];
Without looking at the bindings doc, it's not obvious what adc_number.
I'd prefer enough local docs to make that clear!
> +	unsigned int		adc_number;
> +};
> +
> +static int alt_modular_adc_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val,
> +				int *val2,
> +				long mask)
> +{
> +	struct altera_adc *adc = iio_priv(indio_dev);
> +	int ret = -EINVAL;
> +	u32 value;
> +
> +	if (mask != IIO_CHAN_INFO_RAW)
> +		return -EINVAL;
> +
> +	value = readl_relaxed(adc->sample_regs + (chan->address * 4));
> +
> +	if (adc->mode == MODE_SINGLE_ADC) {
> +		*val = (value & ADC_LOW_MSK);
> +		ret = IIO_VAL_INT;
> +	} else if (adc->mode == MODE_DUAL_ADC) {
> +		*val = (value & ADC_LOW_MSK);
> +		*val2 = ((value & ADC_HIGH_MSK) >> 16);

No.  This is not part of the ABI and is absolutely not the intent.
You can't pass two separate ADC readings from different channels through
the sysfs interface like this.  It's been requested a number of times
but the write way to do this is to implement the buffered interface
and push the out that way.  One sysfs attribute, one value is the rule!
The exceptions are for element that have no meaning whatsoever on their own
(such as quaternions) where any given element has no scale without the rest.
That is not true here.

> +		ret = IIO_VAL_INT_MULTIPLE;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct iio_info adc_iio_info = {
> +	.read_raw = &alt_modular_adc_read_raw,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static int alt_modular_adc_channel_init(struct iio_dev *indio_dev)
> +{
> +	struct altera_adc *adc = iio_priv(indio_dev);
> +	struct iio_chan_spec *chan_array;
> +	struct iio_chan_spec *chan;
> +	char **channel_name;
> +	int i;
> +
> +	chan_array = devm_kzalloc(&indio_dev->dev, (adc->slot_count *
> +		sizeof(*chan_array)), GFP_KERNEL);
> +	if (chan_array == NULL)
> +		return -ENOMEM;
> +
> +	channel_name = devm_kzalloc(&indio_dev->dev, adc->slot_count,
> +		GFP_KERNEL);
> +	if (channel_name == NULL)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < adc->slot_count; i++) {
> +		channel_name[i] = devm_kzalloc(&indio_dev->dev,
> +				ADC_MAX_STR_SIZE, GFP_KERNEL);
No need to do this here, use devm_kasprintf as suggested below.
If not I think you could easily have combined this loop with the one
below simplifying the code.

> +		if (channel_name == NULL)
> +			return -ENOMEM;
> +	}
> +
> +	chan = chan_array;
> +	for (i = 0; i < adc->slot_count; i++, chan++) {
> +		chan->type = IIO_VOLTAGE;
> +		chan->indexed = 1;
> +		chan->channel = i;
> +		chan->address = i;
No need to set address if it is always being set to the same
value as channel.  Channel is available everywhere address is so
just use that value.

> +
> +		/* Construct iio sysfs name*/
> +		if (adc->mode == MODE_SINGLE_ADC) {
Use kasprintf and you can skip the earlier allocation of channel_name[i]
plus allocate exactly what is needed.
> +			snprintf(channel_name[i], ADC_MAX_STR_SIZE,
> +				"adc%d-ch%d",
> +				adc->adc_number,
> +				adc->slot_sequence[0][i]);
> +		} else if (adc->mode == MODE_DUAL_ADC) {
> +			snprintf(channel_name[i], ADC_MAX_STR_SIZE,
> +				"adc1-ch%d_adc2-ch%d",
> +				adc->slot_sequence[0][i],
> +				adc->slot_sequence[1][i]);
> +		} else {
> +			return -EINVAL;
> +		}
> +
> +		chan->datasheet_name = channel_name[i];
> +		chan->extend_name = channel_name[i];
You are making use of extend_name in an unusual way.
1) This results in non standard ABI so should be documented under
Documentation/ABI/testing/sysfs-bus-iio*
2) The naming here makes me think you are abusing the abi and pushing two
channels through the same sysfs attribute.  Don't do that.  If you need
to clearly capture two channels together then implement the buffered
interface (chardev reading of 'scans' - groups of channels captured at
a similar time) rather than abusing the simpler sysfs route.
> +		chan->scan_index = i;
You aren't providing buffered access yet so don't bother filling in
scan_index or scan_type fo rhte channels (they are unusued).
> +		chan->scan_type.sign = 'u';
> +		chan->scan_type.realbits = ADC_BITS;
> +		chan->scan_type.storagebits = ADC_STORE_BITS;
> +		chan->scan_type.endianness = IIO_CPU;
> +		chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> +	}
> +
> +	indio_dev->channels = chan_array;
Might as well just use indio_dev->channels directly rather than
having the local variable.

> +
> +	return 0;
> +}
> +
> +static const struct of_device_id alt_modular_adc_match[] = {
> +	{ .compatible = "altr,modular-adc-1.0" },
> +	{ .compatible = "altr,modular-dual-adc-1.0" },
> +	{ /* Sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, alt_modular_adc_match);
> +
> +static int alt_modular_adc_parse_dt(struct iio_dev *indio_dev,
> +				struct device *dev)
> +{
> +	struct altera_adc *adc = iio_priv(indio_dev);
> +	struct device_node *np = dev->of_node;
> +	u32 value;
> +	int ret, i, j;
> +	char str[50];
> +
> +	ret = of_property_read_u32(np, "altr,adc-mode", &value);
> +	if (ret < 0)
> +		return ret;
> +	if (value == 0 || value > MAX_ADC) {
> +		dev_err(dev, "Invalid ADC mode value");
> +		return -EINVAL;
> +	}
> +	adc->mode = value;
> +
> +	ret = of_property_read_u32(np, "altr,adc-slot-count", &value);
> +	if (ret < 0)
> +		return ret;
> +	if (value == 0 || value > MAX_SLOT) {
> +		dev_err(dev, "Invalid ADC slot count value");
> +		return -EINVAL;
> +	}
> +	adc->slot_count = value;
> +
> +	ret = of_property_read_u32(np, "altr,adc-number", &value);
> +	if (ret < 0)
> +		return ret;
> +	if (value == 0 || value > MAX_ADC) {
> +		dev_err(dev, "Invalid ADC number value");
> +		return -EINVAL;
> +	}
> +	adc->adc_number = value;
> +
> +	/* Device tree lookup for channels for each memory slots */
> +	for (j = 0; j < adc->mode; j++) {
> +		for (i = 0; i < adc->slot_count; i++) {
> +			str[0] = '\0';
> +
> +			snprintf(str, sizeof(str),
> +				"altr,adc%d-slot-sequence-%d",
> +				(j + 1), (i + 1));
> +
> +			ret = of_property_read_u32(np, str, &value);
> +			if (ret < 0)
> +				return ret;
> +			if (value > MAX_CHANNEL) {
> +				dev_err(dev, "Invalid ADC channel value");
> +				return -EINVAL;
> +			}
> +			adc->slot_sequence[j][i] = value;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int alt_modular_adc_probe(struct platform_device *pdev)
> +{
> +	struct altera_adc *adc;
> +	struct device_node *np = pdev->dev.of_node;
> +	struct iio_dev *indio_dev;
> +	struct resource *mem;
> +	int ret;
> +
> +	if (!np)
> +		return -ENODEV;
> +
> +	indio_dev = iio_device_alloc(sizeof(struct altera_adc));
Convention has become sizeof(*adc) as it makes the connection slightly
more explicit.

> +	if (!indio_dev) {
> +		dev_err(&pdev->dev, "failed allocating iio device\n");
> +		return -ENOMEM;
> +	}
> +
> +	adc = iio_priv(indio_dev);
> +
> +	mem = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +		"sequencer_csr");
> +	adc->seq_regs = devm_ioremap_resource(&pdev->dev, mem);
> +	if (IS_ERR(adc->seq_regs)) {
> +		ret = PTR_ERR(adc->seq_regs);
> +		goto err_iio;
> +	}
> +
> +	mem = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +		"sample_store_csr");
> +	adc->sample_regs = devm_ioremap_resource(&pdev->dev, mem);
> +	if (IS_ERR(adc->sample_regs)) {
> +		ret = PTR_ERR(adc->sample_regs);
> +		goto err_iio;
> +	}
> +
> +	ret = alt_modular_adc_parse_dt(indio_dev, &pdev->dev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to parse device tree\n");
> +		goto err_iio;
> +	}
> +
> +	ret = alt_modular_adc_channel_init(indio_dev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed initialize ADC channels\n");
> +		goto err_iio;
> +	}
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	indio_dev->name = dev_name(&pdev->dev);
> +	indio_dev->dev.parent = &pdev->dev;
> +	indio_dev->dev.of_node = pdev->dev.of_node;
> +	indio_dev->info = &adc_iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->num_channels = adc->slot_count;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret)
> +		goto err_iio;
> +
> +	/* Disable Interrupt */
> +	writel_relaxed(0, (adc->sample_regs + ADC_IER_REG));
Given we don't seem to handle interrupts anywhere I'd expect the device
to have come up with this disabled, but if it doesn't, this definitely
belongs a lot earlier than here.
> +
> +	/* Start Continuous Sampling */
> +	writel_relaxed((ADC_RUN_MSK), (adc->seq_regs + ADC_CMD_REG));

I'm not sure it makes sense to do either of these last two steps
after the userspace interface is started by the iio_device_register
call.

> +
> +	return 0;
> +
Only 1 blank line here please (pretty much always considered enough
in kernel coding style).
> +
> +err_iio:
> +	iio_device_free(indio_dev);
> +	return ret;
> +}
> +
> +static int alt_modular_adc_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct altera_adc *adc = iio_priv(indio_dev);
> +

If you don't unregister the iio_device first there is a clear
race condition with userspace requests hitting after you've
stopped the ADC but before the interfaces have been removed / marked
as going away by that unregister call.

> +	/* Stop ADC */
> +	writel((ADC_STOP_MSK), (adc->seq_regs + ADC_CMD_REG));

Still  an excess of brackets.  You don't need them around a lot
of these arguments.  We can reasonably assume they don't contain
any malicious elements that could lead to it doing other than the
obvious.
	writel(ADC_STOP_MSK, adc->seq_regs + ADC_CMD_REG);
will be fine (similar cases elsewhere in the driver).

> +
> +	/* Unregister ADC */
> +	iio_device_unregister(indio_dev);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver altr_modular_adc_driver = {
> +	.probe		= alt_modular_adc_probe,
> +	.remove		= alt_modular_adc_remove,
> +	.driver		= {
> +		.name	= "alt-modular-adc",
> +		.owner	= THIS_MODULE,
> +		.of_match_table = alt_modular_adc_match,
> +	},
> +};
> +
> +
> +module_platform_driver(altr_modular_adc_driver);
> +
> +MODULE_DESCRIPTION("Altera Modular ADC Driver");
> +MODULE_AUTHOR("Chee Nouk Phoon <cnphoon@altera.com>");
> +MODULE_LICENSE("GPL v2");
> 

