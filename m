Return-Path: <SRS0=UNU4=QK=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A545C169C4
	for <linux-iio@archiver.kernel.org>; Sun,  3 Feb 2019 21:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9358217D6
	for <linux-iio@archiver.kernel.org>; Sun,  3 Feb 2019 21:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549228680;
	bh=3/d9my5jWWwHdgMixfqCXsOSQA/PdAFviphfBDdDiMI=;
	h=Date:From:To:Subject:List-ID:From;
	b=Vg4D48WKGcB4AAt+PLb6Ztz2ZiH1Utp8ThyRLwqWhIXaOw5qD1yJOdSZBQoaXokAP
	 3/67VKRuNbZmamLGJvCsHn8tWpGTvcOjkIzE6uf53MwL4GtjQ6IiydvN1x/CptUmwX
	 bj6LiZpaLLWtRW2JEdWYbBozzGN+V+0p3f7cYoCg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfBCVSA (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 3 Feb 2019 16:18:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:35048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbfBCVSA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Feb 2019 16:18:00 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BCBC217D6;
        Sun,  3 Feb 2019 21:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549228678;
        bh=3/d9my5jWWwHdgMixfqCXsOSQA/PdAFviphfBDdDiMI=;
        h=Date:From:To:Subject:From;
        b=YW482NZgUQarxA8GCM5YhClJ87Zjc1R8CcziVBKyxrGpEONfew+hiIM9hw7hbR8qq
         fJQetHE3uXDN1ZewrqPYhLbzxleo/x7/urxGiEn2MAw7xg212ruJJ9J0x1Y0+5Hc1z
         QxQm1pgibou5KDzFL9WWscjobzpmKCaXdbKkvue8=
Date:   Sun, 3 Feb 2019 21:17:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] First set of IIO new device support etc for 5.1
Message-ID: <20190203211753.7b2d02cd@archlinux>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit c6cbcdea7ab94120b676a4865e9782ed3c06dc80:

  Merge tag 'iio-for-4.21b' of git://git.kernel.org/pub/scm/linux/kernel/gi=
t/jic23/iio into staging-next (2018-12-13 13:37:24 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-=
5.1a

for you to fetch changes up to 3fa30bf7004bb8069826ef85487f4753666a73da:

  iio: chemical: sps30: remove printk format specifier (2019-02-02 17:08:06=
 +0000)

----------------------------------------------------------------
First set of new device support, features and cleanup for IIO in the 5.1 cy=
cle

A number of interesting new devices supported plus a good set of staging
cleanup including one graduation and one drop.

New device support
* ad56886
  - Add support for AD5674R/AD5679R with some minor driver changes to suppo=
rt
    more channels.
* ad7768
  - New driver and dt bindings for this 24 bit ADC.
* max44009
  - New driver and dt bindings for this ambient light sensor.
* mpu6050
  - Support the ICM 20602 IMU. Minor tweaks due to slightly different
    register map.
* NPCM adc
  - New driver and dt bindings for this BMC ADC.
* Sensiron SGP30
  - Modifiers for ethanol and H2.
  - New driver and dt bindings.
  - Follow patch added self cleaning support.
* Sensiron SPS30
  - New channel type for mass concentration.
  - New driver and bindings.
  - Minor tidy up patch followed (drop fmt specifier as unused)
* st_pressure
  - lps22hh support. ID plus information structures and dt bindings.
* ti-ads124s08
  - Add binding doc and driver.

Staging graduations
* ad7606 driver and bindings.

Staging drops
* ad7152 CDC driver dropped.  This part is near EoL and no one is known
  to be using it.  If anyone surfaces obviously we can bring the driver
  back.  If not, good to drop it to avoid wasting anyone's time cleaning
  it up.

New features
* bme680
  - DT support and bindings doc.
* isl29018
  - Add regulator for VCC.
* mag3110
  - Add regulators for supplies.
* meson-saradc
  - Support the temperature sensors of more SoCs.
* mma8452
  - Add regulators for power suplies and binding docs to reflect them.
* st-accel
  - Support the undocumented but it seems fairly common _ONT ACPI method
    to specify orientation of the sensor.

Cleanup, minor fixes and fixes for staging driver that have been broken a
long time
* ad5933
  - Drop platform data alternative to specifying the reference voltage
    using a regulator.
  - Use the clock framework to contorl the reference clock.
  - Add a DT binding doc to cover the defacto binding.
* ad7280a
  - Split up some big functions to improve readability.
* ad7606
  - Allow for timeout if interrupt never occurs.
  - Use devm functions to simplify probe and remove.
  - Use the find_closest macro to avoid need for precise values from
    userspace.
  - Add missing vendor prefixes for various DT properties. Note the
    driver is in staging still and there are no known devicetrees.
  - Add explict OF device ID table.
  - Simplify the Kconfig choices
  - Change to a threaded IRQ.
  - SPDX and simple stype fixes.
* ad7816
  - Drop unnecessary variable init.
* ad9523
  - Check a return value that was ignored.
* ad9833
  - Drop platform data.  It was just setting most values to the hardware
    defaults.
  - Use the clock framework to provide the input clock.
* adt7316 (lots of staging cleanup)
  - Fix some wrong register / bit definitions
  - Invert the logic of the check for an ldac pin so it actually makes sens=
e.
  - Read the right register to get internal vref settings
  - Allow adt751x chips to use the internal vref for all DAC channels rather
    than a subset.
  - Remove dac vref bypass control from parts that don't have one.
  - Make the store DAC update mode function consistent with the show one.
  - Fix some spellings and other minor tidy up.
  - Avoid passing irq numbers around by putting all the irq logic in
    one place.
  - Fix an issue with the resolution of DAC control.
  - Fix support of the high resolution DAC mode (for temp proportional outp=
ut)
    where supported.
  - Fix DAC read and write calculations.
* st_lsm6dsx
  - Drop an unused variable (set but not read)
* xilinx-xadc
  - Check an unhandled return value.

----------------------------------------------------------------
Aditya Pakki (1):
      iio: adc: xilinx: check return value of xadc_write_adc_reg

Alexandru Ardelean (1):
      staging: iio: cdc: ad7152: remove driver completely

Andreas Brauchli (3):
      iio: Add modifiers for ethanol and H2 gases
      iio: chemical: sgp30: Support Sensirion SGP30/SGPC3 sensors
      iio: chemical: sgp30: add device tree support

Anson Huang (4):
      iio: magnetometer: mag3110: add vdd/vddio regulator operation support
      iio: light: isl29018: add vcc regulator operation support
      dt-bindings: iio: accel: mma8452: add power supplies property
      iio: accell: mma8452: add vdd/vddio regulator operation support

Beniamin Bia (2):
      staging: iio: frequency: ad9833: Get frequency value statically
      staging: iio: frequency: ad9833: Load clock using clock framework

Dan Murphy (2):
      iio: ti-ads124s08: Add DT binding documentation
      iio: adc: Add the TI ads124s08 ADC code

Daniel Drake (1):
      iio: st_accel: use ACPI orientation data

Hardik Singh Rathore (2):
      staging: iio: adt7316: drop unnecessary initialization of variables
      staging: iio: ad7816: drop unnecessary initialization of variables

Jeremy Fertic (11):
      staging: iio: adt7316: fix register and bit definitions
      staging: iio: adt7316: invert the logic of the check for an ldac pin
      staging: iio: adt7316: use correct variable in DAC_internal_Vref read
      staging: iio: adt7316: allow adt751x to use internal vref for all dacs
      staging: iio: adt7316: remove dac vref buffer bypass from adt751x
      staging: iio: adt7316: change interpretation of write to dac update m=
ode
      staging: iio: adt7316: correct spelling of ADT7316_DA_EN_VIA_DAC_LDCA
      staging: iio: adt7316: fix dac_bits assignment
      staging: iio: adt7316: fix handling of dac high resolution option
      staging: iio: adt7316: fix the dac read calculation
      staging: iio: adt7316: fix the dac write calculation

Kangjie Lu (1):
      iio: ad9523: fix a missing check of return value

Lorenzo Bianconi (1):
      dt-bindings: iio: pressure: add LPS22HH bindings

Marcelo Schmitt (3):
      staging: iio: ad5933: change regulator binging for vref
      staging: iio: ad5933: use clock framework for clock reference
      staging: iio: ad5933: add binding doc for ad5933

Martin Blumenstingl (2):
      dt-bindings: iio: adc: meson-saradc: update temperature sensor support
      iio: adc: meson-saradc: enable the temperature sensor two more SoCs

Mircea Caprioru (1):
      iio: dac: ad5686: Add support for AD5674R/AD5679R

Randolph Maa=C3=9Fen (2):
      dt-bindings: iio: imu: add icm20602 bindings to mpu6050
      iio: imu: mpu6050: Add support for the ICM 20602 IMU

Robert Eshleman (2):
      iio: light: add driver for MAX44009
      dt-bindings: iio: light: Add max44009

Sebastien Bourdelin (2):
      iio: chemical: bme680: Add device-tree support
      dt-bindings: iio: chemical: Add bindings for bme680

Shreeya Patel (1):
      Staging: iio: adt7316: Add all irq related code in adt7316_irq_setup()

Slawomir Stepien (2):
      staging: iio: adc: ad7280a: split ad7280_channel_init() to more funct=
ions
      staging: iio: adc: ad7280a: split ad7280_attr_init() to more functions

Stefan Popa (13):
      staging: iio: adc: ad7606: Use wait-for-completion handler
      staging: iio: adc: ad7606: Use devm functions in probe
      staging: iio: adc: ad7606: Use find_closest() macro
      staging: iio: adc: ad7606: Use vendor prefix for DT properties
      staging: iio: adc: ad7606: Add OF device ID table
      staging: iio: adc: ad7606: Simplify the Kconfing menu
      staging: iio: adc: ad7606: Use SPDX identifier
      staging: iio: adc: ad7606: Add support for threaded irq
      staging: iio: adc: ad7606: Misc style fixes (no functional change)
      staging: iio: adc: ad7606: Move out of staging
      dt-bindings: iio: adc: Add docs for AD7606 ADC
      iio: adc: Add AD7768-1 ADC basic support
      dt-bindings: iio: adc: Add docs for AD7768-1

Tomasz Duszynski (6):
      iio: add IIO_MASSCONCENTRATION channel type
      iio: chemical: add support for Sensirion SPS30 sensor
      dt-bindings: iio: chemical: sps30: add device tree support
      iio: chemical: sps30: add support for self cleaning
      iio: chemical: sps30: allow changing self cleaning period
      iio: chemical: sps30: remove printk format specifier

Tomer Maimon (2):
      dt-binding: iio: add NPCM ADC documentation
      iio: adc: add NPCM ADC driver

YueHaibing (1):
      iio: imu: st_lsm6dsx: remove set but not used variable ''

mario tesi (1):
      iio:st_pressure:initial lps22hh sensor support

 Documentation/ABI/testing/sysfs-bus-iio            |  21 +-
 Documentation/ABI/testing/sysfs-bus-iio-sps30      |  28 +
 .../devicetree/bindings/iio/accel/mma8452.txt      |   4 +
 .../devicetree/bindings/iio/adc/adi,ad7606.txt     |  65 +++
 .../devicetree/bindings/iio/adc/adi,ad7768-1.txt   |  41 ++
 .../bindings/iio/adc/amlogic,meson-saradc.txt      |   4 +
 .../bindings/iio/adc/nuvoton,npcm-adc.txt          |  35 ++
 .../devicetree/bindings/iio/adc/ti-ads124s08.txt   |  25 +
 .../devicetree/bindings/iio/chemical/bme680.txt    |  11 +
 .../bindings/iio/chemical/sensirion,sgp30.txt      |  15 +
 .../bindings/iio/chemical/sensirion,sps30.txt      |  12 +
 .../bindings/iio/impedance-analyzer/ad5933.txt     |  26 +
 .../devicetree/bindings/iio/imu/inv_mpu6050.txt    |   1 +
 .../devicetree/bindings/iio/light/max44009.txt     |  24 +
 .../devicetree/bindings/iio/st-sensors.txt         |   1 +
 MAINTAINERS                                        |  16 +
 drivers/iio/accel/mma8452.c                        | 105 +++-
 drivers/iio/accel/st_accel_core.c                  | 171 +++++-
 drivers/iio/adc/Kconfig                            |  60 +++
 drivers/iio/adc/Makefile                           |   6 +
 drivers/{staging =3D> }/iio/adc/ad7606.c             | 272 +++++-----
 drivers/{staging =3D> }/iio/adc/ad7606.h             |  17 +-
 drivers/{staging =3D> }/iio/adc/ad7606_par.c         |  46 +-
 drivers/{staging =3D> }/iio/adc/ad7606_spi.c         |  35 +-
 drivers/iio/adc/ad7768-1.c                         | 459 ++++++++++++++++
 drivers/iio/adc/meson_saradc.c                     |  33 ++
 drivers/iio/adc/npcm_adc.c                         | 335 ++++++++++++
 drivers/iio/adc/ti-ads124s08.c                     | 376 +++++++++++++
 drivers/iio/adc/xilinx-xadc-core.c                 |   4 +-
 drivers/iio/chemical/Kconfig                       |  11 +
 drivers/iio/chemical/Makefile                      |   2 +
 drivers/iio/chemical/bme680_i2c.c                  |   7 +
 drivers/iio/chemical/bme680_spi.c                  |   8 +
 drivers/iio/chemical/sgp30.c                       | 591 +++++++++++++++++=
++++
 drivers/iio/chemical/sps30.c                       | 545 +++++++++++++++++=
++
 drivers/iio/dac/Kconfig                            |   6 +-
 drivers/iio/dac/ad5686-spi.c                       |   7 +-
 drivers/iio/dac/ad5686.c                           |  42 +-
 drivers/iio/dac/ad5686.h                           |   2 +
 drivers/iio/frequency/ad9523.c                     |   7 +-
 drivers/iio/imu/inv_mpu6050/Kconfig                |   8 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |  31 ++
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |   6 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |   8 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c          |  12 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c       |   2 -
 drivers/iio/industrialio-core.c                    |   5 +
 drivers/iio/light/Kconfig                          |  10 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/isl29018.c                       |  46 +-
 drivers/iio/light/max44009.c                       | 555 +++++++++++++++++=
++
 drivers/iio/magnetometer/mag3110.c                 |  94 +++-
 drivers/iio/pressure/Kconfig                       |   2 +-
 drivers/iio/pressure/st_pressure.h                 |   2 +
 drivers/iio/pressure/st_pressure_core.c            |  69 +++
 drivers/iio/pressure/st_pressure_i2c.c             |   5 +
 drivers/iio/pressure/st_pressure_spi.c             |   5 +
 drivers/staging/iio/adc/Kconfig                    |  34 --
 drivers/staging/iio/adc/Makefile                   |   4 -
 drivers/staging/iio/adc/ad7280a.c                  | 243 ++++++---
 drivers/staging/iio/adc/ad7816.c                   |   7 +-
 drivers/staging/iio/addac/adt7316-i2c.c            |   6 +-
 drivers/staging/iio/addac/adt7316-spi.c            |   4 +-
 drivers/staging/iio/addac/adt7316.c                | 143 ++---
 drivers/staging/iio/cdc/Kconfig                    |  10 -
 drivers/staging/iio/cdc/Makefile                   |   1 -
 drivers/staging/iio/cdc/ad7152.c                   | 552 -----------------=
--
 drivers/staging/iio/frequency/ad9834.c             |  54 +-
 drivers/staging/iio/frequency/ad9834.h             |  28 -
 drivers/staging/iio/impedance-analyzer/ad5933.c    |  57 +-
 include/linux/iio/common/st_sensors.h              |   1 +
 include/uapi/linux/iio/types.h                     |   7 +
 tools/iio/iio_event_monitor.c                      |  14 +
 73 files changed, 4431 insertions(+), 1071 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-sps30
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7606.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.=
txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton,npcm-=
adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-ads124s08.=
txt
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/bme680.t=
xt
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirio=
n,sgp30.txt
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirio=
n,sps30.txt
 create mode 100644 Documentation/devicetree/bindings/iio/impedance-analyze=
r/ad5933.txt
 create mode 100644 Documentation/devicetree/bindings/iio/light/max44009.txt
 rename drivers/{staging =3D> }/iio/adc/ad7606.c (73%)
 rename drivers/{staging =3D> }/iio/adc/ad7606.h (88%)
 rename drivers/{staging =3D> }/iio/adc/ad7606_par.c (75%)
 rename drivers/{staging =3D> }/iio/adc/ad7606_spi.c (67%)
 create mode 100644 drivers/iio/adc/ad7768-1.c
 create mode 100644 drivers/iio/adc/npcm_adc.c
 create mode 100644 drivers/iio/adc/ti-ads124s08.c
 create mode 100644 drivers/iio/chemical/sgp30.c
 create mode 100644 drivers/iio/chemical/sps30.c
 create mode 100644 drivers/iio/light/max44009.c
 delete mode 100644 drivers/staging/iio/cdc/ad7152.c
