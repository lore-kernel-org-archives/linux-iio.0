Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA9E401480
	for <linux-iio@vger.kernel.org>; Sat, 28 Feb 2026 19:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772306141; cv=none; b=RQ09W6HoWk5uxIVh1F6KD2TgQ5MLApls1F4cwiMc2WkwC/sBphjsxg+h9CRCLhUU4eO5qslGMwcHgLfK3LqVDE6kFT9WPiQ8U1O39EMMNuMld2kuMegBhfNdc5SAEwuy0LaRMNlHCMixtu3J703VtywnYSr9pDY2uIHQStIKzuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772306141; c=relaxed/simple;
	bh=RaHWcaTGquYjBjkFXqSWHYS4JWm8jPuCNNkiQhCR/zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LGsYwOjHI86DxTiyiqqme/4zpKUuR5vO6rM2MQBaogD3ayK9u6FC3e+ung3i4c1SyqGcR9fKUVxb0+CpzZIdbRoV3TeUr3c1z2Hi5pow9lxvJQeGB7GSjEc6EsnFnKXrG4F30y4ckxJK9GC7rmz3i9CsgooH3IeOkhnLtLb1SO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNtBaXnn; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNtBaXnn"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-827390e8a3cso2094600b3a.0
        for <linux-iio@vger.kernel.org>; Sat, 28 Feb 2026 11:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772306137; x=1772910937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrjN8Am9nPkuoa8HBafNNHI41p4l7h9p4EeDz+6g2vw=;
        b=nNtBaXnn3Gw6ROSGPrVyXkeO3d0ULKG9kKU952f2VvQmADWAZSwMrM3sBNLs00R2bY
         33Cl0Vngi57H8oGG8XDWE6F2XJcsyBgdXDhZ3Ad41aWCa9EzgK8bQNEJ7xc/2LnDcIfD
         wkE0ACDw3G4e1lyzjSg3MbAkbCgmYSConK4KJf0HMU8CdrkNe5NjKtl5+kkvBfMFxpBu
         au5iFQKIIaJqZzPHZXVPSgASOCdAnR9JQf+B4viQiCrKi35GVp2os2/bTaNmouTT6MyE
         WJE1myhYa+CH8Ap7hUWdLjUVqRLPZsEDUisS0aHSBNpdsZPObOncQYMwNO4oRuqKwXHe
         +gLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772306137; x=1772910937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TrjN8Am9nPkuoa8HBafNNHI41p4l7h9p4EeDz+6g2vw=;
        b=s3rmNart169YOcirfhooUAwGiSMzm2pEcgIVNJ7X65JhvAs/fVwhvx4tCLQLeHAbCf
         Pa6LrNE+Y34Sgl7gm1s6UOcEHxPXAZXzPlDAn21l/SRQSzfyckE9cY9pGsxB7Gb9dMp2
         3L8yMIZRT9l7343SkRnTF91yfFiuP8ahcofvOxbWEqhosnKkFXbGYJXvQZ3sSYXRQClg
         HrKQaLoc1Hbqcm0q3PX7HJh6oZPRvGJPu8a2ImEGxvjmyK/rwpKtY4mMUkJkri/Ieq2E
         U5h8LWzd9g5keY0fie+751IRdfvC/v+OHjP0bXS4jGDuKSe+PeT3GEeiKwVksTgkMIui
         DM9A==
X-Forwarded-Encrypted: i=1; AJvYcCVSWPBZ8ABGNyuXyIXAjsFJ9EsSfWzk8RmbABgVnuUo5Yjb20TqGdqd9c/5W+Yi3tx3AOAiQNNB9+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMtgtpd/Pbm+Ddw+7cDQvw7/CvGfj8nkObvmh/rKdEv9NLi4Nc
	EkbizdepRmXgt5iRqPv2B3A/u+s2sXKoqsT1x4UgQmN9jHhSEVlO9P3s
X-Gm-Gg: ATEYQzztAAQ3T9xJTPhfYy9wAPhecYnHtXr8y7Ctk6/xrf9JqQj53lY7RC1W5moV3Xx
	gl+bFWpiDZt9Mhc2GPLIeWXLKTTuK4q/d7C5xF+J/MG3Xe0jWsN7pLjfinl0fZot2Ir0e4Cl945
	hSOXzPUWKBgYWqLut5XklWGEKK7YP5d7MOHEPGDIcJH/aAvDe31dITc2ZEdtpjrUmprq1zEdfg1
	JHu7qSk1olQMpaEVE4U8cxs2YDUUHhPEpPlYWM9SwMbJxBsqsH/ocMv35zq2BLLh9LSevXdIC/i
	Ry/qbgGM9+CfZ6VLgqzKcLnWKYHYRdTr4XaMepVUKADojybXwn0GMRoIXmga8YhQ//4oapWw2LI
	M3+NhqPh/Xe6JzewPiF7YjKv6sAOpNKkp0xCLKYIXJe/aDy/dNBwMD7ClDQ141YKwGHZ2BM801p
	OVttt2pl3bS4D0MdXSnO0ChCHl
X-Received: by 2002:a05:6a00:3685:b0:824:3d5b:3cd3 with SMTP id d2e1a72fcca58-8274d9dae20mr6737395b3a.0.1772306137308;
        Sat, 28 Feb 2026 11:15:37 -0800 (PST)
Received: from arch ([2409:40c2:5057:a20e:20e0:a4e3:da85:ffd2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d4c910sm8327918b3a.8.2026.02.28.11.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 11:15:36 -0800 (PST)
From: Bhargav Joshi <rougueprince47@gmail.com>
To: jikos@kernel.org,
	srinivas.pandruvada@linux.intel.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rougueprince47@gmail.com,
	linux-input@vger.kernel.org
Subject: [PATCH 2/2] iio: hid-sensor-gyro-3d: fix typo in array name
Date: Sun,  1 Mar 2026 00:44:00 +0530
Message-ID: <20260228191400.19244-3-rougueprince47@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260228191400.19244-1-rougueprince47@gmail.com>
References: <20260228191400.19244-1-rougueprince47@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The array 'gryo_3d_sensitivity_addresses' has a clear spelling mistake
in its prefix. Rename it to 'gyro_3d_sensitivity_addresses' to correctly
match the naming convention.

Signed-off-by: Bhargav Joshi <rougueprince47@gmail.com>
---
 drivers/iio/gyro/hid-sensor-gyro-3d.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index 8e3628cd8529..4f88fe478d84 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -42,7 +42,7 @@ static const u32 gyro_3d_addresses[GYRO_3D_CHANNEL_MAX] = {
 	HID_USAGE_SENSOR_ANGL_VELOCITY_Z_AXIS
 };
 
-static const u32 gryo_3d_sensitivity_addresses[] = {
+static const u32 gyro_3d_sensitivity_addresses[] = {
 	HID_USAGE_SENSOR_DATA_ANGL_VELOCITY,
 };
 
@@ -297,8 +297,8 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
 	ret = hid_sensor_parse_common_attributes(hsdev,
 						HID_USAGE_SENSOR_GYRO_3D,
 						&gyro_state->common_attributes,
-						gryo_3d_sensitivity_addresses,
-						ARRAY_SIZE(gryo_3d_sensitivity_addresses));
+						gyro_3d_sensitivity_addresses,
+						ARRAY_SIZE(gyro_3d_sensitivity_addresses));
 	if (ret) {
 		dev_err(&pdev->dev, "failed to setup common attributes\n");
 		return ret;
-- 
2.53.0

