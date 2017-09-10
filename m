Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751435AbdIJPvm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Sep 2017 11:51:42 -0400
Date: Sun, 10 Sep 2017 16:51:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Kepplinger <martink@posteo.de>
Cc: Harinath Nampally <harinath922@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        amsfield22@gmail.com
Subject: Re: [PATCH v6] iio: accel: mma8452: improvements to handle multiple
 events
Message-ID: <20170910165137.4568b000@archlinux>
In-Reply-To: <ffc140c7-3072-870a-3cec-587e8553d1e2@posteo.de>
References: <1504987018-8934-1-git-send-email-harinath922@gmail.com>
        <ffc140c7-3072-870a-3cec-587e8553d1e2@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 10 Sep 2017 08:36:43 +0200
Martin Kepplinger <martink@posteo.de> wrote:

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
Applied to the togreg branch of iio.git - pushed out as testing to
let the autobuilders play with it.

I stripped the version change stuff from the commit message - they
should have been below the ---  Useful during review, but generally
not worth retaining once we have accepted it.

Thanks,

Jonathan
> 
> btw, Harianath: Would you point me to the imx6ul eval board you are
> using? thanks
> 
> > @@ -740,6 +762,36 @@ static int mma8452_write_raw(struct iio_dev *indio_dev,
> >  	return ret;
> >  }
> >  
> > +static int mma8452_get_event_regs(struct mma8452_data *data,
> > +		const struct iio_chan_spec *chan, enum iio_event_direction dir,
> > +		const struct mma8452_event_regs **ev_reg)
> > +{
> > +	if (!chan)
> > +		return -EINVAL;
> > +
> > +	switch (chan->type) {
> > +	case IIO_ACCEL:
> > +		switch (dir) {
> > +		case IIO_EV_DIR_RISING:
> > +			if ((data->chip_info->all_events
> > +					& MMA8452_INT_TRANS) &&
> > +				(data->chip_info->enabled_events
> > +					& MMA8452_INT_TRANS))
> > +				*ev_reg = &ev_regs_accel_rising;
> > +			else
> > +				*ev_reg = &ev_regs_accel_falling;
> > +			return 0;  
> 
> I know it's fine, only the naming seems odd here.
> 
> > +		case IIO_EV_DIR_FALLING:
> > +			*ev_reg = &ev_regs_accel_falling;
> > +			return 0;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

