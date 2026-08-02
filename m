Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6945B188CC9
	for <linux-iio@vger.kernel.org>; Sun,  2 Aug 2026 01:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785635417; cv=none; b=sIXPNiqFKDytI+x+l+uOSsJvaMV5yyrq4DX9+ujTouLmclQeNk3cEUlxffY1rDEXk7iHAu1klzJ1Av39jIIwCUpk9M5kTlwMA/nMmvNeuA4zXX03MansblGCuVfEYQotIB47fdCCUsH5NbVBPKKLyVg6optrKgTyewdba5WTmuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785635417; c=relaxed/simple;
	bh=cCSwyeq+bUMJ6dCQDoQQXmGMX8EYf/2AqJF/E3NlKf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RYP+mPDLMBkJkIBPQ76wHO0pZ5cOHFSj/8jnpU4iFC20Iwu0V6MyU1HMjcG0u+lQ0m/cf8/LbNOY7NpONT75wyWXpISsODxeXArjJMHJteBzhsVQ0APxBQhtYG3W3fhZi2YzQCIg04+FqmRA9+udIWBMOfrLmWI6vYRSEf6UMQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwrYZ2en; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwrYZ2en"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8484f229529so1841478b3a.2
        for <linux-iio@vger.kernel.org>; Sat, 01 Aug 2026 18:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785635416; x=1786240216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z6NQeJkM6li/nOFCtSkjFCccdUvQQ23178ESjFjKpj4=;
        b=SwrYZ2ennVASiz2JxHw3p3SUbPh6C3b7Ouc4cHJFIjPcMvw9abPvl4057kMYiRvvWF
         pac3gj8dwGan9oA1LCNyOESbHRpGv2Ptzqqk7u7FkmYWUcZUAUGVnDZhhBRY+Rs+9Lpa
         obNlyfEH/YEZCOWhPSJ6OOEFh6wPUj12/sfcNm+d+f9bUPcpw1v3hVRUufmN+4xfWJ5U
         +7AzcxUg2flhXCCroq1xr/sdpyMwK+5DlZowCfPLPDisNH9Y9XozIIXI0KX97YdfQ0an
         LZUm+UauHSChGGUP2z264kEKoMQPUZiRABDn6fk9MxGbE7AYwKteUbBfp0OKTp5y9NEA
         sQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785635416; x=1786240216;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z6NQeJkM6li/nOFCtSkjFCccdUvQQ23178ESjFjKpj4=;
        b=Ak8U5OX2xPgUpsTueZ4QckZ/wwWWiJw6lGUrp6I3eKu+zIyje1E4iZUrxU3CHTDa+W
         WCeB/TzsOOOS4Fk7vLMmpu0KASo3JPgc1kBWLKGEgWXSNqLx+w4pUCH+NxWduKdTZ/Bf
         48JNfKrVKmdGyRFa6tM26knKy4EG2t08HG3TPLRUFZUHHTnWfbg1WzAGecglq8GRaoJZ
         Hi/BsOPhflJCfBcbJ8fyITIkOMsuo7AREO5LpYIuGy/znce4VNoljOyTiixJPXhXcNC/
         1jX9xDLZsplZGH5GUqDxVi7VSiIeVZ2vQTM5FYz9uSywUVZx53Yl9l1ylbzekYqTwnQo
         k3KQ==
X-Forwarded-Encrypted: i=1; AHgh+RpjP1oYt4MruDFcs8WCbULceuJFcs3q93ISU/0BKB5VU1onoeUJvzZRACBVogCWrbMGtDRgsvU8q4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YybcA3uX1LS/pc/x/q/aoU/pRxoEl7tRZLZUbCed22BlptU/v9O
	mo0pG41fg7TwuXx/rWCXufc3AC8cKUB+2ViNVzILjVFb/FFrgVr69HL+
X-Gm-Gg: AR+sD106EZW76poT/kuMK6yJU1wrTm51sh3LYYOGXeFxEth7DRDkaMLEmV14tq3vr1l
	r1Q9yqRr9skAQ+89jVRmraCGvL6d06hzCybroLYBX0a++uBGdhWi5F8c/Ae5MRQdMl4rc/Z8iZN
	X6f2AZVFt+55N33fmfHbsZsyrbw5HVAPh6tQainIWumY+nZqGS0YGWJ7I1fmqrabPfiapm7cfIM
	eBA/zh7ugsfDBGSvmexcBufzap4ioOoqnJYS94RQs050jDjooz4ljqkr7TcgGopCRunMSe+X4n6
	DUMoCpTDQgeibDi7z3cS+X0h7aLALOr6Jl5CjD4SYZs7qdYWWfNp4AxYh4cA9YQ9N9nI5Wrvl1w
	cx9Jcje6mxSqPQKIx35imGQQ4R5/NTQIp42hYp0gwzndYdcAxZjIwzYEB+dtV3n0OhKVlb8fcB4
	xEGJteAH/46c/iAazbQFhCZLNrXwsX+aX6u+jH0B+MqLAxOK749VfUaR9ZG3NJxLmjTF90FEJ7S
	Svrj4nsZN43jHBW118PhoigNZIggTZGbGRH3/YCjw4c4IVbcnpYAe1pZYkw4A==
X-Received: by 2002:a05:6a21:3086:b0:3c3:6544:6083 with SMTP id adf61e73a8af0-3c92a276a70mr5047352637.0.1785635415638;
        Sat, 01 Aug 2026 18:50:15 -0700 (PDT)
Received: from debian13.localdomain (bb219-75-96-14.singnet.com.sg. [219.75.96.14])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e1886e7sm24654675eec.26.2026.08.01.18.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 18:50:15 -0700 (PDT)
From: Adi Nata <adinata.softwareengineer@gmail.com>
To: lorenzo@kernel.org,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linux.dev,
	Adi Nata <adinata.softwareengineer@gmail.com>
Subject: [PATCH] iio: humidity: hts221: Fix checkpatch symbolic perms warning
Date: Sun,  2 Aug 2026 09:49:45 +0800
Message-ID: <20260802014945.17221-1-adinata.softwareengineer@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Checkpatch warning:

WARNING:SYMBOLIC_PERMS: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static IIO_DEVICE_ATTR(in_humidity_oversampling_ratio_available, S_IRUGO,

WARNING:SYMBOLIC_PERMS: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static IIO_DEVICE_ATTR(in_temp_oversampling_ratio_available, S_IRUGO,

Signed-off-by: Adi Nata <adinata.softwareengineer@gmail.com>
---
 drivers/iio/humidity/hts221_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
index bfeb0a60d3af..bad98da100bd 100644
--- a/drivers/iio/humidity/hts221_core.c
+++ b/drivers/iio/humidity/hts221_core.c
@@ -521,9 +521,9 @@ static int hts221_validate_trigger(struct iio_dev *iio_dev,
 	return hw->trig == trig ? 0 : -EINVAL;
 }
 
-static IIO_DEVICE_ATTR(in_humidity_oversampling_ratio_available, S_IRUGO,
+static IIO_DEVICE_ATTR(in_humidity_oversampling_ratio_available, 0444,
 		       hts221_sysfs_rh_oversampling_avail, NULL, 0);
-static IIO_DEVICE_ATTR(in_temp_oversampling_ratio_available, S_IRUGO,
+static IIO_DEVICE_ATTR(in_temp_oversampling_ratio_available, 0444,
 		       hts221_sysfs_temp_oversampling_avail, NULL, 0);
 static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(hts221_sysfs_sampling_freq);
 
-- 
2.47.3

