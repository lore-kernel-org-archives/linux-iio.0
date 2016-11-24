Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51639 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965961AbcKXW3O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Nov 2016 17:29:14 -0500
To: Greg KH <gregkh@linuxfoundation.org>
Subject: [PULL] 4th set of IIO new device support, features and cleanups for
 the 4.10 cycle.
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <cfd5964e-d0ad-01f9-83b9-e16e82e7e76b@kernel.org>
Date: Thu, 24 Nov 2016 22:29:10 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 8d78f0f2ba76a5a56de8800e19caeb8a3e161b75:

  staging: lustre: lnet: cleanup some of the > 80 line issues (2016-11-18 08:47:33 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.10d

for you to fetch changes up to 6f771d0b338d59c492699814b0fe554f9d1ee27c:

  iio: magnetometer: separate the values of attributes based on their usage type for HID compass sensor (2016-11-24 20:41:30 +0000)

----------------------------------------------------------------
Fourth set of IIO new device support, features and cleaups for the 4.10 cycle.

Probably the final set before the merge window unless things get significantly
delayed.

New device support
* STM32 ADC core
  - new driver.  Interesting device with up to 3 ADCs with complex triggering
    options that will follow later. Note split into an 'mfd like' core that
    handles the interrupt sharing etc between the various instances present and
    a per ADC section that is instantiated as many times as needed.
  - device tree bindings.

Cleanups and minor fixes
* st_accel
  - inline per sensor data as the defines don't add any meaning and make it
    much harder to check if a given sensor has the right values.
* hid-magnetometer
  - sort out the associations of the associated attributes with the two types.

----------------------------------------------------------------
Dan Carpenter (1):
      iio: tsl2583: make array large enough

Fabrice Gasnier (3):
      Documentation: dt-bindings: Document STM32 ADC DT bindings
      iio: adc: Add support for STM32 ADC core
      iio: adc: Add support for STM32 ADC

Linus Walleij (1):
      iio: accel: st_accel: inline per-sensor data

Ooi, Joyce (1):
      iio: magnetometer: separate the values of attributes based on their usage type for HID compass sensor

 .../devicetree/bindings/iio/adc/st,stm32-adc.txt   |  83 +++
 drivers/iio/accel/st_accel_core.c                  | 602 +++++++--------------
 drivers/iio/adc/Kconfig                            |  22 +
 drivers/iio/adc/Makefile                           |   2 +
 drivers/iio/adc/stm32-adc-core.c                   | 303 +++++++++++
 drivers/iio/adc/stm32-adc-core.h                   |  52 ++
 drivers/iio/adc/stm32-adc.c                        | 518 ++++++++++++++++++
 drivers/iio/light/tsl2583.c                        |   2 +-
 drivers/iio/magnetometer/hid-sensor-magn-3d.c      | 147 +++--
 9 files changed, 1299 insertions(+), 432 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
 create mode 100644 drivers/iio/adc/stm32-adc-core.c
 create mode 100644 drivers/iio/adc/stm32-adc-core.h
 create mode 100644 drivers/iio/adc/stm32-adc.c
