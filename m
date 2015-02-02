Return-Path: <hofrat@osadl.org>
From: Nicholas Mc Guire <hofrat@osadl.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH 3/3] iio: ad_sigma_delta: cleanup wait_for_completion return handling
Date: Mon,  2 Feb 2015 03:37:38 -0500
Message-Id: <1422866258-10517-1-git-send-email-hofrat@osadl.org>
List-ID: <linux-iio@vger.kernel.org>

return type of wait_for_completion_timeout is unsigned long not int, rather
than introducing a new variable the wait_for_completion_timeout is moved
into the if condition as the return value is only used to detect timeout.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Aside from the fixup of the wait_for_completion_timeout handling
a minor coding style issue in the else branch was fixed - the {} is
not needed for the one-line body.

Patch was compile tested only for imx_v6_v7_defconfig + CONFIG_IIO=m
CONFIG_STAGING=y, CONFIG_AD7780=m, CONFIG_AD_SIGMA_DELTA=m

Patch is against 3.19.0-rc6 -next-20150130

 drivers/iio/adc/ad_sigma_delta.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index d10bd0c..fbc5824 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -196,14 +196,12 @@ static int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
 
 	sigma_delta->irq_dis = false;
 	enable_irq(sigma_delta->spi->irq);
-	ret = wait_for_completion_timeout(&sigma_delta->completion, 2*HZ);
-	if (ret == 0) {
+	if (!wait_for_completion_timeout(&sigma_delta->completion, 2*HZ)) {
 		sigma_delta->irq_dis = true;
 		disable_irq_nosync(sigma_delta->spi->irq);
 		ret = -EIO;
-	} else {
+	} else
 		ret = 0;
-	}
 out:
 	sigma_delta->bus_locked = false;
 	spi_bus_unlock(sigma_delta->spi->master);
-- 
1.7.10.4
