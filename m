Return-Path: <pmeerw@pmeerw.net>
Date: Mon, 16 Feb 2015 20:26:11 +0100 (CET)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Irina Tirdea <irina.tirdea@intel.com>
cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
    Adriana Reus <adriana.reus@intel.com>
Subject: Re: [PATCH 2/2] iio: accel: kxcjk-1013: optimize i2c transfers in
 trigger handler
In-Reply-To: <1424110909-16878-3-git-send-email-irina.tirdea@intel.com>
Message-ID: <alpine.DEB.2.02.1502162014280.26763@pmeerw.net>
References: <1424110909-16878-1-git-send-email-irina.tirdea@intel.com> <1424110909-16878-3-git-send-email-irina.tirdea@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


> Reading all axis values in one i2c transfer reduces the delays
> introduced by the i2c bus. In case i2c block read is not supported,
> fallback to reading each axis as a separate word.

see comments inline below
 
> Signed-off-by: Adriana Reus <adriana.reus@intel.com>
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/iio/accel/kxcjk-1013.c | 44 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 35 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 5f27787..bfa2899 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -109,6 +109,8 @@ struct kxcjk1013_data {
>  	int64_t timestamp;
>  	enum kx_chipset chipset;
>  	bool is_smo8500_device;
> +	s32 (*read_block_data)(const struct i2c_client *client, u8 command,
> +			       u8 length, u8 *values);

probably this could/should be done in the i2c layer or we end up adding a 
similar function in every driver?

>  };
>  
>  enum kxcjk1013_axis {
> @@ -216,6 +218,23 @@ static const struct {
>  				 {800, 0, 0x06},
>  				 {1600, 0, 0x06} };
>  
> +static s32 kxcjk1013_read_block_data(const struct i2c_client *client,
> +				     u8 command, u8 length, u8 *values)
> +{
> +	s32 data;
> +	u8 i;
> +
> +	for (i = 0; i < length; i += 2) {
> +		data = i2c_smbus_read_word_data(client, command + i);
> +		if (data < 0)
> +			return data;
> +
> +		values[i] = data & 0xFF;
> +		values[i+1] = data >> 8;

this is incorrect; it forces the data to be little endian, however, the 
endianness (as specified in the driver's .scan_type) is IIO_CPU -- the 
code breaks for big-endian CPUs

since _read_i2c_block_data() can't do endianness conversion (and the chip 
does i2c endianness, i.e. little-endian), the .scan_type should become 
IIO_LE and above code is correct again but still ugly :)

bottom line: change .scan_type to IIO_LE

> +	}
> +	return i;
> +}
> +
>  static int kxcjk1013_set_mode(struct kxcjk1013_data *data,
>  			      enum kxcjk1013_mode mode)
>  {
> @@ -955,18 +974,14 @@ static irqreturn_t kxcjk1013_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct kxcjk1013_data *data = iio_priv(indio_dev);
> -	int bit, ret, i = 0;
> +	int ret;
>  
>  	mutex_lock(&data->mutex);
> -	for (bit = 0; bit < AXIS_MAX; bit++) {
> -		ret = kxcjk1013_get_acc_reg(data, bit);
> -		if (ret < 0) {
> -			mutex_unlock(&data->mutex);
> -			goto err;
> -		}
> -		data->buffer[i++] = ret;
> -	}
> +	ret = data->read_block_data(data->client, KXCJK1013_REG_XOUT_L,
> +				    AXIS_MAX * 2, (u8 *) data->buffer);
>  	mutex_unlock(&data->mutex);
> +	if (ret < 0)
> +		goto err;
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
>  					   data->timestamp);
> @@ -1196,6 +1211,11 @@ static int kxcjk1013_probe(struct i2c_client *client,
>  	const char *name;
>  	int ret;
>  
> +	if (!i2c_check_functionality(client->adapter,
> +				     I2C_FUNC_SMBUS_BYTE_DATA |
> +				     I2C_FUNC_SMBUS_READ_WORD_DATA))
> +		return -ENODEV;
> +
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>  	if (!indio_dev)
>  		return -ENOMEM;
> @@ -1204,6 +1224,12 @@ static int kxcjk1013_probe(struct i2c_client *client,
>  	i2c_set_clientdata(client, indio_dev);
>  	data->client = client;
>  
> +	if (i2c_check_functionality(client->adapter,
> +				    I2C_FUNC_SMBUS_READ_I2C_BLOCK))
> +		data->read_block_data = i2c_smbus_read_i2c_block_data;
> +	else
> +		data->read_block_data = kxcjk1013_read_block_data;
> +
>  	pdata = dev_get_platdata(&client->dev);
>  	if (pdata)
>  		data->active_high_intr = pdata->active_high_intr;
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
