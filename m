Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52709 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740AbaKPWMc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 16 Nov 2014 17:12:32 -0500
Message-ID: <5469214A.9000203@kernel.org>
Date: Sun, 16 Nov 2014 22:12:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Bastien Nocera <hadess@hadess.net>,
	Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org,
	Lennart Poettering <lennart@poettering.net>,
	Cosimo Cecchi <cosimoc@gnome.org>
Subject: Re: Kernel wishlist item: Better IIO API
References: <1414593052.2406.37.camel@hadess.net>			 <5451221D.6000301@metafoo.de> <1414604035.2406.41.camel@hadess.net>		 <54512640.3040505@metafoo.de> <1414604840.2406.43.camel@hadess.net>	 <54513238.6050903@metafoo.de> <1415909105.30887.3.camel@hadess.net>
In-Reply-To: <1415909105.30887.3.camel@hadess.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/11/14 20:05, Bastien Nocera wrote:
> On Wed, 2014-10-29 at 19:30 +0100, Lars-Peter Clausen wrote:
> <snip>
>> The sysfs ABI is not meant to be self documenting and it is not 
>> undocumented. The documentation for the different attributes can be found in 
>> Documentation/ABI/testing/sysfs-bus-iio[1].
> <snip>
>> I can understand your frustration. A API that is not usable in a generic way 
>> is not really useful. So we should try to fix that, but we are bound by the 
>> framework itself and can't just throw everything away.
> 
> I'll go back to this e-mail, and start again with very concrete examples
> of my problems. I'm looking for shorter term gains here, while you can
> look at my questions as inspiration for what needs fixing longer term :)
Sorry for my lack of proper reply.  Been a busy few weeks and long term
discussions always seem to get queued up behind patch reviews that need doing,
> 
> My goal is to move iio-sensor-proxy[1] into systemd's codebase, probably
> in logind. I know of two different "types" of sensors that I'd like to
> support, and 2 very different types of drivers.
cool
> 
> The driver used in the Lenovo Yoga Pros (hid-sensor-accel-3d), which I
> used to write the iio-sensor-proxy, requires the following procedure to
> be used:
> - find the accelerometer iio device (with the "accel_3d" name)
> - find the associated trigger
> - enable the sensors by writing to some files in scan_elements/
> - enable the ring buffer by writing to buffer/enable
> - enable the trigger found above by writing to trigger/current_trigger
You'll need to set the trigger before enabling the buffer...
> - parse the files in scan_elements/ to find the channel array
> - find the scale of each axis
> - on some variants, tweak the hysteresis [2] to trigger changes
interesting one. - Note I personally don't mind fixes for firmware bugs
in kernel - if there is a simple way of identifying parts with the problem.
> - and then read from the ring buffer on a regular basis, parse those
> buffers, scale them, and we finally have the 3 dimensions we needed
Hmm.. We did have a handy watermark patch set back in August that got
stuck up on details and would make this slightly nicer.  I'll chase
that one up when I get a chance.
> 
> The driver used in the Onda tablet I have is far less featureful.
> - find the accelerometer iio device (this time called "i2c-SMO8500:00")
> - build the channel array (?? I haven't found how)
> - read the scale of each axis
> - read directly from the sysfs files for each axis (?? surely not) on a
> regular basis, scale the values, and we have the 3 dimensions
On this second one, the driver has trigger and buffer support
(not all drivers have as it's optional - doesn't make any sense for very
 slow devices and adds some complexity).

However, looking at that driver - the interrupt is optional. If
it's not there (i.e. either the pin isn't connected, or the relevant
information isn't supplied to the driver to tell it which interrupt
is in use) then the driver does indeed only enable the polled mode.
That is, it doesn't set up either the trigger or the buffer.

So the question is whether the tablet really doesn't route that pin
or whether there is an issue in the driver identifying it.

Looking briefly back at the patch that added support for the SM08500
it was clear then that we didn't have the interrupt.
Hence we are into the realms of polling at some level...

It would be fine to add support to the driver for a trigger that
instead of using the interrupt simply polls the device - ugly but
about all we can do here.  Looks like reading the int_source1 register
will tell us whether new data is available...

So in conclusion - the issue here is that a rather nasty work around
is needed for either a bad configuration or non optimal hardware design.

Still I guess there isn't much we can do about it...
> 
> Is this at all correct? Is there documentation (the sysfs-bus-iio
> doesn't tell me how to use this "API")
True enough, the docs are rather more in the form of the example
program (drivers/staging/iio/Documentation) than explicit docs.
The docs that do exist tend to lag behind the code unfortunately
and since things have gotten rather more stable no one has had
the time to write a full set.

> that's available somewhere else,
> or is there a more turn-key user-space library available?
> 
> Cheers
> 
> (I've been told that the Yoga should probably use the quaternion sensor
> instead, it's planned, and so is writing user-space front-ends for the
> compass in some devices).
> 
> [1]: https://github.com/hadess/iio-sensor-proxy
> [2]: https://github.com/hadess/iio-sensor-proxy/issues/1#issuecomment-54536393
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

