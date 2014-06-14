Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:44017 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754760AbaFNPCS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 14 Jun 2014 11:02:18 -0400
Message-ID: <539C646F.3080103@kernel.org>
Date: Sat, 14 Jun 2014 16:04:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 04/12] iio:adc:ad7476: Use GENMASK() macro
References: <1402549229-4449-1-git-send-email-pmeerw@pmeerw.net> <1402549229-4449-5-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1402549229-4449-5-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/06/14 06:00, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks,
> ---
>   drivers/iio/adc/ad7476.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> index d141d45..ce400ec 100644
> --- a/drivers/iio/adc/ad7476.c
> +++ b/drivers/iio/adc/ad7476.c
> @@ -14,6 +14,7 @@
>   #include <linux/regulator/consumer.h>
>   #include <linux/err.h>
>   #include <linux/module.h>
> +#include <linux/bitops.h>
>
>   #include <linux/iio/iio.h>
>   #include <linux/iio/sysfs.h>
> @@ -21,8 +22,6 @@
>   #include <linux/iio/trigger_consumer.h>
>   #include <linux/iio/triggered_buffer.h>
>
> -#define RES_MASK(bits)	((1 << (bits)) - 1)
> -
>   struct ad7476_state;
>
>   struct ad7476_chip_info {
> @@ -117,7 +116,7 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
>   		if (ret < 0)
>   			return ret;
>   		*val = (ret >> st->chip_info->channel[0].scan_type.shift) &
> -			RES_MASK(st->chip_info->channel[0].scan_type.realbits);
> +			GENMASK(st->chip_info->channel[0].scan_type.realbits - 1, 0);
>   		return IIO_VAL_INT;
>   	case IIO_CHAN_INFO_SCALE:
>   		if (!st->chip_info->int_vref_uv) {
>

