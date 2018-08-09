Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:52703 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730090AbeHIQSn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Aug 2018 12:18:43 -0400
From: Colin King <colin.king@canonical.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: max44000: remove unused variable max44000_alstim_shift
Date: Thu,  9 Aug 2018 14:53:38 +0100
Message-Id: <20180809135338.10868-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable max44000_alstim_shift is defined but is never used hence it is
redundant and can be removed. This variable has been like this since
the driver was added back in 2016.

Cleans up clang warning:
warning: 'max44000_alstim_shift' defined but not used [-Wunused-const-variable=]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iio/light/max44000.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/light/max44000.c b/drivers/iio/light/max44000.c
index bcdb0eb9e537..b9b0bd341be8 100644
--- a/drivers/iio/light/max44000.c
+++ b/drivers/iio/light/max44000.c
@@ -99,7 +99,6 @@ static const int max44000_alspga_shift[] = {0, 2, 4, 7};
  * Handling this internally is also required for buffer support because the
  * channel's scan_type can't be modified dynamically.
  */
-static const int max44000_alstim_shift[] = {0, 2, 4, 6};
 #define MAX44000_ALSTIM_SHIFT(alstim) (2 * (alstim))
 
 /* Available integration times with pretty manual alignment: */
-- 
2.17.1

