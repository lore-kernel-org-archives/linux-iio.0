Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: IIO comments
Date: Fri, 18 Mar 2011 17:57:58 +0100
Cc: Kay Sievers <kay.sievers@vrfy.org>,
 linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Greg KH <greg@kroah.com>,
 Jean Delvare <khali@linux-fr.org>,
 Guenter Roeck <guenter.roeck@ericsson.com>
References: <201103152215.20059.arnd@arndb.de> <201103181718.08502.arnd@arndb.de> <4D83885C.3050402@cam.ac.uk>
In-Reply-To: <4D83885C.3050402@cam.ac.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201103181757.58218.arnd@arndb.de>
List-ID: <linux-iio@vger.kernel.org>

On Friday 18 March 2011, Jonathan Cameron wrote:
> > I guess if it's always in${i}-in${i+1}, it's still not too hard.
> I think they have been so far, but doubt this is universal.
> How about having a diff type and just having a pair of indices in the
> channel structure?  Actually may need a third for x^2+y^2+z^2 devices.
> (iirc there are parts that do x^2+y^2 despite also having a z channel)
> ...

If two identifiers are common, that would probably be fine.

If you have a x^2+y^2+z^2 device, it might be easier to call that
a different type with a fixed name, as long as there is a small
number of combinations.

	Arnd
