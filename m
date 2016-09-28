Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34264 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbcI1R7k (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Sep 2016 13:59:40 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v5 0/2] Add IIO support for counter devices
Date: Wed, 28 Sep 2016 13:59:32 -0400
Message-Id: <cover.1475079578.git.vilhelm.gray@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes in v5:
  - Refactored scale to handle values of 1, 0.5, and 0.25, in order to
    be consistent with the multiplication usage of the other interfaces
  - Reimplemented preset as an ext_info since the preset functionality
    is rather device specific
  - Reimplemented ab_enable ext_info as IIO_CHAN_INFO_ENABLE; this
    should make the counter enable/disable interface more intuitive
  - Renamed "preset_enable" attribute to "set_to_preset_on_index" (and
    refactored as a boolean) to make the functionality clearer
  - Updated documentation to account for the changes in this patchset

This patchset adds new IIO channel type constants to facilitate support
for counter devices. In addition, a new "counter" subdirectory is
created to house drivers for these counter devices.

Quadrature encoders, such as rotary encoders and linear encoders, are
devices which are capable of encoding the relative position and
direction of motion of a shaft. This patchset introduces several IIO
constants for supporting quadrature encoder counter devices.

  IIO_COUNT: Current count (main data provided by the counter device)
  IIO_INDEX: Counter device index value

Specifically, this patchset introduces a driver to support the ACCES
104-QUAD-8 device, a general purpose quadrature encoder
counter/interface board capable of monitoring the outputs of eight
encoders.

William Breathitt Gray (2):
  iio: Implement counter channel type and info constants
  iio: 104-quad-8: Add IIO support for the ACCES 104-QUAD-8

 Documentation/ABI/testing/sysfs-bus-iio            |  18 +
 .../ABI/testing/sysfs-bus-iio-counter-104-quad-8   | 125 +++++
 MAINTAINERS                                        |   6 +
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/counter/104-quad-8.c                   | 593 +++++++++++++++++++++
 drivers/iio/counter/Kconfig                        |  24 +
 drivers/iio/counter/Makefile                       |   7 +
 drivers/iio/industrialio-core.c                    |   2 +
 include/uapi/linux/iio/types.h                     |   2 +
 10 files changed, 779 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
 create mode 100644 drivers/iio/counter/104-quad-8.c
 create mode 100644 drivers/iio/counter/Kconfig
 create mode 100644 drivers/iio/counter/Makefile

-- 
2.7.3

