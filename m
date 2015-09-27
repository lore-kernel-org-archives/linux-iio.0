Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37208 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755936AbbI0PjJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 27 Sep 2015 11:39:09 -0400
Subject: Re: [PATCH] iio: chemical: vz89x hardware i2c workaround
To: Matt Ranostay <mranostay@gmail.com>, lars@metafoo.de,
	pmeerw@pmeerw.net
References: <1442982309-3925-1-git-send-email-mranostay@gmail.com>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56080D9B.9040905@kernel.org>
Date: Sun, 27 Sep 2015 16:39:07 +0100
MIME-Version: 1.0
In-Reply-To: <1442982309-3925-1-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/09/15 05:25, Matt Ranostay wrote:
> Chipset sometime updates in the middle of a reading causing it
> to reset the data pointer, and causing invalid reading of previous data.
> 
> We can check for this invalid state by reading MSB of the resistance
> reading that is always zero, and by also confirming the VOC_short isn't
> zero.
> 
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
Applied.
> ---
>  drivers/iio/chemical/vz89x.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/chemical/vz89x.c b/drivers/iio/chemical/vz89x.c
> index b454200..11e59a5 100644
> --- a/drivers/iio/chemical/vz89x.c
> +++ b/drivers/iio/chemical/vz89x.c
> @@ -85,6 +85,21 @@ static const struct attribute_group vz89x_attrs_group = {
>  	.attrs = vz89x_attributes,
>  };
>  
> +/*
> + * Chipset sometime updates in the middle of a reading causing it to reset the
> + * data pointer, and causing invalid reading of previous data.
> + * We can check for this by reading MSB of the resistance reading that is
> + * always zero, and by also confirming the VOC_short isn't zero.
> + */
> +
> +static int vz89x_measurement_is_valid(struct vz89x_data *data)
> +{
> +	if (data->buffer[VZ89X_VOC_SHORT_IDX] == 0)
> +		return 1;
> +
> +	return !!(data->buffer[VZ89X_REG_MEASUREMENT_SIZE - 1] > 0);
> +}
> +
>  static int vz89x_get_measurement(struct vz89x_data *data)
>  {
>  	int ret;
> @@ -106,6 +121,10 @@ static int vz89x_get_measurement(struct vz89x_data *data)
>  		data->buffer[i] = ret;
>  	}
>  
> +	ret = vz89x_measurement_is_valid(data);
> +	if (ret)
> +		return -EAGAIN;
> +
>  	data->last_update = jiffies;
>  
>  	return 0;
> @@ -113,9 +132,9 @@ static int vz89x_get_measurement(struct vz89x_data *data)
>  
>  static int vz89x_get_resistance_reading(struct vz89x_data *data)
>  {
> -	u8 *buf = &data->buffer[VZ89X_VOC_TVOC_IDX];
> +	u8 *buf = &data->buffer[VZ89X_VOC_RESISTANCE_IDX];
>  
> -	return buf[0] | (buf[1] << 8) | (buf[2] << 16);
> +	return buf[0] | (buf[1] << 8);
>  }
>  
>  static int vz89x_read_raw(struct iio_dev *indio_dev,
> 

