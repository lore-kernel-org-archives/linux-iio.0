Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36270 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757798AbcJQJpq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Oct 2016 05:45:46 -0400
Received: by mail-pf0-f196.google.com with SMTP id r16so12461226pfg.3
        for <linux-iio@vger.kernel.org>; Mon, 17 Oct 2016 02:45:46 -0700 (PDT)
Date: Mon, 17 Oct 2016 17:45:37 +0800
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, outreachy-kernel@googlegroups.com,
        Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Subject: Re: [PATCH] staging: iio: cdc: ad7746: add additional config defines
Message-ID: <20161017094535.GB2809@Socrates-DK>
References: <1476674510-10734-1-git-send-email-eraretuya@gmail.com>
 <e0a34a65-5443-7fc4-500c-f1b43b1788dc@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e0a34a65-5443-7fc4-500c-f1b43b1788dc@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Oct 17, 2016 at 09:51:07AM +0200, Lars-Peter Clausen wrote:
> On 10/17/2016 05:21 AM, Eva Rachel Retuya wrote:
> > Introduce defines for shifting and mask under the config register for
> > better readability.
> > 
> > Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
> 
> Hi,
> 
> Thanks for the patch. Comments inline.
> 
> > ---
> >  drivers/staging/iio/cdc/ad7746.c | 26 ++++++++++++++++----------
> >  1 file changed, 16 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> > index f41251c..751f0d1 100644
> > --- a/drivers/staging/iio/cdc/ad7746.c
> > +++ b/drivers/staging/iio/cdc/ad7746.c
> > @@ -70,8 +70,12 @@
> >  #define AD7746_EXCSETUP_EXCLVL(x)	(((x) & 0x3) << 0)
> >  
> >  /* Config Register Bit Designations (AD7746_REG_CFG) */
> > -#define AD7746_CONF_VTFS(x)		((x) << 6)
> > -#define AD7746_CONF_CAPFS(x)		((x) << 3)
> > +#define AD7746_CONF_VTFS_SHIFT		6
> > +#define AD7746_CONF_CAPFS_SHIFT		3
> > +#define AD7746_CONF_VTFS_MASK		0x3
> > +#define AD7746_CONF_CAPFS_MASK		0x7
> > +#define AD7746_CONF_VTFS(x)		((x) << AD7746_CONF_VTFS_SHIFT)
> > +#define AD7746_CONF_CAPFS(x)		((x) << AD7746_CONF_CAPFS_SHIFT)
> >  #define AD7746_CONF_MODE_IDLE		(0 << 0)
> >  #define AD7746_CONF_MODE_CONT_CONV	(1 << 0)
> >  #define AD7746_CONF_MODE_SINGLE_CONV	(2 << 0)
> > @@ -224,8 +228,8 @@ static int ad7746_select_channel(struct iio_dev *indio_dev,
> >  	case IIO_CAPACITANCE:
> >  		cap_setup = (chan->address & 0xFF) | AD7746_CAPSETUP_CAPEN;
> >  		vt_setup = chip->vt_setup & ~AD7746_VTSETUP_VTEN;
> > -		delay = ad7746_cap_filter_rate_table[(chip->config >> 3) &
> > -			0x7][1];
> > +		delay = ad7746_cap_filter_rate_table[(chip->config &
> > +			AD7746_CONF_CAPFS_MASK) >> AD7746_CONF_CAPFS_SHIFT][1];
> 
> This flips the order in which the shift and the mask are applied, that will
> break things. But maybe we should change things so that the mask includes
> the offset and use the GENMASK() macro to create them. This would also allow
> to simplify
> 

My bad, I blindly followed the feedback from a recent patch I made on
this driver. I'm aware and wondering why the order got reversed,
should've replied back to that thread.

Anyways, thank you for the feedback. Will send v2 with your proposed
changes.

Eva

> 	chip->config &= ~AD7746_CONF_CAPFS(AD7746_CONF_CAPFS_MASK);
> 
> to
> 
> 	chip->config &= ~AD7746_CONF_CAPFS_MASK;
> 
> I'd also introduce a helper variable to move the index calculation outside
> of the array brackets. It is a bit convoluted the way it is right now.
> 
> Same comment for the similar changes done below.
> 
> >  
> >  		if (chip->capdac_set != chan->channel) {
> >  			ret = i2c_smbus_write_byte_data(chip->client,
> > @@ -246,8 +250,8 @@ static int ad7746_select_channel(struct iio_dev *indio_dev,
> >  	case IIO_TEMP:
> >  		vt_setup = (chan->address & 0xFF) | AD7746_VTSETUP_VTEN;
> >  		cap_setup = chip->cap_setup & ~AD7746_CAPSETUP_CAPEN;
> > -		delay = ad7746_cap_filter_rate_table[(chip->config >> 6) &
> > -			0x3][1];
> > +		delay = ad7746_cap_filter_rate_table[(chip->config &
> > +			AD7746_CONF_VTFS_MASK) >> AD7746_CONF_VTFS_SHIFT][1];
> >  		break;
> >  	default:
> >  		return -EINVAL;
> [...]
> > @@ -636,12 +640,14 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
> >  		switch (chan->type) {
> >  		case IIO_CAPACITANCE:
> >  			*val = ad7746_cap_filter_rate_table[
> > -					(chip->config >> 3) & 0x7][0];
> > +				(chip->config & AD7746_CONF_CAPFS_MASK) >>
> > +					AD7746_CONF_CAPFS_SHIFT][0];
> >  			ret = IIO_VAL_INT;
> >  			break;
> >  		case IIO_VOLTAGE:
> >  			*val = ad7746_vt_filter_rate_table[
> > -					(chip->config >> 6) & 0x3][0];
> > +				(chip->config & AD7746_CONF_VTFS_MASK) >>
> > +					AD7746_CONF_VTFS_SHIFT][0];
> >  			break;
> >  		default:
> >  			ret = -EINVAL;
> > 
> 
