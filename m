Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58505 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137AbcGXK0R (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Jul 2016 06:26:17 -0400
Subject: Re: [PATCH 2/2] staging: iio: vcnl4000: Replace i2c api's with regmap
To: Pratik Prajapati <pratik.prajapati12@gmail.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1469112097-6806-1-git-send-email-pratik.prajapati12@gmail.com>
 <1469112097-6806-2-git-send-email-pratik.prajapati12@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <bb12cea3-487d-b1ec-cadc-4ca582082517@kernel.org>
Date: Sun, 24 Jul 2016 11:26:12 +0100
MIME-Version: 1.0
In-Reply-To: <1469112097-6806-2-git-send-email-pratik.prajapati12@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/07/16 15:41, Pratik Prajapati wrote:
> Signed-off-by: Pratik Prajapati <pratik.prajapati12@gmail.com>
> ---
>  drivers/iio/light/vcnl4000.c | 91 +++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 78 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 1378175..61e48f8 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -20,6 +20,7 @@
>  #include <linux/i2c.h>
>  #include <linux/err.h>
>  #include <linux/delay.h>
> +#include <linux/regmap.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -52,6 +53,7 @@
>  struct vcnl4000_data {
>  	struct i2c_client *client;
>  	struct mutex lock;
> +	struct regmap *regmap;
You can use the regmap_get_device to avoid having to carry the client through the whole
driver. I haven't checked the result of applying this patch but I'm not entirely sure
you use client at all.
>  };
>  
>  static const struct i2c_device_id vcnl4000_id[] = {
> @@ -66,20 +68,20 @@ static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
>  	int tries = 20;
>  	__be16 buf;
>  	int ret;
> +	unsigned int regval;
>  
>  	mutex_lock(&data->lock);
>  
> -	ret = i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND,
> -					req_mask);
> +	ret = regmap_write(data->regmap, VCNL4000_COMMAND, req_mask);
>  	if (ret < 0)
>  		goto fail;
>  
>  	/* wait for data to become ready */
>  	while (tries--) {
> -		ret = i2c_smbus_read_byte_data(data->client, VCNL4000_COMMAND);
> +		ret = regmap_read(data->regmap, VCNL4000_COMMAND, &regval);
>  		if (ret < 0)
>  			goto fail;
> -		if (ret & rdy_mask)
> +		if (regval & rdy_mask)
>  			break;
>  		msleep(20); /* measurement takes up to 100 ms */
>  	}
> @@ -91,8 +93,8 @@ static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
>  		goto fail;
>  	}
>  
> -	ret = i2c_smbus_read_i2c_block_data(data->client,
> -		data_reg, sizeof(buf), (u8 *) &buf);
> +	ret = regmap_bulk_read(data->regmap, data_reg, (u8 *) &buf,
> +			sizeof(buf));
>  	if (ret < 0)
>  		goto fail;
>  
> @@ -131,23 +133,24 @@ static int vcnl4000_write_led_current_raw(struct vcnl4000_data *data, int val)
>  	if (val < 0 || val > VCNL4000_LED_CURRENT_MAX)
>  		return -ERANGE;
>  	mutex_lock(&data->lock);
> -	ret = i2c_smbus_write_byte_data(data->client, VCNL4000_LED_CURRENT,
> -			val);
Just noticed this.  You didn't do a masked write in the previous patch.
Are you sure that wasn't overwriting something it shouldn't have been?
> +	ret = regmap_write_bits(data->regmap, VCNL4000_LED_CURRENT,
> +		VCNL4000_LED_CURRENT_MASK, val);
>  	mutex_unlock(&data->lock);
>  	return ret;
>  }
>  
>  static int vcnl4000_read_led_current_raw(struct vcnl4000_data *data)
>  {
> +	unsigned int regval;
>  	int ret;
>  
>  	mutex_lock(&data->lock);
> -	ret = i2c_smbus_read_byte_data(data->client, VCNL4000_LED_CURRENT);
> +	ret = regmap_read(data->regmap, VCNL4000_LED_CURRENT, &regval);
>  	mutex_unlock(&data->lock);
>  	if (ret < 0)
>  		return ret;
> -	ret &= VCNL4000_LED_CURRENT_MASK;
> -	return ret;
> +	regval &= VCNL4000_LED_CURRENT_MASK;
Tempting to roll these two lines into one, but then it wouldn't be
quite so obvious that you did the conversion right.  Up to you :)
> +	return regval;
>  }
>  
>  static int vcnl4000_read_raw(struct iio_dev *indio_dev,
> @@ -224,27 +227,89 @@ static const struct iio_info vcnl4000_info = {
>  	.driver_module = THIS_MODULE,
>  };
>  
> +static bool vcnl4000_readable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case VCNL4000_COMMAND:
> +	case VCNL4000_PROD_REV:
> +	case VCNL4000_LED_CURRENT:
> +	case VCNL4000_AL_PARAM:
> +	case VCNL4000_AL_RESULT_HI:
> +	case VCNL4000_AL_RESULT_LO:
> +	case VCNL4000_PS_RESULT_HI:
> +	case VCNL4000_PS_RESULT_LO:
> +	case VCNL4000_PS_MEAS_FREQ:
> +	case VCNL4000_PS_MOD_ADJ:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool vcnl4000_writeable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case VCNL4000_COMMAND:
> +	case VCNL4000_LED_CURRENT:
> +	case VCNL4000_AL_PARAM:
> +	case VCNL4000_PS_MEAS_FREQ:
> +	case VCNL4000_PS_MOD_ADJ:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool vcnl4000_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case VCNL4000_COMMAND:
> +	case VCNL4000_AL_RESULT_HI:
> +	case VCNL4000_AL_RESULT_LO:
> +	case VCNL4000_PS_RESULT_HI:
> +	case VCNL4000_PS_RESULT_LO:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static const struct regmap_config vcnl4000_regmap_config = {
> +	.reg_bits	= 8,
> +	.val_bits	= 8,
> +	.max_register	= VCNL4000_PS_MOD_ADJ,
> +	.readable_reg	= vcnl4000_readable_reg,
> +	.writeable_reg	= vcnl4000_writeable_reg,
> +	.volatile_reg	= vcnl4000_volatile_reg,
> +};
> +
>  static int vcnl4000_probe(struct i2c_client *client,
>  			  const struct i2c_device_id *id)
>  {
>  	struct vcnl4000_data *data;
>  	struct iio_dev *indio_dev;
>  	int ret, prod_id;
> +	unsigned int regval;
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
>  	data = iio_priv(indio_dev);
> +	data->regmap = devm_regmap_init_i2c(client, &vcnl4000_regmap_config);
> +	if (IS_ERR(data->regmap)) {
> +		dev_err(&client->dev, "regmap_init failed!\n");
> +		return PTR_ERR(data->regmap);
> +	}
>  	i2c_set_clientdata(client, indio_dev);
>  	data->client = client;
>  	mutex_init(&data->lock);
>  
> -	ret = i2c_smbus_read_byte_data(data->client, VCNL4000_PROD_REV);
> +	ret = regmap_read(data->regmap, VCNL4000_PROD_REV, &regval);
>  	if (ret < 0)
>  		return ret;
>  
> -	prod_id = ret >> 4;
> +	prod_id = regval >> 4;
>  	if (prod_id != VCNL4010_ID && prod_id != VCNL4000_ID)
>  		return -ENODEV;
>  
> 

