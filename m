Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:56433 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753227AbbFRIJr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 18 Jun 2015 04:09:47 -0400
From: "Breana, Tiberiu A" <tiberiu.a.breana@intel.com>
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH] iio: light: STK3310: un-invert proximity values
Date: Thu, 18 Jun 2015 08:09:43 +0000
Message-ID: <4586F61A4A291F4DA44D32824E7C0F40221534F4@IRSMSX109.ger.corp.intel.com>
References: <1434539393-1451-1-git-send-email-tiberiu.a.breana@intel.com>
 <alpine.DEB.2.02.1506171516090.2489@pmeerw.net>
In-Reply-To: <alpine.DEB.2.02.1506171516090.2489@pmeerw.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> -----Original Message-----
> From: Peter Meerwald [mailto:pmeerw@pmeerw.net]
> Sent: Wednesday, June 17, 2015 4:18 PM
> To: Breana, Tiberiu A
> Cc: linux-iio@vger.kernel.org
> Subject: Re: [PATCH] iio: light: STK3310: un-invert proximity values
> 
> 
> > In accordance with the recent ABI changes, STK3310's proximity
> > readings should be un-inversed in order to return low values for
> > far-away objects and high values for close ones.
> 
> the patch does a lot more than it advertises in the text above; I think it needs
> to be split up
> 
> thanks, p.
> 

Peter, how would you see this patch split? A patch that deals with the raw readings and max values and another that switches the event types?
Or should I rather just write a more detailed commit message?

Thanks,
Tiberiu

> > Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
> > ---
> >  drivers/iio/light/stk3310.c | 53
> > +++++++++++++++------------------------------
> >  1 file changed, 17 insertions(+), 36 deletions(-)
> >
> > diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
> > index fee4297..c1a2182 100644
> > --- a/drivers/iio/light/stk3310.c
> > +++ b/drivers/iio/light/stk3310.c
> > @@ -43,7 +43,6 @@
> >  #define STK3311_CHIP_ID_VAL			0x1D
> >  #define STK3310_PSINT_EN			0x01
> >  #define STK3310_PS_MAX_VAL			0xFFFF
> > -#define STK3310_THRESH_MAX			0xFFFF
> >
> >  #define STK3310_DRIVER_NAME			"stk3310"
> >  #define STK3310_REGMAP_NAME			"stk3310_regmap"
> > @@ -84,15 +83,13 @@ static const struct reg_field
> stk3310_reg_field_flag_psint =
> >  				REG_FIELD(STK3310_REG_FLAG, 4, 4);  static
> const struct reg_field
> > stk3310_reg_field_flag_nf =
> >  				REG_FIELD(STK3310_REG_FLAG, 0, 0);
> > -/*
> > - * Maximum PS values with regard to scale. Used to export the 'inverse'
> > - * PS value (high values for far objects, low values for near objects).
> > - */
> > +
> > +/* Estimate maximum proximity values with regard to measurement
> > +scale. */
> >  static const int stk3310_ps_max[4] = {
> > -	STK3310_PS_MAX_VAL / 64,
> > -	STK3310_PS_MAX_VAL / 16,
> > -	STK3310_PS_MAX_VAL /  4,
> > -	STK3310_PS_MAX_VAL,
> > +	STK3310_PS_MAX_VAL / 640,
> > +	STK3310_PS_MAX_VAL / 160,
> > +	STK3310_PS_MAX_VAL /  40,
> > +	STK3310_PS_MAX_VAL /  10
> >  };
> >
> >  static const int stk3310_scale_table[][2] = { @@ -128,14 +125,14 @@
> > static const struct iio_event_spec stk3310_events[] = {
> >  	/* Proximity event */
> >  	{
> >  		.type = IIO_EV_TYPE_THRESH,
> > -		.dir = IIO_EV_DIR_FALLING,
> > +		.dir = IIO_EV_DIR_RISING,
> >  		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> >  				 BIT(IIO_EV_INFO_ENABLE),
> >  	},
> >  	/* Out-of-proximity event */
> >  	{
> >  		.type = IIO_EV_TYPE_THRESH,
> > -		.dir = IIO_EV_DIR_RISING,
> > +		.dir = IIO_EV_DIR_FALLING,
> >  		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
> >  				 BIT(IIO_EV_INFO_ENABLE),
> >  	},
> > @@ -205,23 +202,16 @@ static int stk3310_read_event(struct iio_dev
> *indio_dev,
> >  	u8 reg;
> >  	u16 buf;
> >  	int ret;
> > -	unsigned int index;
> >  	struct stk3310_data *data = iio_priv(indio_dev);
> >
> >  	if (info != IIO_EV_INFO_VALUE)
> >  		return -EINVAL;
> >
> > -	/*
> > -	 * Only proximity interrupts are implemented at the moment.
> > -	 * Since we're inverting proximity values, the sensor's 'high'
> > -	 * threshold will become our 'low' threshold, associated with
> > -	 * 'near' events. Similarly, the sensor's 'low' threshold will
> > -	 * be our 'high' threshold, associated with 'far' events.
> > -	 */
> > +	/* Only proximity interrupts are implemented at the moment. */
> >  	if (dir == IIO_EV_DIR_RISING)
> > -		reg = STK3310_REG_THDL_PS;
> > -	else if (dir == IIO_EV_DIR_FALLING)
> >  		reg = STK3310_REG_THDH_PS;
> > +	else if (dir == IIO_EV_DIR_FALLING)
> > +		reg = STK3310_REG_THDL_PS;
> >  	else
> >  		return -EINVAL;
> >
> > @@ -232,8 +222,7 @@ static int stk3310_read_event(struct iio_dev
> *indio_dev,
> >  		dev_err(&data->client->dev, "register read failed\n");
> >  		return ret;
> >  	}
> > -	regmap_field_read(data->reg_ps_gain, &index);
> > -	*val = swab16(stk3310_ps_max[index] - buf);
> > +	*val = swab16(buf);
> >
> >  	return IIO_VAL_INT;
> >  }
> > @@ -257,13 +246,13 @@ static int stk3310_write_event(struct iio_dev
> *indio_dev,
> >  		return -EINVAL;
> >
> >  	if (dir == IIO_EV_DIR_RISING)
> > -		reg = STK3310_REG_THDL_PS;
> > -	else if (dir == IIO_EV_DIR_FALLING)
> >  		reg = STK3310_REG_THDH_PS;
> > +	else if (dir == IIO_EV_DIR_FALLING)
> > +		reg = STK3310_REG_THDL_PS;
> >  	else
> >  		return -EINVAL;
> >
> > -	buf = swab16(stk3310_ps_max[index] - val);
> > +	buf = swab16(val);
> >  	ret = regmap_bulk_write(data->regmap, reg, &buf, 2);
> >  	if (ret < 0)
> >  		dev_err(&client->dev, "failed to set PS threshold!\n"); @@ -
> 334,14
> > +323,6 @@ static int stk3310_read_raw(struct iio_dev *indio_dev,
> >  			return ret;
> >  		}
> >  		*val = swab16(buf);
> > -		if (chan->type == IIO_PROXIMITY) {
> > -			/*
> > -			 * Invert the proximity data so we return low values
> > -			 * for close objects and high values for far ones.
> > -			 */
> > -			regmap_field_read(data->reg_ps_gain, &index);
> > -			*val = stk3310_ps_max[index] - *val;
> > -		}
> >  		mutex_unlock(&data->lock);
> >  		return IIO_VAL_INT;
> >  	case IIO_CHAN_INFO_INT_TIME:
> > @@ -581,8 +562,8 @@ static irqreturn_t stk3310_irq_event_handler(int
> irq, void *private)
> >  	}
> >  	event = IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 1,
> >  				     IIO_EV_TYPE_THRESH,
> > -				     (dir ? IIO_EV_DIR_RISING :
> > -					    IIO_EV_DIR_FALLING));
> > +				     (dir ? IIO_EV_DIR_FALLING :
> > +					    IIO_EV_DIR_RISING));
> >  	iio_push_event(indio_dev, event, data->timestamp);
> >
> >  	/* Reset the interrupt flag */
> >
> 
> --
> 
> Peter Meerwald
> +43-664-2444418 (mobile)
