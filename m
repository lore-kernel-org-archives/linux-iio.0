Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:34633 "EHLO mail.aswsp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932773AbcHXO6C (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 24 Aug 2016 10:58:02 -0400
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Alexander Kurz <akurz@blala.de>, Tejun Heo <tj@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Daniel Baluta <daniel.baluta@intel.com>,
        "Ludovic Tancerel" <ludovic.tancerel@maplehightech.com>,
        Vlad Dogaru <vlad.dogaru@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Marek Vasut" <marex@denx.de>,
        Crestez Dan Leonard <leonard.crestez@intel.com>,
        Gregor Boirie <gregor.boirie@parrot.com>
Subject: [PATCH v1 0/3] iio: devm helpers and Murata zpa2326 barometer support
Date: Wed, 24 Aug 2016 16:58:45 +0200
Message-ID: <cover.1472050374.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Introduce support for the Murata ZPA2326 pressure and temperature sensor.
Also bring in resource managed versions for triggered buffer setup helpers and
trigger registration which the above mentioned driver depends on.

Driver features:
* I2C and SPI buses
* interrupt and polling based operations
* direct, triggered and software buffered IIO sampling modes
* hardware sampling frequency handling
* trigger consumers notification (plugged on interrupt) 
* runtime and system power states

2 questions with respect to current driver implementation for which I'd
like to hear your suggestions...

Hardware frequency handling is using the (legacy ?) IIO_DEV_ATTR_SAMP_FREQ and
IIO_CONST_ATTR_SAMP_FREQ_AVAIL macros.  As I remember Jonathan telling he was
trying to get rid of these, I wonder whether I should move to
iio_chan_spec_ext_info based code or not.

Sensor is able to sample in a continuous manner, triggering an interrupt each
time a new sample is ready to be fetched by CPU. This mode is implemented using
INDIO_BUFFER_SOFTWARE mode instead of INDIO_BUFFER_TRIGGERED (as can be seen in
the vast majority of IIO drivers). Can somebody confirm there is no misuse
here ?

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
 drivers/iio/pressure/Kconfig                       |   33 +
 drivers/iio/pressure/Makefile                      |    3 +
 drivers/iio/pressure/zpa2326.c                     | 1766 ++++++++++++++++++++
 drivers/iio/pressure/zpa2326.h                     |   76 +
 drivers/iio/pressure/zpa2326_i2c.c                 |  188 +++
 drivers/iio/pressure/zpa2326_spi.c                 |  184 ++
 include/linux/iio/iio.h                            |    1 +
 include/linux/iio/trigger.h                        |    6 +
 include/linux/iio/triggered_buffer.h               |    8 +
 14 files changed, 2395 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/zpa2326.txt
 create mode 100644 drivers/iio/pressure/zpa2326.c
 create mode 100644 drivers/iio/pressure/zpa2326.h
 create mode 100644 drivers/iio/pressure/zpa2326_i2c.c
 create mode 100644 drivers/iio/pressure/zpa2326_spi.c

-- 
2.1.4

