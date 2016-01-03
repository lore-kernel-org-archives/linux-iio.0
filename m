Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57711 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543AbcACSFi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Jan 2016 13:05:38 -0500
Subject: Re: [PATCH] Staging: iio: cdc: Fix Alignment should match open
 parenthesis
To: Shraddha Barke <shraddha.6596@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>
References: <1451319262-4631-1-git-send-email-shraddha.6596@gmail.com>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <568962EF.2070907@kernel.org>
Date: Sun, 3 Jan 2016 18:05:35 +0000
MIME-Version: 1.0
In-Reply-To: <1451319262-4631-1-git-send-email-shraddha.6596@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/12/15 16:14, Shraddha Barke wrote:
> Patch fixes the checkpatch warning "Alignment should match open 
> parenthesis"
> 
> Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>
Hi Shraddha,

In principle these sorts of changes are good in my view, however
a few issues inline where the result has gone a bit wrong / less readable!

Jonathan
> ---
>  drivers/staging/iio/cdc/ad7746.c | 42 +++++++++++++++++++++-------------------
>  1 file changed, 22 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index 2c5d277..8c371e3 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -212,7 +212,7 @@ static const unsigned char ad7746_cap_filter_rate_table[][2] = {
>  };
>  
>  static int ad7746_select_channel(struct iio_dev *indio_dev,
> -			    struct iio_chan_spec const *chan)
> +				 struct iio_chan_spec const *chan)
>  {
>  	struct ad7746_chip_info *chip = iio_priv(indio_dev);
>  	int ret, delay;
> @@ -227,12 +227,12 @@ static int ad7746_select_channel(struct iio_dev *indio_dev,
>  
>  		if (chip->capdac_set != chan->channel) {
>  			ret = i2c_smbus_write_byte_data(chip->client,
> -				AD7746_REG_CAPDACA,
> -				chip->capdac[chan->channel][0]);
> +							AD7746_REG_CAPDACA,
> +			chip->capdac[chan->channel][0]);
This last line is still an argument of the function call. It should be indented
the same as the other arguments.  However that will then over run the 80 char
line count.  This is often the reason we elect to do a non standard argument
alignment.  Here I think the original choice was actually the best option
under the circumstances.
>  			if (ret < 0)
>  				return ret;
>  			ret = i2c_smbus_write_byte_data(chip->client,
> -				AD7746_REG_CAPDACB,
> +							AD7746_REG_CAPDACB,
>  				chip->capdac[chan->channel][1]);
>  			if (ret < 0)
>  				return ret;
> @@ -356,8 +356,8 @@ static IIO_DEVICE_ATTR(in_voltage0_calibscale_calibration,
>  		       S_IWUSR, NULL, ad7746_start_gain_calib, VIN);
>  
>  static ssize_t ad7746_show_cap_filter_rate_setup(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +						 struct device_attribute *attr,
> +						 char *buf)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ad7746_chip_info *chip = iio_priv(indio_dev);
> @@ -367,9 +367,9 @@ static ssize_t ad7746_show_cap_filter_rate_setup(struct device *dev,
>  }
>  
>  static ssize_t ad7746_store_cap_filter_rate_setup(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> +						  struct device_attribute *attr,
> +						  const char *buf,
> +						  size_t len)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ad7746_chip_info *chip = iio_priv(indio_dev);
> @@ -396,8 +396,8 @@ static ssize_t ad7746_store_cap_filter_rate_setup(struct device *dev,
>  }
>  
>  static ssize_t ad7746_show_vt_filter_rate_setup(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +						struct device_attribute *attr,
> +						char *buf)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ad7746_chip_info *chip = iio_priv(indio_dev);
> @@ -407,9 +407,9 @@ static ssize_t ad7746_show_vt_filter_rate_setup(struct device *dev,
>  }
>  
>  static ssize_t ad7746_store_vt_filter_rate_setup(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> +						 struct device_attribute *attr,
> +						 const char *buf,
> +						 size_t len)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ad7746_chip_info *chip = iio_priv(indio_dev);
> @@ -509,7 +509,8 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
>  			goto out;
>  		}
>  		ret = i2c_smbus_write_word_data(chip->client,
> -				AD7746_REG_CAP_OFFH, swab16(val));
> +						AD7746_REG_CAP_OFFH,
> +						swab16(val));
>  		if (ret < 0)
>  			goto out;
>  
> @@ -533,12 +534,12 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
>  			AD7746_CAPDAC_DACP(val) | AD7746_CAPDAC_DACEN : 0);
>  
>  		ret = i2c_smbus_write_byte_data(chip->client,
> -			AD7746_REG_CAPDACA,
> +						AD7746_REG_CAPDACA,
>  			chip->capdac[chan->channel][0]);
This is the same issue as above - aligning different arguments to different
points doesn't make good sense from the point of view of readability.
>  		if (ret < 0)
>  			goto out;
>  		ret = i2c_smbus_write_byte_data(chip->client,
> -			AD7746_REG_CAPDACB,
> +						AD7746_REG_CAPDACB,
>  			chip->capdac[chan->channel][1]);
>  		if (ret < 0)
>  			goto out;
> @@ -577,7 +578,7 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
>  
>  		regval = chip->config | AD7746_CONF_MODE_SINGLE_CONV;
>  		ret = i2c_smbus_write_byte_data(chip->client, AD7746_REG_CFG,
> -				regval);
> +						regval);
>  		if (ret < 0)
>  			goto out;
>  
> @@ -585,7 +586,8 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
>  		/* Now read the actual register */
>  
>  		ret = i2c_smbus_read_i2c_block_data(chip->client,
> -			chan->address >> 8, 3, &chip->data.d8[1]);
> +						    chan->address >> 8, 3,
> +						    &chip->data.d8[1]);
>  
>  		if (ret < 0)
>  			goto out;
> @@ -687,7 +689,7 @@ static const struct iio_info ad7746_info = {
>   */
>  
>  static int ad7746_probe(struct i2c_client *client,
> -		const struct i2c_device_id *id)
> +			const struct i2c_device_id *id)
>  {
>  	struct ad7746_platform_data *pdata = client->dev.platform_data;
>  	struct ad7746_chip_info *chip;
> 

