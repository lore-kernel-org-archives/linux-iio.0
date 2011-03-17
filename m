Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: IIO comments
Date: Thu, 17 Mar 2011 18:54:52 +0100
Cc: Kay Sievers <kay.sievers@vrfy.org>,
 linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Greg KH <greg@kroah.com>,
 Jean Delvare <khali@linux-fr.org>,
 Guenter Roeck <guenter.roeck@ericsson.com>
References: <201103152215.20059.arnd@arndb.de> <201103171603.35700.arnd@arndb.de> <4D823AF8.8070408@cam.ac.uk>
In-Reply-To: <4D823AF8.8070408@cam.ac.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201103171854.52777.arnd@arndb.de>
List-ID: <linux-iio@vger.kernel.org>

On Thursday 17 March 2011 17:46:48 Jonathan Cameron wrote:
> > 
> > Since I haven't fully understood the distinction between the
> > three chardevs, it may of course turn out a bad idea, but I
> > think it would simplify the core code if you could assume
> > that every iio device has exactly one chardev interface,
> > so you could give them the same unique number and manage
> > the life time together.
>
> It simplifies that corner, but I'm a little worried that it
> will add a lot of interlinks between the currently fairly
> disconnected elements that go through a character device.
> 
> If we can keep those links to a minimum (which I think
> we can, but haven't tried yet!) it will be a sensible move.

Let's first work out how a single event buffer should work
using read and poll, as discussed in the other thread.
Once we have sorted that out, this may become a lot clearer.

	Arnd
