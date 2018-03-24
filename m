Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751894AbeCXNgv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Mar 2018 09:36:51 -0400
Date: Sat, 24 Mar 2018 13:36:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com
Subject: Re: [PATCH 05/11] staging: iio: tsl2x7x: split out als and prox
 interrupt settings
Message-ID: <20180324133646.4445277a@archlinux>
In-Reply-To: <20180321102912.5130-6-masneyb@onstation.org>
References: <20180321102912.5130-1-masneyb@onstation.org>
        <20180321102912.5130-6-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 21 Mar 2018 06:29:06 -0400
Brian Masney <masneyb@onstation.org> wrote:

> The struct tsl2x7x_settings contained an interrupts_en member that was
> a bitmask for which interrupts are enabled. This required having
> bitmasks in several parts of the code. This patch splits this field
> out into two booleans to remove most of the bitmasks in the code.
> 
> This patch also fixes a bug where if an interrupt pin was configured,
> but proximity interrupts were disabled, then the proximity value could
> not be polled.
> 
> This patch also removes an unnecessary second call to writing the
> control register in tsl2x7x_chip_on().
> 
> Driver tested using a TSL2772 hooked up to a Raspberry Pi 2.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied.
> ---
>  drivers/staging/iio/light/tsl2x7x.c | 64 ++++++++++++-------------------------
>  drivers/staging/iio/light/tsl2x7x.h |  7 ++--
>  2 files changed, 24 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 99230d9313e1..f7e7fcc17059 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -226,10 +226,11 @@ static const struct tsl2x7x_settings tsl2x7x_default_settings = {
>  	.prox_config = 0,
>  	.als_gain_trim = 1000,
>  	.als_cal_target = 150,
> +	.als_interrupt_en = false,
>  	.als_thresh_low = 200,
>  	.als_thresh_high = 256,
>  	.persistence = 255,
> -	.interrupts_en = 0,
> +	.prox_interrupt_en = false,
>  	.prox_thres_low  = 0,
>  	.prox_thres_high = 512,
>  	.prox_max_samples_cal = 30,
> @@ -686,37 +687,22 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
>  	/* Power-on settling time */
>  	usleep_range(3000, 3500);
>  
> -	/*
> -	 * NOW enable the ADC
> -	 * initialize the desired mode of operation
> -	 */
> -	ret = tsl2x7x_write_control_reg(chip,
> -					TSL2X7X_CNTL_PWR_ON |
> -					TSL2X7X_CNTL_ADC_ENBL |
> -					TSL2X7X_CNTL_PROX_DET_ENBL);
> +	reg_val = TSL2X7X_CNTL_PWR_ON | TSL2X7X_CNTL_ADC_ENBL |
> +		  TSL2X7X_CNTL_PROX_DET_ENBL;
> +	if (chip->settings.als_interrupt_en)
> +		reg_val |= TSL2X7X_CNTL_ALS_INT_ENBL;
> +	if (chip->settings.prox_interrupt_en)
> +		reg_val |= TSL2X7X_CNTL_PROX_INT_ENBL;
> +
> +	ret = tsl2x7x_write_control_reg(chip, reg_val);
>  	if (ret < 0)
>  		return ret;
>  
> -	chip->tsl2x7x_chip_status = TSL2X7X_CHIP_WORKING;
> -
> -	if (chip->settings.interrupts_en != 0) {
> -		dev_info(&chip->client->dev, "Setting Up Interrupt(s)\n");
> -
> -		reg_val = TSL2X7X_CNTL_PWR_ON | TSL2X7X_CNTL_ADC_ENBL;
> -		if (chip->settings.interrupts_en == 0x20 ||
> -		    chip->settings.interrupts_en == 0x30)
> -			reg_val |= TSL2X7X_CNTL_PROX_DET_ENBL;
> -
> -		reg_val |= chip->settings.interrupts_en;
> -		ret = tsl2x7x_write_control_reg(chip, reg_val);
> -		if (ret < 0)
> -			return ret;
> +	ret = tsl2x7x_clear_interrupts(chip, TSL2X7X_CMD_PROXALS_INT_CLR);
> +	if (ret < 0)
> +		return ret;
>  
> -		ret = tsl2x7x_clear_interrupts(chip,
> -					       TSL2X7X_CMD_PROXALS_INT_CLR);
> -		if (ret < 0)
> -			return ret;
> -	}
> +	chip->tsl2x7x_chip_status = TSL2X7X_CHIP_WORKING;
>  
>  	return ret;
>  }
> @@ -978,14 +964,11 @@ static int tsl2x7x_read_interrupt_config(struct iio_dev *indio_dev,
>  					 enum iio_event_direction dir)
>  {
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> -	int ret;
>  
>  	if (chan->type == IIO_INTENSITY)
> -		ret = !!(chip->settings.interrupts_en & 0x10);
> +		return chip->settings.als_interrupt_en;
>  	else
> -		ret = !!(chip->settings.interrupts_en & 0x20);
> -
> -	return ret;
> +		return chip->settings.prox_interrupt_en;
>  }
>  
>  static int tsl2x7x_write_interrupt_config(struct iio_dev *indio_dev,
> @@ -997,17 +980,10 @@ static int tsl2x7x_write_interrupt_config(struct iio_dev *indio_dev,
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
>  	int ret;
>  
> -	if (chan->type == IIO_INTENSITY) {
> -		if (val)
> -			chip->settings.interrupts_en |= 0x10;
> -		else
> -			chip->settings.interrupts_en &= 0x20;
> -	} else {
> -		if (val)
> -			chip->settings.interrupts_en |= 0x20;
> -		else
> -			chip->settings.interrupts_en &= 0x10;
> -	}
> +	if (chan->type == IIO_INTENSITY)
> +		chip->settings.als_interrupt_en = val ? true : false;
> +	else
> +		chip->settings.prox_interrupt_en = val ? true : false;
>  
>  	ret = tsl2x7x_invoke_change(indio_dev);
>  	if (ret < 0)
> diff --git a/drivers/staging/iio/light/tsl2x7x.h b/drivers/staging/iio/light/tsl2x7x.h
> index 28b0e7fdc9b8..b2aa642299b3 100644
> --- a/drivers/staging/iio/light/tsl2x7x.h
> +++ b/drivers/staging/iio/light/tsl2x7x.h
> @@ -50,12 +50,12 @@ struct tsl2x7x_lux {
>   *  @prox_config:           Prox configuration filters.
>   *  @als_cal_target:        Known external ALS reading for
>   *                          calibration.
> - *  @interrupts_en:         Enable/Disable - 0x00 = none, 0x10 = als,
> - *                                           0x20 = prx,  0x30 = bth
>   *  @persistence:           H/W Filters, Number of 'out of limits'
>   *                          ADC readings PRX/ALS.
> + *  @als_interrupt_en:      Enable/Disable ALS interrupts
>   *  @als_thresh_low:        CH0 'low' count to trigger interrupt.
>   *  @als_thresh_high:       CH0 'high' count to trigger interrupt.
> + *  @prox_interrupt_en:     Enable/Disable proximity interrupts
>   *  @prox_thres_low:        Low threshold proximity detection.
>   *  @prox_thres_high:       High threshold proximity detection
>   *  @prox_pulse_count:      Number if proximity emitter pulses
> @@ -70,10 +70,11 @@ struct tsl2x7x_settings {
>  	int prox_gain;
>  	int prox_config;
>  	int als_cal_target;
> -	u8  interrupts_en;
>  	u8  persistence;
> +	bool als_interrupt_en;
>  	int als_thresh_low;
>  	int als_thresh_high;
> +	bool prox_interrupt_en;
>  	int prox_thres_low;
>  	int prox_thres_high;
>  	int prox_pulse_count;

