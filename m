Return-Path: <hadess@hadess.net>
Message-ID: <1403354266.3385.7.camel@nuvo>
Subject: Re: User-space API for accelerometer(s)?
From: Bastien Nocera <hadess@hadess.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Reyad Attiyat
	 <reyad.attiyat@gmail.com>, linux-iio@vger.kernel.org, Benjamin Tissoires
	 <benjamin.tissoires@redhat.com>
Date: Sat, 21 Jun 2014 14:37:46 +0200
In-Reply-To: <53A57414.8000104@kernel.org>
References: <1403100542.30918.29.camel@nuvo>
		 <CA+BWVUSqrJhFwKXHL5q=mwcxmasfkpNB6EqEXC6jPfg0ytOVzA@mail.gmail.com>
		 <53A224AB.9090305@linux.intel.com> <1403176834.30918.32.camel@nuvo>
	 <53A57414.8000104@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Sat, 2014-06-21 at 13:01 +0100, Jonathan Cameron wrote:
> On 19/06/14 12:20, Bastien Nocera wrote:
> > On Wed, 2014-06-18 at 16:45 -0700, Srinivas Pandruvada wrote:
> >> On 06/18/2014 04:31 PM, Reyad Attiyat wrote:
> >>> Hello Bastien Nocera,
> >>>
> >>> I'm not the best person to answer your questions but I will try and
> >>> help. The best people to talk to would be Jonathan Cameron, the IIO
> >>> maintainer, and Srinivas Pandruvada, the author of the hid-sensor-hub
> >>> device drivers. I have CC'ed them for you to hopefully get a better
> >>> response than what I can offer.
> >>>
> >>> Your device uses the same sensor hub, over usb, as my device does. I
> >>> have a Microsoft Surface and it also uses many of the sensors found on
> >>> the Lenovo Yoga.
> >>>
> >>>> So, my question regarding the IIO user-space API is:
> >>>> is it possible to make the IIO accelerometer send out a kevent when the
> >>>> orientation changes in a major way (using triggers?) or does user-space
> >>>> need to poll the device instead?
> >>
> >> You can check a program called generic_buffer.c in
> >> "drivers/staging/iio/Documentation". I have used this as a reference to
> >> port to Android.
> >> You don't need to poll, you can also check
> >> "https://github.com/pfps/yoga-laptop/sensors " developed by Peter F.
> >> Patel-Schneider.
> >
> > I've read this code, and in fact, I mentioned it in my original mail. I
> > fail to see how this code isn't polling. It's also much more complicated
> > than doing the same thing for a evdev accelerometer.
> >
> Just to throw it in there.  There is an out of tree bridge driver from
> IIO to input.  It's only out of tree because I haven't had a chance to
> tidy it up (anyone else is welcome to take this on if they like!)
> Google for iio_input.c to find it.

Found it, thanks :)

http://thread.gmane.org/gmane.linux.kernel.iio/4464/

(By the way, "iio_input", not "iio_snoop")

> The intent of that was to allow general accelerometer drivers and similar
> in IIO to work in conjunction with iio-input to provide input style interfaces.
> This came about after previous debates on where the 'right' place for
> accelerometers was in the kernel. I believe that at least in principle,
> Dmitry was happy with this concept.

Cool. The only question left would be whether this could throw a kevent
when the orientation changes in a major way. This is a firmware feature
in the WeTab/Pegatron machine, and is useful because it avoids the need
to have the accelerometer constantly opened when not needed (saving
battery by avoiding wakeups).

Would it be worth adding such a feature inside the iio-input driver? I
would have preferred it if the hardware sent those events, but I'd be
happy just the same if the driver did it. The backing IIO device is
always opened and processing data, it seems, whether or not the backing
input device is opened in user-space or not.

Cheers
