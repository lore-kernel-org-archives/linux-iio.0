Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2963B95EB
	for <linux-iio@vger.kernel.org>; Sat,  8 Aug 2026 09:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786179681; cv=none; b=n3G0KJ0OiWh8pfy4uzYd8dLdUhSKOWMu4xrXhgjnGBwCUeMAh6wl9unxQ6sf08YhfMvU5lxrxCtFgZLyQHF35jfxjyj56Gn8cuIzJYDmt2whNc8v9qAsb4vYuyYOpnHjpVk38FvfjzhZlFGjZYuhNr4fXG4k7BFIlugD8nmlwN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786179681; c=relaxed/simple;
	bh=qk/kOYORym5I+8ya8cWHEEAmCjE1vOB3NM+RASUrorQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LoNlIevrFHmGgxIjaEgyAN2Duk5mlLpzqbtBrGO/AYRhrS7do/TTeiM03t8MPyHNSZMw/EVUUxy7jJaPEQChBgi9l0R3rxKSsK8r8k9/IlBRBEzhtvgF2rQ4nVWfdBTb4bnNZFjscdslivnhh3yJIe0QF7qSlp1nDJBoUSyIqC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDescYPP; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDescYPP"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-ca957432c7fso297183a12.1
        for <linux-iio@vger.kernel.org>; Sat, 08 Aug 2026 02:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786179677; x=1786784477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v1Lu5z40VaFQBmnLoOwaqvwm+6VvtbjWSO8Fgi8tuuA=;
        b=SDescYPPwBEsuUEofEc07fwUzF8NI8m/CaSOQbp5VAfiFHV+Ur5jub08T2kP9wqoJd
         /qBCZBqLH9/7/THmPJxLSBZXB078o0u55YDX/WxfoMILAYg0DpZzSW+TQxPG25m4tgWp
         sfi3D8fgFOKASS/VU8an/JNCCWI1az+dJfHLaR16VcndGbGHWak/W9e0k+MujkACr/op
         pXucNoJ+i0Gj1wdIRZwXyac5Sv4wdmVdmlVZb6v2zcLyJTWswaPCC2o0o5JW3wb3hjtR
         Y6po729K+U/AB8Dg8xygZ0rAQg/I8Y7B4Ia0dNz7W3RVs1W+vWp4T26V9tskJQCW+pL7
         8waA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786179677; x=1786784477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v1Lu5z40VaFQBmnLoOwaqvwm+6VvtbjWSO8Fgi8tuuA=;
        b=JStxDc+V5YqPIu6yNgAS16/jxct/i2zsZ4BjYVxoF0Y+oZd5ztOkL6JZkmZEcEdnyM
         rv8BMHm9RzSj8pLAuxBYuRiYDzSBgNsQ+B6mKe4LsVhp+BJISxq5ubSaNuKGSJPlHqik
         O/EnLcI3+E0HSM7f4VbipAQSTGMmhlJ2IHPu0Rc9DmhvMDW7ULf/fpPVB2ZmjSu99klf
         IwBoLKudIypGEy4FyUMpJSTuuNJtOItlJTj9zUsTpZHCLU+I/NC24NfxVhlj4fxPxv0n
         mTWBBMcE/iOv/syZKl+hBb8WZTFWyJKpRvr7C6iODW5JAEveUsXMIHcU8ICrOJcykH6f
         KZRQ==
X-Forwarded-Encrypted: i=1; AHgh+Rql0NmBOw9beyPAKiwqsjCiO+e52ZvjKTZY/wZWIU4FsHwy+eeUoLP8xgKrdQhVXtPq5+NUXuEIjCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWe43bfdPCG2laQ720/4W6KIs3oSO1CGqoGF9TWXLm8x8qfzfs
	IO7pQbGZnOUDWrGQaUVykrCRhPqVxErgODVEk169fTLh8xNErqMoi4BI
X-Gm-Gg: AR+sD12M35K/kUL9rr3VOL5h6KFzqm9eUPmzw8ZY11WpSDVW8w54UXnu4NVLtbG8aBV
	sbeqUcWvI0atqLwVjoXGr8ivC7BonRRZhvI8PgrzmfoS9Pvg/Lc5zBPvh+XEs8S4T2+sz86zOFL
	4L4YIXNQNy80F4UO0ksmL0oTr1rmwchD02W/t1E6coWznF5LesvgYmfGDqN7vkxDKjyU4fm0olA
	xo9spm0BlebPXU1Dpt4OEXbrjoc4BiVDVTApMQZiExlNdkFzptAmsW1Fy9sOZnazlkMaIT19ZPQ
	qyEFL9fLky6IJEpC+zUKNTXzpP4qR7fV91KKOxSvbGLvx822g6N1GCANF2Du0iRi8h4urLsJnme
	azqEflqTF3g06cUcPowyi6QdsWiHF9kEl5eu6kqtdqNTlIEDup3p2/QxHCQex8tqVh0ClmrAt5z
	itnb9TGLP8vLhIcK5HXPcFUfwXr5/Rwnf8fZWXPHtbvZrxp9Iqex8iPZMQLjtd4pVNesWmDNhgp
	eOVmxDLNDMBbiP4FWpMgM28hktZCAvCgq56W+M5jNbJWwzVY8md12UMTjV/cw==
X-Received: by 2002:a05:6a00:1daa:b0:846:8b21:6304 with SMTP id d2e1a72fcca58-84f2dfd2c03mr32330956b3a.14.1786179677117;
        Sat, 08 Aug 2026 02:01:17 -0700 (PDT)
Received: from debian13.localdomain (bb219-75-96-14.singnet.com.sg. [219.75.96.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a51e9f0sm1973871b3a.28.2026.08.08.02.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 02:01:16 -0700 (PDT)
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
Subject: [PATCH 5/5] iio: humidity: hts221: fix division by zero in calibration parsing
Date: Sat,  8 Aug 2026 17:00:26 +0800
Message-ID: <20260808090026.34187-6-adinata.softwareengineer@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260808090026.34187-1-adinata.softwareengineer@gmail.com>
References: <20260808090026.34187-1-adinata.softwareengineer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hts221_parse_rh_caldata() and hts221_parse_temp_caldata() divide by
(cal_x1 - cal_x0) without checking that the two calibration points
differ can cause division by zero.

Reject zero divisor with -EINVAL, logging the offending calibration
values. A device with such calibration data cannot produce meaningful
scale or offset values anyway.

Signed-off-by: Adi Nata <adinata.softwareengineer@gmail.com>
---
 drivers/iio/humidity/hts221_core.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
index 313c80df3f6e..fd11cc881dbf 100644
--- a/drivers/iio/humidity/hts221_core.c
+++ b/drivers/iio/humidity/hts221_core.c
@@ -276,10 +276,20 @@ static int hts221_parse_temp_caldata(struct hts221_hw *hw)
 		return err;
 	cal_x1 = le16_to_cpu(val);
 
+	if (cal_x1 == cal_x0)
+		return dev_err_probe(hw->dev, -EINVAL,
+				     "invalid temperature calibration points (x0 %d, x1 %d)\n",
+				     cal_x0, cal_x1);
+
 	slope = &hw->sensors[HTS221_SENSOR_T].slope;
 	b_gen = &hw->sensors[HTS221_SENSOR_T].b_gen;
 
 	*slope = ((cal_y1 - cal_y0) * 8000) / (cal_x1 - cal_x0);
+	if (!*slope)
+		return dev_err_probe(hw->dev, -EINVAL,
+				     "invalid temperature calibration slope (y0 %d, y1 %d)\n",
+				     cal_y0, cal_y1);
+
 	*b_gen = (((s32)cal_x1 * cal_y0 - (s32)cal_x0 * cal_y1) * 1000) /
 		 (cal_x1 - cal_x0);
 	*b_gen *= 8;
@@ -315,10 +325,20 @@ static int hts221_parse_rh_caldata(struct hts221_hw *hw)
 		return err;
 	cal_x1 = le16_to_cpu(val);
 
+	if (cal_x1 == cal_x0)
+		return dev_err_probe(hw->dev, -EINVAL,
+				     "invalid rh calibration points (x0 %d, x1 %d)\n",
+				     cal_x0, cal_x1);
+
 	slope = &hw->sensors[HTS221_SENSOR_H].slope;
 	b_gen = &hw->sensors[HTS221_SENSOR_H].b_gen;
 
 	*slope = ((cal_y1 - cal_y0) * 8000) / (cal_x1 - cal_x0);
+	if (!*slope)
+		return dev_err_probe(hw->dev, -EINVAL,
+				     "invalid rh calibration slope (y0 %d, y1 %d)\n",
+				     cal_y0, cal_y1);
+
 	*b_gen = (((s32)cal_x1 * cal_y0 - (s32)cal_x0 * cal_y1) * 1000) /
 		 (cal_x1 - cal_x0);
 	*b_gen *= 8;
-- 
2.47.3

