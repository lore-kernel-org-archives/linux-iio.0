Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:27531 "EHLO
	mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932274AbbJ0P3A (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 27 Oct 2015 11:29:00 -0400
Date: Tue, 27 Oct 2015 16:28:41 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Ioana Ciornei <ciorneiioana@gmail.com>
cc: outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: iio: change IRQ_HANDLED to
 IRQ_WAKE_THREAD
In-Reply-To: <1445959587-25953-1-git-send-email-ciorneiioana@gmail.com>
Message-ID: <alpine.DEB.2.10.1510271627540.2370@hadrien>
References: <1445959587-25953-1-git-send-email-ciorneiioana@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 27 Oct 2015, Ioana Ciornei wrote:

> This patch changes the return value of the primary interrupt handler to
> IRQ_WAKE_THREAD in order to wake the kernel thread represented by the
> iio_simple_dummy_event_handler function and continue handling the event.

Can you give some more justification about why that is the right thing to
do?  Is it for example what other IIO drivers do in this situation?

julia

> Signed-off-by: Ioana Ciornei <ciorneiioana@gmail.com>
> ---
>  drivers/staging/iio/iio_simple_dummy_events.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/iio/iio_simple_dummy_events.c b/drivers/staging/iio/iio_simple_dummy_events.c
> index bfbf1c5..6eb600f 100644
> --- a/drivers/staging/iio/iio_simple_dummy_events.c
> +++ b/drivers/staging/iio/iio_simple_dummy_events.c
> @@ -159,7 +159,7 @@ static irqreturn_t iio_simple_dummy_get_timestamp(int irq, void *private)
>  	struct iio_dummy_state *st = iio_priv(indio_dev);
>
>  	st->event_timestamp = iio_get_time_ns();
> -	return IRQ_HANDLED;
> +	return IRQ_WAKE_THREAD;
>  }
>
>  /**
> --
> 2.1.4
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/1445959587-25953-1-git-send-email-ciorneiioana%40gmail.com.
> For more options, visit https://groups.google.com/d/optout.
>
