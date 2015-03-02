Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from h1.radempa.de ([176.9.142.194]:49446 "EHLO mail.cosmopool.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755900AbbCBVHD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 2 Mar 2015 16:07:03 -0500
From: Harald Geyer <harald@ccbib.org>
To: Jonathan Cameron <jic23@kernel.org>,
	John Stultz <john.stultz@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-iio@vger.kernel.org, Richard Weinberger <richard@nod.at>,
	Harald Geyer <harald@ccbib.org>
Subject: [PATCH 0/3] Provide new API to get the current time resolution
Date: Mon,  2 Mar 2015 20:56:03 +0000
Message-Id: <1425329766-14703-1-git-send-email-harald@ccbib.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch series introduces a new function
u32 ktime_get_resolution_ns(void)
and shows how this would be used in a driver that greatly benefits from
it.

Since the iio subsystem has it's own wrapper function iio_get_time_ns()
for timestamps a similiar wrapper iio_get_time_resolution_ns() is
introduce in Patch 2 to keep the API consistent.

Patch 3 updates the example driver. Patch 3 depends on other fixes
currently only iio.git. If Patch 3 can't be picked up now then it will
be resent with more cleanup patches to dht11.c later - the main goal
for now is, to get the new code for timekeeping reviewed and merged.

Harald Geyer (3):
  timekeeping: Provide new API to get the current time resolution
  iio: Provide new API to get the current resolution of timestamps
  iio: dht11: Use new function iio_get_time_resolution_ns()

 drivers/iio/humidity/dht11.c |   33 +++++++++++++++++----------------
 include/linux/iio/iio.h      |    5 +++++
 include/linux/timekeeping.h  |    1 +
 kernel/time/timekeeping.c    |   18 ++++++++++++++++++
 4 files changed, 41 insertions(+), 16 deletions(-)

-- 
1.7.2.5

