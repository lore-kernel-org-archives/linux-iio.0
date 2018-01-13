Return-Path: <SRS0=sDnG=EI=metafoo.de=lars@kernel.org>
Subject: Re: [PATCH] iio: adc: driver for ti adc081s/adc101s/adc121s
To: Milan Stevanovic <milan.o.stevanovic@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 knaack.h@gmx.de, pmeerw@pmeerw.net, Michael.Hennerich@analog.com
References: <23df1de6-dd7e-5c45-9634-1a3ec2e9687b@gmail.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <fdeb4497-ff2d-5d89-156f-db071a43a343@metafoo.de>
Date: Sat, 13 Jan 2018 10:12:38 +0100
MIME-Version: 1.0
In-Reply-To: <23df1de6-dd7e-5c45-9634-1a3ec2e9687b@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 01/12/2018 09:38 PM, Milan Stevanovic wrote:
> From cb437dd49444fb12897f88ccf485369e6ed3184e Mon Sep 17 00:00:00 2001
> From: Milan Stevanovic <milan.o.stevanovic@gmail.com>
> Date: Sun, 7 Jan 2018 21:44:33 +0100
> Subject: [PATCH] iio: adc: driver for ti adc081s/adc101s/adc121s
> 
>     Add Linux device driver for TI single-channel CMOS
>     8/10/12-bit analog-to-digital converter with a
>     high-speed serial interface.
> 
> Signed-off-by: Milan Stevanovic <milan.o.stevanovic@gmail.com>
> ---
>  drivers/iio/adc/ad7476.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> index b7706bf..e872081 100644
> --- a/drivers/iio/adc/ad7476.c
> +++ b/drivers/iio/adc/ad7476.c
> @@ -1,9 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
> - * AD7466/7/8 AD7476/5/7/8 (A) SPI ADC driver
>   *
> - * Copyright 2010 Analog Devices Inc.

The copyright should probably stay.

> + * Analog Device AD7466/7/8 AD7476/5/7/8 (A) SPI ADC driver

Analog Devices with a s at the end.

> + * TI ADC081S/ADC101S/ADC121S 8/10/12-bit SPI ADC driver
>   *
> - * Licensed under the GPL-2 or later.
>   */
>  
[...]
