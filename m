Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:37714 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752529AbdARQeo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Jan 2017 11:34:44 -0500
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: wsa+renesas@sang-engineering.com, magnus.damm@gmail.com,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, marek.vasut@gmail.com, geert@linux-m68k.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v5 0/2] iio: adc: Add Maxim MAX11100 driver
Date: Wed, 18 Jan 2017 17:30:51 +0100
Message-Id: <1484757053-7102-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello everyone,
  hopefully we have reached last iteration on this simple driver.

After having clarified the read_raw() measure unit question, I'm now sending
out v5 addressing Jonathan's comment on having spi destination aligned to
their own cache lines to support DMA-capable SPI controllers.

Also, I added indio_dev->name attribute, as suggested by Lars-Peter even if
the same value can be retrieved from of_node/name.


v1 -> v2:
    - incorporated pmeerw's review comments
    - retrieve vref from dts and use that to convert read_raw result
      to mV
    - add device tree bindings documentation

v2 -> v3:
    - add _SCALE bit of read_raw function and change _RAW bit accordingly
    - call regulator_get_voltage when accessing the _SCALE part of read_raw
      and not during probe
    - add back remove function as regulator has to be disabled when detaching
      the module. Do not use devm_ version of iio_register/unregister functions
      anymore but do unregister in the remove.
    - remove mutex as access to SPI bus is protected by SPI core. Thanks marex

v3 -> v4:
    - split device tree binding documentation and actual ADC driver
    - add "reg" to the list of required properties and use a better
      namimg for the adc device node in bindings documentation as suggested
      by Geert.

v4 -> v5:
    - make spi_read() destination buffer cacheline aligned
    - add indio_dev->name attribute.

Jacopo Mondi (2):
  iio: adc: Add Maxim MAX11100 driver
  dt-bindings: iio: document MAX11100 ADC

 .../devicetree/bindings/iio/adc/max11100.txt       |  19 ++
 drivers/iio/adc/Kconfig                            |   9 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/max11100.c                         | 192 +++++++++++++++++++++
 4 files changed, 221 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/max11100.txt
 create mode 100644 drivers/iio/adc/max11100.c

-- 
2.7.4

