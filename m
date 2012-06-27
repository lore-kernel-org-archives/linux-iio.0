Return-Path: <jbe@pengutronix.de>
From: Juergen Beisert <jbe@pengutronix.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: i.MX28 die temperature
Date: Wed, 27 Jun 2012 14:33:15 +0200
Cc: Marek Vasut <marex@denx.de>,
 linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <330B740BA662BF4E8386F534DF556ED819731A@AEDCEXC09.aei.com> <201206271400.11727.marex@denx.de> <4FEAF75E.5090505@cam.ac.uk>
In-Reply-To: <4FEAF75E.5090505@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201206271433.15303.jbe@pengutronix.de>
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

Jonathan Cameron wrote:
> [...]
> >>>>> [...]
> >>>>>
> >>>>>>> Take a look at:
> >>>>>>> http://www.spinics.net/lists/linux-iio/msg04345.html
> >>>>>>
> >>>>>> Any progress here with inclusion in some git tree?
> >>>>>
> >>>>> Well ... I recently raised from the dead. It's on the schedule,
> >>>>> obviously help is welcome.
> >>>>
> >>>> I tried a little bit with your driver. The disadvantage I see is, its
> >>>> claims all the free AD channels. But a few of them can also act as a
> >>>> touchscreen controller. Shouldn't be the driver handle the channel
> >>>> usage dynamically?
> >>>
> >>> I wonder, I'd rather see this driver behave as a composite driver, what
> >>> do you think?
> >>
> >> Alternative (though it's still in development) would be to use IIO
> >> as the ADC layer and sit the other parts on top.
> >
> > I think you need to adjust a few bits there and there in the hardware to
> > behave as a touchscreen. Will IIO be able to handle that somehow ?
>
> No means of doing it yet.  I'm not entirely sure this can be done
> generically. I'm not really familiar enough with touchscreen adcs as
> none of my boards have one.  At worst I'm sure we can put some
> hooks in to get hold of the underlying device if necessary.

It requires a more or less complex state-machine to switch the used 4 or 5 
pins to different modes to measure the X/Y position and the pressure. And 
these pins interfere with the ADC input pins.

> [...]

Regards,
Juergen
-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | http://www.pengutronix.de/  |
