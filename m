Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40491 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759579AbbKUScc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Nov 2015 13:32:32 -0500
Subject: Re: [PATCH] iio: chemical: vz89x: rework i2c transfer reading
To: Matt Ranostay <mranostay@gmail.com>
References: <1447811389-28509-1-git-send-email-mranostay@gmail.com>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5650B8BE.3060909@kernel.org>
Date: Sat, 21 Nov 2015 18:32:30 +0000
MIME-Version: 1.0
In-Reply-To: <1447811389-28509-1-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/11/15 01:49, Matt Ranostay wrote:
> Remove racey i2c_smbus_read_byte() calls in measurement
> reading function with an single i2c_transfer.
> 
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
As with the lidar sensor, this requires a more sophisticated I2C master
so you should be checking if it is capable of doing what you need here.
Also, ideally provide a fallback to smbus for those cases where the
controller isn't sophisticated enough with appropriate locking to protect
the device...

Jonathan
> ---
>  drivers/iio/chemical/vz89x.c | 33 +++++++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/chemical/vz89x.c b/drivers/iio/chemical/vz89x.c
> index 11e59a5..c03f988 100644
> --- a/drivers/iio/chemical/vz89x.c
> +++ b/drivers/iio/chemical/vz89x.c
> @@ -100,27 +100,40 @@ static int vz89x_measurement_is_valid(struct vz89x_data *data)
>  	return !!(data->buffer[VZ89X_REG_MEASUREMENT_SIZE - 1] > 0);
>  }
>  
> +static int vz89x_i2c_xfer(struct vz89x_data *data, u8 cmd)
> +{
> +	struct i2c_client *client = data->client;
> +	struct i2c_msg msg[2];
> +	int ret;
> +	u8 buf[3] = { cmd, 0, 0};
> +
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
> +
> +	return (ret == VZ89X_REG_MEASUREMENT_SIZE) ? 0 : ret;
> +}
> +
>  static int vz89x_get_measurement(struct vz89x_data *data)
>  {
>  	int ret;
> -	int i;
>  
>  	/* sensor can only be polled once a second max per datasheet */
>  	if (!time_after(jiffies, data->last_update + HZ))
>  		return 0;
>  
> -	ret = i2c_smbus_write_word_data(data->client,
> -					VZ89X_REG_MEASUREMENT, 0);
> +	ret = vz89x_i2c_xfer(data, VZ89X_REG_MEASUREMENT);
>  	if (ret < 0)
>  		return ret;
>  
> -	for (i = 0; i < VZ89X_REG_MEASUREMENT_SIZE; i++) {
> -		ret = i2c_smbus_read_byte(data->client);
> -		if (ret < 0)
> -			return ret;
> -		data->buffer[i] = ret;
> -	}
> -
>  	ret = vz89x_measurement_is_valid(data);
>  	if (ret)
>  		return -EAGAIN;
> 

