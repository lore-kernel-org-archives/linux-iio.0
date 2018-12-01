Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbeLBCLD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Dec 2018 21:11:03 -0500
Date: Sat, 1 Dec 2018 14:58:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Kelly <martin@martingkelly.com>
Cc: linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@intel.com>
Subject: Re: [PATCH 1/2] iio: bmi160: snap timestamp closer to event
Message-ID: <20181201145818.1653ef17@archlinux>
In-Reply-To: <c6376fbc-2678-5def-c167-75fec52f15d2@martingkelly.com>
References: <20181119005347.747-1-martin@martingkelly.com>
        <20181125135959.1b36ac18@archlinux>
        <c6376fbc-2678-5def-c167-75fec52f15d2@martingkelly.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 26 Nov 2018 15:43:37 -0800
Martin Kelly <martin@martingkelly.com> wrote:

> On 11/25/18 5:59 AM, Jonathan Cameron wrote:
> > On Sun, 18 Nov 2018 16:53:46 -0800
> > Martin Kelly <martin@martingkelly.com> wrote:
> >   
> >> From: Martin Kelly <martin@martingkelly.com>
> >>
> >> Currently, we snap the timestamp after reading from the buffer and
> >> processing the event. Technically, we can get a slightly more accurate
> >> timestamp by snapping it prior to reading the data, since the data was
> >> already generated prior to entering the trigger handler. This is not going
> >> to make a huge difference, but we might as well improve slightly.
> >>
> >> Signed-off-by: Martin Kelly <martin@martingkelly.com>  
> > Now this is always an interesting one.   We are running that handler
> > off the back of a trigger that isn't a dataready signal.  As such
> > the start of the function doesn't necessarily correspond to the
> > time that is closest to when the data is captured, it corresponds
> > to the time that is closest to when we asked for it (which is
> > not the most relevant number when processing the data)
> > 
> > Now, here we are talking on either side of the actual hardware
> > reads, so my suspicion is that it'll be just as inaccurate, but
> > in the other direction.
> > 
> > Also note that the compiler is probably within it's rights to
> > reorder that entirely if it can tell there are no side effects
> > (which it probably can't here... so this change will actually
> > do what you intend.)
> > 
> > So upshot is I'm currently unconvinced either way on whether this
> > is a useful change or not!
> > 
> > Jonathan
> >   
> 
> Yes, you are right that in the current driver, it's rather fuzzy when 
> the "correct" timestamp to snap is. Separately, I'm working on adding 
> interrupt support to this driver, so perhaps I should queue this up 
> after that change. With interrupts (based on a data ready signal), I 
> believe this change will be correct.

Agreed.  That is the time to make this change as then it'll be obvious
why.

Thanks,

Jonathan

> 
> >   
> >> ---
> >>   drivers/iio/imu/bmi160/bmi160_core.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
> >> index c85659ca9507..4d9d59d9e3a9 100644
> >> --- a/drivers/iio/imu/bmi160/bmi160_core.c
> >> +++ b/drivers/iio/imu/bmi160/bmi160_core.c
> >> @@ -384,6 +384,7 @@ static irqreturn_t bmi160_trigger_handler(int irq, void *p)
> >>   {
> >>   	struct iio_poll_func *pf = p;
> >>   	struct iio_dev *indio_dev = pf->indio_dev;
> >> +	s64 ts = iio_get_time_ns(indio_dev);
> >>   	struct bmi160_data *data = iio_priv(indio_dev);
> >>   	__le16 buf[16];
> >>   	/* 3 sens x 3 axis x __le16 + 3 x __le16 pad + 4 x __le16 tstamp */
> >> @@ -399,8 +400,7 @@ static irqreturn_t bmi160_trigger_handler(int irq, void *p)
> >>   		buf[j++] = sample;
> >>   	}
> >>   
> >> -	iio_push_to_buffers_with_timestamp(indio_dev, buf,
> >> -					   iio_get_time_ns(indio_dev));
> >> +	iio_push_to_buffers_with_timestamp(indio_dev, buf, ts);
> >>   done:
> >>   	iio_trigger_notify_done(indio_dev->trig);
> >>   	return IRQ_HANDLED;  
> >   
> 
