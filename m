Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:36965 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753903AbbHJGiV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 10 Aug 2015 02:38:21 -0400
Date: Mon, 10 Aug 2015 12:05:08 +0530
From: maitysanchayan@gmail.com
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, stefan@agner.ch, B38611@freescale.com,
	hofrat@osadl.org, sanjeev_sharma@mentor.com,
	fabio.estevam@freescale.com, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, antoine.tenart@free-electrons.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] iio: adc: vf610: Add IIO buffer support for Vybrid ADC
Message-ID: <20150810063508.GA2273@Sanchayan-Arch.toradex.int>
References: <cover.1438775572.git.maitysanchayan@gmail.com>
 <1bb1f290da601bbda41875a92ba6e983b423d7b0.1438775572.git.maitysanchayan@gmail.com>
 <55C6125B.1060103@kernel.org>
 <20150808172200.GA2758@Sanchayan-Arch>
 <55C64E68.8010500@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <55C64E68.8010500@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

On 15-08-08 19:46:00, Jonathan Cameron wrote:
> On 08/08/15 18:22, maitysanchayan@gmail.com wrote:
> > Hello Jonathan,
> > 
> > On 15-08-08 15:29:47, Jonathan Cameron wrote:
> >> On 05/08/15 13:10, Sanchayan Maity wrote:
> >>> This patch adds support for IIO buffer to the Vybrid ADC driver.
> >>> IIO triggered buffer infrastructure along with iio sysfs trigger
> >>> is used to leverage continuous sampling support provided by the
> >>> ADC block.
> >> Looking good.  Just a couple more bits and pieces inline from me.
> >> One or two of which aren't corrected from Peter's review of v1.
> >>
> >> I will want Fugang Dong's ack / review tag on the final version
> >> before applying it however.
> > 
> > Sure.
> > 
> >> This driver is some distance form my area of expertise!
> > 
> > I doubt :).
> > 
> >>
> >> Jonathan
> >>>
> >>> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> >>> ---
> >>>  drivers/iio/adc/Kconfig     |   4 ++
> >>>  drivers/iio/adc/vf610_adc.c | 107 +++++++++++++++++++++++++++++++++++++++++---
> >>>  2 files changed, 105 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> >>> index 7c55658..4661241 100644
> >>> --- a/drivers/iio/adc/Kconfig
> >>> +++ b/drivers/iio/adc/Kconfig
> >>> @@ -337,6 +337,10 @@ config TWL6030_GPADC
> >>>  config VF610_ADC
> >>>  	tristate "Freescale vf610 ADC driver"
> >>>  	depends on OF
> >>> +	select IIO_BUFFER
> >>> +	select IIO_TRIGGER
> >>> +	select IIO_SYSFS_TRIGGER
> >> Unless I missed something there is no dependency on this particular
> >> trigger (it just happens to be the one you've been testing with I guess).
> >> Could be driven from a hardware trigger belonging to another device for
> >> example.
> > 
> > Yes right in a way. Right now we do not provide or there is no provision
> > for hardware triggers. On the Vybrid, the Peripheral Delay Block (PDB)
> > does the job of providing support for software and hardware triggers. PDB
> > support is not yet there in Linux however. 
> Not supplying a trigger is fine, but any trigger (that allows other devices
> to bind to it) will be fine.

Ok.

> > 
> > There is also the question of where the Vybrid PDB driver would belong
> > to? In the TRM it is put in the timers but the kernel has no generic timer
> > framework that I am aware of.
> It's been debated a number of times, but no one has ever written one.
> Not seen anything recently on this topic..  Lars, you seen anything?
> (the blackfin-timer trigger is similar to what you are describing I think).
> 
> > After some internal reviews we decided to
> > do a platform driver which provided functions ADC driver could called into.
> Does rather feel like there ought to be at least a standard home for these.
> Might be worth asking the arm-soc guys...
> > 
> > I have a patchset ready which provides trigger support using PDB however
> > configuring the PDB properly has proven to be tricky. While it works but
> > not reliably with multiple channels and it would be a while before I get
> > that working and post that patchset. So kind of stalled there and just
> > because of two registers which need to be written with the correct value
> > :). For what it's worth if someone comes across this, some discussion
> > here [1] along with patches. (Note however those are a bit old patches
> > not exactly my new work).
> > 
> > Sorry for digressing from the topic. Anyways so the idea was to provide
> > sysfs triggers as default for using this continuous sampling. Later the
> > driver may provide additional triggers. So for now I added the sysfs
> > trigger as a select option so that a user won't have to recompile the
> > kernel for using the buffers with continuous sampling.
> It's a policy decision so should really be left to the distro builders.
> There are lots of possible triggers out there (though sysfs might be
> the most likely one!)
> 
> Hence don't put the select there in Kconfig.  We should shortly have
> Daniel's update to the patches for the high resolution timer
> which would give another obvious choice for starters.

Alright. Will drop that iio sysfs tigger select from the Kconfig.

> 
> I doubt many distros build without the sysfs triggers but with other IIO
> stuff.
> 
> > 
> >>
> >>> +	select IIO_TRIGGERED_BUFFER
> >>>  	help
> >>>  	  Say yes here to support for Vybrid board analog-to-digital converter.
> >>>  	  Since the IP is used for i.MX6SLX, the driver also support i.MX6SLX.
> >>> diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
> >>> index 23b8fb9..97cb2ed 100644
> >>> --- a/drivers/iio/adc/vf610_adc.c
> >>> +++ b/drivers/iio/adc/vf610_adc.c
> >>> @@ -34,8 +34,11 @@
> >>>  #include <linux/err.h>
> >>>  
> >>>  #include <linux/iio/iio.h>
> >>> +#include <linux/iio/buffer.h>
> >>>  #include <linux/iio/sysfs.h>
> >>> -#include <linux/iio/driver.h>
> >>> +#include <linux/iio/trigger.h>
> >>> +#include <linux/iio/trigger_consumer.h>
> >>> +#include <linux/iio/triggered_buffer.h>
> >>>  
> >>>  /* This will be the driver name the kernel reports */
> >>>  #define DRIVER_NAME "vf610-adc"
> >>> @@ -170,6 +173,7 @@ struct vf610_adc {
> >>>  	u32 sample_freq_avail[5];
> >>>  
> >>>  	struct completion completion;
> >>> +	u16 buffer[2];
> >> Note the requirements on the buffer provided to
> >> iio_push_to_buffers_with_timestamp
> >> Needs to be u16 buffer[8] to allow for the aligned 64bit (4 word) timestamp.
> >>
> >> Peter pointed this out in his follow up email and you said you'd implement
> >> it.. Guessing this got lost somewhere.
> > 
> > No, I meant to implement what Peter recommended but I guess I did not completely
> > grasp what he intended. Sorry about that. Will fix this and ask further if in
> > more doubts.
> > 
> >>
> >>
> >>>  };
> >>>  
> >>>  static const u32 vf610_hw_avgs[] = { 1, 4, 8, 16, 32 };
> >>> @@ -505,12 +509,22 @@ static const struct iio_chan_spec_ext_info vf610_ext_info[] = {
> >>>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
> >>>  				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> >>>  	.ext_info = vf610_ext_info,				\
> >>> +	.address = (_idx),				\
> >>> +	.scan_index = (_idx),			\
> >>> +	.scan_type.sign = 'u',			\
> >>> +	.scan_type.realbits = 12,		\
> >>> +	.scan_type.storagebits = 16,	\
> >>>  }
> >>>  
> >>>  #define VF610_ADC_TEMPERATURE_CHAN(_idx, _chan_type) {	\
> >>>  	.type = (_chan_type),	\
> >>>  	.channel = (_idx),		\
> >>>  	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),	\
> >>> +	.address = (_idx),						\
> >>> +	.scan_index = (_idx),					\
> >> .scan_type = {
> >> 	   .sign = 'u',
> >> 	   etc.
> >>
> >> Peter picked up on this..
> > 
> > Sorry yes missed that. Will definitely fix.
> > 
> >>
> >>> +	.scan_type.sign = 'u',					\
> >>> +	.scan_type.realbits = 12,				\
> >>> +	.scan_type.storagebits = 16,			\
> >>>  }
> >>>  
> >>>  static const struct iio_chan_spec vf610_adc_iio_channels[] = {
> >>> @@ -531,6 +545,7 @@ static const struct iio_chan_spec vf610_adc_iio_channels[] = {
> >>>  	VF610_ADC_CHAN(14, IIO_VOLTAGE),
> >>>  	VF610_ADC_CHAN(15, IIO_VOLTAGE),
> >>>  	VF610_ADC_TEMPERATURE_CHAN(26, IIO_TEMP),
> >>> +	IIO_CHAN_SOFT_TIMESTAMP(32),
> >> It's bit extreme throwing it out at scan_index 32.  Is there a reason
> >> to think that migh be neccesary?  Mind you, why is the temperature
> >> channel down at 26?  Are we dealing with a set of reserved real channels
> >> inbetween?
> > 
> > 
> > The temperature channel is the 26th channel and there are some reserved
> > channels in between. 31st is the channel which acts as a conversion
> > disabled setting. So I put the timestamp at index 32.
> Fair enough if weird ;)
> > 
> > 
> >>>  	/* sentinel */
> >>>  };
> >>>  
> >>> @@ -559,13 +574,20 @@ static int vf610_adc_read_data(struct vf610_adc *info)
> >>>  
> >>>  static irqreturn_t vf610_adc_isr(int irq, void *dev_id)
> >>>  {
> >>> -	struct vf610_adc *info = (struct vf610_adc *)dev_id;
> >>> +	struct iio_dev *indio_dev = (struct iio_dev *)dev_id;
> >>> +	struct vf610_adc *info = iio_priv(indio_dev);
> >>>  	int coco;
> >>>  
> >>>  	coco = readl(info->regs + VF610_REG_ADC_HS);
> >>>  	if (coco & VF610_ADC_HS_COCO0) {
> >>>  		info->value = vf610_adc_read_data(info);
> >>
> >> I'd be tempted to make the non buffered path also use
> >> info->bufffer[0] and drop info->value entirely.
> >> A more invasive patch, but a cleaner resulting code (slightly!)
> > 
> > I did think of that but decided against it as I wanted the changes
> > to as less invasive as possible making only the necessary changes
> > and keeping the old code as is.
> You could do this then clean up in a follow up patch which would be
> really easy to review.

Ok. Will implement the same with a follow up second patch in the third
revision.

- Sanchayan.

> > 
> >>> -		complete(&info->completion);
> >>> +		if (iio_buffer_enabled(indio_dev)) {
> >>> +			info->buffer[0] = info->value;
> >>> +			iio_push_to_buffers_with_timestamp(indio_dev,
> >>> +					info->buffer, iio_get_time_ns());
> >>> +			iio_trigger_notify_done(indio_dev->trig);
> >>> +		} else
> >>> +			complete(&info->completion);
> >>>  	}
> >>>  
> >>>  	return IRQ_HANDLED;
> >>> @@ -612,6 +634,9 @@ static int vf610_read_raw(struct iio_dev *indio_dev,
> >>>  	switch (mask) {
> >>>  	case IIO_CHAN_INFO_RAW:
> >>>  	case IIO_CHAN_INFO_PROCESSED:
> >>
> >> To avoid possible races this check should be done under the mlock
> > 
> > Thanks for picking this. Somehow I remember seeing it outside of the
> > mlock. However grepping again shows otherwise. Will fix.
> > 
> > .
> >>> +		if (iio_buffer_enabled(indio_dev))
> >>> +			return -EBUSY;
> >>> +
> >>>  		mutex_lock(&indio_dev->mlock);
> >>>  		reinit_completion(&info->completion);
> >>>  
> >>> @@ -694,6 +719,68 @@ static int vf610_write_raw(struct iio_dev *indio_dev,
> >>>  	return -EINVAL;
> >>>  }
> >>>  
> >>> +static int vf610_adc_buffer_postenable(struct iio_dev *indio_dev)
> >>> +{
> >>> +	struct vf610_adc *info = iio_priv(indio_dev);
> >>> +	unsigned int channel;
> >>> +	int ret;
> >>> +	int val;
> >>> +
> >>> +	ret = iio_triggered_buffer_postenable(indio_dev);
> >>> +	if (ret)
> >>> +		return ret;
> >>> +
> >>> +	val = readl(info->regs + VF610_REG_ADC_GC);
> >>> +	val |= VF610_ADC_ADCON;
> >>> +	writel(val, info->regs + VF610_REG_ADC_GC);
> >>> +
> >>> +	channel = find_first_bit(indio_dev->active_scan_mask,
> >>> +						indio_dev->masklength);
> >>> +
> >>> +	val = VF610_ADC_ADCHC(channel);
> >>> +	val |= VF610_ADC_AIEN;
> >>> +
> >>> +	writel(val, info->regs + VF610_REG_ADC_HC0);
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static int vf610_adc_buffer_postdisable(struct iio_dev *indio_dev)
> >>> +{
> >>> +	struct vf610_adc *info = iio_priv(indio_dev);
> >>> +	unsigned int hc_cfg = 0;
> >>> +	int val;
> >>> +
> >>> +	val = readl(info->regs + VF610_REG_ADC_GC);
> >>> +	val &= ~VF610_ADC_ADCON;
> >>> +	writel(val, info->regs + VF610_REG_ADC_GC);
> >>> +
> >>> +	hc_cfg |= VF610_ADC_CONV_DISABLE;
> >>> +	hc_cfg &= ~VF610_ADC_AIEN;
> >>> +
> >>> +	writel(hc_cfg, info->regs + VF610_REG_ADC_HC0);
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static const struct iio_buffer_setup_ops iio_triggered_buffer_setup_ops = {
> >>> +	.postenable = &vf610_adc_buffer_postenable,
> >>> +	.predisable = &iio_triggered_buffer_predisable,
> >>> +	.postdisable = &vf610_adc_buffer_postdisable,
> >>> +	.validate_scan_mask = &iio_validate_scan_mask_onehot,
> >>> +};
> >>> +
> >>> +static int vf610_adc_buffer_init(struct iio_dev *indio_dev)
> >>> +{
> >>> +	return iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
> >>> +		NULL, &iio_triggered_buffer_setup_ops);
> >>> +}
> >>> +
> >>> +static void vf610_adc_buffer_remove(struct iio_dev *indio_dev)
> >>> +{
> >>> +	iio_triggered_buffer_cleanup(indio_dev);
> >>> +}
> >> These to wrappers seem a little superflous. I'd have just put the code
> >> inline, but it's obviously a matter of personal taste and I don't care
> >> that much!
> > 
> > Ok. I do not have strong opinions on this. I just tried to follow how the
> > at91 adc code did it considering it as a good example. Will drop it.
> > 
> >>
> >>> +
> >>>  static int vf610_adc_reg_access(struct iio_dev *indio_dev,
> >>>  			unsigned reg, unsigned writeval,
> >>>  			unsigned *readval)
> >>> @@ -753,7 +840,7 @@ static int vf610_adc_probe(struct platform_device *pdev)
> >>>  
> >>>  	ret = devm_request_irq(info->dev, irq,
> >>>  				vf610_adc_isr, 0,
> >>> -				dev_name(&pdev->dev), info);
> >>> +				dev_name(&pdev->dev), indio_dev);
> >>>  	if (ret < 0) {
> >>>  		dev_err(&pdev->dev, "failed requesting irq, irq = %d\n", irq);
> >>>  		return ret;
> >>> @@ -806,15 +893,22 @@ static int vf610_adc_probe(struct platform_device *pdev)
> >>>  	vf610_adc_cfg_init(info);
> >>>  	vf610_adc_hw_init(info);
> >>>  
> >>> +	ret = vf610_adc_buffer_init(indio_dev);
> >>> +	if (ret < 0) {
> >>> +		dev_err(&pdev->dev, "Couldn't initialise the buffer\n");
> >>> +		goto error_iio_device_register;
> >>> +	}
> >>> +
> >>>  	ret = iio_device_register(indio_dev);
> >>>  	if (ret) {
> >>>  		dev_err(&pdev->dev, "Couldn't register the device.\n");
> >>> -		goto error_iio_device_register;
> >>> +		goto error_adc_buffer_init;
> >>>  	}
> >>>  
> >>>  	return 0;
> >>>  
> >>> -
> >>> +error_adc_buffer_init:
> >>> +	vf610_adc_buffer_remove(indio_dev);
> >>>  error_iio_device_register:
> >>>  	clk_disable_unprepare(info->clk);
> >>>  error_adc_clk_enable:
> >>> @@ -829,6 +923,7 @@ static int vf610_adc_remove(struct platform_device *pdev)
> >>>  	struct vf610_adc *info = iio_priv(indio_dev);
> >>>  
> >>>  	iio_device_unregister(indio_dev);
> >>> +	vf610_adc_buffer_remove(indio_dev);
> >>>  	regulator_disable(info->vref);
> >>>  	clk_disable_unprepare(info->clk);
> >>>  
> >>>
> >>
> > 
> > Thanks for the review.
> > 
> > - Sanchayan.
> > 
> > [1]. https://community.freescale.com/thread/357619
> > 
> 
