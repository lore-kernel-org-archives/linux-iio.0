Return-Path: <groeck@ericsson.com>
Date: Sun, 24 Oct 2010 16:47:35 -0700
From: Guenter Roeck <guenter.roeck@ericsson.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Mike Frysinger <vapier@gentoo.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>,
        Sonic Zhang <sonic.zhang@analog.com>
Subject: Re: [PATCH 12/14] staging: iio: adc: new driver for ADT7408
 temperature sensors
Message-ID: <20101024234735.GB15616@ericsson.com>
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

device_id and manufactory_id (shouldn't that be manufacturer_id ?) don't provide
much value since they are (or could be) already part of the device name.

"capability" reflects a raw register value. I would be opposed to any attribute
like that, since it does not mean anything beyond the driver for that specific chip.
The data it provides might make sense in the driver documentation, but what
is anyone supposed to do with the returned hex value ? That kind of ABI really
does not make any sense. If the reported values are really valuable enough to be
reported, a real abi (eg tempX_accuracy and tempX_resolution) would be much better.

For "power-save" (or "power-down" ?) and "full" mode I am not sure
why suspend/resume isn't used instead. Is that some new upcoming ABI ?

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
There should be a generic part and a specific part for such generic devices.
The generic part can be in mfd or somewhere suitable (such as iio), but
the hwmon part should reside in hwmon.

The worst thing to do would be to duplicate functionality as it is proposed here.
That can only create chaos.

If the event mechanism in hwmon is deemed insufficient enough to cause drivers
to move elsewhere, maybe event mechanism in hwmon should be improved instead.
Or, even better, if there is a really need for a more detailed / improved event
mechanism, there should be a single event subsystem that works for both iio
and hwmon.

In short, if the hwmon ABI is deemed to be insufficient to support today's devices,
for whaever reason, it needs to get fixed. Moving hwmon drivers elsewhere to
avoid its perceived (or real) limitations should be an absolute no.

Guenter
