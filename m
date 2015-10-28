Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f194.google.com ([209.85.212.194]:33843 "EHLO
	mail-wi0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932384AbbJ1I0G (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 28 Oct 2015 04:26:06 -0400
Received: by wicuk10 with SMTP id uk10so581460wic.1
        for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2015 01:26:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1445971256-22474-1-git-send-email-ciorneiioana@gmail.com>
References: <1445971256-22474-1-git-send-email-ciorneiioana@gmail.com>
Date: Wed, 28 Oct 2015 10:26:04 +0200
Message-ID: <CAEnQRZBPcDapgGvjoZpHqCVstCch5b0aFoFi1stFKRomFM6u+A@mail.gmail.com>
Subject: Re: [Outreachy kernel] [PATCH] staging: iio: dummy: complete IIO
 events delivery to userspace
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Ioana Ciornei <ciorneiioana@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: outreachy-kernel <outreachy-kernel@googlegroups.com>,
	Cristina Georgiana Opriceana <cristina.opriceana@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Oct 27, 2015 at 8:40 PM, Ioana Ciornei <ciorneiioana@gmail.com> wrote:
> Starting with commit fd2bb310ca (Staging: iio: Move evgen interrupt
> generation to irq_work) event processing is handled by calling
> both the top half and the threaded part properly simulating real
> hardware interrupts making use of threaded interrupts.
> This way the processing is split in 2 parts:
>
> * the IRQ handler that runs in IRQ context and only saves the event
> timestamp
> * the threaded handler that runs in process context, reads the events
> and pushes the in the userspace.
>
> If the IRQ handler returns IRQ_HANDLED the threaded handler is not
> even being called since the interrupt is considered to be processed.
> Because the iio dummy driver processes the events in the threaded
> handler the IRQ handler must return IRQ_WAKE_THREAD so that the
> threaded part would be awakened and called.
>
> Signed-off-by: Ioana Ciornei <ciorneiioana@gmail.com>

Fixes: fd2bb310ca ("Staging: iio: Move evgen interrupt generation to irq_work")
Acked-by: Daniel Baluta <daniel.baluta@intel.com>

> ---
> rebased on linux-iio tree
>
>  drivers/iio/dummy/iio_simple_dummy_events.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/dummy/iio_simple_dummy_events.c b/drivers/iio/dummy/iio_simple_dummy_events.c
> index bfbf1c5..6eb600f 100644
> --- a/drivers/iio/dummy/iio_simple_dummy_events.c
> +++ b/drivers/iio/dummy/iio_simple_dummy_events.c
> @@ -159,7 +159,7 @@ static irqreturn_t iio_simple_dummy_get_timestamp(int irq, void *private)
>         struct iio_dummy_state *st = iio_priv(indio_dev);
>
>         st->event_timestamp = iio_get_time_ns();
> -       return IRQ_HANDLED;
> +       return IRQ_WAKE_THREAD;
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/1445971256-22474-1-git-send-email-ciorneiioana%40gmail.com.
> For more options, visit https://groups.google.com/d/optout.
