Return-Path: <SRS0=3+N4=CT=elementarea.net=a.brauchli@kernel.org>
Message-ID: <1511280680.12439.34.camel@elementarea.net>
Subject: [PATCH 0/2] iio: chemical: sgpxx: Support SGP30 / SGPC3 Gas Sensors
From: Andreas Brauchli <a.brauchli@elementarea.net>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen
	 <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 21 Nov 2017 17:11:20 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

This patch series adds support for Sensirion SGP30 and SGPC3 I2C gas
sensors.

Patch 1/2 adds full driver support and sensor documentation
Patch 2/2 adds triggered buffer support

Note that the current version of libiio (0.11) has some parsing issues
with the use of struct iio_chan_spec's extend_name. Patches will be
issued separately, but reviewers are kindly asked to ensure that this
patch follows best IIO attribute naming practises.

Further product specs available from:
https://www.sensirion.com/en/environmental-sensors/gas-sensors/multi-pixel-gas-sensors/

Andreas Brauchli (2):
  iio: chemical: sgpxx: Support Sensirion SGPxx sensors
  iio: chemical: sgpxx: triggered buffer support

 Documentation/iio/chemical/sgpxx.txt | 112 +++++
 drivers/iio/chemical/Kconfig         |  16 +
 drivers/iio/chemical/Makefile        |   1 +
 drivers/iio/chemical/sgpxx.c         | 932 +++++++++++++++++++++++++++++++++++
 4 files changed, 1061 insertions(+)
 create mode 100644 Documentation/iio/chemical/sgpxx.txt
 create mode 100644 drivers/iio/chemical/sgpxx.c

-- 
2.14.1
