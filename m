Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f177.google.com ([209.85.128.177]:35022 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750810AbdIJQ0U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 10 Sep 2017 12:26:20 -0400
MIME-Version: 1.0
In-Reply-To: <ffc140c7-3072-870a-3cec-587e8553d1e2@posteo.de>
References: <1504987018-8934-1-git-send-email-harinath922@gmail.com> <ffc140c7-3072-870a-3cec-587e8553d1e2@posteo.de>
From: harinath Nampally <harinath922@gmail.com>
Date: Sun, 10 Sep 2017 12:25:38 -0400
Message-ID: <CAAGUq_rhbdjawYP+DqA3veeN55wUXHCAvUd1GERt-93BV6My-Q@mail.gmail.com>
Subject: Re: [PATCH v6] iio: accel: mma8452: improvements to handle multiple events
To: Martin Kepplinger <martink@posteo.de>
Cc: Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
        lars@metafoo.de, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alison Schofield <amsfield22@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> Alright, I didn't test it but I kind of like it now. The one minor
> naming issue I had pointed out before is mentioned below. But if that's
> no issue for Jon:
> Reviewed-by: Martin Kepplinger <martink@posteo.de>
Martin, Thanks a lot for the review.

> btw, Harianath: Would you point me to the imx6ul eval board you are
> using? thanks
https://www.nxp.com/products/microcontrollers-and-processors/arm-based-processors-and-mcus/i.mx-applications-processors/developer-resources/i.mx6ultralite-evaluation-kit:MCIMX6UL-EVK

> > @@ -740,6 +762,36 @@ static int mma8452_write_raw(struct iio_dev *indio_dev,
> >       return ret;
> >  }
> >
> > +static int mma8452_get_event_regs(struct mma8452_data *data,
> > +             const struct iio_chan_spec *chan, enum iio_event_direction dir,
> > +             const struct mma8452_event_regs **ev_reg)
> > +{
> > +     if (!chan)
> > +             return -EINVAL;
> > +
> > +     switch (chan->type) {
> > +     case IIO_ACCEL:
> > +             switch (dir) {
> > +             case IIO_EV_DIR_RISING:
> > +                     if ((data->chip_info->all_events
> > +                                     & MMA8452_INT_TRANS) &&
> > +                             (data->chip_info->enabled_events
> > +                                     & MMA8452_INT_TRANS))
> > +                             *ev_reg = &ev_regs_accel_rising;
> > +                     else
> > +                             *ev_reg = &ev_regs_accel_falling;
> > +                     return 0;
> I know it's fine, only the naming seems odd here.
I agree, I will replace 'ev_regs_accel_rising' to 'ev_trans_regs'
and 'ev_regs_accel_falling' to 'ev_ff_mt_regs'.
As Jon just applied this patch, I will cover this in my next patch set
which fix the checkpatch.pl warnings in this file.

Thanks,
Hari


On Sun, Sep 10, 2017 at 2:36 AM, Martin Kepplinger <martink@posteo.de> wrote:
>
> On 2017-09-09 21:56, Harinath Nampally wrote:
> >     This driver supports multiple devices like mma8653,
> >     mma8652, mma8452, mma8453 and fxls8471. Almost all
> >     these devices have more than one event.
> >
> >     Current driver design hardcodes the event specific
> >     information, so only one event can be supported by this
> >     driver at any given time.
> >     Also current design doesn't have the flexibility to
> >     add more events.
> >
> >     This patch improves by detaching the event related
> >     information from chip_info struct,and based on channel
> >     type and event direction the corresponding event
> >     configuration registers are picked dynamically.
> >     Hence both transient and freefall events can be
> >     handled in read/write callbacks.
> >
> >     Changes are thoroughly tested on fxls8471 device on imx6UL
> >     Eval board using iio_event_monitor user space program.
> >
> >     After this fix both Freefall and Transient events are
> >     handled by the driver without any conflicts.
> >
> >     Changes since v5 -> v6
> >     -Rename supported_events to all_events(short name)
> >     -Use get_event_regs function in read/write event
> >      config callbacks to pick appropriate config registers
> >     -Add ev_cfg_ele and ev_cfg_chan_shift in event_regs struct
> >      which are needed in read/write event callbacks
> >
> >     Changes since v4 -> v5
> >     -Add supported_events and enabled_events
> >      in chip_info structure so that devices(mma865x)
> >      which has no support for transient event will
> >      fallback to freefall event. Hence this patch changes
> >      won't break for devices that can't support
> >      transient events
> >
> >     Changes since v3 -> v4
> >     -Add 'const struct ev_regs_accel_falling'
> >     -Add 'const struct ev_regs_accel_rising'
> >     -Refactor mma8452_get_event_regs function to
> >      remove the fill in the struct and return above structs
> >     -Condense the commit's subject message
> >
> >     Changes since v2 -> v3
> >     -Fix typo in commit message
> >     -Replace word 'Bugfix' with 'Improvements'
> >     -Describe more accurate commit message
> >     -Replace breaks with returns
> >     -Initialise transient event threshold mask
> >     -Remove unrelated change of IIO_ACCEL channel type
> >      check in read/write event callbacks
> >
> >     Changes since v1 -> v2
> >     -Fix indentations
> >     -Remove unused fields in mma8452_event_regs struct
> >     -Remove redundant return statement
> >     -Remove unrelated changes like checkpatch.pl warning fixes
> >
> > Signed-off-by: Harinath Nampally <harinath922@gmail.com>
> > ---
>
> Alright, I didn't test it but I kind of like it now. The one minor
> naming issue I had pointed out before is mentioned below. But if that's
> no issue for Jon:
>
> Reviewed-by: Martin Kepplinger <martink@posteo.de>
>
>
> btw, Harianath: Would you point me to the imx6ul eval board you are
> using? thanks
>
> > @@ -740,6 +762,36 @@ static int mma8452_write_raw(struct iio_dev *indio_dev,
> >       return ret;
> >  }
> >
> > +static int mma8452_get_event_regs(struct mma8452_data *data,
> > +             const struct iio_chan_spec *chan, enum iio_event_direction dir,
> > +             const struct mma8452_event_regs **ev_reg)
> > +{
> > +     if (!chan)
> > +             return -EINVAL;
> > +
> > +     switch (chan->type) {
> > +     case IIO_ACCEL:
> > +             switch (dir) {
> > +             case IIO_EV_DIR_RISING:
> > +                     if ((data->chip_info->all_events
> > +                                     & MMA8452_INT_TRANS) &&
> > +                             (data->chip_info->enabled_events
> > +                                     & MMA8452_INT_TRANS))
> > +                             *ev_reg = &ev_regs_accel_rising;
> > +                     else
> > +                             *ev_reg = &ev_regs_accel_falling;
> > +                     return 0;
>
> I know it's fine, only the naming seems odd here.
>
> > +             case IIO_EV_DIR_FALLING:
> > +                     *ev_reg = &ev_regs_accel_falling;
> > +                     return 0;
> > +             default:
> > +                     return -EINVAL;
> > +             }
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
