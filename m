Return-Path: <SRS0=cGCW=7O=hadess.net=hadess@kernel.org>
Message-ID: <1502542703.2326.1.camel@hadess.net>
Subject: Re: [RFT][PATCH] iio: hid-sensor-trigger: Fix the race with user
 space powering up sensors
From: Bastien Nocera <hadess@hadess.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Hans de Goede
 <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sat, 12 Aug 2017 14:58:23 +0200
In-Reply-To: <20170812131611.63667d25@archlinux>
References: 
	<1502407444-1078-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1502460270.2588.8.camel@hadess.net> <20170812131611.63667d25@archlinux>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Sat, 2017-08-12 at 13:16 +0100, Jonathan Cameron wrote:
> On Fri, 11 Aug 2017 16:04:30 +0200
> Bastien Nocera <hadess@hadess.net> wrote:
> 
> > Woot!
> > 
> > On Thu, 2017-08-10 at 16:24 -0700, Srinivas Pandruvada wrote:
> > > It has been reported for a while that with iio-sensor-proxy
> > > service the
> > > rotation only works after one suspend/resume cycle. This required
> > > a wait
> > > in the systemd unit file to avoid race. I found a Yoga 900 where
> > > I could
> > > reproduce this.
> > > 
> > > The problem scenerio is:
> > > - During sensor driver init, enable run time PM and also set a
> > >   auto-suspend for 3 seconds.
> > > 	This result in one runtime resume. But there is a check to
> > > avoid
> > > a powerup in this sequence, but rpm is active
> > > - User space iio-sensor-proxy tries to power up the sensor. Since
> > > rpm is
> > >   active it will simply return. But sensors were not actually
> > > powered up in the prior sequence, so actaully the sensors will
> > > not work
> > > - After 3 seconds the auto suspend kicks
> > > 
> > > If we add a wait in systemd service file to fire iio-sensor-proxy 
> > > after
> > > 3 seconds, then now everything will work as the runtime resume
> > > will
> > > actually powerup the sensor as this is a user request.
> > > 
> > > To avoid this:
> > > - Remove the check to match user requested state, this will cause
> > > a
> > >   brief powerup, but if the iio-sensor-proxy starts immediately
> > > it will
> > > still work as the sensors are ON.
> > > - Also move the autosuspend delay to place when user requested
> > > turn off
> > >   of sensors, like after user finished raw read or buffer disable
> > > 
> > > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.int
> > > el.com>  
> > 
> > Tested-by: Bastien Nocera <hadess@hadess.net>
> > 
> > I'm still chasing a couple of bugs in the user-space side of things
> > caused by the removal of the timeout.
> > 
> > Thanks!
> 
> Is it worth me sitting on this for a week or so to see if it deals
> with
> all the reported issues around this?
> 
> Or are you happy that the test set you have is sufficient to verify
> it?

I'd rather have it merged ASAP. The fact that it didn't need to sleep
for 3 seconds allowed me to find a couple of problems in GNOME's use of
this feature, with the sensor showing up before the desktop has
started. Those will likely be taken care of next week as well.

I've tested it on a couple of machines, and it's working as expected.

> Definitely good to put this one to bed finally! 

And no one's happier than me in this one. I can concentrate on bugs I
wrote myself now ;)
