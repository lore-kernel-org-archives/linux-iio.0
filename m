Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78CC314A9E
	for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 10:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777201021; cv=none; b=g8gOQOSjeR7ei0KrU+Z46INvLbEHWGYiCxP24xjmw+3SKyvdJNLMK+D5NFRfEtMywxJJyZCJQ0S96QrGx5eXJOHKNQXw0x7Z7qQ11BX4aVbbw/c+KZxriBp4EsBr8uyNesIroxN3KF/rl2h+c331ysuoP2ew5GxxDEOfTFNgE0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777201021; c=relaxed/simple;
	bh=R7t8Dxm4N4TH8az3T+2O8jGth1/zfuHUl5nazXlAT40=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l9EBjIdzhEsOW6jEYsKMcyCG/MZ8qIAMBCqpZ/8r9ukz52WuNL0kZt8O3cqF2g384YzIdps9uMocaLUO2hN6Du5+KY4KXkEXvAP9acauomkd77LFbUF0vc3RUbhOiJ9QGclQGydhO79bH4N05o9bSQtr6kPrM2oxQM4LBCfzVsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXf+W4+9; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXf+W4+9"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b2d3a9e149so48207445ad.1
        for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 03:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777201019; x=1777805819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/MmJo/XgpKRA3A7qF0L4xXU1s05fphO/Tr8t4rT8lfQ=;
        b=EXf+W4+9r4seiShtT9gCERrqKMGgMLRGCmADr7/qxJqJPw0Z3420dBCJUe7KH4iVGi
         WcQllsCtB586IZNZ+rGiE/USH2MmNpebN4cHG6T7IEYfMVeR9xV4wrJvitk+4rDWKEu0
         Tx4xTdkEsywtKLEQgjmSRzauOBfA6YSxZvokNSQCIvQNeO9+NGA3qaxN8hDbaoYYRD7U
         DdKNmeNwF8Z4MVDVSVWomS0D8pAGF7YS0q7fqyx19sRO8Ef11BJ8oUP2V4qMNbdgdmc7
         9pZg6SJmcXrcI8MnxHTag4exZNoQQSKYyqMzPUvfXjVKq8lYGAOxYJhDrSgird8Gq6TJ
         gWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777201019; x=1777805819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MmJo/XgpKRA3A7qF0L4xXU1s05fphO/Tr8t4rT8lfQ=;
        b=fcLCnwZxC0mkYwU+c1ORi4gYhkEqJn67W2y+A3WmuPiyIqWASmkWSylqk6sKO+dZIX
         hrXeRRAx0/R3l6gnlmczvR59sPAl3fz4l5PlQPeAayQ2upRXI3KdMKqH019jDxLkpW2D
         7FcG54Et/4Ua7cjrgJGqVqSnJYZiA7HqFTyXTzFyU6744wrJvERtkteHmTEtlaS9ng0M
         Yk2/F409DboaeA1jvmjsJa4dfZcqwNgW/9J7W8+vsEz2U4O2JWt7OrKI8kWVpn6iVDCX
         JYURdJ7P0lBLhFEJ3pmehhnX+1BKJ10JiOGMZnA9a0Ua5h365MtqXTMC6gPqrXjkXe13
         7hbw==
X-Forwarded-Encrypted: i=1; AFNElJ9Eq3RdLXv5LhgK44iX6j+KIIaMWHaUZphvLcERQTkpA0pRB9hD5hGSC2288Cypy70TH1n+XuGcy4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS4aFOdpWH0OqZ1YFNCx781ETVpmreNU4t3CsQHR6a6mblVHEz
	9a1tQPJ5RDwyevnNLFv4J9VWVMoxFnia7BPnm1TLd0WyaFd//faiq/T+
X-Gm-Gg: AeBDieuwUfyDS8BOyY4fFCh4ku1WrNmrOtOYjlG/01I64RTsdJLr9k8oPGXnDW7BSoX
	pnUKGQeEjx4KJdWzAXo6wi94CQw7P93ltgIQUEdutHwiAwE4SFmpN0GtHu9H1dPqDxopYxnTF7T
	tzi3CGsr+vaASP7swU8/KaCT2yhqcw65TEcohTqSCa/4WLIz8q0RmXRiLonm2a2K7PFFhXKNvOo
	yBaMNMSawbTn2c0PGEseSUWFEWfI8qhvLT0jFIdaWc1KGOrtoP2s7ezuaOvvQP9Xy8pmSC17DWn
	zlcZvYnu19pffzs4Iynj8wGyvIOzYGaMeeQx+OSybUgcp1YSfx962xYV7IzykNkdKip7FPDbBbj
	pMyMVsznos1f9NF5mlivWHvZcFVG1tWshY2V1YPwnRTyBrKvBdoNPPwPG/+b4UNOD5M5+oGAg/I
	KsZJxIdyyuQskXa/YHTB/97gd8JYoiY1IE6oRGxkY+GQ8+3o2em2zbEQguL/M=
X-Received: by 2002:a17:902:da8f:b0:2b4:5fdf:f91f with SMTP id d9443c01a7336-2b5f9dc3154mr358935165ad.4.1777201019119;
        Sun, 26 Apr 2026 03:56:59 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa507cbsm284535265ad.37.2026.04.26.03.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 03:56:58 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: ssp_sensors: cleanup codestyle warning
Date: Sun, 26 Apr 2026 16:26:53 +0530
Message-Id: <20260426105653.3764291-1-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Reported by checkpatch:
FILE: drivers/iio/common/ssp_sensors/ssp_iio.c

WARNING: Block comments use a trailing */ on a separate line
+	 * */

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/common/ssp_sensors/ssp_iio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_iio.c b/drivers/iio/common/ssp_sensors/ssp_iio.c
index 78ac689de2fe..e83f589fd72c 100644
--- a/drivers/iio/common/ssp_sensors/ssp_iio.c
+++ b/drivers/iio/common/ssp_sensors/ssp_iio.c
@@ -24,9 +24,10 @@ int ssp_common_buffer_postenable(struct iio_dev *indio_dev)
 	struct ssp_sensor_data *spd = iio_priv(indio_dev);
 	struct ssp_data *data = dev_get_drvdata(indio_dev->dev.parent->parent);
 
-	/* the allocation is made in post because scan size is known in this
+	/*
+	 * the allocation is made in post because scan size is known in this
 	 * moment
-	 * */
+	 */
 	spd->buffer = kmalloc(indio_dev->scan_bytes, GFP_KERNEL | GFP_DMA);
 	if (!spd->buffer)
 		return -ENOMEM;
-- 
2.34.1

