Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:37753 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756221AbbIYOT3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 25 Sep 2015 10:19:29 -0400
Message-ID: <1443190753.3825.5.camel@linux.intel.com>
Subject: Re: [PATCH] Asus T300CHI.
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Mike Mestnik <cheako@mikemestnik.net>,
	Bastien Nocera <hadess@hadess.net>,
	Daniel Baluta <daniel.baluta@gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Fri, 25 Sep 2015 07:19:13 -0700
In-Reply-To: <20150924155704.GA6388@localhost>
References: <CAF8px547WhBsfmV8K8OLbqTbADWbu0sD1jUjrGEPHVZfEzrP6w@mail.gmail.com>
	 <CAEnQRZAX1=Y4SaOrpfbWRLR1kYmNKJjeKKouS6pkeb2BBDzr-g@mail.gmail.com>
	 <CAF8px56ehuZxcP9EJ3d+M68CdYJKdkiaRs_g1+S8euiFKA5pkA@mail.gmail.com>
	 <55FF0433.6050900@kernel.org> <1442788960.1030.11.camel@hadess.net>
	 <20150921142604.GA12821@localhost> <56005E7A.9060304@kernel.org>
	 <20150924155704.GA6388@localhost>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 2015-09-24 at 10:57 -0500, Mike Mestnik wrote:
> On Mon, Sep 21, 2015 at 2:46 PM, Jonathan Cameron <jic23@kernel.org>
> wrote:
> > On 21/09/15 15:26, Mike Mestnik wrote:
> > > On Sep 20, 2015 5:42 PM, "Bastien Nocera" <hadess@hadess.net>
> > > wrote:
> > > > 
> > > > On Sun, 2015-09-20 at 20:08 +0100, Jonathan Cameron wrote:
> > > > > On 19/09/15 20:03, Mike Mestnik wrote:
> > > > > > On Sat, Sep 19, 2015 at 1:48 PM, Daniel Baluta <
> > > > > > daniel.baluta@gmail.com> wrote:
> > > > > > > On Fri, Sep 18, 2015 at 12:07 AM, Mike Mestnik <
> > > > > > > cheako@mikemestnik.net> wrote:
> > > > > > > > Hello,
> > > > > > > >   I'm looking to know the result of adding ACPI support
> > > > > > > > for a
> > > > > > > > new
> > > > > > > > tablet, the existing support shouldn't work because of
> > > > > > > > a
> > > > > > > > misplaced
> > > > > > > > __init that causes the function to be removed prior to
> > > > > > > > being
> > > > > > > > called.
> > > > > > > 
> > > > > > > Are you sure about this? It seems that the existing
> > > > > > > support
> > > > > > > doesn't work
> > > > > > > because you have different product ids.
> > > > > > > 
> > > > > > The driver worked much better prior to me adding the
> > > > > > product ids.
> > > > > >  The
> > > > > > sensors were exposed to sysfs and all the data they
> > > > > > collected
> > > > > > seemed
> > > > > > correct to me.  The big issue is that there is no software,
> > > > > > even
> > > > > > iio-sensor-proxy didn't know how to access the data.
> > > > > Cc'd Bastien Nocera.
> > > > 
> > > > iio-sensor-proxy not finding the sensor, and with it working
> > > > otherwise,
> > > > would be an iio-sensor-proxy bug. I have one of those already
> > > > for the
> > > > accelerometer in the WinBook TW100 that I haven't had time to
> > > > root down
> > > > though. See:
> > > > https://github.com/hadess/iio-sensor-proxy/issues/39
> > > > 
> > > > The main problem being that sensor types are already hard to
> > > > detect,
> > > > and the iio subsystem doesn't make it any easier to check
> > > > whether
> > > > there's buffered output available, or the application needs to
> > > > poll.
> > I dispute this one.  It's not exactly hard to check for the buffer
> > directory in sysfs and to evaluate if there is a trigger provided
> > by
> > the device (again a simple directory presence check).
> > It gets harder if there is more than one trigger provided, but
> > inherently
> > there isn't much we can do to suggest the best one.  If there are
> > two
> > then there are two usecases that demand different choices.
> > 
> > > > 
> > > > If anyone wants to fix that in the kernel, that would certainly
> > > > make my
> > > > life easier.
> > > > 
> > > I only kind of understand the reasoning for iio, but for the case
> > > of
> > > devices used for instructing application behaviour I can't help
> > > but think
> > > this would be better served using/extending input events.
> > Indeed, the IIO side of things is about providing generic support
> > for lots of use cases whereas in your case you are looking at
> > something
> > which is naturally quite specific.
> > 
> I just found a copy of this driver in the input tree:
> drivers/input/misc/mpu3050.c
This was done in 2011 time frame, when IIO was still in staging, I
guess.
Using input driver is not good idea as we need some special sysfs
entries for control.
There was some proposal for IIO input driver bridge.

Thanks,
Srinivas

> Perhaps "indexing" drivers by userspace API is the wrong approach as
> it's logical that a device my be accessible from userspace via
> multiple APIs and applicable for lots of reasons.  Splinting drivers
> into directories because of how userspace communicates with the
> driver
> is just asking for duplication or problems with bringing in the
> appropriate code.
> 
> > > 
> > > That would seam to cover the above issues, in exchange for having
> > > to add
> > > support for a few new tricks.
> > > 
> > > 1. An axis where max and min are actually one 'step' apart.
> > > 2. Double axis for xyz, 6 instead of 3.  Perhaps this can be
> > > handled with
> > > extra event nodes, but then there may be sync issues.
> 
> At first glance it seems that these are still outstanding, needing a
> proposed userspace API.
