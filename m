Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:44289
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752250AbdEDUe1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 May 2017 16:34:27 -0400
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: linux-pm@vger.kernel.org
Cc: keescook@chromium.org, kernel-janitors@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-omap@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH 0/9] Drop unnecessary static
Date: Thu,  4 May 2017 22:10:45 +0200
Message-Id: <1493928654-18768-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

These patches fix cases where there is a static on a local variable, but
the variable is either first initialized or never used, on every possible
execution path through the function.  The static has no benefit, and
dropping it reduces the code size.

---

 drivers/block/drbd/drbd_nl.c            |    2 +-
 drivers/clocksource/timer-fttmr010.c    |    2 +-
 drivers/iio/accel/hid-sensor-accel-3d.c |    2 +-
 drivers/mfd/max8925-i2c.c               |    2 +-
 drivers/mfd/twl4030-irq.c               |    2 +-
 drivers/mtd/chips/cfi_cmdset_0020.c     |    2 +-
 drivers/mtd/maps/physmap_of_gemini.c    |    2 +-
 drivers/power/supply/axp20x_usb_power.c |    2 +-
 drivers/regulator/palmas-regulator.c    |    2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)
