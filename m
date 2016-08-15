Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42352 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713AbcHORt3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Aug 2016 13:49:29 -0400
Subject: Re: [PATCH 1/1] iio:ti-ads1015: fix a wrong pointer definition.
To: Giorgio <giorgio.nicole@arcor.de>, linux-iio@vger.kernel.org
References: <20160727212749.21573-1-giorgio.nicole@arcor.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <7645ca07-ae31-e111-ffb1-a0c2b75bce47@kernel.org>
Date: Mon, 15 Aug 2016 18:49:24 +0100
MIME-Version: 1.0
In-Reply-To: <20160727212749.21573-1-giorgio.nicole@arcor.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/07/16 22:27, Giorgio wrote:
> The call to i2c_get_clientdata(client) returns a struct iio_dev*, not
> the needed struct ads1015_data*. We need here an intermediate step as
> in the function: void ads1015_get_channels_config(struct i2c_client *client).
Please sign off on any patches you submit.

I can't apply this for you as it has legal meaning.

Jonathan
> ---
>  drivers/iio/adc/ti-ads1015.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 73cbf0b..fe96af6 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -403,7 +403,8 @@ static const struct iio_info ads1015_info = {
>  #ifdef CONFIG_OF
>  static int ads1015_get_channels_config_of(struct i2c_client *client)
>  {
> -	struct ads1015_data *data = i2c_get_clientdata(client);
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct ads1015_data *data = iio_priv(indio_dev);
>  	struct device_node *node;
>  
>  	if (!client->dev.of_node ||
> 

