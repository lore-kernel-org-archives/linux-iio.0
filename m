Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:37035 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064AbbHEH7Z (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Aug 2015 03:59:25 -0400
Received: by wibhh20 with SMTP id hh20so11920996wib.0
        for <linux-iio@vger.kernel.org>; Wed, 05 Aug 2015 00:59:24 -0700 (PDT)
Date: Wed, 5 Aug 2015 13:26:17 +0530
From: maitysanchayan@gmail.com
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: fabio.estevam@freescale.com, lars@metafoo.de, B38611@freescale.com,
	linux-iio@vger.kernel.org, knaack.h@gmx.de, stefan@agner.ch,
	jic23@kernel.org
Subject: Re: [PATCH] iio: adc: vf610: Add IIO buffer support for Vybrid ADC
Message-ID: <20150805075617.GA17211@Sanchayan-Arch.toradex.int>
References: <cover.1438610517.git.maitysanchayan@gmail.com>
 <1f11be7d7bc1c3fcebf7d0bcf274f1fcbef35999.1438610517.git.maitysanchayan@gmail.com>
 <alpine.DEB.2.02.1508031716370.12576@pmeerw.net>
 <alpine.DEB.2.02.1508040930050.3094@pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <alpine.DEB.2.02.1508040930050.3094@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

On 15-08-04 09:32:23, Peter Meerwald wrote:
> > > This patch adds support for IIO buffer to the Vybrid ADC driver.
> > > IIO triggered buffer infrastructure along with iio sysfs trigger
> > > is used to leverage continuous sampling support provided by the
> > > ADC block.
> > 
> > comments below
> 
> gave some ill advise regarding buffer size..
>   
> > > Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> > > ---
> > >  drivers/iio/adc/Kconfig     |   4 ++
> > >  drivers/iio/adc/vf610_adc.c | 122 +++++++++++++++++++++++++++++++++++++++++---
> > >  2 files changed, 120 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > > index 7c55658..4661241 100644
> > > --- a/drivers/iio/adc/Kconfig
> > > +++ b/drivers/iio/adc/Kconfig
> > > @@ -337,6 +337,10 @@ config TWL6030_GPADC
> > >  config VF610_ADC
> > >  	tristate "Freescale vf610 ADC driver"
> > >  	depends on OF
> > > +	select IIO_BUFFER
> > > +	select IIO_TRIGGER
> > > +	select IIO_SYSFS_TRIGGER
> > > +	select IIO_TRIGGERED_BUFFER
> > >  	help
> > >  	  Say yes here to support for Vybrid board analog-to-digital converter.
> > >  	  Since the IP is used for i.MX6SLX, the driver also support i.MX6SLX.
> > > diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
> > > index 23b8fb9..af72b9a 100644
> > > --- a/drivers/iio/adc/vf610_adc.c
> > > +++ b/drivers/iio/adc/vf610_adc.c
> > > @@ -34,8 +34,11 @@
> > >  #include <linux/err.h>
> > >  
> > >  #include <linux/iio/iio.h>
> > > +#include <linux/iio/buffer.h>
> > >  #include <linux/iio/sysfs.h>
> > > -#include <linux/iio/driver.h>
> > > +#include <linux/iio/trigger.h>
> > > +#include <linux/iio/trigger_consumer.h>
> > > +#include <linux/iio/triggered_buffer.h>
> > >  
> > >  /* This will be the driver name the kernel reports */
> > >  #define DRIVER_NAME "vf610-adc"
> > > @@ -170,6 +173,7 @@ struct vf610_adc {
> > >  	u32 sample_freq_avail[5];
> > >  
> > >  	struct completion completion;
> > > +	u16 *buffer;
> > >  };
> > >  
> > >  static const u32 vf610_hw_avgs[] = { 1, 4, 8, 16, 32 };
> > > @@ -505,12 +509,22 @@ static const struct iio_chan_spec_ext_info vf610_ext_info[] = {
> > >  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
> > >  				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> > >  	.ext_info = vf610_ext_info,				\
> > > +	.address = (_idx),				\
> > 
> > address is not used, no need to set it
> > 
> > > +	.scan_index = (_idx),			\
> > 
> > often this is written .scan_type = {.sign = 'u', ...}
> > 
> > > +	.scan_type.sign = 'u',			\
> > > +	.scan_type.realbits = 12,		\
> > > +	.scan_type.storagebits = 16,	\
> > >  }
> > >  
> > >  #define VF610_ADC_TEMPERATURE_CHAN(_idx, _chan_type) {	\
> > >  	.type = (_chan_type),	\
> > >  	.channel = (_idx),		\
> > >  	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),	\
> > > +	.address = (_idx),						\
> > > +	.scan_index = (_idx),					\
> > > +	.scan_type.sign = 'u',					\
> > > +	.scan_type.realbits = 12,				\
> > > +	.scan_type.storagebits = 16,			\
> > >  }
> > >  
> > >  static const struct iio_chan_spec vf610_adc_iio_channels[] = {
> > > @@ -531,6 +545,7 @@ static const struct iio_chan_spec vf610_adc_iio_channels[] = {
> > >  	VF610_ADC_CHAN(14, IIO_VOLTAGE),
> > >  	VF610_ADC_CHAN(15, IIO_VOLTAGE),
> > >  	VF610_ADC_TEMPERATURE_CHAN(26, IIO_TEMP),
> > > +	IIO_CHAN_SOFT_TIMESTAMP(32),
> > >  	/* sentinel */
> > >  };
> > >  
> > > @@ -559,13 +574,21 @@ static int vf610_adc_read_data(struct vf610_adc *info)
> > >  
> > >  static irqreturn_t vf610_adc_isr(int irq, void *dev_id)
> > >  {
> > > -	struct vf610_adc *info = (struct vf610_adc *)dev_id;
> > > +	struct iio_dev *indio_dev = (struct iio_dev *)dev_id;
> > > +	struct vf610_adc *info = iio_priv(indio_dev);
> > >  	int coco;
> > >  
> > >  	coco = readl(info->regs + VF610_REG_ADC_HS);
> > >  	if (coco & VF610_ADC_HS_COCO0) {
> > >  		info->value = vf610_adc_read_data(info);
> > > -		complete(&info->completion);
> > > +		if (iio_buffer_enabled(indio_dev)) {
> > > +			info->buffer[0] = info->value;
> > > +			writel(0, info->regs + VF610_REG_ADC_HS);
> > > +			iio_push_to_buffers_with_timestamp(indio_dev,
> > > +					info->buffer, iio_get_time_ns());
> > > +			iio_trigger_notify_done(indio_dev->trig);
> > > +		} else
> > > +			complete(&info->completion);
> > >  	}
> > >  
> > >  	return IRQ_HANDLED;
> > > @@ -612,6 +635,9 @@ static int vf610_read_raw(struct iio_dev *indio_dev,
> > >  	switch (mask) {
> > >  	case IIO_CHAN_INFO_RAW:
> > >  	case IIO_CHAN_INFO_PROCESSED:
> > > +		if (iio_buffer_enabled(indio_dev))
> > > +			return -EBUSY;
> > > +
> > >  		mutex_lock(&indio_dev->mlock);
> > >  		reinit_completion(&info->completion);
> > >  
> > > @@ -694,6 +720,81 @@ static int vf610_write_raw(struct iio_dev *indio_dev,
> > >  	return -EINVAL;
> > >  }
> > >  
> > > +static int vf610_adc_buffer_postenable(struct iio_dev *indio_dev)
> > > +{
> > > +	struct vf610_adc *info = iio_priv(indio_dev);
> > > +	unsigned int channel;
> > > +	int ret;
> > > +	int val;
> > > +
> > > +	ret = iio_triggered_buffer_postenable(indio_dev);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	val = readl(info->regs + VF610_REG_ADC_GC);
> > > +	val |= VF610_ADC_ADCON;
> > > +	writel(val, info->regs + VF610_REG_ADC_GC);
> > > +
> > > +	channel = find_first_bit(indio_dev->active_scan_mask,
> > > +						indio_dev->masklength);
> > > +
> > > +	val = VF610_ADC_ADCHC(channel);
> > > +	val |= VF610_ADC_AIEN;
> > > +
> > > +	writel(val, info->regs + VF610_REG_ADC_HC0);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int vf610_adc_buffer_postdisable(struct iio_dev *indio_dev)
> > > +{
> > > +	struct vf610_adc *info = iio_priv(indio_dev);
> > > +	unsigned int hc_cfg = 0;
> > > +	int val;
> > > +
> > > +	val = readl(info->regs + VF610_REG_ADC_GC);
> > > +	val &= ~VF610_ADC_ADCON;
> > > +	writel(val, info->regs + VF610_REG_ADC_GC);
> > > +
> > > +	hc_cfg |= VF610_ADC_CONV_DISABLE;
> > > +	hc_cfg &= ~VF610_ADC_AIEN;
> > > +
> > > +	writel(hc_cfg, info->regs + VF610_REG_ADC_HC0);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int vf610_adc_update_scan_mode(struct iio_dev *indio_dev,
> > > +	const unsigned long *scan_mask)
> > > +{
> > > +	struct vf610_adc *info = iio_priv(indio_dev);
> > > +
> > > +	kfree(info->buffer);
> > 
> > only one channel can be read (onehot), why not use a fixed size buffer 
> > (one u16, perhaps as a local variable in _adc_isr()?
> 
> fixed size buffer might still be a good idea but it has to be 16 bytes:
> one u16 + padding (6 bytes) + timestamp (8 bytes aligned at 8 bytes 
> offset)
>  

Will implement, test it and change accordingly.

Thanks & Regards,
Sanchayan.

(snip)
