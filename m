Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:49810 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752644AbeDUAmK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 20 Apr 2018 20:42:10 -0400
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH 00/13] iio: tsl2x7x: staging cleanups
Date: Fri, 20 Apr 2018 20:41:40 -0400
Message-Id: <20180421004153.19073-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Here is another round of staging cleanups for this driver mostly based
on Jonathon's feedback. We're very close to a staging graduation and I
only have a few items remaining on my todo list:
 
- Remove wildcards from the driver name. Jonathan suggested tsl2571.
- Don't make the events/ directory available to user space via sysfs if
  an interrupt pin is not configured.
- Go through the newer ALS part numbers on AMS's site and see if there
  are other part numbers that can be added to this driver.
- I found this week an issue with the integration_time sysfs attribute.

Hopefully I'll have time to wrap this up next week.

Brian Masney (13):
  staging: iio: tsl2x7x: move integration_time* attributes to
    IIO_INTENSITY channel
  staging: iio: tsl2x7x: use GPL-2.0+ SPDX license identifier
  staging: iio: tsl2x7x: don't return error in IRQ handler
  staging: iio: tsl2x7x: simplify tsl2x7x_clear_interrupts function
  staging: iio: tsl2x7x: remove unnecessary chip status checks in
    suspend/resume
  staging: iio: tsl2x7x: simplify tsl2x7x_write_interrupt_config return
  staging: iio: tsl2x7x: simplify device id verification
  staging: iio: tsl2x7x: add range checking to three sysfs attributes
  staging: iio: tsl2x7x: move power and diode settings into header file
  staging: iio: tsl2x7x: rename prx to prox for consistency
  staging: iio: tsl2x7x: use device defaults for als_time, prox_time and
    wait_time
  staging: iio: tsl2x7x: various comment cleanups
  staging: iio: tsl2x7x: rename prox_config to als_prox_config

 drivers/staging/iio/light/tsl2x7x.c | 217 ++++++++++++++----------------------
 drivers/staging/iio/light/tsl2x7x.h |  81 +++++++-------
 2 files changed, 125 insertions(+), 173 deletions(-)

-- 
2.14.3

