Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:43852 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754734AbaFNOrF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 14 Jun 2014 10:47:05 -0400
Message-ID: <539C60DE.1010209@kernel.org>
Date: Sat, 14 Jun 2014 15:49:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 02/12] iio:adc:ad5504: Use BIT() and GENMASK() macros
References: <1402549229-4449-1-git-send-email-pmeerw@pmeerw.net> <1402549229-4449-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1402549229-4449-3-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/06/14 06:00, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
I would have ever so slightly preferred the kernel doc fix
to be in another patch, but ah well.

Applied to the togreg branch of iio.git

Thanks,
> ---
>   drivers/iio/dac/ad5504.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
> index 1e64493..c917dd2 100644
> --- a/drivers/iio/dac/ad5504.c
> +++ b/drivers/iio/dac/ad5504.c
> @@ -15,17 +15,16 @@
>   #include <linux/sysfs.h>
>   #include <linux/regulator/consumer.h>
>   #include <linux/module.h>
> +#include <linux/bitops.h>
>
>   #include <linux/iio/iio.h>
>   #include <linux/iio/sysfs.h>
>   #include <linux/iio/events.h>
>   #include <linux/iio/dac/ad5504.h>
>
> -#define AD5505_BITS			12
> -#define AD5504_RES_MASK			((1 << (AD5505_BITS)) - 1)
> -
> -#define AD5504_CMD_READ			(1 << 15)
> -#define AD5504_CMD_WRITE		(0 << 15)
> +#define AD5504_RES_MASK			GENMASK(11, 0)
> +#define AD5504_CMD_READ			BIT(15)
> +#define AD5504_CMD_WRITE		0
>   #define AD5504_ADDR(addr)		((addr) << 12)
>
>   /* Registers */
> @@ -42,7 +41,7 @@
>
>   /**
>    * struct ad5446_state - driver instance specific data
> - * @us:			spi_device
> + * @spi:			spi_device
>    * @reg:		supply regulator
>    * @vref_mv:		actual reference voltage used
>    * @pwr_down_mask	power down mask
>

