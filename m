Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50914 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752056AbcHUKBa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Aug 2016 06:01:30 -0400
Subject: Re: [PATCH 1/1] iio:ti-ads1015: fix a wrong pointer definition.
To: Giorgio Dal Molin <giorgio.nicole@arcor.de>,
        linux-iio@vger.kernel.org
References: <CAKzfze9e3U5MjgbwQYn7_APnvDMJpX8ORrstsASrrbN6bp5UOg@mail.gmail.com>
 <20160816184337.17059-1-giorgio.nicole@arcor.de>
Cc: jic23@jic23.retrosnub.co.uk
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <248470f9-d185-0ad6-350f-436a1e899a52@kernel.org>
Date: Sun, 21 Aug 2016 11:01:27 +0100
MIME-Version: 1.0
In-Reply-To: <20160816184337.17059-1-giorgio.nicole@arcor.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/08/16 19:43, Giorgio Dal Molin wrote:
> The call to i2c_get_clientdata(client) returns a struct iio_dev*, not
> the needed struct ads1015_data*. We need here an intermediate step as
> in the function: void ads1015_get_channels_config(struct i2c_client *client).
> 
> Signed-off-by: Giorgio Dal Molin <giorgio.nicole@arcor.de>
Applied with the addition of a fixes tag to the fixes-togreg branch
of iio.git.

I've also marked this for stable.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/ti-ads1015.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 1ef39877..066abaf 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -489,7 +489,8 @@ static struct iio_info ads1115_info = {
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

