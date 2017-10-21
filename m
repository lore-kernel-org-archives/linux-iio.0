Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932132AbdJURi2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Oct 2017 13:38:28 -0400
Date: Sat, 21 Oct 2017 18:38:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com
Subject: Re: [PATCH 07/13] staging: iio: tsl2x7x: remove unnecessary
 parentheses
Message-ID: <20171021183823.3fb96b21@archlinux>
In-Reply-To: <20171019200632.25820-8-masneyb@onstation.org>
References: <20171019200632.25820-1-masneyb@onstation.org>
        <20171019200632.25820-8-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 19 Oct 2017 16:06:26 -0400
Brian Masney <masneyb@onstation.org> wrote:

> This patch fixes the error 'Unnecessary parentheses around 'XXX' from
> checkpatch.pl. It also fixes several other places with unnecessary
> parentheses that checkpatch.pl did not detect.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Some of these are completely pointless, others can be argued either
way (from a readability point of view).  I don't care much on those though so
Applied to the togreg branch of iio.git

Thanks,

Jonathan
> ---
>  drivers/staging/iio/light/tsl2x7x.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 80968dd456a0..6cc89cd6505e 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -348,9 +348,9 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
>  
>  	/* clear any existing interrupt status */
>  	ret = i2c_smbus_write_byte(chip->client,
> -				   (TSL2X7X_CMD_REG |
> +				   TSL2X7X_CMD_REG |
>  				   TSL2X7X_CMD_SPL_FN |
> -				   TSL2X7X_CMD_ALS_INT_CLR));
> +				   TSL2X7X_CMD_ALS_INT_CLR);
>  	if (ret < 0) {
>  		dev_err(&chip->client->dev,
>  			"i2c_write_command failed - err = %d\n", ret);
> @@ -364,7 +364,7 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
>  	chip->als_cur_info.als_ch0 = ch0;
>  	chip->als_cur_info.als_ch1 = ch1;
>  
> -	if ((ch0 >= chip->als_saturation) || (ch1 >= chip->als_saturation)) {
> +	if (ch0 >= chip->als_saturation || ch1 >= chip->als_saturation) {
>  		lux = TSL2X7X_LUX_CALC_OVER_FLOW;
>  		goto return_max;
>  	}
> @@ -697,14 +697,14 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
>  		dev_info(&chip->client->dev, "Setting Up Interrupt(s)\n");
>  
>  		reg_val = TSL2X7X_CNTL_PWR_ON | TSL2X7X_CNTL_ADC_ENBL;
> -		if ((chip->settings.interrupts_en == 0x20) ||
> -		    (chip->settings.interrupts_en == 0x30))
> +		if (chip->settings.interrupts_en == 0x20 ||
> +		    chip->settings.interrupts_en == 0x30)
>  			reg_val |= TSL2X7X_CNTL_PROX_DET_ENBL;
>  
>  		reg_val |= chip->settings.interrupts_en;
>  		ret = i2c_smbus_write_byte_data(chip->client,
> -						(TSL2X7X_CMD_REG |
> -						TSL2X7X_CNTRL), reg_val);
> +						TSL2X7X_CMD_REG | TSL2X7X_CNTRL,
> +						reg_val);
>  		if (ret < 0)
>  			dev_err(&chip->client->dev,
>  				"%s: failed in tsl2x7x_IOCTL_INT_SET.\n",
> @@ -1721,7 +1721,7 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
>  		return -EINVAL;
>  	}
>  
> -	ret = i2c_smbus_write_byte(clientp, (TSL2X7X_CMD_REG | TSL2X7X_CNTRL));
> +	ret = i2c_smbus_write_byte(clientp, TSL2X7X_CMD_REG | TSL2X7X_CNTRL);
>  	if (ret < 0) {
>  		dev_err(&clientp->dev, "write to cmd reg failed. err = %d\n",
>  			ret);

