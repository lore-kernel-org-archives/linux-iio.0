Return-Path: <SRS0=/2Sp=B3=rwth-aachen.de=Stefan.Bruens@kernel.org>
From: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
To: <linux-iio@vger.kernel.org>
CC: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	=?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>,
	<linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>, "Lars-Peter
 Clausen" <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, "Hartmut
 Knaack" <knaack.h@gmx.de>, Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH v2 0/3] iio: adc: ina2xx: Fixes and extensions
Date: Sat, 28 Oct 2017 23:12:45 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Message-ID: <02c0ff0b-52c8-4a7a-ac48-7bf6c00f7942@rwthex-w2-a.rwth-ad.de>
List-ID: <linux-iio@vger.kernel.org>

The first patch fixes an issue with the conversion-ready status flag showing
up in the bus voltage raw value.

(removed original second patch from series, as already applied to togreg branch)

The second patch cleans up the specification of the LSB value for the shunt
voltage register. For code readability and uniformity, use the value from the
datasheet (e.g 10uV per LSB) instead of the reciprocal (100 LSBs per mV), as
done for the other registers.

The third patch adds support for the INA219/220 specific bus voltage range
and shunt voltage PGA.

Changes in v2:
- Apply to the shunt voltage, not bus voltage register
- Shift instead of masking the LSBs
- new patch
- Fix conversion for shunt gain, function expects milli, not micro

Stefan Brüns (3):
  iio: adc: ina2xx: Shift bus voltage register to mask flag bits
  iio: adc: ina2xx: Use LSB specifier instead of divider in config
  iio: adc: ina2xx: Allow setting Shunt Voltage PGA gain and Bus Voltage
    range

 drivers/iio/adc/ina2xx-adc.c | 149 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 131 insertions(+), 18 deletions(-)

-- 
2.14.3
