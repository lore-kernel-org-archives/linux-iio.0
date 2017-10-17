Return-Path: <SRS0=HRyn=BQ=wunner.de=lukas@kernel.org>
Message-Id: <cover.1508232186.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 17 Oct 2017 12:42:00 +0200
Subject: [PATCH v2 0/3] Texas Instruments 8/10/12-bit 2/4-channel DAC driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Mathias Duckeck <m.duckeck@kunbus.de>, Phil Elwell <phil@raspberrypi.org>, linux-iio@vger.kernel.org
List-ID: <linux-iio@vger.kernel.org>

Changes v1 -> v2:

Patch [1/3] was acked by Rob Herring.

Patch [2/3]:
- Enable vref regulator before initializing outputs to 0 in ti_dac_probe().
- Add channel datasheet names "A", "B", "C", "D".
- Use goto in ti_dac_set_powerdown_mode(). (Jonathan)
- Return -EBUSY instead of -ESHUTDOWN in ti_dac_write_raw(). (Jonathan)

Patch [3/3]:
- Look up chip properties in table indexed by the modalias instead of
  gleaning them from the modalias directly. (Jonathan)
  Separate patch for opinionatedness. ;-)


Link to v1:

https://www.spinics.net/lists/linux-iio/msg34885.html


Lukas Wunner (3):
  dt-bindings: iio: dac: ti-dac082s085: Document new driver
  iio: dac: Add Texas Instruments 8/10/12-bit 2/4-channel DAC driver
  iio: dac: ti-dac082s085: Read chip spec from device table

 Documentation/ABI/testing/sysfs-bus-iio            |   1 +
 .../devicetree/bindings/iio/dac/ti-dac082s085.txt  |  34 ++
 drivers/iio/dac/Kconfig                            |  10 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/ti-dac082s085.c                    | 368 +++++++++++++++++++++
 5 files changed, 414 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ti-dac082s085.txt
 create mode 100644 drivers/iio/dac/ti-dac082s085.c

-- 
2.11.0
