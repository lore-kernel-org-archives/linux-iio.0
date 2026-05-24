Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C2530C158
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 19:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650492; cv=none; b=J18MYrLcyM8bgo1xa20O3UkceWWoXwiTrvw4KEX875EogiOZoJtljxqujYUqlPRwClT8+mg4fTkvjIdeRs2H/rtZfhViAqd7TMdi2Y1T+uWbTyRJub7vuTCwM4uEHHUIs6px6IeMyZDwV0/+2NT1zZP/4/S/QEm1DL5QXFiO1Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650492; c=relaxed/simple;
	bh=HGg3t1ABuUnyKpmQ9GOqX/SEfejk+aLEXRhZne2Ykgg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IZ1Enb3AFtBYFdB3LlL+l4G2Jm4vGE+YrRRWIK1qjhO/tJl6TeEqWbirCL/6av6A2Vq+ZASWhvjsCz4mqCrhJ7Hs4irwA3vn+KI+GDNHJsrUW6L5efwcWTyMPbHYuqmc6xe6E72U1oOectmGiZFEzBOBwkL36ZCtUjTbt74IJi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tFKgPljg; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tFKgPljg"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-835b78c3797so3863654b3a.2
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 12:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650490; x=1780255290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXnz3K+XEMe+ecLtNKM811vwRDy8rRojjpiVzVFzOCE=;
        b=tFKgPljguZCClKm/DbcnXWFnUlc1Zf8E/5QL5GtFzcjJY/dw2QK3M9wKILQt2Vii7c
         vVbnp0fKnW9cMGUP6mKydo+fYCeaxzE8eQjQmjwdRjoVweI5qLiQybu/qdFvwEz+Z3FM
         4xzDI+Xve0Dqwmaq4u6vODMlMHGuNsPB4eBxy2R5lRlrwwPvvuoXP+Go/5mQrhnTW8nh
         gTJZs11UjgYIYDE+S9S9MX+2sOPNvVU23uL3TqySaHn+4eG+jIBZ+bBALzThQwxmNFOG
         HPeoyYs+/G//f0e/4N/C5ji2eot24kY2o/9uv15cdseI4b1sz/l+FLbpYM9L+oGW8bi9
         QBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650490; x=1780255290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GXnz3K+XEMe+ecLtNKM811vwRDy8rRojjpiVzVFzOCE=;
        b=e8RqtMFBJ5q7uIELW7wwiT5SEtgowvOdZsKng0Ess2IZjn1/MDbnpBszWHJtTg/HEh
         kXMMPQ8JzFh03CrHGrkNNL999lUtDcYVu1WftT6cdyHG64r+Err+D9xL5+obslnDF8UE
         OsrAK15d/C5Yx2fu4kdixBzK6BOAir98dH88+31m0UivpZlCxPj2bEBzRxVet2hPVjM8
         DLIsQu1/QQAcLZLQfkxKFmcF5V9Xk1JK9RCQ8h3a0UKOP9cvKyzGKKox3X0rVGqylXH/
         eH6d+4LHqaqxgistF+RPJdQ579V8bAsgAxhi7z2NeXLeff/bCGMfEJIi5JLW7i6aWRkF
         sCpg==
X-Forwarded-Encrypted: i=1; AFNElJ92mSleB7VDnBFo2m8A5c1SzxbgFzI9/2Rui3ykIaZIJaAp31XOLex3l0m9WJNjqT8rSDRGE0V7kTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Zks6WgDK37lR5i6wljkNfJnpkacpG6E6Lz4VJvKuLEQIeVgO
	Cle/rkw0/McPJLiJQ/xIqEsr1rGBRcm50Wic9aPJ6f+gesB3DcIxtI4CnWjn9A==
X-Gm-Gg: Acq92OE1zPRydifPJFNLeaUbNixVjcuj2UM9kVbRtwIezgHddrerJhrmN/5sNNlooXC
	lOXHhKO2/3QFd5IrsVSDbX/5+ayPEJFyLYJQ8Pz+ag/Pc0Cd+gzORwEsrwFa/ZUYb+xjTTK+WMx
	V6x8cZStHSnBosKp/et+TQ+b5G3SPuBOGUp+rXDmPFnVKbuujwb/JTeQa27D0z56CGuXQHqYswe
	FQcKSZuDurA8eAoiMtmcHPHR6In/vD8z7zhoBGd24IVTLWEh/cEGKM987C8T2Bvfw9ufpIjf4T6
	oOthMriW4hn63HhkrwsR7HTVAJOU6R7efMa0WMPbIXFsyluZIwno7JqjMKPokOtW1r/3a1M1VIq
	G5H7/Fz1jc+hfSr8FPP4VCd+tbfnHdS2j0J6aqDYgarVkZlsj5OXLqcPcGZEgnfoDkQQDBFWvEn
	Fiha22XiYMqWHYlXKSwyGHCV9vglF+KRUg6dElfkvsxufjJzhi
X-Received: by 2002:a05:6a00:180a:b0:835:405a:7e72 with SMTP id d2e1a72fcca58-8415f141d5fmr10711033b3a.11.1779650490485;
        Sun, 24 May 2026 12:21:30 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164aed7c9sm8689973b3a.13.2026.05.24.12.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:21:28 -0700 (PDT)
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
Subject: [PATCH v4 04/36] iio: light: hid-sensor-als: use u32 instead of unsigned
Date: Mon, 25 May 2026 00:50:27 +0530
Message-Id: <20260524192059.1193716-5-sanjayembedded@gmail.com>
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
 drivers/iio/light/hid-sensor-als.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 384572844162..ac654b2bbc1b 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -251,7 +251,7 @@ static const struct iio_info als_info = {
 
 /* Callback handler to send event after all samples are received and captured */
 static int als_proc_event(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
@@ -273,7 +273,7 @@ static int als_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				size_t raw_len, char *raw_data,
 				void *priv)
 {
@@ -315,7 +315,7 @@ static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
 /* Parse report which is specific to an usage id*/
 static int als_parse_report(struct platform_device *pdev,
 				struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				struct als_state *st)
 {
 	struct iio_chan_spec *channels;
-- 
2.34.1

