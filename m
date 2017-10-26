Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932343AbdJZSP4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 26 Oct 2017 14:15:56 -0400
Date: Thu, 26 Oct 2017 19:15:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Subject: [PULL] 3rd (small) set of new device support, features and cleanups
 for IIO in the 4.15 cycle.
Message-ID: <20171026191552.773dadf2@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 11b86c7004ef14f9f8c1e2caf66bfaad6f3167a2:

  platform/chrome: Add cros_ec_accel_legacy driver (2017-10-14 20:34:01 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.15c

for you to fetch changes up to f98677cf315e61403aefef72b056c643dd152c54:

  iio: dac: ti-dac082s085: Read chip spec from device table (2017-10-21 20:36:45 +0100)

----------------------------------------------------------------
Third set of new device support, cleanups and features for IIO in the 4.15 cycle

New device support
* ti-dac082s085 dac
  - new driver supporting 8, 10 and 12 bit TI DACs with 2 and 4 channels:
    DAC082S085, DAC102S085, DAC122S085, DAC104s085 and DAC124S085.

Minor features and cleanps
* adc12138
  - make array ch_to_mux static for small object code size reduction.
* sun4i-gpadc
  - use of_device_get_match_data rather than opencoding it.
* stm32 trigger
  - add tim15 tigger on STM32H7
  - check clock rate to avoid potential division by zero
* tsl2x7x staging cleanups.
  - move *_thresh_period to being created by IIO core.
  - remove unused tsl2x7x_parse_result structure.
  - sort includes
  - drop a repeat iio_dev forward definition
  - fix some code alignment of defines.
  - use IIO_CONST_ATTR for constant string attribute
  - drop some unnecessary parentheses
  - fix various alignment with parenthese
  - rename power defines for readability reasons
  - fix a missaligned break statement
  - Tidy up function definitions so they fit on a single line.

----------------------------------------------------------------
Brian Masney (12):
      staging: iio: tsl2x7x: migrate *_thresh_period sysfs attributes to iio_event_spec
      staging: iio: tsl2x7x: remove unused tsl2x7x_parse_result structure
      staging: iio: tsl2x7x: sort #includes
      staging: iio: tsl2x7x: remove unnecessary struct iio_dev definition
      staging: iio: tsl2x7x: changed #defines to be aligned on the same column
      staging: iio: tsl2x7x: convert in_proximity0_calibscale_available to use IIO_CONST_ATTR
      staging: iio: tsl2x7x: remove unnecessary parentheses
      staging: iio: tsl2x7x: correct alignment of parenthesis
      staging: iio: tsl2x7x: correct alignment of parenthesis
      staging: iio: tsl2x7x: rename power defines to improve code readability
      staging: iio: tsl2x7x: fix alignment of break statements
      staging: iio: tsl2x7x: put function definitions on a single line

Colin Ian King (1):
      iio: adc: adc12138: make array ch_to_mux static, makes object code smaller

Corentin Labbe (1):
      iio: adc: sun4i-gpadc: use of_device_get_match_data

Fabrice Gasnier (2):
      iio: adc: stm32: add tim15 trigger
      iio: adc: stm32: add check on clock rate

Lukas Wunner (3):
      dt-bindings: iio: dac: ti-dac082s085: Document new driver
      iio: dac: Add Texas Instruments 8/10/12-bit 2/4-channel DAC driver
      iio: dac: ti-dac082s085: Read chip spec from device table

 Documentation/ABI/testing/sysfs-bus-iio            |   1 +
 .../devicetree/bindings/iio/dac/ti-dac082s085.txt  |  34 ++
 drivers/iio/adc/stm32-adc-core.c                   |  13 +
 drivers/iio/adc/stm32-adc.c                        |   1 +
 drivers/iio/adc/sun4i-gpadc-iio.c                  |   6 +-
 drivers/iio/adc/ti-adc12138.c                      |   2 +-
 drivers/iio/dac/Kconfig                            |  10 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/ti-dac082s085.c                    | 368 +++++++++++++++++
 drivers/staging/iio/light/tsl2x7x.c                | 440 ++++++++-------------
 drivers/staging/iio/light/tsl2x7x.h                |   2 -
 11 files changed, 598 insertions(+), 280 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ti-dac082s085.txt
 create mode 100644 drivers/iio/dac/ti-dac082s085.c
