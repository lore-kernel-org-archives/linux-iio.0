Return-Path: <lars@metafoo.de>
Message-ID: <53BBF178.2050301@metafoo.de>
Date: Tue, 08 Jul 2014 15:26:16 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 1/6] staging:iio:ad7291 remove double define
References: <53BBD0C7.4050003@gmx.de>
In-Reply-To: <53BBD0C7.4050003@gmx.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 07/08/2014 01:06 PM, Hartmut Knaack wrote:
> Remove second instance of definition of AD7291_BITS.
>
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>

All patches in this series:

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.

> ---
> diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
> index 7194bd1..c08b258 100644
> --- a/drivers/staging/iio/adc/ad7291.c
> +++ b/drivers/staging/iio/adc/ad7291.c
> @@ -73,8 +73,6 @@
>   #define AD7291_T_VALUE_FLOAT_OFFSET	2
>   #define AD7291_T_VALUE_FLOAT_MASK	0x2
>
> -#define AD7291_BITS			12
> -
>   struct ad7291_chip_info {
>   	struct i2c_client	*client;
>   	struct regulator	*reg;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
