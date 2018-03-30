Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750967AbeC3KjU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 30 Mar 2018 06:39:20 -0400
Date: Fri, 30 Mar 2018 11:39:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, daniel.baluta@gmail.com
Subject: Re: [PATCH v6 1/6] Staging: iio: adis16209: Indent the field
 definitions
Message-ID: <20180330113914.7d9dc309@archlinux>
In-Reply-To: <508a70d5477067c083408fc81e58023c7e91bc95.1522306893.git.shreeya.patel23498@gmail.com>
References: <cover.1522306893.git.shreeya.patel23498@gmail.com>
        <508a70d5477067c083408fc81e58023c7e91bc95.1522306893.git.shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 29 Mar 2018 14:42:02 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> Have indentation in field definitions to make them
> clearly different from the register addresses.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Note that, given the timing wrt to the current kernel cycle
(merge window will probably open this weekend), this and
everything for the last 2 weeks is now destined to go upstream
in the next cycle.

Thanks,

Jonathan

> ---
> 
> Changes in v5
>   -Change some macro names and have indentation in the field
> definitions.
> 
> Changes in v6
>   -Have indentation in the field definitions and do not
> change the names of the macros as the patch for changing 
> the names has already been applied.
> 
>  drivers/staging/iio/accel/adis16209.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
> index a8453bf..0e6366a 100644
> --- a/drivers/staging/iio/accel/adis16209.c
> +++ b/drivers/staging/iio/accel/adis16209.c
> @@ -71,13 +71,13 @@
>  #define ADIS16209_STAT_REG			0x3C
>  #define  ADIS16209_STAT_ALARM2			BIT(9)
>  #define  ADIS16209_STAT_ALARM1			BIT(8)
> -#define ADIS16209_STAT_SELFTEST_FAIL_BIT	5
> -#define ADIS16209_STAT_SPI_FAIL_BIT		3
> -#define ADIS16209_STAT_FLASH_UPT_FAIL_BIT	2
> +#define  ADIS16209_STAT_SELFTEST_FAIL_BIT	5
> +#define  ADIS16209_STAT_SPI_FAIL_BIT		3
> +#define  ADIS16209_STAT_FLASH_UPT_FAIL_BIT	2
>  /* Power supply above 3.625 V */
> -#define ADIS16209_STAT_POWER_HIGH_BIT		1
> +#define  ADIS16209_STAT_POWER_HIGH_BIT		1
>  /* Power supply below 3.15 V */
> -#define ADIS16209_STAT_POWER_LOW_BIT		0
> +#define  ADIS16209_STAT_POWER_LOW_BIT		0
>  
>  #define ADIS16209_CMD_REG			0x3E
>  #define  ADIS16209_CMD_SW_RESET			BIT(7)

