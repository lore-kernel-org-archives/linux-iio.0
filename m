Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:57945 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbaFROJJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Jun 2014 10:09:09 -0400
Message-ID: <1403100542.30918.29.camel@nuvo>
Subject: User-space API for accelerometer(s)?
From: Bastien Nocera <hadess@hadess.net>
To: linux-iio@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Wed, 18 Jun 2014 16:09:02 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hey,

I'm trying to integrate the accelerometer of the Lenovo Yoga into GNOME
and a modern desktop. The accelerometer is exported through an IIO
device as per:
https://github.com/pfps/yoga-laptop/blob/master/sensors/orientation.c

We already have some integration for accelerometers in udev/systemd and
GNOME, and they rely on the accelerometer being an input device, being
tagged with the ID_INPUT_ACCELEROMETER and sending out a kevent/uevent
when a major orientation change took place. This is handled by:
http://cgit.freedesktop.org/systemd/systemd/tree/src/udev/accelerometer/accelerometer.c
for the WeTab/Pegatron devices for example.

So, my question regarding the IIO user-space API is:
is it possible to make the IIO accelerometer send out a kevent when the
orientation changes in a major way (using triggers?) or does user-space
need to poll the device instead?

If the former, I intend on writing a small helper to set up the
accelerometer, and a helper similar to the one already in the udev tree.

If the latter, I'll probably write a long-running helper, which would
offer the same interface as the one used by the Pegatron accelerometer
driver, so that we don't need to make any more changes to user-space.

Cheers

