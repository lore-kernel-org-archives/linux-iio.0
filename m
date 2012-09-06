Return-Path: <jkosina@suse.cz>
Date: Thu, 6 Sep 2012 11:12:13 +0200 (CEST)
From: Jiri Kosina <jkosina@suse.cz>
To: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org
Subject: Re: [PATCH 3/9] HID: sensors: add to special driver list
In-Reply-To: <1346849792-22417-4-git-send-email-srinivas.pandruvada@intel.com>
Message-ID: <alpine.LNX.2.00.1209061112000.23820@pobox.suse.cz>
References: <1346849792-22417-1-git-send-email-srinivas.pandruvada@intel.com> <1346849792-22417-4-git-send-email-srinivas.pandruvada@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

On Wed, 5 Sep 2012, Srinivas Pandruvada wrote:

> From: srinivas pandruvada <srinivas.pandruvada@intel.com>
> 
> Adding Intel and STM sensor hub in the list of drivers with
> specialized driver.
> 
> Signed-off-by: srinivas pandruvada <srinivas.pandruvada@intel.com>

Signed-off-by: Jiri Kosina <jkosina@suse.cz>

> ---
>  drivers/hid/hid-core.c | 5 +++++
>  drivers/hid/hid-ids.h  | 6 ++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 60ea284..15ffc0a 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1550,6 +1550,10 @@ static const struct hid_device_id hid_have_special_driver[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_GYRATION, USB_DEVICE_ID_GYRATION_REMOTE_3) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK, USB_DEVICE_ID_HOLTEK_ON_LINE_GRIP) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_HOLTEK_ALT, USB_DEVICE_ID_HOLTEK_ALT_KEYBOARD) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_INTEL_8086, USB_DEVICE_ID_SENSOR_HUB_1020) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_INTEL_8086, USB_DEVICE_ID_SENSOR_HUB_09FA) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_INTEL_8087, USB_DEVICE_ID_SENSOR_HUB_1020) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_INTEL_8087, USB_DEVICE_ID_SENSOR_HUB_09FA) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_KENSINGTON, USB_DEVICE_ID_KS_SLIMBLADE) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_KEYTOUCH, USB_DEVICE_ID_KEYTOUCH_IEC) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_KYE, USB_DEVICE_ID_KYE_ERGO_525V) },
> @@ -1642,6 +1646,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_SUNPLUS, USB_DEVICE_ID_SUNPLUS_WDESKTOP) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_STANTUM_STM, USB_DEVICE_ID_SENSOR_HUB_7014) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb300) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb304) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb323) },
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 1dcb76f..8a270a3 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -419,6 +419,11 @@
>  #define USB_VENDOR_ID_IMATION		0x0718
>  #define USB_DEVICE_ID_DISC_STAKKA	0xd000
>  
> +#define USB_VENDOR_ID_INTEL_8086	0x8086
> +#define USB_VENDOR_ID_INTEL_8087	0x8087
> +#define USB_DEVICE_ID_SENSOR_HUB_1020	0x1020
> +#define USB_DEVICE_ID_SENSOR_HUB_09FA	0x09FA
> +
>  #define USB_VENDOR_ID_IRTOUCHSYSTEMS	0x6615
>  #define USB_DEVICE_ID_IRTOUCH_INFRARED_USB	0x0070
>  
> @@ -695,6 +700,7 @@
>  
>  #define USB_VENDOR_ID_STANTUM_STM		0x0483
>  #define USB_DEVICE_ID_MTP_STM		0x3261
> +#define USB_DEVICE_ID_SENSOR_HUB_7014	0x7014
>  
>  #define USB_VENDOR_ID_STANTUM_SITRONIX		0x1403
>  #define USB_DEVICE_ID_MTP_SITRONIX		0x5001
> -- 
> 1.7.11.4
> 

-- 
Jiri Kosina
SUSE Labs
