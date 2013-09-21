Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56193 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151Ab3IUKTs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Sep 2013 06:19:48 -0400
Message-ID: <523D80E7.8020900@kernel.org>
Date: Sat, 21 Sep 2013 12:20:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: Fix tcs3472 dev-to-indio_dev conversion in suspend/resume
References: <1379540853-15189-1-git-send-email-pmeerw@pmeerw.net> <1379540853-15189-4-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1379540853-15189-4-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/18/13 22:47, Peter Meerwald wrote:
> dev_to_iio_dev() is a false friend
> 
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the togreg branch of iio.git

Thanks
> ---
>  drivers/iio/light/tcs3472.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
> index 7bf2969..0b4ed57 100644
> --- a/drivers/iio/light/tcs3472.c
> +++ b/drivers/iio/light/tcs3472.c
> @@ -330,12 +330,15 @@ static int tcs3472_remove(struct i2c_client *client)
>  #ifdef CONFIG_PM_SLEEP
>  static int tcs3472_suspend(struct device *dev)
>  {
> -	return tcs3472_powerdown(iio_priv(dev_to_iio_dev(dev)));
> +	struct tcs3472_data *data = iio_priv(i2c_get_clientdata(
> +		to_i2c_client(dev)));
> +	return tcs3472_powerdown(data);
>  }
>  
>  static int tcs3472_resume(struct device *dev)
>  {
> -	struct tcs3472_data *data = iio_priv(dev_to_iio_dev(dev));
> +	struct tcs3472_data *data = iio_priv(i2c_get_clientdata(
> +		to_i2c_client(dev)));
>  	return i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE,
>  		data->enable | (TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON));
>  }
> 
