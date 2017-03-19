Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48522 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751886AbdCSK6T (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Mar 2017 06:58:19 -0400
Subject: Re: [PATCH v2 15/17] iio: pressure: mpl3115: Add OF device ID table
To: Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-kernel@vger.kernel.org
References: <20170315044505.20660-1-javier@osg.samsung.com>
 <20170315044505.20660-16-javier@osg.samsung.com>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alison Schofield <amsfield22@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c126ef90-6bee-c76a-bc40-a83491ec66a5@kernel.org>
Date: Sun, 19 Mar 2017 10:58:11 +0000
MIME-Version: 1.0
In-Reply-To: <20170315044505.20660-16-javier@osg.samsung.com>
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
>  drivers/iio/pressure/mpl3115.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
> index 525644a7442d..619b963714c7 100644
> --- a/drivers/iio/pressure/mpl3115.c
> +++ b/drivers/iio/pressure/mpl3115.c
> @@ -321,9 +321,16 @@ static const struct i2c_device_id mpl3115_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, mpl3115_id);
>  
> +static const struct of_device_id mpl3115_of_match[] = {
> +	{ .compatible = "fsl,mpl3115" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, mpl3115_of_match);
> +
>  static struct i2c_driver mpl3115_driver = {
>  	.driver = {
>  		.name	= "mpl3115",
> +		.of_match_table = mpl3115_of_match,
>  		.pm	= MPL3115_PM_OPS,
>  	},
>  	.probe = mpl3115_probe,
> 

