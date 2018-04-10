Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr50101.outbound.protection.outlook.com ([40.107.5.101]:21828
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753628AbeDJP2Y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 10 Apr 2018 11:28:24 -0400
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
        "Andrew F . Davis" <afd@ti.com>,
        Fabio Estevam <festevam@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 0/2] iio: add unit converter
Date: Tue, 10 Apr 2018 17:28:00 +0200
Message-Id: <20180410152802.30958-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi!

This driver implements support for voltage dividers and current
sense shunts. It's pretty generic and should be easily adaptable
to other linear scaling purposes.

Cheers,
Peter

Changes since v2:    https://lkml.org/lkml/2018/4/3/461
- Rename from current-sence-circuit to current-sense-shunt (this
  should also fix all the typing problems I had with curciut).
- Describe the shunt resistance directly (instead of indirectly
  in the form of a quotient).
- Add a ->props() op to struct unit_converter_cfg to enable simple
  separation of properties for different converters.
- Shuffle the code around to minimize forward declarations.
- Drop the unused indio member from struct unit_converter.
- Drop error report on iio driver registration failure.

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
  dt-bindings: iio: afe: add current-sense-shunt and voltage-divider
  iio: afe: unit-converter: new driver

 .../bindings/iio/afe/current-sense-shunt.txt       |  41 +++
 .../bindings/iio/afe/voltage-divider.txt           |  45 ++++
 MAINTAINERS                                        |   8 +
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/afe/Kconfig                            |  18 ++
 drivers/iio/afe/Makefile                           |   6 +
 drivers/iio/afe/iio-unit-converter.c               | 291 +++++++++++++++++++++
 8 files changed, 411 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
 create mode 100644 Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
 create mode 100644 drivers/iio/afe/Kconfig
 create mode 100644 drivers/iio/afe/Makefile
 create mode 100644 drivers/iio/afe/iio-unit-converter.c

-- 
2.11.0

