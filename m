Return-Path: <groeck@ericsson.com>
Date: Mon, 25 Oct 2010 07:12:35 -0700
From: Guenter Roeck <guenter.roeck@ericsson.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Mike Frysinger <vapier@gentoo.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>,
        Sonic Zhang <sonic.zhang@analog.com>
Subject: Re: [PATCH 12/14] staging: iio: adc: new driver for ADT7408
 temperature sensors
Message-ID: <20101025141235.GA18016@ericsson.com>
References: <1287865757-1031-1-git-send-email-vapier@gentoo.org>
 <1287865757-1031-12-git-send-email-vapier@gentoo.org>
 <4CC4B8F8.7010005@cam.ac.uk>
 <20101025004650.GA15907@ericsson.com>
 <4CC55CD2.1020501@cam.ac.uk>
 <20101025111943.GA16863@ericsson.com>
 <4CC56D50.3000804@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <4CC56D50.3000804@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Oct 25, 2010 at 07:43:12AM -0400, Jonathan Cameron wrote:
[ ... ]

> > I did not refer to the chips with generic ADC sensors.
> > The chips I referred to are AD7414/15, ADT75, ADT7310, ADT7408, and ADT7410,
> > though I may have missed some.
> You clearly got further through the set than I have so far! (I'd only come across
> the first 2 of those)  Agreed, all of these appear to be temperature only and at
> a quick look they are typically slow and low resolution so that set definitely
> want to be in hwmon.
> 
> For those parts with actual hwmon drivers, ad7414/15 and adt7408 (based on a quick
> grep unless Guenter has others queued). Lets drop them for now from the merge.
> 

Nothing queued here. Not that I would mind doing the driver conversions for ADT7310
and ADT7410 if needed, but I would need HW (eval boards) for testing.

> For the others lets put a todo in place to convert them to hwmon.  Nothing wrong
> with putting them in staging (under IIO or otherwise) in the meantime as far
> as I am concerned.
> 
> > 
> >> We went through this in a lot of depth back when IIO first came about.
> >> There is a boundary. We just need to pin down where it is.
> > 
> > For the ambient temperature sensors on the other chips - did you consider
> > adding hwmon device entries for those ? There may of course be reasons against
> > doing that, but it may be an option. There are other drivers outside the hwmon 
> > directory which call hwmon_device_register(), so it is not a new concept.
> It depends on whether they are generally useful for temperature monitoring.
> On the whole they are giving one the value on a particular bit of silicon
> in the chip (not the ambient temperature near by). They aren't reading it for
> monitoring purposes, but because it is needed to calibrate the other sensors in
> the package.  We even have devices with multiple temperature sensors, one on
> each MEMs device. Also they often get read into a buffer with all the rest
> of the channels.
> 
> Lets leave the decision on this up to individual driver writers.  If they are using
> the device to do hwmon stuff as well as whatever else it is for then we encourage them
> to register it with hwmon as you suggest.
> 
Ok, makes sense.

Thanks,
Guenter
