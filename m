Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34163 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954AbbHEIDx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Aug 2015 04:03:53 -0400
Date: Wed, 5 Aug 2015 13:30:45 +0530
From: maitysanchayan@gmail.com
To: Duan Andy <fugang.duan@freescale.com>
Cc: "jic23@kernel.org" <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"stefan@agner.ch" <stefan@agner.ch>,
	"hofrat@osadl.org" <hofrat@osadl.org>,
	"sanjeev_sharma@mentor.com" <sanjeev_sharma@mentor.com>,
	Fabio Estevam <Fabio.Estevam@freescale.com>,
	"knaack.h@gmx.de" <knaack.h@gmx.de>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"antoine.tenart@free-electrons.com"
	<antoine.tenart@free-electrons.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] iio: adc: vf610: Add IIO buffer support for Vybrid ADC
Message-ID: <20150805080044.GB17211@Sanchayan-Arch.toradex.int>
References: <cover.1438610517.git.maitysanchayan@gmail.com>
 <1f11be7d7bc1c3fcebf7d0bcf274f1fcbef35999.1438610517.git.maitysanchayan@gmail.com>
 <BN3PR0301MB12191A12387C829F111B612BF5760@BN3PR0301MB1219.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <BN3PR0301MB12191A12387C829F111B612BF5760@BN3PR0301MB1219.namprd03.prod.outlook.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

On 15-08-04 03:18:46, Duan Andy wrote:
> From: Sanchayan Maity <maitysanchayan@gmail.com> Sent: Monday, August 03, 2015 11:10 PM
> > To: jic23@kernel.org; linux-iio@vger.kernel.org
> > Cc: stefan@agner.ch; Duan Fugang-B38611; hofrat@osadl.org;
> > sanjeev_sharma@mentor.com; Estevam Fabio-R49496; knaack.h@gmx.de;
> > lars@metafoo.de; pmeerw@pmeerw.net; antoine.tenart@free-electrons.com;
> > linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > Sanchayan Maity
> > Subject: [PATCH] iio: adc: vf610: Add IIO buffer support for Vybrid ADC
> > 
> > This patch adds support for IIO buffer to the Vybrid ADC driver.
> > IIO triggered buffer infrastructure along with iio sysfs trigger is used
> > to leverage continuous sampling support provided by the ADC block.
> > 
> > Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> > ---
> >  drivers/iio/adc/Kconfig     |   4 ++
> >  drivers/iio/adc/vf610_adc.c | 122
> > +++++++++++++++++++++++++++++++++++++++++---
> >  2 files changed, 120 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig index
> > 7c55658..4661241 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -337,6 +337,10 @@ config TWL6030_GPADC  config VF610_ADC
> >  	tristate "Freescale vf610 ADC driver"
> >  	depends on OF
> > +	select IIO_BUFFER
> > +	select IIO_TRIGGER
> > +	select IIO_SYSFS_TRIGGER
> > +	select IIO_TRIGGERED_BUFFER
> >  	help
> >  	  Say yes here to support for Vybrid board analog-to-digital
> > converter.
> >  	  Since the IP is used for i.MX6SLX, the driver also support
> > i.MX6SLX.
> > diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
> > index 23b8fb9..af72b9a 100644
> > --- a/drivers/iio/adc/vf610_adc.c
> > +++ b/drivers/iio/adc/vf610_adc.c
> > @@ -34,8 +34,11 @@
> >  #include <linux/err.h>
> > 
> >  #include <linux/iio/iio.h>
> > +#include <linux/iio/buffer.h>
> >  #include <linux/iio/sysfs.h>
> > -#include <linux/iio/driver.h>
> > +#include <linux/iio/trigger.h>
> > +#include <linux/iio/trigger_consumer.h> #include
> > +<linux/iio/triggered_buffer.h>
> > 
> >  /* This will be the driver name the kernel reports */  #define
> > DRIVER_NAME "vf610-adc"
> > @@ -170,6 +173,7 @@ struct vf610_adc {
> >  	u32 sample_freq_avail[5];
> > 
> >  	struct completion completion;
> > +	u16 *buffer;
> >  };
> > 
> >  static const u32 vf610_hw_avgs[] = { 1, 4, 8, 16, 32 }; @@ -505,12
> > +509,22 @@ static const struct iio_chan_spec_ext_info vf610_ext_info[] =
> > {
> >  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
> >  				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> >  	.ext_info = vf610_ext_info,				\
> > +	.address = (_idx),				\
> > +	.scan_index = (_idx),			\
> > +	.scan_type.sign = 'u',			\
> > +	.scan_type.realbits = 12,		\
> > +	.scan_type.storagebits = 16,	\
> >  }
> > 
> >  #define VF610_ADC_TEMPERATURE_CHAN(_idx, _chan_type) {	\
> >  	.type = (_chan_type),	\
> >  	.channel = (_idx),		\
> >  	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),	\
> > +	.address = (_idx),						\
> > +	.scan_index = (_idx),					\
> > +	.scan_type.sign = 'u',					\
> > +	.scan_type.realbits = 12,				\
> > +	.scan_type.storagebits = 16,			\
> >  }
> > 
> >  static const struct iio_chan_spec vf610_adc_iio_channels[] = { @@ -531,6
> > +545,7 @@ static const struct iio_chan_spec vf610_adc_iio_channels[] = {
> >  	VF610_ADC_CHAN(14, IIO_VOLTAGE),
> >  	VF610_ADC_CHAN(15, IIO_VOLTAGE),
> >  	VF610_ADC_TEMPERATURE_CHAN(26, IIO_TEMP),
> > +	IIO_CHAN_SOFT_TIMESTAMP(32),
> >  	/* sentinel */
> >  };
> > 
> > @@ -559,13 +574,21 @@ static int vf610_adc_read_data(struct vf610_adc
> > *info)
> > 
> >  static irqreturn_t vf610_adc_isr(int irq, void *dev_id)  {
> > -	struct vf610_adc *info = (struct vf610_adc *)dev_id;
> > +	struct iio_dev *indio_dev = (struct iio_dev *)dev_id;
> > +	struct vf610_adc *info = iio_priv(indio_dev);
> >  	int coco;
> > 
> >  	coco = readl(info->regs + VF610_REG_ADC_HS);
> >  	if (coco & VF610_ADC_HS_COCO0) {
> >  		info->value = vf610_adc_read_data(info);
> > -		complete(&info->completion);
> > +		if (iio_buffer_enabled(indio_dev)) {
> > +			info->buffer[0] = info->value;
> > +			writel(0, info->regs + VF610_REG_ADC_HS);
> The register is read only. After ADC_Rn is read, the coco bit is cleared.

Right. This crept in from a different implementation which I was trying with
PDB and perhaps a wrong interpretation of the TRM.

Will fix.

Regards,
Sanchayan.

(snip)
