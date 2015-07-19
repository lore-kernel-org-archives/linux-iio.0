Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47577 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150AbbGSNxP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jul 2015 09:53:15 -0400
Message-ID: <55ABABC8.6030506@kernel.org>
Date: Sun, 19 Jul 2015 14:53:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tiberiu Breana <tiberiu.a.breana@intel.com>
Subject: Re: [PATCH v2 1/5] iio:light:stk3310: move device register to end
 of probe
References: <cover.1436398691.git.knaack.h@gmx.de> <fe03a1248d7d1037686a7b08bd5357b95a0b9081.1436398691.git.knaack.h@gmx.de>
In-Reply-To: <fe03a1248d7d1037686a7b08bd5357b95a0b9081.1436398691.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/07/15 22:51, Hartmut Knaack wrote:
> iio_device_register should be the last operation during probe. Therefor
> move up interrupt setup code and while at it, change the check for invalid
> values of client->irq to be smaller than zero.
> Fixes: 3dd477acbdd1 ("iio: light: Add threshold interrupt support for STK3310")
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Applied to the fixes-togreg branch of iio.git

I added some stuff about why this ordering matters.

Jonathan
> ---
>  drivers/iio/light/stk3310.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
> index c1a218236be5..e7e6e5a2b1f8 100644
> --- a/drivers/iio/light/stk3310.c
> +++ b/drivers/iio/light/stk3310.c
> @@ -608,13 +608,7 @@ static int stk3310_probe(struct i2c_client *client,
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = iio_device_register(indio_dev);
> -	if (ret < 0) {
> -		dev_err(&client->dev, "device_register failed\n");
> -		stk3310_set_state(data, STK3310_STATE_STANDBY);
> -	}
> -
> -	if (client->irq <= 0)
> +	if (client->irq < 0)
>  		client->irq = stk3310_gpio_probe(client);
>  
>  	if (client->irq >= 0) {
> @@ -629,6 +623,12 @@ static int stk3310_probe(struct i2c_client *client,
>  					client->irq);
>  	}
>  
> +	ret = iio_device_register(indio_dev);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "device_register failed\n");
> +		stk3310_set_state(data, STK3310_STATE_STANDBY);
> +	}
> +
>  	return ret;
>  }
>  
> 

