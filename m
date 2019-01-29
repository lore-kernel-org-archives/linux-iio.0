Return-Path: <SRS0=/rIq=QF=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FA1C169C4
	for <linux-iio@archiver.kernel.org>; Tue, 29 Jan 2019 06:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504AD2148E
	for <linux-iio@archiver.kernel.org>; Tue, 29 Jan 2019 06:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfA2G1E (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 29 Jan 2019 01:27:04 -0500
Received: from anchovy2.45ru.net.au ([203.30.46.146]:56014 "EHLO
        anchovy2.45ru.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfA2G1D (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Jan 2019 01:27:03 -0500
Received: (qmail 4041 invoked by uid 5089); 29 Jan 2019 06:27:01 -0000
Received: by simscan 1.2.0 ppid: 3993, pid: 3994, t: 0.0772s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950
X-RBL:  $rbltext
Received: from unknown (HELO preid-centos7.electromag.com.au) (preid@electromag.com.au@203.59.235.95)
  by anchovy3.45ru.net.au with ESMTPA; 29 Jan 2019 06:27:00 -0000
Received: by preid-centos7.electromag.com.au (Postfix, from userid 1000)
        id E8EE434969E65; Tue, 29 Jan 2019 14:26:57 +0800 (AWST)
From:   Phil Reid <preid@electromag.com.au>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, preid@electromag.com.au,
        linux-iio@vger.kernel.org
Subject: [PATCH 1/1] iio: core: Improve precision of __iio_format_value for FRACTIONAL values
Date:   Tue, 29 Jan 2019 14:26:52 +0800
Message-Id: <1548743212-83787-1-git-send-email-preid@electromag.com.au>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Currently FRACTIONAL values are outputed with 9 digits after the decimal
place. This is not always sufficient to resolve the raw value with 1 bit.
Output FRACTIONAL values to 15 decimal places of precision, regardless
of the number of leading zeros.

Currently for a 2.5V ref with 24 bits of precision the code outputs only
to 9 decimal places.

Cur: 0.00014901100000000000 * 16777216 = 2499.989733
New: 0.00014901161193847600 * 16777216 = 2500.000000
Signed-off-by: Phil Reid <preid@electromag.com.au>
---

Notes:
    Alternatively I could add additonal FRACTIONAL types that select the new
    behaviour to prevent any possible regressions.

 drivers/iio/industrialio-core.c | 55 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index a062cfd..bd9da64 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -571,11 +571,53 @@ int of_iio_read_mount_matrix(const struct device *dev,
 #endif
 EXPORT_SYMBOL(of_iio_read_mount_matrix);
 
+static ssize_t __iio_format_div_prec(char *buf, unsigned int len, s64 x, s32 y)
+{
+	unsigned int prec = 0;
+	unsigned int idx = 0;
+	s64 d;
+
+	if (!len)
+		return 0;
+
+	if (!y)
+		return snprintf(buf, len, "inf");
+
+	if (!x)
+		return snprintf(buf, len, "0");
+
+	if (((x > 0) && (y < 0)) || ((x < 0) && (y > 0))) {
+		buf[idx++] = '-';
+		x = x > 0 ? x : -x;
+		y = y > 0 ? y : -y;
+	}
+
+	d = div64_s64(x, y);
+	idx += snprintf(buf+idx, len-idx, "%d", (int)d);
+	x = x - (y * d);
+	if ((x != 0) && (idx < len-1)) {
+		buf[idx++] = '.';
+		x = x * 10;
+		d = div64_s64(x, y);
+
+		while ((idx < len-1) && (prec < 15)) {
+			if (d || prec)
+				prec++;
+			buf[idx++] = '0' + (char)d;
+			x = x - (y * d);
+			if (!x)
+				break;
+			x = x * 10;
+			d = div64_s64(x, y);
+		}
+		buf[idx] = 0;
+	}
+	return idx;
+}
+
 static ssize_t __iio_format_value(char *buf, size_t len, unsigned int type,
 				  int size, const int *vals)
 {
-	unsigned long long tmp;
-	int tmp0, tmp1;
 	bool scale_db = false;
 
 	switch (type) {
@@ -598,14 +640,9 @@ static ssize_t __iio_format_value(char *buf, size_t len, unsigned int type,
 		else
 			return snprintf(buf, len, "%d.%09u", vals[0], vals[1]);
 	case IIO_VAL_FRACTIONAL:
-		tmp = div_s64((s64)vals[0] * 1000000000LL, vals[1]);
-		tmp1 = vals[1];
-		tmp0 = (int)div_s64_rem(tmp, 1000000000, &tmp1);
-		return snprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
+		return __iio_format_div_prec(buf, len, vals[0], vals[1]);
 	case IIO_VAL_FRACTIONAL_LOG2:
-		tmp = shift_right((s64)vals[0] * 1000000000LL, vals[1]);
-		tmp0 = (int)div_s64_rem(tmp, 1000000000LL, &tmp1);
-		return snprintf(buf, len, "%d.%09u", tmp0, abs(tmp1));
+		return __iio_format_div_prec(buf, len, vals[0], 1 << vals[1]);
 	case IIO_VAL_INT_MULTIPLE:
 	{
 		int i;
-- 
1.8.3.1

