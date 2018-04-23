Return-Path: <SRS0=My0Y=HM=axentia.se=peda@kernel.org>
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Andrew F . Davis" <afd@ti.com>,
	Fabio Estevam <festevam@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v4 0/4] iio: add unit-converter
Date: Mon, 23 Apr 2018 23:08:05 +0200
Message-Id: <20180423210809.29586-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Hi!

This driver implements support for voltage dividers, current sense
shunts and current sense amplifiers. It's pretty generic and should
be easily adaptable to other linear scaling purposes.

Cheers,
Peter

Changes since v3:    https://lkml.org/lkml/2018/4/10/614
- Split the bindings patch for voltage-divider and current-sense-shunt
  in two, thus retaining the tag from Rob on the latter, when the
  former got a major update. The voltage-divider binding is now
  clear of its history from the generic io-channel-unit-converter
  binding roots (v1 of the series) and makes much more sense on its
  own (IMHO).
- Incorporate the confusing followup patches that added current sense
  amplification to the series.
- Drop the adi,lt6106 binding from that followup and replace it with
  a generic current-sense-amplifier binding.
- Adjust the driver to the above, and also rename it to iio-rescale
  as unit-converter was perhaps a little bit too generic even for the
  driver name.

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

Peter Rosin (4):
  dt-bindings: iio: afe: add binding for current-sense-shunt
  dt-bindings: iio: afe: add binding for voltage-divider
  dt-bindings: iio: afe: add binding for current-sense-amplifier
  iio: afe: rescale: new driver

 .../bindings/iio/afe/current-sense-amplifier.txt   |  26 ++
 .../bindings/iio/afe/current-sense-shunt.txt       |  41 +++
 .../bindings/iio/afe/voltage-divider.txt           |  53 +++
 MAINTAINERS                                        |   9 +
 drivers/iio/Kconfig                                |   1 +
 drivers/iio/Makefile                               |   1 +
 drivers/iio/afe/Kconfig                            |  19 ++
 drivers/iio/afe/Makefile                           |   6 +
 drivers/iio/afe/iio-rescale.c                      | 359 +++++++++++++++++++++
 9 files changed, 515 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/afe/current-sense-amplifier.txt
 create mode 100644 Documentation/devicetree/bindings/iio/afe/current-sense-shunt.txt
 create mode 100644 Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
 create mode 100644 drivers/iio/afe/Kconfig
 create mode 100644 drivers/iio/afe/Makefile
 create mode 100644 drivers/iio/afe/iio-rescale.c

-- 
2.11.0
