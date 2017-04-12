Return-Path: <SRS0=7pg1=3U=rwth-aachen.de=Stefan.Bruens@kernel.org>
From: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
To: <linux-iio@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter
 Meerwald-Stadler <pmeerw@pmeerw.net>, =?UTF-8?q?Stefan=20Br=C3=BCns?=
	<stefan.bruens@rwth-aachen.de>
Subject: [PATCH 0/2] Enhancements for TI INA219/220 current/voltage monitors
Date: Wed, 12 Apr 2017 05:01:38 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Message-ID: <e91408f6b96d461b8d59b8dbd6849bf2@rwthex-w2-b.rwth-ad.de>
List-ID: <linux-iio@vger.kernel.org>

The ina2xx adc driver does not handle differences between INA219/220 and
INA226/230/231 completely:

- The 219 uses a 4 bit register field for for the bus/shunt voltage adc
  integration times each, whereas the 226 uses two 3 bit fields for the
  integration times and an additional 3 bit averaging field.

  The first patch correct setting integration times in the config register.

- The 219 also has an adjustable PGA. The default setting allows the
  maximum range, but also reduces accuracy.

  The second patch adds attributes for shunt PGA gain and bus voltage
  range (bus voltage PGA), and sets the config register accordingly.

Stefan Brüns (2):
  iio: adc: Fix integration time/averaging for INA219/220
  iio: adc: Allow setting Shunt Voltage PGA gain and Bus Voltage range

 drivers/iio/adc/ina2xx-adc.c | 344 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 322 insertions(+), 22 deletions(-)

-- 
2.12.0
