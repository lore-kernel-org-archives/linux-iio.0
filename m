Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:56552 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932674AbaGWSgi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 23 Jul 2014 14:36:38 -0400
Date: Wed, 23 Jul 2014 20:36:36 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Martin Fuzzey <mfuzzey@parkeon.com>
cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 7/8] iio: mma8452: add an attribute to enable the highpass
 filter
In-Reply-To: <20140723171734.22067.95323.stgit@localhost>
Message-ID: <alpine.DEB.2.01.1407232035090.21518@pmeerw.net>
References: <20140723171719.22067.79447.stgit@localhost> <20140723171734.22067.95323.stgit@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> The hardware contains a single configurable highpass filter which
> is normally used for transient detection (event).
> 
> However it is also possible to enable this filter for normal channel
> reading. Add a new attribute in_accel_high_pass_filter_en to do this.

the patch moves around many lines of code, can likely be made much more 
compact
 
> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
> ---
>  drivers/iio/accel/mma8452.c |  115 +++++++++++++++++++++++++++++--------------
>  1 file changed, 78 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 66933b2..c56d34e 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -62,6 +62,7 @@
>  #define MMA8452_DATA_CFG_FS_2G 0
>  #define MMA8452_DATA_CFG_FS_4G 1
>  #define MMA8452_DATA_CFG_FS_8G 2
> +#define MMA8452_DATA_CFG_HPF_MASK BIT(4)
>  
>  #define MMA8452_INT_DRDY	BIT(0)
>  #define MMA8452_INT_FF_MT	BIT(2)
> @@ -106,6 +107,43 @@ static int mma8452_read(struct mma8452_data *data, __be16 buf[3])
>  		MMA8452_OUT_X, 3 * sizeof(__be16), (u8 *) buf);
>  }
>  
> +static int mma8452_standby(struct mma8452_data *data)
> +{
> +	return i2c_smbus_write_byte_data(data->client, MMA8452_CTRL_REG1,
> +		data->ctrl_reg1 & ~MMA8452_CTRL_ACTIVE);
> +}
> +
> +static int mma8452_active(struct mma8452_data *data)
> +{
> +	return i2c_smbus_write_byte_data(data->client, MMA8452_CTRL_REG1,
> +		data->ctrl_reg1);
> +}
> +
> +static int mma8452_change_config(struct mma8452_data *data, u8 reg, u8 val)
> +{
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +
> +	/* config can only be changed when in standby */
> +	ret = mma8452_standby(data);
> +	if (ret < 0)
> +		goto fail;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, reg, val);
> +	if (ret < 0)
> +		goto fail;
> +
> +	ret = mma8452_active(data);
> +	if (ret < 0)
> +		goto fail;
> +
> +	ret = 0;
> +fail:
> +	mutex_unlock(&data->lock);
> +	return ret;
> +}
> +
>  static ssize_t mma8452_show_int_plus_micros(char *buf,
>  	const int (*vals)[2], int n)
>  {
> @@ -201,11 +239,50 @@ static ssize_t mma8452_show_hp_cutoff_avail(struct device *dev,
>  		ARRAY_SIZE(mma8452_hp_filter_cutoff[0]));
>  }
>  
> +static ssize_t mma8452_show_hp_cutoff_en(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct mma8452_data *data = iio_priv(indio_dev);
> +
> +	return sprintf(buf, "%d\n",
> +		data->data_cfg & MMA8452_DATA_CFG_HPF_MASK ? 1 : 0);
> +}
> +
> +static ssize_t mma8452_store_hp_cutoff_en(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct mma8452_data *data = iio_priv(indio_dev);
> +	bool state;
> +	int ret;
> +
> +	ret = strtobool(buf, &state);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (state)
> +		data->data_cfg |= MMA8452_DATA_CFG_HPF_MASK;
> +	else
> +		data->data_cfg &= ~MMA8452_DATA_CFG_HPF_MASK;
> +
> +	ret = mma8452_change_config(data, MMA8452_DATA_CFG, data->data_cfg);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
>  static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(mma8452_show_samp_freq_avail);
>  static IIO_DEVICE_ATTR(in_accel_scale_available, S_IRUGO,
>  	mma8452_show_scale_avail, NULL, 0);
>  static IIO_DEVICE_ATTR(in_accel_filter_high_pass_3db_frequency_available,
>  			S_IRUGO, mma8452_show_hp_cutoff_avail, NULL, 0);
> +static IIO_DEVICE_ATTR(in_accel_filter_high_pass_en,
> +			 S_IRUGO | S_IWUSR,
> +			 mma8452_show_hp_cutoff_en,
> +			 mma8452_store_hp_cutoff_en, 0);
>  
>  static int mma8452_get_samp_freq_index(struct mma8452_data *data,
>  	int val, int val2)
> @@ -282,43 +359,6 @@ static int mma8452_read_raw(struct iio_dev *indio_dev,
>  	return -EINVAL;
>  }
>  
> -static int mma8452_standby(struct mma8452_data *data)
> -{
> -	return i2c_smbus_write_byte_data(data->client, MMA8452_CTRL_REG1,
> -		data->ctrl_reg1 & ~MMA8452_CTRL_ACTIVE);
> -}
> -
> -static int mma8452_active(struct mma8452_data *data)
> -{
> -	return i2c_smbus_write_byte_data(data->client, MMA8452_CTRL_REG1,
> -		data->ctrl_reg1);
> -}
> -
> -static int mma8452_change_config(struct mma8452_data *data, u8 reg, u8 val)
> -{
> -	int ret;
> -
> -	mutex_lock(&data->lock);
> -
> -	/* config can only be changed when in standby */
> -	ret = mma8452_standby(data);
> -	if (ret < 0)
> -		goto fail;
> -
> -	ret = i2c_smbus_write_byte_data(data->client, reg, val);
> -	if (ret < 0)
> -		goto fail;
> -
> -	ret = mma8452_active(data);
> -	if (ret < 0)
> -		goto fail;
> -
> -	ret = 0;
> -fail:
> -	mutex_unlock(&data->lock);
> -	return ret;
> -}
> -
>  static int mma8452_write_raw(struct iio_dev *indio_dev,
>  			     struct iio_chan_spec const *chan,
>  			     int val, int val2, long mask)
> @@ -636,6 +676,7 @@ static struct attribute *mma8452_attributes[] = {
>  	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
>  	&iio_dev_attr_in_accel_scale_available.dev_attr.attr,
>  	&iio_dev_attr_in_accel_filter_high_pass_3db_frequency_available.dev_attr.attr,
> +	&iio_dev_attr_in_accel_filter_high_pass_en.dev_attr.attr,
>  	NULL
>  };
>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
