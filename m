Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:38056 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516AbaKPWml convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 16 Nov 2014 17:42:41 -0500
References: <1414593052.2406.37.camel@hadess.net> <5451221D.6000301@metafoo.de> <1414604035.2406.41.camel@hadess.net> <54512640.3040505@metafoo.de> <1414604840.2406.43.camel@hadess.net> <54513238.6050903@metafoo.de> <1415909105.30887.3.camel@hadess.net> <5469214A.9000203@kernel.org>
Mime-Version: 1.0 (1.0)
In-Reply-To: <5469214A.9000203@kernel.org>
Content-Type: text/plain;
	charset=us-ascii
Message-Id: <1851AC2B-97B9-4D5F-BC1E-3BD7C265A2E2@hadess.net>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lennart Poettering <lennart@poettering.net>,
	Cosimo Cecchi <cosimoc@gnome.org>
From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Kernel wishlist item: Better IIO API
Date: Sun, 16 Nov 2014 23:42:36 +0100
To: Jonathan Cameron <jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> On 16 Nov 2014, at 23:12, Jonathan Cameron <jic23@kernel.org> wrote:
> 
>> The driver used in the Onda tablet I have is far less featureful.
>> - find the accelerometer iio device (this time called "i2c-SMO8500:00")
>> - build the channel array (?? I haven't found how)
>> - read the scale of each axis
>> - read directly from the sysfs files for each axis (?? surely not) on a
>> regular basis, scale the values, and we have the 3 dimensions
> On this second one, the driver has trigger and buffer support
> (not all drivers have as it's optional - doesn't make any sense for very
> slow devices and adds some complexity).
> 
> However, looking at that driver - the interrupt is optional. If
> it's not there (i.e. either the pin isn't connected, or the relevant
> information isn't supplied to the driver to tell it which interrupt
> is in use) then the driver does indeed only enable the polled mode.
> That is, it doesn't set up either the trigger or the buffer.
> 
> So the question is whether the tablet really doesn't route that pin
> or whether there is an issue in the driver identifying it.
> 
> Looking briefly back at the patch that added support for the SM08500
> it was clear then that we didn't have the interrupt.
> Hence we are into the realms of polling at some level...

I'll try to ask somebody with Windows on that tablet whether there is an interrupt associated with the device or not. It could very well be a problem with the ACPI support on that tablet (I'm still chasing battery reporting...)

> It would be fine to add support to the driver for a trigger that
> instead of using the interrupt simply polls the device - ugly but
> about all we can do here.  Looks like reading the int_source1 register
> will tell us whether new data is available...
> 
> So in conclusion - the issue here is that a rather nasty work around
> is needed for either a bad configuration or non optimal hardware design.
> 
> Still I guess there isn't much we can do about it...

But without the scan_elements subdir, I can't know what the device would spit out, so I need to use sysfs directly, not the dev node. Is that correct?

Cheers
