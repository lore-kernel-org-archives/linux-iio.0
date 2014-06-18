Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:63089 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396AbaFRXbu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Jun 2014 19:31:50 -0400
Received: by mail-wg0-f50.google.com with SMTP id x13so1512563wgg.21
        for <linux-iio@vger.kernel.org>; Wed, 18 Jun 2014 16:31:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1403100542.30918.29.camel@nuvo>
References: <1403100542.30918.29.camel@nuvo>
From: Reyad Attiyat <reyad.attiyat@gmail.com>
Date: Wed, 18 Jun 2014 18:31:29 -0500
Message-ID: <CA+BWVUSqrJhFwKXHL5q=mwcxmasfkpNB6EqEXC6jPfg0ytOVzA@mail.gmail.com>
Subject: Re: User-space API for accelerometer(s)?
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-iio@vger.kernel.org,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Bastien Nocera,

I'm not the best person to answer your questions but I will try and
help. The best people to talk to would be Jonathan Cameron, the IIO
maintainer, and Srinivas Pandruvada, the author of the hid-sensor-hub
device drivers. I have CC'ed them for you to hopefully get a better
response than what I can offer.

Your device uses the same sensor hub, over usb, as my device does. I
have a Microsoft Surface and it also uses many of the sensors found on
the Lenovo Yoga.

> So, my question regarding the IIO user-space API is:
> is it possible to make the IIO accelerometer send out a kevent when the
> orientation changes in a major way (using triggers?) or does user-space
> need to poll the device instead?

Of course it's possible but this does not occur in the current hid
sensor hub drivers, from my understanding of the code. You should
probably check out the current documentation on the IIO sysfs user
interface:
https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-bus-iio

These outline the possible attributes sysfs offers. As of now the only
ones that are found on the hid sensor hub devices is _raw as of 3.16
and _scale, _offset, _sampling_frequency, _hysteresis. The raw
attribute lets you read the data that is at the top of the iio buffer.
As you can see in the documentation there are many events support by
other drivers that could possible be implemented by the hid-sensor-hub
devices.

IIO devices use a buffer that have a fixed size. It can be enabled
with the sysfs interface. An example of this can be found in the
kernel (drivers/staging/iio/iio_simple_dummy_buffer.c) there is also
additional documentation there as well as dummy drivers.

To use these interfaces in user space, or in the context of GNOME
desktop, I think you would need to poll the iio buffer for new data
and calculate the changes that way. The iio subsystem does support
events but you would need to add these to the hid-sensor-hub devices
and do the calculations for each event. This would allow you to poll
for these iio events instead of polling the buffer.

Hope this helps,
Reyad Attiyat
