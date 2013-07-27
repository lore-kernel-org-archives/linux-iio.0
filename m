Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53868 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276Ab3G0LDi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 27 Jul 2013 07:03:38 -0400
Message-ID: <51F3B71C.5050908@kernel.org>
Date: Sat, 27 Jul 2013 13:03:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 12/15] staging:iio:adis16260: Remove unused includes
References: <1374072279-7140-1-git-send-email-lars@metafoo.de> <1374072279-7140-12-git-send-email-lars@metafoo.de>
In-Reply-To: <1374072279-7140-12-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/17/13 15:44, Lars-Peter Clausen wrote:
> Remove some unused includes from the driver.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied.
> ---
>  drivers/staging/iio/gyro/adis16260_core.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
> index 48b0e63..b8a6a04 100644
> --- a/drivers/staging/iio/gyro/adis16260_core.c
> +++ b/drivers/staging/iio/gyro/adis16260_core.c
> @@ -7,15 +7,11 @@
>   */
>  
>  #include <linux/interrupt.h>
> -#include <linux/irq.h>
> -#include <linux/delay.h>
>  #include <linux/mutex.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
>  #include <linux/spi/spi.h>
> -#include <linux/slab.h>
>  #include <linux/sysfs.h>
> -#include <linux/list.h>
>  #include <linux/module.h>
>  
>  #include <linux/iio/iio.h>
> 
