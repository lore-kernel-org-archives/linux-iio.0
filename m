Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752734AbdHIOZU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Aug 2017 10:25:20 -0400
Date: Wed, 9 Aug 2017 15:25:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        daniel.baluta@gmail.com, amsfield22@gmail.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: ccs811: Add ACPI support
Message-ID: <20170809152500.4ae6fadd@archlinux>
In-Reply-To: <1501674036-24605-1-git-send-email-narcisaanamaria12@gmail.com>
References: <1501674036-24605-1-git-send-email-narcisaanamaria12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed,  2 Aug 2017 14:40:36 +0300
Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com> wrote:

> Add ACPI ID to enable ACPI support.
> 
> Cc: Daniel Baluta <daniel.baluta@gmail.com>
> Cc: Alison Schofield <amsfield22@gmail.com>
> Signed-off-by: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
> ---
> This patch depends on "iio: chemical: ccs811: Add triggered buffer support"
> 
> Note: The ACPI ID is not yet registered at
> http://www.uefi.org/PNP_ACPI_Registry. This vendor doesn't have a
> registered ID yet.
Sorry, until it is registered then we can't take support for it.
ACPI bindings are often entirely random so who knows what the right one
will be.

Jonathan
> 
>  drivers/iio/chemical/ccs811.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
> index 8dbb5ed..8a4160e 100644
> --- a/drivers/iio/chemical/ccs811.c
> +++ b/drivers/iio/chemical/ccs811.c
> @@ -18,6 +18,7 @@
>   * 4. Read error register and put the information in logs
>   */
> 
> +#include <linux/acpi.h>
>  #include <linux/delay.h>
>  #include <linux/i2c.h>
>  #include <linux/iio/iio.h>
> @@ -324,9 +325,16 @@ static int ccs811_remove(struct i2c_client *client)
>  };
>  MODULE_DEVICE_TABLE(i2c, ccs811_id);
> 
> +static const struct acpi_device_id ccs811_acpi_match[] = {
> +	{"CCS0811", 0},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, ccs811_acpi_match);
> +
>  static struct i2c_driver ccs811_driver = {
>  	.driver = {
>  		.name = "ccs811",
> +		.acpi_match_table = ACPI_PTR(ccs811_acpi_match),
>  	},
>  	.probe = ccs811_probe,
>  	.remove = ccs811_remove,
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

