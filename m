Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751099AbdI3UlL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 30 Sep 2017 16:41:11 -0400
Date: Sat, 30 Sep 2017 21:41:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Harsha Sharma <harshasharmaiitr@gmail.com>
Cc: gregkh@linuxfoundation.org, lars@metafoo.de, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: Re: [PATCH] staging: iio: trigger: Move header file content to
 source file
Message-ID: <20170930214107.55e03f96@archlinux>
In-Reply-To: <1506450375-15538-1-git-send-email-harshasharmaiitr@gmail.com>
References: <1506450375-15538-1-git-send-email-harshasharmaiitr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 26 Sep 2017 23:56:15 +0530
Harsha Sharma <harshasharmaiitr@gmail.com> wrote:

> The contents of the header file are used only by this single source file.
> Moved content into iio-trig-bfin-timer.c and removed iio-trig-bfin-timer.h
> 
> Signed-off-by: Harsha Sharma <harshasharmaiitr@gmail.com>

Hmm. This one again.  Sometimes you need to not just consider whether a
structure is in use elsewhere in the kernel, but rather what it is for.

If you had done this here you would have discovered the delights of board
files - the means we used to use to describe individual hardware configurations
on ARM before we had device tree (there are still some under arch/arm/mach-pxa
for example). 

The upshot is that if this driver ever moved out of staging and we still
had it configured with platform data - this file would go in
include/linux/platform_data/

Whilst a driver is in staging - all it's code must not be outside
staging which leads to these files being in an unusual location.

Jonathan
> ---
>  drivers/staging/iio/trigger/iio-trig-bfin-timer.c | 20 ++++++++++++++++++-
>  drivers/staging/iio/trigger/iio-trig-bfin-timer.h | 24 -----------------------
>  2 files changed, 19 insertions(+), 25 deletions(-)
>  delete mode 100644 drivers/staging/iio/trigger/iio-trig-bfin-timer.h
> 
> diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> index d80dcf8..2cedcaf 100644
> --- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> +++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> @@ -19,7 +19,25 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/trigger.h>
>  
> -#include "iio-trig-bfin-timer.h"
> +/**
> + * struct iio_bfin_timer_trigger_pdata - timer trigger platform data
> + * @output_enable: Enable external trigger pulse generation.
> + * @active_low: Whether the trigger pulse is active low.
> + * @duty_ns: Length of the trigger pulse in nanoseconds.
> + *
> + * This struct is used to configure the output pulse generation of the blackfin
> + * timer trigger. If output_enable is set to true an external trigger signal
> + * will generated on the pin corresponding to the timer. This is useful for
> + * converters which needs an external signal to start conversion. active_low and
> + * duty_ns are used to configure the type of the trigger pulse. If output_enable
> + * is set to false no external trigger pulse will be generated and active_low
> + * and duty_ns are ignored.
> + **/
> +struct iio_bfin_timer_trigger_pdata {
> +	 bool output_enable;
> +	 bool active_low;
> +	 unsigned int duty_ns;
> +};
>  
>  struct bfin_timer {
>  	unsigned short id, bit;
> diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.h b/drivers/staging/iio/trigger/iio-trig-bfin-timer.h
> deleted file mode 100644
> index c07321f..0000000
> --- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.h
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -#ifndef __IIO_BFIN_TIMER_TRIGGER_H__
> -#define __IIO_BFIN_TIMER_TRIGGER_H__
> -
> -/**
> - * struct iio_bfin_timer_trigger_pdata - timer trigger platform data
> - * @output_enable: Enable external trigger pulse generation.
> - * @active_low: Whether the trigger pulse is active low.
> - * @duty_ns: Length of the trigger pulse in nanoseconds.
> - *
> - * This struct is used to configure the output pulse generation of the blackfin
> - * timer trigger. If output_enable is set to true an external trigger signal
> - * will generated on the pin corresponding to the timer. This is useful for
> - * converters which needs an external signal to start conversion. active_low and
> - * duty_ns are used to configure the type of the trigger pulse. If output_enable
> - * is set to false no external trigger pulse will be generated and active_low
> - * and duty_ns are ignored.
> - **/
> -struct iio_bfin_timer_trigger_pdata {
> -	bool output_enable;
> -	bool active_low;
> -	unsigned int duty_ns;
> -};
> -
> -#endif

