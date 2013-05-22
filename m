Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39693 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757704Ab3EVWQj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 May 2013 18:16:39 -0400
Message-ID: <519D43C5.3020302@kernel.org>
Date: Wed, 22 May 2013 23:16:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO cleanups, new stuff and staging graduations (IIO set 1
 for the 3.11 cycle)
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 735ae5392a622e88ebe9dda1f66d80850580239d:

  Staging: bcm: fix checkpatch errors and warnings in Version.h (2013-05-21 19:59:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.11a

for you to fetch changes up to c619653d77a5d59abe9166da57f3686b7f067745:

  adc: exynos_adc: Convert to devm_ioremap_resource() (2013-05-22 22:18:22 +0100)

----------------------------------------------------------------
First round of new IIO drivers and cleanups for the 3.11 cycle.

1) New driver for MCP3204/08 12 bit ADCs
2) Move the sysfs trigger out of staging.  This has been pretty clean for a
   long time so lets finally move it out.
3) New functionality for the ak8975 magnetometer (DT and data ready interrupt
   handling)
4) Use devm_ioremap_resource in exynos_adc.  We have 3 separate versions of
   this patch proposed but this one got there first.
5) A couple of other tiny fixes.

----------------------------------------------------------------
Alexandre Relange (1):
      iio: Correct HID light sensor name in comments

Jacek Anaszewski (2):
      iio:ak8975 Add support for gpios DT property
      iio:ak8975 Implement data ready interrupt handling

Jonathan Cameron (1):
      iio:trigger:sysfs Move out of staging.

Michał Mirosław (2):
      iio: buffer: cleanup messages in iio_update_buffers()
      staging/iio/mxs-lradc: cleanup masklength

Oskar Andero (1):
      iio: adc: add driver for MCP3204/08 12-bit ADC

Paul Bolle (1):
      iio: STMicroelectronics: remove three useless selects

Sachin Kamat (1):
      adc: exynos_adc: Convert to devm_ioremap_resource()

 .../bindings/iio/magnetometer/ak8975.txt           |  18 ++
 drivers/iio/Kconfig                                |   3 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/accel/Kconfig                          |   1 -
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/exynos_adc.c                       |  12 +-
 drivers/iio/adc/mcp320x.c                          | 257 +++++++++++++++++++++
 drivers/iio/gyro/Kconfig                           |   1 -
 drivers/iio/industrialio-buffer.c                  |  10 +-
 drivers/iio/light/hid-sensor-als.c                 |   2 +-
 drivers/iio/magnetometer/Kconfig                   |   1 -
 drivers/iio/magnetometer/ak8975.c                  | 103 ++++++++-
 drivers/iio/trigger/Kconfig                        |  17 ++
 drivers/iio/trigger/Makefile                       |   5 +
 drivers/{staging => }/iio/trigger/iio-trig-sysfs.c |   0
 drivers/staging/iio/adc/mxs-lradc.c                |   8 +-
 drivers/staging/iio/trigger/Kconfig                |  11 -
 drivers/staging/iio/trigger/Makefile               |   1 -
 19 files changed, 425 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
 create mode 100644 drivers/iio/adc/mcp320x.c
 create mode 100644 drivers/iio/trigger/Kconfig
 create mode 100644 drivers/iio/trigger/Makefile
 rename drivers/{staging => }/iio/trigger/iio-trig-sysfs.c (100%)
