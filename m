Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0426330E0E5
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 19:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650511; cv=none; b=AHCZ68L8It8nJYGODo2YG/HoXreSAJ8DAxtqRuVhhgd97rAvQfbQlA24y1ok5N36Au17497aCCetjJob77jkIkz0A0IbxM8C1299msviBD0F4EzDD0lVTUiPAXrN8ySCUGakFSuqqDQi60a6Iu6W/Rw3cP2ja/fiI6cgQ4WjJmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650511; c=relaxed/simple;
	bh=qk5V6C/buUjSgVqlR2gP9lvmXiwqitj3sTA6M5VgkVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TYxPHVn/Fq93R3gGCCZKbskZeBKR4vqbDDLtCWlF2zY1pkHFU9vlaD+UcqOFzA0Ef2alrrycjTxKa+5egbBOvgs21UF7DOP0yp5dtdRAeKVGbIqZPLAAGom+qjhg1LdlmTdcx8P7Q4Tqz1Lk9am9dPP80vIi40Y7LNNiwNCq0o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyX+R9vA; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyX+R9vA"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-83ef1d17904so9084740b3a.1
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 12:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650509; x=1780255309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bq2ZBNbqtfNnrU1ULZFFyVuyMOiXNJEljnbEgUUjzU=;
        b=AyX+R9vAXntDfpJDsMzaJXwyjOcWbokFuMF0ennbgQSVON+X5hdrJW/q2hkX924VCe
         JVp7rFjZ7RrnugWFv7coPVLQABKf5723Scyja5MmhMNKDA5xZdH4hAWee4ye2bFhI5bR
         W8m5kf1xZG8fwexIyY2CtPUZkw/9/e0SlsU/rev+XZqwNeFmtIsPK/GGIohtcpBkZz5o
         qpkBQxWUGsGN3iZsBKtHKtqlLFqC5FfeEd1/7I+9Bd4R5hMrI49chLter2M5v361we/c
         CCjExVgkhqDDkFEI3CPW+HVWNHGR/SeKfsQ76uCrqrIQQpS/yEPtANzZQP5jiSpKOqbU
         rVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650509; x=1780255309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5bq2ZBNbqtfNnrU1ULZFFyVuyMOiXNJEljnbEgUUjzU=;
        b=Hbg4xckTSLbQ7SE4Qh2REGq+jsL5ia1dYkO0xSFtNDEXtlrpv6MRVfkLOvyQ+BexfD
         6vxCYLirKPMBBj/1YhbSKzOSMf+c30t3nceRx4AK6+n+FCrGWs4OjFCrO54DDiVt2u4U
         BboKxq5K6wSRsc88Wx/snumB0HjE94Dv2WzTzdZaHN6MP9fg3q+uGNYXWFEBpupYiwCk
         4RU/LzanrPkYwtjYsgiioAKCzsYX1vq/WZZF9fkHM/krLO2asKBaO9TaCvbV2GbPgmJv
         0hH5m5Ju4M1ZfrSeB2n1kdPQSbYbc5VkueEsgol5aXbW2IGqdLG3EqA2C5VTkHK+Ks1i
         xNiA==
X-Forwarded-Encrypted: i=1; AFNElJ9WzOStcf1/9gTIo2HFK+1MZnkCcJ953zsdbLHw+f+zKVnMDvwwivCaY9xTQzmFWvwV2ywa+E+zb0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwDCIaPICBqIDOFW8KbtGxbEef+m0CjaOBUA4S4d6dz/ioMcGy
	rl5JWQEWPO+aCxEgNFgNg35ZiC+q2bnGCubz0tXkOTCO3tsxia0XCHmU
X-Gm-Gg: Acq92OEecEej1OKJoW5Kxk5mI67884cCfk9eDiYp3BPojm/6c91nTxNdUU4lfaUjFqN
	FjttJ27f9e/EmM2LNXAv+js9AEhaRVXVs/5AdlU79Ugv2suumr4CMnlzguPIdCheCGhqkxnVm7i
	Ganv7Qh/O1BNzrkA9znmbjiNmGFqwhSdP1bNCb+vUfIiprCJt8xNxq3YVfCXtB3QAPfjxtmuoz0
	kTsZbg4/hdwM655S7s6tMphcB91HRUK6CEhguPIKCMerKGWVDm+CMzCuy5IzWvwXYq/xY65lY8V
	l4lsXK5zM3gHQY9xjQwOHNlOkHbUDluNQZMg3Yw5tUN7vI4PeNSzQHHUSZZbO5GZT3VX+s3fpM0
	gsUlsFGPFVSGv7dV4KW+xADBordkKr4X88eEWY8Xcq9Xloxcja3UzY0+OV+9GlM+cQVPfJlN50h
	zJu4Q6NnMyEs/262oSwHWvtNEhL3fDgbQtraBLUkZm7tTeAE9h
X-Received: by 2002:a05:6a00:2d20:b0:839:f1c0:13ce with SMTP id d2e1a72fcca58-8415f385301mr10690293b3a.40.1779650509493;
        Sun, 24 May 2026 12:21:49 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164aed7c9sm8689973b3a.13.2026.05.24.12.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:21:49 -0700 (PDT)
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
Subject: [PATCH v4 08/36] iio: pressure: hid-sensor-press: use u32 instead of unsigned
Date: Mon, 25 May 2026 00:50:31 +0530
Message-Id: <20260524192059.1193716-9-sanjayembedded@gmail.com>
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
 drivers/iio/pressure/hid-sensor-press.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index 5f1d6abda3e4..a5db5220d3d5 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -165,7 +165,7 @@ static const struct iio_info press_info = {
 
 /* Callback handler to send event after all samples are received and captured */
 static int press_proc_event(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
@@ -186,7 +186,7 @@ static int press_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int press_capture_sample(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				size_t raw_len, char *raw_data,
 				void *priv)
 {
@@ -214,7 +214,7 @@ static int press_capture_sample(struct hid_sensor_hub_device *hsdev,
 static int press_parse_report(struct platform_device *pdev,
 				struct hid_sensor_hub_device *hsdev,
 				struct iio_chan_spec *channels,
-				unsigned usage_id,
+				u32 usage_id,
 				struct press_state *st)
 {
 	int ret;
-- 
2.34.1

