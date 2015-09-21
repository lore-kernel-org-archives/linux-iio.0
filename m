Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:33248 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932270AbbIUO0I (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 Sep 2015 10:26:08 -0400
Received: by igbkq10 with SMTP id kq10so79605918igb.0
        for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2015 07:26:07 -0700 (PDT)
Date: Mon, 21 Sep 2015 09:26:04 -0500
From: Mike Mestnik <cheako@mikemestnik.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH] Asus T300CHI.
Message-ID: <20150921142604.GA12821@localhost>
References: <CAF8px547WhBsfmV8K8OLbqTbADWbu0sD1jUjrGEPHVZfEzrP6w@mail.gmail.com>
 <CAEnQRZAX1=Y4SaOrpfbWRLR1kYmNKJjeKKouS6pkeb2BBDzr-g@mail.gmail.com>
 <CAF8px56ehuZxcP9EJ3d+M68CdYJKdkiaRs_g1+S8euiFKA5pkA@mail.gmail.com>
 <55FF0433.6050900@kernel.org>
 <1442788960.1030.11.camel@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1442788960.1030.11.camel@hadess.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sep 20, 2015 5:42 PM, "Bastien Nocera" <hadess@hadess.net> wrote:
>
> On Sun, 2015-09-20 at 20:08 +0100, Jonathan Cameron wrote:
> > On 19/09/15 20:03, Mike Mestnik wrote:
> > > On Sat, Sep 19, 2015 at 1:48 PM, Daniel Baluta <
> > > daniel.baluta@gmail.com> wrote:
> > > > On Fri, Sep 18, 2015 at 12:07 AM, Mike Mestnik <
> > > > cheako@mikemestnik.net> wrote:
> > > > > Hello,
> > > > >   I'm looking to know the result of adding ACPI support for a
> > > > > new
> > > > > tablet, the existing support shouldn't work because of a
> > > > > misplaced
> > > > > __init that causes the function to be removed prior to being
> > > > > called.
> > > >
> > > > Are you sure about this? It seems that the existing support
> > > > doesn't work
> > > > because you have different product ids.
> > > >
> > > The driver worked much better prior to me adding the product ids.
> > >  The
> > > sensors were exposed to sysfs and all the data they collected
> > > seemed
> > > correct to me.  The big issue is that there is no software, even
> > > iio-sensor-proxy didn't know how to access the data.
> > Cc'd Bastien Nocera.
>
> iio-sensor-proxy not finding the sensor, and with it working otherwise,
> would be an iio-sensor-proxy bug. I have one of those already for the
> accelerometer in the WinBook TW100 that I haven't had time to root down
> though. See:
> https://github.com/hadess/iio-sensor-proxy/issues/39
>
> The main problem being that sensor types are already hard to detect,
> and the iio subsystem doesn't make it any easier to check whether
> there's buffered output available, or the application needs to poll.
>
> If anyone wants to fix that in the kernel, that would certainly make my
> life easier.
>
I only kind of understand the reasoning for iio, but for the case of
devices used for instructing application behaviour I can't help but think
this would be better served using/extending input events.

That would seam to cover the above issues, in exchange for having to add
support for a few new tricks.

1. An axis where max and min are actually one 'step' apart.
2. Double axis for xyz, 6 instead of 3.  Perhaps this can be handled with
extra event nodes, but then there may be sync issues.
3. Integrating iio data into input events.  I don't even understand what
this would mean.

> Cheers
