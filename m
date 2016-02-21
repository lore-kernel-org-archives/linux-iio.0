Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60485 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbcBUUex (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Feb 2016 15:34:53 -0500
Subject: Re: [PATCH] iio: chemical: atlas-ph-sensor: use regmap_bulk_read
To: Matt Ranostay <mranostay@gmail.com>
References: <1455505147-2261-1-git-send-email-mranostay@gmail.com>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56CA1F6C.4010400@kernel.org>
Date: Sun, 21 Feb 2016 20:34:52 +0000
MIME-Version: 1.0
In-Reply-To: <1455505147-2261-1-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/02/16 02:59, Matt Ranostay wrote:
> Replaced i2c_smbus_read_i2c_block_data() with regmap_bulk_read()
> function call. This is to make the driver code more consistent.
> 
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
Oops.
Applied, thanks,

Jonathan
> ---
>  drivers/iio/chemical/atlas-ph-sensor.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-ph-sensor.c
> index 06cd49c..93fcea9 100644
> --- a/drivers/iio/chemical/atlas-ph-sensor.c
> +++ b/drivers/iio/chemical/atlas-ph-sensor.c
> @@ -180,10 +180,10 @@ static irqreturn_t atlas_trigger_handler(int irq, void *private)
>  	struct atlas_data *data = iio_priv(indio_dev);
>  	int ret;
>  
> -	ret = i2c_smbus_read_i2c_block_data(data->client, ATLAS_REG_PH_DATA,
> -				sizeof(data->buffer[0]), (u8 *) &data->buffer);
> +	ret = regmap_bulk_read(data->regmap, ATLAS_REG_PH_DATA,
> +			      (u8 *) &data->buffer, sizeof(data->buffer[0]));
>  
> -	if (ret > 0)
> +	if (!ret)
>  		iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
>  				iio_get_time_ns());
>  
> 

