Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:52813 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754851AbbITWmr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 20 Sep 2015 18:42:47 -0400
Message-ID: <1442788960.1030.11.camel@hadess.net>
Subject: Re: [PATCH] Asus T300CHI.
From: Bastien Nocera <hadess@hadess.net>
To: Jonathan Cameron <jic23@kernel.org>,
	Mike Mestnik <cheako@mikemestnik.net>,
	Daniel Baluta <daniel.baluta@gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Date: Mon, 21 Sep 2015 00:42:40 +0200
In-Reply-To: <55FF0433.6050900@kernel.org>
References: <CAF8px547WhBsfmV8K8OLbqTbADWbu0sD1jUjrGEPHVZfEzrP6w@mail.gmail.com>
	 <CAEnQRZAX1=Y4SaOrpfbWRLR1kYmNKJjeKKouS6pkeb2BBDzr-g@mail.gmail.com>
	 <CAF8px56ehuZxcP9EJ3d+M68CdYJKdkiaRs_g1+S8euiFKA5pkA@mail.gmail.com>
	 <55FF0433.6050900@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 2015-09-20 at 20:08 +0100, Jonathan Cameron wrote:
> On 19/09/15 20:03, Mike Mestnik wrote:
> > On Sat, Sep 19, 2015 at 1:48 PM, Daniel Baluta <
> > daniel.baluta@gmail.com> wrote:
> > > On Fri, Sep 18, 2015 at 12:07 AM, Mike Mestnik <
> > > cheako@mikemestnik.net> wrote:
> > > > Hello,
> > > >   I'm looking to know the result of adding ACPI support for a
> > > > new
> > > > tablet, the existing support shouldn't work because of a
> > > > misplaced
> > > > __init that causes the function to be removed prior to being
> > > > called.
> > > 
> > > Are you sure about this? It seems that the existing support
> > > doesn't work
> > > because you have different product ids.
> > > 
> > The driver worked much better prior to me adding the product ids. 
> >  The
> > sensors were exposed to sysfs and all the data they collected
> > seemed
> > correct to me.  The big issue is that there is no software, even
> > iio-sensor-proxy didn't know how to access the data.
> Cc'd Bastien Nocera.

iio-sensor-proxy not finding the sensor, and with it working otherwise,
would be an iio-sensor-proxy bug. I have one of those already for the
accelerometer in the WinBook TW100 that I haven't had time to root down
though. See:
https://github.com/hadess/iio-sensor-proxy/issues/39

The main problem being that sensor types are already hard to detect,
and the iio subsystem doesn't make it any easier to check whether
there's buffered output available, or the application needs to poll.

If anyone wants to fix that in the kernel, that would certainly make my
life easier.

Cheers
