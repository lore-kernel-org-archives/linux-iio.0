Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:41528 "EHLO mout01.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751516AbbLOQqQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 15 Dec 2015 11:46:16 -0500
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
	by mout01.posteo.de (Postfix) with ESMTPS id B936720ABD
	for <linux-iio@vger.kernel.org>; Tue, 15 Dec 2015 17:46:15 +0100 (CET)
From: Martin Kepplinger <martink@posteo.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, christoph.muellner@theobroma-systems.com,
	mfuzzey@parkeon.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCHv2 0/3] iio: mma8452: cleanup and freefall mode
Date: Tue, 15 Dec 2015 17:44:58 +0100
Message-Id: <1450197901-9826-1-git-send-email-martink@posteo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is v2 of cleanup and freefall detection for mma8452 devices.

[PATCH 1/3] iio: mma8452: remove unused register description
[PATCH 2/3] iio: mma8452: use enum for channel index
[PATCH 3/3] iio: mma8452: add freefall detection for Freescale's

If freefall mode (x&y&z falling event) is enabled, changes to individual
(rising) axis events have no effect, keeping the state consistent to
what values the user reads.

Other combinations (x&y, y&z, x&z) could be added later. x&y&z is
by far the most useful one for freefall detection.

Of course this doesn't change anything for existing users.

revision history
----------------
v2: freefall channel idx -1, seperate enum patch, cleanup and fixes
    thanks to Jonathan's review.

