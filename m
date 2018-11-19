Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39759 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbeKSTIg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Nov 2018 14:08:36 -0500
Received: by mail-ed1-f66.google.com with SMTP id b14so22090345edt.6
        for <linux-iio@vger.kernel.org>; Mon, 19 Nov 2018 00:45:38 -0800 (PST)
MIME-Version: 1.0
References: <20181119005347.747-1-martin@martingkelly.com>
In-Reply-To: <20181119005347.747-1-martin@martingkelly.com>
From: Daniel Baluta <daniel.baluta@intel.com>
Date: Mon, 19 Nov 2018 10:45:26 +0200
Message-ID: <CAEnQRZDYRnQc3Ja5+Jp4TCLZWShx-jC4V8MOoKnk1dA_1qV46w@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: bmi160: snap timestamp closer to event
To: martin@martingkelly.com
Cc: linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Nov 19, 2018 at 2:54 AM Martin Kelly <martin@martingkelly.com> wrote:
>
> From: Martin Kelly <martin@martingkelly.com>
>
> Currently, we snap the timestamp after reading from the buffer and
> processing the event. Technically, we can get a slightly more accurate
> timestamp by snapping it prior to reading the data, since the data was
> already generated prior to entering the trigger handler. This is not going
> to make a huge difference, but we might as well improve slightly.
>
> Signed-off-by: Martin Kelly <martin@martingkelly.com>

Makes sense to me.

Acked-by: Daniel Baluta <daniel.baluta@gmail.com>

Would be nice to see some datapoints and compare the differences.

> ---
>  drivers/iio/imu/bmi160/bmi160_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
> index c85659ca9507..4d9d59d9e3a9 100644
> --- a/drivers/iio/imu/bmi160/bmi160_core.c
> +++ b/drivers/iio/imu/bmi160/bmi160_core.c
> @@ -384,6 +384,7 @@ static irqreturn_t bmi160_trigger_handler(int irq, void *p)
>  {
>         struct iio_poll_func *pf = p;
>         struct iio_dev *indio_dev = pf->indio_dev;
> +       s64 ts = iio_get_time_ns(indio_dev);
>         struct bmi160_data *data = iio_priv(indio_dev);
>         __le16 buf[16];
>         /* 3 sens x 3 axis x __le16 + 3 x __le16 pad + 4 x __le16 tstamp */
> @@ -399,8 +400,7 @@ static irqreturn_t bmi160_trigger_handler(int irq, void *p)
>                 buf[j++] = sample;
>         }
>
> -       iio_push_to_buffers_with_timestamp(indio_dev, buf,
> -                                          iio_get_time_ns(indio_dev));
> +       iio_push_to_buffers_with_timestamp(indio_dev, buf, ts);
>  done:
>         iio_trigger_notify_done(indio_dev->trig);
>         return IRQ_HANDLED;
> --
> 2.11.0
>
