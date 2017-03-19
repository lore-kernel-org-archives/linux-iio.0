Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48510 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751886AbdCSK57 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Mar 2017 06:57:59 -0400
Subject: Re: [PATCH v2 14/17] iio: accel: mma7455_i2c: Add OF device ID table
To: Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-kernel@vger.kernel.org
References: <20170315044505.20660-1-javier@osg.samsung.com>
 <20170315044505.20660-15-javier@osg.samsung.com>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <2328f25a-6e06-c728-6503-502805ad68ae@kernel.org>
Date: Sun, 19 Mar 2017 10:57:51 +0000
MIME-Version: 1.0
In-Reply-To: <20170315044505.20660-15-javier@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/03/17 04:45, Javier Martinez Canillas wrote:
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
>  drivers/iio/accel/mma7455_i2c.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/accel/mma7455_i2c.c b/drivers/iio/accel/mma7455_i2c.c
> index 3cab5fb4a3c4..73bf81a8ab14 100644
> --- a/drivers/iio/accel/mma7455_i2c.c
> +++ b/drivers/iio/accel/mma7455_i2c.c
> @@ -41,12 +41,20 @@ static const struct i2c_device_id mma7455_i2c_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, mma7455_i2c_ids);
>  
> +static const struct of_device_id mma7455_of_match[] = {
> +	{ .compatible = "fsl,mma7455" },
> +	{ .compatible = "fsl,mma7456" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, mma7455_of_match);
> +
>  static struct i2c_driver mma7455_i2c_driver = {
>  	.probe = mma7455_i2c_probe,
>  	.remove = mma7455_i2c_remove,
>  	.id_table = mma7455_i2c_ids,
>  	.driver = {
>  		.name	= "mma7455-i2c",
> +		.of_match_table = mma7455_of_match,
>  	},
>  };
>  module_i2c_driver(mma7455_i2c_driver);
> 

