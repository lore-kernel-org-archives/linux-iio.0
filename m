Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: IIO comments
Date: Thu, 17 Mar 2011 16:03:35 +0100
Cc: Kay Sievers <kay.sievers@vrfy.org>,
 linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Greg KH <greg@kroah.com>,
 Jean Delvare <khali@linux-fr.org>,
 Guenter Roeck <guenter.roeck@ericsson.com>
References: <201103152215.20059.arnd@arndb.de> <201103171447.17960.arnd@arndb.de> <4D821DE2.4050707@cam.ac.uk>
In-Reply-To: <4D821DE2.4050707@cam.ac.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201103171603.35700.arnd@arndb.de>
List-ID: <linux-iio@vger.kernel.org>

On Thursday 17 March 2011, Jonathan Cameron wrote:
> On 03/17/11 13:47, Arnd Bergmann wrote:

> > What about hardware devices that have multiple unrelated streams
> > of buffered input data?
>
> Certainly plausible, but so far the only ones I've seen that actually
> do this are really just two bits of silicon in the same plastic
> package.  They tend to use different i2c addresses or spi chip
> selects anyway so as far as the kernel is concerned are completely
> separate.  You are correct that any device which truly has different
> streams of data would indeed need more than one device.

Ok.

> >>> * One chardev for each iio device
> >>
> >> currently 1-3. (event line, buffer access, buffer event)
> > 
> > It would be really nice to unify this, as I said. What
> > are the reasons why you think it cannot or should not be
> > done?
>
> Simplicity perhaps, but I'll definitely give your suggestions
> a go and see where we end up. 

Since I haven't fully understood the distinction between the
three chardevs, it may of course turn out a bad idea, but I
think it would simplify the core code if you could assume
that every iio device has exactly one chardev interface,
so you could give them the same unique number and manage
the life time together.

> >>> * Use epoll to wait for data and/or out-of-band messages
> >>> * Use chrdev read to get events from the buffer
> >>
> >> and data?
> > 
> > I mean get the data associated with the event. The event
> > itself as you said does not have any data, so we would not
> > need to read it, just to use poll()/epoll() in order to
> > wait for it.
>
> Sure. But devices can do a heck of a lot of different events.
> (certainly 10's or maybe more).  I'm not immediately clear
> on how to handle this via poll etc.  This is probably just
> because I've never tried though!

(e)poll can generally distinguish between very few types of
activity: data for reading available, space for writing available,
out-of-band events (to be read with e.g. ioctl) and errors.

If you want to wait for multiple equal types of events for
one hardware device, it would be logical to have multiple 
character devices for them, so a user could open and wait
for some of them independent of the others.

Intuitively, I would also expect these to be separate iio
devices for the same hardware (each with one chardev), but
there may be good reasons why that is not possible.

	Arnd
