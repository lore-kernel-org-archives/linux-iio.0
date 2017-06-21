Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751028AbdFUTun (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 21 Jun 2017 15:50:43 -0400
Date: Wed, 21 Jun 2017 20:50:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: light: tsl2563: use correct event code
Message-ID: <20170621205039.5872f8c3@kernel.org>
In-Reply-To: <1497977197-19157-1-git-send-email-akinobu.mita@gmail.com>
References: <1497977197-19157-1-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 21 Jun 2017 01:46:37 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> The TSL2563 driver provides three iio channels, two of which are raw ADC
> channels (channel 0 and channel 1) in the device and the remaining one
> is calculated by the two.  The ADC channel 0 only supports programmable
> interrupt with threshold settings and this driver supports the event but
> the generated event code does not contain the corresponding iio channel
> type.
> 
> Cc: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Hmm. Patch is clearly correct, but this has been broken for a
long time.  I worry slightly that we may have userspace
code depending on the broken format.

If any of that does turn up, we may have to emit both the
write event code and the wrong one.  Guess we'll wait and see
what happens.

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan
> ---
>  drivers/iio/light/tsl2563.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
> index e7d4ea7..7599693 100644
> --- a/drivers/iio/light/tsl2563.c
> +++ b/drivers/iio/light/tsl2563.c
> @@ -626,7 +626,7 @@ static irqreturn_t tsl2563_event_handler(int irq, void *private)
>  	struct tsl2563_chip *chip = iio_priv(dev_info);
>  
>  	iio_push_event(dev_info,
> -		       IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
> +		       IIO_UNMOD_EVENT_CODE(IIO_INTENSITY,
>  					    0,
>  					    IIO_EV_TYPE_THRESH,
>  					    IIO_EV_DIR_EITHER),

