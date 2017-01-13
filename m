Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:35000 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751456AbdAMJvC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Jan 2017 04:51:02 -0500
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: wsa+renesas@sang-engineering.com, magnus.damm@gmail.com,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, marek.vasut@gmail.com, geert@linux-m68k.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v4 0/2] iio: adc: Add Maxim MAX11100 driver
Date: Fri, 13 Jan 2017 10:50:36 +0100
Message-Id: <1484301038-16386-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,
   sending out v4 splitting device tree bindings documentation and actual ADC
driver.
No changes in driver code since v3.

Same question for iio maintainers here:
I would like to have clarified the measure unit returned by read_raw().
Currently (value_raw * value_scale) return the ADC input value in mV.
While testing the patch I've been questioned if that should not actually
be in uV. This is easily achievable making _scale return a value in uV.
I have found no mention of this in the ABI documentation as it speaks of
generic voltage.
Can we have a final word on this?

Thanks Marek for having tested this.

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

Jacopo Mondi (2):
  iio: adc: Add Maxim MAX11100 driver
  dt-bindings: iio: document MAX11100 ADC

 .../devicetree/bindings/iio/adc/max11100.txt       |  19 +++
 drivers/iio/adc/Kconfig                            |   9 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/max11100.c                         | 187 +++++++++++++++++++++
 4 files changed, 216 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/max11100.txt
 create mode 100644 drivers/iio/adc/max11100.c

-- 
2.7.4

