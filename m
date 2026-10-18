Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C1B45561A
	for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2026 20:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792353701; cv=none; b=NkxagDCVMIFPqiD6Ikw3SZs1V5yxrHROAO4ixXKxEGLTJ7Muk+HB+JQo8Kqm4Ya1NbqWac5DQocWOscQkJoFO4BVgzEvtOTvyjDKsIW168p42rQ6rL7iHh+NQqylEj+YsC6onMAJBtfkIclvWOoeeapv8EBxi+Puer5NtxhzmoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792353701; c=relaxed/simple;
	bh=Hx2Qj+l8OFcg63fIdID0ARo7fsSvD3MoqrRN8F5jdQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pyVpfzkIHwEhP48eubvlUZPDVgKaiiOZdZzHRqW0Di2yo54TD4MwTYbAqehBXWopfPUPwVYemJASDmz5nONSpSX9UiIKc6S6CWwTmad3BX4yiWKJ1XE6iM2/zNzxgI4YUNkglhHyE/uyXythzL2fPZKQWeP0UlUC3xv/VNmOSFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AygePdDG; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AygePdDG"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so2998716eec.0
        for <linux-iio@vger.kernel.org>; Sun, 18 Oct 2026 13:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792353699; x=1792958499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=78g9KK4RW/XUg9Q6d51RdojUrkDXmguxkjVsTLKd+rM=;
        b=AygePdDGZ+YkNxZvmkSZhGTn9muge/1me4I0AmQ/XL7hTsT6tCohL2NHq7NCR3ha3E
         MsBAXjbNhuVx7gQwkCNZcov/PHBnWnGTQskbWl9eRc06MYWZx9INPWyBk+5bSWU++B6L
         iCwu67rri9WxC1lYw/1PswxeeJOfe0QsINd4RZU1u1cYbHoaL21qD/KZ330ocxLrRmT+
         Rz7S9RX9Fz7HeHeT8iS1jHj5taX/Ix8XoOBUIe1h8+3rx0kI16CEbjg4raWvwzkR5PiD
         +HCBgEoVnRTqye+Qe3R5e3ENOMUy1RNg1XBMxSIFYSgGDkVX8DRA6Nduv/jWCjhCBwoZ
         hcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792353699; x=1792958499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=78g9KK4RW/XUg9Q6d51RdojUrkDXmguxkjVsTLKd+rM=;
        b=wKp6RM7cxl+rAKfdzxnMf+tBjSz0z9cnBEhhsvZeDs0YBrjsjAkIC0/yQUV4+SvL4O
         hTmmyNOBSNUEH+rZTQTzlPIwWXF/YqaM9JJSa+e+IQJYMAJbOkSuYU64ZqhPD0lMgpPv
         RvEPXOWhCnf3dI14FxErb+tv5bz1pAJM7mj8JYvFLMtSXqQsttT4KEThsuV3iQ0tqSJv
         57ZKHWQgnqPBn0LnZlPDExtI6YfsxqePoPCTKARpgPvv2cXuR2wvlthIGC+Ky81SBGcI
         inTKJ5aY/G4KsEhdFBXoYn4qBOazFGN1gTFOo9Qo5pDWDWX8sXrVpwHJWnHp1RNCitLr
         S3zA==
X-Forwarded-Encrypted: i=1; AKwUvBwi+ns47PbKxS0wX62EHjFYLJcRjoUte0R6LgO/m9soXk84w39vftvm6cE2HVD3DJ182BzXgCc4xvA=@vger.kernel.org
X-Gm-Message-State: AFq9FYI1qOa3XeIK3TrZ0P8eYIAAUltIVAbI3Rj3z/DNKZNr/r8QESob
	H7rlHSGjGn1dgYLNxufliTzbwWnxAKS1ADlBxchYT3R83pnsv8gkpzvw
X-Gm-Gg: AYBFou1ziiPB07VqYUWgqRcFjGl9Qd4z0UEYLGZsLu5bXmzOIT6DeYAr1lzAs6C5K03
	LWi0Z1o6nL+5hbJeB+O+AlHzUK8RQQH9EeoxT607swKrYW+1D/Tpnv0qGcWJ1Xl9WuJnsBbdANr
	H/os0iCZbAuHFE83r4yO/4RYaXJkJniqzxevpWoDPF3OnPqLnNenas86PR8YlelqVeQotbjXUMY
	G4JoRjSloGqrJCTjVzClqBMgdmX8BPY7PqKbGDQtw3VnAiDGks8q8G9yzt1STl+x7aSMq9ucmOe
	wdH+NN7bcpPgoPCXlgQmaHH6C2Buta5oUDJ/yeMXwNBIrm5c0OVgrh7HjBTynUpzy3nQsJSPwda
	8YnFLt8s7xzQesASVLQdQ5I7+tdLDyv7Ez8+IJ5ztWW+VVtULBKGKysCDloMLubmDz+c6luWDvN
	Oe//+al26lKy6d/HENWK5ju23HqNfwaVKMXp3RrnmwlYLUUq7Dd2Neqp0Lx/UGgbZEYcYY5oAVe
	FiCGWlk9kAlF+fhn6UyKds=
X-Received: by 2002:a05:7300:d588:b0:360:58a9:2704 with SMTP id 5a478bee46e88-361a1471311mr9142824eec.6.1792353699112;
        Sun, 18 Oct 2026 13:01:39 -0700 (PDT)
Received: from NithishVelan.localdomain ([152.57.94.185])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082784ec8sm24693980eec.22.2026.10.18.13.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 13:01:38 -0700 (PDT)
From: Nithishvelan M <mnithishvelan@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nuno Sa <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Nithishvelan M <mnithishvelan@gmail.com>
Subject: [PATCH] staging: iio: impedance-analyzer: ad5933: use guard(mutex) in ad5933_show()
Date: Sun, 18 Oct 2026 20:01:27 +0000
Message-ID: <20261018200128.642-1-mnithishvelan@gmail.com>
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

