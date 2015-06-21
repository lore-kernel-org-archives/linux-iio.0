Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43653 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079AbbFUMxj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jun 2015 08:53:39 -0400
Message-ID: <5586B3D2.2080109@kernel.org>
Date: Sun, 21 Jun 2015 13:53:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Tiberiu Breana <tiberiu.a.breana@intel.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: accel: STK8BA50: suspend sensor on init errors
References: <1434725798-26223-1-git-send-email-tiberiu.a.breana@intel.com>
In-Reply-To: <1434725798-26223-1-git-send-email-tiberiu.a.breana@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/06/15 15:56, Tiberiu Breana wrote:
> Put chip in 'suspend' mode in case something goes wrong
> during probe.
> 
> Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
Applied to the togreg branch of iio.git - initially pushed
out as testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
> no changes since v1
> ---
>  drivers/iio/accel/stk8ba50.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
> index 92229bd..9836880 100644
> --- a/drivers/iio/accel/stk8ba50.c
> +++ b/drivers/iio/accel/stk8ba50.c
> @@ -265,7 +265,7 @@ static int stk8ba50_probe(struct i2c_client *client,
>  			STK8BA50_REG_SWRST, STK8BA50_RESET_CMD);
>  	if (ret < 0) {
>  		dev_err(&client->dev, "failed to reset sensor\n");
> -		return ret;
> +		goto err_power_off;
>  	}
>  
>  	/* The default range is +/-2g */
> @@ -277,10 +277,14 @@ static int stk8ba50_probe(struct i2c_client *client,
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0) {
>  		dev_err(&client->dev, "device_register failed\n");
> -		stk8ba50_set_power(data, STK8BA50_MODE_SUSPEND);
> +		goto err_power_off;
>  	}
>  
>  	return ret;
> +
> +err_power_off:
> +	stk8ba50_set_power(data, STK8BA50_MODE_SUSPEND);
> +	return ret;
>  }
>  
>  static int stk8ba50_remove(struct i2c_client *client)
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
