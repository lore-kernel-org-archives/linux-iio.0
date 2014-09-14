Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54540 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494AbaINOF3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 14 Sep 2014 10:05:29 -0400
Message-ID: <5415A0A7.7090507@kernel.org>
Date: Sun, 14 Sep 2014 15:05:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Bastien Nocera <hadess@hadess.net>, linux-iio@vger.kernel.org
CC: Daniel Baluta <daniel.baluta@intel.com>
Subject: Re: [PATCH] iio:kxcjk-1013: Add support for SMO8500 device
References: <1410283148.4077.16.camel@hadess.net>
In-Reply-To: <1410283148.4077.16.camel@hadess.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/09/14 18:19, Bastien Nocera wrote:
> The Onda v975w tablet contains an accelerometer that's advertised over
> ACPI as SMO8500. This device is however a KXCJ9 accelerometer as
> can be seen in the Windows driver's INF file.
> 
> ---
> 
> I tested the patch, and it works correctly in my testing. However,
> there's no GPIO pin for the "data ready" interrupt, and this throws an
> error that looks fatal in the logs (could this be downgraded?), and
> the name of the device doesn't match the hid-sensor-hub ones, making it
> hard for user-space to discover them.

Change the driver to use the i2c device id supplied name instead of hard
coding it.  This is normal in multi part supporting drivers.
We should probably encourage this even in single part supporting drivers
to cut down on churn when more parts are almost inevitably added later!

> (https://github.com/hadess/iio-sensor-proxy is my attempt at something
>  that integrates with user-space and the IIO sensors)
> 
> It will also conflict with Daniel's patch here:
> http://www.spinics.net/lists/linux-iio/msg14438.html
> 
> Cheers
> ---
>  drivers/iio/accel/kxcjk-1013.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 7941cf2..dea5732 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -736,12 +736,14 @@ static SIMPLE_DEV_PM_OPS(kxcjk1013_pm_ops, kxcjk1013_suspend, kxcjk1013_resume);
>  
>  static const struct acpi_device_id kx_acpi_match[] = {
>  	{"KXCJ1013", 0},
> +	{"SMO8500", 0},
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(acpi, kx_acpi_match);
>  
>  static const struct i2c_device_id kxcjk1013_id[] = {
>  	{"kxcjk1013", 0},
> +	{"SMO8500", 0},
>  	{}
>  };
>  
> 
