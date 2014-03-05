Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:35786 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753783AbaCETGT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 5 Mar 2014 14:06:19 -0500
Message-ID: <53177641.5010804@linux.intel.com>
Date: Wed, 05 Mar 2014 11:08:49 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
To: "Peter F. Patel-Schneider" <pfpschneider@gmail.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] iio:hid-sensor-hub: Add in quirk for sensor hub in Lenovo
 Ideapad Yogas
References: <53166D17.10104@gmail.com>
In-Reply-To: <53166D17.10104@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Looks good, but need to post to linux_input mailing list for Jiri to 
pick up.

Thanks,
Srinivas
On 03/04/2014 04:17 PM, Peter F. Patel-Schneider wrote:
> The sensor hub in Lenovo Yogas needs the ennumeration quirk.  I've 
> been running the patch for about a week with no problems, whereas 
> theunpatched drivers reliably mis-initialized the sensors.
>
> Signed-off-by: Peter F. Patel-Schneider <pfpschneider@gmail.com>
> ---
>  drivers/hid/hid-ids.h        | 3 +++
>  drivers/hid/hid-sensor-hub.c | 3 +++
>  2 files changed, 6 insertions(+)
>
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 5a5248f..f944e37 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -823,6 +823,9 @@
>  #define USB_DEVICE_ID_SYNAPTICS_HD    0x0ac3
>  #define USB_DEVICE_ID_SYNAPTICS_QUAD_HD    0x1ac3
>
> +#define USB_VENDOR_ID_TEXAS_INSTRUMENTS    0x2047
> +#define USB_DEVICE_ID_TEXAS_INSTRUMENTS_LENOVO_YOGA    0x0855
> +
>  #define USB_VENDOR_ID_THINGM        0x27b8
>  #define USB_DEVICE_ID_BLINK1        0x01ed
>
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> index 46f4480..597732b 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -665,6 +665,9 @@ static const struct hid_device_id 
> sensor_hub_devices[] = {
>      { HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, 
> USB_VENDOR_ID_INTEL_1,
>              USB_DEVICE_ID_INTEL_HID_SENSOR),
>              .driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
> +    { HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, 
> USB_VENDOR_ID_TEXAS_INSTRUMENTS,
> +             USB_DEVICE_ID_TEXAS_INSTRUMENTS_LENOVO_YOGA),
> +             .driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
>      { HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, HID_ANY_ID,
>               HID_ANY_ID) },
>      { }
>
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

