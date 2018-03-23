Return-Path: <SRS0=FfDz=GN=huawei.com=jonathan.cameron@kernel.org>
Date: Fri, 23 Mar 2018 13:32:04 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Himanshu Jha <himanshujha199640@gmail.com>
CC: <jic23@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
	<knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <gregkh@linuxfoundation.org>,
	<linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
	<linux-kernel@vger.kernel.org>, <21cnbao@gmail.com>
Subject: Re: [PATCH 1/4] Staging: iio: accel: adis16201: Remove unused
 headers
Message-ID: <20180323143204.000026f7@huawei.com>
In-Reply-To: <1521745965-26972-1-git-send-email-himanshujha199640@gmail.com>
References: <1521230786-18155-10-git-send-email-himanshujha199640@gmail.com>
	<1521745965-26972-1-git-send-email-himanshujha199640@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-ID: <linux-iio@vger.kernel.org>

On Fri, 23 Mar 2018 00:42:42 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> Remove few unused headers files since the adis core handles the buffer and
> sysfs support.
> 
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
Please avoid sending a series in reply to a previous series.
It is far to easy for people to miss that this is new material.

This patch is fine, I'll pick it up when on the right computer.

Jonathan
> ---
>  drivers/staging/iio/accel/adis16201.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
> index 97e25a3..b04dbb3 100644
> --- a/drivers/staging/iio/accel/adis16201.c
> +++ b/drivers/staging/iio/accel/adis16201.c
> @@ -6,7 +6,6 @@
>   * Licensed under the GPL-2 or later.
>   */
>  
> -#include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -16,8 +15,6 @@
>  #include <linux/sysfs.h>
>  
>  #include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
> -#include <linux/iio/buffer.h>
>  #include <linux/iio/imu/adis.h>
>  
>  #define ADIS16201_STARTUP_DELAY_MS			220
