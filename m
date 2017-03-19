Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48437 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbdCSKxU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Mar 2017 06:53:20 -0400
Subject: Re: [PATCH v2 06/17] iio: light: tsl2563: Add OF device ID table
To: Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-kernel@vger.kernel.org
References: <20170315044505.20660-1-javier@osg.samsung.com>
 <20170315044505.20660-7-javier@osg.samsung.com>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Amitoj Kaur Chawla <amitoj1606@gmail.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <70de26bf-3580-4977-fb30-efe7af2b8e26@kernel.org>
Date: Sun, 19 Mar 2017 10:53:17 +0000
MIME-Version: 1.0
In-Reply-To: <20170315044505.20660-7-javier@osg.samsung.com>
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
Applied
> ---
> 
>  drivers/iio/light/tsl2563.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
> index 04598ae993d4..e7d4ea75e007 100644
> --- a/drivers/iio/light/tsl2563.c
> +++ b/drivers/iio/light/tsl2563.c
> @@ -884,9 +884,19 @@ static const struct i2c_device_id tsl2563_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, tsl2563_id);
>  
> +static const struct of_device_id tsl2563_of_match[] = {
> +	{ .compatible = "amstaos,tsl2560" },
> +	{ .compatible = "amstaos,tsl2561" },
> +	{ .compatible = "amstaos,tsl2562" },
> +	{ .compatible = "amstaos,tsl2563" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, tsl2563_of_match);
> +
>  static struct i2c_driver tsl2563_i2c_driver = {
>  	.driver = {
>  		.name	 = "tsl2563",
> +		.of_match_table = tsl2563_of_match,
>  		.pm	= TSL2563_PM_OPS,
>  	},
>  	.probe		= tsl2563_probe,
> 

