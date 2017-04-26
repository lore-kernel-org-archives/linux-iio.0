Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58290 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1950815AbdDZGHI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Apr 2017 02:07:08 -0400
Subject: Re: [PATCH] iio: proximity: as3935: recalibrate RCO after resume
To: Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-iio@vger.kernel.org
Cc: George McCollister <george.mccollister@gmail.com>
References: <20170414233819.8259-1-matt.ranostay@konsulko.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <57904b64-f2be-e59d-8967-e1f3700da870@kernel.org>
Date: Wed, 26 Apr 2017 07:06:59 +0100
MIME-Version: 1.0
In-Reply-To: <20170414233819.8259-1-matt.ranostay@konsulko.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/04/17 00:38, Matt Ranostay wrote:
> According to the datasheet the RCO must be recalibrated
> on every power-on-reset. Also remove mutex locking in the
> calibration function since callers other than the probe
> function (which doesn't need it) will have a lock.
> 
> Fixes: 24ddb0e4bba4 ("iio: Add AS3935 lightning sensor support")
> Cc: George McCollister <george.mccollister@gmail.com>
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan
> ---
>  drivers/iio/proximity/as3935.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
> index ddf9bee89f77..d0f5e53aad59 100644
> --- a/drivers/iio/proximity/as3935.c
> +++ b/drivers/iio/proximity/as3935.c
> @@ -269,8 +269,6 @@ static irqreturn_t as3935_interrupt_handler(int irq, void *private)
>  
>  static void calibrate_as3935(struct as3935_state *st)
>  {
> -	mutex_lock(&st->lock);
> -
>  	/* mask disturber interrupt bit */
>  	as3935_write(st, AS3935_INT, BIT(5));
>  
> @@ -280,8 +278,6 @@ static void calibrate_as3935(struct as3935_state *st)
>  
>  	mdelay(2);
>  	as3935_write(st, AS3935_TUNE_CAP, (st->tune_cap / TUNE_CAP_DIV));
> -
> -	mutex_unlock(&st->lock);
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> @@ -318,6 +314,8 @@ static int as3935_resume(struct device *dev)
>  	val &= ~AS3935_AFE_PWR_BIT;
>  	ret = as3935_write(st, AS3935_AFE_GAIN, val);
>  
> +	calibrate_as3935(st);
> +
>  err_resume:
>  	mutex_unlock(&st->lock);
>  
> 

