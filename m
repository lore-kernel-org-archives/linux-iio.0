Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:50365 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750914AbdBSKCa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Feb 2017 05:02:30 -0500
Subject: Re: [PATCH 4/4] iio: accel: adxl345: Add ACPI support
To: Eva Rachel Retuya <eraretuya@gmail.com>, jic23@kernel.org,
        linux-iio@vger.kernel.org
References: <1487239327-21406-1-git-send-email-eraretuya@gmail.com>
 <1487239327-21406-5-git-send-email-eraretuya@gmail.com>
Cc: knaack.h@gmx.de, pmeerw@pmeerw.net, dmitry.torokhov@gmail.com,
        michael.hennerich@analog.com, daniel.baluta@gmail.com,
        amsfield22@gmail.com, florian.vaussard@heig-vd.ch,
        linux-kernel@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <cd10157c-a1ac-c042-bd91-3cb7647919af@metafoo.de>
Date: Sun, 19 Feb 2017 11:01:23 +0100
MIME-Version: 1.0
In-Reply-To: <1487239327-21406-5-git-send-email-eraretuya@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/16/2017 11:02 AM, Eva Rachel Retuya wrote:
[...]
> @@ -54,9 +55,17 @@ static const struct i2c_device_id adxl345_i2c_id[] = {
>  
>  MODULE_DEVICE_TABLE(i2c, adxl345_i2c_id);
>  
> +static const struct acpi_device_id adxl345_acpi_id[] = {
> +	{ "ADX0345", 0 },

Who allocated this ID? ADX does not seem to be a registered vendor ID
(http://www.uefi.org/PNP_ACPI_Registry).

> +	{ }
> +};

