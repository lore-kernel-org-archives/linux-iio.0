Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f195.google.com ([209.85.212.195]:33584 "EHLO
	mail-wi0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964897AbbJ0QMN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 27 Oct 2015 12:12:13 -0400
Received: by wiut4 with SMTP id t4so28595763wiu.0
        for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2015 09:12:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1445959587-25953-1-git-send-email-ciorneiioana@gmail.com>
References: <1445959587-25953-1-git-send-email-ciorneiioana@gmail.com>
Date: Tue, 27 Oct 2015 18:12:12 +0200
Message-ID: <CAEnQRZCEaZ=AW7ka6BWZ5MjBGvMcZuqr=rAcVk3Ga7fKVw_kZQ@mail.gmail.com>
Subject: Re: [Outreachy kernel] [PATCH] staging: iio: change IRQ_HANDLED to IRQ_WAKE_THREAD
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Ioana Ciornei <ciorneiioana@gmail.com>
Cc: outreachy-kernel <outreachy-kernel@googlegroups.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Oct 27, 2015 at 5:26 PM, Ioana Ciornei <ciorneiioana@gmail.com> wrote:
> This patch changes the return value of the primary interrupt handler to
> IRQ_WAKE_THREAD in order to wake the kernel thread represented by the
> iio_simple_dummy_event_handler function and continue handling the event.
>

This is a very good catch! We need to have a better commit message. You
need to describe why the commit is needed.

==
iio: dummy: Complete IIO events delivery to userspace

Since commit fd2bb310ca ("Staging: iio: Move evgen interrupt
generation to irq_work")
event processing is split in two parts using threaded interrupts:

* part 1, IRQ handler - runs in IRQ context and only saves event timestamp.
* part 2, threaded handler, runs in process context, get events and
pushes them to userspace.

When IRQ handler returns IRQ_HANDLED code the interrupt is considered
to be processed
and the threaded handler will not be called. We don't want this for
IIO dummy events driver, since
the events processing takes places in the threaded handler.

Thus, IRQ handler needs to wake up threaded handler by returning IRQ_WAKE_THREAD

Fixes: fd2bb310ca ("Staging: iio: Move evgen interrupt generation to irq_work")
==

Also, because IIO driver was moved out of staging please rebase your
patch on Jonathan's tree:

https://git.kernel.org/cgit/linux/kernel/git/jic23/iio.git/log/?h=testing

use testing branch for this.


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
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/1445959587-25953-1-git-send-email-ciorneiioana%40gmail.com.
> For more options, visit https://groups.google.com/d/optout.
