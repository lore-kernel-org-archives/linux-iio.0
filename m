Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.avionic-design.de ([87.253.173.79]:28929 "EHLO
        mail.avionic-design.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751663AbdCXM5G (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Mar 2017 08:57:06 -0400
From: Nikolaus Schulz <nikolaus.schulz@avionic-design.de>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
CC: Nikolaus Schulz <nikolaus.schulz@avionic-design.de>,
        <stable@vger.kernel.org>
Subject: [PATCH] iio: core: Fix IIO_VAL_FRACTIONAL_LOG2 for negative values
Date: Fri, 24 Mar 2017 13:41:51 +0100
Message-ID: <1490359311-21042-1-git-send-email-nikolaus.schulz@avionic-design.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix formatting of negative values of type IIO_VAL_FRACTIONAL_LOG2 by
switching from do_div(), which can't handle negative numbers, to
div_s64_rem().  Also use shift_right for shifting, which is safe with
negative values.

Signed-off-by: Nikolaus Schulz <nikolaus.schulz@avionic-design.de>
Cc: stable@vger.kernel.org
---
 drivers/iio/industrialio-core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index d18ded4..3ff91e0 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -610,10 +610,9 @@ static ssize_t __iio_format_value(char *buf, size_t len, unsigned int type,
 		tmp0 = (int)div_s64_rem(tmp, 1000000000, &tmp1);
 		return snprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
 	case IIO_VAL_FRACTIONAL_LOG2:
-		tmp = (s64)vals[0] * 1000000000LL >> vals[1];
-		tmp1 = do_div(tmp, 1000000000LL);
-		tmp0 = tmp;
-		return snprintf(buf, len, "%d.%09u", tmp0, tmp1);
+		tmp = shift_right((s64)vals[0] * 1000000000LL, vals[1]);
+		tmp0 = (int)div_s64_rem(tmp, 1000000000LL, &tmp1);
+		return snprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
 	case IIO_VAL_INT_MULTIPLE:
 	{
 		int i;
-- 
2.1.4

