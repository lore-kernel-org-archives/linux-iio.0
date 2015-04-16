Return-Path: <knaack.h@gmx.de>
Message-ID: <55301CE7.2050307@gmx.de>
Date: Thu, 16 Apr 2015 22:34:47 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Martin Fuzzey <mfuzzey@parkeon.com>, linux-iio@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 1/9] iio: mma8452: Initialise before activating
References: <20150219141553.27001.18825.stgit@localhost> <20150219141556.27001.96911.stgit@localhost>
In-Reply-To: <20150219141556.27001.96911.stgit@localhost>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Martin Fuzzey schrieb am 19.02.2015 um 15:15:
> Many of the hardware configuration registers may only be modified while the
> device is inactive.
> 
> Currently the probe code first activates the device and then modifies the
> registers (eg to set the scale). This doesn't actually work but is not
> noticed since the scale used is the default value.
> 
> While at it also issue a hardware reset command at probe time.
> 

Hi Martin,
checkpatch.pl with strict option recommends the following:

CHECK: Alignment should match open parenthesis
#48: FILE: drivers/iio/accel/mma8452.c:345:
+       ret = i2c_smbus_write_byte_data(client, MMA8452_CTRL_REG2,
+                                               MMA8452_CTRL_REG2_RST);

CHECK: usleep_range is preferred over udelay; see Documentation/timers/timers-howto.txt
#53: FILE: drivers/iio/accel/mma8452.c:350:
+               udelay(100);

CHECK: Alignment should match open parenthesis
#88: FILE: drivers/iio/accel/mma8452.c:406:
+       ret = i2c_smbus_write_byte_data(client, MMA8452_CTRL_REG1,
+               data->ctrl_reg1);

Since your use of udelay is not critically in regard of timing, checkpatchs 
recommendation seems valid.
Thanks,
Hartmut

> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
> ---
>  drivers/iio/accel/mma8452.c |   39 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 34 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 3c12d49..04a4f34 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -32,6 +32,7 @@
>  #define MMA8452_OFF_Z 0x31
>  #define MMA8452_CTRL_REG1 0x2a
>  #define MMA8452_CTRL_REG2 0x2b
> +#define MMA8452_CTRL_REG2_RST		BIT(6)
>  
>  #define MMA8452_STATUS_DRDY (BIT(2) | BIT(1) | BIT(0))
>  
> @@ -111,7 +112,7 @@ static const int mma8452_samp_freq[8][2] = {
>  	{6, 250000}, {1, 560000}
>  };
>  
> -/* 
> +/*
>   * Hardware has fullscale of -2G, -4G, -8G corresponding to raw value -2048
>   * The userspace interface uses m/s^2 and we declare micro units
>   * So scale factor is given by:
> @@ -335,6 +336,30 @@ static const struct iio_info mma8452_info = {
>  
>  static const unsigned long mma8452_scan_masks[] = {0x7, 0};
>  
> +static int mma8452_reset(struct i2c_client *client)
> +{
> +	int i;
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(client,	MMA8452_CTRL_REG2,
> +						MMA8452_CTRL_REG2_RST);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < 10; i++) {
> +		udelay(100);
> +		ret = i2c_smbus_read_byte_data(client, MMA8452_CTRL_REG2);
> +		if (ret == -EIO)
> +			continue; /* I2C comm reset */
> +		if (ret < 0)
> +			return ret;
> +		if (!(ret & MMA8452_CTRL_REG2_RST))
> +			return 0;
> +	}
> +
> +	return -ETIMEDOUT;
> +}
> +
>  static int mma8452_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
> @@ -365,10 +390,7 @@ static int mma8452_probe(struct i2c_client *client,
>  	indio_dev->num_channels = ARRAY_SIZE(mma8452_channels);
>  	indio_dev->available_scan_masks = mma8452_scan_masks;
>  
> -	data->ctrl_reg1 = MMA8452_CTRL_ACTIVE |
> -		(MMA8452_CTRL_DR_DEFAULT << MMA8452_CTRL_DR_SHIFT);
> -	ret = i2c_smbus_write_byte_data(client, MMA8452_CTRL_REG1,
> -		data->ctrl_reg1);
> +	ret = mma8452_reset(client);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -378,6 +400,13 @@ static int mma8452_probe(struct i2c_client *client,
>  	if (ret < 0)
>  		return ret;
>  
> +	data->ctrl_reg1 = MMA8452_CTRL_ACTIVE |
> +		(MMA8452_CTRL_DR_DEFAULT << MMA8452_CTRL_DR_SHIFT);
> +	ret = i2c_smbus_write_byte_data(client, MMA8452_CTRL_REG1,
> +		data->ctrl_reg1);
> +	if (ret < 0)
> +		return ret;
> +
>  	ret = iio_triggered_buffer_setup(indio_dev, NULL,
>  		mma8452_trigger_handler, NULL);
>  	if (ret < 0)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
