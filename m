Return-Path: <groeck@ericsson.com>
Date: Mon, 1 Nov 2010 07:37:58 -0700
From: Guenter Roeck <guenter.roeck@ericsson.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "Zhang, Sonic" <Sonic.Zhang@analog.com>,
        Mike Frysinger <vapier@gentoo.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH 12/14] staging: iio: adc: new driver for ADT7408
 temperature sensors
Message-ID: <20101101143758.GA12962@ericsson.com>
References: <1287865757-1031-1-git-send-email-vapier@gentoo.org>
 <1287865757-1031-12-git-send-email-vapier@gentoo.org>
 <4CC4B8F8.7010005@cam.ac.uk>
 <DB904C5425BA6F4E8424B3B51A1414D16578B22370@NWD2CMBX1.ad.analog.com>
 <4CC69C32.9030205@cam.ac.uk>
 <20101026143307.GB22667@ericsson.com>
 <4CCE9CC2.5090401@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <4CCE9CC2.5090401@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

On Mon, Nov 01, 2010 at 06:56:02AM -0400, Jonathan Cameron wrote:
> On 10/26/10 15:33, Guenter Roeck wrote:
> > On Tue, Oct 26, 2010 at 05:15:30AM -0400, Jonathan Cameron wrote:
> >> On 10/26/10 04:27, Zhang, Sonic wrote:
> >>>
> >>>
> >>>> -----Original Message-----
> >>>> From: Jonathan Cameron [mailto:jic23@cam.ac.uk]
> >>>> Sent: Monday, October 25, 2010 6:54 AM
> >>>> To: Mike Frysinger
> >>>> Cc: linux-iio@vger.kernel.org;
> >>>> device-drivers-devel@blackfin.uclinux.org; Zhang, Sonic; Guenter Roeck
> >>>> Subject: Re: [PATCH 12/14] staging: iio: adc: new driver for
> >>>> ADT7408 temperature sensors
> >>>>
> >>>> On 10/23/10 21:29, Mike Frysinger wrote:
> >>>>> From: Sonic Zhang <sonic.zhang@analog.com>
> >>>> Here we enter new territory. This device is already supported
> >>>> in hwmon.  Do we have a usecase that is not covered by that driver?
> >>>>
> >>>
> >>> I don't find a way to get event notification other than poll in hwmon
> >>> framework. So, I move all temperature devic with interrupt available
> >>> to IIO framework.
> >>
> >> Whilst it isn't often done (and is a little clunky). It is possible to select
> >> on sysfs attributes much like any other file. I'm sure Guenter can tell us
> >> if any current hwmon devices are doing this?
> > 
> > One can always use sysfs_notify(). Not sure I understand what is clunky about it.
> > gpio-fan uses it, and I have used it as well in an internal driver. Works pretty well.
> > 
> > I thought that is what was meant with "poll" [ie poll (2)], and somehow considered
> > to not be good enough. Would be nice to know the reasons, though, and how iio does
> > better than that. Maybe I need to spend some time reading the iio documentation.
> As a quick and dirty summary.  IIO does it roughly the same way as input, be it heavily
> stripped down. Character device rather than sysfs for events.
> 
> This is from memory, but I think the main issue with sysfs_notify is that, whilst you can
> poll on any file, all of those in a given directory will wake up on a call of sysfs_notify.

>>From looking at the code, I don't think that is true. It should only happen if the attribute
name is not specified in the call. From a logical perspective, it would not make much sense
to have the attribute name as parameter if it is just ignored - and the call does not ignore it.

I'll do some testing to verify this. But even if it is true, I would assume it to be a bug
that should be fixed, and not be used as argument to move drivers out of sysfs.

> In devices with one or two alarms that is probably fine as you can just read them all,
> but we have devices with 10s of different alarms.  Hence you don't want to be reading lots
> of files to find out what is going on.  A single alarm file would be fine if only one could
> trigger simultaneously, but that's rarely the case.  Any sort of 'what alarm has triggered'
> mask is clunky and difficult to generalize.
> 
select() is clunky ?

> We try to use sysfs for what it is good at (low bandwidth direct reading from devices and
> configuration of those devices) and character devices for the high bandwidth stuff.
> 
Makes sense. But right now I am not entirely sure if some sysfs bashing got in there
along the way.

Note that I would not be opposed to some thinking about the hwmon user interface 
and how to improve it, or even merge it with iio if that makes sense. I have a system
which right now reports 301 (!) alarm files, and I am not even done with all drivers.
That _is_ getting a bit large. But there should be a discussion about it.
I don't think that providing parallel drivers in different subsystems is a solution.
And writing hwmon drivers into iio with no driver in hwmon isn't a solution either.

Thanks,
Guenter
