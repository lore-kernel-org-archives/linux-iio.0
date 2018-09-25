Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:32620 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbeIYTZM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Sep 2018 15:25:12 -0400
Date: Tue, 25 Sep 2018 15:17:39 +0200
From: Ludovic Desroches <ludovic.desroches@microchip.com>
To: Eugen Hristev <eugen.hristev@microchip.com>
CC: <jic23@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <nicolas.ferre@microchip.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v2 1/2] iio: adc: at91: fix acking DRDY irq on simple
 conversions
Message-ID: <20180925131739.2nuoelhqmkszamqo@M43218.corp.atmel.com>
References: <1537775504-7981-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1537775504-7981-1-git-send-email-eugen.hristev@microchip.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Sep 24, 2018 at 10:51:43AM +0300, Eugen Hristev wrote:
> When doing simple conversions, the driver did not acknowledge the DRDY irq.
> If this irq status is not acked, it will be left pending, and as soon as a
> trigger is enabled, the irq handler will be called, it doesn't know why
> this status has occurred because no channel is pending, and then it will go
> int a irq loop and board will hang.
> To avoid this situation, read the LCDR after a raw conversion is done.
> 
> Fixes 0e589d5fb ("ARM: AT91: IIO: Add AT91 ADC driver.")
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com> 

> ---
> Hello Jonathan,
> 
> I moved this LCDR read/acknowledge into the IRQ handler after the conversion
> value is being read.
> Sorry about the noise to stable@vger, removed from message.
> 
> Thanks,
> Eugen
> 
>  drivers/iio/adc/at91_adc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 44b5168..e3be88e 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -279,6 +279,8 @@ static void handle_adc_eoc_trigger(int irq, struct iio_dev *idev)
>  		iio_trigger_poll(idev->trig);
>  	} else {
>  		st->last_value = at91_adc_readl(st, AT91_ADC_CHAN(st, st->chnb));
> +		/* Needed to ACK the DRDY interruption */
> +		at91_adc_readl(st, AT91_ADC_LCDR);
>  		st->done = true;
>  		wake_up_interruptible(&st->wq_data_avail);
>  	}
> -- 
> 2.7.4
> 
