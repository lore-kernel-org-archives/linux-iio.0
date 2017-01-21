Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35316 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750917AbdAUOnj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Jan 2017 09:43:39 -0500
Subject: Re: [PATCH v2 10/15] staging: iio: isl29028: remove out of memory log
 message
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <20170117092502.6951-1-masneyb@onstation.org>
 <20170117092502.6951-11-masneyb@onstation.org>
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <2e9e4d12-08cb-d268-5d5c-5b552a6b37be@kernel.org>
Date: Sat, 21 Jan 2017 14:43:26 +0000
MIME-Version: 1.0
In-Reply-To: <20170117092502.6951-11-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/01/17 09:24, Brian Masney wrote:
> If the call to devm_iio_device_alloc() fails, then isl29028_probe()
> logs a message saying that memory cannot be allocated. The user's system
> most likely has larger issues at this point. This patch removes that
> error message since the error code is passed on and the message is not
> necessary.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied.
> ---
>  drivers/staging/iio/light/isl29028.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
> index be1fc4a..e93077b 100644
> --- a/drivers/staging/iio/light/isl29028.c
> +++ b/drivers/staging/iio/light/isl29028.c
> @@ -488,10 +488,8 @@ static int isl29028_probe(struct i2c_client *client,
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
> -	if (!indio_dev) {
> -		dev_err(&client->dev, "iio allocation fails\n");
> +	if (!indio_dev)
>  		return -ENOMEM;
> -	}
>  
>  	chip = iio_priv(indio_dev);
>  
> 

