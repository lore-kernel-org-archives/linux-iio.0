Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39029 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533AbbDSMpG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Apr 2015 08:45:06 -0400
Message-ID: <5533A351.9070500@kernel.org>
Date: Sun, 19 Apr 2015 13:45:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, pmeerw@pmeerw.net
CC: linux-iio@vger.kernel.org, srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH v5 5/5] iio: ltr501: Add ACPI enumeration support
References: <cover.1429433882.git.sathyanarayanan.kuppuswamy@linux.intel.com> <24456f45bdb0586e6058a18f0c76ff455ffe5ea1.1429433882.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <24456f45bdb0586e6058a18f0c76ff455ffe5ea1.1429433882.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/04/15 10:10, Kuppuswamy Sathyanarayanan wrote:
> Added ACPI enumeration support for LTR501 chip.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Good set of patches.

All now applied to the togreg branch of iio.git - pushed out as testing for the
autobuilders to play with it,.

Thanks,

Jonathan
> ---
>  drivers/iio/light/ltr501.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> index d9b4536..0162e86 100644
> --- a/drivers/iio/light/ltr501.c
> +++ b/drivers/iio/light/ltr501.c
> @@ -17,6 +17,7 @@
>  #include <linux/err.h>
>  #include <linux/delay.h>
>  #include <linux/regmap.h>
> +#include <linux/acpi.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/events.h>
> @@ -1264,6 +1265,12 @@ static int ltr501_resume(struct device *dev)
>  
>  static SIMPLE_DEV_PM_OPS(ltr501_pm_ops, ltr501_suspend, ltr501_resume);
>  
> +static const struct acpi_device_id ltr_acpi_match[] = {
> +	{"LTER0501", 0},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, ltr_acpi_match);
> +
>  static const struct i2c_device_id ltr501_id[] = {
>  	{ "ltr501", 0 },
>  	{ }
> @@ -1274,6 +1281,7 @@ static struct i2c_driver ltr501_driver = {
>  	.driver = {
>  		.name   = LTR501_DRV_NAME,
>  		.pm	= &ltr501_pm_ops,
> +		.acpi_match_table = ACPI_PTR(ltr_acpi_match),
>  		.owner  = THIS_MODULE,
>  	},
>  	.probe  = ltr501_probe,
> 

