Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34191 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753116AbcDFFPS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 6 Apr 2016 01:15:18 -0400
Date: Tue, 5 Apr 2016 22:15:15 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	kgene@kernel.org, k.kozlowski@samsung.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH 0/9] iio: use regmap to retrieve struct device
Message-ID: <cover.1459918214.git.amsfield22@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

These drivers include both struct regmap and struct device in their
global data.  Remove the redundant copy by deleting struct device 
from the drivers global data and using regmap API to retrieve when
needed.

This patchset removes all such redundancies in drivers/iio/.

Patches created using Coccinelle plus hand edits for whitespace and
one local var naming collision.

Alison Schofield (9):
  iio: adc: exynos_adc: use regmap to retrieve struct device
  iio: adc: qcom-spmi-iadc: use regmap to retrieve struct device
  iio: adc: qcom-spmi-vadc: use regmap to retrieve struct device
  iio: accel: bmc150: use regmap to retrieve struct device
  iio: accel: mma7455: use regmap to retrieve struct device
  iio: accel: mxc4005: use regmap to retrieve struct device
  iio: health: afe4403: use regmap to retrieve struct device
  iio: health: afe4404: use regmap to retrieve struct device
  iio: gyro: bmg160_core: use regmap to retrieve struct device

 drivers/iio/accel/bmc150-accel-core.c | 99 +++++++++++++++++++----------------
 drivers/iio/accel/mma7455_core.c      |  5 +-
 drivers/iio/accel/mxc4005.c           | 26 +++++----
 drivers/iio/adc/exynos_adc.c          | 18 +++----
 drivers/iio/adc/qcom-spmi-iadc.c      | 32 +++++------
 drivers/iio/adc/qcom-spmi-vadc.c      | 37 +++++++------
 drivers/iio/gyro/bmg160_core.c        | 86 +++++++++++++++---------------
 drivers/iio/health/afe4403.c          | 36 ++++++-------
 drivers/iio/health/afe4404.c          | 38 +++++++-------
 9 files changed, 197 insertions(+), 180 deletions(-)

-- 
2.1.4

