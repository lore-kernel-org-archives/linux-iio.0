Return-Path: <SRS0=D05P=6T=rwth-aachen.de=Stefan.Bruens@kernel.org>
From: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
To: <linux-iio@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter
 Meerwald-Stadler <pmeerw@pmeerw.net>, =?UTF-8?q?Stefan=20Br=C3=BCns?=
	<stefan.bruens@rwth-aachen.de>
Subject: [PATCH 0/2] iio: Documentation enhancements
Date: Mon, 17 Jul 2017 01:34:08 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Message-ID: <3164b0ebc2d743daa852526fae3ac15f@rwthex-w2-b.rwth-ad.de>
List-ID: <linux-iio@vger.kernel.org>

Add some documentation missing for the INA2xx power sensor. The power
attribute is generic and matches the implementation of the MAX9611 and
the INA2xx IIO drivers (the only drivers with IIO_POWER type channels).

The INA2xx shunt resistor value is specified in microohms, contrary
to the common use of ohms for resistance in IIO, thus is added as
ina2xx specific documentation.

Stefan Brüns (2):
  iio: Documentation: Add missing documentation for power attribute
  iio: Documentation: Add ina2xx shunt_resistor attribute documentation

 Documentation/ABI/testing/sysfs-bus-iio                | 9 +++++++++
 Documentation/ABI/testing/sysfs-bus-iio-adc-ina2xx-adc | 7 +++++++
 2 files changed, 16 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ina2xx-adc

-- 
2.13.2
