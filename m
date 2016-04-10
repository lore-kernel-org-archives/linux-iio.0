Return-Path: <amsfield22@gmail.com>
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	kgene@kernel.org,
	k.kozlowski@samsung.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 0/5] iio: use regmap to retrieve struct device
Date: Sun, 10 Apr 2016 12:03:50 -0700
Message-Id: <cover.1460314070.git.amsfield22@gmail.com>
In-Reply-To: <cover.1459918214.git.amsfield22@gmail.com>
References: <cover.1459918214.git.amsfield22@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

These drivers include both struct regmap and struct device in their
global data.  Remove the redundant copy by deleting struct device 
from the drivers global data and using regmap API to retrieve when
needed.

This patchset removes all such redundancies in drivers/iio/.

Patches created using Coccinelle plus hand edits for whitespace.

Changes v1->v2:
	This set is updated following reviews teaching me that not
	all regmaps in global data will be of that device.  Discards
	and keepers are noted below.  No actual code changes just a
	remake of the patchset.

	Jonathan - I saw you want to let it simmer, just want to
	let it simmer cleaner ;)

  accel: mma7455
	Removing: Joachim ack'd, Jonathan took v1 

  adc: exynos_adc
	Discard: regmap is of PMU parent

  adc: qcom-spmi-iadc
  adc: qcom-spmi-vadc
	Discard: first line of _probe gets regmap from parent

  accel: bmc150
  gyro: bmg160
	Keep: regmap passed into _probe from i2c,spi_probe where
	it was initialized for this device

  accel: mxc4005
  health: afe4403
  health: afe4404
	Keep: regmap initialized in _probe for this device


Alison Schofield (5):
  iio: accel: bmc150: use regmap to retrieve struct device
  iio: accel: mxc4005: use regmap to retrieve struct device
  iio: health: afe4403: use regmap to retrieve struct device
  iio: health: afe4404: use regmap to retrieve struct device
  iio: gyro: bmg160: use regmap to retrieve struct device

 drivers/iio/accel/bmc150-accel-core.c | 99 +++++++++++++++++++----------------
 drivers/iio/accel/mxc4005.c           | 26 +++++----
 drivers/iio/gyro/bmg160_core.c        | 86 +++++++++++++++---------------
 drivers/iio/health/afe4403.c          | 36 ++++++-------
 drivers/iio/health/afe4404.c          | 38 +++++++-------
 5 files changed, 149 insertions(+), 136 deletions(-)

-- 
2.1.4
