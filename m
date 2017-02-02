Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:49825 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750808AbdBBKfP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Feb 2017 05:35:15 -0500
Message-ID: <1486031705.16399.1.camel@hadess.net>
Subject: Re: Why hid-sensor-hub's IIO doesn't work properly in >= 4.3
 (possibly badly bisected)
From: Bastien Nocera <hadess@hadess.net>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Richard Hughes <richard@hughsie.com>
Date: Thu, 02 Feb 2017 11:35:05 +0100
In-Reply-To: <1485993472.18380.73.camel@linux.intel.com>
References: <1484927552.21721.17.camel@hadess.net>
         <CAJZ5v0hYwyV+j+38rdqo81x0p5jWyLzHijYFY5RmnODzRUK0qg@mail.gmail.com>
         <1485869863.5845.54.camel@hadess.net> <4663686.yGs8knaWTY@aspire.rjw.lan>
         <1485993472.18380.73.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 2017-02-01 at 15:57 -0800, Srinivas Pandruvada wrote:
> On Thu, 2017-02-02 at 00:38 +0100, Rafael J. Wysocki wrote:
> > + Srinivas
> > 
> > On Tuesday, January 31, 2017 02:37:43 PM Bastien Nocera wrote:
> > > 
> > > Hey Rafael,
> > > 
> > > On Fri, 2017-01-27 at 00:07 +0100, Rafael J. Wysocki wrote:
> > > > 
> > > > On Thu, Jan 26, 2017 at 4:15 PM, Bastien Nocera <hadess@hadess.
> > > > ne
> > > > t>
> > > > wrote:
> > > > > 
> > > > > On Fri, 2017-01-20 at 16:52 +0100, Bastien Nocera wrote:
> > > > > > 
> > > > > > Hey,
> > > > > > 
> > > > > > TLDR:
> > > > > > # first bad commit:
> > > > > > [50ba22479c324c0d9dc8134d519dcba92d83a8a7]
> > > > > > Merge
> > > > > > back earlier ACPI PM material for v4.3.
> > > > > > 
> > > > > > hid-sensor-hub devices only start sending events through
> > > > > > the
> > > > > > IIO
> > > > > > trigger after a suspend/resume cycle.
> 
> 
> > Srinivas, does it sound like anything familiar to you?
> 
> I guess this is related to
> https://github.com/hadess/iio-sensor-proxy/issues/82
> 
> There is some race between user space and iio. So the driver powerup
> never gets called back to power a hub during system boot. So the
> workaround was to add to systemd unit file for iio-sensor-proxy 
> [Unit]
> After=multi-user.target
> 
> Something changed timings in the kernel, which triggered this issue.

I don't think it's simply "timings", or at least it's a big enough
window of opportunity that I can reproduce the bug 100% of the time
when not adding timeouts to iio-sensor-proxy's timeout.

Putting the machine on suspend and resuming it also fixes the problem
(for a machine I've been testing that can be suspended, it's not an
option for all of them).

> I never got chance to root cause this.

Well, at least the root cause is limited to a single commit, shame it's
a merge one.
