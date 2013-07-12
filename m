Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from h1446028.stratoserver.net ([85.214.92.142]:42816 "EHLO
	mail.ahsoftware.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757508Ab3GLTfK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 12 Jul 2013 15:35:10 -0400
Received: from eiche.ahsoftware (p57B20185.dip0.t-ipconnect.de [87.178.1.133])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.ahsoftware.de (Postfix) with ESMTPSA id 53554888059
	for <linux-iio@vger.kernel.org>; Fri, 12 Jul 2013 21:35:08 +0200 (CEST)
Message-ID: <51E05A4A.2000306@ahsoftware.de>
Date: Fri, 12 Jul 2013 21:34:34 +0200
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: Alexandre Relange <alexandre@relange.org>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/5] iio: mechanical: new HID sensor boolean switch
References: <1370962336-20739-1-git-send-email-alexandre@relange.org> <1370962336-20739-4-git-send-email-alexandre@relange.org>
In-Reply-To: <1370962336-20739-4-git-send-email-alexandre@relange.org>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Am 11.06.2013 16:52, schrieb Alexandre Relange:
> Implements the Boolean Switch sensor from the USB sensor usage tables
> http://www.usb.org/developers/hidpage/HUTRR39b.pdf
> 
> This code is based on drivers/iio/light/hid-sensor-als.c
> 
> Signed-off-by: Alexandre Relange <alexandre@relange.org>
> ---

...

> +
> +/*Format: HID-SENSOR-usage_id_in_hex*/
> +/*Usage ID from spec for Boolean-Switch: 0x200061*/
> +#define DRIVER_NAME "HID-SENSOR-200061"
> +

...

> +static struct platform_driver hid_switch_platform_driver = {
> +	.driver = {
> +		.name	= DRIVER_NAME,
> +		.owner	= THIS_MODULE,
> +	},
> +	.probe		= hid_switch_probe,
> +	.remove		= hid_switch_remove,
> +};
> +module_platform_driver(hid_switch_platform_driver);
> +

You already might add the fix I've recently posted for all the other iio
HID drivers to let the module automatically loaded. It gives a nicier
driver name too.

I've pasted the patch for the als-driver for your reference below.
Be sure to change the usage id to the one for your driver.

Regards,

Alexander Holler

--------
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -30,10 +30,6 @@
 #include <linux/iio/triggered_buffer.h>
 #include "../common/hid-sensors/hid-sensor-trigger.h"

-/*Format: HID-SENSOR-usage_id_in_hex*/
-/*Usage ID from spec for Ambiant-Light: 0x200041*/
-#define DRIVER_NAME "HID-SENSOR-200041"
-
 #define CHANNEL_SCAN_INDEX_ILLUM 0

 struct als_state {
@@ -355,9 +351,19 @@ static int hid_als_remove(struct platform_device *pdev)
 	return 0;
 }

+static struct platform_device_id hid_als_ids[] = {
+	{
+		/* Format: HID-SENSOR-usage_id_in_hex_lowercase */
+		.name = "HID-SENSOR-200041",
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, hid_als_ids);
+
 static struct platform_driver hid_als_platform_driver = {
+	.id_table = hid_als_ids,
 	.driver = {
-		.name	= DRIVER_NAME,
+		.name	= KBUILD_MODNAME,
 		.owner	= THIS_MODULE,
 	},
 	.probe		= hid_als_probe,
-- 1.8.1.5


