Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57049 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762344Ab3JQVsi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 17 Oct 2013 17:48:38 -0400
Message-ID: <5260696B.1050509@kernel.org>
Date: Thu, 17 Oct 2013 23:49:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 03/11] staging:iio:hmc5843: Always read all channels
 values otherwise no updates
References: <1381961954-25596-1-git-send-email-pmeerw@pmeerw.net> <1381961954-25596-4-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1381961954-25596-4-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/16/13 23:19, Peter Meerwald wrote:
> v2:
> * use __be16 instead of s16
> 
> Split out data ready/wait for read measurement
> fix bug in case reading status register fails
> 
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/staging/iio/magnetometer/hmc5843.c | 53 ++++++++++++++++++------------
>  1 file changed, 32 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
> index 749b0b6..78b97b0 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843.c
> @@ -28,12 +28,7 @@
>  #define HMC5843_CONFIG_REG_A			0x00
>  #define HMC5843_CONFIG_REG_B			0x01
>  #define HMC5843_MODE_REG			0x02
> -#define HMC5843_DATA_OUT_X_MSB_REG		0x03
> -#define HMC5843_DATA_OUT_Y_MSB_REG		0x05
> -#define HMC5843_DATA_OUT_Z_MSB_REG		0x07
> -/* Beware: Y and Z are exchanged on HMC5883 */
> -#define HMC5883_DATA_OUT_Z_MSB_REG		0x05
> -#define HMC5883_DATA_OUT_Y_MSB_REG		0x07
> +#define HMC5843_DATA_OUT_MSB_REGS		0x03
>  #define HMC5843_STATUS_REG			0x09
>  
>  enum hmc5843_ids {
> @@ -140,17 +135,16 @@ static s32 hmc5843_configure(struct i2c_client *client,
>  					operating_mode & HMC5843_MODE_MASK);
>  }
>  
> -/* Return the measurement value from the specified channel */
> -static int hmc5843_read_measurement(struct hmc5843_data *data,
> -				    int address, int *val)
> +static int hmc5843_wait_measurement(struct hmc5843_data *data)
>  {
>  	s32 result;
>  	int tries = 150;
>  
> -	mutex_lock(&data->lock);
>  	while (tries-- > 0) {
>  		result = i2c_smbus_read_byte_data(data->client,
>  			HMC5843_STATUS_REG);
> +		if (result < 0)
> +			return result;
>  		if (result & HMC5843_DATA_READY)
>  			break;
>  		msleep(20);
> @@ -158,16 +152,32 @@ static int hmc5843_read_measurement(struct hmc5843_data *data,
>  
>  	if (tries < 0) {
>  		dev_err(&data->client->dev, "data not ready\n");
> -		mutex_unlock(&data->lock);
>  		return -EIO;
>  	}
>  
> -	result = i2c_smbus_read_word_swapped(data->client, address);
> +	return 0;
> +}
> +
> +/* Return the measurement value from the specified channel */
> +static int hmc5843_read_measurement(struct hmc5843_data *data,
> +				    int idx, int *val)
> +{
> +	s32 result;
> +	__be16 values[3];
> +
> +	mutex_lock(&data->lock);
> +	result = hmc5843_wait_measurement(data);
> +	if (result < 0) {
> +		mutex_unlock(&data->lock);
> +		return result;
> +	}
> +	result = i2c_smbus_read_i2c_block_data(data->client,
> +		HMC5843_DATA_OUT_MSB_REGS, sizeof(values), (u8 *) values);
>  	mutex_unlock(&data->lock);
>  	if (result < 0)
>  		return -EINVAL;
>  
> -	*val = sign_extend32(result, 15);
> +	*val = sign_extend32(be16_to_cpu(values[idx]), 15);
>  	return IIO_VAL_INT;
>  }
>  
> @@ -458,7 +468,7 @@ static int hmc5843_write_raw_get_fmt(struct iio_dev *indio_dev,
>  	}
>  }
>  
> -#define HMC5843_CHANNEL(axis, addr)					\
> +#define HMC5843_CHANNEL(axis, idx)					\
>  	{								\
>  		.type = IIO_MAGN,					\
>  		.modified = 1,						\
> @@ -466,19 +476,20 @@ static int hmc5843_write_raw_get_fmt(struct iio_dev *indio_dev,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
>  			BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
> -		.address = addr						\
> +		.address = idx						\
>  	}
>  
>  static const struct iio_chan_spec hmc5843_channels[] = {
> -	HMC5843_CHANNEL(X, HMC5843_DATA_OUT_X_MSB_REG),
> -	HMC5843_CHANNEL(Y, HMC5843_DATA_OUT_Y_MSB_REG),
> -	HMC5843_CHANNEL(Z, HMC5843_DATA_OUT_Z_MSB_REG),
> +	HMC5843_CHANNEL(X, 0),
> +	HMC5843_CHANNEL(Y, 1),
> +	HMC5843_CHANNEL(Z, 2),
>  };
>  
> +/* Beware: Y and Z are exchanged on HMC5883 */
>  static const struct iio_chan_spec hmc5883_channels[] = {
> -	HMC5843_CHANNEL(X, HMC5843_DATA_OUT_X_MSB_REG),
> -	HMC5843_CHANNEL(Y, HMC5883_DATA_OUT_Y_MSB_REG),
> -	HMC5843_CHANNEL(Z, HMC5883_DATA_OUT_Z_MSB_REG),
> +	HMC5843_CHANNEL(X, 0),
> +	HMC5843_CHANNEL(Z, 1),
> +	HMC5843_CHANNEL(Y, 2),
>  };
>  
>  static struct attribute *hmc5843_attributes[] = {
> 
