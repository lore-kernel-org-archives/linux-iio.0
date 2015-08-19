Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:43932 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753858AbbHSMKM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 19 Aug 2015 08:10:12 -0400
Date: Wed, 19 Aug 2015 15:09:56 +0300
From: Teodora Baluta <teodora.baluta@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	daniel.baluta@intel.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: mxc4005: add triggered buffer mode for
 mxc4005
Message-ID: <20150819120956.GB27721@hard-bop>
References: <1439487101-13085-1-git-send-email-teodora.baluta@intel.com>
 <1439487101-13085-3-git-send-email-teodora.baluta@intel.com>
 <55D03DD0.7080600@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55D03DD0.7080600@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Aug 16, 2015 at 08:37:52AM +0100, Jonathan Cameron wrote:
> On 13/08/15 18:31, Teodora Baluta wrote:
> > This patch adds support for buffered readings for the 3-axis
> > accelerometer mxc4005.
> > 
> > Signed-off-by: Teodora Baluta <teodora.baluta@intel.com>
> One big one (buffer isn't big enough) in here.
> Otherwise, looking good.

Yes, thanks. :)

> 
> Jonathan
> > ---
> >  drivers/iio/accel/Kconfig   |  2 ++
> >  drivers/iio/accel/mxc4005.c | 75 +++++++++++++++++++++++++++++++++++++++++++--
> >  2 files changed, 75 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> > index 69302be..cd5cd24 100644
> > --- a/drivers/iio/accel/Kconfig
> > +++ b/drivers/iio/accel/Kconfig
> > @@ -140,6 +140,8 @@ config MMA9553
> >  config MXC4005
> >  	tristate "Memsic MXC4005XC 3-Axis Accelerometer Driver"
> >  	depends on I2C
> > +	select IIO_BUFFER
> > +	select IIO_TRIGGERED_BUFFER
> >  	select REGMAP_I2C
> >  	help
> >  	  Say yes here to build support for the Memsic MXC4005XC 3-axis
> > diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
> > index 76a7954..5f4813d 100644
> > --- a/drivers/iio/accel/mxc4005.c
> > +++ b/drivers/iio/accel/mxc4005.c
> > @@ -19,6 +19,9 @@
> >  #include <linux/acpi.h>
> >  #include <linux/regmap.h>
> >  #include <linux/iio/sysfs.h>
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +#include <linux/iio/trigger_consumer.h>
> >  
> >  #define MXC4005_DRV_NAME		"mxc4005"
> >  #define MXC4005_REGMAP_NAME		"mxc4005_regmap"
> > @@ -52,6 +55,7 @@ struct mxc4005_data {
> >  	struct i2c_client *client;
> >  	struct mutex mutex;
> >  	struct regmap *regmap;
> > +	__be16 buffer[3];
> Not big enough as needs to have space for the timestamp as well.
> (noticing this does require reading the fine print for
> iio_push_to_buffers_with_timestamp).
> 
> Should be 3*2 bytes + 8 bytes (aligned) so will be 16 bytes, or 8 __be16s.
> 
> >  };
> >  
> >  /*
> > @@ -123,6 +127,20 @@ static const struct regmap_config mxc4005_regmap_config = {
> >  	.writeable_reg = mxc4005_is_writeable_reg,
> >  };
> >  
> > +static int mxc4005_read_xyz(struct mxc4005_data *data)
> > +{
> > +	int ret;
> > +
> > +	ret = regmap_bulk_read(data->regmap, MXC4005_REG_XOUT_UPPER,
> > +			       (u8 *) data->buffer, sizeof(data->buffer));
> > +	if (ret < 0) {
> > +		dev_err(&data->client->dev, "failed to read axes\n");
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int mxc4005_read_axis(struct mxc4005_data *data,
> >  			     unsigned int addr)
> >  {
> > @@ -198,7 +216,8 @@ static int mxc4005_read_raw(struct iio_dev *indio_dev,
> >  			ret = mxc4005_read_axis(data, chan->address);
> >  			if (ret < 0)
> >  				return ret;
> > -			*val = sign_extend32(ret >> 4, 11);
> > +			*val = sign_extend32(ret >> chan->scan_type.shift,
> > +					     chan->scan_type.realbits - 1);
> >  			return IIO_VAL_INT;
> >  		default:
> >  			return -EINVAL;
> > @@ -240,6 +259,11 @@ static const struct iio_info mxc4005_info = {
> >  	.attrs		= &mxc4005_attrs_group,
> >  };
> >  
> > +static const unsigned long mxc4005_scan_masks[] = {
> > +	BIT(AXIS_X) | BIT(AXIS_Y) | BIT(AXIS_Z),
> > +	0
> > +};
> > +
> >  #define MXC4005_CHANNEL(_axis, _addr) {				\
> >  	.type = IIO_ACCEL,					\
> >  	.modified = 1,						\
> > @@ -247,14 +271,43 @@ static const struct iio_info mxc4005_info = {
> >  	.address = _addr,					\
> >  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> >  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> > +	.scan_index = AXIS_##_axis,				\
> > +	.scan_type = {						\
> > +		.sign = 's',					\
> > +		.realbits = 12,					\
> > +		.storagebits = 16,				\
> > +		.shift = 4,					\
> > +		.endianness = IIO_BE,				\
> > +	},							\
> >  }
> >  
> >  static const struct iio_chan_spec mxc4005_channels[] = {
> >  	MXC4005_CHANNEL(X, MXC4005_REG_XOUT_UPPER),
> >  	MXC4005_CHANNEL(Y, MXC4005_REG_YOUT_UPPER),
> >  	MXC4005_CHANNEL(Z, MXC4005_REG_ZOUT_UPPER),
> > +	IIO_CHAN_SOFT_TIMESTAMP(3),
> >  };
> >  
> > +static irqreturn_t mxc4005_trigger_handler(int irq, void *private)
> > +{
> > +	struct iio_poll_func *pf = private;
> > +	struct iio_dev *indio_dev = pf->indio_dev;
> > +	struct mxc4005_data *data = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	ret = mxc4005_read_xyz(data);
> > +	if (ret < 0)
> > +		goto err;
> > +
> > +	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> > +					   iio_get_time_ns());
> > +
> > +err:
> > +	iio_trigger_notify_done(indio_dev->trig);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> >  static int mxc4005_chip_init(struct mxc4005_data *data)
> >  {
> >  	int ret;
> > @@ -305,18 +358,34 @@ static int mxc4005_probe(struct i2c_client *client,
> >  	indio_dev->dev.parent = &client->dev;
> >  	indio_dev->channels = mxc4005_channels;
> >  	indio_dev->num_channels = ARRAY_SIZE(mxc4005_channels);
> > +	indio_dev->available_scan_masks = mxc4005_scan_masks;
> >  	indio_dev->name = MXC4005_DRV_NAME;
> >  	indio_dev->modes = INDIO_DIRECT_MODE;
> >  	indio_dev->info = &mxc4005_info;
> >  
> > +	ret = iio_triggered_buffer_setup(indio_dev,
> > +					 &iio_pollfunc_store_time,
> > +					 mxc4005_trigger_handler,
> > +					 NULL);
> > +	if (ret < 0) {
> > +		dev_err(&client->dev,
> > +			"failed to setup iio triggered buffer\n");
> > +		return ret;
> > +	}
> > +
> >  	ret = iio_device_register(indio_dev);
> >  	if (ret < 0) {
> >  		dev_err(&client->dev,
> >  			"unable to register iio device %d\n", ret);
> > -		return ret;
> > +		goto err_buffer_cleanup;
> >  	}
> >  
> >  	return 0;
> > +
> > +err_buffer_cleanup:
> > +	iio_triggered_buffer_cleanup(indio_dev);
> > +
> > +	return ret;
> >  }
> >  
> >  static int mxc4005_remove(struct i2c_client *client)
> > @@ -325,6 +394,8 @@ static int mxc4005_remove(struct i2c_client *client)
> >  
> >  	iio_device_unregister(indio_dev);
> >  
> > +	iio_triggered_buffer_cleanup(indio_dev);
> > +
> >  	return 0;
> >  }
> >  
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
