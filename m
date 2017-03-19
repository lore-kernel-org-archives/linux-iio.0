Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48560 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbdCSLDN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Mar 2017 07:03:13 -0400
Subject: Re: [PATCH v2 10/17] iio: light: apds9960: Add OF device ID table
To: Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-kernel@vger.kernel.org
References: <20170315044505.20660-1-javier@osg.samsung.com>
 <20170315044505.20660-11-javier@osg.samsung.com>
Cc: Matt Ranostay <mranostay@gmail.com>,
        Slawomir Stepien <sst@poczta.fm>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Yong Li <sdliyong@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dan Carpenter <dan.carpenter@oracle.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <64841906-a806-4d03-16d9-030f61401238@kernel.org>
Date: Sun, 19 Mar 2017 10:55:50 +0000
MIME-Version: 1.0
In-Reply-To: <20170315044505.20660-11-javier@osg.samsung.com>
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
>  drivers/iio/light/apds9960.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
> index a4304edc3e0f..90bc98df362b 100644
> --- a/drivers/iio/light/apds9960.c
> +++ b/drivers/iio/light/apds9960.c
> @@ -1122,9 +1122,16 @@ static const struct i2c_device_id apds9960_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, apds9960_id);
>  
> +static const struct of_device_id apds9960_of_match[] = {
> +	{ .compatible = "avago,apds9960" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, apds9960_of_match);
> +
>  static struct i2c_driver apds9960_driver = {
>  	.driver = {
>  		.name	= APDS9960_DRV_NAME,
> +		.of_match_table = apds9960_of_match,
>  		.pm	= &apds9960_pm_ops,
>  	},
>  	.probe		= apds9960_probe,
> 

