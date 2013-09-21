Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56061 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187Ab3IUKFQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Sep 2013 06:05:16 -0400
Message-ID: <523D7D7D.5070801@kernel.org>
Date: Sat, 21 Sep 2013 12:05:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/4] iio: Fix tmp006 dev-to-indio_dev conversion in suspend/resume
References: <1379540853-15189-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1379540853-15189-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/18/13 22:47, Peter Meerwald wrote:
> dev_to_iio_dev() is a false friend
> 
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the fixes-togreg branch.

Thanks
> ---
>  drivers/iio/temperature/tmp006.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
> index 4e95097..84a0789 100644
> --- a/drivers/iio/temperature/tmp006.c
> +++ b/drivers/iio/temperature/tmp006.c
> @@ -252,12 +252,14 @@ static int tmp006_remove(struct i2c_client *client)
>  #ifdef CONFIG_PM_SLEEP
>  static int tmp006_suspend(struct device *dev)
>  {
> -	return tmp006_powerdown(iio_priv(dev_to_iio_dev(dev)));
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	return tmp006_powerdown(iio_priv(indio_dev));
>  }
>  
>  static int tmp006_resume(struct device *dev)
>  {
> -	struct tmp006_data *data = iio_priv(dev_to_iio_dev(dev));
> +	struct tmp006_data *data = iio_priv(i2c_get_clientdata(
> +		to_i2c_client(dev)));
>  	return i2c_smbus_write_word_swapped(data->client, TMP006_CONFIG,
>  		data->config | TMP006_CONFIG_MOD_MASK);
>  }
> 
