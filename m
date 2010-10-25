Return-Path: <groeck@ericsson.com>
Date: Sun, 24 Oct 2010 17:46:50 -0700
From: Guenter Roeck <guenter.roeck@ericsson.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Mike Frysinger <vapier@gentoo.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>,
        Sonic Zhang <sonic.zhang@analog.com>
Subject: Re: [PATCH 12/14] staging: iio: adc: new driver for ADT7408
 temperature sensors
Message-ID: <20101025004650.GA15907@ericsson.com>
References: <1287865757-1031-1-git-send-email-vapier@gentoo.org>
 <1287865757-1031-12-git-send-email-vapier@gentoo.org>
 <4CC4B8F8.7010005@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <4CC4B8F8.7010005@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Oct 24, 2010 at 06:53:44PM -0400, Jonathan Cameron wrote:
> On 10/23/10 21:29, Mike Frysinger wrote:
> > From: Sonic Zhang <sonic.zhang@analog.com>
> Here we enter new territory. This device is already
> supported in hwmon.  Do we have a usecase that is not
> covered by that driver?
> 
> If this is only for hardware monitoring by Guenter (cc'd) can
> perhaps advise on how to support everything you have here...
> 
> I'm personally not against having drivers in IIO for devices
> supported elsewhere, but the requirements for justification
> are rather higher. Also care is needed to ensure no issues with
> platform data etc.
> 
> Guenter, for your information we have a set of temp drivers coming,
> as a small element of a larger set, from Analog's tree. Those
> I've reviewed so far have wanted to use IIO's event infrastructure
> (which is much more general than hwmon's handling of alarms)
> or have been suitably high performance devices with general
> adc's to satisfy me that they clearly have uses beyond
> hardware monitoring.
> 
Browsing through the adt patch list, there are several other drivers
which either already exist in hwmon, or should be there.

I'd love to see some reasoning why hardware monitoring drivers are
moved to or directly written in iio.

Also, I seem to be missing your point re "high performance devices".
Are you saying that hwmon is not suitable for high performance
hardware monitoring devices ?

Thanks,
Guenter
