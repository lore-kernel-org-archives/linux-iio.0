Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35135 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755647Ab3FEQZJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Jun 2013 12:25:09 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: AM335x tsc & adc, dt + cleanup take 3
Date: Wed,  5 Jun 2013 18:24:33 +0200
Message-Id: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Samuel,

can please take this via your mfd tree? I collected a few input & iio ACKs
for some of these patches. Unless ofcource someone wants a redo…

The following changes since commit d683b96b072dc4680fc74964eca77e6a23d1fa6e:

  Linux 3.10-rc4 (2013-06-02 17:11:17 +0900)

are available in the git repository at:

  git://git.breakpoint.cc/bigeasy/linux.git tags/am335x_tsc-adc

for you to fetch changes up to d1b713a3307101952215631046ced892397d1df4:

  iio/ti_am335x_adc: check if we found the value (2013-06-05 17:51:33 +0200)

----------------------------------------------------------------
A complete refurbished series inclunding:
- DT support for the MFD, TSC and ADC driver & platform device support,
  which has no users, has been killed
- suspend fixes which means correct data structs are taken and no
  interrupt storm
- fifo split which should problem with TSC & ADC beeing used at the same
  time
- The ADC channels are now checked before blindly applied. That means the
  touch part reads X, Y and Z coordinates and does not mix them up. Same
  goes for the IIO ADC driver.
- The IIO ADC driver now creates files named in_voltageX_raw where X
  represents the ADC line instead of a number starting at 0. A read from
  this file can return -EBUSY in case touch is busy and the ADC didn't
  collect a value.

----------------------------------------------------------------
Pantelis Antoniou (2):
      iio/ti_tscadc: Update with IIO map interface
      mfd/ti_tscadc: deal with partial activation

Patil, Rachna (7):
      input/ti_am33x_tsc: Step enable bits made configurable
      input/ti_am33x_tsc: Order of TSC wires, made configurable
      input/ti_am33x_tsc: remove unwanted fifo flush
      input/ti_am33x_tsc: Add DT support
      iio/ti_am335x_adc: Add DT support
      mfd/ti_am335x_tscadc: Add DT support
      arm/am33xx: add TSC/ADC mfd device support

Sebastian Andrzej Siewior (13):
      mfd/ti_am335x_tscadc: remove regmap
      mfd & input & iio/ti_am335x_adc: use one structure for ti_tscadc_dev
      input/ti_am33x_tsc: remove platform_data support
      iio/ti_am335x_adc: remove platform_data support
      mfd/ti_am335x_tscadc: remove platform_data support
      input & mfd: ti_am335x_tsc remove remaining platform data pieces
      mfd & input/ti_am335x_tsc: rename device from tsc to TI-am335x-tsc
      mfd & iio/ti_am335x_adc: rename device from tiadc to TI-am335x-adc
      input/ti_am335x_adc: use only FIFO0 and clean up a little
      input/ti_am335x_tsc: ACK the HW_PEN irq in ISR
      input/ti_am335x_tsc: return IRQ_NONE if there was no IRQ for us
      iio/ti_am335x_adc: Allow to specify input line
      iio/ti_am335x_adc: check if we found the value

 .../bindings/input/touchscreen/ti-tsc-adc.txt      |   44 +++
 arch/arm/boot/dts/am335x-evm.dts                   |   14 +
 arch/arm/boot/dts/am33xx.dtsi                      |    9 +
 drivers/iio/adc/ti_am335x_adc.c                    |  160 ++++++++---
 drivers/input/touchscreen/ti_am335x_tsc.c          |  286 ++++++++++++++------
 drivers/mfd/ti_am335x_tscadc.c                     |  131 ++++++---
 include/linux/input/ti_am335x_tsc.h                |   23 --
 include/linux/mfd/ti_am335x_tscadc.h               |   43 +--
 include/linux/platform_data/ti_am335x_adc.h        |   14 -
 9 files changed, 509 insertions(+), 215 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
 delete mode 100644 include/linux/input/ti_am335x_tsc.h
 delete mode 100644 include/linux/platform_data/ti_am335x_adc.h

Sebastian
