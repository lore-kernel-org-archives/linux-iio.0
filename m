Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43482 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948Ab3IPUi2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2013 16:38:28 -0400
Message-ID: <52377A62.8040600@kernel.org>
Date: Mon, 16 Sep 2013 22:38:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio:max1361: Use default triggered buffer setup ops
References: <1379320489-27334-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1379320489-27334-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/16/13 09:34, Lars-Peter Clausen wrote:
> The max1361 driver uses the same callbacks as the triggered buffer default
> buffer setup ops, so just remove the max1361 specific ops and let it use the
> default ops.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Thanks. Applied to the togreg branch of ii
> ---
>  drivers/iio/adc/max1363.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index 4fb35d1..1e7160d 100644
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -1484,12 +1484,6 @@ done:
>  	return IRQ_HANDLED;
>  }
>  
> -static const struct iio_buffer_setup_ops max1363_buffered_setup_ops = {
> -	.postenable = &iio_triggered_buffer_postenable,
> -	.preenable = &iio_sw_buffer_preenable,
> -	.predisable = &iio_triggered_buffer_predisable,
> -};
> -
>  static int max1363_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
> @@ -1559,7 +1553,7 @@ static int max1363_probe(struct i2c_client *client,
>  		goto error_disable_reg;
>  
>  	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> -		&max1363_trigger_handler, &max1363_buffered_setup_ops);
> +		&max1363_trigger_handler, NULL);
>  	if (ret)
>  		goto error_disable_reg;
>  
> 
