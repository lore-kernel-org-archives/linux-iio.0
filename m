Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA7F47ECC2
	for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 05:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792386442; cv=none; b=chhru+eB5uTLWeYh9BBZTGcOvLQ/u/osyolyveANTAuRUZsnsFfPdKkc/hhAIWHQdAofkV12M6XadJUrssPAMLMzlg7dE56aQwWJwnt/A9Pxj+lSBH1nTa2JKChj2GzAfuU8dO89Ey2QXZWW++RinnWAtmnC6ZExFlt7sY52oJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792386442; c=relaxed/simple;
	bh=x9wpxUyL530Iiw6P0N+3kTeiF91l97A3dxOFL5oObNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FwWf8yLx+GpCLlsyzzgG/KD33qqeUpDkytHmMRvJaccAuE9/2CuhUhXXrUbPaa0DJDaUgOdqyRMhwFJgeFkv2IB82gXAHmbpai7J1xHVJUMvuIlBeujrdz7H/vYe7Z2PbWaA39/RUWhTipnTJXdYoLlMtJjz6daQ2MojBkmJ7rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlN3EpQ8; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlN3EpQ8"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso953660eec.0
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2026 22:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792386432; x=1792991232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fva8zL+n1OCI0oMJodhd5ulLyrv34XE8ucuw+gfKNzI=;
        b=YlN3EpQ8H0+82aX+vWfFofSCYkGN7VEFNdl1mEMwqEvOUWMrZSWXIEFDoX3y1CYKiU
         JG+VbOCGRFc+b5ejda+fE+5RT8aIVJiacmrCZOZYmRHgVGn9FHIA1XMfemUC1FlwFxsu
         KXFX37t7TyCJb7PGu4DbSz+t5l7thYYBV9CZA3Tv2jDZnmKxOpfaRObk44JajtalTYZS
         NOj1AJVh1AbxgN9PHaT0Je4+bImkUs9pj877tycdIpOkBrsh9PBcDStFoaMw6CKnIbSz
         yeVYDpbkyiFPrwxfMIGJJGFVOoDebZ5FcwZCIQJMe+gKhh3T63sGXNv2suAsJ9cN48XC
         ILPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792386432; x=1792991232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fva8zL+n1OCI0oMJodhd5ulLyrv34XE8ucuw+gfKNzI=;
        b=poAZG7fdxUCUu3+9lNqv3OLcLuoWFR6WfH0kPm3K9r14ay66oPnOmFpyQPONeVQcJC
         +P8CK8XOs7mcrQ58DvqezG2scwgFNj+FquSRQ9jK++SMFrvyQEcClta9b6clKkatvENT
         Z26zlgZEDTRZMv9BcvQZM0nz0JS0ZNJb1bV4/gcPPthshLvP/WdH83v1oDjiRhoMay0/
         8y6Y3DTaRWdj1DIOJ63nqr5nMg/tk6SGr5kIKxJGZbYoT6Vu4wdIxpuwFneXTxWVoWDl
         pblObW7dOWAU4R0KDj7lR3+JE1Z4qymABDmqJJMtwebhJqaBlpWH8+lHj+z2GX/Amc6T
         sEeA==
X-Forwarded-Encrypted: i=1; AKwUvBypwHE2hE9n+GsXc5MMYBBRvPtHxJ7eW6ENSvP8N0KPxpIWf3wpYeN8d1khmlvGYS1SBWRoMKjFvAc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKC0YyoBWVNVQFtMCnmpY/kn9hUc53H7rvOG8QU4YAxLKe1UvVI
	uqcYfvjRf0POvWdiLmg0bpZCWz89D+eZkoFyGlGpFrbcaJAZxCPZci6O
X-Gm-Gg: AYBFou2/4BvtL+Gfv8Kk0r5zWcCkMLQp8ApYjY9M4Qw2d9BlsNjCd15fBJqc7bs4RK9
	YNe5e9LBpcaRe3RnPl1AS8kBJmFcA4rfPz6qfskjfTr+NzZadfmzNPWzXDx4xNDH93B92x7DrMj
	J/N2SoYF6mCaLIQV/yHqUynfMScZUM6/E5xmkkq4wRuhwxZkIi3FUDRN4Y2JEbS9xwCL7RRG/nk
	5ptRK0F/2DLPUTJGlJ5kqsQuCkFJ7qzIRlQAuUGqMmtXq5UDU3isrfy09xbC6KKxiLE8qabujfW
	U/DVdYWeTMjPSNzirXyLpbRMne3vYP1Eve//hC458/WdoGfCQ/H+A7pWNHjfSJSMsRF0GA76uz5
	mtc4woHuxu67VHDCvy9AMsyhyTRHzmNpXzYU5WN+YcEgkCAyNaxJhE0rxZZsgthBDbt2OaZ3mzE
	xeAflOUr/zoTzaZS/cILMk3v9ydhbMTLxVaZEXXJAWgeZbiPmIkHyfWdsPLGTN1XotybgdQt5zv
	mH8GAcYGKI7vvnHs+fdnw==
X-Received: by 2002:a05:7022:302:b0:157:cbf6:89c4 with SMTP id a92af1059eb24-18514350f17mr15503005c88.26.1792386431972;
        Sun, 18 Oct 2026 22:07:11 -0700 (PDT)
Received: from NithishVelan.localdomain ([152.57.90.98])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-18314ef8ed8sm23760564c88.3.2026.10.18.22.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 22:07:11 -0700 (PDT)
From: Nithishvelan M <mnithishvelan@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Nithishvelan M <mnithishvelan@gmail.com>
Subject: [PATCH v2] staging: iio: impedance-analyzer: ad5933: use guard(mutex) in ad5933_show()
Date: Mon, 19 Oct 2026 05:07:02 +0000
Message-ID: <20261019050702.419-1-mnithishvelan@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use guard(mutex) to automatically manage the state lock in
ad5933_show(). This simplifies the function by allowing direct returns
from each switch case, eliminating the mutable return variables and
manual mutex_unlock() calls.

Signed-off-by: Nithishvelan M <mnithishvelan@gmail.com>
---
v2:
 - Resend using git-send-email to preserve tabs and whitespace (v1 was
   sent via Gmail web composer and had mangled whitespace).
 - No code changes.

 .../staging/iio/impedance-analyzer/ad5933.c   | 38 ++++++++-----------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 798e62bae2..024c6b5a06 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -333,39 +334,30 @@ static ssize_t ad5933_show(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad5933_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	int ret = 0, len = 0;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
+
 	switch ((u32)this_attr->address) {
 	case AD5933_OUT_RANGE:
-		len = sysfs_emit(buf, "%u\n",
-				 st->range_avail[(st->ctrl_hb >> 1) & 0x3]);
-		break;
+		return sysfs_emit(buf, "%u\n",
+				  st->range_avail[(st->ctrl_hb >> 1) & 0x3]);
 	case AD5933_OUT_RANGE_AVAIL:
-		len = sysfs_emit(buf, "%u %u %u %u\n", st->range_avail[0],
-				 st->range_avail[3], st->range_avail[2],
-				 st->range_avail[1]);
-		break;
+		return sysfs_emit(buf, "%u %u %u %u\n", st->range_avail[0],
+				  st->range_avail[3], st->range_avail[2],
+				  st->range_avail[1]);
 	case AD5933_OUT_SETTLING_CYCLES:
-		len = sysfs_emit(buf, "%d\n", st->settling_cycles);
-		break;
+		return sysfs_emit(buf, "%d\n", st->settling_cycles);
 	case AD5933_IN_PGA_GAIN:
-		len = sysfs_emit(buf, "%s\n",
-				 (st->ctrl_hb & AD5933_CTRL_PGA_GAIN_1) ?
-				 "1" : "0.2");
-		break;
+		return sysfs_emit(buf, "%s\n",
+				  (st->ctrl_hb & AD5933_CTRL_PGA_GAIN_1) ?
+				  "1" : "0.2");
 	case AD5933_IN_PGA_GAIN_AVAIL:
-		len = sysfs_emit(buf, "1 0.2\n");
-		break;
+		return sysfs_emit(buf, "1 0.2\n");
 	case AD5933_FREQ_POINTS:
-		len = sysfs_emit(buf, "%d\n", st->freq_points);
-		break;
+		return sysfs_emit(buf, "%d\n", st->freq_points);
 	default:
-		ret = -EINVAL;
+		return -EINVAL;
 	}
-
-	mutex_unlock(&st->lock);
-	return ret ? ret : len;
 }
 
 static ssize_t ad5933_store(struct device *dev,
-- 
2.53.0

