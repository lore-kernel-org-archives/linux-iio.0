Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49248 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754464AbbHOUYJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 15 Aug 2015 16:24:09 -0400
Subject: Re: [PATCH v3] iio: adc: vf610: Add IIO buffer support for Vybrid ADC
To: Sanchayan Maity <maitysanchayan@gmail.com>,
	linux-iio@vger.kernel.org
References: <cover.1439283162.git.maitysanchayan@gmail.com>
 <d556443a26070be505f9a5f5f0999253b73d9b71.1439283162.git.maitysanchayan@gmail.com>
Cc: stefan@agner.ch, B38611@freescale.com, pmeerw@pmeerw.net,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55CF9FE1.3000103@kernel.org>
Date: Sat, 15 Aug 2015 21:24:01 +0100
MIME-Version: 1.0
In-Reply-To: <d556443a26070be505f9a5f5f0999253b73d9b71.1439283162.git.maitysanchayan@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/08/15 10:05, Sanchayan Maity wrote:
> This patch adds support for IIO buffer to the Vybrid ADC driver.
> IIO triggered buffer infrastructure along with iio sysfs trigger
> is used to leverage continuous sampling support provided by the
> ADC block.
> 
> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
Hi Sanchayan,

Very nearly there. One little point to do with the buffer handling.
Basically I don't think you want anything in the preenable or
postdisable hooks, just in the 'internal' ones.

Jonathan
> ---
>  drivers/iio/adc/Kconfig     |   2 +
>  drivers/iio/adc/vf610_adc.c | 102 +++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 97 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 7c55658..660f790 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -337,6 +337,8 @@ config TWL6030_GPADC
>  config VF610_ADC
>  	tristate "Freescale vf610 ADC driver"
>  	depends on OF
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say yes here to support for Vybrid board analog-to-digital converter.
>  	  Since the IP is used for i.MX6SLX, the driver also support i.MX6SLX.
> diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
> index 23b8fb9..de62c48 100644
> --- a/drivers/iio/adc/vf610_adc.c
> +++ b/drivers/iio/adc/vf610_adc.c
> @@ -34,8 +34,11 @@
>  #include <linux/err.h>
>  
>  #include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
>  #include <linux/iio/sysfs.h>
> -#include <linux/iio/driver.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
>  
>  /* This will be the driver name the kernel reports */
>  #define DRIVER_NAME "vf610-adc"
> @@ -170,6 +173,7 @@ struct vf610_adc {
>  	u32 sample_freq_avail[5];
>  
>  	struct completion completion;
> +	u16 buffer[8];
>  };
>  
>  static const u32 vf610_hw_avgs[] = { 1, 4, 8, 16, 32 };
> @@ -505,12 +509,24 @@ static const struct iio_chan_spec_ext_info vf610_ext_info[] = {
>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
>  				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
>  	.ext_info = vf610_ext_info,				\
> +	.scan_index = (_idx),			\
> +	.scan_type = {					\
> +		.sign = 'u',				\
> +		.realbits = 12,				\
> +		.storagebits = 16,			\
> +	},						\
>  }
>  
>  #define VF610_ADC_TEMPERATURE_CHAN(_idx, _chan_type) {	\
>  	.type = (_chan_type),	\
>  	.channel = (_idx),		\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),	\
> +	.scan_index = (_idx),					\
> +	.scan_type = {						\
> +		.sign = 'u',					\
> +		.realbits = 12,					\
> +		.storagebits = 16,				\
> +	},							\
>  }
>  
>  static const struct iio_chan_spec vf610_adc_iio_channels[] = {
> @@ -531,6 +547,7 @@ static const struct iio_chan_spec vf610_adc_iio_channels[] = {
>  	VF610_ADC_CHAN(14, IIO_VOLTAGE),
>  	VF610_ADC_CHAN(15, IIO_VOLTAGE),
>  	VF610_ADC_TEMPERATURE_CHAN(26, IIO_TEMP),
> +	IIO_CHAN_SOFT_TIMESTAMP(32),
>  	/* sentinel */
>  };
>  
> @@ -559,13 +576,20 @@ static int vf610_adc_read_data(struct vf610_adc *info)
>  
>  static irqreturn_t vf610_adc_isr(int irq, void *dev_id)
>  {
> -	struct vf610_adc *info = (struct vf610_adc *)dev_id;
> +	struct iio_dev *indio_dev = (struct iio_dev *)dev_id;
> +	struct vf610_adc *info = iio_priv(indio_dev);
>  	int coco;
>  
>  	coco = readl(info->regs + VF610_REG_ADC_HS);
>  	if (coco & VF610_ADC_HS_COCO0) {
>  		info->value = vf610_adc_read_data(info);
> -		complete(&info->completion);
> +		if (iio_buffer_enabled(indio_dev)) {
> +			info->buffer[0] = info->value;
> +			iio_push_to_buffers_with_timestamp(indio_dev,
> +					info->buffer, iio_get_time_ns());
> +			iio_trigger_notify_done(indio_dev->trig);
> +		} else
> +			complete(&info->completion);
>  	}
>  
>  	return IRQ_HANDLED;
> @@ -613,8 +637,12 @@ static int vf610_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_RAW:
>  	case IIO_CHAN_INFO_PROCESSED:
>  		mutex_lock(&indio_dev->mlock);
> -		reinit_completion(&info->completion);
> +		if (iio_buffer_enabled(indio_dev)) {
> +			mutex_unlock(&indio_dev->mlock);
> +			return -EBUSY;
> +		}
>  
> +		reinit_completion(&info->completion);
>  		hc_cfg = VF610_ADC_ADCHC(chan->channel);
>  		hc_cfg |= VF610_ADC_AIEN;
>  		writel(hc_cfg, info->regs + VF610_REG_ADC_HC0);
> @@ -694,6 +722,57 @@ static int vf610_write_raw(struct iio_dev *indio_dev,
>  	return -EINVAL;
>  }
>  
> +static int vf610_adc_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct vf610_adc *info = iio_priv(indio_dev);
> +	unsigned int channel;
> +	int ret;
> +	int val;
> +
> +	ret = iio_triggered_buffer_postenable(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	val = readl(info->regs + VF610_REG_ADC_GC);
> +	val |= VF610_ADC_ADCON;
> +	writel(val, info->regs + VF610_REG_ADC_GC);
> +
> +	channel = find_first_bit(indio_dev->active_scan_mask,
> +						indio_dev->masklength);
> +
> +	val = VF610_ADC_ADCHC(channel);
> +	val |= VF610_ADC_AIEN;
> +
> +	writel(val, info->regs + VF610_REG_ADC_HC0);
> +
> +	return 0;
> +}
> +

These are suppose to be pair wise matched, so anything set up
in postenable has to be torn down in predisable.
Likewise, preenable setup torn down in postdisable.

The distinction is meant to be that a query will return that the
buffer is enabled from a point between the pre and post enable
and return that it is disabled from a point between the pre and
post disable.  Actually locks are held so there may no longer
be a window where it matters, but best to keep to convention.

I think you want the postdisable -> predisable and then call the
standard predisable from there.

> +static int vf610_adc_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct vf610_adc *info = iio_priv(indio_dev);
> +	unsigned int hc_cfg = 0;
> +	int val;
> +
> +	val = readl(info->regs + VF610_REG_ADC_GC);
> +	val &= ~VF610_ADC_ADCON;
> +	writel(val, info->regs + VF610_REG_ADC_GC);
> +
> +	hc_cfg |= VF610_ADC_CONV_DISABLE;
> +	hc_cfg &= ~VF610_ADC_AIEN;
> +
> +	writel(hc_cfg, info->regs + VF610_REG_ADC_HC0);
> +
> +	return 0;
> +}
> +
> +static const struct iio_buffer_setup_ops iio_triggered_buffer_setup_ops = {
> +	.postenable = &vf610_adc_buffer_postenable,
> +	.predisable = &iio_triggered_buffer_predisable,
> +	.postdisable = &vf610_adc_buffer_postdisable,
> +	.validate_scan_mask = &iio_validate_scan_mask_onehot,
> +};
> +
>  static int vf610_adc_reg_access(struct iio_dev *indio_dev,
>  			unsigned reg, unsigned writeval,
>  			unsigned *readval)
> @@ -753,7 +832,7 @@ static int vf610_adc_probe(struct platform_device *pdev)
>  
>  	ret = devm_request_irq(info->dev, irq,
>  				vf610_adc_isr, 0,
> -				dev_name(&pdev->dev), info);
> +				dev_name(&pdev->dev), indio_dev);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "failed requesting irq, irq = %d\n", irq);
>  		return ret;
> @@ -806,15 +885,23 @@ static int vf610_adc_probe(struct platform_device *pdev)
>  	vf610_adc_cfg_init(info);
>  	vf610_adc_hw_init(info);
>  
> +	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
> +					NULL, &iio_triggered_buffer_setup_ops);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Couldn't initialise the buffer\n");
> +		goto error_iio_device_register;
> +	}
> +
>  	ret = iio_device_register(indio_dev);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Couldn't register the device.\n");
> -		goto error_iio_device_register;
> +		goto error_adc_buffer_init;
>  	}
>  
>  	return 0;
>  
> -
> +error_adc_buffer_init:
> +	iio_triggered_buffer_cleanup(indio_dev);
>  error_iio_device_register:
>  	clk_disable_unprepare(info->clk);
>  error_adc_clk_enable:
> @@ -829,6 +916,7 @@ static int vf610_adc_remove(struct platform_device *pdev)
>  	struct vf610_adc *info = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
> +	iio_triggered_buffer_cleanup(indio_dev);
>  	regulator_disable(info->vref);
>  	clk_disable_unprepare(info->clk);
>  
> 

