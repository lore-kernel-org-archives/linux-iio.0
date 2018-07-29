Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbeG2MuV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Jul 2018 08:50:21 -0400
Date: Sun, 29 Jul 2018 12:20:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Tomas Novotny <tomas.novotny@tbs-biometrics.com>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Tomas Novotny <tomas@novotny.cz>
Subject: Re: [PATCH v3 1/4] iio: vcnl4000: make the driver extendable
Message-ID: <20180729122009.77188bc9@archlinux>
In-Reply-To: <20180725151821.17566-2-tomas.novotny@tbs-biometrics.com>
References: <20180725151821.17566-1-tomas.novotny@tbs-biometrics.com>
        <20180725151821.17566-2-tomas.novotny@tbs-biometrics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 25 Jul 2018 17:18:18 +0200
Tomas Novotny <tomas.novotny@tbs-biometrics.com> wrote:

> From: Tomas Novotny <tomas@novotny.cz>
> 
> There are similar chips in the vcnl4xxx family. The initialization and
> communication is a bit different for members of the family, so this
> patch makes the driver extendable for different chips.
> 
> There is no functional change.
> 
> Signed-off-by: Tomas Novotny <tomas@novotny.cz>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
> No change v2..v3
> 
>  drivers/iio/light/vcnl4000.c | 85 ++++++++++++++++++++++++++++++++++----------
>  1 file changed, 67 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index c599a90506ad..32c0b531395f 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -26,8 +26,8 @@
>  #include <linux/iio/sysfs.h>
>  
>  #define VCNL4000_DRV_NAME "vcnl4000"
> -#define VCNL4000_ID		0x01
> -#define VCNL4010_ID		0x02 /* for VCNL4020, VCNL4010 */
> +#define VCNL4000_PROD_ID	0x01
> +#define VCNL4010_PROD_ID	0x02 /* for VCNL4020, VCNL4010 */
>  
>  #define VCNL4000_COMMAND	0x80 /* Command register */
>  #define VCNL4000_PROD_REV	0x81 /* Product ID and Revision ID */
> @@ -46,17 +46,50 @@
>  #define VCNL4000_AL_OD		BIT(4) /* start on-demand ALS measurement */
>  #define VCNL4000_PS_OD		BIT(3) /* start on-demand proximity measurement */
>  
> +enum vcnl4000_device_ids {
> +	VCNL4000,
> +};
> +
>  struct vcnl4000_data {
>  	struct i2c_client *client;
> +	enum vcnl4000_device_ids id;
> +	int rev;
> +	int al_scale;
> +	const struct vcnl4000_chip_spec *chip_spec;
>  	struct mutex lock;
>  };
>  
> +struct vcnl4000_chip_spec {
> +	const char *prod;
> +	int (*init)(struct vcnl4000_data *data);
> +	int (*measure_light)(struct vcnl4000_data *data, int *val);
> +	int (*measure_proximity)(struct vcnl4000_data *data, int *val);
> +};
> +
>  static const struct i2c_device_id vcnl4000_id[] = {
> -	{ "vcnl4000", 0 },
> +	{ "vcnl4000", VCNL4000 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, vcnl4000_id);
>  
> +static int vcnl4000_init(struct vcnl4000_data *data)
> +{
> +	int ret, prod_id;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, VCNL4000_PROD_REV);
> +	if (ret < 0)
> +		return ret;
> +
> +	prod_id = ret >> 4;
> +	if (prod_id != VCNL4010_PROD_ID && prod_id != VCNL4000_PROD_ID)
> +		return -ENODEV;
> +
> +	data->rev = ret & 0xf;
> +	data->al_scale = 250000;
> +
> +	return 0;
> +};
> +
>  static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
>  				u8 rdy_mask, u8 data_reg, int *val)
>  {
> @@ -103,6 +136,29 @@ static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
>  	return ret;
>  }
>  
> +static int vcnl4000_measure_light(struct vcnl4000_data *data, int *val)
> +{
> +	return vcnl4000_measure(data,
> +			VCNL4000_AL_OD, VCNL4000_AL_RDY,
> +			VCNL4000_AL_RESULT_HI, val);
> +}
> +
> +static int vcnl4000_measure_proximity(struct vcnl4000_data *data, int *val)
> +{
> +	return vcnl4000_measure(data,
> +			VCNL4000_PS_OD, VCNL4000_PS_RDY,
> +			VCNL4000_PS_RESULT_HI, val);
> +}
> +
> +static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
> +	[VCNL4000] = {
> +		.prod = "VCNL4000",
> +		.init = vcnl4000_init,
> +		.measure_light = vcnl4000_measure_light,
> +		.measure_proximity = vcnl4000_measure_proximity,
> +	},
> +};
> +
>  static const struct iio_chan_spec vcnl4000_channels[] = {
>  	{
>  		.type = IIO_LIGHT,
> @@ -125,16 +181,12 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_RAW:
>  		switch (chan->type) {
>  		case IIO_LIGHT:
> -			ret = vcnl4000_measure(data,
> -				VCNL4000_AL_OD, VCNL4000_AL_RDY,
> -				VCNL4000_AL_RESULT_HI, val);
> +			ret = data->chip_spec->measure_light(data, val);
>  			if (ret < 0)
>  				return ret;
>  			return IIO_VAL_INT;
>  		case IIO_PROXIMITY:
> -			ret = vcnl4000_measure(data,
> -				VCNL4000_PS_OD, VCNL4000_PS_RDY,
> -				VCNL4000_PS_RESULT_HI, val);
> +			ret = data->chip_spec->measure_proximity(data, val);
>  			if (ret < 0)
>  				return ret;
>  			return IIO_VAL_INT;
> @@ -146,7 +198,7 @@ static int vcnl4000_read_raw(struct iio_dev *indio_dev,
>  			return -EINVAL;
>  
>  		*val = 0;
> -		*val2 = 250000;
> +		*val2 = data->al_scale;
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	default:
>  		return -EINVAL;
> @@ -162,7 +214,7 @@ static int vcnl4000_probe(struct i2c_client *client,
>  {
>  	struct vcnl4000_data *data;
>  	struct iio_dev *indio_dev;
> -	int ret, prod_id;
> +	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>  	if (!indio_dev)
> @@ -171,19 +223,16 @@ static int vcnl4000_probe(struct i2c_client *client,
>  	data = iio_priv(indio_dev);
>  	i2c_set_clientdata(client, indio_dev);
>  	data->client = client;
> +	data->id = id->driver_data;
> +	data->chip_spec = &vcnl4000_chip_spec_cfg[data->id];
>  	mutex_init(&data->lock);
>  
> -	ret = i2c_smbus_read_byte_data(data->client, VCNL4000_PROD_REV);
> +	ret = data->chip_spec->init(data);
>  	if (ret < 0)
>  		return ret;
>  
> -	prod_id = ret >> 4;
> -	if (prod_id != VCNL4010_ID && prod_id != VCNL4000_ID)
> -		return -ENODEV;
> -
>  	dev_dbg(&client->dev, "%s Ambient light/proximity sensor, Rev: %02x\n",
> -		(prod_id == VCNL4010_ID) ? "VCNL4010/4020" : "VCNL4000",
> -		ret & 0xf);
> +		data->chip_spec->prod, data->rev);
>  
>  	indio_dev->dev.parent = &client->dev;
>  	indio_dev->info = &vcnl4000_info;

