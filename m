Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:24683 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757555Ab3GLVmy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 12 Jul 2013 17:42:54 -0400
Message-ID: <51E079E3.4030404@linux.intel.com>
Date: Fri, 12 Jul 2013 14:49:23 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
To: Alexander Holler <holler@ahsoftware.de>
CC: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH 2/4] iio: hid-sensor-gyro-3d: add module alias for autoload
References: <1373445120-5407-1-git-send-email-holler@ahsoftware.de> <1373445120-5407-3-git-send-email-holler@ahsoftware.de>
In-Reply-To: <1373445120-5407-3-git-send-email-holler@ahsoftware.de>
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
>   drivers/iio/gyro/hid-sensor-gyro-3d.c | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> index bc943dd..9cc8aa1 100644
> --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> @@ -30,10 +30,6 @@
>   #include <linux/iio/triggered_buffer.h>
>   #include "../common/hid-sensors/hid-sensor-trigger.h"
>   
> -/*Format: HID-SENSOR-usage_id_in_hex*/
> -/*Usage ID from spec for Gyro-3D: 0x200076*/
> -#define DRIVER_NAME "HID-SENSOR-200076"
> -
>   enum gyro_3d_channel {
>   	CHANNEL_SCAN_INDEX_X,
>   	CHANNEL_SCAN_INDEX_Y,
> @@ -389,9 +385,19 @@ static int hid_gyro_3d_remove(struct platform_device *pdev)
>   	return 0;
>   }
>   
> +static struct platform_device_id hid_gyro_3d_ids[] = {
> +	{
> +		/* Format: HID-SENSOR-usage_id_in_hex_lowercase */
> +		.name = "HID-SENSOR-200076",
> +	},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(platform, hid_gyro_3d_ids);
> +
>   static struct platform_driver hid_gyro_3d_platform_driver = {
> +	.id_table = hid_gyro_3d_ids,
>   	.driver = {
> -		.name	= DRIVER_NAME,
> +		.name	= KBUILD_MODNAME,
>   		.owner	= THIS_MODULE,
>   	},
>   	.probe		= hid_gyro_3d_probe,

