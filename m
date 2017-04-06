Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:11677 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933852AbdDFQNO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Apr 2017 12:13:14 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux-iio@vger.kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>
Subject: [PATCH v2 0/5] Add STM32H7 DAC driver
Date: Thu, 6 Apr 2017 18:11:51 +0200
Message-ID: <1491495116-7209-1-git-send-email-fabrice.gasnier@st.com>
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

Please find bellow basic examples, using this driver to:
- generate DC voltage output on channel1
- generate a triangle waveform on channel2

# set max DC voltage / enable / min DC voltage / disable on out1:
cd /sys/bus/iio/devices/iio\:device0
echo 4095 > out_voltage1_raw
echo 1 > out_voltage1_powerdown
echo 0 > out_voltage1_raw
echo 0 > out_voltage1_powerdown
cat out_voltage_powerdown_mode_available
Hi-Z enable

# configure timer trigger, and set triangle waveform with half
# amplitude and DC offset on out2:
cd /sys/bus/iio/devices/trigger9
cat name
tim2_trgo
echo 10000 > sampling_frequency

cd /sys/bus/iio/devices/iio\:device1
echo triangle > out_voltage2_wavetype
echo 2047 > out_voltage2_amplitude
echo 1024 > out_voltage2_offset
echo tim2_trgo > trigger/current_trigger
echo 1 > out_voltage2_powerdown

---
Changes in v2:
- Update dt binding, use 'reg' property to select channel
- Use 'powerdown' attribute instead of 'enable'
- Added set_trigger callback
- Use 'offset' attribute in waveform generation mode to add DC offset
- rework ABI for waveform generation mode
- Various typos, comments

Fabrice Gasnier (5):
  dt-bindings: iio: stm32-dac: Add support for STM32 DAC
  iio: dac: add support for stm32 DAC
  iio: trigger: add set_trigger callback to notify device
  iio: dac: stm32: add support for trigger events
  iio: dac: stm32: add support for waveform generator

 Documentation/ABI/testing/sysfs-bus-iio-dac-stm32  |  16 +
 .../devicetree/bindings/iio/dac/st,stm32-dac.txt   |  61 ++
 drivers/iio/dac/Kconfig                            |  18 +
 drivers/iio/dac/Makefile                           |   2 +
 drivers/iio/dac/stm32-dac-core.c                   | 180 ++++++
 drivers/iio/dac/stm32-dac-core.h                   |  63 ++
 drivers/iio/dac/stm32-dac.c                        | 631 +++++++++++++++++++++
 drivers/iio/industrialio-trigger.c                 |   6 +
 include/linux/iio/iio.h                            |   2 +
 9 files changed, 979 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dac-stm32
 create mode 100644 Documentation/devicetree/bindings/iio/dac/st,stm32-dac.txt
 create mode 100644 drivers/iio/dac/stm32-dac-core.c
 create mode 100644 drivers/iio/dac/stm32-dac-core.h
 create mode 100644 drivers/iio/dac/stm32-dac.c

-- 
1.9.1

