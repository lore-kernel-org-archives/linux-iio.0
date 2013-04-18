Return-Path: <lars@metafoo.de>
Message-ID: <51704643.5020203@metafoo.de>
Date: Thu, 18 Apr 2013 21:15:15 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: iio: Gpio trigger driver.  Happy with interface?
References: <516A99AA.50905@jic23.retrosnub.co.uk>
In-Reply-To: <516A99AA.50905@jic23.retrosnub.co.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 04/14/2013 01:57 PM, Jonathan Cameron wrote:
> Hi all,
> 
> I have no idea how often people are using the GPIO trigger driver but what I am
> looking for here is a discussion (hopefully brief) of the interface and means
> of registering gpio triggers.  To my mind it makes little sense to have this
> via a nice userspace control like the sysfs triggers.  If you are using a gpio
> for a trigger it is probably a hardware design related descision.
> 

Just remembered I wanted to your mail...

I think the interface is fine, there isn't much of an interface anyway. One
suggestion though, maybe make it one interrupt per device. And the name is
outdated, there are no gpio specific bits in the driver anymore. It's a pure
IRQ based trigger these days.

- Lars
