Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-he1eur01on0094.outbound.protection.outlook.com ([104.47.0.94]:59520
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751195AbeDCPgs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 3 Apr 2018 11:36:48 -0400
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Phil Reid <preid@electromag.com.au>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 0/2] iio: add unit converter
Date: Tue,  3 Apr 2018 17:36:33 +0200
Message-Id: <20180403153635.8228-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi!

This driver implements support for voltage dividers and current
sense circuits. It's pretty generic and should be easily adaptable
to other linear scaling purposes...

The driver is still named "unit converter", because it was not
clear to me that there was a real problem with the driver being
named that. I got the impression that the naming discussion in
v1 was mainly about the category, and that it kind of looked odd
and non-specific with unit-converter in the DT bindings, but
what do I know?

Cheers,
Peter

Changes since v1:    https://lkml.org/lkml/2018/3/19/801
- Put the driver in the new afe category (Analog Front Ends) and do not
  move the iio-mux driver.
- Do not refer to the source channel as "parent", use "source" instead.
- Have the DT compatible drive the target unit, instead of relying on a
  "type" DT-property for that.
- In the DT bindings, use an unnamed source channel.
- Do not set up writes to _RAW (sorry Phil) as I don't need it and have
  not tested it. It's easy to add back if needed.
- Fail if the source channel does not support _RAW or _SCALE.
- Fix various spelling issues.
- Fix various code style issues.

Peter Rosin (2):
  dt-bindings: iio: afe: add current-sense-cuicuit and voltage-divider
  iio: afe: unit-converter: new driver

 .../bindings/iio/afe/current-sense-circuit.txt     |  45 ++++
 .../bindings/iio/afe/voltage-divider.txt           |  45 ++++
 MAINTAINERS                                        |   8 +
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/afe/Kconfig                            |  18 ++
 drivers/iio/afe/Makefile                           |   6 +
 drivers/iio/afe/iio-unit-converter.c               | 257 +++++++++++++++++++++
 8 files changed, 381 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/current-sense-circuit.txt
 create mode 100644 Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
 create mode 100644 drivers/iio/afe/Kconfig
 create mode 100644 drivers/iio/afe/Makefile
 create mode 100644 drivers/iio/afe/iio-unit-converter.c

-- 
2.11.0

