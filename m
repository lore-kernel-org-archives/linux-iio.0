Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:54130 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752746AbdJSUGl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 19 Oct 2017 16:06:41 -0400
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH 12/13] staging: iio: tsl2x7x: put function definitions on a single line
Date: Thu, 19 Oct 2017 16:06:31 -0400
Message-Id: <20171019200632.25820-13-masneyb@onstation.org>
In-Reply-To: <20171019200632.25820-1-masneyb@onstation.org>
References: <20171019200632.25820-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The functions tsl2x7x_invoke_change() and tsl2x7x_prox_calculate() are
short enough that the return value and static declaration can be moved
onto the same line with the function name. This patch makes that change
to increase code readability.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index f12ab1239a46..42ed9c015aaf 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -752,8 +752,7 @@ static int tsl2x7x_chip_off(struct iio_dev *indio_dev)
  * put device back into proper state, and unlock
  * resource.
  */
-static
-int tsl2x7x_invoke_change(struct iio_dev *indio_dev)
+static int tsl2x7x_invoke_change(struct iio_dev *indio_dev)
 {
 	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
 	int device_status = chip->tsl2x7x_chip_status;
@@ -777,9 +776,8 @@ int tsl2x7x_invoke_change(struct iio_dev *indio_dev)
 	return ret;
 }
 
-static
-void tsl2x7x_prox_calculate(int *data, int length,
-			    struct tsl2x7x_prox_stat *statP)
+static void tsl2x7x_prox_calculate(int *data, int length,
+				   struct tsl2x7x_prox_stat *statP)
 {
 	int i;
 	int sample_sum;
-- 
2.13.6

