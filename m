Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751885AbeCCO5d (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Mar 2018 09:57:33 -0500
Date: Sat, 3 Mar 2018 14:57:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jeff LaBundy <jeff@labundy.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: lv0104cs: Add support for LV0104CS light
 sensor
Message-ID: <20180303145729.40142639@archlinux>
In-Reply-To: <20180225023808.GA2301@labundy.com>
References: <1518620285-1893-1-git-send-email-jeff@labundy.com>
        <1518978307-7108-1-git-send-email-jeff@labundy.com>
        <20180224120259.63e62d3c@archlinux>
        <20180225023808.GA2301@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 24 Feb 2018 20:38:08 -0600
Jeff LaBundy <jeff@labundy.com> wrote:

<snip>
> > > +static int lv0104cs_get_lux(struct lv0104cs_private *lv0104cs,
> > > +				int *val, int *val2)
> > > +{
> > > +	u8 regval = LV0104CS_REGVAL_MEASURE;
> > > +	u16 adc_output;
> > > +	int ret;
> > > +
> > > +	regval |= lv0104cs_scales[lv0104cs->scale].regval;
> > > +	regval |= lv0104cs_int_times[lv0104cs->int_time].regval;
> > > +	ret = lv0104cs_write_reg(lv0104cs, regval);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/* wait for integration time to pass (with margin) */
> > > +	switch (lv0104cs->int_time) {
> > > +	case LV0104CS_INTEG_12_5MS:
> > > +		msleep(50);
> > > +		break;
> > > +
> > > +	case LV0104CS_INTEG_100MS:
> > > +		msleep(150);
> > > +		break;
> > > +
> > > +	case LV0104CS_INTEG_200MS:
> > > +		msleep(250);
> > > +		break;
> > > +
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	ret = lv0104cs_read_adc(lv0104cs, &adc_output);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = lv0104cs_write_reg(lv0104cs, LV0104CS_REGVAL_SLEEP);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/* convert ADC output to lux */
> > > +	switch (lv0104cs->scale) {
> > > +	case LV0104CS_SCALE_0_25X:  
> > Hmm.  Given how simple the scale application is and the fact
> > that we aren't trying dynamic control (which makes this complex)
> > we 'could' go for the IIO default option of providing the raw
> > value and letting userspace deal with the calibration.
> > 
> > However, this is a slow device (fairly anyway) so the
> > cost of conversion is trivial and we are unlikely to ever want
> > to bother with a buffered interface on this I think things
> > are fine as you have them.  
> 
> Sure thing, I'll leave this as-is. The reason for having chosen
> PROCESSED is because the device's ADC output already includes the
> effects of CALIBSCALE, so the device technically does not offer
> a RAW output on its own. Therefore I have presented a PROCESSED
> value that includes the SCALE that was in place when the measurement
> was captured.
It's normal for a device to already include the effect of a
calibscale as they are often done by tweaking a DAC in the
analog section of the sensor circuit.  So don't let that
argue against providing a _RAW value.

The answer is still fine though, just thought I'd comment on the
reasoning ;)

<snip>
