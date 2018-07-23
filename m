Return-Path: <SRS0=b4Gn=KH=osadl.org=hofrat@kernel.org>
From: Nicholas Mc Guire <hofrat@osadl.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] iio: ad_sigma_delta: use unsigned long for timeout
Date: Mon, 23 Jul 2018 11:18:38 +0200
Message-Id: <1532337518-30085-1-git-send-email-hofrat@osadl.org>
List-ID: <linux-iio@vger.kernel.org>

wait_for_completion_timeout returns unsigned long not int so an appropriate
variable is declared and the assignment and check fixed up.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

found by experimental coccinelle script

As the timeout returned is always << INT_MAX there is no side-effect with the
type conversion here, never the less proper types should be used.

Patch was compile tested with: x86_64_defconfig + CONFIG_SPI=y, CONFIG_IIO=y,
CONFIG_AD7793=y (implies CONFIG_AD_SIGMA_DELTA=y)

Patch is against 4.18-rc5 (localversion-next is next-20180720)

 drivers/iio/adc/ad_sigma_delta.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index cf1b048..fc95107 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -209,6 +209,7 @@ static int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
 	unsigned int mode, unsigned int channel)
 {
 	int ret;
+	unsigned long timeout;
 
 	ret = ad_sigma_delta_set_channel(sigma_delta, channel);
 	if (ret)
@@ -224,8 +225,8 @@ static int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
 
 	sigma_delta->irq_dis = false;
 	enable_irq(sigma_delta->spi->irq);
-	ret = wait_for_completion_timeout(&sigma_delta->completion, 2*HZ);
-	if (ret == 0) {
+	timeout = wait_for_completion_timeout(&sigma_delta->completion, 2 * HZ);
+	if (timeout == 0) {
 		sigma_delta->irq_dis = true;
 		disable_irq_nosync(sigma_delta->spi->irq);
 		ret = -EIO;
-- 
2.1.4
