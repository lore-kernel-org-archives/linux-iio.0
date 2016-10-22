Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53230 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936614AbcJVP2L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Oct 2016 11:28:11 -0400
Subject: Re: [PATCH 05/13] staging:iio:ad7606: Use oversampling ratio of 1 for
 no oversampling
To: Lars-Peter Clausen <lars@metafoo.de>
References: <1476896828-10544-1-git-send-email-lars@metafoo.de>
 <1476896828-10544-6-git-send-email-lars@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <64c94276-fd4a-b504-c0d6-354a7eae01b4@kernel.org>
Date: Sat, 22 Oct 2016 16:28:09 +0100
MIME-Version: 1.0
In-Reply-To: <1476896828-10544-6-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/10/16 18:07, Lars-Peter Clausen wrote:
> Currently the ad7606 driver uses a value of 0 for the oversampling ratio to
> express that no oversampling is done. Strictly speaking this means though
> that no data capture is done at all. Instead change the driver to use a
> value of 1, this is in accordance with what other drivers do and what the
> IIO spec suggests.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied.

Thanks,

J
> ---
>  drivers/staging/iio/adc/ad7606_core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
> index d3a3551..7c093e2 100644
> --- a/drivers/staging/iio/adc/ad7606_core.c
> +++ b/drivers/staging/iio/adc/ad7606_core.c
> @@ -149,7 +149,7 @@ static IIO_CONST_ATTR(in_voltage_range_available, "5000 10000");
>  
>  static int ad7606_oversampling_get_index(unsigned int val)
>  {
> -	unsigned char supported[] = {0, 2, 4, 8, 16, 32, 64};
> +	unsigned char supported[] = {1, 2, 4, 8, 16, 32, 64};
>  	int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(supported); i++)
> @@ -188,7 +188,7 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> -static IIO_CONST_ATTR(oversampling_ratio_available, "0 2 4 8 16 32 64");
> +static IIO_CONST_ATTR(oversampling_ratio_available, "1 2 4 8 16 32 64");
>  
>  static struct attribute *ad7606_attributes_os_and_range[] = {
>  	&iio_dev_attr_in_voltage_range.dev_attr.attr,
> @@ -449,7 +449,7 @@ struct iio_dev *ad7606_probe(struct device *dev, int irq,
>  	st->bops = bops;
>  	st->base_address = base_address;
>  	st->range = 5000;
> -	st->oversampling = 0;
> +	st->oversampling = 1;
>  
>  	st->reg = devm_regulator_get(dev, "vcc");
>  	if (!IS_ERR(st->reg)) {
> 

