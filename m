Return-Path: <SRS0=+lUA=ZY=metafoo.de=lars@kernel.org>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	William Breathitt Gray <vilhelm.gray@gmail.com>,
	Matt Ranostay <matt.ranostay@konsulko.com>,
	linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 0/8] iio: Fix missing parent device initalization
Date: Sat, 11 Feb 2017 13:34:13 +0100
Message-Id: <1486816461-28618-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Add parent device initialization to drivers that are currently missing it.
Setting the parent device makes sure that the IIO device shows up at the
right level in the device hierachy.

The following coccinelle semantic patch was used to find the offending
drivers:
// <smpl>
@r1@
identifier indio_dev;
position p;
@@
indio_dev->dev.parent = ...;
...
(
iio_device_register@p(indio_dev)
|
devm_iio_device_register@p(..., indio_dev)
)

@@
position p != r1.p;
identifier indio_dev;
@@
(
*iio_device_register@p(indio_dev)
|
*devm_iio_device_register@p(..., indio_dev)
)
// </smpl>

- Lars

Lars-Peter Clausen (8):
  iio: stx104: Set parent device
  iio: quad-8: Set parent device
  iio: cio-dac: Set parent device
  iio: max30100: Set parent device
  iio: max30102: Set parent device
  iio: lmp91000: Set parent device
  iio: pulsedlight-lidar-lite-v2: Set parent device
  iio: maxim_thermocouple: Set parent device

 drivers/iio/adc/stx104.c                          | 1 +
 drivers/iio/counter/104-quad-8.c                  | 1 +
 drivers/iio/dac/cio-dac.c                         | 1 +
 drivers/iio/health/max30100.c                     | 1 +
 drivers/iio/health/max30102.c                     | 1 +
 drivers/iio/potentiostat/lmp91000.c               | 1 +
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 1 +
 drivers/iio/temperature/maxim_thermocouple.c      | 1 +
 8 files changed, 8 insertions(+)

-- 
2.1.4
