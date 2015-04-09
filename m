Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52478 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327AbbDIN1V (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 9 Apr 2015 09:27:21 -0400
Message-ID: <55267E37.3050903@kernel.org>
Date: Thu, 09 Apr 2015 14:27:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Cristina Opriceana <cristina.opriceana@gmail.com>,
	outreachy-kernel@googlegroups.com
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: ltr501: Powerdown device on error
References: <ba26e935b4fce83d6463762491960f0e6e13f498.1427903144.git.cristina.opriceana@gmail.com>
In-Reply-To: <ba26e935b4fce83d6463762491960f0e6e13f498.1427903144.git.cristina.opriceana@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/04/15 16:50, Cristina Opriceana wrote:
> Power down device when an error occurs  in order to avoid wasting
> power. Move powerdown function up to be seen by the new call and
> align parameters for the ltr501_write_contr() call.
> 
> Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
Greg already picked up a version of this directly by the look of it.

J
> ---
> Changes in v2:
>  - align parameters in the ltr501_write_contr() function call
>  - update commit message to include this change
> 
>  drivers/iio/light/ltr501.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> index 62b7072..78b8783 100644
> --- a/drivers/iio/light/ltr501.c
> +++ b/drivers/iio/light/ltr501.c
> @@ -333,6 +333,13 @@ static int ltr501_init(struct ltr501_data *data)
>  		data->ps_contr);
>  }
>  
> +static int ltr501_powerdown(struct ltr501_data *data)
> +{
> +	return ltr501_write_contr(data->client,
> +				  data->als_contr & ~LTR501_CONTR_ACTIVE,
> +				  data->ps_contr & ~LTR501_CONTR_ACTIVE);
> +}
> +
>  static int ltr501_probe(struct i2c_client *client,
>  			  const struct i2c_device_id *id)
>  {
> @@ -370,7 +377,7 @@ static int ltr501_probe(struct i2c_client *client,
>  	ret = iio_triggered_buffer_setup(indio_dev, NULL,
>  		ltr501_trigger_handler, NULL);
>  	if (ret)
> -		return ret;
> +		goto powerdown_on_error;
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret)
> @@ -380,16 +387,11 @@ static int ltr501_probe(struct i2c_client *client,
>  
>  error_unreg_buffer:
>  	iio_triggered_buffer_cleanup(indio_dev);
> +powerdown_on_error:
> +	ltr501_powerdown(data);
>  	return ret;
>  }
>  
> -static int ltr501_powerdown(struct ltr501_data *data)
> -{
> -	return ltr501_write_contr(data->client,
> -		data->als_contr & ~LTR501_CONTR_ACTIVE,
> -		data->ps_contr & ~LTR501_CONTR_ACTIVE);
> -}
> -
>  static int ltr501_remove(struct i2c_client *client)
>  {
>  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> 

