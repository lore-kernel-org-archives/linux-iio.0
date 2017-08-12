Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:7537 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750983AbdHLQEY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Aug 2017 12:04:24 -0400
Message-ID: <1502553862.20268.49.camel@linux.intel.com>
Subject: Re: [RFT][PATCH] iio: hid-sensor-trigger: Fix the race with user
 space powering up sensors
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Bastien Nocera <hadess@hadess.net>,
        Jonathan Cameron <jic23@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Sat, 12 Aug 2017 09:04:22 -0700
In-Reply-To: <1502542703.2326.1.camel@hadess.net>
References: <1502407444-1078-1-git-send-email-srinivas.pandruvada@linux.intel.com>
         <1502460270.2588.8.camel@hadess.net> <20170812131611.63667d25@archlinux>
         <1502542703.2326.1.camel@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 2017-08-12 at 14:58 +0200, Bastien Nocera wrote:
> On Sat, 2017-08-12 at 13:16 +0100, Jonathan Cameron wrote:
> > 
> > On Fri, 11 Aug 2017 16:04:30 +0200
> > Bastien Nocera <hadess@hadess.net> wrote:
> > 
> > > 
> > > Woot!
> > > 
[...]

> > > > 
> > > > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.i
> > > > nt
> > > > el.com>  
> > > Tested-by: Bastien Nocera <hadess@hadess.net>
> > > 
> > > I'm still chasing a couple of bugs in the user-space side of
> > > things
> > > caused by the removal of the timeout.
> > > 
> > > Thanks!
> > Is it worth me sitting on this for a week or so to see if it deals
> > with
> > all the reported issues around this?
> > 
> > Or are you happy that the test set you have is sufficient to verify
> > it?
> I'd rather have it merged ASAP. The fact that it didn't need to sleep
> for 3 seconds allowed me to find a couple of problems in GNOME's use
> of
> this feature, with the sensor showing up before the desktop has
> started. Those will likely be taken care of next week as well.
> 
> I've tested it on a couple of machines, and it's working as expected.
> 
> > 
> > Definitely good to put this one to bed finally! 
> And no one's happier than me in this one. I can concentrate on bugs I
> wrote myself now ;)
I will resubmit patch by adding Testedby and removing [RFT].

Thanks,
Srinivas
