Return-Path: <SRS0=qmvf=46=rwth-aachen.de=Stefan.Bruens@kernel.org>
From: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-kernel@vger.kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter
 Meerwald-Stadler <pmeerw@pmeerw.net>, Marc Titinger <mtitinger@baylibre.com>,
	=?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
Subject: [PATCH v2 0/3] Enhancements for TI INA219/220 current/voltage monitors
Date: Wed, 24 May 2017 02:09:04 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Message-ID: <47ac5c3d0af8448891af465c2175c138@rwthex-w2-b.rwth-ad.de>
List-ID: <linux-iio@vger.kernel.org>

The ina2xx adc driver does not handle differences between INA219/220 and
INA226/230/231 completely:

- The 219 uses a 4 bit register field for for the bus/shunt voltage adc
  integration times each, whereas the 226 uses two 3 bit fields for the
  integration times and an additional 3 bit averaging field.

  The second patch corrects setting integration times in the config register.

- The conversion ready flag differs between the two families.

  Handling for this flag is corrected in the third patch. Without the patch,
  the kernel will go in a busy loop (setting read register 6 is ACKed by the
  INA219, and the following read returns 0).

- The 219 also has an adjustable PGA. The default setting allows the
  maximum range, but also reduces accuracy.

  (Postponed, needs more thought)

Changes v2:
  - split attribute flags change from [Patch 1] iio: adc: Fix integration time/
    averaging from INA219/220
  - changed Patch v1 1/2 (now 2/3, feedback by Jonathan Cameron):
    * Use correct flags for all channels/chips
    * Improve readability of chip/channel handling in if statement
  - dropped Patch v1 2/2 for now
  - added Patch v2 3/3

Stefan Brüns (3):
  iio: adc: ina2xx: Make use of attribute flags consistent on all
    channels
  iio: adc: Fix integration time/averaging for INA219/220
  iio: adc: Fix polling of INA219 conversion ready flag

 drivers/iio/adc/ina2xx-adc.c | 242 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 213 insertions(+), 29 deletions(-)

-- 
2.12.2
