Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45680 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934Ab2JMJmZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 13 Oct 2012 05:42:25 -0400
Message-ID: <50793781.4030007@kernel.org>
Date: Sat, 13 Oct 2012 10:42:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging iio: use iio_trigger_generic_data_rdy_poll()
 in accel/adis16209,adis16240 driver
References: <1350115595-7107-1-git-send-email-pmeerw@pmeerw.net> <1350115595-7107-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1350115595-7107-3-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/13/2012 09:06 AM, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
added to togreg branch of iio.git
> ---
>  drivers/staging/iio/accel/adis16209_trigger.c |   11 +----------
>  drivers/staging/iio/accel/adis16240_trigger.c |   11 +----------
>  2 files changed, 2 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16209_trigger.c b/drivers/staging/iio/accel/adis16209_trigger.c
> index 2ad93dc..1122803 100644
> --- a/drivers/staging/iio/accel/adis16209_trigger.c
> +++ b/drivers/staging/iio/accel/adis16209_trigger.c
> @@ -8,15 +8,6 @@
>  #include "adis16209.h"
>  
>  /**
> - * adis16209_data_rdy_trig_poll() the event handler for the data rdy trig
> - **/
> -static irqreturn_t adis16209_data_rdy_trig_poll(int irq, void *trig)
> -{
> -	iio_trigger_poll(trig, iio_get_time_ns());
> -	return IRQ_HANDLED;
> -}
> -
> -/**
>   * adis16209_data_rdy_trigger_set_state() set datardy interrupt state
>   **/
>  static int adis16209_data_rdy_trigger_set_state(struct iio_trigger *trig,
> @@ -45,7 +36,7 @@ int adis16209_probe_trigger(struct iio_dev *indio_dev)
>  	}
>  
>  	ret = request_irq(st->us->irq,
> -			  adis16209_data_rdy_trig_poll,
> +			  iio_trigger_generic_data_rdy_poll,
>  			  IRQF_TRIGGER_RISING,
>  			  "adis16209",
>  			  st->trig);
> diff --git a/drivers/staging/iio/accel/adis16240_trigger.c b/drivers/staging/iio/accel/adis16240_trigger.c
> index fa90a22..f3caf09 100644
> --- a/drivers/staging/iio/accel/adis16240_trigger.c
> +++ b/drivers/staging/iio/accel/adis16240_trigger.c
> @@ -8,15 +8,6 @@
>  #include "adis16240.h"
>  
>  /**
> - * adis16240_data_rdy_trig_poll() the event handler for the data rdy trig
> - **/
> -static irqreturn_t adis16240_data_rdy_trig_poll(int irq, void *trig)
> -{
> -	iio_trigger_poll(trig, iio_get_time_ns());
> -	return IRQ_HANDLED;
> -}
> -
> -/**
>   * adis16240_data_rdy_trigger_set_state() set datardy interrupt state
>   **/
>  static int adis16240_data_rdy_trigger_set_state(struct iio_trigger *trig,
> @@ -45,7 +36,7 @@ int adis16240_probe_trigger(struct iio_dev *indio_dev)
>  	}
>  
>  	ret = request_irq(st->us->irq,
> -			  adis16240_data_rdy_trig_poll,
> +			  iio_trigger_generic_data_rdy_poll,
>  			  IRQF_TRIGGER_RISING,
>  			  "adis16240",
>  			  st->trig);
> 
