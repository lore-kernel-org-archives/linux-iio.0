Return-Path: <hofrat@osadl.org>
From: Nicholas Mc Guire <hofrat@osadl.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        "Ivan T. Ivanov" <iivanov@mm-sol.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH 2/3] iio: qcom-spmi-iadc: cleanup wait_for_completion return handling
Date: Mon,  2 Feb 2015 03:37:07 -0500
Message-Id: <1422866227-10484-1-git-send-email-hofrat@osadl.org>
List-ID: <linux-iio@vger.kernel.org>

This patch fixes two issues:
* return type of wait_for_completion_timeout is unsigned long not int, 
  rather than adding a dedicated variable the wait_for_completion_timeout
  is moved into the condition directly
* the timeout of wait_for_completion_timeout is in jiffies but the value
  being passed was a unsigned long not converted to jiffies and thus was
  dependent on the HZ settings which is probably not what you want.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Note that the timeout value changed very significantly as wait was 
initially in the range of 2 milliseconds, so this converts to 1 jiffies
for HZ < 1000 and 2 jiffies for HZ=1000 - thus the timeout value changed
by 3 orders of magnitude. This needs a review by someone that knows the
details of the hardware to judge if this change is ok - in any case the
timeout passed should go through usecs_to_jiffies or msecs_to_jiffis and
to ensure it is no longer HZ dependent.

Patch was compile tested only for imx_v6_v7_defconfig + CONFIG_IIO=m
CONFIG_COMPILE_TEST=y, CONFIG_SPMI=m, CONFIG_QCOM_SPMI_IADC=m

Patch is against 3.19.0-rc6 -next-20150130

 drivers/iio/adc/qcom-spmi-iadc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-iadc.c b/drivers/iio/adc/qcom-spmi-iadc.c
index b9666f2..61fb88d 100644
--- a/drivers/iio/adc/qcom-spmi-iadc.c
+++ b/drivers/iio/adc/qcom-spmi-iadc.c
@@ -296,8 +296,8 @@ static int iadc_do_conversion(struct iadc_chip *iadc, int chan, u16 *data)
 	if (iadc->poll_eoc) {
 		ret = iadc_poll_wait_eoc(iadc, wait);
 	} else {
-		ret = wait_for_completion_timeout(&iadc->complete, wait);
-		if (!ret)
+		if (!wait_for_completion_timeout(&iadc->complete, 
+				usecs_to_jiffies(wait)))
 			ret = -ETIMEDOUT;
 		else
 			/* double check conversion status */
-- 
1.7.10.4
