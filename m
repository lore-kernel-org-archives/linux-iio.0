Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750806AbdKSL2X (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Nov 2017 06:28:23 -0500
Date: Sun, 19 Nov 2017 11:28:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: <nicolas.ferre@microchip.com>,
        <alexandre.belloni@free-electrons.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ludovic.desroches@microchip.com>
Subject: Re: [PATCH v3 4/4] iio: adc: at91-sama5d2_adc: ack DRDY irq in
 direct mode
Message-ID: <20171119112819.5d128c3f@archlinux>
In-Reply-To: <1510750608-8697-5-git-send-email-eugen.hristev@microchip.com>
References: <1510750608-8697-1-git-send-email-eugen.hristev@microchip.com>
        <1510750608-8697-5-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 15 Nov 2017 14:56:48 +0200
Eugen Hristev <eugen.hristev@microchip.com> wrote:

> Need to acknowledge DRDY irq in direct mode/ software
> triggered mode. Otherwise, on the next conversion, overrun
> flag will be raised, which is not a correct state.
> This doesn't affect the functionality, but will generate
> possible incorrect overrun reports.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

Applied. Thanks.
> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index 11d34a8..274cb5e 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -787,6 +787,9 @@ static int at91_adc_read_raw(struct iio_dev *indio_dev,
>  		at91_adc_writel(st, AT91_SAMA5D2_IDR, BIT(chan->channel));
>  		at91_adc_writel(st, AT91_SAMA5D2_CHDR, BIT(chan->channel));
>  
> +		/* Needed to ACK the DRDY interruption */
> +		at91_adc_readl(st, AT91_SAMA5D2_LCDR);
> +
>  		mutex_unlock(&st->lock);
>  
>  		iio_device_release_direct_mode(indio_dev);

