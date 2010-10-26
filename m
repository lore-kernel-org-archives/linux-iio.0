Return-Path: <groeck@ericsson.com>
Date: Tue, 26 Oct 2010 07:33:07 -0700
From: Guenter Roeck <guenter.roeck@ericsson.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "Zhang, Sonic" <Sonic.Zhang@analog.com>,
        Mike Frysinger <vapier@gentoo.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH 12/14] staging: iio: adc: new driver for ADT7408
 temperature sensors
Message-ID: <20101026143307.GB22667@ericsson.com>
References: <1287865757-1031-1-git-send-email-vapier@gentoo.org>
 <1287865757-1031-12-git-send-email-vapier@gentoo.org>
 <4CC4B8F8.7010005@cam.ac.uk>
 <DB904C5425BA6F4E8424B3B51A1414D16578B22370@NWD2CMBX1.ad.analog.com>
 <4CC69C32.9030205@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <4CC69C32.9030205@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Oct 26, 2010 at 05:15:30AM -0400, Jonathan Cameron wrote:
> On 10/26/10 04:27, Zhang, Sonic wrote:
> >
> >
> >> -----Original Message-----
> >> From: Jonathan Cameron [mailto:jic23@cam.ac.uk]
> >> Sent: Monday, October 25, 2010 6:54 AM
> >> To: Mike Frysinger
> >> Cc: linux-iio@vger.kernel.org;
> >> device-drivers-devel@blackfin.uclinux.org; Zhang, Sonic; Guenter Roeck
> >> Subject: Re: [PATCH 12/14] staging: iio: adc: new driver for
> >> ADT7408 temperature sensors
> >>
> >> On 10/23/10 21:29, Mike Frysinger wrote:
> >>> From: Sonic Zhang <sonic.zhang@analog.com>
> >> Here we enter new territory. This device is already supported
> >> in hwmon.  Do we have a usecase that is not covered by that driver?
> >>
> >
> > I don't find a way to get event notification other than poll in hwmon
> > framework. So, I move all temperature devic with interrupt available
> > to IIO framework.
> 
> Whilst it isn't often done (and is a little clunky). It is possible to select
> on sysfs attributes much like any other file. I'm sure Guenter can tell us
> if any current hwmon devices are doing this?

One can always use sysfs_notify(). Not sure I understand what is clunky about it.
gpio-fan uses it, and I have used it as well in an internal driver. Works pretty well.

I thought that is what was meant with "poll" [ie poll (2)], and somehow considered
to not be good enough. Would be nice to know the reasons, though, and how iio does
better than that. Maybe I need to spend some time reading the iio documentation.

Guenter
