Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:6296 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964787Ab3GLVnM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 12 Jul 2013 17:43:12 -0400
Message-ID: <51E079F5.50303@linux.intel.com>
Date: Fri, 12 Jul 2013 14:49:41 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
To: Alexander Holler <holler@ahsoftware.de>
CC: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH 3/4] iio: hid-sensor-als: add module alias for autoload
References: <1373445120-5407-1-git-send-email-holler@ahsoftware.de> <1373445120-5407-4-git-send-email-holler@ahsoftware.de>
In-Reply-To: <1373445120-5407-4-git-send-email-holler@ahsoftware.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Tested. You can add my ack.

Acked-by:Srinivas Pandruvada<srinivas.pandruvada@linux.intel.com>


On 07/10/2013 01:31 AM, Alexander Holler wrote:
> Add a MODULE_DEVICE_TABLE in order to let hotplug mechanisms automatically
> load the driver.
>
> This makes it also possible to use the usual driver name instead of
> HID-SENSOR-2000xx which isn't very descriptive in kernel messages.
>
> Signed-off-by: Alexander Holler <holler@ahsoftware.de>
> ---
>   drivers/iio/light/hid-sensor-als.c | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
> index cdc2cad..9adfef0 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c
> @@ -30,10 +30,6 @@
>   #include <linux/iio/triggered_buffer.h>
>   #include "../common/hid-sensors/hid-sensor-trigger.h"
>   
> -/*Format: HID-SENSOR-usage_id_in_hex*/
> -/*Usage ID from spec for Ambiant-Light: 0x200041*/
> -#define DRIVER_NAME "HID-SENSOR-200041"
> -
>   #define CHANNEL_SCAN_INDEX_ILLUM 0
>   
>   struct als_state {
> @@ -355,9 +351,19 @@ static int hid_als_remove(struct platform_device *pdev)
>   	return 0;
>   }
>   
> +static struct platform_device_id hid_als_ids[] = {
> +	{
> +		/* Format: HID-SENSOR-usage_id_in_hex_lowercase */
> +		.name = "HID-SENSOR-200041",
> +	},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(platform, hid_als_ids);
> +
>   static struct platform_driver hid_als_platform_driver = {
> +	.id_table = hid_als_ids,
>   	.driver = {
> -		.name	= DRIVER_NAME,
> +		.name	= KBUILD_MODNAME,
>   		.owner	= THIS_MODULE,
>   	},
>   	.probe		= hid_als_probe,

