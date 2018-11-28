Return-Path: <SRS0=yNLY=OH=broadcom.com=scott.branden@kernel.org>
Subject: Re: [PATCH] iio: adc: Replace license text w/ SPDX identifier
To: Matheus Tavares <matheus.bernardino@usp.br>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@aj.id.au>,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 Eugen Hristev <eugen.hristev@microchip.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Jon Mason <jonmason@broadcom.com>, bcm-kernel-feedback-list@broadcom.com,
 Support Opensource <support.opensource@diasemi.com>,
 Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Andreas Klinger <ak@it-klinger.de>, Milo Kim <milo.kim@ti.com>,
 Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux
 <slemieux.tyco@gmail.com>, Carlo Caione <carlo@caione.org>,
 Kevin Hilman <khilman@baylibre.com>, Heiko Stuebner <heiko@sntech.de>,
 William Breathitt Gray <vilhelm.gray@gmail.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Michal Simek <michal.simek@xilinx.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-samsung-soc@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-rockchip@lists.infradead.org, kernel-usp@googlegroups.com,
 Lucas Santos <ilucas.ms@gmail.com>
References: <20181128175312.9634-1-matheus.bernardino@usp.br>
From: Scott Branden <scott.branden@broadcom.com>
Message-ID: <9ea19805-de34-9286-e540-98b75e49f574@broadcom.com>
Date: Wed, 28 Nov 2018 10:54:04 -0800
MIME-Version: 1.0
In-Reply-To: <20181128175312.9634-1-matheus.bernardino@usp.br>
Content-Type: multipart/alternative;
 boundary="------------3A64579E9D7745788356ECEC"
List-ID: <linux-iio@vger.kernel.org>

This is a multi-part message in MIME format.
--------------3A64579E9D7745788356ECEC
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2018-11-28 9:53 a.m., Matheus Tavares wrote:
> From: Lucas Santos <ilucas.ms@gmail.com>
>
> This patch removes all license boilerplate texts from the .c and .h

I know other people don't follow the patch guidelines,
<https://www.kernel.org/doc/html/latest/process/submitting-patches.html>

but more info on proper commit message format in link. 
<https://www.kernel.org/doc/html/latest/process/submitting-patches.html>

(Don't say "this patch" or "this commit" or "I changed") - use 
imperative present tense. 
<https://www.kernel.org/doc/html/latest/process/submitting-patches.html>

https://www.kernel.org/doc/html/latest/process/submitting-patches.html

> files at drivers/iio/adc/ and, instead, adds the proper SPDX license
> identifiers.
>
> Signed-off-by: Lucas Santos <ilucas.ms@gmail.com>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>   drivers/iio/adc/ad7266.c             |  3 +--
>   drivers/iio/adc/ad7291.c             |  3 +--
>   drivers/iio/adc/ad7298.c             |  3 +--
>   drivers/iio/adc/ad7766.c             |  3 +--
>   drivers/iio/adc/ad7791.c             |  3 +--
>   drivers/iio/adc/ad7793.c             |  3 +--
>   drivers/iio/adc/ad7887.c             |  3 +--
>   drivers/iio/adc/ad7923.c             |  3 +--
>   drivers/iio/adc/ad799x.c             |  5 +----
>   drivers/iio/adc/ad_sigma_delta.c     |  3 +--
>   drivers/iio/adc/aspeed_adc.c         |  6 +-----
>   drivers/iio/adc/at91-sama5d2_adc.c   | 10 +---------
>   drivers/iio/adc/at91_adc.c           |  3 +--
>   drivers/iio/adc/axp20x_adc.c         |  5 +----
>   drivers/iio/adc/axp288_adc.c         | 13 +------------
>   drivers/iio/adc/bcm_iproc_adc.c      | 13 +------------

Broadcom change:

Acked-by: Scott Branden <scott.branden@broadcom.com>

>   drivers/iio/adc/berlin2-adc.c        |  5 +----
>   drivers/iio/adc/cc10001_adc.c        |  6 +-----
>   drivers/iio/adc/cpcap-adc.c          | 10 +---------
>   drivers/iio/adc/da9150-gpadc.c       |  6 +-----
>   drivers/iio/adc/dln2-adc.c           |  5 +----
>   drivers/iio/adc/ep93xx_adc.c         |  5 +----
>   drivers/iio/adc/exynos_adc.c         | 11 +----------
>   drivers/iio/adc/fsl-imx25-gcq.c      |  5 +----
>   drivers/iio/adc/hi8435.c             |  6 +-----
>   drivers/iio/adc/hx711.c              |  6 +-----
>   drivers/iio/adc/imx7d_adc.c          |  6 +-----
>   drivers/iio/adc/ina2xx-adc.c         |  7 +------
>   drivers/iio/adc/lp8788_adc.c         |  5 +----
>   drivers/iio/adc/lpc18xx_adc.c        |  5 +----
>   drivers/iio/adc/lpc32xx_adc.c        | 15 +--------------
>   drivers/iio/adc/ltc2471.c            |  3 +--
>   drivers/iio/adc/ltc2485.c            |  5 +----
>   drivers/iio/adc/ltc2497.c            |  3 +--
>   drivers/iio/adc/max1027.c            |  5 +----
>   drivers/iio/adc/max1118.c            |  5 +----
>   drivers/iio/adc/max1363.c            |  5 +----
>   drivers/iio/adc/mcp320x.c            |  5 +----
>   drivers/iio/adc/mcp3422.c            |  6 +-----
>   drivers/iio/adc/men_z188_adc.c       |  5 +----
>   drivers/iio/adc/meson_saradc.c       |  5 +----
>   drivers/iio/adc/mt6577_auxadc.c      | 10 +---------
>   drivers/iio/adc/mxs-lradc-adc.c      | 11 +----------
>   drivers/iio/adc/nau7802.c            |  3 +--
>   drivers/iio/adc/palmas_gpadc.c       |  5 +----
>   drivers/iio/adc/qcom-pm8xxx-xoadc.c  |  1 +
>   drivers/iio/adc/qcom-spmi-iadc.c     | 10 +---------
>   drivers/iio/adc/qcom-spmi-vadc.c     | 10 +---------
>   drivers/iio/adc/rockchip_saradc.c    | 11 +----------
>   drivers/iio/adc/spear_adc.c          |  3 +--
>   drivers/iio/adc/stx104.c             | 10 +---------
>   drivers/iio/adc/sun4i-gpadc-iio.c    |  5 +----
>   drivers/iio/adc/ti-adc081c.c         |  5 +----
>   drivers/iio/adc/ti-adc0832.c         |  5 +----
>   drivers/iio/adc/ti-adc084s021.c      |  5 +----
>   drivers/iio/adc/ti-adc108s102.c      | 10 +---------
>   drivers/iio/adc/ti-adc12138.c        |  5 +----
>   drivers/iio/adc/ti-ads1015.c         |  5 +----
>   drivers/iio/adc/ti-ads8688.c         |  5 +----
>   drivers/iio/adc/ti-tlc4541.c         |  5 +----
>   drivers/iio/adc/ti_am335x_adc.c      | 10 +---------
>   drivers/iio/adc/twl4030-madc.c       | 16 +---------------
>   drivers/iio/adc/twl6030-gpadc.c      | 16 +---------------
>   drivers/iio/adc/vf610_adc.c          | 15 +--------------
>   drivers/iio/adc/viperboard_adc.c     |  7 +------
>   drivers/iio/adc/xilinx-xadc-core.c   |  3 +--
>   drivers/iio/adc/xilinx-xadc-events.c |  3 +--
>   drivers/iio/adc/xilinx-xadc.h        |  3 +--
>   68 files changed, 68 insertions(+), 361 deletions(-)
>
> diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
> index 605eb5e7e829..b538824e76cd 100644
> --- a/drivers/iio/adc/ad7266.c
> +++ b/drivers/iio/adc/ad7266.c
> @@ -1,9 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * AD7266/65 SPI ADC driver
>    *
>    * Copyright 2012 Analog Devices Inc.
> - *
> - * Licensed under the GPL-2.
>    */
>   
>   #include <linux/device.h>
> diff --git a/drivers/iio/adc/ad7291.c b/drivers/iio/adc/ad7291.c
> index a862b5d8fb4b..7bc9f2e8cd3c 100644
> --- a/drivers/iio/adc/ad7291.c
> +++ b/drivers/iio/adc/ad7291.c
> @@ -1,9 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0+
>   /*
>    * AD7291 8-Channel, I2C, 12-Bit SAR ADC with Temperature Sensor
>    *
>    * Copyright 2010-2011 Analog Devices Inc.
> - *
> - * Licensed under the GPL-2 or later.
>    */
>   
>   #include <linux/device.h>
> diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
> index e0220825fde0..e7ba5e29d0d6 100644
> --- a/drivers/iio/adc/ad7298.c
> +++ b/drivers/iio/adc/ad7298.c
> @@ -1,9 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * AD7298 SPI ADC driver
>    *
>    * Copyright 2011 Analog Devices Inc.
> - *
> - * Licensed under the GPL-2.
>    */
>   
>   #include <linux/device.h>
> diff --git a/drivers/iio/adc/ad7766.c b/drivers/iio/adc/ad7766.c
> index 3ae14fc8c649..ff14959f55de 100644
> --- a/drivers/iio/adc/ad7766.c
> +++ b/drivers/iio/adc/ad7766.c
> @@ -1,9 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0+
>   /*
>    * AD7766/AD7767 SPI ADC driver
>    *
>    * Copyright 2016 Analog Devices Inc.
> - *
> - * Licensed under the GPL-2 or later.
>    */
>   
>   #include <linux/clk.h>
> diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
> index a9ff0695ddf7..1b9ab2ef9bae 100644
> --- a/drivers/iio/adc/ad7791.c
> +++ b/drivers/iio/adc/ad7791.c
> @@ -1,10 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * AD7787/AD7788/AD7789/AD7790/AD7791 SPI ADC driver
>    *
>    * Copyright 2012 Analog Devices Inc.
>    *  Author: Lars-Peter Clausen <lars@metafoo.de>
> - *
> - * Licensed under the GPL-2.
>    */
>   
>   #include <linux/interrupt.h>
> diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
> index 4ac3ae62f56f..886263a3d2b1 100644
> --- a/drivers/iio/adc/ad7793.c
> +++ b/drivers/iio/adc/ad7793.c
> @@ -1,9 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * AD7785/AD7792/AD7793/AD7794/AD7795 SPI ADC driver
>    *
>    * Copyright 2011-2012 Analog Devices Inc.
> - *
> - * Licensed under the GPL-2.
>    */
>   
>   #include <linux/interrupt.h>
> diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
> index 9d4c2467d362..7c17b53dea2e 100644
> --- a/drivers/iio/adc/ad7887.c
> +++ b/drivers/iio/adc/ad7887.c
> @@ -1,9 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * AD7887 SPI ADC driver
>    *
>    * Copyright 2010-2011 Analog Devices Inc.
> - *
> - * Licensed under the GPL-2.
>    */
>   
>   #include <linux/device.h>
> diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
> index d62dbb62be45..cad67ee9bb38 100644
> --- a/drivers/iio/adc/ad7923.c
> +++ b/drivers/iio/adc/ad7923.c
> @@ -1,10 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * AD7904/AD7914/AD7923/AD7924 SPI ADC driver
>    *
>    * Copyright 2011 Analog Devices Inc (from AD7923 Driver)
>    * Copyright 2012 CS Systemes d'Information
> - *
> - * Licensed under the GPL-2.
>    */
>   
>   #include <linux/device.h>
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index 7a5b5d00a87d..65d60fc173aa 100644
> --- a/drivers/iio/adc/ad799x.c
> +++ b/drivers/iio/adc/ad799x.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * iio/adc/ad799x.c
>    * Copyright (C) 2010-2011 Michael Hennerich, Analog Devices Inc.
> @@ -11,10 +12,6 @@
>    * based on linux/drivers/acron/char/pcf8583.c
>    * Copyright (C) 2000 Russell King
>    *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
>    * ad799x.c
>    *
>    * Support for ad7991, ad7995, ad7999, ad7992, ad7993, ad7994, ad7997,
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index ff5f2da2e1b1..cd0c3cda132a 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -1,10 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * Support code for Analog Devices Sigma-Delta ADCs
>    *
>    * Copyright 2012 Analog Devices Inc.
>    *  Author: Lars-Peter Clausen <lars@metafoo.de>
> - *
> - * Licensed under the GPL-2.
>    */
>   
>   #include <linux/interrupt.h>
> diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
> index 9515ca165dfd..5eec9d2a3eb1 100644
> --- a/drivers/iio/adc/aspeed_adc.c
> +++ b/drivers/iio/adc/aspeed_adc.c
> @@ -1,12 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * Aspeed AST2400/2500 ADC
>    *
>    * Copyright (C) 2017 Google, Inc.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU General Public License,
> - * version 2, as published by the Free Software Foundation.
> - *
>    */
>   
>   #include <linux/clk.h>
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index d5ea84cf6460..62ceca3fe3bf 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -1,17 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * Atmel ADC driver for SAMA5D2 devices and compatible.
>    *
>    * Copyright (C) 2015 Atmel,
>    *               2015 Ludovic Desroches <ludovic.desroches@atmel.com>
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> - * GNU General Public License for more details.
>    */
>   
>   #include <linux/bitops.h>
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 75d2f73582a3..21b07413a998 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -1,9 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0+
>   /*
>    * Driver for the ADC present in the Atmel AT91 evaluation boards.
>    *
>    * Copyright 2011 Free Electrons
> - *
> - * Licensed under the GPLv2 or later.
>    */
>   
>   #include <linux/bitmap.h>
> diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
> index 5be789269353..42eefe2593ec 100644
> --- a/drivers/iio/adc/axp20x_adc.c
> +++ b/drivers/iio/adc/axp20x_adc.c
> @@ -1,11 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /* ADC driver for AXP20X and AXP22X PMICs
>    *
>    * Copyright (c) 2016 Free Electrons NextThing Co.
>    *	Quentin Schulz <quentin.schulz@free-electrons.com>
> - *
> - * This program is free software; you can redistribute it and/or modify it under
> - * the terms of the GNU General Public License version 2 as published by the
> - * Free Software Foundation.
>    */
>   
>   #include <linux/completion.h>
> diff --git a/drivers/iio/adc/axp288_adc.c b/drivers/iio/adc/axp288_adc.c
> index 031d568b4972..24c0ec2cfd67 100644
> --- a/drivers/iio/adc/axp288_adc.c
> +++ b/drivers/iio/adc/axp288_adc.c
> @@ -1,19 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * axp288_adc.c - X-Powers AXP288 PMIC ADC Driver
>    *
>    * Copyright (C) 2014 Intel Corporation
> - *
> - * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; version 2 of the License.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the GNU
> - * General Public License for more details.
> - *
>    */
>   
>   #include <linux/module.h>
> diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
> index 7af59a4bbd8d..2eadef68bd49 100644
> --- a/drivers/iio/adc/bcm_iproc_adc.c
> +++ b/drivers/iio/adc/bcm_iproc_adc.c
> @@ -1,17 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * Copyright 2016 Broadcom
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License, version 2, as
> - * published by the Free Software Foundation (the "GPL").
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License version 2 (GPLv2) for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * version 2 (GPLv2) along with this source code.
>    */
>   
>   #include <linux/module.h>
> diff --git a/drivers/iio/adc/berlin2-adc.c b/drivers/iio/adc/berlin2-adc.c
> index 72d8fa94ab31..3b0ca5f326ed 100644
> --- a/drivers/iio/adc/berlin2-adc.c
> +++ b/drivers/iio/adc/berlin2-adc.c
> @@ -1,13 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * Marvell Berlin2 ADC driver
>    *
>    * Copyright (C) 2015 Marvell Technology Group Ltd.
>    *
>    * Antoine Tenart <antoine.tenart@free-electrons.com>
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2. This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
>    */
>   
>   #include <linux/iio/iio.h>
> diff --git a/drivers/iio/adc/cc10001_adc.c b/drivers/iio/adc/cc10001_adc.c
> index 707d8b24b072..8b72037e04b2 100644
> --- a/drivers/iio/adc/cc10001_adc.c
> +++ b/drivers/iio/adc/cc10001_adc.c
> @@ -1,10 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * Copyright (c) 2014-2015 Imagination Technologies Ltd.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of the GNU General Public License version 2 as published by
> - * the Free Software Foundation.
> - *
>    */
>   
>   #include <linux/clk.h>
> diff --git a/drivers/iio/adc/cpcap-adc.c b/drivers/iio/adc/cpcap-adc.c
> index 9ad60421d360..c1bfa4543125 100644
> --- a/drivers/iio/adc/cpcap-adc.c
> +++ b/drivers/iio/adc/cpcap-adc.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * Copyright (C) 2017 Tony Lindgren <tony@atomide.com>
>    *
> @@ -5,15 +6,6 @@
>    * earlier driver found in the Motorola Linux kernel:
>    *
>    * Copyright (C) 2009-2010 Motorola, Inc.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> - * GNU General Public License for more details.
>    */
>   
>   #include <linux/delay.h>
> diff --git a/drivers/iio/adc/da9150-gpadc.c b/drivers/iio/adc/da9150-gpadc.c
> index 0a5d9ce79164..620274890645 100644
> --- a/drivers/iio/adc/da9150-gpadc.c
> +++ b/drivers/iio/adc/da9150-gpadc.c
> @@ -1,14 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0+
>   /*
>    * DA9150 GPADC Driver
>    *
>    * Copyright (c) 2014 Dialog Semiconductor
>    *
>    * Author: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> - *
> - * This program is free software; you can redistribute  it and/or modify it
> - * under  the terms of  the GNU General  Public License as published by the
> - * Free Software Foundation;  either version 2 of the  License, or (at your
> - * option) any later version.
>    */
>   
>   #include <linux/kernel.h>
> diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
> index c64c6675cae6..03f0f8fc6350 100644
> --- a/drivers/iio/adc/dln2-adc.c
> +++ b/drivers/iio/adc/dln2-adc.c
> @@ -1,11 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * Driver for the Diolan DLN-2 USB-ADC adapter
>    *
>    * Copyright (c) 2017 Jack Andersen
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License as
> - * published by the Free Software Foundation, version 2.
>    */
>   
>   #include <linux/kernel.h>
> diff --git a/drivers/iio/adc/ep93xx_adc.c b/drivers/iio/adc/ep93xx_adc.c
> index 5036c392cb20..8f614c84b643 100644
> --- a/drivers/iio/adc/ep93xx_adc.c
> +++ b/drivers/iio/adc/ep93xx_adc.c
> @@ -1,12 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * Driver for ADC module on the Cirrus Logic EP93xx series of SoCs
>    *
>    * Copyright (C) 2015 Alexander Sverdlin
>    *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
>    * The driver uses polling to get the conversion status. According to EP93xx
>    * datasheets, reading ADCResult register starts the conversion, but user is also
>    * responsible for ensuring that delay between adjacent conversion triggers is
> diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
> index f10443f92e4c..9f9c186e2135 100644
> --- a/drivers/iio/adc/exynos_adc.c
> +++ b/drivers/iio/adc/exynos_adc.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0+
>   /*
>    *  exynos_adc.c - Support for ADC in EXYNOS SoCs
>    *
> @@ -5,16 +6,6 @@
>    *
>    *  Copyright (C) 2013 Naveen Krishna Chatradhi <ch.naveen@samsung.com>
>    *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
>    *  You should have received a copy of the GNU General Public License
>    *  along with this program; if not, write to the Free Software
>    *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
> index 929c617db364..e03a434b3cd5 100644
> --- a/drivers/iio/adc/fsl-imx25-gcq.c
> +++ b/drivers/iio/adc/fsl-imx25-gcq.c
> @@ -1,10 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * Copyright (C) 2014-2015 Pengutronix, Markus Pargmann <mpa@pengutronix.de>
>    *
> - * This program is free software; you can redistribute it and/or modify it under
> - * the terms of the GNU General Public License version 2 as published by the
> - * Free Software Foundation.
> - *
>    * This is the driver for the imx25 GCQ (Generic Conversion Queue)
>    * connected to the imx25 ADC.
>    */
> diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
> index 6f6c9a348158..0b6bf71af685 100644
> --- a/drivers/iio/adc/hi8435.c
> +++ b/drivers/iio/adc/hi8435.c
> @@ -1,13 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0+
>   /*
>    * Holt Integrated Circuits HI-8435 threshold detector driver
>    *
>    * Copyright (C) 2015 Zodiac Inflight Innovations
>    * Copyright (C) 2015 Cogent Embedded, Inc.
> - *
> - * This program is free software; you can redistribute  it and/or modify it
> - * under  the terms of  the GNU General  Public License as published by the
> - * Free Software Foundation;  either version 2 of the  License, or (at your
> - * option) any later version.
>    */
>   
>   #include <linux/delay.h>
> diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
> index 36b59d8957fb..894d49843854 100644
> --- a/drivers/iio/adc/hx711.c
> +++ b/drivers/iio/adc/hx711.c
> @@ -1,13 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0+
>   /*
>    * HX711: analog to digital converter for weight sensor module
>    *
>    * Copyright (c) 2016 Andreas Klinger <ak@it-klinger.de>
>    *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
>    * This program is distributed in the hope that it will be useful,
>    * but WITHOUT ANY WARRANTY; without even the implied warranty of
>    * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
> index ad6764fb2a23..2f54ea1e4292 100644
> --- a/drivers/iio/adc/imx7d_adc.c
> +++ b/drivers/iio/adc/imx7d_adc.c
> @@ -1,12 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0+
>   /*
>    * Freescale i.MX7D ADC driver
>    *
>    * Copyright (C) 2015 Freescale Semiconductor, Inc.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
>    */
>   
>   #include <linux/clk.h>
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index bdd7cba6f6b0..9bbcca9df401 100644
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -1,20 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0+
>   /*
>    * INA2XX Current and Power Monitors
>    *
>    * Copyright 2015 Baylibre SAS.
>    *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
>    * Based on linux/drivers/iio/adc/ad7291.c
>    * Copyright 2010-2011 Analog Devices Inc.
>    *
>    * Based on linux/drivers/hwmon/ina2xx.c
>    * Copyright 2012 Lothar Felten <l-felten@ti.com>
>    *
> - * Licensed under the GPL-2 or later.
> - *
>    * IIO driver for INA219-220-226-230-231
>    *
>    * Configurable 7-bit I2C slave address from 0x40 to 0x4F
> diff --git a/drivers/iio/adc/lp8788_adc.c b/drivers/iio/adc/lp8788_adc.c
> index 3bc4df916420..09dd55bff7bc 100644
> --- a/drivers/iio/adc/lp8788_adc.c
> +++ b/drivers/iio/adc/lp8788_adc.c
> @@ -1,13 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * TI LP8788 MFD - ADC driver
>    *
>    * Copyright 2012 Texas Instruments
>    *
>    * Author: Milo(Woogyom) Kim <milo.kim@ti.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
>    */
>   
>   #include <linux/delay.h>
> diff --git a/drivers/iio/adc/lpc18xx_adc.c b/drivers/iio/adc/lpc18xx_adc.c
> index 041dc4a3f66c..00d39234143d 100644
> --- a/drivers/iio/adc/lpc18xx_adc.c
> +++ b/drivers/iio/adc/lpc18xx_adc.c
> @@ -1,12 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * IIO ADC driver for NXP LPC18xx ADC
>    *
>    * Copyright (C) 2016 Joachim Eastwood <manabian@gmail.com>
>    *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
>    * UNSUPPORTED hardware features:
>    *  - Hardware triggers
>    *  - Burst mode
> diff --git a/drivers/iio/adc/lpc32xx_adc.c b/drivers/iio/adc/lpc32xx_adc.c
> index 20b36690fa4f..e361c1532a75 100644
> --- a/drivers/iio/adc/lpc32xx_adc.c
> +++ b/drivers/iio/adc/lpc32xx_adc.c
> @@ -1,23 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0+
>   /*
>    *  lpc32xx_adc.c - Support for ADC in LPC32XX
>    *
>    *  3-channel, 10-bit ADC
>    *
>    *  Copyright (C) 2011, 2012 Roland Stigge <stigge@antcom.de>
> - *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, write to the Free Software
> - *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>    */
>   
>   #include <linux/module.h>
> diff --git a/drivers/iio/adc/ltc2471.c b/drivers/iio/adc/ltc2471.c
> index b88102b751cf..9d5326377676 100644
> --- a/drivers/iio/adc/ltc2471.c
> +++ b/drivers/iio/adc/ltc2471.c
> @@ -1,11 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * Driver for Linear Technology LTC2471 and LTC2473 voltage monitors
>    * The LTC2473 is identical to the 2471, but reports a differential signal.
>    *
>    * Copyright (C) 2017 Topic Embedded Products
>    * Author: Mike Looijmans <mike.looijmans@topic.nl>
> - *
> - * License: GPLv2
>    */
>   
>   #include <linux/err.h>
> diff --git a/drivers/iio/adc/ltc2485.c b/drivers/iio/adc/ltc2485.c
> index b24c14037fd4..c0e9a7ba7af4 100644
> --- a/drivers/iio/adc/ltc2485.c
> +++ b/drivers/iio/adc/ltc2485.c
> @@ -1,12 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * ltc2485.c - Driver for Linear Technology LTC2485 ADC
>    *
>    * Copyright (C) 2016 Alison Schofield <amsfield22@gmail.com>
>    *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
>    * Datasheet: http://cds.linear.com/docs/en/datasheet/2485fd.pdf
>    */
>   
> diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
> index f1f7cdf66fbd..0fe12c0e3b3c 100644
> --- a/drivers/iio/adc/ltc2497.c
> +++ b/drivers/iio/adc/ltc2497.c
> @@ -1,10 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * ltc2497.c - Driver for Analog Devices/Linear Technology LTC2497 ADC
>    *
>    * Copyright (C) 2017 Analog Devices Inc.
>    *
> - * Licensed under the GPL-2.
> - *
>    * Datasheet: http://cds.linear.com/docs/en/datasheet/2497fd.pdf
>    */
>   
> diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> index 311c1a89c329..af83207b2804 100644
> --- a/drivers/iio/adc/max1027.c
> +++ b/drivers/iio/adc/max1027.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>    /*
>     * iio/adc/max1027.c
>     * Copyright (C) 2014 Philippe Reynes
> @@ -6,10 +7,6 @@
>     * Copyright 2011 Analog Devices Inc (from AD7923 Driver)
>     * Copyright 2012 CS Systemes d'Information
>     *
> -  * This program is free software; you can redistribute it and/or modify
> -  * it under the terms of the GNU General Public License version 2 as
> -  * published by the Free Software Foundation.
> -  *
>     * max1027.c
>     *
>     * Partial support for max1027 and similar chips.
> diff --git a/drivers/iio/adc/max1118.c b/drivers/iio/adc/max1118.c
> index 49db9e9ae625..027ee7f6f5d0 100644
> --- a/drivers/iio/adc/max1118.c
> +++ b/drivers/iio/adc/max1118.c
> @@ -1,12 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * MAX1117/MAX1118/MAX1119 8-bit, dual-channel ADCs driver
>    *
>    * Copyright (c) 2017 Akinobu Mita <akinobu.mita@gmail.com>
>    *
> - * This file is subject to the terms and conditions of version 2 of
> - * the GNU General Public License.  See the file COPYING in the main
> - * directory of this archive for more details.
> - *
>    * Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX1117-MAX1119.pdf
>    *
>    * SPI interface connections
> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index a8d35aebee80..6d191ffc4c7e 100644
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>    /*
>     * iio/adc/max1363.c
>     * Copyright (C) 2008-2010 Jonathan Cameron
> @@ -9,10 +10,6 @@
>     * Copyright (C) 2000 Russell King
>     *
>     * Driver for max1363 and similar chips.
> -  *
> -  * This program is free software; you can redistribute it and/or modify
> -  * it under the terms of the GNU General Public License version 2 as
> -  * published by the Free Software Foundation.
>     */
>   
>   #include <linux/interrupt.h>
> diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
> index a04856d8afdb..4b873afe8e5a 100644
> --- a/drivers/iio/adc/mcp320x.c
> +++ b/drivers/iio/adc/mcp320x.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * Copyright (C) 2013 Oskar Andero <oskar.andero@gmail.com>
>    * Copyright (C) 2014 Rose Technology
> @@ -34,10 +35,6 @@
>    * http://ww1.microchip.com/downloads/en/DeviceDoc/21298c.pdf  mcp3204/08
>    * http://ww1.microchip.com/downloads/en/DeviceDoc/21700E.pdf  mcp3301
>    * http://ww1.microchip.com/downloads/en/DeviceDoc/21950D.pdf  mcp3550/1/3
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
>    */
>   
>   #include <linux/err.h>
> diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
> index 819f26011500..c8232ba24667 100644
> --- a/drivers/iio/adc/mcp3422.c
> +++ b/drivers/iio/adc/mcp3422.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0+
>   /*
>    * mcp3422.c - driver for the Microchip mcp3421/2/3/4/5/6/7/8 chip family
>    *
> @@ -10,11 +11,6 @@
>    *
>    * This driver exports the value of analog input voltage to sysfs, the
>    * voltage unit is nV.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
>    */
>   
>   #include <linux/err.h>
> diff --git a/drivers/iio/adc/men_z188_adc.c b/drivers/iio/adc/men_z188_adc.c
> index c80261748d8f..0cb809bf1730 100644
> --- a/drivers/iio/adc/men_z188_adc.c
> +++ b/drivers/iio/adc/men_z188_adc.c
> @@ -1,12 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * MEN 16z188 Analog to Digial Converter
>    *
>    * Copyright (C) 2014 MEN Mikroelektronik GmbH (www.men.de)
>    * Author: Johannes Thumshirn <johannes.thumshirn@men.de>
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of the GNU General Public License as published by the Free
> - * Software Foundation; version 2 of the License.
>    */
>   
>   #include <linux/kernel.h>
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index 729becb2d3d9..f5299c9bdbde 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -1,12 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * Amlogic Meson Successive Approximation Register (SAR) A/D Converter
>    *
>    * Copyright (C) 2017 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>    *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
>    * You should have received a copy of the GNU General Public License
>    * along with this program. If not, see <http://www.gnu.org/licenses/>.
>    */
> diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
> index 95d76abb64ec..cba0e47c6013 100644
> --- a/drivers/iio/adc/mt6577_auxadc.c
> +++ b/drivers/iio/adc/mt6577_auxadc.c
> @@ -1,15 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * Copyright (c) 2016 MediaTek Inc.
>    * Author: Zhiyong Tao <zhiyong.tao@mediatek.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>    */
>   
>   #include <linux/clk.h>
> diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
> index c627513d9f0f..80983334e5c2 100644
> --- a/drivers/iio/adc/mxs-lradc-adc.c
> +++ b/drivers/iio/adc/mxs-lradc-adc.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0+
>   /*
>    * Freescale MXS LRADC ADC driver
>    *
> @@ -7,16 +8,6 @@
>    * Authors:
>    *  Marek Vasut <marex@denx.de>
>    *  Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> - * GNU General Public License for more details.
>    */
>   
>   #include <linux/completion.h>
> diff --git a/drivers/iio/adc/nau7802.c b/drivers/iio/adc/nau7802.c
> index 8997e74a8847..4e53a63e5fb9 100644
> --- a/drivers/iio/adc/nau7802.c
> +++ b/drivers/iio/adc/nau7802.c
> @@ -1,9 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0+
>   /*
>    * Driver for the Nuvoton NAU7802 ADC
>    *
>    * Copyright 2013 Free Electrons
> - *
> - * Licensed under the GPLv2 or later.
>    */
>   
>   #include <linux/delay.h>
> diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
> index 69b9affeef1e..45d1bf1253d7 100644
> --- a/drivers/iio/adc/palmas_gpadc.c
> +++ b/drivers/iio/adc/palmas_gpadc.c
> @@ -1,13 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * palmas-adc.c -- TI PALMAS GPADC.
>    *
>    * Copyright (c) 2013, NVIDIA Corporation. All rights reserved.
>    *
>    * Author: Pradeep Goudagunta <pgoudagunta@nvidia.com>
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License as
> - * published by the Free Software Foundation version 2.
>    */
>   
>   #include <linux/module.h>
> diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> index c30c002f1fef..648136ed1f85 100644
> --- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> +++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * Qualcomm PM8xxx PMIC XOADC driver
>    *
> diff --git a/drivers/iio/adc/qcom-spmi-iadc.c b/drivers/iio/adc/qcom-spmi-iadc.c
> index 3f062cd61aba..a8402a47c8e4 100644
> --- a/drivers/iio/adc/qcom-spmi-iadc.c
> +++ b/drivers/iio/adc/qcom-spmi-iadc.c
> @@ -1,14 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * Copyright (c) 2012-2014, The Linux Foundation. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 and
> - * only version 2 as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>    */
>   
>   #include <linux/bitops.h>
> diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
> index 3680e0d47412..f3e8fdee39d8 100644
> --- a/drivers/iio/adc/qcom-spmi-vadc.c
> +++ b/drivers/iio/adc/qcom-spmi-vadc.c
> @@ -1,14 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * Copyright (c) 2012-2016, The Linux Foundation. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 and
> - * only version 2 as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>    */
>   
>   #include <linux/bitops.h>
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index 1f98566d5b3c..234c6df348ce 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -1,16 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0+
>   /*
>    * Rockchip Successive Approximation Register (SAR) A/D Converter
>    * Copyright (C) 2014 ROCKCHIP, Inc.
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
>    */
>   
>   #include <linux/module.h>
> diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
> index b1da2c46107c..009019a39bba 100644
> --- a/drivers/iio/adc/spear_adc.c
> +++ b/drivers/iio/adc/spear_adc.c
> @@ -1,9 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * ST SPEAr ADC driver
>    *
>    * Copyright 2012 Stefan Roese <sr@denx.de>
> - *
> - * Licensed under the GPL-2.
>    */
>   
>   #include <linux/module.h>
> diff --git a/drivers/iio/adc/stx104.c b/drivers/iio/adc/stx104.c
> index 0662ca199eb0..f9d0aaae836f 100644
> --- a/drivers/iio/adc/stx104.c
> +++ b/drivers/iio/adc/stx104.c
> @@ -1,15 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * IIO driver for the Apex Embedded Systems STX104
>    * Copyright (C) 2016 William Breathitt Gray
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License, version 2, as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
>    */
>   #include <linux/bitops.h>
>   #include <linux/device.h>
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
> index 04d7147e0110..f13c6248a662 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -1,11 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /* ADC driver for sunxi platforms' (A10, A13 and A31) GPADC
>    *
>    * Copyright (c) 2016 Quentin Schulz <quentin.schulz@free-electrons.com>
>    *
> - * This program is free software; you can redistribute it and/or modify it under
> - * the terms of the GNU General Public License version 2 as published by the
> - * Free Software Foundation.
> - *
>    * The Allwinner SoCs all have an ADC that can also act as a touchscreen
>    * controller and a thermal sensor.
>    * The thermal sensor works only when the ADC acts as a touchscreen controller
> diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
> index 405e3779c0c5..92c7584298f6 100644
> --- a/drivers/iio/adc/ti-adc081c.c
> +++ b/drivers/iio/adc/ti-adc081c.c
> @@ -1,13 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * TI ADC081C/ADC101C/ADC121C 8/10/12-bit ADC driver
>    *
>    * Copyright (C) 2012 Avionic Design GmbH
>    * Copyright (C) 2016 Intel
>    *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
>    * Datasheets:
>    *	http://www.ti.com/lit/ds/symlink/adc081c021.pdf
>    *	http://www.ti.com/lit/ds/symlink/adc101c021.pdf
> diff --git a/drivers/iio/adc/ti-adc0832.c b/drivers/iio/adc/ti-adc0832.c
> index 188dae705bf7..482a00dc9273 100644
> --- a/drivers/iio/adc/ti-adc0832.c
> +++ b/drivers/iio/adc/ti-adc0832.c
> @@ -1,12 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * ADC0831/ADC0832/ADC0834/ADC0838 8-bit ADC driver
>    *
>    * Copyright (c) 2016 Akinobu Mita <akinobu.mita@gmail.com>
>    *
> - * This file is subject to the terms and conditions of version 2 of
> - * the GNU General Public License.  See the file COPYING in the main
> - * directory of this archive for more details.
> - *
>    * Datasheet: http://www.ti.com/lit/ds/symlink/adc0832-n.pdf
>    */
>   
> diff --git a/drivers/iio/adc/ti-adc084s021.c b/drivers/iio/adc/ti-adc084s021.c
> index 25504640e126..914d097c8758 100644
> --- a/drivers/iio/adc/ti-adc084s021.c
> +++ b/drivers/iio/adc/ti-adc084s021.c
> @@ -1,13 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /**
>    * Copyright (C) 2017 Axis Communications AB
>    *
>    * Driver for Texas Instruments' ADC084S021 ADC chip.
>    * Datasheets can be found here:
>    * http://www.ti.com/lit/ds/symlink/adc084s021.pdf
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
>    */
>   
>   #include <linux/err.h>
> diff --git a/drivers/iio/adc/ti-adc108s102.c b/drivers/iio/adc/ti-adc108s102.c
> index 841203edaac5..a1c16199e7cc 100644
> --- a/drivers/iio/adc/ti-adc108s102.c
> +++ b/drivers/iio/adc/ti-adc108s102.c
> @@ -1,18 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * TI ADC108S102 SPI ADC driver
>    *
>    * Copyright (c) 2013-2015 Intel Corporation.
>    * Copyright (c) 2017 Siemens AG
>    *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU General Public License,
> - * version 2, as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope it will be useful, but WITHOUT
> - * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> - * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> - * more details.
> - *
>    * This IIO device driver is designed to work with the following
>    * analog to digital converters from Texas Instruments:
>    *  ADC108S102
> diff --git a/drivers/iio/adc/ti-adc12138.c b/drivers/iio/adc/ti-adc12138.c
> index 703d68ae96b7..9445b79ad7b8 100644
> --- a/drivers/iio/adc/ti-adc12138.c
> +++ b/drivers/iio/adc/ti-adc12138.c
> @@ -1,12 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * ADC12130/ADC12132/ADC12138 12-bit plus sign ADC driver
>    *
>    * Copyright (c) 2016 Akinobu Mita <akinobu.mita@gmail.com>
>    *
> - * This file is subject to the terms and conditions of version 2 of
> - * the GNU General Public License.  See the file COPYING in the main
> - * directory of this archive for more details.
> - *
>    * Datasheet: http://www.ti.com/lit/ds/symlink/adc12138.pdf
>    */
>   
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 6a114dcb4a3a..cddb41a3919c 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -1,12 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * ADS1015 - Texas Instruments Analog-to-Digital Converter
>    *
>    * Copyright (c) 2016, Intel Corporation.
>    *
> - * This file is subject to the terms and conditions of version 2 of
> - * the GNU General Public License.  See the file COPYING in the main
> - * directory of this archive for more details.
> - *
>    * IIO driver for ADS1015 ADC 7-bit I2C slave address:
>    *	* 0x48 - ADDR connected to Ground
>    *	* 0x49 - ADDR connected to Vdd
> diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
> index 184d686ebd99..83d99a79f79e 100644
> --- a/drivers/iio/adc/ti-ads8688.c
> +++ b/drivers/iio/adc/ti-ads8688.c
> @@ -1,9 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * Copyright (C) 2015 Prevas A/S
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
>    */
>   
>   #include <linux/device.h>
> diff --git a/drivers/iio/adc/ti-tlc4541.c b/drivers/iio/adc/ti-tlc4541.c
> index 2290024c89fc..945d547302c6 100644
> --- a/drivers/iio/adc/ti-tlc4541.c
> +++ b/drivers/iio/adc/ti-tlc4541.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * TI tlc4541 ADC Driver
>    *
> @@ -7,10 +8,6 @@
>    * http://www.ti.com/lit/gpn/tlc3541
>    * http://www.ti.com/lit/gpn/tlc4541
>    *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
>    * The tlc4541 requires 24 clock cycles to start a transfer.
>    * Conversion then takes 2.94us to complete before data is ready
>    * Data is returned MSB first.
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index cafb1dcadc48..aac5a1959b78 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -1,16 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * TI ADC MFD driver
>    *
>    * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License as
> - * published by the Free Software Foundation version 2.
> - *
> - * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> - * kind, whether express or implied; without even the implied warranty
> - * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
>    */
>   
>   #include <linux/kernel.h>
> diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
> index 8c019bb6625f..d3ea08f8d33d 100644
> --- a/drivers/iio/adc/twl4030-madc.c
> +++ b/drivers/iio/adc/twl4030-madc.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    *
>    * TWL4030 MADC module driver-This driver monitors the real time
> @@ -12,21 +13,6 @@
>    * Mikko Ylinen <mikko.k.ylinen@nokia.com>
>    *
>    * Amit Kucheria <amit.kucheria@canonical.com>
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * version 2 as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> - * 02110-1301 USA
> - *
>    */
>   
>   #include <linux/device.h>
> diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
> index e470510e76ea..201027839c1e 100644
> --- a/drivers/iio/adc/twl6030-gpadc.c
> +++ b/drivers/iio/adc/twl6030-gpadc.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * TWL6030 GPADC module driver
>    *
> @@ -12,21 +13,6 @@
>    * Based on twl4030-madc.c
>    * Copyright (C) 2008 Nokia Corporation
>    * Mikko Ylinen <mikko.k.ylinen@nokia.com>
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * version 2 as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> - * 02110-1301 USA
> - *
>    */
>   #include <linux/interrupt.h>
>   #include <linux/kernel.h>
> diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
> index bbcb7a4d7edf..a9d13b8b9a68 100644
> --- a/drivers/iio/adc/vf610_adc.c
> +++ b/drivers/iio/adc/vf610_adc.c
> @@ -1,21 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0+
>   /*
>    * Freescale Vybrid vf610 ADC driver
>    *
>    * Copyright 2013 Freescale Semiconductor, Inc.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> - * GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, write to the Free Software
> - *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>    */
>   
>   #include <linux/module.h>
> diff --git a/drivers/iio/adc/viperboard_adc.c b/drivers/iio/adc/viperboard_adc.c
> index 53eb5a4136fe..5b64a5ea488f 100644
> --- a/drivers/iio/adc/viperboard_adc.c
> +++ b/drivers/iio/adc/viperboard_adc.c
> @@ -1,15 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0+
>   /*
>    *  Nano River Technologies viperboard IIO ADC driver
>    *
>    *  (C) 2012 by Lemonage GmbH
>    *  Author: Lars Poeschel <poeschel@lemonage.de>
>    *  All rights reserved.
> - *
> - *  This program is free software; you can redistribute  it and/or modify it
> - *  under  the terms of  the GNU General  Public License as published by the
> - *  Free Software Foundation;  either version 2 of the	License, or (at your
> - *  option) any later version.
> - *
>    */
>   
>   #include <linux/kernel.h>
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index 3f6be5ac049a..b7b5adf6c9fc 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -1,11 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * Xilinx XADC driver
>    *
>    * Copyright 2013-2014 Analog Devices Inc.
>    *  Author: Lars-Peter Clauen <lars@metafoo.de>
>    *
> - * Licensed under the GPL-2.
> - *
>    * Documentation for the parts can be found at:
>    *  - XADC hardmacro: Xilinx UG480
>    *  - ZYNQ XADC interface: Xilinx UG585
> diff --git a/drivers/iio/adc/xilinx-xadc-events.c b/drivers/iio/adc/xilinx-xadc-events.c
> index dc0670308253..0c81ad4f0a05 100644
> --- a/drivers/iio/adc/xilinx-xadc-events.c
> +++ b/drivers/iio/adc/xilinx-xadc-events.c
> @@ -1,10 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * Xilinx XADC driver
>    *
>    * Copyright 2013 Analog Devices Inc.
>    *  Author: Lars-Peter Clauen <lars@metafoo.de>
> - *
> - * Licensed under the GPL-2.
>    */
>   
>   #include <linux/iio/events.h>
> diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
> index 8c0009585c16..5b9042e7441d 100644
> --- a/drivers/iio/adc/xilinx-xadc.h
> +++ b/drivers/iio/adc/xilinx-xadc.h
> @@ -1,10 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>   /*
>    * Xilinx XADC driver
>    *
>    * Copyright 2013 Analog Devices Inc.
>    *  Author: Lars-Peter Clauen <lars@metafoo.de>
> - *
> - * Licensed under the GPL-2.
>    */
>   
>   #ifndef __IIO_XILINX_XADC__

--------------3A64579E9D7745788356ECEC
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2018-11-28 9:53 a.m., Matheus
      Tavares wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20181128175312.9634-1-matheus.bernardino@usp.br">
      <pre class="moz-quote-pre" wrap="">From: Lucas Santos <a class="moz-txt-link-rfc2396E" href="mailto:ilucas.ms@gmail.com">&lt;ilucas.ms@gmail.com&gt;</a>

This patch removes all license boilerplate texts from the .c and .h</pre>
    </blockquote>
    <p><a class="external-link"
href="https://www.kernel.org/doc/html/latest/process/submitting-patches.html"
        rel="nofollow" style="color: rgb(50, 108, 166); text-decoration:
        none; font-family: Arial, sans-serif; font-size: 14px;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        normal; orphans: 2; text-align: start; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(255, 255, 255);"><span style="color:
          rgb(51, 51, 51); font-family: Arial, sans-serif; font-size:
          14px; font-style: normal; font-variant-ligatures: normal;
          font-variant-caps: normal; font-weight: 400; letter-spacing:
          normal; orphans: 2; text-align: start; text-indent: 0px;
          text-transform: none; white-space: normal; widows: 2;
          word-spacing: 0px; -webkit-text-stroke-width: 0px;
          background-color: rgb(255, 255, 255); text-decoration-style:
          initial; text-decoration-color: initial; display: inline
          !important; float: none;">I know other people don't follow the
          patch guidelines,<br>
        </span></a></p>
    <p><a class="external-link"
href="https://www.kernel.org/doc/html/latest/process/submitting-patches.html"
        rel="nofollow" style="color: rgb(50, 108, 166); text-decoration:
        none; font-family: Arial, sans-serif; font-size: 14px;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        normal; orphans: 2; text-align: start; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(255, 255, 255);"><span style="color:
          rgb(51, 51, 51); font-family: Arial, sans-serif; font-size:
          14px; font-style: normal; font-variant-ligatures: normal;
          font-variant-caps: normal; font-weight: 400; letter-spacing:
          normal; orphans: 2; text-align: start; text-indent: 0px;
          text-transform: none; white-space: normal; widows: 2;
          word-spacing: 0px; -webkit-text-stroke-width: 0px;
          background-color: rgb(255, 255, 255); text-decoration-style:
          initial; text-decoration-color: initial; display: inline
          !important; float: none;">but more info on proper commit
          message format in link.</span></a></p>
    <p><a class="external-link"
href="https://www.kernel.org/doc/html/latest/process/submitting-patches.html"
        rel="nofollow" style="color: rgb(50, 108, 166); text-decoration:
        none; font-family: Arial, sans-serif; font-size: 14px;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        normal; orphans: 2; text-align: start; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(255, 255, 255);"><span style="color:
          rgb(51, 51, 51); font-family: Arial, sans-serif; font-size:
          14px; font-style: normal; font-variant-ligatures: normal;
          font-variant-caps: normal; font-weight: 400; letter-spacing:
          normal; orphans: 2; text-align: start; text-indent: 0px;
          text-transform: none; white-space: normal; widows: 2;
          word-spacing: 0px; -webkit-text-stroke-width: 0px;
          background-color: rgb(255, 255, 255); text-decoration-style:
          initial; text-decoration-color: initial; display: inline
          !important; float: none;">(Don't say "this patch" or "this
          commit" or "I changed") - use imperative present tense.</span></a></p>
    <p><a class="external-link"
href="https://www.kernel.org/doc/html/latest/process/submitting-patches.html"
        rel="nofollow" style="color: rgb(50, 108, 166); text-decoration:
        none; font-family: Arial, sans-serif; font-size: 14px;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        normal; orphans: 2; text-align: start; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(255, 255, 255);"><span style="color:
          rgb(51, 51, 51); font-family: Arial, sans-serif; font-size:
          14px; font-style: normal; font-variant-ligatures: normal;
          font-variant-caps: normal; font-weight: 400; letter-spacing:
          normal; orphans: 2; text-align: start; text-indent: 0px;
          text-transform: none; white-space: normal; widows: 2;
          word-spacing: 0px; -webkit-text-stroke-width: 0px;
          background-color: rgb(255, 255, 255); text-decoration-style:
          initial; text-decoration-color: initial; display: inline
          !important; float: none;"></span>https://www.kernel.org/doc/html/latest/process/submitting-patches.html</a></p>
    <blockquote type="cite"
      cite="mid:20181128175312.9634-1-matheus.bernardino@usp.br">
      <pre class="moz-quote-pre" wrap="">
files at drivers/iio/adc/ and, instead, adds the proper SPDX license
identifiers.

Signed-off-by: Lucas Santos <a class="moz-txt-link-rfc2396E" href="mailto:ilucas.ms@gmail.com">&lt;ilucas.ms@gmail.com&gt;</a>
Signed-off-by: Matheus Tavares <a class="moz-txt-link-rfc2396E" href="mailto:matheus.bernardino@usp.br">&lt;matheus.bernardino@usp.br&gt;</a>
---
 drivers/iio/adc/ad7266.c             |  3 +--
 drivers/iio/adc/ad7291.c             |  3 +--
 drivers/iio/adc/ad7298.c             |  3 +--
 drivers/iio/adc/ad7766.c             |  3 +--
 drivers/iio/adc/ad7791.c             |  3 +--
 drivers/iio/adc/ad7793.c             |  3 +--
 drivers/iio/adc/ad7887.c             |  3 +--
 drivers/iio/adc/ad7923.c             |  3 +--
 drivers/iio/adc/ad799x.c             |  5 +----
 drivers/iio/adc/ad_sigma_delta.c     |  3 +--
 drivers/iio/adc/aspeed_adc.c         |  6 +-----
 drivers/iio/adc/at91-sama5d2_adc.c   | 10 +---------
 drivers/iio/adc/at91_adc.c           |  3 +--
 drivers/iio/adc/axp20x_adc.c         |  5 +----
 drivers/iio/adc/axp288_adc.c         | 13 +------------
 drivers/iio/adc/bcm_iproc_adc.c      | 13 +------------</pre>
    </blockquote>
    <p>Broadcom change:</p>
    <p>Acked-by: Scott Branden <a class="moz-txt-link-rfc2396E" href="mailto:scott.branden@broadcom.com">&lt;scott.branden@broadcom.com&gt;</a><br>
    </p>
    <blockquote type="cite"
      cite="mid:20181128175312.9634-1-matheus.bernardino@usp.br">
      <pre class="moz-quote-pre" wrap="">
 drivers/iio/adc/berlin2-adc.c        |  5 +----
 drivers/iio/adc/cc10001_adc.c        |  6 +-----
 drivers/iio/adc/cpcap-adc.c          | 10 +---------
 drivers/iio/adc/da9150-gpadc.c       |  6 +-----
 drivers/iio/adc/dln2-adc.c           |  5 +----
 drivers/iio/adc/ep93xx_adc.c         |  5 +----
 drivers/iio/adc/exynos_adc.c         | 11 +----------
 drivers/iio/adc/fsl-imx25-gcq.c      |  5 +----
 drivers/iio/adc/hi8435.c             |  6 +-----
 drivers/iio/adc/hx711.c              |  6 +-----
 drivers/iio/adc/imx7d_adc.c          |  6 +-----
 drivers/iio/adc/ina2xx-adc.c         |  7 +------
 drivers/iio/adc/lp8788_adc.c         |  5 +----
 drivers/iio/adc/lpc18xx_adc.c        |  5 +----
 drivers/iio/adc/lpc32xx_adc.c        | 15 +--------------
 drivers/iio/adc/ltc2471.c            |  3 +--
 drivers/iio/adc/ltc2485.c            |  5 +----
 drivers/iio/adc/ltc2497.c            |  3 +--
 drivers/iio/adc/max1027.c            |  5 +----
 drivers/iio/adc/max1118.c            |  5 +----
 drivers/iio/adc/max1363.c            |  5 +----
 drivers/iio/adc/mcp320x.c            |  5 +----
 drivers/iio/adc/mcp3422.c            |  6 +-----
 drivers/iio/adc/men_z188_adc.c       |  5 +----
 drivers/iio/adc/meson_saradc.c       |  5 +----
 drivers/iio/adc/mt6577_auxadc.c      | 10 +---------
 drivers/iio/adc/mxs-lradc-adc.c      | 11 +----------
 drivers/iio/adc/nau7802.c            |  3 +--
 drivers/iio/adc/palmas_gpadc.c       |  5 +----
 drivers/iio/adc/qcom-pm8xxx-xoadc.c  |  1 +
 drivers/iio/adc/qcom-spmi-iadc.c     | 10 +---------
 drivers/iio/adc/qcom-spmi-vadc.c     | 10 +---------
 drivers/iio/adc/rockchip_saradc.c    | 11 +----------
 drivers/iio/adc/spear_adc.c          |  3 +--
 drivers/iio/adc/stx104.c             | 10 +---------
 drivers/iio/adc/sun4i-gpadc-iio.c    |  5 +----
 drivers/iio/adc/ti-adc081c.c         |  5 +----
 drivers/iio/adc/ti-adc0832.c         |  5 +----
 drivers/iio/adc/ti-adc084s021.c      |  5 +----
 drivers/iio/adc/ti-adc108s102.c      | 10 +---------
 drivers/iio/adc/ti-adc12138.c        |  5 +----
 drivers/iio/adc/ti-ads1015.c         |  5 +----
 drivers/iio/adc/ti-ads8688.c         |  5 +----
 drivers/iio/adc/ti-tlc4541.c         |  5 +----
 drivers/iio/adc/ti_am335x_adc.c      | 10 +---------
 drivers/iio/adc/twl4030-madc.c       | 16 +---------------
 drivers/iio/adc/twl6030-gpadc.c      | 16 +---------------
 drivers/iio/adc/vf610_adc.c          | 15 +--------------
 drivers/iio/adc/viperboard_adc.c     |  7 +------
 drivers/iio/adc/xilinx-xadc-core.c   |  3 +--
 drivers/iio/adc/xilinx-xadc-events.c |  3 +--
 drivers/iio/adc/xilinx-xadc.h        |  3 +--
 68 files changed, 68 insertions(+), 361 deletions(-)

diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index 605eb5e7e829..b538824e76cd 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * AD7266/65 SPI ADC driver
  *
  * Copyright 2012 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
  */
 
 #include &lt;linux/device.h&gt;
diff --git a/drivers/iio/adc/ad7291.c b/drivers/iio/adc/ad7291.c
index a862b5d8fb4b..7bc9f2e8cd3c 100644
--- a/drivers/iio/adc/ad7291.c
+++ b/drivers/iio/adc/ad7291.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * AD7291 8-Channel, I2C, 12-Bit SAR ADC with Temperature Sensor
  *
  * Copyright 2010-2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2 or later.
  */
 
 #include &lt;linux/device.h&gt;
diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
index e0220825fde0..e7ba5e29d0d6 100644
--- a/drivers/iio/adc/ad7298.c
+++ b/drivers/iio/adc/ad7298.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * AD7298 SPI ADC driver
  *
  * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
  */
 
 #include &lt;linux/device.h&gt;
diff --git a/drivers/iio/adc/ad7766.c b/drivers/iio/adc/ad7766.c
index 3ae14fc8c649..ff14959f55de 100644
--- a/drivers/iio/adc/ad7766.c
+++ b/drivers/iio/adc/ad7766.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * AD7766/AD7767 SPI ADC driver
  *
  * Copyright 2016 Analog Devices Inc.
- *
- * Licensed under the GPL-2 or later.
  */
 
 #include &lt;linux/clk.h&gt;
diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
index a9ff0695ddf7..1b9ab2ef9bae 100644
--- a/drivers/iio/adc/ad7791.c
+++ b/drivers/iio/adc/ad7791.c
@@ -1,10 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * AD7787/AD7788/AD7789/AD7790/AD7791 SPI ADC driver
  *
  * Copyright 2012 Analog Devices Inc.
  *  Author: Lars-Peter Clausen <a class="moz-txt-link-rfc2396E" href="mailto:lars@metafoo.de">&lt;lars@metafoo.de&gt;</a>
- *
- * Licensed under the GPL-2.
  */
 
 #include &lt;linux/interrupt.h&gt;
diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index 4ac3ae62f56f..886263a3d2b1 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * AD7785/AD7792/AD7793/AD7794/AD7795 SPI ADC driver
  *
  * Copyright 2011-2012 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
  */
 
 #include &lt;linux/interrupt.h&gt;
diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
index 9d4c2467d362..7c17b53dea2e 100644
--- a/drivers/iio/adc/ad7887.c
+++ b/drivers/iio/adc/ad7887.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * AD7887 SPI ADC driver
  *
  * Copyright 2010-2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
  */
 
 #include &lt;linux/device.h&gt;
diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index d62dbb62be45..cad67ee9bb38 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -1,10 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * AD7904/AD7914/AD7923/AD7924 SPI ADC driver
  *
  * Copyright 2011 Analog Devices Inc (from AD7923 Driver)
  * Copyright 2012 CS Systemes d'Information
- *
- * Licensed under the GPL-2.
  */
 
 #include &lt;linux/device.h&gt;
diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 7a5b5d00a87d..65d60fc173aa 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * iio/adc/ad799x.c
  * Copyright (C) 2010-2011 Michael Hennerich, Analog Devices Inc.
@@ -11,10 +12,6 @@
  * based on linux/drivers/acron/char/pcf8583.c
  * Copyright (C) 2000 Russell King
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * ad799x.c
  *
  * Support for ad7991, ad7995, ad7999, ad7992, ad7993, ad7994, ad7997,
diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index ff5f2da2e1b1..cd0c3cda132a 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -1,10 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Support code for Analog Devices Sigma-Delta ADCs
  *
  * Copyright 2012 Analog Devices Inc.
  *  Author: Lars-Peter Clausen <a class="moz-txt-link-rfc2396E" href="mailto:lars@metafoo.de">&lt;lars@metafoo.de&gt;</a>
- *
- * Licensed under the GPL-2.
  */
 
 #include &lt;linux/interrupt.h&gt;
diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 9515ca165dfd..5eec9d2a3eb1 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -1,12 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Aspeed AST2400/2500 ADC
  *
  * Copyright (C) 2017 Google, Inc.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
  */
 
 #include &lt;linux/clk.h&gt;
diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index d5ea84cf6460..62ceca3fe3bf 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Atmel ADC driver for SAMA5D2 devices and compatible.
  *
  * Copyright (C) 2015 Atmel,
  *               2015 Ludovic Desroches <a class="moz-txt-link-rfc2396E" href="mailto:ludovic.desroches@atmel.com">&lt;ludovic.desroches@atmel.com&gt;</a>
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
  */
 
 #include &lt;linux/bitops.h&gt;
diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 75d2f73582a3..21b07413a998 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Driver for the ADC present in the Atmel AT91 evaluation boards.
  *
  * Copyright 2011 Free Electrons
- *
- * Licensed under the GPLv2 or later.
  */
 
 #include &lt;linux/bitmap.h&gt;
diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
index 5be789269353..42eefe2593ec 100644
--- a/drivers/iio/adc/axp20x_adc.c
+++ b/drivers/iio/adc/axp20x_adc.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /* ADC driver for AXP20X and AXP22X PMICs
  *
  * Copyright (c) 2016 Free Electrons NextThing Co.
  *	Quentin Schulz <a class="moz-txt-link-rfc2396E" href="mailto:quentin.schulz@free-electrons.com">&lt;quentin.schulz@free-electrons.com&gt;</a>
- *
- * This program is free software; you can redistribute it and/or modify it under
- * the terms of the GNU General Public License version 2 as published by the
- * Free Software Foundation.
  */
 
 #include &lt;linux/completion.h&gt;
diff --git a/drivers/iio/adc/axp288_adc.c b/drivers/iio/adc/axp288_adc.c
index 031d568b4972..24c0ec2cfd67 100644
--- a/drivers/iio/adc/axp288_adc.c
+++ b/drivers/iio/adc/axp288_adc.c
@@ -1,19 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * axp288_adc.c - X-Powers AXP288 PMIC ADC Driver
  *
  * Copyright (C) 2014 Intel Corporation
- *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the GNU
- * General Public License for more details.
- *
  */
 
 #include &lt;linux/module.h&gt;
diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index 7af59a4bbd8d..2eadef68bd49 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -1,17 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright 2016 Broadcom
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License, version 2, as
- * published by the Free Software Foundation (the "GPL").
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License version 2 (GPLv2) for more details.
- *
- * You should have received a copy of the GNU General Public License
- * version 2 (GPLv2) along with this source code.
  */
 
 #include &lt;linux/module.h&gt;
diff --git a/drivers/iio/adc/berlin2-adc.c b/drivers/iio/adc/berlin2-adc.c
index 72d8fa94ab31..3b0ca5f326ed 100644
--- a/drivers/iio/adc/berlin2-adc.c
+++ b/drivers/iio/adc/berlin2-adc.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Marvell Berlin2 ADC driver
  *
  * Copyright (C) 2015 Marvell Technology Group Ltd.
  *
  * Antoine Tenart <a class="moz-txt-link-rfc2396E" href="mailto:antoine.tenart@free-electrons.com">&lt;antoine.tenart@free-electrons.com&gt;</a>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include &lt;linux/iio/iio.h&gt;
diff --git a/drivers/iio/adc/cc10001_adc.c b/drivers/iio/adc/cc10001_adc.c
index 707d8b24b072..8b72037e04b2 100644
--- a/drivers/iio/adc/cc10001_adc.c
+++ b/drivers/iio/adc/cc10001_adc.c
@@ -1,10 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2014-2015 Imagination Technologies Ltd.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
  */
 
 #include &lt;linux/clk.h&gt;
diff --git a/drivers/iio/adc/cpcap-adc.c b/drivers/iio/adc/cpcap-adc.c
index 9ad60421d360..c1bfa4543125 100644
--- a/drivers/iio/adc/cpcap-adc.c
+++ b/drivers/iio/adc/cpcap-adc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2017 Tony Lindgren <a class="moz-txt-link-rfc2396E" href="mailto:tony@atomide.com">&lt;tony@atomide.com&gt;</a>
  *
@@ -5,15 +6,6 @@
  * earlier driver found in the Motorola Linux kernel:
  *
  * Copyright (C) 2009-2010 Motorola, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
  */
 
 #include &lt;linux/delay.h&gt;
diff --git a/drivers/iio/adc/da9150-gpadc.c b/drivers/iio/adc/da9150-gpadc.c
index 0a5d9ce79164..620274890645 100644
--- a/drivers/iio/adc/da9150-gpadc.c
+++ b/drivers/iio/adc/da9150-gpadc.c
@@ -1,14 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * DA9150 GPADC Driver
  *
  * Copyright (c) 2014 Dialog Semiconductor
  *
  * Author: Adam Thomson <a class="moz-txt-link-rfc2396E" href="mailto:Adam.Thomson.Opensource@diasemi.com">&lt;Adam.Thomson.Opensource@diasemi.com&gt;</a>
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
  */
 
 #include &lt;linux/kernel.h&gt;
diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
index c64c6675cae6..03f0f8fc6350 100644
--- a/drivers/iio/adc/dln2-adc.c
+++ b/drivers/iio/adc/dln2-adc.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Driver for the Diolan DLN-2 USB-ADC adapter
  *
  * Copyright (c) 2017 Jack Andersen
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation, version 2.
  */
 
 #include &lt;linux/kernel.h&gt;
diff --git a/drivers/iio/adc/ep93xx_adc.c b/drivers/iio/adc/ep93xx_adc.c
index 5036c392cb20..8f614c84b643 100644
--- a/drivers/iio/adc/ep93xx_adc.c
+++ b/drivers/iio/adc/ep93xx_adc.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Driver for ADC module on the Cirrus Logic EP93xx series of SoCs
  *
  * Copyright (C) 2015 Alexander Sverdlin
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * The driver uses polling to get the conversion status. According to EP93xx
  * datasheets, reading ADCResult register starts the conversion, but user is also
  * responsible for ensuring that delay between adjacent conversion triggers is
diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index f10443f92e4c..9f9c186e2135 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  exynos_adc.c - Support for ADC in EXYNOS SoCs
  *
@@ -5,16 +6,6 @@
  *
  *  Copyright (C) 2013 Naveen Krishna Chatradhi <a class="moz-txt-link-rfc2396E" href="mailto:ch.naveen@samsung.com">&lt;ch.naveen@samsung.com&gt;</a>
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
  *  You should have received a copy of the GNU General Public License
  *  along with this program; if not, write to the Free Software
  *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
index 929c617db364..e03a434b3cd5 100644
--- a/drivers/iio/adc/fsl-imx25-gcq.c
+++ b/drivers/iio/adc/fsl-imx25-gcq.c
@@ -1,10 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2014-2015 Pengutronix, Markus Pargmann <a class="moz-txt-link-rfc2396E" href="mailto:mpa@pengutronix.de">&lt;mpa@pengutronix.de&gt;</a>
  *
- * This program is free software; you can redistribute it and/or modify it under
- * the terms of the GNU General Public License version 2 as published by the
- * Free Software Foundation.
- *
  * This is the driver for the imx25 GCQ (Generic Conversion Queue)
  * connected to the imx25 ADC.
  */
diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
index 6f6c9a348158..0b6bf71af685 100644
--- a/drivers/iio/adc/hi8435.c
+++ b/drivers/iio/adc/hi8435.c
@@ -1,13 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Holt Integrated Circuits HI-8435 threshold detector driver
  *
  * Copyright (C) 2015 Zodiac Inflight Innovations
  * Copyright (C) 2015 Cogent Embedded, Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
  */
 
 #include &lt;linux/delay.h&gt;
diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 36b59d8957fb..894d49843854 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -1,13 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * HX711: analog to digital converter for weight sensor module
  *
  * Copyright (c) 2016 Andreas Klinger <a class="moz-txt-link-rfc2396E" href="mailto:ak@it-klinger.de">&lt;ak@it-klinger.de&gt;</a>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
index ad6764fb2a23..2f54ea1e4292 100644
--- a/drivers/iio/adc/imx7d_adc.c
+++ b/drivers/iio/adc/imx7d_adc.c
@@ -1,12 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Freescale i.MX7D ADC driver
  *
  * Copyright (C) 2015 Freescale Semiconductor, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
  */
 
 #include &lt;linux/clk.h&gt;
diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index bdd7cba6f6b0..9bbcca9df401 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -1,20 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * INA2XX Current and Power Monitors
  *
  * Copyright 2015 Baylibre SAS.
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * Based on linux/drivers/iio/adc/ad7291.c
  * Copyright 2010-2011 Analog Devices Inc.
  *
  * Based on linux/drivers/hwmon/ina2xx.c
  * Copyright 2012 Lothar Felten <a class="moz-txt-link-rfc2396E" href="mailto:l-felten@ti.com">&lt;l-felten@ti.com&gt;</a>
  *
- * Licensed under the GPL-2 or later.
- *
  * IIO driver for INA219-220-226-230-231
  *
  * Configurable 7-bit I2C slave address from 0x40 to 0x4F
diff --git a/drivers/iio/adc/lp8788_adc.c b/drivers/iio/adc/lp8788_adc.c
index 3bc4df916420..09dd55bff7bc 100644
--- a/drivers/iio/adc/lp8788_adc.c
+++ b/drivers/iio/adc/lp8788_adc.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * TI LP8788 MFD - ADC driver
  *
  * Copyright 2012 Texas Instruments
  *
  * Author: Milo(Woogyom) Kim <a class="moz-txt-link-rfc2396E" href="mailto:milo.kim@ti.com">&lt;milo.kim@ti.com&gt;</a>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include &lt;linux/delay.h&gt;
diff --git a/drivers/iio/adc/lpc18xx_adc.c b/drivers/iio/adc/lpc18xx_adc.c
index 041dc4a3f66c..00d39234143d 100644
--- a/drivers/iio/adc/lpc18xx_adc.c
+++ b/drivers/iio/adc/lpc18xx_adc.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * IIO ADC driver for NXP LPC18xx ADC
  *
  * Copyright (C) 2016 Joachim Eastwood <a class="moz-txt-link-rfc2396E" href="mailto:manabian@gmail.com">&lt;manabian@gmail.com&gt;</a>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * UNSUPPORTED hardware features:
  *  - Hardware triggers
  *  - Burst mode
diff --git a/drivers/iio/adc/lpc32xx_adc.c b/drivers/iio/adc/lpc32xx_adc.c
index 20b36690fa4f..e361c1532a75 100644
--- a/drivers/iio/adc/lpc32xx_adc.c
+++ b/drivers/iio/adc/lpc32xx_adc.c
@@ -1,23 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  lpc32xx_adc.c - Support for ADC in LPC32XX
  *
  *  3-channel, 10-bit ADC
  *
  *  Copyright (C) 2011, 2012 Roland Stigge <a class="moz-txt-link-rfc2396E" href="mailto:stigge@antcom.de">&lt;stigge@antcom.de&gt;</a>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
 #include &lt;linux/module.h&gt;
diff --git a/drivers/iio/adc/ltc2471.c b/drivers/iio/adc/ltc2471.c
index b88102b751cf..9d5326377676 100644
--- a/drivers/iio/adc/ltc2471.c
+++ b/drivers/iio/adc/ltc2471.c
@@ -1,11 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Driver for Linear Technology LTC2471 and LTC2473 voltage monitors
  * The LTC2473 is identical to the 2471, but reports a differential signal.
  *
  * Copyright (C) 2017 Topic Embedded Products
  * Author: Mike Looijmans <a class="moz-txt-link-rfc2396E" href="mailto:mike.looijmans@topic.nl">&lt;mike.looijmans@topic.nl&gt;</a>
- *
- * License: GPLv2
  */
 
 #include &lt;linux/err.h&gt;
diff --git a/drivers/iio/adc/ltc2485.c b/drivers/iio/adc/ltc2485.c
index b24c14037fd4..c0e9a7ba7af4 100644
--- a/drivers/iio/adc/ltc2485.c
+++ b/drivers/iio/adc/ltc2485.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * ltc2485.c - Driver for Linear Technology LTC2485 ADC
  *
  * Copyright (C) 2016 Alison Schofield <a class="moz-txt-link-rfc2396E" href="mailto:amsfield22@gmail.com">&lt;amsfield22@gmail.com&gt;</a>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * Datasheet: <a class="moz-txt-link-freetext" href="http://cds.linear.com/docs/en/datasheet/2485fd.pdf">http://cds.linear.com/docs/en/datasheet/2485fd.pdf</a>
  */
 
diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
index f1f7cdf66fbd..0fe12c0e3b3c 100644
--- a/drivers/iio/adc/ltc2497.c
+++ b/drivers/iio/adc/ltc2497.c
@@ -1,10 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * ltc2497.c - Driver for Analog Devices/Linear Technology LTC2497 ADC
  *
  * Copyright (C) 2017 Analog Devices Inc.
  *
- * Licensed under the GPL-2.
- *
  * Datasheet: <a class="moz-txt-link-freetext" href="http://cds.linear.com/docs/en/datasheet/2497fd.pdf">http://cds.linear.com/docs/en/datasheet/2497fd.pdf</a>
  */
 
diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index 311c1a89c329..af83207b2804 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
  /*
   * iio/adc/max1027.c
   * Copyright (C) 2014 Philippe Reynes
@@ -6,10 +7,6 @@
   * Copyright 2011 Analog Devices Inc (from AD7923 Driver)
   * Copyright 2012 CS Systemes d'Information
   *
-  * This program is free software; you can redistribute it and/or modify
-  * it under the terms of the GNU General Public License version 2 as
-  * published by the Free Software Foundation.
-  *
   * max1027.c
   *
   * Partial support for max1027 and similar chips.
diff --git a/drivers/iio/adc/max1118.c b/drivers/iio/adc/max1118.c
index 49db9e9ae625..027ee7f6f5d0 100644
--- a/drivers/iio/adc/max1118.c
+++ b/drivers/iio/adc/max1118.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * MAX1117/MAX1118/MAX1119 8-bit, dual-channel ADCs driver
  *
  * Copyright (c) 2017 Akinobu Mita <a class="moz-txt-link-rfc2396E" href="mailto:akinobu.mita@gmail.com">&lt;akinobu.mita@gmail.com&gt;</a>
  *
- * This file is subject to the terms and conditions of version 2 of
- * the GNU General Public License.  See the file COPYING in the main
- * directory of this archive for more details.
- *
  * Datasheet: <a class="moz-txt-link-freetext" href="https://datasheets.maximintegrated.com/en/ds/MAX1117-MAX1119.pdf">https://datasheets.maximintegrated.com/en/ds/MAX1117-MAX1119.pdf</a>
  *
  * SPI interface connections
diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index a8d35aebee80..6d191ffc4c7e 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
  /*
   * iio/adc/max1363.c
   * Copyright (C) 2008-2010 Jonathan Cameron
@@ -9,10 +10,6 @@
   * Copyright (C) 2000 Russell King
   *
   * Driver for max1363 and similar chips.
-  *
-  * This program is free software; you can redistribute it and/or modify
-  * it under the terms of the GNU General Public License version 2 as
-  * published by the Free Software Foundation.
   */
 
 #include &lt;linux/interrupt.h&gt;
diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
index a04856d8afdb..4b873afe8e5a 100644
--- a/drivers/iio/adc/mcp320x.c
+++ b/drivers/iio/adc/mcp320x.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2013 Oskar Andero <a class="moz-txt-link-rfc2396E" href="mailto:oskar.andero@gmail.com">&lt;oskar.andero@gmail.com&gt;</a>
  * Copyright (C) 2014 Rose Technology
@@ -34,10 +35,6 @@
  * <a class="moz-txt-link-freetext" href="http://ww1.microchip.com/downloads/en/DeviceDoc/21298c.pdf">http://ww1.microchip.com/downloads/en/DeviceDoc/21298c.pdf</a>  mcp3204/08
  * <a class="moz-txt-link-freetext" href="http://ww1.microchip.com/downloads/en/DeviceDoc/21700E.pdf">http://ww1.microchip.com/downloads/en/DeviceDoc/21700E.pdf</a>  mcp3301
  * <a class="moz-txt-link-freetext" href="http://ww1.microchip.com/downloads/en/DeviceDoc/21950D.pdf">http://ww1.microchip.com/downloads/en/DeviceDoc/21950D.pdf</a>  mcp3550/1/3
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include &lt;linux/err.h&gt;
diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
index 819f26011500..c8232ba24667 100644
--- a/drivers/iio/adc/mcp3422.c
+++ b/drivers/iio/adc/mcp3422.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * mcp3422.c - driver for the Microchip mcp3421/2/3/4/5/6/7/8 chip family
  *
@@ -10,11 +11,6 @@
  *
  * This driver exports the value of analog input voltage to sysfs, the
  * voltage unit is nV.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
  */
 
 #include &lt;linux/err.h&gt;
diff --git a/drivers/iio/adc/men_z188_adc.c b/drivers/iio/adc/men_z188_adc.c
index c80261748d8f..0cb809bf1730 100644
--- a/drivers/iio/adc/men_z188_adc.c
+++ b/drivers/iio/adc/men_z188_adc.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * MEN 16z188 Analog to Digial Converter
  *
  * Copyright (C) 2014 MEN Mikroelektronik GmbH (<a class="moz-txt-link-abbreviated" href="http://www.men.de">www.men.de</a>)
  * Author: Johannes Thumshirn <a class="moz-txt-link-rfc2396E" href="mailto:johannes.thumshirn@men.de">&lt;johannes.thumshirn@men.de&gt;</a>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; version 2 of the License.
  */
 
 #include &lt;linux/kernel.h&gt;
diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 729becb2d3d9..f5299c9bdbde 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Amlogic Meson Successive Approximation Register (SAR) A/D Converter
  *
  * Copyright (C) 2017 Martin Blumenstingl <a class="moz-txt-link-rfc2396E" href="mailto:martin.blumenstingl@googlemail.com">&lt;martin.blumenstingl@googlemail.com&gt;</a>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * You should have received a copy of the GNU General Public License
  * along with this program. If not, see <a class="moz-txt-link-rfc2396E" href="http://www.gnu.org/licenses/">&lt;http://www.gnu.org/licenses/&gt;</a>.
  */
diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
index 95d76abb64ec..cba0e47c6013 100644
--- a/drivers/iio/adc/mt6577_auxadc.c
+++ b/drivers/iio/adc/mt6577_auxadc.c
@@ -1,15 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2016 MediaTek Inc.
  * Author: Zhiyong Tao <a class="moz-txt-link-rfc2396E" href="mailto:zhiyong.tao@mediatek.com">&lt;zhiyong.tao@mediatek.com&gt;</a>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include &lt;linux/clk.h&gt;
diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
index c627513d9f0f..80983334e5c2 100644
--- a/drivers/iio/adc/mxs-lradc-adc.c
+++ b/drivers/iio/adc/mxs-lradc-adc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Freescale MXS LRADC ADC driver
  *
@@ -7,16 +8,6 @@
  * Authors:
  *  Marek Vasut <a class="moz-txt-link-rfc2396E" href="mailto:marex@denx.de">&lt;marex@denx.de&gt;</a>
  *  Ksenija Stanojevic <a class="moz-txt-link-rfc2396E" href="mailto:ksenija.stanojevic@gmail.com">&lt;ksenija.stanojevic@gmail.com&gt;</a>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
  */
 
 #include &lt;linux/completion.h&gt;
diff --git a/drivers/iio/adc/nau7802.c b/drivers/iio/adc/nau7802.c
index 8997e74a8847..4e53a63e5fb9 100644
--- a/drivers/iio/adc/nau7802.c
+++ b/drivers/iio/adc/nau7802.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Driver for the Nuvoton NAU7802 ADC
  *
  * Copyright 2013 Free Electrons
- *
- * Licensed under the GPLv2 or later.
  */
 
 #include &lt;linux/delay.h&gt;
diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
index 69b9affeef1e..45d1bf1253d7 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * palmas-adc.c -- TI PALMAS GPADC.
  *
  * Copyright (c) 2013, NVIDIA Corporation. All rights reserved.
  *
  * Author: Pradeep Goudagunta <a class="moz-txt-link-rfc2396E" href="mailto:pgoudagunta@nvidia.com">&lt;pgoudagunta@nvidia.com&gt;</a>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation version 2.
  */
 
 #include &lt;linux/module.h&gt;
diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
index c30c002f1fef..648136ed1f85 100644
--- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
+++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Qualcomm PM8xxx PMIC XOADC driver
  *
diff --git a/drivers/iio/adc/qcom-spmi-iadc.c b/drivers/iio/adc/qcom-spmi-iadc.c
index 3f062cd61aba..a8402a47c8e4 100644
--- a/drivers/iio/adc/qcom-spmi-iadc.c
+++ b/drivers/iio/adc/qcom-spmi-iadc.c
@@ -1,14 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2012-2014, The Linux Foundation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include &lt;linux/bitops.h&gt;
diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
index 3680e0d47412..f3e8fdee39d8 100644
--- a/drivers/iio/adc/qcom-spmi-vadc.c
+++ b/drivers/iio/adc/qcom-spmi-vadc.c
@@ -1,14 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2012-2016, The Linux Foundation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include &lt;linux/bitops.h&gt;
diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index 1f98566d5b3c..234c6df348ce 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -1,16 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Rockchip Successive Approximation Register (SAR) A/D Converter
  * Copyright (C) 2014 ROCKCHIP, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include &lt;linux/module.h&gt;
diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
index b1da2c46107c..009019a39bba 100644
--- a/drivers/iio/adc/spear_adc.c
+++ b/drivers/iio/adc/spear_adc.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * ST SPEAr ADC driver
  *
  * Copyright 2012 Stefan Roese <a class="moz-txt-link-rfc2396E" href="mailto:sr@denx.de">&lt;sr@denx.de&gt;</a>
- *
- * Licensed under the GPL-2.
  */
 
 #include &lt;linux/module.h&gt;
diff --git a/drivers/iio/adc/stx104.c b/drivers/iio/adc/stx104.c
index 0662ca199eb0..f9d0aaae836f 100644
--- a/drivers/iio/adc/stx104.c
+++ b/drivers/iio/adc/stx104.c
@@ -1,15 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * IIO driver for the Apex Embedded Systems STX104
  * Copyright (C) 2016 William Breathitt Gray
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License, version 2, as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
  */
 #include &lt;linux/bitops.h&gt;
 #include &lt;linux/device.h&gt;
diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 04d7147e0110..f13c6248a662 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /* ADC driver for sunxi platforms' (A10, A13 and A31) GPADC
  *
  * Copyright (c) 2016 Quentin Schulz <a class="moz-txt-link-rfc2396E" href="mailto:quentin.schulz@free-electrons.com">&lt;quentin.schulz@free-electrons.com&gt;</a>
  *
- * This program is free software; you can redistribute it and/or modify it under
- * the terms of the GNU General Public License version 2 as published by the
- * Free Software Foundation.
- *
  * The Allwinner SoCs all have an ADC that can also act as a touchscreen
  * controller and a thermal sensor.
  * The thermal sensor works only when the ADC acts as a touchscreen controller
diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
index 405e3779c0c5..92c7584298f6 100644
--- a/drivers/iio/adc/ti-adc081c.c
+++ b/drivers/iio/adc/ti-adc081c.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * TI ADC081C/ADC101C/ADC121C 8/10/12-bit ADC driver
  *
  * Copyright (C) 2012 Avionic Design GmbH
  * Copyright (C) 2016 Intel
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * Datasheets:
  *	<a class="moz-txt-link-freetext" href="http://www.ti.com/lit/ds/symlink/adc081c021.pdf">http://www.ti.com/lit/ds/symlink/adc081c021.pdf</a>
  *	<a class="moz-txt-link-freetext" href="http://www.ti.com/lit/ds/symlink/adc101c021.pdf">http://www.ti.com/lit/ds/symlink/adc101c021.pdf</a>
diff --git a/drivers/iio/adc/ti-adc0832.c b/drivers/iio/adc/ti-adc0832.c
index 188dae705bf7..482a00dc9273 100644
--- a/drivers/iio/adc/ti-adc0832.c
+++ b/drivers/iio/adc/ti-adc0832.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * ADC0831/ADC0832/ADC0834/ADC0838 8-bit ADC driver
  *
  * Copyright (c) 2016 Akinobu Mita <a class="moz-txt-link-rfc2396E" href="mailto:akinobu.mita@gmail.com">&lt;akinobu.mita@gmail.com&gt;</a>
  *
- * This file is subject to the terms and conditions of version 2 of
- * the GNU General Public License.  See the file COPYING in the main
- * directory of this archive for more details.
- *
  * Datasheet: <a class="moz-txt-link-freetext" href="http://www.ti.com/lit/ds/symlink/adc0832-n.pdf">http://www.ti.com/lit/ds/symlink/adc0832-n.pdf</a>
  */
 
diff --git a/drivers/iio/adc/ti-adc084s021.c b/drivers/iio/adc/ti-adc084s021.c
index 25504640e126..914d097c8758 100644
--- a/drivers/iio/adc/ti-adc084s021.c
+++ b/drivers/iio/adc/ti-adc084s021.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /**
  * Copyright (C) 2017 Axis Communications AB
  *
  * Driver for Texas Instruments' ADC084S021 ADC chip.
  * Datasheets can be found here:
  * <a class="moz-txt-link-freetext" href="http://www.ti.com/lit/ds/symlink/adc084s021.pdf">http://www.ti.com/lit/ds/symlink/adc084s021.pdf</a>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include &lt;linux/err.h&gt;
diff --git a/drivers/iio/adc/ti-adc108s102.c b/drivers/iio/adc/ti-adc108s102.c
index 841203edaac5..a1c16199e7cc 100644
--- a/drivers/iio/adc/ti-adc108s102.c
+++ b/drivers/iio/adc/ti-adc108s102.c
@@ -1,18 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * TI ADC108S102 SPI ADC driver
  *
  * Copyright (c) 2013-2015 Intel Corporation.
  * Copyright (c) 2017 Siemens AG
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
  * This IIO device driver is designed to work with the following
  * analog to digital converters from Texas Instruments:
  *  ADC108S102
diff --git a/drivers/iio/adc/ti-adc12138.c b/drivers/iio/adc/ti-adc12138.c
index 703d68ae96b7..9445b79ad7b8 100644
--- a/drivers/iio/adc/ti-adc12138.c
+++ b/drivers/iio/adc/ti-adc12138.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * ADC12130/ADC12132/ADC12138 12-bit plus sign ADC driver
  *
  * Copyright (c) 2016 Akinobu Mita <a class="moz-txt-link-rfc2396E" href="mailto:akinobu.mita@gmail.com">&lt;akinobu.mita@gmail.com&gt;</a>
  *
- * This file is subject to the terms and conditions of version 2 of
- * the GNU General Public License.  See the file COPYING in the main
- * directory of this archive for more details.
- *
  * Datasheet: <a class="moz-txt-link-freetext" href="http://www.ti.com/lit/ds/symlink/adc12138.pdf">http://www.ti.com/lit/ds/symlink/adc12138.pdf</a>
  */
 
diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 6a114dcb4a3a..cddb41a3919c 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * ADS1015 - Texas Instruments Analog-to-Digital Converter
  *
  * Copyright (c) 2016, Intel Corporation.
  *
- * This file is subject to the terms and conditions of version 2 of
- * the GNU General Public License.  See the file COPYING in the main
- * directory of this archive for more details.
- *
  * IIO driver for ADS1015 ADC 7-bit I2C slave address:
  *	* 0x48 - ADDR connected to Ground
  *	* 0x49 - ADDR connected to Vdd
diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
index 184d686ebd99..83d99a79f79e 100644
--- a/drivers/iio/adc/ti-ads8688.c
+++ b/drivers/iio/adc/ti-ads8688.c
@@ -1,9 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2015 Prevas A/S
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include &lt;linux/device.h&gt;
diff --git a/drivers/iio/adc/ti-tlc4541.c b/drivers/iio/adc/ti-tlc4541.c
index 2290024c89fc..945d547302c6 100644
--- a/drivers/iio/adc/ti-tlc4541.c
+++ b/drivers/iio/adc/ti-tlc4541.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * TI tlc4541 ADC Driver
  *
@@ -7,10 +8,6 @@
  * <a class="moz-txt-link-freetext" href="http://www.ti.com/lit/gpn/tlc3541">http://www.ti.com/lit/gpn/tlc3541</a>
  * <a class="moz-txt-link-freetext" href="http://www.ti.com/lit/gpn/tlc4541">http://www.ti.com/lit/gpn/tlc4541</a>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * The tlc4541 requires 24 clock cycles to start a transfer.
  * Conversion then takes 2.94us to complete before data is ready
  * Data is returned MSB first.
diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index cafb1dcadc48..aac5a1959b78 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -1,16 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * TI ADC MFD driver
  *
  * Copyright (C) 2012 Texas Instruments Incorporated - <a class="moz-txt-link-freetext" href="http://www.ti.com/">http://www.ti.com/</a>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation version 2.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include &lt;linux/kernel.h&gt;
diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
index 8c019bb6625f..d3ea08f8d33d 100644
--- a/drivers/iio/adc/twl4030-madc.c
+++ b/drivers/iio/adc/twl4030-madc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *
  * TWL4030 MADC module driver-This driver monitors the real time
@@ -12,21 +13,6 @@
  * Mikko Ylinen <a class="moz-txt-link-rfc2396E" href="mailto:mikko.k.ylinen@nokia.com">&lt;mikko.k.ylinen@nokia.com&gt;</a>
  *
  * Amit Kucheria <a class="moz-txt-link-rfc2396E" href="mailto:amit.kucheria@canonical.com">&lt;amit.kucheria@canonical.com&gt;</a>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
  */
 
 #include &lt;linux/device.h&gt;
diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
index e470510e76ea..201027839c1e 100644
--- a/drivers/iio/adc/twl6030-gpadc.c
+++ b/drivers/iio/adc/twl6030-gpadc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * TWL6030 GPADC module driver
  *
@@ -12,21 +13,6 @@
  * Based on twl4030-madc.c
  * Copyright (C) 2008 Nokia Corporation
  * Mikko Ylinen <a class="moz-txt-link-rfc2396E" href="mailto:mikko.k.ylinen@nokia.com">&lt;mikko.k.ylinen@nokia.com&gt;</a>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
  */
 #include &lt;linux/interrupt.h&gt;
 #include &lt;linux/kernel.h&gt;
diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index bbcb7a4d7edf..a9d13b8b9a68 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -1,21 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Freescale Vybrid vf610 ADC driver
  *
  * Copyright 2013 Freescale Semiconductor, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
 #include &lt;linux/module.h&gt;
diff --git a/drivers/iio/adc/viperboard_adc.c b/drivers/iio/adc/viperboard_adc.c
index 53eb5a4136fe..5b64a5ea488f 100644
--- a/drivers/iio/adc/viperboard_adc.c
+++ b/drivers/iio/adc/viperboard_adc.c
@@ -1,15 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  Nano River Technologies viperboard IIO ADC driver
  *
  *  (C) 2012 by Lemonage GmbH
  *  Author: Lars Poeschel <a class="moz-txt-link-rfc2396E" href="mailto:poeschel@lemonage.de">&lt;poeschel@lemonage.de&gt;</a>
  *  All rights reserved.
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the	License, or (at your
- *  option) any later version.
- *
  */
 
 #include &lt;linux/kernel.h&gt;
diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 3f6be5ac049a..b7b5adf6c9fc 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -1,11 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Xilinx XADC driver
  *
  * Copyright 2013-2014 Analog Devices Inc.
  *  Author: Lars-Peter Clauen <a class="moz-txt-link-rfc2396E" href="mailto:lars@metafoo.de">&lt;lars@metafoo.de&gt;</a>
  *
- * Licensed under the GPL-2.
- *
  * Documentation for the parts can be found at:
  *  - XADC hardmacro: Xilinx UG480
  *  - ZYNQ XADC interface: Xilinx UG585
diff --git a/drivers/iio/adc/xilinx-xadc-events.c b/drivers/iio/adc/xilinx-xadc-events.c
index dc0670308253..0c81ad4f0a05 100644
--- a/drivers/iio/adc/xilinx-xadc-events.c
+++ b/drivers/iio/adc/xilinx-xadc-events.c
@@ -1,10 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Xilinx XADC driver
  *
  * Copyright 2013 Analog Devices Inc.
  *  Author: Lars-Peter Clauen <a class="moz-txt-link-rfc2396E" href="mailto:lars@metafoo.de">&lt;lars@metafoo.de&gt;</a>
- *
- * Licensed under the GPL-2.
  */
 
 #include &lt;linux/iio/events.h&gt;
diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
index 8c0009585c16..5b9042e7441d 100644
--- a/drivers/iio/adc/xilinx-xadc.h
+++ b/drivers/iio/adc/xilinx-xadc.h
@@ -1,10 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Xilinx XADC driver
  *
  * Copyright 2013 Analog Devices Inc.
  *  Author: Lars-Peter Clauen <a class="moz-txt-link-rfc2396E" href="mailto:lars@metafoo.de">&lt;lars@metafoo.de&gt;</a>
- *
- * Licensed under the GPL-2.
  */
 
 #ifndef __IIO_XILINX_XADC__
</pre>
    </blockquote>
  </body>
</html>

--------------3A64579E9D7745788356ECEC--
