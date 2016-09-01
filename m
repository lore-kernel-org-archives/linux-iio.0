Return-Path: <gregor.boirie@parrot.com>
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>, Laxman Dewangan
	<ldewangan@nvidia.com>, Alexander Kurz <akurz@blala.de>, Tejun Heo
	<tj@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Akinobu Mita
	<akinobu.mita@gmail.com>, Daniel Baluta <daniel.baluta@intel.com>, Ludovic
 Tancerel <ludovic.tancerel@maplehightech.com>, Vlad Dogaru
	<vlad.dogaru@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Marek
 Vasut <marex@denx.de>, Crestez Dan Leonard <leonard.crestez@intel.com>, Neil
 Armstrong <narmstrong@baylibre.com>, Masahiro Yamada
	<yamada.masahiro@socionext.com>, Arnd Bergmann <arnd@arndb.de>, Gregor Boirie
	<gregor.boirie@parrot.com>
Subject: [PATCH v2 0/3] iio: devm helpers and Murata zpa2326 barometer support
Date: Thu, 1 Sep 2016 18:25:00 +0200
Message-ID: <cover.1472746681.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Introduce support for the Murata ZPA2326 pressure and temperature sensor.
Also bring in resource managed versions for triggered buffer setup helpers and
trigger registration which the above mentioned driver depends on.

Driver features :
* I2C and SPI buses
* interrupt and polling based operations
* direct, triggered and software buffered IIO sampling modes
* hardware sampling frequency handling
* trigger consumers notification (plugged on interrupt) 
* runtime and system power states

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

Gregor Boirie (3):
  iio:trigger: add resource managed (un)register
  iio: add resource managed triggered buffer init helpers
  iio:pressure: initial zpa2326 barometer support

 .../devicetree/bindings/iio/pressure/zpa2326.txt   |   23 +
 Documentation/driver-model/devres.txt              |    4 +
 drivers/iio/buffer/industrialio-triggered-buffer.c |   42 +
 drivers/iio/industrialio-core.c                    |    3 +-
 drivers/iio/industrialio-trigger.c                 |   59 +
 drivers/iio/pressure/Kconfig                       |   35 +
 drivers/iio/pressure/Makefile                      |    3 +
 drivers/iio/pressure/zpa2326.c                     | 1736 ++++++++++++++++++++
 drivers/iio/pressure/zpa2326.h                     |   93 ++
 drivers/iio/pressure/zpa2326_i2c.c                 |   97 ++
 drivers/iio/pressure/zpa2326_spi.c                 |  101 ++
 include/linux/iio/iio.h                            |    1 +
 include/linux/iio/trigger.h                        |    6 +
 include/linux/iio/triggered_buffer.h               |    8 +
 14 files changed, 2210 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/zpa2326.txt
 create mode 100644 drivers/iio/pressure/zpa2326.c
 create mode 100644 drivers/iio/pressure/zpa2326.h
 create mode 100644 drivers/iio/pressure/zpa2326_i2c.c
 create mode 100644 drivers/iio/pressure/zpa2326_spi.c

-- 
2.1.4
