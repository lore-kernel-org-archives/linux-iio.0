Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56093 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271Ab3IUKGd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Sep 2013 06:06:33 -0400
Message-ID: <523D7DCE.6000209@kernel.org>
Date: Sat, 21 Sep 2013 12:06:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: Fix mcp4725 dev-to-indio_dev conversion in suspend/resume
References: <1379540853-15189-1-git-send-email-pmeerw@pmeerw.net> <1379540853-15189-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1379540853-15189-3-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/18/13 22:47, Peter Meerwald wrote:
> dev_to_iio_dev() is a false friend
> 
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the fixes-togreg branch of iio.git

Thanks
> ---
>  drivers/iio/dac/mcp4725.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
> index 6711a33..7a42d85 100644
> --- a/drivers/iio/dac/mcp4725.c
> +++ b/drivers/iio/dac/mcp4725.c
> @@ -37,21 +37,21 @@ struct mcp4725_data {
>  
>  static int mcp4725_suspend(struct device *dev)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct mcp4725_data *data = iio_priv(indio_dev);
> +	struct mcp4725_data *data = iio_priv(i2c_get_clientdata(
> +		to_i2c_client(dev)));
>  	u8 outbuf[2];
>  
>  	outbuf[0] = (data->powerdown_mode + 1) << 4;
>  	outbuf[1] = 0;
>  	data->powerdown = true;
>  
> -	return i2c_master_send(to_i2c_client(dev), outbuf, 2);
> +	return i2c_master_send(data->client, outbuf, 2);
>  }
>  
>  static int mcp4725_resume(struct device *dev)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct mcp4725_data *data = iio_priv(indio_dev);
> +	struct mcp4725_data *data = iio_priv(i2c_get_clientdata(
> +		to_i2c_client(dev)));
>  	u8 outbuf[2];
>  
>  	/* restore previous DAC value */
> @@ -59,7 +59,7 @@ static int mcp4725_resume(struct device *dev)
>  	outbuf[1] = data->dac_value & 0xff;
>  	data->powerdown = false;
>  
> -	return i2c_master_send(to_i2c_client(dev), outbuf, 2);
> +	return i2c_master_send(data->client, outbuf, 2);
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> 
