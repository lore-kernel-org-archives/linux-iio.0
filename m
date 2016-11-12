Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:55844 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966447AbcKLSTp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Nov 2016 13:19:45 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH v4 00/26] staging: iio: tsl2583: move out of staging
Date: Sat, 12 Nov 2016 13:19:15 -0500
Message-Id: <1478974781-1457-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch set continues my work to clean up the tsl2583 driver to move
it out of staging. Some highlights include:

- Eliminated some unnecessary i2c calls to the sensor.
- Fixed issue with changes to calibscale and int_time not being set on
  the chip.
- Moved from a global lux table to a per device lux table.
- Combined redundant sysfs ABI documentation.
- Made log messages clearer.
- Fixes for some return values that were not checked.
- Chip state is now represented as a boolean instead of a tristate.
- Removed unnecessary chip status checks.
- Use a unified prefix for all symbols (tsl2583_).
- Code style and formatting cleanups.
- Comment cleanups.
- Staging graduation.

I verified that the driver functions correctly using a TSL2581 hooked
up to a Raspberry Pi 2.

Changes from V3 to V4
- Fixed patch 03/28 so that it compiles properly. It was fixed later
  in the old series but this needs to be corrected so that people can
  use git bisect. I verified that every patch in this series compiles
  when incrementally applied.
- Clarified comment on patch 14 in this series.
- Use sizeof(value[1]) instead of sizeof(unsigned int) when updating
  the lux table on patch 18 of this series.

Changes from V2 to V3
- Fixed patch #09 to use "%s: <message>", __func__ consistently. Added
  missing terminating "\n" to one of the log messages. Issues reported
  by Joe Perches.
- Fixed issues found by Jonathan Cameron: comment cleanups, improved the
  wording of two log messages, removed an unnecessary memset call,
  removed unnecessary variable initialization, and multiple driver
  authors can be specified with multiple calls to MODULE_AUTHOR().
- Fixed warning found by make C=1 in the per device lux table:
  warning: Variable length array is used.

Changes from V1 to V2
- The first 7 patches in this series contains version 2 of the patches
  7-9 that I sent out on 2016-11-03. The only change is that the patches
  are split up further to make the code review easier.

Brian Masney (26):
  staging: iio: tsl2583: check if chip is in a working state in
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
  staging: iio: tsl2583: add tsl2583 to list of supported devices in the
    header
  staging: iio: tsl2583: clarified comment about clearing interrupts
  staging: iio: tsl2583: remove comment for tsl2583_probe()
  staging: iio: tsl2583: remove unnecessary memset call
  staging: iio: tsl2583: remove unnecessary variable initialization
  staging: iio: tsl2583: add copyright and MODULE_AUTHOR
  staging: iio: tsl2583: move out of staging

 .../ABI/testing/sysfs-bus-iio-light-tsl2583        |  20 +
 drivers/iio/light/Kconfig                          |   7 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/tsl2583.c                        | 913 +++++++++++++++++++++
 .../light/sysfs-bus-iio-light-tsl2583              |   6 -
 .../iio/Documentation/sysfs-bus-iio-light-tsl2583  |  20 -
 drivers/staging/iio/light/Kconfig                  |   7 -
 drivers/staging/iio/light/Makefile                 |   1 -
 drivers/staging/iio/light/tsl2583.c                | 896 --------------------
 9 files changed, 941 insertions(+), 930 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-light-tsl2583
 create mode 100644 drivers/iio/light/tsl2583.c
 delete mode 100644 drivers/staging/iio/Documentation/light/sysfs-bus-iio-light-tsl2583
 delete mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-light-tsl2583
 delete mode 100644 drivers/staging/iio/light/tsl2583.c

-- 
2.7.4

