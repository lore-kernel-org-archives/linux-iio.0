Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D6E2E7BB6
	for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 07:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775892338; cv=none; b=nXilcOGSOd/NyWSa0ZQpvihd/1WER7MQb7azwFaRjMAm5My2OI2B6JN6lVvWbg6sA8FQYMeuLzFOf5GPXVNb/ESZKjsfiaYeBTCXRGcZfhWHrD0cRQobJWQjxy7GeR8rGqzbFWyoLWSCl92gOxZXuFH3LosAacBzHFycZkHf79I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775892338; c=relaxed/simple;
	bh=UnFQI/xZ2NN2/3G0kANv0nIIcQhsiP71t+jtp73+Has=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=raceCb26yIysIA15lIwUdEposgXfUDIULCz9N+gHaqViYxygtNrwDBh/hZxHMppT02zpTKHFfaIe3YlMgK6bSVrB/TMJOR4vj11IvUbXmHI72xIqpHpsdnTQgcf6MZBROV3QtZqXnc0Kl1/wA2OtgW1pKifCM5Z8x1zMRjZzktE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAvHDdzV; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAvHDdzV"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-82cd70febc7so1868219b3a.2
        for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 00:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775892336; x=1776497136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QadZHnC1xiEz3wsZd5m0aD9GF8EBS7dTGAYQPe3wNUk=;
        b=cAvHDdzV+3ied0lFMgvN4OULiKKXGBh6T/fZ7O17drLoaqKekfR3WTAtwXFiGC8Xc8
         K13cuH4No0FzgAQ/M3GhxPNrFqV8neM0v2JdgVd0l4uGmO3pz3QBIgEDggx5ZKT7VnN/
         qap8nqLH8tfLy9UjjNHcRf/NKmA3NzNb/db40vhJxVyZu0bMvWOQ3xVv7GIeGmaELJN/
         HYQO6emm0GwUwL6ZcpvUHSsFVX2BcLBmV476y2STMYbGisBx40uPNxOImZrQ0Pb86xao
         ZOqNqEmJaNf0benNUGQPKCWiZuslviwxv+4tywQOe/8XWXOHV5wb0VxT3+QswsdgQ5DU
         SgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775892336; x=1776497136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QadZHnC1xiEz3wsZd5m0aD9GF8EBS7dTGAYQPe3wNUk=;
        b=Ls67Yig7jRctVjFmp1a0ac4wDoWXfYxZGO1Zr9hYYBBZvBIYs1CbbI0j0WRfzvdFGn
         MfV/ny1BIZm+4neLiCvrxSdrZsCIw+M8dI2f61tZfm1Jug968C851WXcQSiw1agyZeU8
         TGP3rmzJK4VLcGvMzg94TFZbQa/YGYseQxyRJBZkr0mJloGZZxKSHdEXE8F0oc2BYqOK
         D28LpqsxEGvN4OmaXO/fCp8qiq3JFlKPutQZqDDCpjFWRHsiKLxqvytBGPEa4jbJRDma
         8n+xllolvD+tyVQvAzLfN13jkk0OzR6pIN/J87uMiniP9EubwqOvsnlSdtZ4ojKs616g
         nh3w==
X-Forwarded-Encrypted: i=1; AJvYcCVKtrFKZ72c5QVlZbm2WAnIqHcpt4+xarisWFCxcB5MaXAQLpMo5eGkV30LHIifZCo/UOevwVqB1Ss=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFmvr3z17CKR31wS9hOwTnSZssKzfxbUxv6PQqcPeWY6uwSrO+
	XTOPv1O5TN1S+1zG7um5AOgpwEhooixizjtMxWSmPlnOnnUrDLtd48vdPgkeQJtrtYM=
X-Gm-Gg: AeBDievOdOa3tw6Zrseywby6v1omlOiq4uI1OtfpRSV7AFALjcNkISVwhO2apP3bLNn
	aJ5g04uDgjx9Xm+s6R3CDWN6P2p3zEQ/eSF4vKU32SZGYCnRCVuM804N/MwbDqZ8EERcwJKWOlI
	oi6/SimSTirbP4kfLo/uydoH3EJA2BqOrdA0vIdJOcIegtXEtnRM7BBreyXKp93aago8R6mpS90
	fzQieywKsczQfh6KR33MryWu7tN/6HZyvDBhsUUx2gJygLQm+J8xEzYEVzDyTvyjKPFIKOc7lug
	+NPFqIoLHl74jkKEeJfiZMjVVJWzmEXpRAe2iwIcVtVugavz+BJU8xsaMmUJ6c6mwDE6UvPFGNR
	kBg4uUm+jTmof7E8xTaTPEi2XoIc0VznnYzQKQDmFJRCsCOtPTwdPyQHKHa4pOFNttua0XsGT2k
	3sdL1sIMBPF2Kxz2yYajW7D8l1B/qK4keZseAAZ+JQNaEg/t7O2eoWdfC4
X-Received: by 2002:a05:6a00:6c88:b0:829:9c5d:4342 with SMTP id d2e1a72fcca58-82f0c2ec133mr6088159b3a.54.1775892336610;
        Sat, 11 Apr 2026 00:25:36 -0700 (PDT)
Received: from kubuntu.bits-hyderabad.ac.in ([182.75.45.16])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c30ee6csm4880898b3a.4.2026.04.11.00.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 00:25:36 -0700 (PDT)
From: Advaith Neelacantan <advaith.neelacantan@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Advaith Neelacantan <advaith.neelacantan@gmail.com>
Subject: [PATCH] staging: iio: frequency: ad9832:  use guard(mutex) for locking
Date: Sat, 11 Apr 2026 12:55:04 +0530
Message-ID: <20260411072503.106621-2-advaith.neelacantan@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace mutex lock/unlock pairs with

guard(mutex) for automatic scope-based locking.

Simplifies code by removing need to manually unlock.

Signed-off-by: Advaith Neelacantan <advaith.neelacantan@gmail.com>
---
 drivers/staging/iio/frequency/ad9832.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index b87ea1781..73c47a049 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -181,7 +181,7 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		goto error_ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 	switch ((u32)this_attr->address) {
 	case AD9832_FREQ0HM:
 	case AD9832_FREQ1HM:
@@ -239,7 +239,6 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 	default:
 		ret = -ENODEV;
 	}
-	mutex_unlock(&st->lock);
 
 error_ret:
 	return ret ? ret : len;
-- 
2.51.0

