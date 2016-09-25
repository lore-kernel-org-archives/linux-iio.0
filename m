Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34882 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751990AbcIYIx5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Sep 2016 04:53:57 -0400
Subject: Re: [PATCH] drivers: iio: magnetometer: Fix sparse endianness
 warnings cast to restricted __le16
To: Sandhya Bankar <bankarsandhya512@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org
References: <20160924212253.GA25982@localhost.localdomain>
Cc: outreachy-kernel@googlegroups.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <8cef9ca5-c5e7-1bda-beb1-f59786469a62@kernel.org>
Date: Sun, 25 Sep 2016 09:53:54 +0100
MIME-Version: 1.0
In-Reply-To: <20160924212253.GA25982@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/09/16 22:22, Sandhya Bankar wrote:
> Fix the following sparse endianness warnings:
> 
> drivers/iio/magnetometer/ak8975.c:716:16: warning: cast to restricted __le16
> drivers/iio/magnetometer/ak8975.c:837:19: warning: cast to restricted __le16
> drivers/iio/magnetometer/ak8975.c:838:19: warning: cast to restricted __le16
> drivers/iio/magnetometer/ak8975.c:839:19: warning: cast to restricted __le16
> 
> 
> Signed-off-by: Sandhya Bankar <bankarsandhya512@gmail.com>
Comment inline.  This one is slightly more complex than it first looks.

Jonathan
> 
> ---
>  drivers/iio/magnetometer/ak8975.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index af8606c..66a85a8 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -690,6 +690,7 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
>  	struct ak8975_data *data = iio_priv(indio_dev);
>  	const struct i2c_client *client = data->client;
>  	const struct ak_def *def = data->def;
> +	__le16 rval;
>  	u16 buff;
>  	int ret;
>  
> @@ -703,7 +704,7 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
>  
>  	ret = i2c_smbus_read_i2c_block_data_or_emulated(
>  			client, def->data_regs[index],
> -			sizeof(buff), (u8*)&buff);
> +			sizeof(rval), (u8*)&rval);
>  	if (ret < 0)
>  		goto exit;
>  
> @@ -713,7 +714,7 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
>  	pm_runtime_put_autosuspend(&data->client->dev);
>  
>  	/* Swap bytes and convert to valid range. */
> -	buff = le16_to_cpu(buff);
> +	buff = le16_to_cpu(rval);
>  	*val = clamp_t(s16, buff, -def->range, def->range);
>  	return IIO_VAL_INT;
>  
> @@ -813,6 +814,7 @@ static void ak8975_fill_buffer(struct iio_dev *indio_dev)
>  	const struct ak_def *def = data->def;
>  	int ret;
>  	s16 buff[8]; /* 3 x 16 bits axis values + 1 aligned 64 bits timestamp */
> +	__le16 fval[8];
This one is more interesting.  Check how many values of fval are actually
used.  Buff needs some padding to take a timestamp inserted (rather 
surprisingly by the iio_push_to_buffers_with_timestamp call), lval doesn't. 
>  
>  	mutex_lock(&data->lock);
>  
> @@ -826,17 +828,17 @@ static void ak8975_fill_buffer(struct iio_dev *indio_dev)
>  	 */
>  	ret = i2c_smbus_read_i2c_block_data_or_emulated(client,
>  							def->data_regs[0],
> -							3 * sizeof(buff[0]),
> -							(u8 *)buff);
> +							3 * sizeof(fval[0]),
> +							(u8 *)fval);
>  	if (ret < 0)
>  		goto unlock;
>  
>  	mutex_unlock(&data->lock);
>  
>  	/* Clamp to valid range. */
> -	buff[0] = clamp_t(s16, le16_to_cpu(buff[0]), -def->range, def->range);
> -	buff[1] = clamp_t(s16, le16_to_cpu(buff[1]), -def->range, def->range);
> -	buff[2] = clamp_t(s16, le16_to_cpu(buff[2]), -def->range, def->range);
> +	buff[0] = clamp_t(s16, le16_to_cpu(fval[0]), -def->range, def->range);
> +	buff[1] = clamp_t(s16, le16_to_cpu(fval[1]), -def->range, def->range);
> +	buff[2] = clamp_t(s16, le16_to_cpu(fval[2]), -def->range, def->range);
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev, buff,
>  					   iio_get_time_ns(indio_dev));
> 

