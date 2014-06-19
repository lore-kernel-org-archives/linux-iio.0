Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.cosmopool.net ([178.63.74.76]:47568 "EHLO
	mail.cosmopool.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752051AbaFSTqB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 19 Jun 2014 15:46:01 -0400
From: Harald Geyer <harald@ccbib.org>
To: Lars-Peter Clausen <lars@metafoo.de>
cc: linux-iio@vger.kernel.org
Subject: Re: iio: dht11 HW issues
In-reply-to: <5395A138.2030708@metafoo.de>
References: <E1WtlyB-00012Z-I6@stardust.g4.wien.funkfeuer.at> <5395A138.2030708@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 19 Jun 2014 21:45:39 +0200
Message-Id: <E1WxiHD-0000zG-Ae@stardust.g4.wien.funkfeuer.at>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Lars-Peter Clausen writes:
> On 06/09/2014 12:53 AM, Harald Geyer wrote:
> > Alas at least DHT22 seems to have hardware issues: After a few days
> > of operation (reading the sensor once per minute) the sensor seems
> > to stop responding entirely and the only way to fix this is to power
> > cycle the sensor.
> >
> > I have tried 3.3 V and 5 V supply and have observed this on at least
> > two pieces of hardware, so I'm pretty confident the issue is real.
> > The obvious solution is to use an additional gpio line to control
> > power for the sensor. Now I'm torn whether to handle this in kernel
> > space or user space: Since software using the sysfs ABI doesn't even
> > know (and shouldn't need to know) that the humidity values come from
> > a DHT22, this clearly should be handled be the kernel driver.
> >
> > OTOH there probably is an infinite number of algorithms (and HW
> > configurations) people might want to use to control power and coming
> > up with an ABI that allows implementing any of them, will be a
> > challange. Any guidance is appreciated.
> >
> 
> Yes, this sounds like an issue that should be handled transparently in the 
> kernel if possible. If you can detect that the sensor does not respond I'd 
> say add code to the kernel driver to issue a reset if that happens.

Detecting the loss of sensor response is easy. The hard part is figuring
out what to do about it and which ABI should be provided.

I guess just throwing in an additional (optional) gpio line to control
power isn't the kernel way of doing things and would be rather unflexible
for board designers. Somebody might want to control power of several
sensors with a single gpio line (or even other means but gpio) so 
probably a regulator is needed?

I'm thinking about something like

by default all driver instances set:
regulator_set_voltage(regulator, 0, max_operating_voltage)

if a driver instance is taking measurements it temporarily:
regulator_set_voltage(regulator, min_operating_voltage, max_operating_voltage)

if a driver instance detects loss of sensor response it does:
regulator_set_voltage(regulator, 0, 0)
for a fixed amount of time.

The downside of this: Taking multiple measurements in a row will cause the
sensors to power cycle a lot. (Might look like a brown out actually.)

Is there a better way of doing this or a more suitable framework than
regulators?

TIA,
Harald
