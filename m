Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43351 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751450AbdCYQhP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Mar 2017 12:37:15 -0400
Subject: Re: [PATCH] iio: bmg160: reset chip when probing
To: Quentin Schulz <quentin.schulz@free-electrons.com>,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
References: <20170321155214.18060-1-quentin.schulz@free-electrons.com>
Cc: irina.tirdea@intel.com, gregor.boirie@parrot.com,
        amsfield22@gmail.com, s.trumtrar@pengutronix.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@free-electrons.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <4e094dd9-afdb-80fa-c943-ec870f9cd57c@kernel.org>
Date: Sat, 25 Mar 2017 16:37:11 +0000
MIME-Version: 1.0
In-Reply-To: <20170321155214.18060-1-quentin.schulz@free-electrons.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/03/17 15:52, Quentin Schulz wrote:
> The gyroscope chip might need to be reset to be used.
> 
> Without the chip being reset, the driver stopped at the first
> regmap_read (to get the CHIP_ID) and failed to probe.
> 
> The datasheet of the gyroscope says that a minimum wait of 30ms after
> the reset has to be done.
> 
> This patch has been checked on a BMX055 and the datasheet of the BMG160
> and the BMI055 give the same reset register and bits.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan
> ---
>  drivers/iio/gyro/bmg160_core.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
> index f7fcfa8..821919d 100644
> --- a/drivers/iio/gyro/bmg160_core.c
> +++ b/drivers/iio/gyro/bmg160_core.c
> @@ -27,6 +27,7 @@
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/regmap.h>
> +#include <linux/delay.h>
>  #include "bmg160.h"
>  
>  #define BMG160_IRQ_NAME		"bmg160_event"
> @@ -52,6 +53,9 @@
>  #define BMG160_DEF_BW			100
>  #define BMG160_REG_PMU_BW_RES		BIT(7)
>  
> +#define BMG160_GYRO_REG_RESET		0x14
> +#define BMG160_GYRO_RESET_VAL		0xb6
> +
>  #define BMG160_REG_INT_MAP_0		0x17
>  #define BMG160_INT_MAP_0_BIT_ANY	BIT(1)
>  
> @@ -236,6 +240,14 @@ static int bmg160_chip_init(struct bmg160_data *data)
>  	int ret;
>  	unsigned int val;
>  
> +	/*
> +	 * Reset chip to get it in a known good state. A delay of 30ms after
> +	 * reset is required according to the datasheet.
> +	 */
> +	regmap_write(data->regmap, BMG160_GYRO_REG_RESET,
> +		     BMG160_GYRO_RESET_VAL);
> +	usleep_range(30000, 30700);
> +
>  	ret = regmap_read(data->regmap, BMG160_REG_CHIP_ID, &val);
>  	if (ret < 0) {
>  		dev_err(dev, "Error reading reg_chip_id\n");
> 

