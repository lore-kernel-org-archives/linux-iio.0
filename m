Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34853 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425139AbdD3QeT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Apr 2017 12:34:19 -0400
Subject: Re: [PATCH -next] iio: adc: max9611: Fix return value check in
 max9611_probe()
To: Wei Yongjun <weiyj.lk@gmail.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
References: <20170427152036.30966-1-weiyj.lk@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c58125a4-159e-de2d-b3db-3337e3830949@kernel.org>
Date: Sun, 30 Apr 2017 17:34:14 +0100
MIME-Version: 1.0
In-Reply-To: <20170427152036.30966-1-weiyj.lk@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/04/17 16:20, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> In case of error, the function devm_iio_device_alloc() returns
> NULL pointer not ERR_PTR(). The IS_ERR() test in the return value
> check should be replaced with NULL test.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Good catch.  Dan Carpenter also sent the same fix though and I've
already applied that one.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/max9611.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
> index ec82106..dc3869b 100644
> --- a/drivers/iio/adc/max9611.c
> +++ b/drivers/iio/adc/max9611.c
> @@ -536,8 +536,8 @@ static int max9611_probe(struct i2c_client *client,
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*max9611));
> -	if (IS_ERR(indio_dev))
> -		return PTR_ERR(indio_dev);
> +	if (!indio_dev)
> +		return -ENOMEM;
>  
>  	i2c_set_clientdata(client, indio_dev);
> 

