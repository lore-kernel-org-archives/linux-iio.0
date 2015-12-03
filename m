Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48447 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752406AbbLCSfH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 3 Dec 2015 13:35:07 -0500
Subject: Re: [PATCH v3 1/1] iio: chemical: vz89x: rework i2c transfer reading
To: Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org
References: <1449035240-31044-1-git-send-email-mranostay@gmail.com>
 <1449035240-31044-2-git-send-email-mranostay@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56608B56.10401@kernel.org>
Date: Thu, 3 Dec 2015 18:35:02 +0000
MIME-Version: 1.0
In-Reply-To: <1449035240-31044-2-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/12/15 05:47, Matt Ranostay wrote:
> Add an optimized i2c transfer reading function, and fallback
> to racey smbus transfers if client->adapter doesn't support this.
> 
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
Hmm. The change from V2 is always an interesting one...  Partial transfers
are rather unusual and usually mean thoroughly broken hardware..

Ah well, I don't really care either way so applied this version to the togreg
branch of iio.git - pushed out as testing.
> ---
>  drivers/iio/chemical/vz89x.c | 66 ++++++++++++++++++++++++++++++++++----------
>  1 file changed, 52 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/chemical/vz89x.c b/drivers/iio/chemical/vz89x.c
> index 11e59a5..b8b8049 100644
> --- a/drivers/iio/chemical/vz89x.c
> +++ b/drivers/iio/chemical/vz89x.c
> @@ -34,8 +34,9 @@
>  struct vz89x_data {
>  	struct i2c_client *client;
>  	struct mutex lock;
> -	unsigned long last_update;
> +	int (*xfer)(struct vz89x_data *data, u8 cmd);
>  
> +	unsigned long last_update;
>  	u8 buffer[VZ89X_REG_MEASUREMENT_SIZE];
>  };
>  
> @@ -100,27 +101,60 @@ static int vz89x_measurement_is_valid(struct vz89x_data *data)
>  	return !!(data->buffer[VZ89X_REG_MEASUREMENT_SIZE - 1] > 0);
>  }
>  
> -static int vz89x_get_measurement(struct vz89x_data *data)
> +static int vz89x_i2c_xfer(struct vz89x_data *data, u8 cmd)
>  {
> +	struct i2c_client *client = data->client;
> +	struct i2c_msg msg[2];
>  	int ret;
> -	int i;
> +	u8 buf[3] = { cmd, 0, 0};
>  
> -	/* sensor can only be polled once a second max per datasheet */
> -	if (!time_after(jiffies, data->last_update + HZ))
> -		return 0;
> +	msg[0].addr = client->addr;
> +	msg[0].flags = client->flags;
> +	msg[0].len = 3;
> +	msg[0].buf  = (char *) &buf;
> +
> +	msg[1].addr = client->addr;
> +	msg[1].flags = client->flags | I2C_M_RD;
> +	msg[1].len = VZ89X_REG_MEASUREMENT_SIZE;
> +	msg[1].buf = (char *) &data->buffer;
> +
> +	ret = i2c_transfer(client->adapter, msg, 2);
>  
> -	ret = i2c_smbus_write_word_data(data->client,
> -					VZ89X_REG_MEASUREMENT, 0);
> +	return (ret == 2) ? 0 : ret;
> +}
> +
> +static int vz89x_smbus_xfer(struct vz89x_data *data, u8 cmd)
> +{
> +	struct i2c_client *client = data->client;
> +	int ret;
> +	int i;
> +
> +	ret = i2c_smbus_write_word_data(client, cmd, 0);
>  	if (ret < 0)
>  		return ret;
>  
>  	for (i = 0; i < VZ89X_REG_MEASUREMENT_SIZE; i++) {
> -		ret = i2c_smbus_read_byte(data->client);
> +		ret = i2c_smbus_read_byte(client);
>  		if (ret < 0)
>  			return ret;
>  		data->buffer[i] = ret;
>  	}
>  
> +	return 0;
> +}
> +
> +static int vz89x_get_measurement(struct vz89x_data *data)
> +{
> +	int ret;
> +
> +	/* sensor can only be polled once a second max per datasheet */
> +	if (!time_after(jiffies, data->last_update + HZ))
> +		return 0;
> +
> +	ret = data->xfer(data, VZ89X_REG_MEASUREMENT);
> +	if (ret < 0)
> +		return ret;
> +
>  	ret = vz89x_measurement_is_valid(data);
>  	if (ret)
>  		return -EAGAIN;
> @@ -204,15 +238,19 @@ static int vz89x_probe(struct i2c_client *client,
>  	struct iio_dev *indio_dev;
>  	struct vz89x_data *data;
>  
> -	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA |
> -				     I2C_FUNC_SMBUS_BYTE))
> -		return -ENODEV;
> -
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>  	if (!indio_dev)
>  		return -ENOMEM;
> -
>  	data = iio_priv(indio_dev);
> +
> +	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> +		data->xfer = vz89x_i2c_xfer;
> +	else if (i2c_check_functionality(client->adapter,
> +				I2C_FUNC_SMBUS_WORD_DATA | I2C_FUNC_SMBUS_BYTE))
> +		data->xfer = vz89x_smbus_xfer;
> +	else
> +		return -ENOTSUPP;
> +
>  	i2c_set_clientdata(client, indio_dev);
>  	data->client = client;
>  	data->last_update = jiffies - HZ;
> 

