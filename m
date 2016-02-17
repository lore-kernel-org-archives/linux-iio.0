Return-Path: <gregor.boirie@parrot.com>
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	Tomasz Duszynski <tduszyns@gmail.com>, Daniel Baluta
	<daniel.baluta@intel.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Mark Brown <broonie@kernel.org>, "Andrew F. Davis" <afd@ti.com>, Gregor
 Boirie <gregor.boirie@parrot.com>
Subject: [PATCH v2 0/6] iio:pressure:ms5611: fix and enhancements
Date: Wed, 17 Feb 2016 18:38:38 +0100
Message-ID: <cover.1455729921.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

Changes since v1:
* temperature compensation fix:
    * reword commit message
    * remove useless parenthesis
* power regulator: reword commit message
* add oversampling rate support

Gregor Boirie (3):
  iio:pressure:ms5611: fix ms5607 temp compensation
  iio:pressure:ms5611: oversampling rate support
  iio:pressure:ms5611: continuous sampling support

Grégor Boirie (3):
  iio:pressure:ms5611: use probed device name
  iio:pressure:ms5611: power regulator support
  iio:pressure:ms5611: DT bindings documentation

 .../devicetree/bindings/iio/pressure/ms5611.txt    |  19 ++
 drivers/iio/pressure/ms5611.h                      |  31 ++-
 drivers/iio/pressure/ms5611_core.c                 | 252 ++++++++++++++++++---
 drivers/iio/pressure/ms5611_i2c.c                  |  14 +-
 drivers/iio/pressure/ms5611_spi.c                  |  23 +-
 5 files changed, 284 insertions(+), 55 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/ms5611.txt

-- 
2.1.4
