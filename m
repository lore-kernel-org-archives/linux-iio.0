Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D461737756F
	for <linux-iio@vger.kernel.org>; Thu,  3 Sep 2026 05:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788413946; cv=none; b=e8ZFH36nt7X6mPuwlXd5JMUXwZJKjONbpyRUJxZDYCTR3UrMKFhTZW/nGbCsTtJsj9eZtMUu/ALYLevAFJg5bry2uD2aBmVtsJoQEvjgiH+B053EjZBv0YtxGiIN+VEMKWgoeWIYMWOlzMIVSkxmIkVO6ID9wj2CiBePFxMGPgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788413946; c=relaxed/simple;
	bh=b3b6gfesD/os7apgK4gtFisoUHeK/sYTDMIjbfHch5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HsLIbeDRRKkNjNsHBvXhQzV2BJ/9wD5X/XugglQU+zlWcfO4jvRvqZoKd0f4NIaXvBGI3yeWOw0en0dL0ZPFwxjHtU9BHKWaOeYksvFCdlnxwtREvu3Sk57IxYgzaJqmiKcZx6A42H5zmyVRMBDWCJHOrRupDt8kM6ZFQR+KIVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/2JVReG; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/2JVReG"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc1cf287ef8so1828955a12.3
        for <linux-iio@vger.kernel.org>; Wed, 02 Sep 2026 22:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788413944; x=1789018744; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZPmOa6ZX8GipLr+aIS+ts/201Kh9WrJNcUfS+NBI5Ec=;
        b=P/2JVReGm6cbKAZpWPXYbSWfujzFRkcsHCR/JOzeen1XAGcOSBmUD4jpNaaO9AguZI
         ypeJmwWUu6U6wNrV2GIXaDfG8E2kAdVVoAw8bXG/b87D3mfVPeHIAyUsvVHa/X4R0ufi
         2JsTIvZRvBAN1zUx64v610jE6mxJUtAEIby5525n62+p3W5fzi6zG/w5oOMcTX0Uu11/
         3t8y2u6aj5wd4l+R4Zl3k1MhvyAL2OjeDVC4kSe6WRwawHNhU0dmBFv/K8W9ipBTM9vt
         o65QMIA5xZ9ETBKdwUyAoDlEVzD3sZ9IyKtSzikT+w8S26peuUZwXGp4nNulo4ZgtBDq
         wTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788413944; x=1789018744;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZPmOa6ZX8GipLr+aIS+ts/201Kh9WrJNcUfS+NBI5Ec=;
        b=pcJ3r4vVe1mKV9PrRXsiygqgK979uqmVhx3Co9MFoLTSw2otlEWDw7oul3ZBJGESTj
         EzgP1NqHkW9/DxRZ8bpiB0T6kd1l/1aTMicVa/L9vBgSfOrSVwCvAZ+JmlMbaJVKNv5U
         1sMP03vmKPS6kALvJ7v2ktLVM0B3rIKBrLJEJ9wX5JnA4olalViRi9iXnLZXuaA1Xj3u
         buWgQFMYyb6vx1quvlK2i6Ym4zQ6hWd5vNzigcwT5YpBiuLWYKcDg5AUUVBX2zFekqoq
         oYxqyI5tMi+NnIKBzjxXONBUmEqULnnz3u8508nfx02h8K1EqOIr7uKe6hZIQVaHn6Tn
         DAoA==
X-Gm-Message-State: AFuF++kIZ6WBU2yBpDS8TfVPfNcDkdoJ5LHOB0vaS7gGibrx2ssObI1u
	++CK5U/L7odF8qwXnztowGeksB/5xCR54AJEtCC4jreWYVbMXhn2wz3y
X-Gm-Gg: AYBFou1Kz6UpVy8qSrDDpSXjc1yYyo7o4pSGITZ+yk+fACby+rnfxiH88UVVlAlwR7k
	uZE35SgQi5/HMuLf3VHexc91rgLWJK4Zzv4IGimPbrKdoJvbcAfeKgh/u1OAcIz7nUGExbRRJU2
	DhySi22y+h4bC+VoyjtmYcj/B2E9jtZm9vSAWnPJNreC+yAbrH2Lf3KB0aU04+xMonoEqjDzbF5
	9hnIVPU9LoNApIJNIWOef3ynuEbW4/Am/kjVU07tBeGm51Lvpr7V4KNA76hLMA/RWGkz2IfvAgW
	pfMyQeNVSLS6uaFm6X6/7Ze+oFOMjIZqLhLk1UKyQgyY6C+4Mm0JPcY0O9gzZvZUWSKiHPi3oa2
	GrkIiyVpKs5lxpuAo/OaRkM4P5GDAnHna2ULivLZSQzrHW1ImVYo5Chce5ZB1lcNcB3iFI4Rm3V
	MC+rcvWHjVtwrltx964ExUzDU1cNDAYU4FXBz0w8RMRXimWznurwU7TSfTqu5PyN8tVFg3kVa9H
	L+e5MWGG2a21zvMtMsWrxpNhMI=
X-Received: by 2002:a17:90b:3b52:b0:396:d28e:bd8 with SMTP id 98e67ed59e1d1-39aedf61001mr14096928a91.3.1788413944106;
        Wed, 02 Sep 2026 22:39:04 -0700 (PDT)
Received: from [192.168.20.42] (115-70-157-242.ip4.superloop.au. [115.70.157.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08ce4221sm3253082a91.14.2026.09.02.22.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 22:39:03 -0700 (PDT)
From: Tsz Shan Chan <tsz.chan.dev@gmail.com>
X-Google-Original-From: Tsz Shan Chan <tchan@jacques.com.au>
Date: Thu, 03 Sep 2026 15:38:47 +1000
Subject: [PATCH] iio: light: apds9306: fix default sampling frequency
 definition
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-apds9306-v1-1-3f892aa4f156@jacques.com.au>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSwNj3cSClGJLYwMz3aTUlKRE8yRzk1RTSyWg8oKi1LTMCrBR0bG1tQD
 lNLVoWgAAAA==
X-Change-ID: 20260903-apds9306-bedba7b74e59
To: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, Tsz Shan Chan <tchan@jacques.com.au>
X-Mailer: b4 0.14.3

APDS9306_SAMP_FREQ_10HZ is defined as 0.

According to the datasheet (page 11, ALS_MEAS_RATE), bits[2:0] set the
measurement rate:
- 000: 25ms  (40Hz)
- 001: 20ms  (20Hz)
- 010: 100ms (10Hz)

Change APDS9306_SAMP_FREQ_10HZ from 0 to 2 to write the correct value
for 10Hz.

Fixes: 620d1e6c7a3f ("iio: light: Add support for APDS9306 Light Sensor")

Signed-off-by: Tsz Shan Chan <tchan@jacques.com.au>
---
 drivers/iio/light/apds9306.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
index f681b02e4922..7dd41136734f 100644
--- a/drivers/iio/light/apds9306.c
+++ b/drivers/iio/light/apds9306.c
@@ -61,7 +61,7 @@
 #define APDS9306_NUM_REPEAT_RATES	7
 #define APDS9306_INT_SRC_CLEAR	0
 #define APDS9306_INT_SRC_ALS	1
-#define APDS9306_SAMP_FREQ_10HZ	0
+#define APDS9306_SAMP_FREQ_10HZ	2
 
 /**
  * struct part_id_gts_multiplier - Part no. and corresponding gts multiplier

---
base-commit: 940de590b839f71d6dc846160534bf202401b8b7
change-id: 20260903-apds9306-bedba7b74e59

Best regards,
-- 
Tsz Shan Chan <tchan@jacques.com.au>

