Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:33003 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755854AbbKROix (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Nov 2015 09:38:53 -0500
Received: by wmec201 with SMTP id c201so281773202wme.0
        for <linux-iio@vger.kernel.org>; Wed, 18 Nov 2015 06:38:52 -0800 (PST)
From: Marc Titinger <mtitinger@baylibre.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: daniel.baluta@intel.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, Marc Titinger <mtitinger@baylibre.com>
Subject: [RFC 0/9] spawn hrtimer trigger from client driver upon enabling buffer
Date: Wed, 18 Nov 2015 15:38:26 +0100
Message-Id: <1447857515-23935-1-git-send-email-mtitinger@baylibre.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

this builds upon the sw-trigger / hrtimer series from Daniel[1]
in order to create the trigger upon enabling the buffer when the
sampling frequency is known. This is useful for devices without
hardware streaming scheme, to avoid the complexity of creating
a separate trigger through configfs, and then setting
the sw-trigger frequency from both device0 and the trigger.

[1]: https://lkml.org/lkml/2015/10/23/369

Daniel Baluta (5):
  configfs: Allow dynamic group creation
  iio: core: Introduce IIO configfs support
  iio: core: Introduce IIO software triggers
  iio: trigger: Introduce IIO hrtimer based trigger
  iio: Documentation: Add IIO configfs documentation

Marc Titinger (4):
  iio: ina2xx: add direct IO support for TI INA2xx Power Monitors
  iio: ina2xx: add triggered buffer
  iio: buffer: allow for last-second trigger spawning from device driver
  iio: (RFC) illustrate creation/destruction of hrtimer trigger upon
    buffer enable

 Documentation/ABI/testing/configfs-iio |  21 ++
 Documentation/iio/iio_configfs.txt     |  93 +++++
 drivers/iio/Kconfig                    |  16 +
 drivers/iio/Makefile                   |   2 +
 drivers/iio/adc/Kconfig                |  12 +
 drivers/iio/adc/Makefile               |   1 +
 drivers/iio/adc/ina2xx-iio.c           | 661 +++++++++++++++++++++++++++++++++
 drivers/iio/industrialio-buffer.c      |   5 +
 drivers/iio/industrialio-configfs.c    |  50 +++
 drivers/iio/industrialio-sw-trigger.c  | 183 +++++++++
 drivers/iio/trigger/Kconfig            |  10 +
 drivers/iio/trigger/Makefile           |   2 +
 drivers/iio/trigger/iio-trig-hrtimer.c | 193 ++++++++++
 fs/configfs/dir.c                      | 110 ++++++
 include/linux/configfs.h               |  10 +
 include/linux/iio/iio.h                |   3 +
 include/linux/iio/sw_trigger.h         |  71 ++++
 17 files changed, 1443 insertions(+)
 create mode 100644 Documentation/ABI/testing/configfs-iio
 create mode 100644 Documentation/iio/iio_configfs.txt
 create mode 100644 drivers/iio/adc/ina2xx-iio.c
 create mode 100644 drivers/iio/industrialio-configfs.c
 create mode 100644 drivers/iio/industrialio-sw-trigger.c
 create mode 100644 drivers/iio/trigger/iio-trig-hrtimer.c
 create mode 100644 include/linux/iio/sw_trigger.h

-- 
1.9.1

