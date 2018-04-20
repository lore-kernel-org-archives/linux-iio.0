Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33889 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750927AbeDTT2W (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Apr 2018 15:28:22 -0400
Date: Fri, 20 Apr 2018 21:28:17 +0200
From: David Veenstra <davidjulianveenstra@gmail.com>
To: lars@metafoo.de, jic23@kernel.org, pmeerw@pmeerw.net
Cc: robh+dt@kernel.org, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org
Subject: [PATCH v2 00/13] staging: iio: ad2s1200: Driver clean up
Message-ID: <cover.1524247563.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

For v1 of the patch see [1].

A summary of this patch:
1. Clean up of minor code style issues
2. Replace legacy GPIO ABI with modern ABI
4. Add scaling factor for angular position and angular velocity to
   match the sysfs IIO ABI
5. Add documentation for device tree binding, and angle channel
6. Move driver to main line

Changes in v2:
- Removed an unneeded include
- Instead of using inclination channel for the angular position,
  use angle channel
- Added documentation for device tree binding, and sysfs IIO ABI
  documentation for angle channel

For the scaling factors, a fractional approximation of Pi is needed.
As in v1 of the patch, the fraction 103993 / 33102 was chosen, which is
based on the OEIS series of nominator/denominator of convergents to
Pi (A002485 and A002486). I have looked at the implementation of
iio_read_channel_info, and compared using the fraction above, with
the fraction and offset used in the IIO_DEGREE_TO_RAD in iio.h, and
found the first method to be more accurate for all possible 12-bit values,
as the error is neglible. Also it does not cause overflow.

In [2] Jonathan suggested to remove usage of platform data altogether,
and asked for Michael Hennerich opinion. Since Michael didn't weigh in,
I have left this how it was.

Best regards,
David Veenstra

[1] https://marc.info/?l=linux-iio&m=152137920426820&w=2
[2] https://marc.info/?l=linux-iio&m=152181140619243&w=2

David Veenstra (13):
  staging: iio: ad2s1200: Remove unneeded include
  staging: iio: ad2s1200: Sort includes alphabetically
  staging: iio: ad2s1200: Reverse Christmas tree ordering
  staging: iio: ad2s1200: Add blank lines
  staging: iio: ad2s1200: Add kernel docs to driver state
  staging: iio: ad2s1200: Introduce variable for repeated value
  staging: iio: ad2s1200: Improve readability with be16_to_cpup
  staging: iio: ad2s1200: Replace legacy gpio API with modern API
  staging: iio: ad2s1200: Add documentation for device tree binding
  staging: iio: ad2s1200: Add scaling factor for angular velocity
    channel
  staging: iio: Documentation: Add missing sysfs docs for angle channel
  staging: iio: ad2s1200: Add scaling factor for angle channel
  staging: iio: ad2s1200: Move driver out of staging

 Documentation/ABI/testing/sysfs-bus-iio            |  11 +
 .../devicetree/bindings/iio/resolver/ad2s1200.txt  |  16 ++
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/resolver/Kconfig                       |  17 ++
 drivers/iio/resolver/Makefile                      |   5 +
 drivers/iio/resolver/ad2s1200.c                    | 250 +++++++++++++++++++++
 drivers/staging/iio/resolver/Kconfig               |  12 -
 drivers/staging/iio/resolver/Makefile              |   1 -
 drivers/staging/iio/resolver/ad2s1200.c            | 165 --------------
 10 files changed, 301 insertions(+), 178 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/resolver/ad2s1200.txt
 create mode 100644 drivers/iio/resolver/Kconfig
 create mode 100644 drivers/iio/resolver/Makefile
 create mode 100644 drivers/iio/resolver/ad2s1200.c
 delete mode 100644 drivers/staging/iio/resolver/ad2s1200.c

-- 
2.16.2

