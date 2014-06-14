Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:44027 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754760AbaFNPCl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 14 Jun 2014 11:02:41 -0400
Message-ID: <539C6486.8000407@kernel.org>
Date: Sat, 14 Jun 2014 16:04:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 05/12] iio:adc:ad7298: Use BIT() and GENMASK() macros
References: <1402549229-4449-1-git-send-email-pmeerw@pmeerw.net> <1402549229-4449-6-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1402549229-4449-6-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/06/14 06:00, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks,
> ---
>   drivers/iio/adc/ad7298.c | 21 +++++++++------------
>   1 file changed, 9 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
> index 2a3b65c..4a8c0a2 100644
> --- a/drivers/iio/adc/ad7298.c
> +++ b/drivers/iio/adc/ad7298.c
> @@ -16,6 +16,7 @@
>   #include <linux/delay.h>
>   #include <linux/module.h>
>   #include <linux/interrupt.h>
> +#include <linux/bitops.h>
>
>   #include <linux/iio/iio.h>
>   #include <linux/iio/sysfs.h>
> @@ -25,23 +26,19 @@
>
>   #include <linux/platform_data/ad7298.h>
>
> -#define AD7298_WRITE	(1 << 15) /* write to the control register */
> -#define AD7298_REPEAT	(1 << 14) /* repeated conversion enable */
> -#define AD7298_CH(x)	(1 << (13 - (x))) /* channel select */
> -#define AD7298_TSENSE	(1 << 5) /* temperature conversion enable */
> -#define AD7298_EXTREF	(1 << 2) /* external reference enable */
> -#define AD7298_TAVG	(1 << 1) /* temperature sensor averaging enable */
> -#define AD7298_PDD	(1 << 0) /* partial power down enable */
> +#define AD7298_WRITE	BIT(15) /* write to the control register */
> +#define AD7298_REPEAT	BIT(14) /* repeated conversion enable */
> +#define AD7298_CH(x)	BIT(13 - (x)) /* channel select */
> +#define AD7298_TSENSE	BIT(5) /* temperature conversion enable */
> +#define AD7298_EXTREF	BIT(2) /* external reference enable */
> +#define AD7298_TAVG	BIT(1) /* temperature sensor averaging enable */
> +#define AD7298_PDD	BIT(0) /* partial power down enable */
>
>   #define AD7298_MAX_CHAN		8
> -#define AD7298_BITS		12
> -#define AD7298_STORAGE_BITS	16
>   #define AD7298_INTREF_mV	2500
>
>   #define AD7298_CH_TEMP		9
>
> -#define RES_MASK(bits)	((1 << (bits)) - 1)
> -
>   struct ad7298_state {
>   	struct spi_device		*spi;
>   	struct regulator		*reg;
> @@ -257,7 +254,7 @@ static int ad7298_read_raw(struct iio_dev *indio_dev,
>   			return ret;
>
>   		if (chan->address != AD7298_CH_TEMP)
> -			*val = ret & RES_MASK(AD7298_BITS);
> +			*val = ret & GENMASK(chan->scan_type.realbits - 1, 0);
>
>   		return IIO_VAL_INT;
>   	case IIO_CHAN_INFO_SCALE:
>

