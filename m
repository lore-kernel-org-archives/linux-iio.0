Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:32833 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821AbaEXKZX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 24 May 2014 06:25:23 -0400
Message-ID: <538073FB.30903@kernel.org>
Date: Sat, 24 May 2014 11:27:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Reyad Attiyat <reyad.attiyat@gmail.com>,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: hid-sensor-hub: Add Microsoft Surface Pro 2 HID
 ID and set report quirk
References: <1400031685-28090-1-git-send-email-reyad.attiyat@gmail.com>
In-Reply-To: <1400031685-28090-1-git-send-email-reyad.attiyat@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/05/14 02:41, Reyad Attiyat wrote:
Again, this has no sign off and is not cc'd to Jiri.

Note these don't need my Ack as far as I'm concerned.

Jonathan
> ---
>   drivers/hid/hid-ids.h        | 3 +++
>   drivers/hid/hid-sensor-hub.c | 9 +++++++++
>   2 files changed, 12 insertions(+)
>
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 34bb220..18e2099 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -633,6 +633,9 @@
>   #define USB_DEVICE_ID_MS_PRESENTER_8K_USB	0x0713
>   #define USB_DEVICE_ID_MS_DIGITAL_MEDIA_3K	0x0730
>   #define USB_DEVICE_ID_MS_COMFORT_MOUSE_4500	0x076c
> +#define USB_DEVICE_ID_MS_SURFACE_PRO_2   0x0799
> +#define USB_DEVICE_ID_MS_TOUCH_COVER_2   0x07a7
> +#define USB_DEVICE_ID_MS_TYPE_COVER_2    0x07a9
>
>   #define USB_VENDOR_ID_MOJO		0x8282
>   #define USB_DEVICE_ID_RETRO_ADAPTER	0x3201
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> index be14b56..eefaaf6 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -711,6 +711,15 @@ static const struct hid_device_id sensor_hub_devices[] = {
>   	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, USB_VENDOR_ID_TEXAS_INSTRUMENTS,
>   			USB_DEVICE_ID_TEXAS_INSTRUMENTS_LENOVO_YOGA),
>   			.driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
> +	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, USB_VENDOR_ID_MICROSOFT,
> +			USB_DEVICE_ID_MS_SURFACE_PRO_2),
> +			.driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
> +	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, USB_VENDOR_ID_MICROSOFT,
> +			USB_DEVICE_ID_MS_TOUCH_COVER_2),
> +			.driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
> +	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, USB_VENDOR_ID_MICROSOFT,
> +			USB_DEVICE_ID_MS_TYPE_COVER_2),
> +			.driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
>   	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, HID_ANY_ID,
>   		     HID_ANY_ID) },
>   	{ }
>

