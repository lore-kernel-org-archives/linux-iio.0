Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D85A3033E6
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 19:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650496; cv=none; b=ZzP22/I3Qv9nz28nlM3EGAy4xekdmazghzyST4GdIrOcuwAlePPZJTBvW6gk7QKgw9+3hdrvphCa2GjsJeiBXBibsfLix1CDxbAjKGewPcgRGyQ2uyDxcO4dbTD3J+tH82qOeI5lPIXUSZmhwjBieY9npLI7ckKNftXrPGjUffM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650496; c=relaxed/simple;
	bh=uU2eiFyXTnxuQK4zNACnVAy+a/gOKwty4OvYdhC1GG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RBdXfP1g1dMVHHKWdII/4PiiWh9nSGo2Sz4gWePzLtzZY622NCokTLn3s+R3HJ1BxDMbQo+5phEcNIDfobUPhqbs0xNDfy+sr2Y7nNy6uhuReg48OtSrpeGsJiClDDm56/bzdRz7SB4KWP/Th5EjVmCrCg0Ef9TPSqWt7lrNxsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kW6w0NGy; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kW6w0NGy"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-836ed29d1e5so3935659b3a.2
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 12:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650495; x=1780255295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+gs4epJAJOE0qHD1Os2VxBK03Jh6dC2/iMJV4EcBlM=;
        b=kW6w0NGyUuaZ8r1idtHAMqDQqZzQIZcmNF1NVqRpZh3JmA1dhP7f+rDa5Pg1/4Fk3k
         77UpUHO0iqr9uGMuBXbU+btRAF1mcUYYcuyBolZlHD4JHRacEF74b07aUn6jQIIcqzQ9
         WGQOAIfPCN1v+DSbPwqg2hB6vhXUdMUzChFc851czR0ybhLltRy0UyPSXPHEKsOrHjbu
         Itt1hMYrl3fUl+8zYQvNi6HrSc14Z2fofkDPAZsOSfEjZLdQd+kJ1IXVU3R//gohQL35
         SzWopjejjuqLSnBdaJxS8mfD9g8fF0pSm8inwQHJy8svivxOktqU9FLR86ENP4YYZfFM
         uSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650495; x=1780255295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P+gs4epJAJOE0qHD1Os2VxBK03Jh6dC2/iMJV4EcBlM=;
        b=NDXHd5mCUEBXxSPj8kF0jKzNLVhig16DIQowba//e63iQHJy7K2e1HxLQskpTwpCls
         m8CMoEqkF8iXTw30r7GK++Gn3vafRVfEOWonmvmPZrzEkEaR49YrbWJ1MlufmaRlWEHm
         Jj3Xbtfqz02DSM2L/8sMcC7XSs8o8bPVFg6qF8zzKPbP0/036xFMItvQEjA0dqs60Jcd
         Xg85Fr6ZzjtVMIqRBylg6Hapy37PMRA/Qvw0ZwX9kOSP3vArB8vrCGMsOOP7+f0kr1QD
         hd8KAtHRLez6T2ySopFiDTCKG8VPRuzJPY9qgs5SGJ6xd3jjCy/4fyJAK3FPNiuf17wg
         Drcw==
X-Forwarded-Encrypted: i=1; AFNElJ/FxQ/5E8BR0nGlBtC1uC8QEcl5T2be6zSkzgkTsYmCZFeF2TNP0srne9v1VSUyH0sk03fq4VEUU7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOoANeAhG/H1CcRMfKi714Gcm9feUNIS58a1WKiLf3x9hpgkae
	W/TPZlKUkCWEzcu98ABQa8clkYrAj74o4BlaUs5R5w/G5Xiev/Fz35Fc
X-Gm-Gg: Acq92OFCS6ids9AGWr4xUa5qzwkT2s66vnyyCPD4EqOFPU5ilXQmsmgzSeMjqe/mEIt
	Ylfc1OLPXp04hXiStNDIQukOwtSfX7+Ineac9uoIFWD3MVbFdwEfIpKg7NGV7NzC+vmsdEwrOTK
	IKRBJYFan9rY+QDC/bUMHAT8gh+2ZGx6GIt/q2AViov5SQsg4k/IBvMaOV4VTspnpdXfPGCJCDW
	5LtQWi2q+GyMgfWUfqNgfrHmDyf4qDP60GcPvbXkLUT7/u53hlZ+Otx6tA0WVzPk1X3SfnLLM2g
	L2qWQqgI/VNwrGXzue3O5xQt6CspEN8ouxtRq5ORwjLJrEmFfQNuZnQgMV2nRxj+k3CYa3BQnYL
	OEnMbtOk4gDCClfCG/HR1BfYZaihaWzxcQRwzQ8pMsKKRAmv78bC92pXL4rtzixbLsGJISZg5aw
	GDOCn/v+sV1RtLgz3voxl02ke7QsR9QCDwBqo+S4q+v15ap5Vc
X-Received: by 2002:a05:6a00:180a:b0:81f:4e6a:7276 with SMTP id d2e1a72fcca58-8415f326747mr10650744b3a.14.1779650494774;
        Sun, 24 May 2026 12:21:34 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164aed7c9sm8689973b3a.13.2026.05.24.12.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:21:34 -0700 (PDT)
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
Subject: [PATCH v4 05/36] iio: light: hid-sensor-prox: use u32 instead of unsigned
Date: Mon, 25 May 2026 00:50:28 +0530
Message-Id: <20260524192059.1193716-6-sanjayembedded@gmail.com>
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
 drivers/iio/light/hid-sensor-prox.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index efa904a70d0e..ac55808f161b 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -176,7 +176,7 @@ static const struct iio_info prox_info = {
 
 /* Callback handler to send event after all samples are received and captured */
 static int prox_proc_event(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
@@ -193,7 +193,7 @@ static int prox_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int prox_capture_sample(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				size_t raw_len, char *raw_data,
 				void *priv)
 {
-- 
2.34.1

