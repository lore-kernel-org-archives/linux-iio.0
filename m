Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751749AbdLBP0v (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 2 Dec 2017 10:26:51 -0500
Date: Sat, 2 Dec 2017 15:26:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Subject: [PULL] First set of IIO fixes in the 4.15 cycle.
Message-ID: <20171202152648.69603847@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 0590cdfead8cd6319cc58b5dbe8ab9fbaabae131:

  staging: octeon-usb: use __delay() instead of cvmx_wait() (2017-11-28 14:36:46 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.15a

for you to fetch changes up to 6d745ee8b5e81f3a33791e3c854fbbfd6f3e585e:

  iio: stm32: fix adc/trigger link error (2017-12-02 11:21:31 +0000)

----------------------------------------------------------------
First set of IIO fixes in the 4.15 cycle.

* kernel-doc
  - fix a build error from symbols ending in _ by making them _*
* cpcap
  - Fix wrong handling of platform_get_irq_by_name which can return a
    postive value on success.
* max30102
  - ABI says temperature should bein milli Celsius after scaling. Here it
    was in Celsius.
* meson-saradc:
  - for Meson8/8b the gate clock bit was wrongly selected due to ffs/fls fun.
  - bandgap was not initialized properly on older socs.  Mostly got away
    with this because the bootloader was doing it for us.
  - Meson8/8b don't have some registers in the general regmap config. Give
    them their own ones.
* stm32-lptimer/stm32-adc trigger
  - Fix a link error when optional stm32-lptimer driver isn't built.
* sx9500
  - we recently removed explict handling of ACPI provided gpio interrupts
    as the core i2c acpi code started providing them directly.  Unfortuantely
    there are ACPI tables out there that use GpioIO resources and it doesn't
    know to map those as interrupts.  As such partial revert the removal
    of this handling from the driver.

----------------------------------------------------------------
Andy Shevchenko (1):
      iio: proximity: sx9500: Assign interrupt from GpioIo()

Arnd Bergmann (1):
      iio: stm32: fix adc/trigger link error

Martin Blumenstingl (3):
      iio: adc: meson-saradc: fix the bit_idx of the adc_en clock
      iio: adc: meson-saradc: initialize the bandgap correctly on older SoCs
      iio: adc: meson-saradc: Meson8 and Meson8b do not have REG11 and REG13

Pan Bian (1):
      iio: adc: cpcap: fix incorrect validation

Peter Meerwald-Stadler (1):
      iio: health: max30102: Temperature should be in milli Celsius

Randy Dunlap (1):
      iio: fix kernel-doc build errors

 drivers/iio/adc/cpcap-adc.c                   |  2 +-
 drivers/iio/adc/meson_saradc.c                | 52 +++++++++++++++++++++------
 drivers/iio/health/max30102.c                 |  2 +-
 drivers/iio/industrialio-core.c               |  4 +--
 drivers/iio/proximity/sx9500.c                |  9 +++++
 include/linux/iio/timer/stm32-lptim-trigger.h |  5 ++-
 6 files changed, 59 insertions(+), 15 deletions(-)
