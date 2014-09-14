Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55604 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707AbaINRUA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 14 Sep 2014 13:20:00 -0400
Message-ID: <5415CE3B.4090000@kernel.org>
Date: Sun, 14 Sep 2014 18:19:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Ludovic Desroches <ludovic.desroches@atmel.com>,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
CC: alexandre.belloni@free-electrons.com, josh.wu@atmel.com,
	maxime.ripard@free-electrons.com, knaack.h@gmx.de
Subject: Re: [PATCH v3] iio: adc: at91: don't use the last converted data
 register
References: <1410357747-29797-1-git-send-email-ludovic.desroches@atmel.com> <54105A65.3040009@atmel.com>
In-Reply-To: <54105A65.3040009@atmel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/09/14 15:04, Nicolas Ferre wrote:
> On 10/09/2014 16:02, Ludovic Desroches :
>> If touchscreen mode is enabled and a conversion is requested on another
>> channel, the result in the last converted data register can be a
>> touchscreen relative value. Starting a conversion involves to do a
>> conversion for all active channel. It starts with ADC channels and ends
>> with touchscreen channels. Then if ADC_LCD register is not read quickly,
>> its content may be a touchscreen conversion.
>> To remove this temporal constraint, the conversion value is taken from
>> the channel data register.
>>
>> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Applied with 2 lines of fuzz to the fixes-togreg branch of iio.git

Thanks,

Jonathan
> 
>> ---
>>
>> Changes from v2:
>> - fix GENMASK indexes
>>
>> Changes from v1:
>> - use GENMASK and BIT macros
>>
>>  drivers/iio/adc/at91_adc.c |   12 +++++++-----
>>  1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
>> index 3b5bacd..ad51808 100644
>> --- a/drivers/iio/adc/at91_adc.c
>> +++ b/drivers/iio/adc/at91_adc.c
>> @@ -196,6 +196,7 @@ struct at91_adc_state {
>>  	bool			done;
>>  	int			irq;
>>  	u16			last_value;
>> +	int			chnb;
>>  	struct mutex		lock;
>>  	u8			num_channels;
>>  	void __iomem		*reg_base;
>> @@ -274,7 +275,7 @@ void handle_adc_eoc_trigger(int irq, struct iio_dev *idev)
>>  		disable_irq_nosync(irq);
>>  		iio_trigger_poll(idev->trig, iio_get_time_ns());
>>  	} else {
>> -		st->last_value = at91_adc_readl(st, AT91_ADC_LCDR);
>> +		st->last_value = at91_adc_readl(st, AT91_ADC_CHAN(st, st->chnb));
>>  		st->done = true;
>>  		wake_up_interruptible(&st->wq_data_avail);
>>  	}
>> @@ -351,7 +352,7 @@ static irqreturn_t at91_adc_rl_interrupt(int irq, void *private)
>>  	unsigned int reg;
>>  
>>  	status &= at91_adc_readl(st, AT91_ADC_IMR);
>> -	if (status & st->registers->drdy_mask)
>> +	if (status & GENMASK(st->num_channels - 1, 0))
>>  		handle_adc_eoc_trigger(irq, idev);
>>  
>>  	if (status & AT91RL_ADC_IER_PEN) {
>> @@ -418,7 +419,7 @@ static irqreturn_t at91_adc_9x5_interrupt(int irq, void *private)
>>  		AT91_ADC_IER_YRDY |
>>  		AT91_ADC_IER_PRDY;
>>  
>> -	if (status & st->registers->drdy_mask)
>> +	if (status & GENMASK(st->num_channels - 1, 0))
>>  		handle_adc_eoc_trigger(irq, idev);
>>  
>>  	if (status & AT91_ADC_IER_PEN) {
>> @@ -689,9 +690,10 @@ static int at91_adc_read_raw(struct iio_dev *idev,
>>  	case IIO_CHAN_INFO_RAW:
>>  		mutex_lock(&st->lock);
>>  
>> +		st->chnb = chan->channel;
>>  		at91_adc_writel(st, AT91_ADC_CHER,
>>  				AT91_ADC_CH(chan->channel));
>> -		at91_adc_writel(st, AT91_ADC_IER, st->registers->drdy_mask);
>> +		at91_adc_writel(st, AT91_ADC_IER, BIT(chan->channel));
>>  		at91_adc_writel(st, AT91_ADC_CR, AT91_ADC_START);
>>  
>>  		ret = wait_event_interruptible_timeout(st->wq_data_avail,
>> @@ -708,7 +710,7 @@ static int at91_adc_read_raw(struct iio_dev *idev,
>>  
>>  		at91_adc_writel(st, AT91_ADC_CHDR,
>>  				AT91_ADC_CH(chan->channel));
>> -		at91_adc_writel(st, AT91_ADC_IDR, st->registers->drdy_mask);
>> +		at91_adc_writel(st, AT91_ADC_IDR, BIT(chan->channel));
>>  
>>  		st->last_value = 0;
>>  		st->done = false;
>>
> 
> 
