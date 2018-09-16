Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728100AbeIPQen (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Sep 2018 12:34:43 -0400
Date: Sun, 16 Sep 2018 12:12:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: <linux-iio@vger.kernel.org>, <Michael.Hennerich@analog.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>
Subject: Re: [PATCH V2] staging:iio:ad7606: fix voltage scales
Message-ID: <20180916121202.547a8d41@archlinux>
In-Reply-To: <20180913084409.5986-1-alexandru.ardelean@analog.com>
References: <20180913084409.5986-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 13 Sep 2018 11:44:09 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> Fixes commit 17be2a2905a6ec9aa27cd59521495e2f490d2af0 ("staging: iio:
> ad7606: replace range/range_available with corresponding scale").
> 
> The AD7606 devices don't have a 2.5V voltage range, they have 5V & 10V
> voltage range, which is selectable via the `gpio_range` descriptor.
> 
> The scales also seem to have been miscomputed, because when they were
> applied to the raw values, the results differ from the expected values.
> After checking the ADC transfer function in the datasheet, these were
> re-computed.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
On thing inline.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
> 
> Changelog V1 -> V2:
> * changed 2.5/2**16 and 5/2**16 -> 5000/32768 and 10000/32768, because
>   my computation of 32768 in power of 2 is also wrong; it's 2**15, not 2**16
>   and the datasheet mentions 32768, so use that value
> 
>  drivers/staging/iio/adc/ad7606.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
> index c5fe3003075b..87d5fb073c95 100644
> --- a/drivers/staging/iio/adc/ad7606.c
> +++ b/drivers/staging/iio/adc/ad7606.c
> @@ -26,9 +26,11 @@
>  
>  #include "ad7606.h"
>  
> -/* Scales are computed as 2.5/2**16 and 5/2**16 respectively */

This isn't a kernel comment style. I'll fix up.

> +/* Scales are computed as 5000/32768 and 10000/32768 respectively,
> + * so that when applied to the raw values they provide mV values
> + */
>  static const unsigned int scale_avail[2][2] = {
> -	{0, 38147}, {0, 76294}
> +	{0, 152588}, {0, 305176}
>  };
>  
>  static int ad7606_reset(struct ad7606_state *st)
