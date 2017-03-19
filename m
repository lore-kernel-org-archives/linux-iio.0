Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48404 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751429AbdCSKua (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Mar 2017 06:50:30 -0400
Subject: Re: [PATCH v2 03/17] iio: magnetometer: bmc150_magn_i2c: Add OF
 device ID table
To: Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-kernel@vger.kernel.org
References: <20170315044505.20660-1-javier@osg.samsung.com>
 <20170315044505.20660-4-javier@osg.samsung.com>
Cc: Irina Tirdea <irina.tirdea@intel.com>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <a1f0555f-d89e-3c81-0a03-09b98f388804@kernel.org>
Date: Sun, 19 Mar 2017 10:50:19 +0000
MIME-Version: 1.0
In-Reply-To: <20170315044505.20660-4-javier@osg.samsung.com>
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
>  drivers/iio/magnetometer/bmc150_magn_i2c.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/iio/magnetometer/bmc150_magn_i2c.c b/drivers/iio/magnetometer/bmc150_magn_i2c.c
> index ee05722587aa..57e40dd1222e 100644
> --- a/drivers/iio/magnetometer/bmc150_magn_i2c.c
> +++ b/drivers/iio/magnetometer/bmc150_magn_i2c.c
> @@ -63,9 +63,18 @@ static const struct i2c_device_id bmc150_magn_i2c_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, bmc150_magn_i2c_id);
>  
> +static const struct of_device_id bmc150_magn_of_match[] = {
> +	{ .compatible = "bosch,bmc150_magn" },
> +	{ .compatible = "bosch,bmc156_magn" },
> +	{ .compatible = "bosch,bmm150_magn" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, bmc150_magn_of_match);
> +
>  static struct i2c_driver bmc150_magn_driver = {
>  	.driver = {
>  		.name	= "bmc150_magn_i2c",
> +		.of_match_table = bmc150_magn_of_match,
>  		.acpi_match_table = ACPI_PTR(bmc150_magn_acpi_match),
>  		.pm	= &bmc150_magn_pm_ops,
>  	},
> 

