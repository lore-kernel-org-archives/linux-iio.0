Return-Path: <beomho.seo@samsung.com>
From: Beomho Seo <beomho.seo@samsung.com>
To: linux-iio@vger.kernel.org, jic23@kernel.org, j.anaszewski@samsung.com,
 sachin.kamat@linaro.org, ch.naveen@samsung.com, ktsai@capellamicro.com,
 srinivas.pandruvada@linux.intel.com, t.figa@samsung.com
Cc: myungjoo.ham@samsung.com, jh80.chung@samsung.com, cw00.choi@samsung.com,
 Beomho Seo <beomho.seo@samsung.com>
Subject: [PATCH 0/5] iio: Using devm_* APIs in some sensor drivers
Date: Wed, 18 Jun 2014 15:21:38 +0900
Message-id: <1403072503-29246-1-git-send-email-beomho.seo@samsung.com>
List-ID: <linux-iio@vger.kernel.org>

This patch use devm_* APIs for some sensor drivers.
Using them make sensor driver simpler.

Beomho Seo (5):
  iio: adc: exynos_adc: Use devm_* APIs
  iio: light: cm32181: Use devm_* APIs
  iio: light: cm36651: Use devm_* APIs
  iio: light: gp2ap020a00f: Use devm_* APIs
  iio: magnetometer: ak8975: Use devm_* APIs

 drivers/iio/adc/exynos_adc.c      |   11 +++------
 drivers/iio/light/cm32181.c       |   11 +--------
 drivers/iio/light/cm36651.c       |   11 ++++-----
 drivers/iio/light/gp2ap020a00f.c  |   10 +++-----
 drivers/iio/magnetometer/ak8975.c |   48 ++++++++-----------------------------
 5 files changed, 21 insertions(+), 70 deletions(-)

-- 
1.7.9.5
