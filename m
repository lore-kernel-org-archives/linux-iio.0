Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48530 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752013AbdCSK6r (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Mar 2017 06:58:47 -0400
Subject: Re: [PATCH v2 16/17] iio: accel: mma7660: Add OF device ID table
To: Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-kernel@vger.kernel.org
References: <20170315044505.20660-1-javier@osg.samsung.com>
 <20170315044505.20660-17-javier@osg.samsung.com>
Cc: Martin Klepplinger <martink@posteo.de>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Constantin Musca <constantin.musca@intel.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <7164e9fc-1270-3330-ea6b-408da8ad6927@kernel.org>
Date: Sun, 19 Mar 2017 10:58:39 +0000
MIME-Version: 1.0
In-Reply-To: <20170315044505.20660-17-javier@osg.samsung.com>
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
>  drivers/iio/accel/mma7660.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iio/accel/mma7660.c b/drivers/iio/accel/mma7660.c
> index 3a40774cca74..42fa57e41bdd 100644
> --- a/drivers/iio/accel/mma7660.c
> +++ b/drivers/iio/accel/mma7660.c
> @@ -253,6 +253,12 @@ static const struct i2c_device_id mma7660_i2c_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, mma7660_i2c_id);
>  
> +static const struct of_device_id mma7660_of_match[] = {
> +	{ .compatible = "fsl,mma7660" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, mma7660_of_match);
> +
>  static const struct acpi_device_id mma7660_acpi_id[] = {
>  	{"MMA7660", 0},
>  	{}
> @@ -264,6 +270,7 @@ static struct i2c_driver mma7660_driver = {
>  	.driver = {
>  		.name = "mma7660",
>  		.pm = MMA7660_PM_OPS,
> +		.of_match_table = mma7660_of_match,
>  		.acpi_match_table = ACPI_PTR(mma7660_acpi_id),
>  	},
>  	.probe		= mma7660_probe,
> 

