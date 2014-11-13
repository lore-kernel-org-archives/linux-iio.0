Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:59837 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933146AbaKMUFp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 13 Nov 2014 15:05:45 -0500
Message-ID: <1415909105.30887.3.camel@hadess.net>
Subject: Re: Kernel wishlist item: Better IIO API
From: Bastien Nocera <hadess@hadess.net>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org,
	Lennart Poettering <lennart@poettering.net>,
	Cosimo Cecchi <cosimoc@gnome.org>
Date: Thu, 13 Nov 2014 21:05:05 +0100
In-Reply-To: <54513238.6050903@metafoo.de>
References: <1414593052.2406.37.camel@hadess.net>
			 <5451221D.6000301@metafoo.de> <1414604035.2406.41.camel@hadess.net>
		 <54512640.3040505@metafoo.de> <1414604840.2406.43.camel@hadess.net>
	 <54513238.6050903@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 2014-10-29 at 19:30 +0100, Lars-Peter Clausen wrote:
<snip>
> The sysfs ABI is not meant to be self documenting and it is not 
> undocumented. The documentation for the different attributes can be found in 
> Documentation/ABI/testing/sysfs-bus-iio[1].
<snip>
> I can understand your frustration. A API that is not usable in a generic way 
> is not really useful. So we should try to fix that, but we are bound by the 
> framework itself and can't just throw everything away.

I'll go back to this e-mail, and start again with very concrete examples
of my problems. I'm looking for shorter term gains here, while you can
look at my questions as inspiration for what needs fixing longer term :)

My goal is to move iio-sensor-proxy[1] into systemd's codebase, probably
in logind. I know of two different "types" of sensors that I'd like to
support, and 2 very different types of drivers.

The driver used in the Lenovo Yoga Pros (hid-sensor-accel-3d), which I
used to write the iio-sensor-proxy, requires the following procedure to
be used:
- find the accelerometer iio device (with the "accel_3d" name)
- find the associated trigger
- enable the sensors by writing to some files in scan_elements/
- enable the ring buffer by writing to buffer/enable
- enable the trigger found above by writing to trigger/current_trigger
- parse the files in scan_elements/ to find the channel array
- find the scale of each axis
- on some variants, tweak the hysteresis [2] to trigger changes
- and then read from the ring buffer on a regular basis, parse those
buffers, scale them, and we finally have the 3 dimensions we needed

The driver used in the Onda tablet I have is far less featureful.
- find the accelerometer iio device (this time called "i2c-SMO8500:00")
- build the channel array (?? I haven't found how)
- read the scale of each axis
- read directly from the sysfs files for each axis (?? surely not) on a
regular basis, scale the values, and we have the 3 dimensions

Is this at all correct? Is there documentation (the sysfs-bus-iio
doesn't tell me how to use this "API") that's available somewhere else,
or is there a more turn-key user-space library available?

Cheers

(I've been told that the Yoga should probably use the quaternion sensor
instead, it's planned, and so is writing user-space front-ends for the
compass in some devices).

[1]: https://github.com/hadess/iio-sensor-proxy
[2]: https://github.com/hadess/iio-sensor-proxy/issues/1#issuecomment-54536393

