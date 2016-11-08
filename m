Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:46822 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932562AbcKHKQ7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 8 Nov 2016 05:16:59 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH v2 00/23] staging: iio: tsl2583: move out of staging
Date: Tue,  8 Nov 2016 05:16:25 -0500
Message-Id: <1478600208-21153-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The first 7 patches in this series contains version 2 of the patches
7-9 that I sent out on 2016-11-03. The only change is that the patches
are split up further to make the code review easier.

Patches 8-23 in this series are new and some of the highlights include:

- Moved from a global lux table to a per device lux table.
- Combined redundant sysfs ABI documentation
- Made log messages clearer
- Code style and formatting cleanups
- Staging graduation

I verified that the driver functions correctly using a TSL2581 hooked up
to a Raspberry Pi 2.

Brian Masney (23):
  staging: iio: tsl2583: split out functionality of taos_chip_on()
  staging: iio: tsl2583: fix issue with changes to calibscale and
    int_time not being set on the chip
  staging: iio: tsl2583: check if chip is suspended in
    in_illuminance_calibrate_store
  staging: iio: tsl2583: remove unnecessary chip status check in
    taos_get_lux
  staging: iio: tsl2583: remove unnecessary chip status checks in
    suspend/resume
  staging: iio: tsl2583: change current chip state from a tristate to a
    bool
  staging: iio: tsl2583: remove redundant write to the control register
    in taos_probe()
  staging: iio: tsl2583: remove the FSF's mailing address
  staging: iio: tsl2583: cleaned up logging
  staging: iio: tsl2583: unify function and variable prefix to tsl2583_
  staging: iio: tsl2583: fix alignment of #define values
  staging: iio: tsl2583: fix comparison between signed and unsigned
    integers
  staging: iio: tsl2583: change newlines to improve readability
  staging: iio: tsl2583: combine sysfs documentation
  staging: iio: tsl2583: fix multiline comment syntax
  staging: iio: tsl2583: updated code comment to match what the code
    does
  staging: iio: tsl2583: moved code block inside else statement
  staging: iio: tsl2583: change tsl2583_als_calibrate() to return 0 on
    success
  staging: iio: tsl2583: remove unnecessary parentheses
  staging: iio: tsl2583: don't assume an unsigned int is 32 bits
  staging: iio: tsl2583: move from a global to a per device lux table
  staging: iio: tsl2583: updated copyright and MODULE_AUTHOR
  staging: iio: tsl2583: move out of staging

 .../ABI/testing/sysfs-bus-iio-light-tsl2583        |  20 +
 drivers/iio/light/Kconfig                          |   7 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/tsl2583.c                        | 916 +++++++++++++++++++++
 .../light/sysfs-bus-iio-light-tsl2583              |   6 -
 .../iio/Documentation/sysfs-bus-iio-light-tsl2583  |  20 -
 drivers/staging/iio/light/Kconfig                  |   7 -
 drivers/staging/iio/light/Makefile                 |   1 -
 drivers/staging/iio/light/tsl2583.c                | 892 --------------------
 9 files changed, 944 insertions(+), 926 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-light-tsl2583
 create mode 100644 drivers/iio/light/tsl2583.c
 delete mode 100644 drivers/staging/iio/Documentation/light/sysfs-bus-iio-light-tsl2583
 delete mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-light-tsl2583
 delete mode 100644 drivers/staging/iio/light/tsl2583.c

-- 
2.7.4

