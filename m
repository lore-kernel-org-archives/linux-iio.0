Return-Path: <hadess@hadess.net>
Message-ID: <1403176834.30918.32.camel@nuvo>
Subject: Re: User-space API for accelerometer(s)?
From: Bastien Nocera <hadess@hadess.net>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Reyad Attiyat <reyad.attiyat@gmail.com>, linux-iio@vger.kernel.org,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jonathan Cameron
 <jic23@kernel.org>
Date: Thu, 19 Jun 2014 13:20:34 +0200
In-Reply-To: <53A224AB.9090305@linux.intel.com>
References: <1403100542.30918.29.camel@nuvo>
	 <CA+BWVUSqrJhFwKXHL5q=mwcxmasfkpNB6EqEXC6jPfg0ytOVzA@mail.gmail.com>
	 <53A224AB.9090305@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Wed, 2014-06-18 at 16:45 -0700, Srinivas Pandruvada wrote:
> On 06/18/2014 04:31 PM, Reyad Attiyat wrote:
> > Hello Bastien Nocera,
> >
> > I'm not the best person to answer your questions but I will try and
> > help. The best people to talk to would be Jonathan Cameron, the IIO
> > maintainer, and Srinivas Pandruvada, the author of the hid-sensor-hub
> > device drivers. I have CC'ed them for you to hopefully get a better
> > response than what I can offer.
> >
> > Your device uses the same sensor hub, over usb, as my device does. I
> > have a Microsoft Surface and it also uses many of the sensors found on
> > the Lenovo Yoga.
> >
> >> So, my question regarding the IIO user-space API is:
> >> is it possible to make the IIO accelerometer send out a kevent when the
> >> orientation changes in a major way (using triggers?) or does user-space
> >> need to poll the device instead?
> 
> You can check a program called generic_buffer.c in 
> "drivers/staging/iio/Documentation". I have used this as a reference to 
> port to Android.
> You don't need to poll, you can also check 
> "https://github.com/pfps/yoga-laptop/sensors " developed by Peter F. 
> Patel-Schneider.

I've read this code, and in fact, I mentioned it in my original mail. I
fail to see how this code isn't polling. It's also much more complicated
than doing the same thing for a evdev accelerometer.
