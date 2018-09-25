Return-Path: <SRS0=JomU=MH=microchip.com=Ludovic.Desroches@kernel.org>
Date: Tue, 25 Sep 2018 15:17:57 +0200
From: Ludovic Desroches <ludovic.desroches@microchip.com>
To: Eugen Hristev <eugen.hristev@microchip.com>
CC: <jic23@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<nicolas.ferre@microchip.com>, Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v2 2/2] iio: adc: at91: fix wrong channel number in
 triggered buffer mode
Message-ID: <20180925131757.gjk2t277twhji5ns@M43218.corp.atmel.com>
References: <1537775504-7981-1-git-send-email-eugen.hristev@microchip.com>
 <1537775504-7981-2-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1537775504-7981-2-git-send-email-eugen.hristev@microchip.com>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Sep 24, 2018 at 10:51:44AM +0300, Eugen Hristev wrote:
> When channels are registered, the hardware channel number is not the
> actual iio channel number.
> This is because the driver is probed with a certain number of accessible
> channels. Some pins are routed and some not, depending on the description of
> the board in the DT.
> Because of that, channels 0,1,2,3 can correspond to hardware channels
> 2,3,4,5 for example.
> In the buffered triggered case, we need to do the translation accordingly.
> Fixed the channel number to stop reading the wrong channel.
> 
> Fixes 0e589d5fb "ARM: AT91: IIO: Add AT91 ADC driver."
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

> ---
> Changes in v2:
> - Added 'const' spec to the declaration to avoid build warning
> 
>  drivers/iio/adc/at91_adc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index e3be88e..75d2f73 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -248,12 +248,14 @@ static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *idev = pf->indio_dev;
>  	struct at91_adc_state *st = iio_priv(idev);
> +	struct iio_chan_spec const *chan;
>  	int i, j = 0;
>  
>  	for (i = 0; i < idev->masklength; i++) {
>  		if (!test_bit(i, idev->active_scan_mask))
>  			continue;
> -		st->buffer[j] = at91_adc_readl(st, AT91_ADC_CHAN(st, i));
> +		chan = idev->channels + i;
> +		st->buffer[j] = at91_adc_readl(st, AT91_ADC_CHAN(st, chan->channel));
>  		j++;
>  	}
>  
> -- 
> 2.7.4
> 
