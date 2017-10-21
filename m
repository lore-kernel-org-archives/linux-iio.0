Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932132AbdJURf6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Oct 2017 13:35:58 -0400
Date: Sat, 21 Oct 2017 18:35:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com
Subject: Re: [PATCH 05/13] staging: iio: tsl2x7x: changed #defines to be
 aligned on the same column
Message-ID: <20171021183553.3aef3395@archlinux>
In-Reply-To: <20171019200632.25820-6-masneyb@onstation.org>
References: <20171019200632.25820-1-masneyb@onstation.org>
        <20171019200632.25820-6-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 19 Oct 2017 16:06:24 -0400
Brian Masney <masneyb@onstation.org> wrote:

> Some of the existing #defines have tabs between the name, and the value,
> while others have spaces. The alignment of the values mostly has a
> consistent layout, but there are some that don't. Change all of the
> defines so that the name and value is separated by tabs and all of the
> values start on the same column to increase code readability. This patch
> also removes the unnecessary parentheses around the value of
> TSL2X7X_MAX_TIMER_CNT.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied.
> ---
>  drivers/staging/iio/light/tsl2x7x.c | 132 ++++++++++++++++++------------------
>  1 file changed, 66 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index d407c3ad7e2f..3a3340aadc1a 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -29,98 +29,98 @@
>  #include "tsl2x7x.h"
>  
>  /* Cal defs*/
> -#define PROX_STAT_CAL        0
> -#define PROX_STAT_SAMP       1
> -#define MAX_SAMPLES_CAL      200
> +#define PROX_STAT_CAL			0
> +#define PROX_STAT_SAMP			1
> +#define MAX_SAMPLES_CAL			200
>  
>  /* TSL2X7X Device ID */
> -#define TRITON_ID    0x00
> -#define SWORDFISH_ID 0x30
> -#define HALIBUT_ID   0x20
> +#define TRITON_ID			0x00
> +#define SWORDFISH_ID			0x30
> +#define HALIBUT_ID			0x20
>  
>  /* Lux calculation constants */
> -#define TSL2X7X_LUX_CALC_OVER_FLOW     65535
> +#define TSL2X7X_LUX_CALC_OVER_FLOW	65535
>  
>  /* TAOS Register definitions - note:
>   * depending on device, some of these register are not used and the
>   * register address is benign.
>   */
>  /* 2X7X register offsets */
> -#define TSL2X7X_MAX_CONFIG_REG         16
> +#define TSL2X7X_MAX_CONFIG_REG		16
>  
>  /* Device Registers and Masks */
> -#define TSL2X7X_CNTRL                  0x00
> -#define TSL2X7X_ALS_TIME               0X01
> -#define TSL2X7X_PRX_TIME               0x02
> -#define TSL2X7X_WAIT_TIME              0x03
> -#define TSL2X7X_ALS_MINTHRESHLO        0X04
> -#define TSL2X7X_ALS_MINTHRESHHI        0X05
> -#define TSL2X7X_ALS_MAXTHRESHLO        0X06
> -#define TSL2X7X_ALS_MAXTHRESHHI        0X07
> -#define TSL2X7X_PRX_MINTHRESHLO        0X08
> -#define TSL2X7X_PRX_MINTHRESHHI        0X09
> -#define TSL2X7X_PRX_MAXTHRESHLO        0X0A
> -#define TSL2X7X_PRX_MAXTHRESHHI        0X0B
> -#define TSL2X7X_PERSISTENCE            0x0C
> -#define TSL2X7X_PRX_CONFIG             0x0D
> -#define TSL2X7X_PRX_COUNT              0x0E
> -#define TSL2X7X_GAIN                   0x0F
> -#define TSL2X7X_NOTUSED                0x10
> -#define TSL2X7X_REVID                  0x11
> -#define TSL2X7X_CHIPID                 0x12
> -#define TSL2X7X_STATUS                 0x13
> -#define TSL2X7X_ALS_CHAN0LO            0x14
> -#define TSL2X7X_ALS_CHAN0HI            0x15
> -#define TSL2X7X_ALS_CHAN1LO            0x16
> -#define TSL2X7X_ALS_CHAN1HI            0x17
> -#define TSL2X7X_PRX_LO                 0x18
> -#define TSL2X7X_PRX_HI                 0x19
> +#define TSL2X7X_CNTRL			0x00
> +#define TSL2X7X_ALS_TIME		0X01
> +#define TSL2X7X_PRX_TIME		0x02
> +#define TSL2X7X_WAIT_TIME		0x03
> +#define TSL2X7X_ALS_MINTHRESHLO		0X04
> +#define TSL2X7X_ALS_MINTHRESHHI		0X05
> +#define TSL2X7X_ALS_MAXTHRESHLO		0X06
> +#define TSL2X7X_ALS_MAXTHRESHHI		0X07
> +#define TSL2X7X_PRX_MINTHRESHLO		0X08
> +#define TSL2X7X_PRX_MINTHRESHHI		0X09
> +#define TSL2X7X_PRX_MAXTHRESHLO		0X0A
> +#define TSL2X7X_PRX_MAXTHRESHHI		0X0B
> +#define TSL2X7X_PERSISTENCE		0x0C
> +#define TSL2X7X_PRX_CONFIG		0x0D
> +#define TSL2X7X_PRX_COUNT		0x0E
> +#define TSL2X7X_GAIN			0x0F
> +#define TSL2X7X_NOTUSED			0x10
> +#define TSL2X7X_REVID			0x11
> +#define TSL2X7X_CHIPID			0x12
> +#define TSL2X7X_STATUS			0x13
> +#define TSL2X7X_ALS_CHAN0LO		0x14
> +#define TSL2X7X_ALS_CHAN0HI		0x15
> +#define TSL2X7X_ALS_CHAN1LO		0x16
> +#define TSL2X7X_ALS_CHAN1HI		0x17
> +#define TSL2X7X_PRX_LO			0x18
> +#define TSL2X7X_PRX_HI			0x19
>  
>  /* tsl2X7X cmd reg masks */
> -#define TSL2X7X_CMD_REG                0x80
> -#define TSL2X7X_CMD_SPL_FN             0x60
> +#define TSL2X7X_CMD_REG			0x80
> +#define TSL2X7X_CMD_SPL_FN		0x60
>  
> -#define TSL2X7X_CMD_PROX_INT_CLR       0X05
> -#define TSL2X7X_CMD_ALS_INT_CLR        0x06
> -#define TSL2X7X_CMD_PROXALS_INT_CLR    0X07
> +#define TSL2X7X_CMD_PROX_INT_CLR	0X05
> +#define TSL2X7X_CMD_ALS_INT_CLR		0x06
> +#define TSL2X7X_CMD_PROXALS_INT_CLR	0X07
>  
>  /* tsl2X7X cntrl reg masks */
> -#define TSL2X7X_CNTL_ADC_ENBL          0x02
> -#define TSL2X7X_CNTL_PWR_ON            0x01
> +#define TSL2X7X_CNTL_ADC_ENBL		0x02
> +#define TSL2X7X_CNTL_PWR_ON		0x01
>  
>  /* tsl2X7X status reg masks */
> -#define TSL2X7X_STA_ADC_VALID          0x01
> -#define TSL2X7X_STA_PRX_VALID          0x02
> -#define TSL2X7X_STA_ADC_PRX_VALID      (TSL2X7X_STA_ADC_VALID |\
> -					TSL2X7X_STA_PRX_VALID)
> -#define TSL2X7X_STA_ALS_INTR           0x10
> -#define TSL2X7X_STA_PRX_INTR           0x20
> +#define TSL2X7X_STA_ADC_VALID		0x01
> +#define TSL2X7X_STA_PRX_VALID		0x02
> +#define TSL2X7X_STA_ADC_PRX_VALID	(TSL2X7X_STA_ADC_VALID | \
> +					 TSL2X7X_STA_PRX_VALID)
> +#define TSL2X7X_STA_ALS_INTR		0x10
> +#define TSL2X7X_STA_PRX_INTR		0x20
>  
>  /* tsl2X7X cntrl reg masks */
> -#define TSL2X7X_CNTL_REG_CLEAR         0x00
> -#define TSL2X7X_CNTL_PROX_INT_ENBL     0X20
> -#define TSL2X7X_CNTL_ALS_INT_ENBL      0X10
> -#define TSL2X7X_CNTL_WAIT_TMR_ENBL     0X08
> -#define TSL2X7X_CNTL_PROX_DET_ENBL     0X04
> -#define TSL2X7X_CNTL_PWRON             0x01
> -#define TSL2X7X_CNTL_ALSPON_ENBL       0x03
> -#define TSL2X7X_CNTL_INTALSPON_ENBL    0x13
> -#define TSL2X7X_CNTL_PROXPON_ENBL      0x0F
> -#define TSL2X7X_CNTL_INTPROXPON_ENBL   0x2F
> +#define TSL2X7X_CNTL_REG_CLEAR		0x00
> +#define TSL2X7X_CNTL_PROX_INT_ENBL	0X20
> +#define TSL2X7X_CNTL_ALS_INT_ENBL	0X10
> +#define TSL2X7X_CNTL_WAIT_TMR_ENBL	0X08
> +#define TSL2X7X_CNTL_PROX_DET_ENBL	0X04
> +#define TSL2X7X_CNTL_PWRON		0x01
> +#define TSL2X7X_CNTL_ALSPON_ENBL	0x03
> +#define TSL2X7X_CNTL_INTALSPON_ENBL	0x13
> +#define TSL2X7X_CNTL_PROXPON_ENBL	0x0F
> +#define TSL2X7X_CNTL_INTPROXPON_ENBL	0x2F
>  
>  /*Prox diode to use */
> -#define TSL2X7X_DIODE0                 0x10
> -#define TSL2X7X_DIODE1                 0x20
> -#define TSL2X7X_DIODE_BOTH             0x30
> +#define TSL2X7X_DIODE0			0x10
> +#define TSL2X7X_DIODE1			0x20
> +#define TSL2X7X_DIODE_BOTH		0x30
>  
>  /* LED Power */
> -#define TSL2X7X_mA100                  0x00
> -#define TSL2X7X_mA50                   0x40
> -#define TSL2X7X_mA25                   0x80
> -#define TSL2X7X_mA13                   0xD0
> -#define TSL2X7X_MAX_TIMER_CNT          (0xFF)
> +#define TSL2X7X_mA100			0x00
> +#define TSL2X7X_mA50			0x40
> +#define TSL2X7X_mA25			0x80
> +#define TSL2X7X_mA13			0xD0
> +#define TSL2X7X_MAX_TIMER_CNT		0xFF
>  
> -#define TSL2X7X_MIN_ITIME 3
> +#define TSL2X7X_MIN_ITIME		3
>  
>  /* TAOS txx2x7x Device family members */
>  enum {

