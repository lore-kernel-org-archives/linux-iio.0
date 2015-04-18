Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59124 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811AbbDRKou (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 18 Apr 2015 06:44:50 -0400
Message-ID: <5532359D.7060604@kernel.org>
Date: Sat, 18 Apr 2015 11:44:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, pmeerw@pmeerw.net
CC: linux-iio@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
	Daniel Baluta <daniel.baluta@intel.com>
Subject: Re: [PATCH v4 1/5] iio: ltr501: Add regmap support.
References: <cover.1429326499.git.sathyanarayanan.kuppuswamy@linux.intel.com> <2baa6905998921ffba4f80adef1c4804a8244d91.1429326499.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <2baa6905998921ffba4f80adef1c4804a8244d91.1429326499.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/04/15 06:15, Kuppuswamy Sathyanarayanan wrote:
> Added regmap support. It will be useful to handle
> bitwise updates to als & ps control registers.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Looks good.  Applied to the togreg branch of iio.git
Initially pushed out as testign for the autobuilders to play with it.

Note I hand applied this as there was a lot of realignment stuff in
a recent patch from Daniel.

As he'd gone to the effort to make checkpatch.pl --strict pass it I
did the same and cleaned up a few corners (nothing remotely significant!)

If you could take a look at the result and check I didn't do anything silly
that would be great!

Thanks,

Jonathan
> ---
>  drivers/iio/light/ltr501.c | 114 +++++++++++++++++++++++++++++++--------------
>  1 file changed, 80 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> index 62b7072..84ee2b3 100644
> --- a/drivers/iio/light/ltr501.c
> +++ b/drivers/iio/light/ltr501.c
> @@ -16,6 +16,7 @@
>  #include <linux/i2c.h>
>  #include <linux/err.h>
>  #include <linux/delay.h>
> +#include <linux/regmap.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -33,6 +34,7 @@
>  #define LTR501_ALS_DATA0 0x8a /* 16-bit, little endian */
>  #define LTR501_ALS_PS_STATUS 0x8c
>  #define LTR501_PS_DATA 0x8d /* 16-bit, little endian */
> +#define LTR501_MAX_REG 0x9f
>  
>  #define LTR501_ALS_CONTR_SW_RESET BIT(2)
>  #define LTR501_CONTR_PS_GAIN_MASK (BIT(3) | BIT(2))
> @@ -45,23 +47,25 @@
>  
>  #define LTR501_PS_DATA_MASK 0x7ff
>  
> +#define LTR501_REGMAP_NAME "ltr501_regmap"
> +
>  struct ltr501_data {
>  	struct i2c_client *client;
>  	struct mutex lock_als, lock_ps;
>  	u8 als_contr, ps_contr;
> +	struct regmap *regmap;
>  };
>  
>  static int ltr501_drdy(struct ltr501_data *data, u8 drdy_mask)
>  {
>  	int tries = 100;
> -	int ret;
> +	int ret, status;
>  
>  	while (tries--) {
> -		ret = i2c_smbus_read_byte_data(data->client,
> -			LTR501_ALS_PS_STATUS);
> +		ret = regmap_read(data->regmap, LTR501_ALS_PS_STATUS, &status);
>  		if (ret < 0)
>  			return ret;
> -		if ((ret & drdy_mask) == drdy_mask)
> +		if ((status & drdy_mask) == drdy_mask)
>  			return 0;
>  		msleep(25);
>  	}
> @@ -76,16 +80,24 @@ static int ltr501_read_als(struct ltr501_data *data, __le16 buf[2])
>  	if (ret < 0)
>  		return ret;
>  	/* always read both ALS channels in given order */
> -	return i2c_smbus_read_i2c_block_data(data->client,
> -		LTR501_ALS_DATA1, 2 * sizeof(__le16), (u8 *) buf);
> +	return regmap_bulk_read(data->regmap, LTR501_ALS_DATA1,
> +				buf, 2 * sizeof(__le16));
>  }
>  
>  static int ltr501_read_ps(struct ltr501_data *data)
>  {
> -	int ret = ltr501_drdy(data, LTR501_STATUS_PS_RDY);
> +	int ret, status;
> +
> +	ret = ltr501_drdy(data, LTR501_STATUS_PS_RDY);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_bulk_read(data->regmap, LTR501_PS_DATA,
> +				&status, 2);
>  	if (ret < 0)
>  		return ret;
> -	return i2c_smbus_read_word_data(data->client, LTR501_PS_DATA);
> +
> +	return status;
>  }
>  
>  #define LTR501_INTENSITY_CHANNEL(_idx, _addr, _mod, _shared) { \
> @@ -218,16 +230,18 @@ static int ltr501_write_raw(struct iio_dev *indio_dev,
>  				data->als_contr &= ~LTR501_CONTR_ALS_GAIN_MASK;
>  			else
>  				return -EINVAL;
> -			return i2c_smbus_write_byte_data(data->client,
> -				LTR501_ALS_CONTR, data->als_contr);
> +
> +			return regmap_write(data->regmap, LTR501_ALS_CONTR,
> +					    data->als_contr);
>  		case IIO_PROXIMITY:
>  			i = ltr501_get_ps_gain_index(val, val2);
>  			if (i < 0)
>  				return -EINVAL;
>  			data->ps_contr &= ~LTR501_CONTR_PS_GAIN_MASK;
>  			data->ps_contr |= i << LTR501_CONTR_PS_GAIN_SHIFT;
> -			return i2c_smbus_write_byte_data(data->client,
> -				LTR501_PS_CONTR, data->ps_contr);
> +
> +			return regmap_write(data->regmap, LTR501_PS_CONTR,
> +					    data->ps_contr);
>  		default:
>  			return -EINVAL;
>  		}
> @@ -255,13 +269,13 @@ static const struct iio_info ltr501_info = {
>  	.driver_module = THIS_MODULE,
>  };
>  
> -static int ltr501_write_contr(struct i2c_client *client, u8 als_val, u8 ps_val)
> +static int ltr501_write_contr(struct ltr501_data *data, u8 als_val, u8 ps_val)
>  {
> -	int ret = i2c_smbus_write_byte_data(client, LTR501_ALS_CONTR, als_val);
> +	int ret = regmap_write(data->regmap, LTR501_ALS_CONTR, als_val);
>  	if (ret < 0)
>  		return ret;
>  
> -	return i2c_smbus_write_byte_data(client, LTR501_PS_CONTR, ps_val);
> +	return regmap_write(data->regmap, LTR501_PS_CONTR, ps_val);
>  }
>  
>  static irqreturn_t ltr501_trigger_handler(int irq, void *p)
> @@ -273,7 +287,7 @@ static irqreturn_t ltr501_trigger_handler(int irq, void *p)
>  	__le16 als_buf[2];
>  	u8 mask = 0;
>  	int j = 0;
> -	int ret;
> +	int ret, psdata;
>  
>  	memset(buf, 0, sizeof(buf));
>  
> @@ -289,8 +303,8 @@ static irqreturn_t ltr501_trigger_handler(int irq, void *p)
>  		goto done;
>  
>  	if (mask & LTR501_STATUS_ALS_RDY) {
> -		ret = i2c_smbus_read_i2c_block_data(data->client,
> -			LTR501_ALS_DATA1, sizeof(als_buf), (u8 *) als_buf);
> +		ret = regmap_bulk_read(data->regmap, LTR501_ALS_DATA1,
> +				       (u8 *) als_buf, sizeof(als_buf));
>  		if (ret < 0)
>  			return ret;
>  		if (test_bit(0, indio_dev->active_scan_mask))
> @@ -300,10 +314,11 @@ static irqreturn_t ltr501_trigger_handler(int irq, void *p)
>  	}
>  
>  	if (mask & LTR501_STATUS_PS_RDY) {
> -		ret = i2c_smbus_read_word_data(data->client, LTR501_PS_DATA);
> +		ret = regmap_bulk_read(data->regmap, LTR501_PS_DATA,
> +				       &psdata, 2);
>  		if (ret < 0)
>  			goto done;
> -		buf[j++] = ret & LTR501_PS_DATA_MASK;
> +		buf[j++] = psdata & LTR501_PS_DATA_MASK;
>  	}
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev, buf,
> @@ -317,43 +332,75 @@ done:
>  
>  static int ltr501_init(struct ltr501_data *data)
>  {
> -	int ret;
> +	int ret, status;
>  
> -	ret = i2c_smbus_read_byte_data(data->client, LTR501_ALS_CONTR);
> +	ret = regmap_read(data->regmap, LTR501_ALS_CONTR, &status);
>  	if (ret < 0)
>  		return ret;
> -	data->als_contr = ret | LTR501_CONTR_ACTIVE;
>  
> -	ret = i2c_smbus_read_byte_data(data->client, LTR501_PS_CONTR);
> +	data->als_contr = status | LTR501_CONTR_ACTIVE;
> +
> +	ret = regmap_read(data->regmap, LTR501_PS_CONTR, &status);
>  	if (ret < 0)
>  		return ret;
> -	data->ps_contr = ret | LTR501_CONTR_ACTIVE;
>  
> -	return ltr501_write_contr(data->client, data->als_contr,
> -		data->ps_contr);
> +	data->ps_contr = status | LTR501_CONTR_ACTIVE;
> +
> +	return ltr501_write_contr(data, data->als_contr, data->ps_contr);
> +}
> +
> +static bool ltr501_is_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case LTR501_ALS_DATA1:
> +	case LTR501_ALS_DATA0:
> +	case LTR501_ALS_PS_STATUS:
> +	case LTR501_PS_DATA:
> +		return true;
> +	default:
> +		return false;
> +	}
>  }
>  
> +static struct regmap_config ltr501_regmap_config = {
> +	.name =  LTR501_REGMAP_NAME,
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = LTR501_MAX_REG,
> +	.cache_type = REGCACHE_RBTREE,
> +	.volatile_reg = ltr501_is_volatile_reg,
> +};
> +
>  static int ltr501_probe(struct i2c_client *client,
>  			  const struct i2c_device_id *id)
>  {
>  	struct ltr501_data *data;
>  	struct iio_dev *indio_dev;
> -	int ret;
> +	struct regmap *regmap;
> +	int ret, partid;
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> +	regmap = devm_regmap_init_i2c(client, &ltr501_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&client->dev, "Regmap initialization failed.\n");
> +		return PTR_ERR(regmap);
> +	}
> +
>  	data = iio_priv(indio_dev);
>  	i2c_set_clientdata(client, indio_dev);
>  	data->client = client;
> +	data->regmap = regmap;
>  	mutex_init(&data->lock_als);
>  	mutex_init(&data->lock_ps);
>  
> -	ret = i2c_smbus_read_byte_data(data->client, LTR501_PART_ID);
> +	ret = regmap_read(data->regmap, LTR501_PART_ID, &partid);
>  	if (ret < 0)
>  		return ret;
> -	if ((ret >> 4) != 0x8)
> +
> +	if ((partid >> 4) != 0x8)
>  		return -ENODEV;
>  
>  	indio_dev->dev.parent = &client->dev;
> @@ -385,9 +432,8 @@ error_unreg_buffer:
>  
>  static int ltr501_powerdown(struct ltr501_data *data)
>  {
> -	return ltr501_write_contr(data->client,
> -		data->als_contr & ~LTR501_CONTR_ACTIVE,
> -		data->ps_contr & ~LTR501_CONTR_ACTIVE);
> +	return ltr501_write_contr(data, data->als_contr & ~LTR501_CONTR_ACTIVE,
> +				  data->ps_contr & ~LTR501_CONTR_ACTIVE);
>  }
>  
>  static int ltr501_remove(struct i2c_client *client)
> @@ -414,7 +460,7 @@ static int ltr501_resume(struct device *dev)
>  	struct ltr501_data *data = iio_priv(i2c_get_clientdata(
>  		to_i2c_client(dev)));
>  
> -	return ltr501_write_contr(data->client, data->als_contr,
> +	return ltr501_write_contr(data, data->als_contr,
>  		data->ps_contr);
>  }
>  #endif
> 

