Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52507 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752841AbbEHSaQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 8 May 2015 14:30:16 -0400
Message-ID: <554CBBDA.6040202@kernel.org>
Date: Fri, 08 May 2015 09:36:26 -0400
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
CC: Naidu Tellapati <naidu.tellapati@imgtec.com>,
	James Hartley <james.hartley@imgtec.com>,
	phani.movva@imgtec.com
Subject: Re: [PATCH 2/5] iio: adc: cc10001: Fix incorrect use of power-up/power-down
 register
References: <1431033741-1088-1-git-send-email-ezequiel.garcia@imgtec.com> <1431033741-1088-3-git-send-email-ezequiel.garcia@imgtec.com>
In-Reply-To: <1431033741-1088-3-git-send-email-ezequiel.garcia@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/05/15 17:22, Ezequiel Garcia wrote:
> From: Naidu Tellapati <naidu.tellapati@imgtec.com>
> 
> At present we are incorrectly setting the register to 0x1 to power up
> the ADC. Since it is an active high power down register, we need to set
> the register to 0x0 to actually power up. Conversely, writing 0x1 to the
> register powers it down.
> 
> This commit adds a couple of helpers to make the code clearer and then
> use them to do the power-up/power-down properly.
> 
> Fixes: 1664f6a5b0c8 ("iio: adc: Cosmic Circuits 10001 ADC driver")
> Signed-off-by: Naidu Tellapati <naidu.tellapati@imgtec.com>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Applied to the fixes-togreg branch of iio.git.
Thanks,

Jonathan
> ---
>  drivers/iio/adc/cc10001_adc.c | 35 +++++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/adc/cc10001_adc.c b/drivers/iio/adc/cc10001_adc.c
> index 357e6c2..cf6c6fb 100644
> --- a/drivers/iio/adc/cc10001_adc.c
> +++ b/drivers/iio/adc/cc10001_adc.c
> @@ -35,8 +35,9 @@
>  #define CC10001_ADC_EOC_SET		BIT(0)
>  
>  #define CC10001_ADC_CHSEL_SAMPLED	0x0c
> -#define CC10001_ADC_POWER_UP		0x10
> -#define CC10001_ADC_POWER_UP_SET	BIT(0)
> +#define CC10001_ADC_POWER_DOWN		0x10
> +#define CC10001_ADC_POWER_DOWN_SET	BIT(0)
> +
>  #define CC10001_ADC_DEBUG		0x14
>  #define CC10001_ADC_DATA_COUNT		0x20
>  
> @@ -78,6 +79,20 @@ static inline u32 cc10001_adc_read_reg(struct cc10001_adc_device *adc_dev,
>  	return readl(adc_dev->reg_base + reg);
>  }
>  
> +static void cc10001_adc_power_up(struct cc10001_adc_device *adc_dev)
> +{
> +	cc10001_adc_write_reg(adc_dev, CC10001_ADC_POWER_DOWN,
> +			      ~CC10001_ADC_POWER_DOWN_SET);
> +
> +	ndelay(adc_dev->start_delay_ns);
> +}
> +
> +static void cc10001_adc_power_down(struct cc10001_adc_device *adc_dev)
> +{
> +	cc10001_adc_write_reg(adc_dev, CC10001_ADC_POWER_DOWN,
> +			      CC10001_ADC_POWER_DOWN_SET);
> +}
> +
>  static void cc10001_adc_start(struct cc10001_adc_device *adc_dev,
>  			      unsigned int channel)
>  {
> @@ -139,11 +154,7 @@ static irqreturn_t cc10001_adc_trigger_h(int irq, void *p)
>  
>  	mutex_lock(&adc_dev->lock);
>  
> -	cc10001_adc_write_reg(adc_dev, CC10001_ADC_POWER_UP,
> -			      CC10001_ADC_POWER_UP_SET);
> -
> -	/* Wait for 8 (6+2) clock cycles before activating START */
> -	ndelay(adc_dev->start_delay_ns);
> +	cc10001_adc_power_up(adc_dev);
>  
>  	/* Calculate delay step for eoc and sampled data */
>  	delay_ns = adc_dev->eoc_delay_ns / CC10001_MAX_POLL_COUNT;
> @@ -167,7 +178,7 @@ static irqreturn_t cc10001_adc_trigger_h(int irq, void *p)
>  	}
>  
>  done:
> -	cc10001_adc_write_reg(adc_dev, CC10001_ADC_POWER_UP, 0);
> +	cc10001_adc_power_down(adc_dev);
>  
>  	mutex_unlock(&adc_dev->lock);
>  
> @@ -186,11 +197,7 @@ static u16 cc10001_adc_read_raw_voltage(struct iio_dev *indio_dev,
>  	unsigned int delay_ns;
>  	u16 val;
>  
> -	cc10001_adc_write_reg(adc_dev, CC10001_ADC_POWER_UP,
> -			      CC10001_ADC_POWER_UP_SET);
> -
> -	/* Wait for 8 (6+2) clock cycles before activating START */
> -	ndelay(adc_dev->start_delay_ns);
> +	cc10001_adc_power_up(adc_dev);
>  
>  	/* Calculate delay step for eoc and sampled data */
>  	delay_ns = adc_dev->eoc_delay_ns / CC10001_MAX_POLL_COUNT;
> @@ -199,7 +206,7 @@ static u16 cc10001_adc_read_raw_voltage(struct iio_dev *indio_dev,
>  
>  	val = cc10001_adc_poll_done(indio_dev, chan->channel, delay_ns);
>  
> -	cc10001_adc_write_reg(adc_dev, CC10001_ADC_POWER_UP, 0);
> +	cc10001_adc_power_down(adc_dev);
>  
>  	return val;
>  }
> 

