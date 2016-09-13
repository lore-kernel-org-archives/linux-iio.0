Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:32049 "EHLO mail.aswsp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752315AbcIMMTP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 13 Sep 2016 08:19:15 -0400
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: <devicetree@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vlad Dogaru <ddvlad@gmail.com>,
        Ludovic Tancerel <ludovic.tancerel@maplehightech.com>,
        Marek Vasut <marex@denx.de>,
        Crestez Dan Leonard <leonard.crestez@intel.com>,
        Gregor Boirie <gregor.boirie@parrot.com>
Subject: [PATCH v5 0/1] iio: devm helpers and Murata zpa2326 barometer support
Date: Tue, 13 Sep 2016 14:23:13 +0200
Message-ID: <cover.1473769166.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Introduce support for the Murata ZPA2326 pressure and temperature sensor.
Also bring in resource managed versions for triggered buffer setup helpers and
trigger registration which the above mentioned driver depends on.

Driver features :
* I2C and SPI buses
* interrupt and polling based operations
* direct, external and internal triggered buffering IIO modes
* hardware sampling frequency handling
* trigger consumers notification (plugged on interrupt) 
* runtime and system power states

Changes since v4 :
* cross reference the DT docs from zpa2326 DT bindings doc
* standardize Kconfig according to BMC150 model
* get rid of debugfs based register access (regmap already supports this)
* avoid mixing devm_ and unmanaged function calls in zpa2326_probe()
* remove useless header

Changes since v3 :
* drop first 2 patches since applied onto testing branch
* spelling / syntax corrections
* disable build of verbose message by default.
* get rid of useless zpa_iio2slave() and zpa_iio2priv() macros
* rename "slave" variables to "parent"
* add missing blank lines
* remove useless registers read/write wrappers
* rename zpa_disable_device() to zpa_sleep()
* reword comments to specify interrupt line <= 0 are invalid
* replace zpa2326_claim_direct_mode()/zpa2326_release_direct_mode() by
  equivalent inline statements
* always return IRQ_HANDLED in trigger handlers
* remove useless lock from zpa2326_get_frequency()
* probing reworked
* rename resource managed related init functions
* don't init variables with non trivial function calls
* replace exotic INDIO_BUFFER_SOFTWARE handling with traditional trigger driven
  acquisition

Changes since v2 :
* add missing vref-supply property into DT bindings doc
* kerneldoc'ify comments
* rename return code variables
* compute channel scaling and offset using IIO_VAL_FRACTIONAL for enhanced
  readability
* replace legacy IIO_DEV_ATTR_SAMP_FREQ macro by channel info_mask_shared_by_all
  mechanism 

Changes since v1 :
* cosmetic and spelling corrections
* remove useless header
* remove useless u8 cast from register macro definitions
* fix uninitialized pressure word for continuous sampling operation
* rework of zpa_dequeue_pressure error handling flow for enhanced readability
* merge zpa_acknowledge_irq() into zpa_handle_threaded_irq() for enhanced
  readability
* remove useless pm_runtime_mark_last_busy() invocation
* remove useless channel initializers
* add VRef regulator support
* switch to regmap based bus operations (save ~100 lines of code)
* make symbol prefixes consistent with source file name (zpa_ -> zpa2326_)
* get rid of BUG() usage
* protect sampling frequency reads from userspace with mutex
* remove DEBUG macro (rely on dynamic debug or a futur DEBUG Kconfig option
  defined at IIO level)
* rename ZPA2326_CONVERSION_TIMEOUT macros to ZPA2326_CONVERSION_JIFFIES
* simplify runtime power management error handling
* rework ring setup operations for better separation of concerns
* fix module removal / devm_iio_device_register() race condition
* factor out hardware detection sequence

Regards,
gregor.

Gregor Boirie (1):
  iio:pressure: initial zpa2326 barometer support

 .../devicetree/bindings/iio/pressure/zpa2326.txt   |   31 +
 drivers/iio/pressure/Kconfig                       |   22 +
 drivers/iio/pressure/Makefile                      |    3 +
 drivers/iio/pressure/zpa2326.c                     | 1735 ++++++++++++++++++++
 drivers/iio/pressure/zpa2326.h                     |   89 +
 drivers/iio/pressure/zpa2326_i2c.c                 |   99 ++
 drivers/iio/pressure/zpa2326_spi.c                 |  103 ++
 7 files changed, 2082 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/zpa2326.txt
 create mode 100644 drivers/iio/pressure/zpa2326.c
 create mode 100644 drivers/iio/pressure/zpa2326.h
 create mode 100644 drivers/iio/pressure/zpa2326_i2c.c
 create mode 100644 drivers/iio/pressure/zpa2326_spi.c

-- 
2.1.4

