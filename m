Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750835AbeBJO7g (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Feb 2018 09:59:36 -0500
Date: Sat, 10 Feb 2018 14:59:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tomas Novotny <tomas@novotny.cz>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/2] iio: vcnl4000: make the driver extendable
Message-ID: <20180210145932.1de3f3e2@archlinux>
In-Reply-To: <20180206141740.5cd02807@tomas.local.tbs-biometrics.cz>
References: <20180205180424.30725-1-tomas@novotny.cz>
        <20180205180424.30725-2-tomas@novotny.cz>
        <alpine.DEB.2.21.1802051958260.23705@vps.pmeerw.net>
        <20180206141740.5cd02807@tomas.local.tbs-biometrics.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 6 Feb 2018 14:17:40 +0100
Tomas Novotny <tomas@novotny.cz> wrote:

> Hi Peter,
> 
> On Mon, 5 Feb 2018 21:00:48 +0100 (CET)
> Peter Meerwald-Stadler <pmeerw@pmeerw.net> wrote:
> 
> > > There are similar chips in a vcnl4xxx family. The initialization and
> > > communication is a bit different for another members of the family, so
> > > this patch makes the driver extendable for different chips.    
> >   
> > > There is no functional change.    
> > 
> > looks good to me, suggestion below but not mandatory
> >    
> > > Signed-off-by: Tomas Novotny <tomas@novotny.cz>
> > > ---
> > >  drivers/iio/light/vcnl4000.c | 86 ++++++++++++++++++++++++++++++++++----------
> > >  1 file changed, 68 insertions(+), 18 deletions(-)
> > > 
> > > diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> > > index c599a90506ad..d7e43fd9333e 100644
> > > --- a/drivers/iio/light/vcnl4000.c
> > > +++ b/drivers/iio/light/vcnl4000.c
> > > @@ -26,8 +26,8 @@
> > >  #include <linux/iio/sysfs.h>
> > >  
> > >  #define VCNL4000_DRV_NAME "vcnl4000"
> > > -#define VCNL4000_ID		0x01
> > > -#define VCNL4010_ID		0x02 /* for VCNL4020, VCNL4010 */
> > > +#define VCNL4000_PROD_ID	0x01
> > > +#define VCNL4010_PROD_ID	0x02 /* for VCNL4020, VCNL4010 */
> > >  
> > >  #define VCNL4000_COMMAND	0x80 /* Command register */
> > >  #define VCNL4000_PROD_REV	0x81 /* Product ID and Revision ID */
> > > @@ -46,17 +46,52 @@
> > >  #define VCNL4000_AL_OD		BIT(4) /* start on-demand ALS measurement */
> > >  #define VCNL4000_PS_OD		BIT(3) /* start on-demand proximity measurement */
> > >  
> > > +enum vcnl4000_device_ids {
> > > +	VCNL4000,    
> > 
> > maybe add VCNL4010 here and in vcnl4000_chip_spec_cfg just for 
> > completeness, so that all IDs are actually used?  
> 
> ok, I will do. Does it make sense to be strict and return -ENODEV (with
> appropriate message) when vcnl4000 i2c device is specified but
> VCNL4010_PROD_ID is found (and the same for VCNL4000_PROD_ID)? There is only
> a general check now, see below.

Probably better to just put a warning out.  People have an irritating habit
of having a dt file for their board based on the wrong compatible.
Given the driver can detect this and 'fix' it I think it should.
Please do put a suitably worded warning in the logs though as better
to fix it properly!

> 
> > > +};
> > > +
> > >  struct vcnl4000_data {
> > >  	struct i2c_client *client;
> > > +	enum vcnl4000_device_ids id;
> > > +	const char *prod;
> > > +	int rev;
> > > +	int al_scale;
> > > +	const struct vcnl4000_chip_spec *chip_spec;
> > >  	struct mutex lock;
> > >  };
> > >  
> > > +struct vcnl4000_chip_spec {
> > > +	int (*init)(struct vcnl4000_data *data);
> > > +	int (*measure_light)(struct vcnl4000_data *data, int *val);
> > > +	int (*measure_proximity)(struct vcnl4000_data *data, int *val);
> > > +};
> > > +
> > >  static const struct i2c_device_id vcnl4000_id[] = {
> > > -	{ "vcnl4000", 0 },
> > > +	{ "vcnl4000", VCNL4000 },
> > >  	{ }
> > >  };
> > >  MODULE_DEVICE_TABLE(i2c, vcnl4000_id);
> > >  
> > > +static int vcnl4000_init(struct vcnl4000_data *data)
> > > +{
> > > +	int ret, prod_id;
> > > +
> > > +	ret = i2c_smbus_read_byte_data(data->client, VCNL4000_PROD_REV);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	prod_id = ret >> 4;
> > > +	if (prod_id != VCNL4010_PROD_ID && prod_id != VCNL4000_PROD_ID)
> > > +		return -ENODEV;  
> 
As a general scalability thing, I would do that as a switch statement.
These sorts of if statements have a habit of growing every time a new
variant comes along and in the end get changed to a switch statement
which causes more noise than it would have done if we had allowed for
the future in the first place.

> here ^^^
> 
> Thanks,
> 
> Tomas
> 
> > > +	data->prod = prod_id == VCNL4010_PROD_ID ? "VCNL4010/4020" : "VCNL4000";
> > > +	data->rev = ret & 0xf;
> > > +
> > > +	data->al_scale = 250000;
> > > +
> > > +	return 0;
> > > +};
> > > +
> > >  static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
> > >  				u8 rdy_mask, u8 data_reg, int *val)
> > >  {
> > > @@ -103,6 +138,28 @@ static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
> > >  	return ret;
> > >  }
> > >  
> > > +static int vcnl4000_measure_light(struct vcnl4000_data *data, int *val)
> > > +{
> > > +	return vcnl4000_measure(data,
> > > +			VCNL4000_AL_OD, VCNL4000_AL_RDY,
> > > +			VCNL4000_AL_RESULT_HI, val);
> > > +}
> > > +
> > > +static int vcnl4000_measure_proximity(struct vcnl4000_data *data, int *val)
> > > +{
> > > +	return vcnl4000_measure(data,
> > > +			VCNL4000_PS_OD, VCNL4000_PS_RDY,
> > > +			VCNL4000_PS_RESULT_HI, val);
> > > +}
> > > +
> > > +static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
> > > +	[VCNL4000] = {
> > > +		.init = vcnl4000_init,
> > > +		.measure_light = vcnl4000_measure_light,
> > > +		.measure_proximity = vcnl4000_measure_proximity,
> > > +	},
> > > +};
> > > +
> > >  static const struct iio_chan_spec vcnl4000_channels[] = {
> > >  	{
> > >  		.type = IIO_LIGHT,
> > > @@ -125,16 +182,12 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
> > >  	case IIO_CHAN_INFO_RAW:
> > >  		switch (chan->type) {
> > >  		case IIO_LIGHT:
> > > -			ret = vcnl4000_measure(data,
> > > -				VCNL4000_AL_OD, VCNL4000_AL_RDY,
> > > -				VCNL4000_AL_RESULT_HI, val);
> > > +			ret = data->chip_spec->measure_light(data, val);
> > >  			if (ret < 0)
> > >  				return ret;
> > >  			return IIO_VAL_INT;
> > >  		case IIO_PROXIMITY:
> > > -			ret = vcnl4000_measure(data,
> > > -				VCNL4000_PS_OD, VCNL4000_PS_RDY,
> > > -				VCNL4000_PS_RESULT_HI, val);
> > > +			ret = data->chip_spec->measure_proximity(data, val);
> > >  			if (ret < 0)
> > >  				return ret;
> > >  			return IIO_VAL_INT;
> > > @@ -146,7 +199,7 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
> > >  			return -EINVAL;
> > >  
> > >  		*val = 0;
> > > -		*val2 = 250000;
> > > +		*val2 = data->al_scale;
> > >  		return IIO_VAL_INT_PLUS_MICRO;
> > >  	default:
> > >  		return -EINVAL;
> > > @@ -162,7 +215,7 @@ static int vcnl4000_probe(struct i2c_client *client,
> > >  {
> > >  	struct vcnl4000_data *data;
> > >  	struct iio_dev *indio_dev;
> > > -	int ret, prod_id;
> > > +	int ret;
> > >  
> > >  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> > >  	if (!indio_dev)
> > > @@ -171,19 +224,16 @@ static int vcnl4000_probe(struct i2c_client *client,
> > >  	data = iio_priv(indio_dev);
> > >  	i2c_set_clientdata(client, indio_dev);
> > >  	data->client = client;
> > > +	data->id = id->driver_data;
> > > +	data->chip_spec = &vcnl4000_chip_spec_cfg[data->id];
> > >  	mutex_init(&data->lock);
> > >  
> > > -	ret = i2c_smbus_read_byte_data(data->client, VCNL4000_PROD_REV);
> > > +	ret = data->chip_spec->init(data);
> > >  	if (ret < 0)
> > >  		return ret;
> > >  
> > > -	prod_id = ret >> 4;
> > > -	if (prod_id != VCNL4010_ID && prod_id != VCNL4000_ID)
> > > -		return -ENODEV;
> > > -
> > >  	dev_dbg(&client->dev, "%s Ambient light/proximity sensor, Rev: %02x\n",
> > > -		(prod_id == VCNL4010_ID) ? "VCNL4010/4020" : "VCNL4000",
> > > -		ret & 0xf);
> > > +		data->prod, data->rev);
> > >  
> > >  	indio_dev->dev.parent = &client->dev;
> > >  	indio_dev->info = &vcnl4000_info;
> > >     
> >   

