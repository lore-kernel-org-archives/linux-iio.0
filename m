Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43185 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754177Ab3EFRVN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 6 May 2013 13:21:13 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Jonathan Cameron <jic23@kernel.org>
Subject: [RFC PATCH 0/4] iio: Rework the generic trigger-gpio trigger and move out of staging
Date: Mon,  6 May 2013 18:20:59 +0100
Message-Id: <1367860863-6863-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi all,

This is an RFC for a couple of reasons.

1) I'm not sure how people feel about the move to multiple platform devices
(patch 3).
2) I don't actually have a simple test setup for this one.  I can put one
together but it might be a while before I get it done.

Anyhow, the purpose of this set is to respond to Lars-Peter's comments
when I originally asked if anyone minded it moving out of staging as it
was before this.  Lars raised the point that having one driver instance
register multiple triggers just made life more complicated, and instead
it might be better to have multiple driver instances, with one trigger each.
Lars also pointed out that the name of the driver was silly given there
was nolonger a requirement that the source of the interrupts be a gpio
and there hasn't been for quite some time.

All comments welcome. Particularly wrt to patch 3.

Jonathan Cameron (4):
  staging:iio:trigger:gpio bug in release of gpio in error path
  staging:iio:triggers: rename iio-trig-gpio to iio-trig-interrupt
  staging:iio:triggers:interrupt trigger - one per platform device.
  iio:triggers:interrupt trigger - move out of staging.

 drivers/iio/trigger/Kconfig                 |   9 ++
 drivers/iio/trigger/Makefile                |   1 +
 drivers/iio/trigger/iio-trig-interrupt.c    | 123 ++++++++++++++++++++
 drivers/staging/iio/trigger/Kconfig         |   6 -
 drivers/staging/iio/trigger/Makefile        |   1 -
 drivers/staging/iio/trigger/iio-trig-gpio.c | 167 ----------------------------
 6 files changed, 133 insertions(+), 174 deletions(-)
 create mode 100644 drivers/iio/trigger/iio-trig-interrupt.c
 delete mode 100644 drivers/staging/iio/trigger/iio-trig-gpio.c

-- 
1.8.2.1

