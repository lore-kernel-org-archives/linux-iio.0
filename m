Return-Path: <gregor.boirie@parrot.com>
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>, Irina Tirdea
	<irina.tirdea@intel.com>, Cristina Moraru <cristina.moraru09@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>, Julia Lawall <Julia.Lawall@lip6.fr>,
	Gregor Boirie <gregor.boirie@parrot.com>
Subject: [PATCH v2 0/5] iio:magnetometer:ak8975: fix and enhancements
Date: Thu, 3 Mar 2016 11:44:02 +0100
Message-ID: <cover.1457001111.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

Various fixes and enhancements for the ak8975 magnetometers family driver.

Changes since v1:
* get rid of silly le16 to cpu conversion since SMBUS handles this for us when
  reading words (patch 3/6)
* get rid of axes caching and serialize bus access between trigger handler and
  read_raw
* pack triggered buffer sampling bus accesses into a single SMBUS data block
  access
* use channel address within read_raw

Gregor.

Gregor Boirie (5):
  iio:magnetometer:ak8975: fix uninitialized chipset
  iio:magnetometer:ak8975: remove unused field
  iio:magnetometer:ak8975: power regulator support
  iio:magnetometer:ak8975: mounting matrix support
  iio:magnetometer:ak8975: triggered buffer support

 .../bindings/iio/magnetometer/ak8975.txt           |  12 ++
 drivers/iio/magnetometer/Kconfig                   |   2 +
 drivers/iio/magnetometer/ak8975.c                  | 218 ++++++++++++++++++---
 3 files changed, 202 insertions(+), 30 deletions(-)

-- 
2.1.4
