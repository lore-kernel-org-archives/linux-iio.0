Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23E030C16C
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 19:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650474; cv=none; b=XtBCLZreyJmSvJYpgOVwf88JdjHpBfqjMbiDAFT0W/gQXscZYAgvXTXA0XCsDwoYeeYWzV6LrVV9o3+E4nyIPxMqY5RSdbjUIE8+1HJPpNtlf5m9LW6ZsCMimrkDfreF5BwGw6qpJTDVhO19bQxDxPNKlSTkSFW6NX/sW3q/A+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650474; c=relaxed/simple;
	bh=MynwvAXISlN6FBbplJ3MtRw713eym2MlQlYrB5xEx14=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kOr17hs5VFdTR26hqKhCV/U+HeupeuZObCzbiYVwOWvHMHFXPbRDlaLhZdEPJgeysg4HfboOubnsLcLjz9KygFG5xUgfmwP0LgnIXsbuErH4qQgdwcCfUunkW8aMoDKXA6nl7D5j8O0z8jOZo+sq9RLhS9ELcB1TFhrAwWrMbmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUZVe9FI; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUZVe9FI"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8379e010b01so3852246b3a.1
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 12:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650472; x=1780255272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4fJxXzGfStgadHssCMhfgcT9RTwK+beGIJZOOpamdI=;
        b=HUZVe9FIVmiLXmVA3QmHAMvAWv3FJ6UYgtDkuiclwjeukUiE4EYtAHr+B+QyMZv0jw
         mIE1FDtJoVPvG/0W5kbB6ySbPr9TK4YWNL6XLIUPsrQQGZoIj77qmYAUrfeQtGpDeJte
         bImUMAnxE26mZiuQTfDi840zw7/eHT3AkU75tUGkO7nEBtOf12gms4WCJmiCMlq2FXSy
         QG/U+SWWZCsbAmL8gwLxvCejmfQczeuZH9s3KUgr23OHRrHsy3Qaf+4i+FQwckc/NJuJ
         9i4v2kHqJwUlJe9nAPugccpVdNv7KAb7RNPrNPVcOop7q5VBmPALzQ1hgneVpi3vcCEX
         wePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650472; x=1780255272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D4fJxXzGfStgadHssCMhfgcT9RTwK+beGIJZOOpamdI=;
        b=X/ZIYquB4/HSJ3rqX/V+eMejTB1ZzksjOq3LqVYPNaWI9+q/1f/6OJ5t5Gfo24xPWu
         rzgAhmQ2pFehTCkiU7wUhmDoC1T2nO87xyTCDFRs88QzIvJXrLjRV69tp+04Pz8rHmuB
         nGtbB4Jm4fajS3/JiqrqAIVW8jKszAKvWD5G8563YCSQ+31YjEZ76oLp5WSR04K6Zwww
         rwqto/621sq5syejbDUHJSnbOA1kXKWL2ERBdW2b0hytZ6bPKQhp9jRQqNl8TsyaDmDJ
         Nk/Y5kQ2vSwHuFhV2T3kvKOA1pT955f2E/dNzbqm3NazE1YRqYzLe892Rc64FQZifnbp
         TZUg==
X-Forwarded-Encrypted: i=1; AFNElJ+AQ/Vb48BlvBUDjAh8NWC737x83DFiBroAWHjz8ry2QMn7hOGqLVJ8djJyqgC9PnaYqYHZb8spiVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQOYdKUDvjt43d7vLdVxlxNsK6vnQyIzGQXKmyaUO9KDBnoi5J
	9gpMrJA1NXKtREPj58eoH4UTnT26BIriYbis7wxX8gQsTIiIhLosKl14
X-Gm-Gg: Acq92OF97s5ABX/T8lE0BOQxsUUq00KDSsE2ehoRW1WSS+BAerwYW08RsRP/NP1Hdyo
	xljyrAJx45r8Te0qQFUOL/CGSrWfp1zisxNw8dACXytTXiUs/74mRa7bFEvITejkT1ltX3V5J6x
	1JbDBXK/H11U2t8B1SMpiANcLUke7BN6L/MD2hljT0WVGK9TeL/GUk3JKjO8MwKrsdMqJUAE/0C
	fE7gQgrAOF99QkMvWy3wA4jRzIuM2A7HiJeUDZUBLfnJmp9tfqGfWMXs9fxr4NlOzSiQG2xOyzK
	fL+hLHIk+aAKBJBM90HulEm0ywo4fB79LhLVB3Me3/L4giRh2Kp7yzVUOhsG/EvGG2pg2z4isK8
	IufhLz9SSfa2an6C3oFV8vs5BXGvEl9mVyRmK0MZRHtNixO9TSjnxD2J36xQIqU3FsiOaAtpw/e
	xUHIH4g3BQgL6hUIx+FjMi8TJUqq2ClOSWbOBP62lzZFkHIrzDKg8tNbwrAbY=
X-Received: by 2002:a05:6a00:8885:20b0:841:89a4:5f86 with SMTP id d2e1a72fcca58-84189a4702dmr2748311b3a.21.1779650471941;
        Sun, 24 May 2026 12:21:11 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164aed7c9sm8689973b3a.13.2026.05.24.12.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:21:11 -0700 (PDT)
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
Subject: [PATCH v4 01/36] iio: hid-sensors: add missing blank line after declarations
Date: Mon, 25 May 2026 00:50:24 +0530
Message-Id: <20260524192059.1193716-2-sanjayembedded@gmail.com>
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

Add a blank line after variable declarations to improve
readability and align with kernel coding style.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
Changes in v4:
- Rectify commit message with input from David
---
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 417c4ab8c1b2..c8ccf96f3d03 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -314,7 +314,9 @@ static int __maybe_unused hid_sensor_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct hid_sensor_common *attrb = iio_device_get_drvdata(indio_dev);
+
 	schedule_work(&attrb->work);
+
 	return 0;
 }
 
@@ -322,6 +324,7 @@ static int __maybe_unused hid_sensor_runtime_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct hid_sensor_common *attrb = iio_device_get_drvdata(indio_dev);
+
 	return _hid_sensor_power_state(attrb, true);
 }
 
-- 
2.34.1

