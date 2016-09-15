Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yb0-f193.google.com ([209.85.213.193]:35780 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751671AbcIOOug (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Sep 2016 10:50:36 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v3 0/2] Add IIO support for counter devices
Date: Thu, 15 Sep 2016 10:50:12 -0400
Message-Id: <cover.1473950198.git.vilhelm.gray@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes in v3:
  - Moved addition of counter subdirectory with the introduction of the
    104-QUAD-8 driver; this should prevent an unpopulated Makefile from
    existing in an empty counter subdirectory
  - Remove flg1 ext_info. In the 104-QUAD-8, the FLG1 pin is used to
    trigger interrupts; I plan to add interrupt support in a later
    patch, so for now interrupts are disabled by this driver (FLG1 pin
    is ignored).

This patchset adds new IIO channel type and info constants to facilitate
support for counter devices. In addition, a new "counter" subdirectory
is created to house drivers for these counter devices.

Quadrature encoders, such as rotary encoders and linear encoders, are
devices which are capable of encoding the relative position and
direction of motion of a shaft. This patchset adds several IIO constants
for supporting quadrature encoder counter devices.

  IIO_COUNT: Current count (main data provided by the counter device)
  IIO_INDEX: Set high when index input is at active level
  IIO_CHAN_INFO_PRESET: Counter preset value

Specifically, this patchset introduces a driver to support the ACCES
104-QUAD-8 device, a general purpose quadrature encoder
counter/interface board capable of monitoring the outputs of eight
encoders.

William Breathitt Gray (2):
  iio: Implement counter channel type and info constants
  iio: 104-quad-8: Add IIO support for the ACCES 104-QUAD-8

 MAINTAINERS                      |   6 +
 drivers/iio/Kconfig              |   1 +
 drivers/iio/Makefile             |   1 +
 drivers/iio/counter/104-quad-8.c | 654 +++++++++++++++++++++++++++++++++++++++
 drivers/iio/counter/Kconfig      |  22 ++
 drivers/iio/counter/Makefile     |   7 +
 drivers/iio/industrialio-core.c  |   3 +
 include/linux/iio/iio.h          |   1 +
 include/uapi/linux/iio/types.h   |   2 +
 9 files changed, 697 insertions(+)
 create mode 100644 drivers/iio/counter/104-quad-8.c
 create mode 100644 drivers/iio/counter/Kconfig
 create mode 100644 drivers/iio/counter/Makefile

-- 
2.7.3

