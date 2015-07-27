Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx02.posteo.de ([89.146.194.165]:48310 "EHLO mx02.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753418AbbG0OJu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 27 Jul 2015 10:09:50 -0400
From: Martin Kepplinger <martink@posteo.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, mfuzzey@parkeon.com, roberta.dobrescu@gmail.com,
	robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	christoph.muellner@theobroma-systems.com
Subject: [PATCH v5 0/8] iio: mma8452: improve driver and support more chips
Date: Mon, 27 Jul 2015 16:08:07 +0200
Message-Id: <1438006095-26920-1-git-send-email-martink@posteo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Before I go away for holidays, this is version 5 of the mma8452 driver
improvements. This version removes the unnessasary DRIVER_NAME define and
improves the DT property "use_int2" to be extendible for any future additions
to the driver.

This is based on today's -next.


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
v5   DRIVER_NAME define removed; more flexible DT property
v4   cleanup; one bugfix patch removed from series; DT people added
v3   adds one patch to allow all possible pin wirings; adds more email
recipients
v2   splits the work into a series of smaller pieces
v1   initial post


