Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56096 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188Ab2GCTrT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 3 Jul 2012 15:47:19 -0400
Message-ID: <4FF34C46.5000503@kernel.org>
Date: Tue, 03 Jul 2012 20:47:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: fix spelling of detach in static func
References: <1341265427-1647-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1341265427-1647-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/02/2012 10:43 PM, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
oops.  merged. Thanks.
> ---
>  drivers/iio/industrialio-trigger.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index ec653fb..2ef36d1 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -234,7 +234,7 @@ static int iio_trigger_attach_poll_func(struct iio_trigger *trig,
>  	return ret;
>  }
>  
> -static int iio_trigger_dettach_poll_func(struct iio_trigger *trig,
> +static int iio_trigger_detach_poll_func(struct iio_trigger *trig,
>  					 struct iio_poll_func *pf)
>  {
>  	int ret = 0;
> @@ -502,7 +502,7 @@ EXPORT_SYMBOL(iio_triggered_buffer_postenable);
>  
>  int iio_triggered_buffer_predisable(struct iio_dev *indio_dev)
>  {
> -	return iio_trigger_dettach_poll_func(indio_dev->trig,
> +	return iio_trigger_detach_poll_func(indio_dev->trig,
>  					     indio_dev->pollfunc);
>  }
>  EXPORT_SYMBOL(iio_triggered_buffer_predisable);
> 


