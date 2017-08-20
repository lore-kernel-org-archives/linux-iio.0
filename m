Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40122 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752524AbdHTLFR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 Aug 2017 07:05:17 -0400
Date: Sun, 20 Aug 2017 11:57:30 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH v2 06/11] iio: adc: ti-ads1015: add adequate wait time
 to get correct conversion
Message-ID: <20170820115730.61d0d3bc@archlinux>
In-Reply-To: <20170723123618.3895caea@kernel.org>
References: <1500564267-8613-1-git-send-email-akinobu.mita@gmail.com>
        <1500564267-8613-7-git-send-email-akinobu.mita@gmail.com>
        <20170723123618.3895caea@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 23 Jul 2017 12:36:18 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 21 Jul 2017 00:24:22 +0900
> Akinobu Mita <akinobu.mita@gmail.com> wrote:
> 
> > This driver assumes that the device is operating in the continuous
> > conversion mode which performs the conversion continuously.  So this driver
> > inserts a wait time before reading the conversion register if the
> > configuration is changed from a previous request.
> > 
> > Currently, the wait time is only the period required for a single
> > conversion that is calculated as the reciprocal of the sampling frequency.
> > However we also need to wait for the the previous conversion to complete.
> > Otherwise we probably get the conversion result for the previous
> > configuration when the sampling frequency is lower.
> > 
> > Cc: Daniel Baluta <daniel.baluta@gmail.com>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>  
> Assuming Daniel is happy with these, I propose to take these
> first 6 through the fixes-togreg branch and mark them all for stable.

I changed my mind on this given the late staging in the cycle and
am pushing them all through the togreg branch.  The fixes can then
be picked up by stable post merge window which may be the quickest
route at the moment!

Thanks,

Jonathan
> 
> The rest may well have to wait on those patches coming back
> around and into the togreg branch of iio.git.
> 
> Hence it may be at least a few weeks.
> 
> Jonathan
> > ---
> >  drivers/iio/adc/ti-ads1015.c | 31 +++++++++++++++++++------------
> >  1 file changed, 19 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> > index 1c475e2..9c501e5 100644
> > --- a/drivers/iio/adc/ti-ads1015.c
> > +++ b/drivers/iio/adc/ti-ads1015.c
> > @@ -242,27 +242,34 @@ static
> >  int ads1015_get_adc_result(struct ads1015_data *data, int chan, int *val)
> >  {
> >  	int ret, pga, dr, conv_time;
> > -	bool change;
> > +	unsigned int old, mask, cfg;
> >  
> >  	if (chan < 0 || chan >= ADS1015_CHANNELS)
> >  		return -EINVAL;
> >  
> > +	ret = regmap_read(data->regmap, ADS1015_CFG_REG, &old);
> > +	if (ret)
> > +		return ret;
> > +
> >  	pga = data->channel_data[chan].pga;
> >  	dr = data->channel_data[chan].data_rate;
> > +	mask = ADS1015_CFG_MUX_MASK | ADS1015_CFG_PGA_MASK |
> > +		ADS1015_CFG_DR_MASK;
> > +	cfg = chan << ADS1015_CFG_MUX_SHIFT | pga << ADS1015_CFG_PGA_SHIFT |
> > +		dr << ADS1015_CFG_DR_SHIFT;
> >  
> > -	ret = regmap_update_bits_check(data->regmap, ADS1015_CFG_REG,
> > -				       ADS1015_CFG_MUX_MASK |
> > -				       ADS1015_CFG_PGA_MASK |
> > -				       ADS1015_CFG_DR_MASK,
> > -				       chan << ADS1015_CFG_MUX_SHIFT |
> > -				       pga << ADS1015_CFG_PGA_SHIFT |
> > -				       dr << ADS1015_CFG_DR_SHIFT,
> > -				       &change);
> > -	if (ret < 0)
> > +	cfg = (old & ~mask) | (cfg & mask);
> > +
> > +	ret = regmap_write(data->regmap, ADS1015_CFG_REG, cfg);
> > +	if (ret)
> >  		return ret;
> >  
> > -	if (change || data->conv_invalid) {
> > -		conv_time = DIV_ROUND_UP(USEC_PER_SEC, data->data_rate[dr]);
> > +	if (old != cfg || data->conv_invalid) {
> > +		int dr_old = (old & ADS1015_CFG_DR_MASK) >>
> > +				ADS1015_CFG_DR_SHIFT;
> > +
> > +		conv_time = DIV_ROUND_UP(USEC_PER_SEC, data->data_rate[dr_old]);
> > +		conv_time += DIV_ROUND_UP(USEC_PER_SEC, data->data_rate[dr]);
> >  		usleep_range(conv_time, conv_time + 1);
> >  		data->conv_invalid = false;
> >  	}  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

