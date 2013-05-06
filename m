Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42641 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417Ab3EFQaZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 6 May 2013 12:30:25 -0400
Message-ID: <5187DAA1.50503@kernel.org>
Date: Mon, 06 May 2013 17:30:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shawn Guo <shawn.guo@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] staging/iio/mxs-lradc: fix preenable for multiple
 buffers
References: <6bb527db65fb20f60bb95814bff3abc513733a7c.1367671597.git.mirq-linux@rere.qmqm.pl> <ba60ca91ef1d3061b454e518f6026a1157fae5d7.1367671597.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <ba60ca91ef1d3061b454e518f6026a1157fae5d7.1367671597.git.mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/04/2013 02:19 PM, Michał Mirosław wrote:
> This fixes 'preenable failed: -EINVAL' error when using this driver.
> 
For future patches, please cleanly separate out (in a different series)
the bug fixes from the cleanups.  This one has been applied to the
fixes-togreg branch of iio.git wherease the first patch will go
through the togreg branch and hit one kernel cycle later.

Applied to the fixes-togreg
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/staging/iio/adc/mxs-lradc.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
> index 03299ea..d92c97a 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -690,7 +690,6 @@ static void mxs_lradc_trigger_remove(struct iio_dev *iio)
>  static int mxs_lradc_buffer_preenable(struct iio_dev *iio)
>  {
>  	struct mxs_lradc *lradc = iio_priv(iio);
> -	struct iio_buffer *buffer = iio->buffer;
>  	int ret = 0, chan, ofs = 0;
>  	unsigned long enable = 0;
>  	uint32_t ctrl4_set = 0;
> @@ -698,7 +697,7 @@ static int mxs_lradc_buffer_preenable(struct iio_dev *iio)
>  	uint32_t ctrl1_irq = 0;
>  	const uint32_t chan_value = LRADC_CH_ACCUMULATE |
>  		((LRADC_DELAY_TIMER_LOOP - 1) << LRADC_CH_NUM_SAMPLES_OFFSET);
> -	const int len = bitmap_weight(buffer->scan_mask, LRADC_MAX_TOTAL_CHANS);
> +	const int len = bitmap_weight(iio->active_scan_mask, LRADC_MAX_TOTAL_CHANS);
>  
>  	if (!len)
>  		return -EINVAL;
> @@ -725,7 +724,7 @@ static int mxs_lradc_buffer_preenable(struct iio_dev *iio)
>  		lradc->base + LRADC_CTRL1 + STMP_OFFSET_REG_CLR);
>  	writel(0xff, lradc->base + LRADC_CTRL0 + STMP_OFFSET_REG_CLR);
>  
> -	for_each_set_bit(chan, buffer->scan_mask, LRADC_MAX_TOTAL_CHANS) {
> +	for_each_set_bit(chan, iio->active_scan_mask, LRADC_MAX_TOTAL_CHANS) {
>  		ctrl4_set |= chan << LRADC_CTRL4_LRADCSELECT_OFFSET(ofs);
>  		ctrl4_clr |= LRADC_CTRL4_LRADCSELECT_MASK(ofs);
>  		ctrl1_irq |= LRADC_CTRL1_LRADC_IRQ_EN(ofs);
> 
