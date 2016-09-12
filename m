Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42014 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751203AbcILT6j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Sep 2016 15:58:39 -0400
To: Greg KH <gregkh@linuxfoundation.org>
Subject: [PULL] Second round of IIO new device support, features and cleanups
 for the 4.8 cycle.
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <43645e00-9c43-0f65-50ae-3ceee90f460c@kernel.org>
Date: Mon, 12 Sep 2016 20:58:34 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit d5bd1eba19230347acfc4960581a15bfb459a615:

  Merge tag 'iio-for-4.9a' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into work-testing (2016-08-23 17:50:16 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.9b

for you to fetch changes up to 1696566f995cfd4ddf3f167b4097cdc83f1458f2:

  iio: accel: mxc6255: Fix chip-id check (2016-09-12 20:19:16 +0100)

----------------------------------------------------------------
Second set of iio new device support, features and cleanups for the 4.9 cycle.

New device support
* ad8801 dac
  - new driver supporting ad8801 and ad8803 DACs.
* adc12138
  - new driver supporting TI adc12130/adc12132 and adc12138 ADCs.
* ltc2485 adc
  - new driver
* mxc6255
  - add support for the mxc6225 part name and fixup the ID check so it works.
* vz89x VOC sensor
  - add support for the vz89te part which drops the voc_short channel and adds
    CRCs compared to other supported parts.

New features
* core
  - immutable triggers.  These effectively grant exclusive control over a
    trigger. The typical usecase is a device representing an analog part
    (perhaps a MUX) that needs to control the sampling of a downstream
    ADC.
  - resource managed trigger registration and triggered_buffer_init.
  - iio_push_event now protected against case of the event interface
    registration not having yet occured.  Only matters if an interrupt
    can occur during this window - might happen on shared interrupt lines.
  - helper to let a driver query if the trigger it is using is provided by
    itself (using the convention of both device and trigger having the same
    parent).
* tools
  - iio-utils. Used channel modifier scaling in preference to generic scaling
    when both exist.
* at91-adc
  - Add support for touchscreen switches closure time needed by some newer
    parts.
* stx104
  - support the ADC channels on this ADC/DAC board. As these are the primary
    feature of the board also move the driver to the iio/adc directory.
* sx9500
  - device tree bindings.

Cleanups / Fixes
* ad5755
  - fix an off-by-one on devnr limit check (introduced earlier this cycle)
* ad7266
  - drop NULL check on devm_regulator_get_optional as it can't return NULL.
* ak8974
  - avoid an unused functional warning due to rework in PM core code.
  - remove .owner field setting as done by i2c_core.
* ina2xx
  - clear out a left over debug field from chip global data.
* hid-sensors
  - avoid an unused functional warning due to rework in PM core code.
* maxim-thermocouple
  - fix non static symbol warnings.
* ms5611
  - fetch and enable regulators unconditionally when they aren't optional.
* sca3000
  - whitespace cleanup.
* st_sensors
  - fetch and enable regulators unconditionally rather than having them
    supported as optional regulators (missunderstanding on my part amongst
    others a while back)
  - followup to previous patch fixes error checking on the regulators.
  - mark symbols static where possible.
  - use the 'is it my trigger' help function.  This prevents the odd case
    of another device triggering from the st-sensors trigger whilst the
    st-sensors trigger is itself not using it but rather using say an hrtimer.
* ti-ads1015
  - add missing of_node_put.
* vz89x
  - rework to all support of new devices.
  - prevent reading of a corrupted buffer.
  - fixup a return value of 0/1 in a bool returning function.

Address updates
- Vlad Dogaru email address change.

----------------------------------------------------------------
Akinobu Mita (1):
      iio: adc: add ADC12130/ADC12132/ADC12138 ADC driver

Alison Schofield (2):
      iio: adc: ltc2485: add support for Linear Technology LTC2485 ADC
      iio: adc: ina2xx: remove unused debug field from chip global data

Arnd Bergmann (2):
      iio: hid-sensors: avoid unused function warning
      iio: magn/ak8974: avoid unused function warning

Baoyou Xie (1):
      fix:iio:common:st_sensors:st_sensors_trigger:mark symbols static where possible

Christoph Fritz (1):
      iio: sx9500: add final devicetree support

Clifton Barnes (1):
      staging: iio: accel: sca3000: remove extra space

Colin Ian King (1):
      iio: ad5755: fix off-by-one on devnr limit check

Crt Mori (2):
      iio: fetch and enable regulators unconditionally
      iio: devm_regulator_get_optional never returns NULL

Gregor Boirie (2):
      iio:trigger: add resource managed (un)register
      iio: add resource managed triggered buffer init helpers

Gwenhael Goavec-Merou (1):
      iio: dac: AD8801: add Analog Devices AD8801/AD8803 support

Hans de Goede (2):
      iio: accel: mxc6255 add support for the mxc6225
      iio: accel: mxc6255: Fix chip-id check

Lars-Peter Clausen (1):
      iio: iio_push_event(): Don't crash if the event interface is not registered

Linus Walleij (4):
      iio: st_sensors: fetch and enable regulators unconditionally
      iio: st_sensors: fix errorcheck for regulators
      iio: trigger: helpers to determine own trigger
      iio: st_sensors: use the helper function

Matt Ranostay (5):
      iio: iio-utils: use channel modifier scaling if it exists
      iio: chemical: vz89x: abstract chip configuration
      iio: chemical: vz89x: add support for VZ89TE part
      iio: chemical: vz89x: prevent corrupted buffer from being read
      iio: trigger: allow immutable triggers to be assigned

Nicolas Ferre (1):
      iio: adc: at91: Add support for Touchscreen Switches Closure Time

Vlad Dogaru (1):
      mailmap: update Vlad Dogaru email address

Wei Yongjun (3):
      iio: temperature: fix non static symbol warnings
      iio: adc: ti-ads1015: add missing of_node_put() in ads1015_get_channels_config_of()
      iio: magn: ak8974: remove .owner field for driver

William Breathitt Gray (1):
      iio: stx104: Add IIO support for the ADC channels

kbuild test robot (1):
      iio: chemical: vz89x: fix boolreturn.cocci warnings

 .mailmap                                           |   1 +
 .../devicetree/bindings/iio/adc/ti-adc12138.txt    |  37 ++
 .../devicetree/bindings/iio/proximity/sx9500.txt   |  24 +
 Documentation/driver-model/devres.txt              |   4 +
 MAINTAINERS                                        |   4 +-
 drivers/iio/accel/mxc6255.c                        |   4 +-
 drivers/iio/adc/Kconfig                            |  36 ++
 drivers/iio/adc/Makefile                           |   3 +
 drivers/iio/adc/ad7266.c                           |   4 +-
 drivers/iio/adc/at91_adc.c                         |  13 +
 drivers/iio/adc/ina2xx-adc.c                       |   5 -
 drivers/iio/adc/ltc2485.c                          | 148 ++++++
 drivers/iio/{dac => adc}/stx104.c                  | 153 +++++-
 drivers/iio/adc/ti-adc12138.c                      | 552 +++++++++++++++++++++
 drivers/iio/adc/ti-ads1015.c                       |   2 +
 drivers/iio/adc/ti-ads8688.c                       |   4 +-
 drivers/iio/buffer/industrialio-triggered-buffer.c |  42 ++
 drivers/iio/chemical/vz89x.c                       | 201 ++++++--
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |   9 +-
 drivers/iio/common/st_sensors/st_sensors_buffer.c  |   2 +-
 drivers/iio/common/st_sensors/st_sensors_core.c    |  53 +-
 drivers/iio/common/st_sensors/st_sensors_trigger.c |   4 +-
 drivers/iio/dac/Kconfig                            |  20 +-
 drivers/iio/dac/Makefile                           |   2 +-
 drivers/iio/dac/ad5755.c                           |   2 +-
 drivers/iio/dac/ad8801.c                           | 239 +++++++++
 drivers/iio/industrialio-core.c                    |   3 +-
 drivers/iio/industrialio-event.c                   |   8 +
 drivers/iio/industrialio-trigger.c                 |  95 ++++
 drivers/iio/magnetometer/ak8974.c                  |   7 +-
 drivers/iio/pressure/ms5611_core.c                 |   6 +-
 drivers/iio/proximity/sx9500.c                     |   7 +
 drivers/iio/temperature/maxim_thermocouple.c       |   6 +-
 drivers/staging/iio/accel/sca3000_core.c           |   2 +-
 include/linux/iio/iio.h                            |   3 +
 include/linux/iio/trigger.h                        |  26 +
 include/linux/iio/triggered_buffer.h               |   8 +
 tools/iio/iio_utils.c                              |  11 +-
 38 files changed, 1610 insertions(+), 140 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc12138.txt
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/sx9500.txt
 create mode 100644 drivers/iio/adc/ltc2485.c
 rename drivers/iio/{dac => adc}/stx104.c (60%)
 create mode 100644 drivers/iio/adc/ti-adc12138.c
 create mode 100644 drivers/iio/dac/ad8801.c
 
