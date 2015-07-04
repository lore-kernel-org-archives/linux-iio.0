Return-Path: <martink@posteo.de>
From: Martin Kepplinger <martink@posteo.de>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	mfuzzey@parkeon.com,
	roberta.dobrescu@gmail.com,
	christoph.muellner@theobroma-systems.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 0/9] iio: mma8452: improve driver and support more chips
Date: Sat,  4 Jul 2015 15:55:01 +0200
Message-Id: <1436018110-3903-1-git-send-email-martink@posteo.de>
List-ID: <linux-iio@vger.kernel.org>

This is version 3 of the mma8452 driver improvements. Version 3 adds one
patch to allow all possible pin wirings for users and adds more relevant
people to the discussion, I forgot about before. I'm sorry.

These changes add support for motion interrupts and 3 more accelerometer
chips, two of which use them because they don't support the until now
included transient interrupt sources:

MMA8453Q, MMA8652FC and MMA8653FC; datasheets are in the commit messages.

The driver and module name remains the same, seperating it from the device
names it now supports.

On top of this, there are minor documentation additions, and more notably,
the change of the existing iio event type from IIO_EV_TYPE_THRESH to
IIO_EV_TYPE_MAG since it's the magnitude of the threshold that is relevant
for these devices, not a signed value. Finally it allows to use the driver,
no matter how the interrupt pins are wired on your board.

Please review and test if you can. For MMA8452Q, other than the event type,
nothing should have changed.

revision history
----------------
v3   adds one patch to allow all possible pin wirings; adds more email
     recipients
v2   splits the work into a series of smaller pieces
v1   initial post
