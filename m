Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48443 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751633AbdCSKxu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Mar 2017 06:53:50 -0400
Subject: Re: [PATCH v2 07/17] iio: pressure: hp03: Add OF device ID table
To: Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-kernel@vger.kernel.org
References: <20170315044505.20660-1-javier@osg.samsung.com>
 <20170315044505.20660-8-javier@osg.samsung.com>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Marek Vasut <marex@denx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <aea9d5dc-f2b8-3104-2760-6adcc0f41268@kernel.org>
Date: Sun, 19 Mar 2017 10:53:48 +0000
MIME-Version: 1.0
In-Reply-To: <20170315044505.20660-8-javier@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/03/17 04:44, Javier Martinez Canillas wrote:
> The driver doesn't have a struct of_device_id table but supported devices
> are registered via Device Trees. This is working on the assumption that a
> I2C device registered via OF will always match a legacy I2C device ID and
> that the MODALIAS reported will always be of the form i2c:<device>.
> 
> But this could change in the future so the correct approach is to have an
> OF device ID table if the devices are registered via OF.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Applied.
> ---
> 
>  drivers/iio/pressure/hp03.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iio/pressure/hp03.c b/drivers/iio/pressure/hp03.c
> index ac76515d5d49..8c7b3ec3d84a 100644
> --- a/drivers/iio/pressure/hp03.c
> +++ b/drivers/iio/pressure/hp03.c
> @@ -297,9 +297,16 @@ static const struct i2c_device_id hp03_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, hp03_id);
>  
> +static const struct of_device_id hp03_of_match[] = {
> +	{ .compatible = "hoperf,hp03" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, hp03_of_match);
> +
>  static struct i2c_driver hp03_driver = {
>  	.driver = {
>  		.name	= "hp03",
> +		.of_match_table = hp03_of_match,
>  	},
>  	.probe		= hp03_probe,
>  	.remove		= hp03_remove,
> 

