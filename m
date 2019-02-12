Return-Path: <SRS0=KJmS=QT=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00A0C282C4
	for <linux-iio@archiver.kernel.org>; Tue, 12 Feb 2019 21:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624BF2081B
	for <linux-iio@archiver.kernel.org>; Tue, 12 Feb 2019 21:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550006116;
	bh=l6o0/SlH0/8sqHB1vaTWKKBebWVFHjCs0+sDu7Zf/WQ=;
	h=Date:From:To:Subject:List-ID:From;
	b=hZdrPpnBnRSeR+MeuA2ahkOIaTIWB2ecYjkGILe6SS9Nb0+rSkBUfdql5AcXsgvz7
	 IhZvdV1SA9Di0XR+t0PhNDfqUluRNwRKTJI3XuFlTwksxXiviCfyEocGh4uOdFVvgZ
	 vDHZChhEKI2q/HQ5dasExKuR7s/+i0Bm91MYW3Gc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732386AbfBLVPP (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:15:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:53416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727932AbfBLVPP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 12 Feb 2019 16:15:15 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0CE12081B;
        Tue, 12 Feb 2019 21:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550006114;
        bh=l6o0/SlH0/8sqHB1vaTWKKBebWVFHjCs0+sDu7Zf/WQ=;
        h=Date:From:To:Subject:From;
        b=2JrgQPl/Fd0I9pRulbC8M43bsW/8Ts/QnoKlu1IBH0mDFMPKoDCO/rc7v4QMgT9Bv
         tdg5jW5CAUQkTMpsl9QxXjCfbUsD3RnEtBNTJQctvoi8nihmiGCPz5pbCUtC2oqCue
         4ExxmqhKN0IakH3V6bsVN2HLWUXV+oJaul+hbXMg=
Date:   Tue, 12 Feb 2019 21:15:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] IIO second set of new device support, cleanups and features
 for the 5.1 cycle.
Message-ID: <20190212211510.5707e70f@archlinux>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit c2f4dd4364b71ef4eb43925b402377aefe9c1ca0:

  staging: wlan-ng: formatting change in cfg80211.c (2019-02-08 10:31:14 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.1b

for you to fetch changes up to 103cda6a3b8d2c10d5f8cd7abad118e9db8f4776:

  iio: adc: exynos-adc: Use proper number of channels for Exynos4x12 (2019-02-12 20:56:00 +0000)

----------------------------------------------------------------
Second set of new device support, features and cleanup for IIO in the 5.1 cycle.

There are a few late breaking fixes in here that weren't worth trying to
rush into 5.0 as they have been with us for quite a while.

New device support
* ad7476
  - add support for TI ADS786X parts that are compatible with this Analog
    Devices driver. Good to see some simple devices are so similar.
* Ingenic jz47xx SoC ADCs
  - new driver and bindings
* Plantower PMS7003 partical sensor
  - new driver and bindings including vendor prefix.
* TI DAC7612
  - new driver and bindings for this dual DAC.

New features
* ad7768-1
  - Sampling frequency control
* bmi160
  - Data ready trigger support, including open-drain dt binding.

Cleanup / minor fixes.
* Analog Device DACs
  - Fix some inconsistent licenses.  These are only ones where there were
    two different license marked in the same file, and hence were previously
    unclear.
* ads124s08
  - Spelling fix.
* adxl345
  - Parameter alignement tidy up.
* bmi160
  - SPDX
  - correct a note on the types of supported interrupts which was too strict.
  - use iio_pollfunc_store_time to grab an earlier timestamp.
  - use if (ret) instead of if (ret < 0) to be consistent whilst simplifying
    some handling where ret was effectively getting written to 0 even though
    it was always already 0.
* exynos_adc
  - Fix a null pointer dereference on unbind.
  - Fix number of channels on Exynos4x12 devices to be 4 rather than 8.
* lpc32xx-adc
  - Move DT bindings doc out of staging. Oops, I missed this one when
    moving the driver.
  - SPDX.
* npcm-adc
  - drop documentation of reset node as going to be done differently.
    It's a new driver this cycle so no need to support the previous
    binding going forwards.
* sps30
  - Fix an issue with a loop timeout test that meant it would never identify
    a timeout.
  - Mark deliberate switch fall throughs.

----------------------------------------------------------------
Artur Rojek (3):
      dt-bindings: iio/adc: Add docs for Ingenic JZ47xx SoCs ADC.
      dt-bindings: iio/adc: Add bindings for Ingenic JZ47xx SoCs ADC.
      IIO: add Ingenic JZ47xx ADC driver.

Colin Ian King (1):
      iio: adc: ads124s08: fix spelling mistake "converions" -> "conversions"

Dan Carpenter (1):
      iio: chemical: sps30: fix a loop timeout test

Gregory CLEMENT (2):
      dt-bindings: iio: adc: move lpc32xx-adc out of staging
      iio:adc:lpc32xx use SPDX-License-Identifier

Jonathan Cameron (1):
      iio:chemical:sps30 Supress some switch fallthrough warnings.

Krzysztof Kozlowski (2):
      iio: adc: exynos-adc: Fix NULL pointer exception on unbind
      iio: adc: exynos-adc: Use proper number of channels for Exynos4x12

Luciana da Costa Marques (1):
      iio:accel:adxl345: Change alignment to match paranthesis

Martin Kelly (6):
      iio:bmi160: add SPDX identifiers
      iio:bmi160: add drdy interrupt support
      dt-bindings: fix incorrect bmi160 IRQ note
      dt-bindings: bmi160 document open-drain property
      iio:bmi160: use iio_pollfunc_store_time
      iio:bmi160: use if (ret) instead of if (ret < 0)

Ricardo Ribalda Delgado (3):
      iio: adc: ad7476: Add support for TI ADS786X ADCs
      iio:dac:ti-dac7612: Add driver for Texas Instruments DAC7612
      iio:dac:dac7612: device tree bindings

Stefan Popa (2):
      drivers: iio: dac: Fix wrong license for ADI drivers
      iio: adc: ad7768-1: Add support for setting the sampling frequency

Tomasz Duszynski (3):
      iio: chemical: add support for Plantower PMS7003 sensor
      dt-bindings: add Plantower to the vendor prefixes
      dt-bindings: iio: chemical: pms7003: add device tree support

Tomer Maimon (1):
      dt-binding: iio: remove rst node from NPCM ADC document

 .../devicetree/bindings/iio/adc/ingenic,adc.txt    |  48 +++
 .../bindings/{staging => }/iio/adc/lpc32xx-adc.txt |   0
 .../bindings/iio/adc/nuvoton,npcm-adc.txt          |  11 -
 .../bindings/iio/adc/samsung,exynos-adc.txt        |   4 +-
 .../bindings/iio/chemical/plantower,pms7003.txt    |  20 ++
 .../devicetree/bindings/iio/dac/ti,dac7612.txt     |  28 ++
 .../devicetree/bindings/iio/imu/bmi160.txt         |   6 +-
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 MAINTAINERS                                        |   7 +
 drivers/iio/accel/adxl345_core.c                   |   4 +-
 drivers/iio/adc/Kconfig                            |  20 +-
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ad7476.c                           |  20 ++
 drivers/iio/adc/ad7768-1.c                         | 202 +++++++++++-
 drivers/iio/adc/exynos_adc.c                       |  19 +-
 drivers/iio/adc/ingenic-adc.c                      | 364 +++++++++++++++++++++
 drivers/iio/adc/lpc32xx_adc.c                      |  15 +-
 drivers/iio/adc/ti-ads124s08.c                     |   8 +-
 drivers/iio/chemical/Kconfig                       |  10 +
 drivers/iio/chemical/Makefile                      |   1 +
 drivers/iio/chemical/pms7003.c                     | 340 +++++++++++++++++++
 drivers/iio/chemical/sps30.c                       |   5 +-
 drivers/iio/dac/Kconfig                            |  10 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/ad5686-spi.c                       |   2 +-
 drivers/iio/dac/ad5686.c                           |   2 +-
 drivers/iio/dac/ad5686.h                           |   2 +-
 drivers/iio/dac/ad5696-i2c.c                       |   2 +-
 drivers/iio/dac/ad5758.c                           |   2 +-
 drivers/iio/dac/ti-dac7612.c                       | 184 +++++++++++
 drivers/iio/imu/bmi160/bmi160.h                    |  11 +
 drivers/iio/imu/bmi160/bmi160_core.c               | 317 ++++++++++++++++--
 drivers/iio/imu/bmi160/bmi160_i2c.c                |   5 +-
 drivers/iio/imu/bmi160/bmi160_spi.c                |   4 +-
 include/dt-bindings/iio/adc/ingenic,adc.h          |  10 +
 35 files changed, 1601 insertions(+), 85 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt
 rename Documentation/devicetree/bindings/{staging => }/iio/adc/lpc32xx-adc.txt (100%)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt
 create mode 100644 drivers/iio/adc/ingenic-adc.c
 create mode 100644 drivers/iio/chemical/pms7003.c
 create mode 100644 drivers/iio/dac/ti-dac7612.c
 create mode 100644 include/dt-bindings/iio/adc/ingenic,adc.h
