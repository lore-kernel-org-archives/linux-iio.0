Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.117]:37848 "EHLO vps.pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750931AbdFVEw7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 22 Jun 2017 00:52:59 -0400
Date: Thu, 22 Jun 2017 06:52:56 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jack Andersen <jackoalan@gmail.com>
cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Octavian Purdila <octavian.purdila@intel.com>
Subject: Re: [PATCH] iio: adc: Add support for DLN2 ADC
In-Reply-To: <1498101549-6252-2-git-send-email-jackoalan@gmail.com>
Message-ID: <alpine.DEB.2.20.1706220627310.31788@vps.pmeerw.net>
References: <1498101549-6252-1-git-send-email-jackoalan@gmail.com> <1498101549-6252-2-git-send-email-jackoalan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> This patch adds support for Diolan DLN2 ADC via IIO's ADC interface.
> ADC is the fourth and final component of the DLN2 for the kernel.

comments below

> Signed-off-by: Jack Andersen <jackoalan@gmail.com>
> ---
>  drivers/iio/adc/Kconfig    |   9 +
>  drivers/iio/adc/Makefile   |   1 +
>  drivers/iio/adc/dln2-adc.c | 648 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/mfd/dln2.c         |  12 +
>  4 files changed, 670 insertions(+)
>  create mode 100644 drivers/iio/adc/dln2-adc.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 401f47b..78d7455 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -239,6 +239,15 @@ config DA9150_GPADC
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called berlin2-adc.
>  
> +config DLN2_ADC
> +	tristate "Diolan DLN-2 ADC driver support"
> +	depends on MFD_DLN2
> +	help
> +	  Say yes here to build support for Diolan DLN-2 ADC.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called adc_dln2.
> +
>  config ENVELOPE_DETECTOR
>  	tristate "Envelope detector using a DAC and a comparator"
>  	depends on OF
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 9339bec..378bc65 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -24,6 +24,7 @@ obj-$(CONFIG_BERLIN2_ADC) += berlin2-adc.o
>  obj-$(CONFIG_CC10001_ADC) += cc10001_adc.o
>  obj-$(CONFIG_CPCAP_ADC) += cpcap-adc.o
>  obj-$(CONFIG_DA9150_GPADC) += da9150-gpadc.o
> +obj-$(CONFIG_DLN2_ADC) += dln2-adc.o
>  obj-$(CONFIG_ENVELOPE_DETECTOR) += envelope-detector.o
>  obj-$(CONFIG_EXYNOS_ADC) += exynos_adc.o
>  obj-$(CONFIG_FSL_MX25_ADC) += fsl-imx25-gcq.o
> diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
> new file mode 100644
> index 0000000..7900e2c
> --- /dev/null
> +++ b/drivers/iio/adc/dln2-adc.c
> @@ -0,0 +1,648 @@
> +/*
> + * Driver for the Diolan DLN-2 USB-ADC adapter
> + *
> + * Copyright (c) 2017 Jack Andersen
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation, version 2.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <linux/platform_device.h>
> +#include <linux/mfd/dln2.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/kfifo_buf.h>
> +#include <linux/virtio.h>

virtio needed?

> +#include <linux/version.h>
> +
> +#define DLN2_ADC_MOD_NAME "dln2-adc"
> +
> +#define DLN2_ADC_ID             0x06
> +
> +#define DLN2_ADC_GET_CHANNEL_COUNT	DLN2_CMD(0x01, DLN2_ADC_ID)
> +#define DLN2_ADC_ENABLE			DLN2_CMD(0x02, DLN2_ADC_ID)
> +#define DLN2_ADC_DISABLE		DLN2_CMD(0x03, DLN2_ADC_ID)
> +#define DLN2_ADC_CHANNEL_ENABLE		DLN2_CMD(0x05, DLN2_ADC_ID)
> +#define DLN2_ADC_CHANNEL_DISABLE	DLN2_CMD(0x06, DLN2_ADC_ID)
> +#define DLN2_ADC_SET_RESOLUTION		DLN2_CMD(0x08, DLN2_ADC_ID)
> +#define DLN2_ADC_CHANNEL_GET_VAL	DLN2_CMD(0x0A, DLN2_ADC_ID)
> +#define DLN2_ADC_CHANNEL_GET_ALL_VAL	DLN2_CMD(0x0B, DLN2_ADC_ID)
> +#define DLN2_ADC_CHANNEL_SET_CFG	DLN2_CMD(0x0C, DLN2_ADC_ID)
> +#define DLN2_ADC_CHANNEL_GET_CFG	DLN2_CMD(0x0D, DLN2_ADC_ID)
> +#define DLN2_ADC_CONDITION_MET_EV	DLN2_CMD(0x10, DLN2_ADC_ID)
> +
> +#define DLN2_ADC_EVENT_NONE		0
> +#define DLN2_ADC_EVENT_BELOW		1
> +#define DLN2_ADC_EVENT_LEVEL_ABOVE	2
> +#define DLN2_ADC_EVENT_OUTSIDE		3
> +#define DLN2_ADC_EVENT_INSIDE		4
> +#define DLN2_ADC_EVENT_ALWAYS		5
> +
> +#define DLN2_ADC_MAX_CHANNELS 8
> +#define DLN2_ADC_DATA_BITS 10
> +
> +struct dln2_adc {
> +	struct platform_device *pdev;
> +	int port;

u8

> +	struct iio_trigger *trig;
> +	/* Set once initialized */
> +	u8 port_enabled;

bool, and use true/false

> +	/* Set once resolution request made to HW */
> +	u8 resolution_set;

bool

> +	/* Bitmask requesting enabled channels */
> +	unsigned long chans_requested;
> +	/* Bitmask indicating enabled channels on HW */
> +	unsigned long chans_enabled;
> +	/* Channel that is arbitrated for event trigger */
> +	int trigger_chan;
> +};
> +
> +struct dln2_adc_port_chan {
> +	u8 port;
> +	u8 chan;
> +};
> +
> +struct dln2_adc_get_all_vals {
> +	__le16 channel_mask;
> +	__le16 values[DLN2_ADC_MAX_CHANNELS];
> +};
> +
> +static int dln2_adc_get_chan_count(struct dln2_adc *dln2)
> +{
> +	int ret;
> +	u8 port = dln2->port;
> +	int ilen = sizeof(port);

save/drop these two temporary variable (here and elsewhere)

> +	u8 count;
> +	int olen = sizeof(count);
> +
> +	ret = dln2_transfer(dln2->pdev, DLN2_ADC_GET_CHANNEL_COUNT,
> +			    &port, ilen, &count, &olen);
> +	if (ret < 0) {
> +		dev_dbg(&dln2->pdev->dev, "Problem in %s\n", __func__);
> +		return ret;
> +	}
> +	if (olen < sizeof(count))
> +		return -EPROTO;
> +
> +	return count;
> +}
> +
> +static int dln2_adc_set_port_resolution(struct dln2_adc *dln2)
> +{
> +	int ret;
> +	struct dln2_adc_port_chan port_chan = {
> +		.port = dln2->port,
> +		.chan = DLN2_ADC_DATA_BITS,
> +	};
> +	int ilen = sizeof(port_chan);

save/drop temporary variable, here and elsewhere

> +
> +	ret = dln2_transfer_tx(dln2->pdev, DLN2_ADC_SET_RESOLUTION,
> +			       &port_chan, ilen);
> +	if (ret < 0) {
> +		dev_dbg(&dln2->pdev->dev, "Problem in %s\n", __func__);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int dln2_adc_set_chan_enabled(struct dln2_adc *dln2,
> +				     int channel, bool enable)
> +{
> +	int ret;
> +	struct dln2_adc_port_chan port_chan = {
> +		.port = dln2->port,
> +		.chan = channel,
> +	};
> +	int ilen = sizeof(port_chan);
> +
> +	u16 cmd = enable ? DLN2_ADC_CHANNEL_ENABLE : DLN2_ADC_CHANNEL_DISABLE;
> +
> +	ret = dln2_transfer_tx(dln2->pdev, cmd, &port_chan, ilen);
> +	if (ret < 0) {
> +		dev_dbg(&dln2->pdev->dev, "Problem in %s\n", __func__);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int dln2_adc_set_port_enabled(struct dln2_adc *dln2, bool enable)
> +{
> +	int ret;
> +	u8 port = dln2->port;
> +	int ilen = sizeof(port);
> +	__le16 conflict;
> +	int olen = sizeof(conflict);
> +
> +	u16 cmd = enable ? DLN2_ADC_ENABLE : DLN2_ADC_DISABLE;
> +
> +	ret = dln2_transfer(dln2->pdev, cmd, &port, ilen, &conflict, &olen);
> +	if (ret < 0) {
> +		dev_dbg(&dln2->pdev->dev, "Problem in %s(%d)\n",
> +			__func__, (int)enable);
> +		return ret;
> +	}
> +	if (enable && olen < sizeof(conflict))
> +		return -EPROTO;
> +
> +	return 0;
> +}
> +
> +/*
> + * ADC channels are lazily enabled due to the pins being shared with GPIO
> + * channels. Enabling channels requires taking the ADC port offline, specifying
> + * the resolution, individually enabling channels, then putting the port back
> + * online. If GPIO pins have already been exported by gpio_dln2, EINVAL is
> + * reported.
> + */
> +static int dln2_adc_update_enabled_chans(struct dln2_adc *dln2)
> +{
> +	int ret, i, chan_count;
> +	struct iio_dev *indio_dev;
> +
> +	if (dln2->chans_enabled == dln2->chans_requested)
> +		return 0;
> +
> +	indio_dev = platform_get_drvdata(dln2->pdev);
> +	chan_count = indio_dev->num_channels;
> +
> +	if (dln2->port_enabled) {
> +		ret = dln2_adc_set_port_enabled(dln2, false);
> +		if (ret < 0)
> +			return ret;
> +		dln2->port_enabled = false;
> +	}
> +
> +	if (!dln2->resolution_set) {
> +		ret = dln2_adc_set_port_resolution(dln2);
> +		if (ret < 0)
> +			return ret;
> +		dln2->resolution_set = true;
> +	}
> +
> +	for (i = 0; i < chan_count; ++i) {
> +		bool requested = (dln2->chans_requested & (1 << i));
> +		bool enabled = (dln2->chans_enabled & (1 << i));

outer parenthesis not needed

> +
> +		if (requested == enabled)
> +			continue;
> +		ret = dln2_adc_set_chan_enabled(dln2, i, requested);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	dln2->chans_enabled = dln2->chans_requested;
> +
> +	ret = dln2_adc_set_port_enabled(dln2, true);
> +	if (ret < 0)
> +		return ret;
> +	dln2->port_enabled = true;
> +
> +	return ret;
> +}
> +
> +static int dln2_adc_get_chan_freq(struct dln2_adc *dln2, unsigned int channel)
> +{
> +	int ret;
> +	struct dln2_adc_port_chan port_chan = {
> +		.port = dln2->port,
> +		.chan = channel,
> +	};
> +	int ilen = sizeof(port_chan);
> +	struct {
> +		__u8 type;
> +		__le16 period;
> +		__le16 low;
> +		__le16 high;
> +	} __packed get_cfg;
> +	int olen = sizeof(get_cfg);
> +
> +	ret = dln2_transfer(dln2->pdev, DLN2_ADC_CHANNEL_GET_CFG,
> +			    &port_chan, ilen, &get_cfg, &olen);
> +	if (ret < 0) {
> +		dev_dbg(&dln2->pdev->dev, "Problem in %s\n", __func__);
> +		return ret;
> +	}
> +	if (olen < sizeof(get_cfg))
> +		return -EPROTO;
> +
> +	return get_cfg.period;

period is __le16, need to use le16_to_cpu()

> +}
> +
> +static int dln2_adc_set_chan_freq(struct dln2_adc *dln2, unsigned int channel,
> +				  unsigned int freq)
> +{
> +	int ret;
> +	struct {
> +		struct dln2_adc_port_chan port_chan;
> +		__u8 type;
> +		__le16 period;
> +		__le16 low;
> +		__le16 high;
> +	} __packed set_cfg = {
> +		.port_chan.port = dln2->port,
> +		.port_chan.chan = channel,
> +		.type = freq ? DLN2_ADC_EVENT_ALWAYS : DLN2_ADC_EVENT_NONE,
> +		.period = freq

end with ,
use cpu_to_le16() on freq

> +	};
> +
> +	ret = dln2_transfer_tx(dln2->pdev, DLN2_ADC_CHANNEL_SET_CFG,
> +			       &set_cfg, sizeof(set_cfg));

no dev_dbg() here?

> +	return ret;
> +}
> +
> +static int dln2_adc_read(struct dln2_adc *dln2, unsigned int channel)
> +{
> +	int ret;
> +
> +	dln2->chans_requested |= (1 << channel);
> +	ret = dln2_adc_update_enabled_chans(dln2);
> +	if (ret < 0)
> +		return ret;
> +	dln2->port_enabled = 1;

need to rollback chans_requested?

> +
> +	struct dln2_adc_port_chan port_chan = {
> +		.port = dln2->port,
> +		.chan = channel,
> +	};
> +	int ilen = sizeof(port_chan);
> +	__le16 value;
> +	int olen = sizeof(value);
> +
> +	ret = dln2_transfer(dln2->pdev, DLN2_ADC_CHANNEL_GET_VAL,
> +			    &port_chan, ilen, &value, &olen);
> +	if (ret < 0) {
> +		dev_dbg(&dln2->pdev->dev, "Problem in %s\n", __func__);
> +		return ret;
> +	}
> +	if (olen < sizeof(value))
> +		return -EPROTO;
> +
> +	return le16_to_cpu(value);
> +}
> +
> +static int dln2_adc_read_all(struct dln2_adc *dln2,
> +			     struct dln2_adc_get_all_vals *get_all_vals)
> +{
> +	int ret;
> +	__u8 port = dln2->port;
> +	int olen = sizeof(struct dln2_adc_get_all_vals);

why not 
sizeof(dln2_adc_get_all_vals)
as done with other structs?

> +
> +	ret = dln2_transfer(dln2->pdev, DLN2_ADC_CHANNEL_GET_ALL_VAL,
> +			    &port, sizeof(port), get_all_vals, &olen);
> +	if (ret < 0) {
> +		dev_dbg(&dln2->pdev->dev, "Problem in %s\n", __func__);
> +		return ret;
> +	}
> +	if (olen < sizeof(struct dln2_adc_get_all_vals))
> +		return -EPROTO;
> +
> +	return 0;
> +}
> +
> +static int dln2_adc_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val,
> +			     int *val2,
> +			     long mask)
> +{
> +	int ret;
> +	struct dln2_adc *dln2 = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&indio_dev->mlock);

use your own lock as most/all other drivers do, here and elsewhere

> +		ret = dln2_adc_read(dln2, chan->channel);
> +		mutex_unlock(&indio_dev->mlock);
> +
> +		if (ret < 0)
> +			break;
> +
> +		*val = ret;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 0;
> +		// 3.3 / (1 << 10) * 1000000;

no C++ style comments

> +		*val2 = 3222656;
> +		return IIO_VAL_INT_PLUS_NANO;
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		mutex_lock(&indio_dev->mlock);
> +		if (dln2->trigger_chan == -1)
> +			ret = 0;
> +		else
> +			ret = dln2_adc_get_chan_freq(dln2, dln2->trigger_chan);
> +		mutex_unlock(&indio_dev->mlock);
> +
> +		if (ret < 0)
> +			break;
> +
> +		*val = ret / 1000;
> +		*val2 = (ret % 1000) * 1000;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +
> +	default:
> +		break;

return -EINVAL directly here and elsewhere

> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int dln2_adc_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val,
> +			      int val2,
> +			      long mask)
> +{
> +	int ret = 0;

initialization not needed

> +	unsigned int freq;
> +	struct dln2_adc *dln2 = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		freq = val * 1000 + val2 / 1000;
> +		if (freq > 65535) {
> +			freq = 65535;
> +			dev_warn(&dln2->pdev->dev,
> +				 "clamping freq to 65535ms\n");
> +		}
> +		mutex_lock(&indio_dev->mlock);
> +
> +		/*
> +		 * The first requested channel is arbitrated as a shared
> +		 * trigger source, so only one event is registered with the DLN.
> +		 * The event handler will then read all enabled channel values
> +		 * using DLN2_ADC_CHANNEL_GET_ALL_VAL to maintain
> +		 * synchronization between ADC readings.
> +		 */
> +		if (dln2->trigger_chan == -1)
> +			dln2->trigger_chan = chan->channel;
> +		ret = dln2_adc_set_chan_freq(dln2, dln2->trigger_chan, freq);
> +
> +		mutex_unlock(&indio_dev->mlock);
> +
> +		if (ret < 0)
> +			break;
> +
> +		return 0;
> +
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +#define DLN2_ADC_CHAN(idx) {					\
> +	.type = IIO_VOLTAGE,					\
> +	.indexed = 1,						\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE) |	\
> +				   BIT(IIO_CHAN_INFO_SAMP_FREQ),\
> +	.scan_type.sign = 'u',					\
> +	.scan_type.realbits = DLN2_ADC_DATA_BITS,		\
> +	.scan_type.storagebits = 16,				\
> +	.scan_type.endianness = IIO_LE,				\
> +	.channel = idx,						\
> +	.scan_index = idx,					\

maybe move .scan_index next to .scan_type and .channel next to .indexed

> +}
> +
> +static const struct iio_chan_spec dln2_adc_iio_channels[] = {
> +	DLN2_ADC_CHAN(0),
> +	DLN2_ADC_CHAN(1),
> +	DLN2_ADC_CHAN(2),
> +	DLN2_ADC_CHAN(3),
> +	DLN2_ADC_CHAN(4),
> +	DLN2_ADC_CHAN(5),
> +	DLN2_ADC_CHAN(6),
> +	DLN2_ADC_CHAN(7),
> +};
> +
> +static const struct iio_info dln2_adc_info = {
> +	.read_raw = &dln2_adc_read_raw,

no need for & for functions

> +	.write_raw = &dln2_adc_write_raw,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static irqreturn_t dln2_adc_trigger_h(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	int len = 0;
> +	u16 *data;

__le16

> +	struct dln2_adc_get_all_vals dev_data;
> +	struct dln2_adc *dln2 = iio_priv(indio_dev);
> +
> +	mutex_lock(&indio_dev->mlock);
> +
> +	dln2->chans_requested |= *indio_dev->active_scan_mask;
> +	if (dln2_adc_update_enabled_chans(dln2) < 0) {
> +		mutex_unlock(&indio_dev->mlock);
> +		goto done;
> +	}
> +
> +	if (dln2_adc_read_all(dln2, &dev_data) < 0) {
> +		mutex_unlock(&indio_dev->mlock);
> +		goto done;
> +	}
> +
> +	mutex_unlock(&indio_dev->mlock);
> +
> +	data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);

maybe statically allocate maximum size in struct dln2_adc (or on stack) 
and use that

> +	if (!data)
> +		goto done;
> +
> +	if (!bitmap_empty(indio_dev->active_scan_mask,
> +			  indio_dev->masklength)) {

is this check needed? can't we just loop over and find that no bit is set?

> +		int i, j;
> +
> +		for (i = 0, j = 0;
> +		     i < bitmap_weight(indio_dev->active_scan_mask,
> +				       indio_dev->masklength);
> +		     i++, j++) {
> +			j = find_next_bit(indio_dev->active_scan_mask,
> +					  indio_dev->masklength, j);
> +			data[i] = dev_data.values[j];
> +			len += 2;

2 should be sizeof(__le16) or sizeof(dev_data.values[i])

> +		}
> +	}
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, data,
> +					   iio_get_time_ns(indio_dev));

there is no timestamp in dln2_adc_iio_channels; data would need space for 
timestamp + packing

> +
> +	kfree(data);
> +
> +done:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}
> +
> +static int dln2_adc_triggered_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct dln2_adc *dln2 = iio_priv(indio_dev);
> +
> +	dln2->chans_requested |= *indio_dev->active_scan_mask;
> +	dln2_adc_update_enabled_chans(dln2);

check return value?

> +
> +	return iio_triggered_buffer_postenable(indio_dev);
> +}
> +
> +static const struct iio_buffer_setup_ops dln2_adc_buffer_setup_ops = {
> +	.postenable = &dln2_adc_triggered_buffer_postenable,
> +	.predisable = &iio_triggered_buffer_predisable,

no need for &

> +};
> +
> +static void dln2_adc_event(struct platform_device *pdev, u16 echo,
> +			   const void *data, int len)
> +{
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct dln2_adc *dln2 = iio_priv(indio_dev);
> +
> +	iio_trigger_poll(dln2->trig);
> +}
> +
> +static const struct iio_trigger_ops dln2_adc_trigger_ops = {
> +	.owner = THIS_MODULE,
> +};
> +
> +static int dln2_adc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct dln2_adc *dln2;
> +	struct dln2_platform_data *pdata = dev_get_platdata(&pdev->dev);
> +	struct iio_dev *indio_dev = NULL;

no need to initialize

> +	struct iio_buffer *buffer;
> +	int ret = -ENODEV;

no need to initialize

> +	int chans;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(struct dln2_adc));
> +	if (!indio_dev) {
> +		dev_err(dev, "failed allocating iio device\n");
> +		return -ENOMEM;
> +	}
> +
> +	dln2 = iio_priv(indio_dev);
> +	dln2->pdev = pdev;
> +	dln2->port = pdata->port;
> +	dln2->port_enabled = 0;

false

> +	dln2->resolution_set = 0;

false

> +	dln2->chans_requested = 0;
> +	dln2->chans_enabled = 0;
> +	dln2->trigger_chan = -1;
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	chans = dln2_adc_get_chan_count(dln2);
> +	if (chans < 0) {
> +		dev_err(dev, "failed to get channel count: %d\n", chans);
> +		ret = chans;
> +		goto dealloc_dev;
> +	}
> +	if (chans > DLN2_ADC_MAX_CHANNELS) {
> +		chans = DLN2_ADC_MAX_CHANNELS;
> +		dev_warn(dev, "clamping channels to %d\n",
> +			 DLN2_ADC_MAX_CHANNELS);
> +	}
> +
> +	indio_dev->name = DLN2_ADC_MOD_NAME;
> +	indio_dev->dev.parent = dev;
> +	indio_dev->info = &dln2_adc_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;
> +	indio_dev->channels = dln2_adc_iio_channels;
> +	indio_dev->num_channels = chans;
> +	indio_dev->setup_ops = &dln2_adc_buffer_setup_ops;
> +
> +	dln2->trig = devm_iio_trigger_alloc(dev, "samplerate");
> +	if (!dln2->trig) {
> +		dev_err(dev, "failed to allocate trigger\n");
> +		goto dealloc_dev;
> +	}
> +	dln2->trig->ops = &dln2_adc_trigger_ops;
> +	iio_trigger_set_drvdata(dln2->trig, dln2);
> +	iio_trigger_register(dln2->trig);
> +	iio_trigger_set_immutable(indio_dev, dln2->trig);
> +
> +	buffer = devm_iio_kfifo_allocate(dev);
> +	if (!buffer) {
> +		dev_err(dev, "failed to allocate kfifo\n");
> +		ret = -ENOMEM;
> +		goto dealloc_trigger;
> +	}
> +
> +	iio_device_attach_buffer(indio_dev, buffer);
> +
> +	indio_dev->pollfunc = iio_alloc_pollfunc(NULL,
> +						 &dln2_adc_trigger_h,
> +						 IRQF_ONESHOT,
> +						 indio_dev,
> +						 "samplerate");
> +
> +	if (!indio_dev->pollfunc) {
> +		ret = -ENOMEM;
> +		goto dealloc_kfifo;
> +	}
> +
> +	ret = dln2_register_event_cb(pdev, DLN2_ADC_CONDITION_MET_EV,
> +				     dln2_adc_event);
> +	if (ret) {
> +		dev_err(dev, "failed to register event cb: %d\n", ret);
> +		goto dealloc_pollfunc;
> +	}
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret) {
> +		dev_err(dev, "failed to register iio device: %d\n", ret);
> +		goto dealloc_pollfunc;
> +	}
> +
> +	dev_info(dev, "DLN2 ADC driver loaded\n");

avoid this kind of logging

> +
> +	return 0;
> +
> +dealloc_pollfunc:
> +	iio_dealloc_pollfunc(indio_dev->pollfunc);
> +dealloc_kfifo:
> +dealloc_trigger:
> +	iio_trigger_unregister(dln2->trig);
> +dealloc_dev:
> +
> +	return ret;
> +}
> +
> +static int dln2_adc_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct dln2_adc *dln2 = iio_priv(indio_dev);
> +
> +	dev_info(&indio_dev->dev, "DLN2 ADC driver unloaded\n");

no such logging please

> +
> +	dln2_unregister_event_cb(pdev, DLN2_ADC_CONDITION_MET_EV);

should be after device_unregister

> +	iio_device_unregister(indio_dev);
> +	iio_trigger_unregister(dln2->trig);
> +	iio_dealloc_pollfunc(indio_dev->pollfunc);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver dln2_adc_driver = {
> +	.driver.name	= DLN2_ADC_MOD_NAME,
> +	.probe		= dln2_adc_probe,
> +	.remove		= dln2_adc_remove,
> +};
> +
> +module_platform_driver(dln2_adc_driver);
> +
> +MODULE_AUTHOR("Jack Andersen <jackoalan@gmail.com");
> +MODULE_DESCRIPTION("Driver for the Diolan DLN2 ADC interface");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:dln2-adc");
> diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
> index 704e189..a22ab8c 100644
> --- a/drivers/mfd/dln2.c
> +++ b/drivers/mfd/dln2.c
> @@ -53,6 +53,7 @@ enum dln2_handle {
>  	DLN2_HANDLE_GPIO,
>  	DLN2_HANDLE_I2C,
>  	DLN2_HANDLE_SPI,
> +	DLN2_HANDLE_ADC,
>  	DLN2_HANDLES
>  };
>  
> @@ -663,6 +664,12 @@ static int dln2_start_rx_urbs(struct dln2_dev *dln2, gfp_t gfp)
>  	.port = 0,
>  };
>  
> +/* Only one ADC port supported */
> +static struct dln2_platform_data dln2_pdata_adc = {
> +	.handle = DLN2_HANDLE_ADC,
> +	.port = 0,
> +};
> +
>  static const struct mfd_cell dln2_devs[] = {
>  	{
>  		.name = "dln2-gpio",
> @@ -679,6 +686,11 @@ static int dln2_start_rx_urbs(struct dln2_dev *dln2, gfp_t gfp)
>  		.platform_data = &dln2_pdata_spi,
>  		.pdata_size = sizeof(struct dln2_platform_data),
>  	},
> +	{
> +		.name = "dln2-adc",
> +		.platform_data = &dln2_pdata_adc,
> +		.pdata_size = sizeof(struct dln2_platform_data),
> +	},
>  };
>  
>  static void dln2_stop(struct dln2_dev *dln2)
> 

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
