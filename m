Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59094 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752564AbbEQJ3k (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 May 2015 05:29:40 -0400
Message-ID: <55585F83.3040705@kernel.org>
Date: Sun, 17 May 2015 10:29:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Martin Fuzzey <mfuzzey@parkeon.com>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [PATCH V4 1/7] iio: mma8452: Initialise before activating
References: <20150513102635.27803.99054.stgit@localhost> <20150513102638.27803.95440.stgit@localhost>
In-Reply-To: <20150513102638.27803.95440.stgit@localhost>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/05/15 11:26, Martin Fuzzey wrote:
> Many of the hardware configuration registers may only be modified while the
> device is inactive.
> 
> Currently the probe code first activates the device and then modifies the
> registers (eg to set the scale). This doesn't actually work but is not
> noticed since the scale used is the default value.
> 
> While at it also issue a hardware reset command at probe time.
> 
> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
Applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/accel/mma8452.c |   37 +++++++++++++++++++++++++++++++++----
>  1 file changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 5b80657..001a7db 100644
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
> +					MMA8452_CTRL_REG2_RST);
> +	if (ret < 0)
> +		return ret;
> +
> +	for (i = 0; i < 10; i++) {
> +		usleep_range(100, 200);
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
> +					data->ctrl_reg1);
> +	if (ret < 0)
> +		return ret;
> +
>  	ret = iio_triggered_buffer_setup(indio_dev, NULL,
>  		mma8452_trigger_handler, NULL);
>  	if (ret < 0)
> 

