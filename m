Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752875AbeAFMua (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Jan 2018 07:50:30 -0500
Date: Sat, 6 Jan 2018 12:50:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: adc: stm32: fix scan of multiple channels with DMA
Message-ID: <20180106125025.76ac5235@archlinux>
In-Reply-To: <1515162894-11637-1-git-send-email-fabrice.gasnier@st.com>
References: <1515162894-11637-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 5 Jan 2018 15:34:54 +0100
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> By default, watermark is set to '1'. Watermark is used to fine tune
> cyclic dma buffer period. In case watermark is left untouched (e.g. 1)
> and several channels are being scanned, buffer period is wrongly set
> (e.g. to 1 sample). As a consequence, data is never pushed to upper layer.
> Fix buffer period size, by taking scan channels number into account.
> 
> Fixes: 2763ea0585c9 ("iio: adc: stm32: add optional dma support")
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>

Given where we are in the cycle I've applied this to the togreg
branch for the next merge window and marked it for stable.

This is probably the quickest way to get it in at this stage.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/stm32-adc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index c9d96f9..cecf1e5 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -1315,6 +1315,7 @@ static int stm32_adc_set_watermark(struct iio_dev *indio_dev, unsigned int val)
>  {
>  	struct stm32_adc *adc = iio_priv(indio_dev);
>  	unsigned int watermark = STM32_DMA_BUFFER_SIZE / 2;
> +	unsigned int rx_buf_sz = STM32_DMA_BUFFER_SIZE;
>  
>  	/*
>  	 * dma cyclic transfers are used, buffer is split into two periods.
> @@ -1323,7 +1324,7 @@ static int stm32_adc_set_watermark(struct iio_dev *indio_dev, unsigned int val)
>  	 * - one buffer (period) driver can push with iio_trigger_poll().
>  	 */
>  	watermark = min(watermark, val * (unsigned)(sizeof(u16)));
> -	adc->rx_buf_sz = watermark * 2;
> +	adc->rx_buf_sz = min(rx_buf_sz, watermark * 2 * adc->num_conv);
>  
>  	return 0;
>  }

