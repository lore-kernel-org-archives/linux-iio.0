Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58207 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbbHLVRd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 17:17:33 -0400
Subject: Re: [PATCH v2 5/5] iio:light:stk3310: adjust indentation
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
References: <cover.1436398691.git.knaack.h@gmx.de>
 <6c7e6efa93f5b6df5097b0548549e4043a8d68c0.1436398691.git.knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tiberiu Breana <tiberiu.a.breana@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55CBB7EC.9050402@kernel.org>
Date: Wed, 12 Aug 2015 22:17:32 +0100
MIME-Version: 1.0
In-Reply-To: <6c7e6efa93f5b6df5097b0548549e4043a8d68c0.1436398691.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/07/15 22:51, Hartmut Knaack wrote:
> Adjust some indentation issues as spotted by checkpatch.pl --strict
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
> Reviewed-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
Applied.
> ---
>  drivers/iio/light/stk3310.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
> index 0056f4870357..e73f6f27cc56 100644
> --- a/drivers/iio/light/stk3310.c
> +++ b/drivers/iio/light/stk3310.c
> @@ -385,7 +385,7 @@ static int stk3310_write_raw(struct iio_dev *indio_dev,
>  			ret = regmap_field_write(data->reg_ps_it, index);
>  		if (ret < 0)
>  			dev_err(&data->client->dev,
> -					"sensor configuration failed\n");
> +				"sensor configuration failed\n");
>  		mutex_unlock(&data->lock);
>  		return ret;
>  
> @@ -402,7 +402,7 @@ static int stk3310_write_raw(struct iio_dev *indio_dev,
>  			ret = regmap_field_write(data->reg_ps_gain, index);
>  		if (ret < 0)
>  			dev_err(&data->client->dev,
> -					"sensor configuration failed\n");
> +				"sensor configuration failed\n");
>  		mutex_unlock(&data->lock);
>  		return ret;
>  	}
> @@ -645,7 +645,7 @@ static int stk3310_probe(struct i2c_client *client,
>  						STK3310_EVENT, indio_dev);
>  		if (ret < 0) {
>  			dev_err(&client->dev, "request irq %d failed\n",
> -					client->irq);
> +				client->irq);
>  			goto err_standby;
>  		}
>  	}
> 

