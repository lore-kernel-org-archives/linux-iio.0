Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:46236 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754102Ab1F1Juv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jun 2011 05:50:51 -0400
Message-ID: <4E09A5E0.7030300@cam.ac.uk>
Date: Tue, 28 Jun 2011 10:58:56 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Variable accuracy devices.
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi All,

There are a couple of different types of variable accuracy drivers in three.

1) Devices with variable gain - these are well handled

2) Devices with variable number of bits per sample. Typically they will
   do higher accuracy at a slower rate.

3) Variable bit depths in hardware ring buffers (sca3000 only - currently
glossed over).


In case 2 we have for example the adis16130 gyro driver (a very simple driver).
This one doesn't currently implement buffered capture, so our only read route
is through the sysfs attributes.   So my question here is whether there is
a use case for sampling at anything other than maximum accuracy if we are
reading via a slow path anyway?  Basically I'd like to drop the non standard
interface that this driver has.

Case 3 is one I've been avoiding mainly because it only exists in one driver
right now and that one is for a long deprecated part.   It is however similar
to a controllable nbit adc or indeed the adis16130 gyro.  In those cases we
want to be able to control the accuracy of data that is captured into a
software buffer.  Right now we don't have an easy way of doing this.

The solution that comes to mind is:
Additional optional callback within ring_setup_ops (it kind of fits in there
if we broaden the term setup somewhat), checked by equivalent replacement
of iio_show_fixed_type.  If it's present, the driver is queried, if not then
we use the fixed type stuff from the iio_chan_spec structure.  Clearly
we will also need a write function.  The matching _available attribute
could be done by a second callback.

What do people think?

Thanks,

Jonathan
