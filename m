Return-Path: <SRS0=x61j=S2=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C8CC10F11
	for <linux-iio@archiver.kernel.org>; Wed, 24 Apr 2019 19:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0626E20674
	for <linux-iio@archiver.kernel.org>; Wed, 24 Apr 2019 19:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556135383;
	bh=2KMTxtYEJavYFnpOOYA/i6hDj2Bqnnvh8X6XoIIseQM=;
	h=Date:From:To:Subject:List-ID:From;
	b=q6hTklBpqxE/LkyaEvqumVB6OCgnIZThk0BLKWU05UxMiO4QbSGlU7tKtfnrmWrtA
	 NrW8PIYgocgxqyLRvWDGJGyU4oauwIdxjt/WCbGxDeaDBrOGy9r5Epl7qtpQ3YF/xf
	 FY4m7J0riUtZM8sVJg/xRFnXA22rZ0/ZVQnNzIsM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730739AbfDXTtm (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:49:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfDXTtl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 24 Apr 2019 15:49:41 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F52E20674;
        Wed, 24 Apr 2019 19:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556135380;
        bh=2KMTxtYEJavYFnpOOYA/i6hDj2Bqnnvh8X6XoIIseQM=;
        h=Date:From:To:Subject:From;
        b=BWFAWr4/8Wy/P6avrXVg8RSUmPu4Uxnan+X3S7hEuAAT/IfMG7wBDiqAbSZke3cNh
         QZE2yRb8+dOm3CxsXDA9jxqzoZWExdlsgE1s1qNFChAsJpoQq5RT36nZN6dKAF/WAo
         YbuHn0i57n9ZTkNyTgmKqFnC0cncu1OkpeIwwdOw=
Date:   Wed, 24 Apr 2019 20:49:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] Second round of new device support etc for IIO in the 5.2
 cycle.
Message-ID: <20190424204931.04005591@archlinux>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 932f98922f6fca9f8c45274346b49058dd50d51a:

  Merge tag 'iio-for-5.2a-2' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next (2019-04-04 22:25:29 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.2b

for you to fetch changes up to 447ccb4e0834a9f9f0dd5643e421c7f1a1649e6a:

  iio: adc: qcom-spmi-adc5: Fix of-based module autoloading (2019-04-22 11:51:29 +0100)

----------------------------------------------------------------
Second set of IIO new device support, features and cleanup for the 5.2 cycle.

New device suport
* ad7606
  - Support the AD7616 16 channel, 12bit ADC.
* fxas21002c
  - New driver for this gyroscope with I2C and SPI support.
* lsm6dsx
  - Support the lsm6dsr, new device information structure and dt bindings.
* srf04
  - Addition device IDs for mb1000, mb1010, mb1020, mb1030 and mb1040 +
    support of different required trigger pulse lengths.
* st-accel
  - Support the ls2de12, new device info and dt bindings.
* ti-ads8344
  - New driver for this 8 channel, 16 bit SPI ADC.

Binding conversions to yaml - we have started doing these in general for IIO.
* avia-hx711
* bmp085

Cleanups and minor fixes / additions
* ad5758
  - Fixup for some changes between preproduction parts and final part.
* ad7606
  - Refactor handling of oversampling to make it easy to vary between
    supported devices.
* ad9832
  - Organise includes.
  - Clock framework to handle clocks.
* ad9834
  - Drop unnecessary parenthesis.
* bmc150
  - Use __func__ rather than hardcoding.
* dummy_evgen.
  - Fix a memleak on error in probe.
* kxcjk1013
  - Add KXCJ91008 ACPI ID as seen in the wild.
  - Use __func__ rather than hardcoding.
* imx7d
  - Local dev variable to simplify code a bit.
  - dev_err replaces pr_err to give more info.
  - devm_platform_ioremap_resource for small reduction in boilerplate.
  - Simplify probe and remove by sharing suspend / resume logic.
  - Devm for iio_device_register as remove only contains the unregister.
* lsm6dsx
  - Remove a variable that was never read.
  - Open code values where they are effectively described by what is assigned
    to them rather than using uninformative defines.
* max31856
  - Avoid an unintialized ret variable in a path that can't actually occur
    but is hard for a static checker to know.
* max9611
  - White space
* mpu3050
  - Reduce a sleep worst case by switching from msleep to usleep_range.
* qcom-spmi-adc5
  - Add MODULE_DEVICE_TABLE to assist autoloading of this as a module.
* stm32-dfsdm
  - Fix missing dependencies.
* stm32-timer trigger
  - Fix a build issue when disabled.
* ti-ads7950
  - Fix mising dependency on CONFIG_GPIOLIB.

----------------------------------------------------------------
Andreas Klinger (5):
      avia-hx711.yaml: transform DT binding to YAML
      bmp085.yaml: transform DT documentation of iio sensor into YAML
      srf04.c: add maxbotix ultrasonic sensors
      dt-bindings: iio: srf04: add Maxbotix ultrasonic iio proximity sensors
      Kconfig: change configuration of srf04 ultrasonic iio sensor

Andrey Smirnov (6):
      iio: imx7d_adc: Add local struct device pointer in imx7d_adc_probe()
      iio: imx7d_adc: Replace pr_err with dev_err
      iio: imx7d_adc: Use devm_platform_ioremap_resource()
      iio: imx7d_adc: Simplify imx7d_adc_probe() with imx7d_adc_resume()
      iio: imx7d_adc: Simplify imx7d_adc_remove() with imx7d_adc_suspend()
      iio: imx7d_adc: Use devm_iio_device_register()

Beniamin Bia (2):
      iio: adc: ad7616: Add support for AD7616 ADC
      dt-bindings: iio: adc: Add AD7616 ADC documentation

Bjorn Andersson (1):
      iio: adc: qcom-spmi-adc5: Fix of-based module autoloading

Colin Ian King (1):
      iio: temperature: max31856: fix uninitialized error return

Fabrice Gasnier (3):
      iio: trigger: stm32-timer: fix build issue when disabled
      iio: adc: stm32-dfsdm: fix unmet direct dependencies detected
      iio: adc: stm32-dfsdm: fix triggered buffer build dependency

Fabrizio Castro (1):
      iio: adc: Fix MAX9611 spacing

Gregory CLEMENT (2):
      dt-bindings: iio: adc: Add bindings for TI ADS8344 A/DC chips
      iio: adc: Add driver for the TI ADS8344 A/DC chips

Lorenzo Bianconi (3):
      iio: imu: st_lsm6dsx: add support to LSM6DSR
      dt-bindings: iio: imu: st_lsm6dsx: add lsm6dsr device bindings
      iio: imu: st_lsm6dsx: inline per-sensor data

Marcelo Schmitt (2):
      staging: iio: ad9832: organize includes
      staging: iio: ad9832: use clock framework for clock reference

Melissa Wen (1):
      staging: iio: frequency: ad9834: Remove unnecessary parentheses

Mircea Caprioru (1):
      iio: dac: ad5758: Modifications for new revision

Mohan Kumar (2):
      drivers/iio/gyro/mpu3050-core.c: This patch fix the following checkpatch warning.
      iio:accel:Switch hardcoded function name with a reference to __func__ making the code more maintainable

Pan Bian (1):
      iio: dummy_evgen: fix possible memleak in evgen init

Robert Jones (2):
      dt-bindings: iio: accel: add LIS2DE12 sensor device binding
      iio: accel: add support to LIS2DE12

Rui Miguel Silva (5):
      iio: gyro: add DT bindings to fxas21002c
      iio: gyro: add core driver for fxas21002c
      iio: gyro: fxas21002c: add i2c driver
      iio: gyro: fxas21002c: add spi driver
      MAINTAINERS: add entry for fxas21002c gyro driver

Stefan Popa (1):
      iio: adc: ad7606: Move oversampling options in chip info and rework *_avail attributes

Valentin Manea (1):
      iio: accel: kxcjk1013: Add KIOX0008 ACPI Hardware-ID

YueHaibing (2):
      iio: imu: st_lsm6dsx: remove set but not used variables 'acc_sensor' and 'gyro_sensor'
      iio: adc: ti-ads7950: Fix build error without CONFIG_GPIOLIB

 .../devicetree/bindings/iio/adc/adi,ad7606.txt     |    1 +
 .../devicetree/bindings/iio/adc/avia-hx711.txt     |   24 -
 .../devicetree/bindings/iio/adc/avia-hx711.yaml    |   66 ++
 .../devicetree/bindings/iio/adc/ti-ads8344.txt     |   19 +
 .../bindings/iio/gyroscope/nxp,fxas21002c.txt      |   31 +
 .../devicetree/bindings/iio/imu/st_lsm6dsx.txt     |    1 +
 .../devicetree/bindings/iio/pressure/bmp085.txt    |   27 -
 .../devicetree/bindings/iio/pressure/bmp085.yaml   |   70 ++
 .../bindings/iio/proximity/devantech-srf04.yaml    |   25 +-
 .../devicetree/bindings/iio/st-sensors.txt         |    1 +
 MAINTAINERS                                        |   10 +
 drivers/iio/accel/Kconfig                          |    2 +-
 drivers/iio/accel/bmc150-accel-core.c              |    2 +-
 drivers/iio/accel/kxcjk-1013.c                     |    3 +-
 drivers/iio/accel/st_accel.h                       |    2 +
 drivers/iio/accel/st_accel_core.c                  |   76 ++
 drivers/iio/accel/st_accel_i2c.c                   |    5 +
 drivers/iio/adc/Kconfig                            |   16 +-
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/ad7606.c                           |  120 ++-
 drivers/iio/adc/ad7606.h                           |   25 +-
 drivers/iio/adc/ad7606_spi.c                       |    2 +
 drivers/iio/adc/imx7d_adc.c                        |  175 ++--
 drivers/iio/adc/qcom-spmi-adc5.c                   |    1 +
 drivers/iio/adc/ti-ads8344.c                       |  204 ++++
 drivers/iio/dac/ad5758.c                           |   55 +-
 drivers/iio/dummy/iio_dummy_evgen.c                |    5 +-
 drivers/iio/gyro/Kconfig                           |   22 +
 drivers/iio/gyro/Makefile                          |    3 +
 drivers/iio/gyro/fxas21002c.h                      |  150 +++
 drivers/iio/gyro/fxas21002c_core.c                 | 1004 ++++++++++++++++++++
 drivers/iio/gyro/fxas21002c_i2c.c                  |   69 ++
 drivers/iio/gyro/fxas21002c_spi.c                  |   70 ++
 drivers/iio/gyro/mpu3050-core.c                    |    2 +-
 drivers/iio/imu/st_lsm6dsx/Kconfig                 |    2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |    2 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |   12 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |  117 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c        |    5 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c        |    5 +
 drivers/iio/proximity/Kconfig                      |   11 +-
 drivers/iio/proximity/srf04.c                      |   38 +-
 drivers/iio/temperature/max31856.c                 |    3 +
 drivers/staging/iio/frequency/ad9832.c             |   51 +-
 drivers/staging/iio/frequency/ad9832.h             |    1 -
 drivers/staging/iio/frequency/ad9834.c             |    2 +-
 include/linux/iio/timer/stm32-timer-trigger.h      |   11 +-
 47 files changed, 2242 insertions(+), 307 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-ads8344.txt
 create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/pressure/bmp085.txt
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
 create mode 100644 drivers/iio/adc/ti-ads8344.c
 create mode 100644 drivers/iio/gyro/fxas21002c.h
 create mode 100644 drivers/iio/gyro/fxas21002c_core.c
 create mode 100644 drivers/iio/gyro/fxas21002c_i2c.c
 create mode 100644 drivers/iio/gyro/fxas21002c_spi.c
