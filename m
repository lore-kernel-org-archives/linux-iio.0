Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:54283 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755226AbaIOVhN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 15 Sep 2014 17:37:13 -0400
Message-ID: <54175C04.70302@gmx.de>
Date: Mon, 15 Sep 2014 23:37:08 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Chris Ruffin <cmruffin@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging: iio: accel: remove unnecessary syntax
References: <1410737937-10773-1-git-send-email-cmruffin@gmail.com>
In-Reply-To: <1410737937-10773-1-git-send-email-cmruffin@gmail.com>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Chris Ruffin schrieb, Am 15.09.2014 01:38:
> The else clause in the conditional of lis3l02dq_data_rdy_trig_poll()
> does not make consistent use of braces with the rest of the
> conditional.  Fix this coding style problem by removing the
> unnecessary conditional altogether.
> 
> Signed-off-by: Chris Ruffin <cmruffin@gmail.com>
Acked-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
>  drivers/staging/iio/accel/lis3l02dq_ring.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
> index 1d934ee..9efc77b 100644
> --- a/drivers/staging/iio/accel/lis3l02dq_ring.c
> +++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
> @@ -34,8 +34,9 @@ irqreturn_t lis3l02dq_data_rdy_trig_poll(int irq, void *private)
>  	if (st->trigger_on) {
>  		iio_trigger_poll(st->trig);
>  		return IRQ_HANDLED;
> -	} else
> -		return IRQ_WAKE_THREAD;
> +	}
> +
> +	return IRQ_WAKE_THREAD;
>  }
>  
>  static const u8 read_all_tx_array[] = {
> 

