Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:41930 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751136AbdLSQFf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Dec 2017 11:05:35 -0500
Received: by mail-wm0-f67.google.com with SMTP id g75so4756046wme.0
        for <linux-iio@vger.kernel.org>; Tue, 19 Dec 2017 08:05:35 -0800 (PST)
From: Crt Mori <cmo@melexis.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH v8 0/3] iio: temperataure: MLX90632
Date: Tue, 19 Dec 2017 17:05:25 +0100
Message-Id: <20171219160525.30641-1-cmo@melexis.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi everybody,

With the sensor now available to broad public, it is time to also
share the driver with the community. MLX90632 is just 3x3mm in size,
but with factory calibration offers instant usage in every project.

Driver currently provides basic functionality, but I might add
some more fancy features after a while.

v2 includes comments from Rob Herring (dt-bindings) and Jonathan
Cameron (iio), as well as proposal to split out int_sqrt64 function
into the linux/kernel.h

v3 comments were added to some parts of mlx90632.c and TENTO defines
replaced by values. Fixes were done to emissivity read/write and
changed to INT_PLUS_MICRO instead. Empty line in int_sqrt.c was
removed as it generated a warning when applying.

v4 CONFIG_PM replaced by __maybe_unused, some cleanup in suspend,
EEPROM_VERSION identifier is grouped together in one single number
instead of assembled on fly. Replaced license on top with SPDX.
Most importantly - reordered patches so that lib is added before
the driver itself (which uses it).

v5 Re-ordered patches so that dt-bindings is before driver patch
as per Andreas Farber remark. Using same function for Power
Management during runtime and suspend, as the runtime state
already puts device to lowest possible state (without power off)
and that is why special state for suspend is not needed at the
current moment. Added few more checks of current PM state and
move marking regmap dirty to suspend instead of resume.

v6 Adding usage of UNIVERSAL_DEV_PM_OPS macro for PM function
mapping.

v7 Rework usage of int_sqrt according to Joe Perches and fixing
return size to u32 as per Peter Zijlstra suggestion, as sqrt of
64bit number cannot be have more than 32bits.

v8 Small style fixup in the comment

Crt Mori (3):
  lib: Add strongly typed 64bit int_sqrt
  dt-bindings: iio: temperature: add MLX90632 device bindings
  iio: temperature: Adding support for MLX90632

 .../bindings/iio/temperature/mlx90632.txt          |  28 +
 MAINTAINERS                                        |   7 +
 drivers/iio/temperature/Kconfig                    |  12 +
 drivers/iio/temperature/Makefile                   |   1 +
 drivers/iio/temperature/mlx90632.c                 | 759 +++++++++++++++++++++
 include/linux/kernel.h                             |   6 +
 lib/int_sqrt.c                                     |  31 +
 7 files changed, 844 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/mlx90632.txt
 create mode 100644 drivers/iio/temperature/mlx90632.c

-- 
2.15.0

