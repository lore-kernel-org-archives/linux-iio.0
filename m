Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59067 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964799AbbHHPa7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Aug 2015 11:30:59 -0400
Subject: Re: [PATCH 1/2] iio:accel:bmc150-accel: Move bmc150_accel_chip_init()
To: Bastien Nocera <hadess@hadess.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <1437664859.2863.12.camel@hadess.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55C620B0.4050709@kernel.org>
Date: Sat, 8 Aug 2015 16:30:56 +0100
MIME-Version: 1.0
In-Reply-To: <1437664859.2863.12.camel@hadess.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/07/15 16:20, Bastien Nocera wrote:
> Move bmc150_accel_chip_init() so that we can use
> bmc150_accel_chip_info_tbl[] in it.
> 
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
Whilst it would be nice to have this in stable etc it's going to need
some backporting.  For now I've applied it by hand to the togreg
branch of iio.git (late in cycle so I'm wary of pushing this out
in a fixes patchset).

I have marked it as for stable, but it almost certainly won't apply as is.
(or at least the chances of both applying is rather small!)

Jonathan
> ---
>  drivers/iio/accel/bmc150-accel.c | 118 +++++++++++++++++++--------------------
>  1 file changed, 59 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
> index cc5a357..2ec9b56 100644
> --- a/drivers/iio/accel/bmc150-accel.c
> +++ b/drivers/iio/accel/bmc150-accel.c
> @@ -345,65 +345,6 @@ static int bmc150_accel_any_motion_setup(struct bmc150_accel_trigger *t,
>  	return 0;
>  }
>  
> -static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
> -{
> -	int ret;
> -
> -	ret = i2c_smbus_read_byte_data(data->client, BMC150_ACCEL_REG_CHIP_ID);
> -	if (ret < 0) {
> -		dev_err(&data->client->dev,
> -			"Error: Reading chip id\n");
> -		return ret;
> -	}
> -
> -	dev_dbg(&data->client->dev, "Chip Id %x\n", ret);
> -	if (ret != data->chip_info->chip_id) {
> -		dev_err(&data->client->dev, "Invalid chip %x\n", ret);
> -		return -ENODEV;
> -	}
> -
> -	ret = bmc150_accel_set_mode(data, BMC150_ACCEL_SLEEP_MODE_NORMAL, 0);
> -	if (ret < 0)
> -		return ret;
> -
> -	/* Set Bandwidth */
> -	ret = bmc150_accel_set_bw(data, BMC150_ACCEL_DEF_BW, 0);
> -	if (ret < 0)
> -		return ret;
> -
> -	/* Set Default Range */
> -	ret = i2c_smbus_write_byte_data(data->client,
> -					BMC150_ACCEL_REG_PMU_RANGE,
> -					BMC150_ACCEL_DEF_RANGE_4G);
> -	if (ret < 0) {
> -		dev_err(&data->client->dev,
> -					"Error writing reg_pmu_range\n");
> -		return ret;
> -	}
> -
> -	data->range = BMC150_ACCEL_DEF_RANGE_4G;
> -
> -	/* Set default slope duration and thresholds */
> -	data->slope_thres = BMC150_ACCEL_DEF_SLOPE_THRESHOLD;
> -	data->slope_dur = BMC150_ACCEL_DEF_SLOPE_DURATION;
> -	ret = bmc150_accel_update_slope(data);
> -	if (ret < 0)
> -		return ret;
> -
> -	/* Set default as latched interrupts */
> -	ret = i2c_smbus_write_byte_data(data->client,
> -					BMC150_ACCEL_REG_INT_RST_LATCH,
> -					BMC150_ACCEL_INT_MODE_LATCH_INT |
> -					BMC150_ACCEL_INT_MODE_LATCH_RESET);
> -	if (ret < 0) {
> -		dev_err(&data->client->dev,
> -			"Error writing reg_int_rst_latch\n");
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
>  static int bmc150_accel_get_bw(struct bmc150_accel_data *data, int *val,
>  			       int *val2)
>  {
> @@ -1611,6 +1552,65 @@ static const struct iio_buffer_setup_ops bmc150_accel_buffer_ops = {
>  	.postdisable = bmc150_accel_buffer_postdisable,
>  };
>  
> +static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, BMC150_ACCEL_REG_CHIP_ID);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev,
> +			"Error: Reading chip id\n");
> +		return ret;
> +	}
> +
> +	dev_dbg(&data->client->dev, "Chip Id %x\n", ret);
> +	if (ret != data->chip_info->chip_id) {
> +		dev_err(&data->client->dev, "Invalid chip %x\n", ret);
> +		return -ENODEV;
> +	}
> +
> +	ret = bmc150_accel_set_mode(data, BMC150_ACCEL_SLEEP_MODE_NORMAL, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Set Bandwidth */
> +	ret = bmc150_accel_set_bw(data, BMC150_ACCEL_DEF_BW, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Set Default Range */
> +	ret = i2c_smbus_write_byte_data(data->client,
> +					BMC150_ACCEL_REG_PMU_RANGE,
> +					BMC150_ACCEL_DEF_RANGE_4G);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev,
> +					"Error writing reg_pmu_range\n");
> +		return ret;
> +	}
> +
> +	data->range = BMC150_ACCEL_DEF_RANGE_4G;
> +
> +	/* Set default slope duration and thresholds */
> +	data->slope_thres = BMC150_ACCEL_DEF_SLOPE_THRESHOLD;
> +	data->slope_dur = BMC150_ACCEL_DEF_SLOPE_DURATION;
> +	ret = bmc150_accel_update_slope(data);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Set default as latched interrupts */
> +	ret = i2c_smbus_write_byte_data(data->client,
> +					BMC150_ACCEL_REG_INT_RST_LATCH,
> +					BMC150_ACCEL_INT_MODE_LATCH_INT |
> +					BMC150_ACCEL_INT_MODE_LATCH_RESET);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev,
> +			"Error writing reg_int_rst_latch\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static int bmc150_accel_probe(struct i2c_client *client,
>  			      const struct i2c_device_id *id)
>  {
> 

