Return-Path: <alan@lxorguk.ukuu.org.uk>
Date: Mon, 6 Sep 2010 15:48:00 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>,
        LKML
 <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>,
        Jean Delvare <khali@linux-fr.org>, Greg KH
 <greg@kroah.com>,
        Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [IIO] Proposal for sysfs attributes
Message-ID: <20100906154800.53522fc7@lxorguk.ukuu.org.uk>
In-Reply-To: <4C84F80C.2050702@cam.ac.uk>
References: <4C84A93B.2050507@iis.fraunhofer.de>
	<4C84E64D.4040600@jic23.retrosnub.co.uk>
	<20100906143256.6b49825d@lxorguk.ukuu.org.uk>
	<4C84F80C.2050702@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

> I'm afraid I have lost you here.  Why restrict to powers of 10?  The buffered
> route is going to ship whatever the chip actually produces.

Then I don't see the point of IIO over a million random misc API's of the
week. Giving 50,000 interfaces the same name doesn't actually achieve
anything or solve any real problems.

The job of the OS is to provide an *abstraction*. If IIO won't do that I
don't see the point of IIO.

The current situation is

	Random gadget added with own API
	Qt sensors module is written for said gadget

IIO is offering no improvement if it won't abstract in a controlled
fashion.
