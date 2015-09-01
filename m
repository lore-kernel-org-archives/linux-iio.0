Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:48927 "EHLO mout01.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755269AbbIALyP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 1 Sep 2015 07:54:15 -0400
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
	by mout01.posteo.de (Postfix) with ESMTPS id 9BE9220B83
	for <linux-iio@vger.kernel.org>; Tue,  1 Sep 2015 13:47:05 +0200 (CEST)
From: Martin Kepplinger <martink@posteo.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, mfuzzey@parkeon.com, roberta.dobrescu@gmail.com,
	robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	christoph.muellner@theobroma-systems.com
Subject: [PATCHv6 0/6] iio: mma8452: improve driver and support more chips
Date: Tue,  1 Sep 2015 13:45:07 +0200
Message-Id: <1441107913-4112-1-git-send-email-martink@posteo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Version 6 of the mma8452 driver improvements. This is rebased on the current
-next tree because of cleanup changes in the meantime. Also, the patches are
slightly more cleaned up (adding the DT bindings document in the right patch).
Here we go:


These changes add support for motion interrupts and 3 more accelerometer
chips, two of which use them because they don't support the until now
included transient interrupt sources:

MMA8453Q, MMA8652FC and MMA8653FC; datasheets are in the commit messages.
The driver and module name remains the same, seperating it from the device
names it now supports.

Please review and test if you can. For MMA8452Q, nothing should have
changed.

revision history
----------------
v6   rebase! remove one patch (adding a new DT property). minor patch cleanup.
v5   DRIVER_NAME define removed; more flexible DT property
v4   cleanup; one bugfix patch removed from series; DT people added
v3   adds one patch to allow all possible pin wirings; adds more email
recipients
v2   splits the work into a series of smaller pieces
v1   initial post

