Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50518 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752240AbcL3Kri (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Dec 2016 05:47:38 -0500
Subject: Re: [PATCH v2 1/6] iio: bmi160: Add of device table for i2c
To: Marcin Niestroj <m.niestroj@grinn-global.com>
References: <20161208142259.26230-1-m.niestroj@grinn-global.com>
 <20161208142259.26230-2-m.niestroj@grinn-global.com>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <a262d6f4-a7a1-3eb9-af89-f3f03484600b@kernel.org>
Date: Fri, 30 Dec 2016 10:47:36 +0000
MIME-Version: 1.0
In-Reply-To: <20161208142259.26230-2-m.niestroj@grinn-global.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/12/16 14:22, Marcin Niestroj wrote:
> From now on we can add bmi160 device to device-tree by specifying
> compatible string.
> 
> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
Other than the fact this should really have been two patches, this looks good.

Applied to the togreg branch of iio.git and pushed out as testing for the autobuilders
to play with it.

Thanks,

Jonathan
> ---
> Patch introduced in v2
> 
>  drivers/iio/imu/bmi160/bmi160_i2c.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi160/bmi160_i2c.c b/drivers/iio/imu/bmi160/bmi160_i2c.c
> index 07a179d..155a31f 100644
> --- a/drivers/iio/imu/bmi160/bmi160_i2c.c
> +++ b/drivers/iio/imu/bmi160/bmi160_i2c.c
> @@ -11,10 +11,11 @@
>   *      - 0x68 if SDO is pulled to GND
>   *      - 0x69 if SDO is pulled to VDDIO
>   */
> -#include <linux/module.h>
> +#include <linux/acpi.h>
>  #include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
>  #include <linux/regmap.h>
> -#include <linux/acpi.h>
Whilst I have no objection to reordering headers so they are alphabetical
(as long as not clarity is lost) it should really be in it's own patch...
>  
>  #include "bmi160.h"
>  
> @@ -56,10 +57,19 @@ static const struct acpi_device_id bmi160_acpi_match[] = {
>  };
>  MODULE_DEVICE_TABLE(acpi, bmi160_acpi_match);
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id bmi160_of_match[] = {
> +	{ .compatible = "bosch,bmi160" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, bmi160_of_match);
> +#endif
> +
>  static struct i2c_driver bmi160_i2c_driver = {
>  	.driver = {
>  		.name			= "bmi160_i2c",
>  		.acpi_match_table	= ACPI_PTR(bmi160_acpi_match),
> +		.of_match_table		= of_match_ptr(bmi160_of_match),
>  	},
>  	.probe		= bmi160_i2c_probe,
>  	.remove		= bmi160_i2c_remove,
> 

