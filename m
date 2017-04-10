Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:38305 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753566AbdDJPvS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Apr 2017 11:51:18 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux-iio@vger.kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>
Subject: [PATCH v3 0/2] Add STM32H7 DAC driver
Date: Mon, 10 Apr 2017 17:49:48 +0200
Message-ID: <1491839390-2449-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patchset adds support for the STM32H7 DAC controller

It's a 12-bit, voltage output digital-to-analog converter. It has two
output channels, each with its own converter, trigger sources and
waveform generator.

Each channel can be used independently, so common resources are managed
in stm32-dac-core driver (e.g. clock, reset, regulator, registers).
One IIO device is instantiated per DAC output channel, in stm32-dac
driver, so each channel can have its own trigger.

Examples, using this driver to generate DC voltage output on channel1:
# set max DC voltage / enable / min DC voltage / disable on out1
cd /sys/bus/iio/devices/iio\:device0
echo 4095 > out_voltage1_raw
echo 0 > out_voltage1_powerdown
echo 0 > out_voltage1_raw
echo 1 > out_voltage1_powerdown
cat out_voltage_powerdown_mode_available
three_state

---
Changes in v3:
- Fix powerdown mode, use 'three_state' as documented in sysfs-bus-iio
- For now, drop support for triggers & waveform generator that requires more work.
  This needs to be discussed more deeply.

Changes in v2:
- Update dt binding, use 'reg' property to select channel
- Use 'powerdown' attribute instead of 'enable'
- Added set_trigger callback
- Use 'offset' attribute in waveform generation mode to add DC offset
- rework ABI for waveform generation mode
- Various typos, comments

Fabrice Gasnier (2):
  dt-bindings: iio: stm32-dac: Add support for STM32 DAC
  iio: dac: add support for stm32 DAC

 .../devicetree/bindings/iio/dac/st,stm32-dac.txt   |  61 ++++
 drivers/iio/dac/Kconfig                            |  15 +
 drivers/iio/dac/Makefile                           |   2 +
 drivers/iio/dac/stm32-dac-core.c                   | 180 +++++++++++
 drivers/iio/dac/stm32-dac-core.h                   |  51 ++++
 drivers/iio/dac/stm32-dac.c                        | 334 +++++++++++++++++++++
 6 files changed, 643 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/st,stm32-dac.txt
 create mode 100644 drivers/iio/dac/stm32-dac-core.c
 create mode 100644 drivers/iio/dac/stm32-dac-core.h
 create mode 100644 drivers/iio/dac/stm32-dac.c

-- 
1.9.1

