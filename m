Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D753081A2
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 19:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650486; cv=none; b=HlZ2pAozM9K1JB4y7aPm0WJn2hOqJmnNAedItfPb2SSNDrDULp1dm0WzheIdn+rvEFW5zT54PtC9CBpUktxcScRQ0Mo2u4m5Bf4AQVcB1H+buXITcHgmI3WO8DwoZmyY3UezGu+xrpuImNer8jh8GWmdf2fumdsY6qq8NF/RccQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650486; c=relaxed/simple;
	bh=/QVszgJnEkulS/iRv/AhAx7SOz9/GjOk+6xLdakh/wU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ty3yIHPjoiXWfKH1gLdlAOSKc+BDvRPdbBvyFnArvJNv5oIp6MYhpgU+K9QeWeVMfPVKFGI97hzOPEa7rx66TSp/R9zvIDKExuw+vST6NXp72M/XyPilLwNT5VZDTqSrby4IP/sq7gPtRTQCxtY3X1dExMl184bmFFLncVjcak4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oTfzvWha; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oTfzvWha"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82f8893bff3so4094545b3a.2
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 12:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650484; x=1780255284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3NLBl9QxXqe4Ee+9JSBYGMFAkrfzp6f/9EsOxzh5s+U=;
        b=oTfzvWhaQlWQEMNla1/8EVMzfPms54qL6aKUV2T4ErLEMdBG+nhdwfG9s9pqRcRHRK
         FiDAyixLUEakM2Uqlt7YPfP7TGfig0Dqq7eNusRvc4MLucjRJFG2Ow+ilL8zXugAkNtH
         dZTfstL3Dlk8pRF4hWIbC07UUDTSTKVlCSuOWOj3mLGQjvT3E6/Fq2r9/ad5jMVmwaTw
         D4Ogsu0AyuNpXGMWzRH6GozbQ4yNg6AlzCOKlvy6GkyZE3WyTIxzqfzlQcCoIWheatHc
         SNIXH8F6JXCC85b4qttAekkUcdmTICSB9Qpikzz2/4CrpOA5daHXTkwHHwjX/ClENTGj
         mfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650484; x=1780255284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3NLBl9QxXqe4Ee+9JSBYGMFAkrfzp6f/9EsOxzh5s+U=;
        b=ohwfJ2U9jF9lIbM4i2qkStvpn80A4eGlTUqtBt86/tNBG/uq9eS4F8Ny+7nsUqynIE
         gHKQ4wvvCgfPxjvn9IrUd3FuyycKXKlUJrF2ajrYLrxhKZJbYBRc8IJk0nmJDQBtbwkm
         AVphHxFWHkPRS+5NcTFmQO7SrBWzuWa8T9MngSdUpz4Pb1FpMesyi7fOmpSC3bXLgC/g
         doT32JE9hjNAIB3TmB3yNwN/LFCLpOn9HtqL3B/eyr9G5jNF/cGvDupRFzLTEOxs2FHa
         F3IE6mFKNQKloRqqikblGHnU01/P2FbGGqO2KX6w81qzCrT0MNjTKs0H3Pklttga1Vko
         nRjw==
X-Forwarded-Encrypted: i=1; AFNElJ9XtXt33qlj6weBtYUu2XJxvaQh7Iy9uMOeOD8bCB8xkg7EdQ3laS5WFjxvxa5vDQ6YFPUHGn3Gu4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Y1vXHzoTCjvRRKANKzP1/200a4mC8owftgT3Y0HqyC/Th1Lr
	l70Fy4JvjT/M3fHjzCy/e+7dnwAkHksLSPkkmtDIWLbJ1zRIJvbcDFBu
X-Gm-Gg: Acq92OE4EjyCgNJt2IwQ+EC5LKI7M5kFSsQJjmjP9rOJ07Svuz4dT++hESSgb/mk5qz
	DfB6iMRm2HU/ByagMCXfG6qGIlVqlzwY+bul1Lpmg7DBwBCJR3ZHhVV2CzAbZyuN8sCHXqNyFUp
	oTx2gisbLzqoTj3qboXXiYRWbaIT1nomqbr0s/m/IY3si2rz7f3Xb2h7QUHn5SRqQh+QwTzE5rx
	QJ5UjWVXDfLF9aZo+wc/3JtRPRaBtYFXpza1lTSpRC0OM7rpE7moqWitGQDE5zZnmXg5gIuDHiA
	kt9zHbJjH6LWfAnXSVwKrGpUfXea4+IAZjr/6fnUDaMcbaGODW0v4SicjzxCiEF5jkO30LvVS6/
	0bivihPz7YxKufpszYhHFG4cuSF/itHZ/yKHg2N+fGV4TmDtoAUHFBeBfPiStVfgpkFSuiLmLNL
	bztuat11i4QpIZJawljy4jufG1I/Ac/UErJuLAO88ZvJx1lL92
X-Received: by 2002:a05:6a00:3911:b0:82c:dd31:b844 with SMTP id d2e1a72fcca58-8415f5e9a44mr10387787b3a.40.1779650484186;
        Sun, 24 May 2026 12:21:24 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164aed7c9sm8689973b3a.13.2026.05.24.12.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:21:23 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	sakari.ailus@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/36] iio: accel: hid-sensor-accel-3d: use u32 instead of unsigned
Date: Mon, 25 May 2026 00:50:26 +0530
Message-Id: <20260524192059.1193716-4-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260524192059.1193716-1-sanjayembedded@gmail.com>
References: <20260524192059.1193716-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Prefer 'u32' instead of bare 'unsigned' variable to improve code
clarity and consistency with kernel style.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/accel/hid-sensor-accel-3d.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 2ff591b3458f..67fb8efd6b10 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -233,7 +233,7 @@ static void hid_sensor_push_data(struct iio_dev *indio_dev, void *data,
 
 /* Callback handler to send event after all samples are received and captured */
 static int accel_3d_proc_event(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
@@ -257,7 +257,7 @@ static int accel_3d_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int accel_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				size_t raw_len, char *raw_data,
 				void *priv)
 {
@@ -293,7 +293,7 @@ static int accel_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
 static int accel_3d_parse_report(struct platform_device *pdev,
 				struct hid_sensor_hub_device *hsdev,
 				struct iio_chan_spec *channels,
-				unsigned usage_id,
+				u32 usage_id,
 				struct accel_3d_state *st)
 {
 	int ret;
-- 
2.34.1

