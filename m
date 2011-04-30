Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:55559 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755155Ab1D3KH1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Apr 2011 06:07:27 -0400
Message-ID: <4DBBDFE7.5060207@cam.ac.uk>
Date: Sat, 30 Apr 2011 11:09:43 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Prashant Shah <pshah.mumbai@gmail.com>
CC: linux-iio@vger.kernel.org, "Getz, Robin" <Robin.Getz@analog.com>
Subject: Re: drivers for usb daq card
References: <BANLkTikjnjSRtDRBHjXeMfHAOEsVzkkwag@mail.gmail.com>
In-Reply-To: <BANLkTikjnjSRtDRBHjXeMfHAOEsVzkkwag@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/30/11 08:33, Prashant Shah wrote:
> Hi,
> 
> I am total newbie and this is my first device drivers. I am trying to
> write drivers for National Instruments USB 6008 USB based data
> acquisition card.
> 
> I was initially trying to do that with the comedi based system but I
> was suggest to try working with the IIO sub system. 
That's curious. I was going to suggest you looked at comedi!
Out of interest, what was the reason given?
> I was reading
> through the IIO docs and IIO seems to be more targeted to SPI and I2C
> systems. I am not sure about how good is the support for USB based
> systems. 
Everything is bus independent. It just happens that our current parts
are all spi or i2c.
> I am newbie so I dont want to do something that will be hard
> for me to work with :)
Two initial questions.  Do you have the full docs? NI haven't been
helpful to my requests in the past (which has put me off ever using
their kit again).  Secondly, why does this want to be in kernel space?
Limitations of the usb bus often mean you can do almost as well
with a userspace driver and they tend to be easier to write / debug.
Based on a quick look at NI's website, I'd suggest doing a userspace
driver first for this part anyway to make sure you understand the
underlying interface to the device. libusb is great for this sort of
thing!
> 
> Also, we already have user space applications that interface with
> comedi like scilab and xoscope, etc. Will these applications that use
> the comedi based interface work with IIO ?
Not directly. The issue of sharing interfaces has been raised before
but I don't think any firm proposals have been made. Robin, are 
you aware of any progress on this?  It would probably be possible to
do this as a userspace library (I think all comedi calls go through
a library?).

Good luck!

Jonathan
> 
> Regards.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

