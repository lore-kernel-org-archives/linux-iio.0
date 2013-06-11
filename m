Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55437 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127Ab3FKTcT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 11 Jun 2013 15:32:19 -0400
Message-ID: <51B77B42.9060800@kernel.org>
Date: Tue, 11 Jun 2013 20:32:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/4] staging:iio:adis16130: Remove unused includes
References: <1370872815-14386-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1370872815-14386-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/10/2013 03:00 PM, Lars-Peter Clausen wrote:
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/staging/iio/gyro/adis16130_core.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/gyro/adis16130_core.c b/drivers/staging/iio/gyro/adis16130_core.c
> index 531b803..5288635 100644
> --- a/drivers/staging/iio/gyro/adis16130_core.c
> +++ b/drivers/staging/iio/gyro/adis16130_core.c
> @@ -6,18 +6,12 @@
>   * Licensed under the GPL-2 or later.
>   */
>  
> -#include <linux/delay.h>
>  #include <linux/mutex.h>
> -#include <linux/device.h>
>  #include <linux/kernel.h>
>  #include <linux/spi/spi.h>
> -#include <linux/slab.h>
> -#include <linux/sysfs.h>
> -#include <linux/list.h>
>  #include <linux/module.h>
>  
>  #include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
>  
>  #define ADIS16130_CON         0x0
>  #define ADIS16130_CON_RD      (1 << 6)
> 
