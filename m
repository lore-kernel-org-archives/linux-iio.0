Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42101 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930AbcHORCq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Aug 2016 13:02:46 -0400
Subject: Re: [PATCH 2/2] iio: sx9500: Use complete() instead of complete_all()
To: Daniel Wagner <wagi@monom.org>
References: <1470316030-4153-1-git-send-email-wagi@monom.org>
 <1470316030-4153-3-git-send-email-wagi@monom.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <1bb9998e-405a-753a-e9ef-415451235102@kernel.org>
Date: Mon, 15 Aug 2016 18:02:45 +0100
MIME-Version: 1.0
In-Reply-To: <1470316030-4153-3-git-send-email-wagi@monom.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/08/16 14:07, Daniel Wagner wrote:
> From: Daniel Wagner <daniel.wagner@bmw-carit.de>
> 
> There is only one waiter for the completion, therefore there
> is no need to use complete_all(). Let's make that clear by
> using complete() instead of complete_all().
> 
> The usage pattern of the completion is:
> 
> waiter context                          waker context
> 
> sx9500_read_proximity()
>   sx9500_inc_chan_users()
>   sx9500_inc_data_rdy_users()
>   wait_for_completion_interruptible()
> 
>                                         s9500_irq_thread_handler()
>                                           complete()
> 
>   reinit_completion()
> 
> Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
Applied to the togreg branch of iio.git - initially pushed
out as testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/proximity/sx9500.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
> index 1d74b3a..6f84f53 100644
> --- a/drivers/iio/proximity/sx9500.c
> +++ b/drivers/iio/proximity/sx9500.c
> @@ -516,7 +516,7 @@ static irqreturn_t sx9500_irq_thread_handler(int irq, void *private)
>  		sx9500_push_events(indio_dev);
>  
>  	if (val & SX9500_CONVDONE_IRQ)
> -		complete_all(&data->completion);
> +		complete(&data->completion);
>  
>  out:
>  	mutex_unlock(&data->mutex);
> 

