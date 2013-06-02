Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: mirq-linux@rere.qmqm.pl,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/4 V2]  iio: Rework the generic trigger-gpio trigger and move out of staging
Date: Sun,  2 Jun 2013 20:00:12 +0100
Message-Id: <1370199616-25500-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

Only changes here are dropping the irq_res_cnt as it unused (thanks Lars) and
a rebase as a result of some Kconfig dependency changes.

I still don't have a hardware setup, but this is so simple that unless
someone shouts I'll probably send it upstream in fairly soon anyway.

Jonathan

Previous message:

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
 drivers/iio/trigger/iio-trig-interrupt.c    | 121 ++++++++++++++++++++
 drivers/staging/iio/trigger/Kconfig         |   6 -
 drivers/staging/iio/trigger/Makefile        |   1 -
 drivers/staging/iio/trigger/iio-trig-gpio.c | 167 ----------------------------
 6 files changed, 131 insertions(+), 174 deletions(-)
 create mode 100644 drivers/iio/trigger/iio-trig-interrupt.c
 delete mode 100644 drivers/staging/iio/trigger/iio-trig-gpio.c

-- 
1.8.2.3
