Return-Path: <SRS0=Sopg=OI=sntech.de=heiko@kernel.org>
From: Heiko Stuebner <heiko@sntech.de>
To: Matheus Tavares <matheus.bernardino@usp.br>, Milo Kim <milo.kim@ti.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, William Breathitt Gray <vilhelm.gray@gmail.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Michal Simek <michal.simek@xilinx.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, kernel-usp@googlegroups.com, Lucas Santos <ilucas.ms@gmail.com>
Subject: Re: [PATCH] iio: adc: Replace license text w/ SPDX identifier
Date: Thu, 29 Nov 2018 14:18:03 +0100
Message-ID: <3999722.Y4omgby9AG@phil>
In-Reply-To: <20181128175312.9634-1-matheus.bernardino@usp.br>
References: <20181128175312.9634-1-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-iio@vger.kernel.org>

Am Mittwoch, 28. November 2018, 18:53:12 CET schrieb Matheus Tavares:
> From: Lucas Santos <ilucas.ms@gmail.com>
> 
> This patch removes all license boilerplate texts from the .c and .h
> files at drivers/iio/adc/ and, instead, adds the proper SPDX license
> identifiers.
> 
> Signed-off-by: Lucas Santos <ilucas.ms@gmail.com>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---

> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index 1f98566d5b3c..234c6df348ce 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -1,16 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Rockchip Successive Approximation Register (SAR) A/D Converter
>   * Copyright (C) 2014 ROCKCHIP, Inc.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>   */
>  
>  #include <linux/module.h>

For the Rockchip-part
Acked-by: Heiko Stuebner <heiko@sntech.de>
