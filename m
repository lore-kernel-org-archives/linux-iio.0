Return-Path: <martink@posteo.de>
From: Martin Kepplinger <martink@posteo.de>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	mfuzzey@parkeon.com,
	roberta.dobrescu@gmail.com,
	robh+dt@kernel.org,
	pawel.moll@arm.com,
	mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org
Cc: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	christoph.muellner@theobroma-systems.com
Subject: [PATCH v4 0/8] iio:mma8452: improve driver and support more chips
Date: Mon,  6 Jul 2015 14:34:14 +0200
Message-Id: <1436186062-5766-1-git-send-email-martink@posteo.de>
List-ID: <linux-iio@vger.kernel.org>

This is version 4 of the mma8452 driver improvements. This version removes
one patch that changed the iio event type for existing users. It can be
dealt with seperately and this series applies without it.

Also, changes according to Jonathan's review are applied and a few
devicetree maintainers are added as recipients.


These changes add support for motion interrupts and 3 more accelerometer
chips, two of which use them because they don't support the until now
included transient interrupt sources:

MMA8453Q, MMA8652FC and MMA8653FC; datasheets are in the commit messages.

The driver and module name remains the same, seperating it from the device
names it now supports.

On top of this, there are minor documentation additions, and more notably,
 it allows to use the driver, no matter how the interrupt pins are wired
on your board.

Please review and test if you can. For MMA8452Q, nothing should have
changed.

revision history
----------------
v4   cleanup; one bugfix patch removed from series; DT people added
v3   adds one patch to allow all possible pin wirings; adds more email
     recipients
v2   splits the work into a series of smaller pieces
v1   initial post
