Return-Path: <SRS0=Gvxw=OV=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,T_MIXED_ES autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3E8C65BAF
	for <linux-iio@archiver.kernel.org>; Wed, 12 Dec 2018 18:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453D52084E
	for <linux-iio@archiver.kernel.org>; Wed, 12 Dec 2018 18:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544639569;
	bh=s9FCjc0f1X+FpGSeiddcozuhH1Ml+o7ucceZj3LH1D4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=r0ySw5O38UuEQmg7GjeKulfC2u/3+UQMoTLWpIe56+cB3lanI0ZFfYX2BweYjc4zW
	 Wcqazmn2qVg0lvaLD5rDPJTz3AR8QzQSskfQ577qlPT9zePGdW0fvFdr5tADEfLCMk
	 AXBkyx9QgyK3Cc6lLqIgN6mTTsHW46RF6IzpVQD8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 453D52084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-iio-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeLLScs (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:32:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:41240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728128AbeLLScs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 12 Dec 2018 13:32:48 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3BE12084E;
        Wed, 12 Dec 2018 18:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544639567;
        bh=s9FCjc0f1X+FpGSeiddcozuhH1Ml+o7ucceZj3LH1D4=;
        h=Date:From:To:Cc:Subject:From;
        b=eso58E2tbGvJt0TclzTc4+QnIWLQVPij8riI099uWGfaqf3+Q0vQpWRUz5JKNUtGF
         WmgpvOolrft44Id+2L2wIAJ8tnEPJap1z+NGaryEVLlOroiL5+CBJJDMfo8hZdtjAe
         8RSumq4ToQY8uxwmvtZH8yWGRlZ6fn6Pcit4vr+k=
Date:   Wed, 12 Dec 2018 18:32:42 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org
Subject: [PULL] Second set of IIO new device support, features, cleanups and
 minor fixes for 4.21
Message-ID: <20181212183242.27562340@archlinux>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 16c44c57ecd89402a1acc81617cff463ff446fe7:

  staging: vboxvideo: Rename uint32_t type to u32 (2018-11-23 10:58:47 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.21b

for you to fetch changes up to db23d88756abd38e0995ea8449d0025b3de4b26b:

  iio: adc: qcom-spmi-adc5: Initialize prescale properly (2018-12-12 17:45:30 +0000)

----------------------------------------------------------------
Second set of IIO new device support, features and cleanups for the 4.21 cycle.

Staging graduation
* ad2s90
  - Driver for this resolver to digital chip.

New drivers and device support.
* ad5686
  - Add support for ad5310r DAC and associated fix in value read back.
* exynos-adc
  - Support for S5PV210 which is slightly different from other parts.
* mcp41010
  - Driver supporting MCP41010, MCP41050, MCP41100, MCP42010, MCP42050 and
  MCP42100 microchip potentiometers.

New ACPI ids.
* ak8975
  - AKM9911 ACPI HID.
* kxcjk-1013
  - KXJ2109 ACPI HID.
  - KIOX010A ACPI HID.

New features
* ad5933
  - Explicit DT binding.
* ad2s90
  - Explicit DT binding including dropping spi setup that is done via dt
    in favour of verifying the settings form DT.
* adt7316
  - Explicit DT binding and support for gpio, irq_flags etc.
* stm32-adc
  - Runtime power management.

Minor fixes and cleanups
* core
  - Protect against missing info structure.
* ad2s90
  - SPDX
  - Add documentation fo the mutex.
* ad7280a
  - Check allocation failure.
  - Fix an accidental replacement of an error return.
* adt7316
  - Switch some variables to be local and rename for consistency with other
    drivers.
  - Revert a false handling of 0 as an error introduced earlier this cycle.
* bmi160
  - Use devm functions throughout probe() to avoid need for remove().
* hid-sensor-hub
  - White space cleanup.
* hts221
  - MAINTAINERS entry.
* lis302
  - Use generic name in the DT binding doc.
* Messon-saradc
  - Check for allocation error.
  - Fix some presented clock names that break clk debugfs.
* qcom-spmi-adc
  - A fix for initialization of the prescale property. Came late in the
    cycle, so merge window is probably the best route for this.
* st_lsm6dsx
  - Allow for variable read length to support wider range of slave devices.

----------------------------------------------------------------
Alexandru Ardelean (1):
      staging:iio:ad2s90: Add max frequency check at probe

Andi Shyti (1):
      iio: core: check 'info' value before registering the device

Chris Coffey (2):
      dt-bindings: iio: potentiometer: Add Microchip MCP41xxx/42xxx
      iio: potentiometer: Add driver for Microchip MCP41xxx/42xxx

Colin Ian King (1):
      iio: hid-sensor-hub: clean up indentation, remove extraneous tab

Evan Green (1):
      iio: adc: qcom-spmi-adc5: Initialize prescale properly

Fabrice Gasnier (3):
      iio: adc: stm32-adc: move self-calibration to prepare routine
      iio: adc: stm32-adc: add power management support
      iio: adc: stm32-adc: switch off running adc when going to low power

Hans de Goede (1):
      iio: accel: kxcjk1013: Add KIOX010A ACPI Hardware-ID

Jeremy Fertic (1):
      Revert "Staging: iio: adt7316: Add an extra check for 'ret' equals to 0"

Jonathan Bakker (3):
      iio: adc: exynos-adc: Add S5PV210 variant
      iio: adc: Allow selection of Exynos ADC on S5PV210
      dt-bindings: iio: adc: exynos-adc: Add S5PV210 variant

Lorenzo Bianconi (2):
      iio: imu: st_lsm6dsx: do not use a fixed read len in read_oneshot
      iio: humidity: hts221: add entry in MAINTAINERS file

Lubomir Rintel (1):
      dt-bindings: iio: accel: use a generic node name for lis302

Marcelo Schmitt (1):
      staging: iio: ad5933: add device tree support

Martin Blumenstingl (1):
      iio: adc: meson-saradc: fix internal clock names

Martin Kelly (1):
      iio: bmi160: use all devm functions in probe

Matheus Tavares (5):
      staging:iio:ad2s90: Add device tree support
      staging:iio:ad2s90: Remove spi setup that should be done via dt
      dt-bindings:iio:resolver: Add docs for ad2s90
      staging:iio:ad2s90: Replace license text w/ SPDX identifier
      staging:iio:ad2s90: Move out of staging

Mircea Caprioru (1):
      iio: dac: ad5686: fix bit shift read register

Nicholas Mc Guire (2):
      iio: adc: meson-saradc: check for devm_kasprintf failure
      staging: iio: adc: ad7280a: check for devm_kasprint() failure

Shreeya Patel (4):
      Staging: iio: adt7316: Add of_device_id table
      Staging: iio: adt7316: Use device tree data to set ldac_pin
      Staging: iio: adt7316: Switch irq_flags to a local variable
      Staging: iio: adt7316: Change the name from irq_flags to irq_type

Slawomir Stepien (1):
      staging: iio: adc: ad7280a: fix overwrite of the returned value

Stefan Popa (1):
      iio:dac:ad5686: Add AD5310R support

Stephan Gerhold (2):
      iio: accel: kxcjk-1013: Add the "KXJ2109" ACPI HID
      iio: magnetometer: ak8975: Add the "AKM9911" ACPI HID

Victor Colombo (1):
      staging:iio:ad2s90: Add comment to device state mutex

 .../devicetree/bindings/iio/accel/lis302.txt       |   4 +-
 .../bindings/iio/adc/samsung,exynos-adc.txt        |   4 +-
 .../bindings/iio/potentiometer/mcp41010.txt        |  28 ++
 .../devicetree/bindings/iio/resolver/ad2s90.txt    |  31 +++
 MAINTAINERS                                        |   8 +
 drivers/iio/accel/kxcjk-1013.c                     |   2 +
 drivers/iio/adc/Kconfig                            |   2 +-
 drivers/iio/adc/exynos_adc.c                       |  14 +
 drivers/iio/adc/meson_saradc.c                     |  14 +-
 drivers/iio/adc/qcom-spmi-adc5.c                   |  58 ++--
 drivers/iio/adc/stm32-adc-core.c                   | 182 +++++++++----
 drivers/iio/adc/stm32-adc.c                        | 303 +++++++++++++++------
 .../iio/common/hid-sensors/hid-sensor-attributes.c |   2 +-
 drivers/iio/dac/ad5686-spi.c                       |  21 +-
 drivers/iio/dac/ad5686.c                           |  19 +-
 drivers/iio/dac/ad5686.h                           |   7 +
 drivers/iio/imu/bmi160/bmi160.h                    |   1 -
 drivers/iio/imu/bmi160/bmi160_core.c               |  38 +--
 drivers/iio/imu/bmi160/bmi160_i2c.c                |   8 -
 drivers/iio/imu/bmi160/bmi160_spi.c                |   8 -
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c       |  14 +-
 drivers/iio/industrialio-core.c                    |   3 +
 drivers/iio/magnetometer/ak8975.c                  |   1 +
 drivers/iio/potentiometer/Kconfig                  |  12 +
 drivers/iio/potentiometer/Makefile                 |   1 +
 drivers/iio/potentiometer/mcp41010.c               | 203 ++++++++++++++
 drivers/iio/resolver/Kconfig                       |  10 +
 drivers/iio/resolver/Makefile                      |   1 +
 drivers/{staging => }/iio/resolver/ad2s90.c        |  38 +--
 drivers/staging/iio/adc/ad7280a.c                  |  51 ++--
 drivers/staging/iio/addac/adt7316-i2c.c            |  18 +-
 drivers/staging/iio/addac/adt7316-spi.c            |   1 -
 drivers/staging/iio/addac/adt7316.c                |  22 +-
 drivers/staging/iio/addac/adt7316.h                |   1 -
 drivers/staging/iio/impedance-analyzer/ad5933.c    |   9 +
 drivers/staging/iio/resolver/Kconfig               |  10 -
 drivers/staging/iio/resolver/Makefile              |   1 -
 37 files changed, 852 insertions(+), 298 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/mcp41010.txt
 create mode 100644 Documentation/devicetree/bindings/iio/resolver/ad2s90.txt
 create mode 100644 drivers/iio/potentiometer/mcp41010.c
 rename drivers/{staging => }/iio/resolver/ad2s90.c (79%)
