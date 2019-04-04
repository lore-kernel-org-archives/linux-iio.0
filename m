Return-Path: <SRS0=W9FC=SG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E57EC10F0E
	for <linux-iio@archiver.kernel.org>; Thu,  4 Apr 2019 19:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D21621738
	for <linux-iio@archiver.kernel.org>; Thu,  4 Apr 2019 19:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554407847;
	bh=w4/xw7O0kdEPcmhMFyAcmpR20Xy3j4PMSOish8sSooE=;
	h=Date:From:To:Subject:List-ID:From;
	b=zYA8Tg+FNnYYq7M6hWV0NJ2qKUeBmpfUgP5PY11fFRQZQXDn4vYd+hFu1ZSe4XxaT
	 xRiTNVUGyF+ArnhuFSPVqaWp0C6jRsKk1yRsAMQ8PjSJTwNn/QPCIV6tJLvWJK+RRx
	 9wCoHLRTcIAc29wI7KBr6mWO2hrupOBmeRDb3fAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbfDDT50 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:57:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730566AbfDDT50 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 4 Apr 2019 15:57:26 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A9E720855;
        Thu,  4 Apr 2019 19:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554407845;
        bh=w4/xw7O0kdEPcmhMFyAcmpR20Xy3j4PMSOish8sSooE=;
        h=Date:From:To:Subject:From;
        b=QtbhHYaCA35HVgmvZtAKMff1KsJsI8yz44Yn+nV88vso/0Je/61D+iOL3mxCmOTsq
         ZO4k1fe7B+B/oQ8ZCl77VZqkeyqz0ltmP4vHJg/I1F9K/ET7fPuxW/CYaF/jw6L2iB
         LkXpoEqsUzK1M3OOAdkK6qzW/WeDh1AvWUT9AE5g=
Date:   Thu, 4 Apr 2019 20:57:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL V2] First round of new device support, cleanups and fixes for
 IIO in the 5.2 cycle.
Message-ID: <20190404205720.66804920@archlinux>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit b397f82585c3101dcf92642dd359891e66d00c55:

  Merge 5.1-rc3 into staging-next (2019-04-01 07:49:24 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-=
5.2a-2

for you to fetch changes up to df1d80aee963480c5c2938c64ec0ac3e4a0df2e0:

  iio: ad_sigma_delta: Properly handle SPI bus locking vs CS assertion (201=
9-04-04 20:21:15 +0100)

----------------------------------------------------------------
First set of new device support, features and fixes for IIO in the 5.2 cycle

Staging graduations
* ad7780
  - Move this ADC driver out of staging.  Included adding some new features
    along the way (see below). Also added DT bindings.

New device support
* adis16480
  - Support the ADIS16495 and ADIS16497 IMU devices making
    heavy use of refactoring of various aspects of the driver in precursor
    patches.
* lsm6dsx
  - Support for the ASM330LHH 6-axis (accelerometer + gyro) sensor.
  - Support for the LSM6DS0X
* matbotix mb1232
  - New driver for this ultrasound ranging device family. Including binding=
s.
  - Supports mb1202, mb1212, mb1222, mb1232, mb1242, mb7040 and mb7137.
* max31856
  - New driver for this thermocouple temperature sensor.
* meson saradc
  - Support the Meson-G12A (ID addition only).
* stmpe-adc
  - New driver supporting generic ADC alongside touchscreen support which
    previously existed. Includes DT bindings.
* vcnl4000
  - Support for the vcln4040 proximity and light sensor, including adding
    DT bindings for this and parts previously supported.

Features
* core
  - Allow reading of mount matrices from ACPI in addition to DT.
  - Common binding for theromcouple types.
* ad5933
  - Add ABI docs as there are a few 'unsual' elements about this
    device - perhaps because it's our only impedance analyser.
* ad7780
  - Add gain and filter gpio support + readback of current gain and filter.
* adis16480
  - Allow selection fo the dataready pin to be used.
  - Device tree ID table and binding documentation.
  - Support external clock modes, including new bindings.
* bma180
  - Mount matrix support.
* bmc150
  - Mount matrix support.
* bmg160
  - Mount matrix support.
  - DT id table and bindings doc.
* bmp280
  - Put calibration data into the entropy pool.
* hmc5843
  - Mount matrix support.
* itg3200
  - Mount matrix support.
* kxcjk1013
  - Device tree id table, and binding docs.
* lpc32xx
  - Add scale when regulator specified including DT docs for regulator.
* pms7003
  - Add device IDs for all supported parts to driver and binding.
* stm32-dfsdm
  - Enable hw consumer support, scan mode control and a complex set of
    triggered buffer modes.
  - Power management.
* stm32-lptimer-counter
  - power management.
  - Document the pinctrl sleep state binding.
* ti-ads7950
  - GPIO pin support.

Cleanups, minor fixes
* core
  - Use bitmap_zalloc to make it explicit that is what we are doing.
  - Tidy up all the Kconfig files (which had slowly gotten messy)
  - Fix a forwards definition missing issue in iio/driver.h
* ad sigma delta core
  - Improve handling of SPI bus locking vs CS assertion.  This has been
    wrong a long time so not rushing this in.
* ad5064
  - Mlock to local lock.
* ad5933 (staging cleanup)
  - Multiline comment fixes.
  - Include ordering.
  - SPDX.
  - Tidy up Kconfig help which was a bit missleading.
  - Change some non standard attributes to ABI defined ones.
* ad7124
  - White space fix.
* ad7192
  - White space.
  - Use DT clock binding.
  - Improve error reporting.
  - Platform data to DT conversion.
  - Use read_avail callback, mostly to avoid the endless series of
    patches from new contributors trying to falsely put spaces around
    the negative sign.
* ad7280a
  - Add brackets to macros to avoid potential precedence isseus.
  - Add temp vars for event codes to reduce indent and improved readability.
  - Clean out som CamelCase notation.
  - White space.
* ad7606
  - Fix broken file naming in MAINTAINERS.
* ad7780
  - Missing switch defaults to supress warnings and harden the code slightl=
y.
  - Set pattern masks more directly.
  - Add ID values and masks for all supported chips.
  - SPDX + add Renato as a copyright holder as he has done a lot of work on
    this driver.
  - Add brackets to macros to avoid potential precedence issues.
* ad7923
  - White space fixes.
  - Use BIT macro to improve readability.
  - Add brackets to macros to avoid potential precedence issues.
  - Tidy up a null comparisom.
* ad9523
  - Fix a typo in naming of variables.
* adis16400
  - Combine trigger file into main code as no advantage in separate files.
    Rename core file to just adis16400.
  - Squash the header into the c file now there is only one file.
  - Generalize burst mode to support new variants.
* ak8975
  - Local variable to improve readability around mount matrix support.
* as3935
  - Avoid potential race by ensuring remove does exact opposite of
    probe rather than a slightly different order.
* cross_ec
  - Drop some unnecessary includes.
  - Fix some warning and the slightly 'unusual' code.
  - Add some docs for non obvious function.
  - SPDX
* hmc5843
  - Potential unhandled error case.
* iio trigger core
  - Print an error if there is no available irq due to max consumers per
    trigger being set to low.
* iio loop trigger
  - Drop an unlikely on IS_ERR as IS_ERR already has the annotation.
* ingenic-adc
  - Drop a redundant dev_err call as devm_ioremap_resource reports the same
    internally.
* lmp91000
  - Drop some unncessary parentheses and white space tidy up.
  - Invert and if statement to improve readability.
  - Fix a wrong error message.
* lpc32xx
  - Header sorting + drop some unused ones.
* mma8542
  - Mark a switch fallthrough.
* mpu6050
  - Add a local variable to improve code readability around mount matrix
    support.
* mxs-lradc-adc
  - Handle devm_iio_trigger_alloc failure.
* sps30
  - Fix up a kernel version in the ABI docs.
* srf04
  - DT binding doc converted to yaml.
* ssp_sensors
  - Supress a clang build warning due to lack of visibility of conditional
    within a iio_push_to_buffers_with_timestamp.  (reasonable false warning=
!)
* st_accel
  - Drop pointless less than 0 comparisom of unsigned int.
* stm32-dfsdm
  - Improve accuracy of spi_master_frequency calculation.
  - Improve calculation fo sampling frequency.
  - Rework various internals to simplify adding triggered buffer support.
  - Claim direct mode to avoid racing around read_raw and being in buffered
    mode.
* stmpe
  - Fix a clang false positive warning.
* ti-ads7950
  - Use local lock rather than using the core mlock when not locking around
    the device mode.
* vcnl4000
  - Use word writes instead of byte writes.  It seems byte writes are fine
    for some parts (undocument) but not others that the driver will shortly
    support.

Other
* mailmap
  - Add email address change for Sean Nyekjaer.  Update in relevant drivers

----------------------------------------------------------------
Alexandru Ardelean (5):
      iio: imu: adis16400: move trigger handler into adis16400_core
      iio: imu: adis: generalize burst mode support
      iio: imu: adis16400: move burst logic to ADIS lib
      iio: imu: adis16400: rename adis16400_core.c -> adi16400.c
      iio: imu: adis16400: move adis16400.h into adis16400.c

Anderson Reis (3):
      iio:potentiostat:lmp91000: reduce line width and remove blank line
      iio:potentiostat:lmp91000: invert if statement
      iio:potentiostat:lmp91000: change dev_err message

Andreas Klinger (5):
      dt-bindings: Add vendor prefix for MaxBotix
      dt-bindings: maxbotix,mb1232: Add MaxBotix i2c ultrasonic rangers
      mb1232.c: add distance iio sensor with i2c
      MAINTAINERS: add maintainer for maxbotix ultrasonic driver
      devantech-srf04.yaml: transform DT binding to YAML

Andy Shevchenko (3):
      iio: Allow to read mount matrix from ACPI
      iio: buffer: Switch to bitmap_zalloc()
      iio: Make possible to include driver.h first

Angus Ainslie (Purism) (5):
      iio: light: vcnl4000 use word writes instead of byte writes
      iio: light: vcnl4000 add devicetree hooks
      dt-bindings: iio: light: add vcnl4000 devicetree bindings
      iio: light: vcnl4000 add support for the VCNL4040 proximity and light=
 sensor
      dt-bindings: iio: light: add vcnl4040 devicetree bindings

B=C3=A1rbara Fernandes (4):
      iio:adc:ad7923: Align broken line to parenthesis
      iio:adc:ad7923: Use BIT macro instead of bitshift
      iio:adc:ad7923: Put macro argument between ()'s
      iio:adc:ad7923: Rewrite comparison to NULL

Chengguang Xu (1):
      iio: remove redundant unlikely annotation

Colin Ian King (2):
      iio: st_accel: remove redundant unsigned less than zero check
      iio: adc: ad7124 fix indentation issue, remove extra tab

Cristian Sicilia (4):
      staging: iio: adc: ad7280a: Avoid precedence issues in macro
      staging: iio: adc: ad7280a: Adding temp var to improve readability
      staging: iio: adc: ad7280a: Remove CamelCase notation
      staging: iio: adc: ad7280a: Tab alignment

Enric Balletbo i Serra (1):
      iio: cros_ec: Switch to SPDX identifier.

Enrico Weigelt, metux IT consult (1):
      drivers: iio: Kconfig: pedantic cleanup

Fabrice Gasnier (12):
      dt-bindings: iio: stm32-lptimer-counter: document pinctrl sleep state
      iio: counter: stm32-lptimer: Add power management support
      iio: adc: stm32-dfsdm: make spi_master_freq more accurate
      iio: adc: stm32-dfsdm: continuous mode depends on current mode
      iio: adc: stm32-dfsdm: move dma enable from start_conv() to start_dma=
()
      iio: adc: stm32-dfsdm: move dma slave config to start routine
      iio: adc: stm32-dfsdm: enable hw consumer
      iio: adc: stm32-dfsdm: add support for scan mode
      iio: adc: stm32-dfsdm: add support for buffer modes
      iio: adc: stm32-dfsdm: claim direct mode for raw read and settings
      iio: adc: stm32-dfsdm: improve sampling frequency accuracy
      iio: adc: stm32-dfsdm: add PM support

Gregory CLEMENT (4):
      iio: adc: lpc32xx: Sort headers
      iio: adc: lpc32xx: Cleanup headers
      iio: adc: lpc32xx: Add scale feature
      dt-bindings: iio: adc: lpc32xx-adc: Document vref-supply

Guenter Roeck (1):
      iio: cros_ec: Drop unnecessary include files

Gustavo A. R. Silva (2):
      iio: mma8452: mark expected switch fall-through
      iio: cros_ec_accel_legacy: Refactor code in cros_ec_accel_legacy_probe

Gwendal Grignou (1):
      iio: cros_ec: Add kernel-doc for cros_ec_sensors_read_lpc

H. Nikolaus Schaller (10):
      iio: accel: bmc150: add mount matrix support
      iio: accel: bma180: add mount matrix support
      iio: gyro: bmg160: add mount matrix support
      iio: gyro: itg3200: add mount matrix support
      iio: magnetometer: bmc150: add mount matrix support
      iio: magnetometer: hmc5843: add mount matrix support
      iio: mpu6050: improve code readability
      iio: ak8975: improve code readability
      iio: gyro: bmg160: add device tree compatibility table
      dt-bindings: iio: add Bosch BMG160 gyroscope sensor

Jonathan Cameron (1):
      iio:dac:ad5064 mlock cleanup - move to a local lock.

Justin Chen (2):
      iio: adc: ti-ads7950: Fix improper use of mlock
      iio: adc: ti-ads7950: add GPIO support

Kangjie Lu (2):
      iio: adc: fix a potential NULL pointer dereference
      iio: hmc5843: fix potential NULL pointer dereferences

Lars-Peter Clausen (2):
      iio: frequency: ad9523: Fix typo in ad9523_platform_data
      iio: ad_sigma_delta: Properly handle SPI bus locking vs CS assertion

Linus Walleij (1):
      iio: pressure: bmp280: BMP280 calibration to entropy

Lorenzo Bianconi (4):
      iio: imu: st_lsm6dsx: add support to ASM330LHH
      dt-bindings: iio: imu: st_lsm6dsx: add asm330lhh device bindings
      iio: imu: st_lsm6dsx: add support to LSM6DSOX
      dt-bindings: iio: imu: st_lsm6dsx: add lsm6dsox device bindings

Lucas Oshiro (1):
      iio:potentiostat:lmp91000: remove unnecessary parentheses

Marcelo Schmitt (6):
      staging: iio: ad5933: change multi-line comment style
      staging: iio: ad5933: organize includes
      staging: iio: ad5933: add SPDX identifier
      staging: iio: ad5933: change help rule message
      staging: iio: ad5933: add ABI documentation
      staging: iio: ad5933: change attributes to match ABI

Mathieu Othacehe (1):
      iio: trigger: Print an error if there is no available irq

Mircea Caprioru (5):
      staging: iio: adc: ad7192: Fix identation
      staging: iio: adc: ad7192: Use DT clock binding
      staging: iio: adc: ad7192: Report error directly in ad7192_setup
      staging: iio: adc: ad7192: Convert platform data to DT properties
      staging: iio: adc: ad7192: Use read_avail for available attributes

Nathan Chancellor (2):
      iio: common: ssp_sensors: Initialize calculated_time in ssp_common_pr=
ocess_data
      iio: adc: stmpe-adc: Shuffle an if statement around in stmpe_adc_isr

Neil Armstrong (2):
      dt-bindings: iio: adc: document the Meson G12A support
      iio: adc: meson-saradc: add support for Meson G12A

Paresh Chaudhary (2):
      iio:temperature:max31856:Add device tree bind info
      iio:temperature: Add MAX31856 thermocouple support

Patrick Havelange (1):
      dt-bindings: iio/temperature: Add thermocouple types (and doc)

Renato Lui Geh (11):
      staging: iio: ad7780: add gain & filter gpio support
      staging: iio: ad7780: add missing switch default case
      staging: iio: ad7780: add gain reading to ad778x
      staging: iio: ad7780: add filter reading to ad778x
      staging: iio: ad7780: set pattern values and masks directly
      staging:iio:ad7780: add chip ID values and mask
      staging: iio: ad7780: move regulator to after GPIO init
      staging: iio: ad7780: add SPDX identifier
      staging: iio: ad7780: add new copyright holder
      staging: iio: ad7780: moving ad7780 out of staging
      staging: iio: ad7780: add device tree binding

Robert Yang (3):
      dt-bindings: Add vendor prefix for Kionix, Inc.
      dt-bindings: iio: accel: kxcjk1013: Add device tree binding documenta=
tion
      iio: accel: kxcjk1013: Add device tree support

Sean Nyekjaer (3):
      mailmap: Update email for Sean Nyekjaer
      iio: adc: ti-ads8688: Update the module author email address
      iio: dac: ti-dac5571: Update the module author email address

Stefan Popa (10):
      iio: imu: adis16480: Add support for configurable drdy indicator
      iio: imu: adis16480: Add OF device ID table
      iio: imu: adis16480: Treat temperature scale in a generic way
      iio: imu: adis16480: Calculate the sampling frequency in a generic way
      iio: imu: adis16480: Deal with filter freq in a generic way
      iio: imu: adis16480: Add support for ADIS1649x family of devices
      iio: imu: adis16480: Add docs for ADIS16480 IMU
      iio: imu: adis16480: Add support for external clock
      dt-bindings: iio: imu: adis16480: Document external clock
      MAINTAINERS: Fix the link to ad7606 dt-bindings

Sven Van Asbroeck (1):
      iio: proximity: as3935: fix use-after-free on device remove

Tomasz Duszynski (3):
      iio: chemical: pms7003: extend supported sensors list
      dt-bindings: iio: chemical: pms7003: extend supported sensors list
      iio: chemical: sps30: fix attribute kernel version

Vladimir Petrigo (1):
      iio: adc: ad7780: Add parentheses to macros

Wei Yongjun (1):
      iio: adc: ingenic: remove redundant dev_err call in ingenic_adc_probe=
()

 .mailmap                                           |   1 +
 .../sysfs-bus-iio-impedance-analyzer-ad5933        |  19 +-
 Documentation/ABI/testing/sysfs-bus-iio-sps30      |   2 +-
 .../ABI/testing/sysfs-bus-iio-temperature-max31856 |  24 +
 .../bindings/iio/accel/kionix,kxcjk1013.txt        |  17 +
 .../devicetree/bindings/iio/adc/adi,ad7780.txt     |  48 ++
 .../bindings/iio/adc/amlogic,meson-saradc.txt      |   1 +
 .../devicetree/bindings/iio/adc/lpc32xx-adc.txt    |   5 +
 .../bindings/iio/chemical/plantower,pms7003.txt    |   8 +-
 .../bindings/iio/counter/stm32-lptimer-cnt.txt     |   8 +-
 .../devicetree/bindings/iio/gyroscope/bmg160.txt   |  20 +
 .../devicetree/bindings/iio/imu/adi,adis16480.txt  |  85 +++
 .../devicetree/bindings/iio/imu/st_lsm6dsx.txt     |   2 +
 .../devicetree/bindings/iio/light/vcnl4000.txt     |  24 +
 .../bindings/iio/proximity/devantech-srf04.txt     |  28 -
 .../bindings/iio/proximity/devantech-srf04.yaml    |  59 ++
 .../bindings/iio/proximity/maxbotix,mb1232.txt     |  29 +
 .../bindings/iio/temperature/max31856.txt          |  24 +
 .../iio/temperature/temperature-bindings.txt       |   7 +
 .../devicetree/bindings/vendor-prefixes.txt        |   2 +
 MAINTAINERS                                        |  10 +-
 drivers/iio/Kconfig                                |  24 +-
 drivers/iio/accel/Kconfig                          |  48 +-
 drivers/iio/accel/bma180.c                         |  18 +-
 drivers/iio/accel/bmc150-accel-core.c              |  21 +
 drivers/iio/accel/cros_ec_accel_legacy.c           |  40 +-
 drivers/iio/accel/kxcjk-1013.c                     |  10 +
 drivers/iio/accel/kxsd9.c                          |   4 +-
 drivers/iio/accel/mma8452.c                        |   2 +-
 drivers/iio/accel/st_accel_core.c                  |   2 +-
 drivers/iio/adc/Kconfig                            |  32 +-
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ad7124.c                           |   2 +-
 drivers/{staging =3D> }/iio/adc/ad7780.c             | 179 ++++--
 drivers/iio/adc/ad7923.c                           |  24 +-
 drivers/iio/adc/ad_sigma_delta.c                   |  16 +-
 drivers/iio/adc/ingenic-adc.c                      |   4 +-
 drivers/iio/adc/lpc32xx_adc.c                      |  60 +-
 drivers/iio/adc/meson_saradc.c                     |   8 +
 drivers/iio/adc/mxs-lradc-adc.c                    |   2 +
 drivers/iio/adc/stm32-dfsdm-adc.c                  | 628 ++++++++++++++++-=
----
 drivers/iio/adc/stm32-dfsdm-core.c                 | 180 +++++-
 drivers/iio/adc/stmpe-adc.c                        |   5 +-
 drivers/iio/adc/ti-ads7950.c                       | 219 ++++++-
 drivers/iio/adc/ti-ads8688.c                       |   2 +-
 drivers/iio/buffer/industrialio-buffer-cb.c        |  10 +-
 drivers/iio/chemical/Kconfig                       |  12 +-
 drivers/iio/chemical/pms7003.c                     |   5 +
 .../iio/common/cros_ec_sensors/cros_ec_sensors.c   |  12 +-
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  |  22 +-
 drivers/iio/common/ms_sensors/Kconfig              |   2 +-
 drivers/iio/common/ssp_sensors/ssp_iio.c           |   2 +-
 drivers/iio/counter/stm32-lptimer-cnt.c            |  55 ++
 drivers/iio/dac/ad5064.c                           |  15 +-
 drivers/iio/dac/ti-dac5571.c                       |   2 +-
 drivers/iio/frequency/ad9523.c                     |  16 +-
 drivers/iio/gyro/bmg160_core.c                     |  21 +
 drivers/iio/gyro/bmg160_i2c.c                      |   9 +
 drivers/iio/gyro/itg3200_core.c                    |  20 +
 drivers/iio/gyro/mpu3050-core.c                    |   3 +-
 drivers/iio/humidity/Kconfig                       |  20 +-
 drivers/iio/imu/Makefile                           |   2 -
 drivers/iio/imu/{adis16400_core.c =3D> adis16400.c}  | 232 +++++++-
 drivers/iio/imu/adis16400.h                        | 215 -------
 drivers/iio/imu/adis16400_buffer.c                 | 101 ----
 drivers/iio/imu/adis16480.c                        | 435 +++++++++++++-
 drivers/iio/imu/adis_buffer.c                      |  40 ++
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |  10 +-
 drivers/iio/imu/st_lsm6dsx/Kconfig                 |   2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |   4 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |   8 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |  42 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c        |  10 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c        |  10 +
 drivers/iio/industrialio-buffer.c                  |  24 +-
 drivers/iio/industrialio-core.c                    |  46 +-
 drivers/iio/industrialio-trigger.c                 |   5 +-
 drivers/iio/light/Kconfig                          | 274 ++++-----
 drivers/iio/light/cros_ec_light_prox.c             |  12 +-
 drivers/iio/light/vcnl4000.c                       |  77 ++-
 drivers/iio/magnetometer/ak8974.c                  |   5 +-
 drivers/iio/magnetometer/ak8975.c                  |  13 +-
 drivers/iio/magnetometer/bmc150_magn.c             |  21 +
 drivers/iio/magnetometer/hmc5843.h                 |   1 +
 drivers/iio/magnetometer/hmc5843_core.c            |  20 +-
 drivers/iio/magnetometer/hmc5843_i2c.c             |   7 +-
 drivers/iio/magnetometer/hmc5843_spi.c             |   7 +-
 drivers/iio/potentiometer/Kconfig                  |  34 +-
 drivers/iio/potentiostat/lmp91000.c                |  14 +-
 drivers/iio/pressure/bmp280-core.c                 |   6 +
 drivers/iio/pressure/cros_ec_baro.c                |  11 +-
 drivers/iio/proximity/Kconfig                      |  12 +
 drivers/iio/proximity/Makefile                     |   1 +
 drivers/iio/proximity/as3935.c                     |  50 +-
 drivers/iio/proximity/mb1232.c                     | 272 +++++++++
 drivers/iio/temperature/Kconfig                    |  24 +-
 drivers/iio/temperature/Makefile                   |   1 +
 drivers/iio/temperature/max31856.c                 | 353 ++++++++++++
 drivers/iio/trigger/iio-trig-loop.c                |   2 +-
 drivers/staging/iio/adc/Kconfig                    |  13 -
 drivers/staging/iio/adc/Makefile                   |   1 -
 drivers/staging/iio/adc/ad7192.c                   | 233 +++++---
 drivers/staging/iio/adc/ad7192.h                   |   9 -
 drivers/staging/iio/adc/ad7280a.c                  | 109 ++--
 drivers/staging/iio/impedance-analyzer/Kconfig     |   2 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c    |  54 +-
 include/dt-bindings/iio/temperature/thermocouple.h |  16 +
 include/linux/iio/adc/ad_sigma_delta.h             |   1 +
 include/linux/iio/driver.h                         |   1 +
 include/linux/iio/frequency/ad9523.h               |   8 +-
 include/linux/iio/gyro/itg3200.h                   |   1 +
 include/linux/iio/iio.h                            |   4 +-
 include/linux/iio/imu/adis.h                       |  14 +
 113 files changed, 3777 insertions(+), 1272 deletions(-)
 rename {drivers/staging/iio/Documentation =3D> Documentation/ABI/testing}/=
sysfs-bus-iio-impedance-analyzer-ad5933 (56%)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-temperature-max=
31856
 create mode 100644 Documentation/devicetree/bindings/iio/accel/kionix,kxcj=
k1013.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7780.txt
 create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/bmg160.=
txt
 create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16480=
.txt
 create mode 100644 Documentation/devicetree/bindings/iio/light/vcnl4000.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/proximity/devante=
ch-srf04.txt
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/devante=
ch-srf04.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/maxboti=
x,mb1232.txt
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/max31=
856.txt
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/tempe=
rature-bindings.txt
 rename drivers/{staging =3D> }/iio/adc/ad7780.c (63%)
 rename drivers/iio/imu/{adis16400_core.c =3D> adis16400.c} (77%)
 delete mode 100644 drivers/iio/imu/adis16400.h
 delete mode 100644 drivers/iio/imu/adis16400_buffer.c
 create mode 100644 drivers/iio/proximity/mb1232.c
 create mode 100644 drivers/iio/temperature/max31856.c
 create mode 100644 include/dt-bindings/iio/temperature/thermocouple.h
