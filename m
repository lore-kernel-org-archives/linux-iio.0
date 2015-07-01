Return-Path: <martink@posteo.de>
From: Martin Kepplinger <martink@posteo.de>
To: pmeerw@pmeerw.net,
	jic23@kernel.org,
	christoph.muellner@theobroma-systems.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 0/8] iio: mma8452: support more devices and improve driver
Date: Wed,  1 Jul 2015 10:21:54 +0200
Message-Id: <1435738922-12580-1-git-send-email-martink@posteo.de>
List-ID: <linux-iio@vger.kernel.org>

This is the 2nd version that adds support for motion interrupts and 3 more
accelerometer chips, two of which use them because they don't support the
until now included transient interrupt sources:

MMA8453Q, MMA8652FC and MMA8653FC; datasheets are in the commit messages.

The driver and module name remains the same, seperating it from the device
names it now supports.

On top of this, there are minor documentation additions, and more notably,
the change of the existing iio event type from IIO_EV_TYPE_THRESH to
IIO_EV_TYPE_MAG since it's the magnitude of the threshold that is relevant
for these devices, not a signed value.

Please review and test if you can. For MMA8452Q, other than the event type,
nothing should have changed.
