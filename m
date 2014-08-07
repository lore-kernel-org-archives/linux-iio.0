Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:41949 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751500AbaHGRrJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 7 Aug 2014 13:47:09 -0400
Date: Thu, 7 Aug 2014 19:47:07 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
cc: Martin Fuzzey <mfuzzey@parkeon.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH V2 1/8] iio: mma8452: Initialise before activating
In-Reply-To: <53E38B62.8010208@kernel.org>
Message-ID: <alpine.DEB.2.01.1408071936430.24683@pmeerw.net>
References: <20140729090128.4618.92936.stgit@localhost> <20140729090131.4618.11083.stgit@localhost> <53E38B62.8010208@kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> > Many of the hardware configuration registers may only be modified while the
> > device is inactive.
> >
> > Currently the probe code first activates the device and then modifies the
> > registers (eg to set the scale). This doesn't actually work but is not
> > noticed since the scale used is the default value.
> >
> > While at it also issue a hardware reset command at probe time.
> >
> > Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
> Looks fine to me but I'd like an OK from Peter for this series.

looks good, no objection, I haven't test yet however

patch 1/8 is a bug fix but not worth for -stable

in patch 2, the local variable ret could be dropped and replaced with 
returns

patch 3, what is the local variable supported_interrupts good for?

patch 6/8 still has wrong subject: io -> iio

> >  drivers/iio/accel/mma8452.c |   39 ++++++++++++++++++++++++++++++++++-----
> >  1 file changed, 34 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> > index 3c12d49..04a4f34 100644
> > --- a/drivers/iio/accel/mma8452.c
> > +++ b/drivers/iio/accel/mma8452.c
> > @@ -32,6 +32,7 @@
> >  #define MMA8452_OFF_Z 0x31
> >  #define MMA8452_CTRL_REG1 0x2a
> >  #define MMA8452_CTRL_REG2 0x2b
> > +#define MMA8452_CTRL_REG2_RST		BIT(6)
> >
> >  #define MMA8452_STATUS_DRDY (BIT(2) | BIT(1) | BIT(0))
> >
> > @@ -111,7 +112,7 @@ static const int mma8452_samp_freq[8][2] = {
> >  	{6, 250000}, {1, 560000}
> >  };
> >
> > -/*
> > +/*
> This ought to be in a separate cleanup patch.  Just adds noise to the important
> stuff in here!  Not important though so don't bother rerolling the series for this.
> 
> >   * Hardware has fullscale of -2G, -4G, -8G corresponding to raw value -2048
> >   * The userspace interface uses m/s^2 and we declare micro units
> >   * So scale factor is given by:
> > @@ -335,6 +336,30 @@ static const struct iio_info mma8452_info = {
> >
> >  static const unsigned long mma8452_scan_masks[] = {0x7, 0};
> >
> > +static int mma8452_reset(struct i2c_client *client)
> > +{
> > +	int i;
> > +	int ret;
> > +
> > +	ret = i2c_smbus_write_byte_data(client,	MMA8452_CTRL_REG2,
> > +						MMA8452_CTRL_REG2_RST);
> > +	if (ret)
> > +		return ret;
> > +
> > +	for (i = 0; i < 10; i++) {
> > +		udelay(100);
> > +		ret = i2c_smbus_read_byte_data(client, MMA8452_CTRL_REG2);
> > +		if (ret == -EIO)
> > +			continue; /* I2C comm reset */
> > +		if (ret < 0)
> > +			return ret;
> > +		if (!(ret & MMA8452_CTRL_REG2_RST))
> > +			return 0;
> > +	}
> > +
> > +	return -ETIMEDOUT;
> > +}
> > +
> >  static int mma8452_probe(struct i2c_client *client,
> >  			 const struct i2c_device_id *id)
> >  {
> > @@ -365,10 +390,7 @@ static int mma8452_probe(struct i2c_client *client,
> >  	indio_dev->num_channels = ARRAY_SIZE(mma8452_channels);
> >  	indio_dev->available_scan_masks = mma8452_scan_masks;
> >
> > -	data->ctrl_reg1 = MMA8452_CTRL_ACTIVE |
> > -		(MMA8452_CTRL_DR_DEFAULT << MMA8452_CTRL_DR_SHIFT);
> > -	ret = i2c_smbus_write_byte_data(client, MMA8452_CTRL_REG1,
> > -		data->ctrl_reg1);
> > +	ret = mma8452_reset(client);
> >  	if (ret < 0)
> >  		return ret;
> >
> > @@ -378,6 +400,13 @@ static int mma8452_probe(struct i2c_client *client,
> >  	if (ret < 0)
> >  		return ret;
> >
> > +	data->ctrl_reg1 = MMA8452_CTRL_ACTIVE |
> > +		(MMA8452_CTRL_DR_DEFAULT << MMA8452_CTRL_DR_SHIFT);
> > +	ret = i2c_smbus_write_byte_data(client, MMA8452_CTRL_REG1,
> > +		data->ctrl_reg1);
> > +	if (ret < 0)
> > +		return ret;
> > +
> >  	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> >  		mma8452_trigger_handler, NULL);
> >  	if (ret < 0)
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
