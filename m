Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752115AbeCCPke (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Mar 2018 10:40:34 -0500
Date: Sat, 3 Mar 2018 15:40:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, daniel.baluta@gmail.com
Subject: Re: [PATCH 2/6] Staging: iio: adis16209: Change the definition name
Message-ID: <20180303154029.1d8f30ee@archlinux>
In-Reply-To: <646c1e2ac1311db1879a5cae58f5f0a0c07114a5.1519995673.git.shreeya.patel23498@gmail.com>
References: <cover.1519995673.git.shreeya.patel23498@gmail.com>
        <646c1e2ac1311db1879a5cae58f5f0a0c07114a5.1519995673.git.shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri,  2 Mar 2018 18:53:41 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> The change in the definition name makes it then obvious
> what the units are throughout the driver and there will
> be no need of the comment.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/accel/adis16209.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
> index 58f604d..830c278 100644
> --- a/drivers/staging/iio/accel/adis16209.c
> +++ b/drivers/staging/iio/accel/adis16209.c
> @@ -20,7 +20,7 @@
>  #include <linux/iio/buffer.h>
>  #include <linux/iio/imu/adis.h>
>  
> -#define ADIS16209_STARTUP_DELAY	220 /* ms */
> +#define ADIS16209_STARTUP_DELAY_MS	220
>  
>  /* Flash memory write count */
>  #define ADIS16209_FLASH_CNT      0x00
> @@ -303,7 +303,7 @@ static const struct adis_data adis16209_data = {
>  
>  	.self_test_mask = ADIS16209_MSC_CTRL_SELF_TEST_EN,
>  	.self_test_no_autoclear = true,
> -	.startup_delay = ADIS16209_STARTUP_DELAY,
> +	.startup_delay = ADIS16209_STARTUP_DELAY_MS,
>  
>  	.status_error_msgs = adis16209_status_error_msgs,
>  	.status_error_mask = BIT(ADIS16209_DIAG_STAT_SELFTEST_FAIL_BIT) |

