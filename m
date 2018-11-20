Return-Path: <SRS0=3PWr=N7=gmail.com=shreeya.patel23498@kernel.org>
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Remove platform data and introduce DT bindings
Date: Tue, 20 Nov 2018 22:17:18 +0530
Message-Id: <20181120164718.6999-1-shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

This patchset introduces device tree bindings for adt7316
driver and removes the usage of platform data from it.
Also, it sets the data field to it's appropriate value in
the i2c read function which was nowhere being set before.

Changes in v2:
  - Make the commit message of patch *[1/5] appropriate.

Shreeya Patel (5):
  Staging: iio: adt7316: Add of_device_id table
  Staging: iio: adt7316: Use device tree data to set ldac_pin
  Staging: iio: adt7316: Switch irq_flags to a local variable
  Staging: iio: adt7316: Change the name from irq_flags to irq_type
  Staging: iio: adt7316: Use device tree data to assign irq_type

 drivers/staging/iio/addac/adt7316-i2c.c | 14 ++++++++-
 drivers/staging/iio/addac/adt7316-spi.c |  1 -
 drivers/staging/iio/addac/adt7316.c     | 39 ++++++++++++++++++-------
 drivers/staging/iio/addac/adt7316.h     |  1 -
 4 files changed, 42 insertions(+), 13 deletions(-)

-- 
2.17.1
