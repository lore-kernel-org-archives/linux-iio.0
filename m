Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1853D5C38
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167484; cv=none; b=qaSraRlPx4SjSdFDJY1o32E07KM2jqbUmcyO9Xem2XnzrfUlEwYuaoE01SyDdiCfqPwMzDooACHdjGBmfsOD6K5acOO6KVv7rdmpc/WI28z/hk+bTqkc4Gkz95RmW/LoNayf35n0iJywOcGO2BTh3lAUDQakBcblBfviFZZ3KDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167484; c=relaxed/simple;
	bh=jp7dYYoCq1NXnvCr+23gaJk3mfP3XYRhH2j1qXZHUdA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Iao9tDCb1Cst4QrQLL7hEXN2+i4LivOlOzgIXMCq0WPwplKGhZju8H2K7tLOMHzoZRY5SGb8P4O8PoYPoRUIXKm1USvSBSqOl/cIm7ygKR8CgfWnHaOYCKmitqQSXiUCqOpFl0h7DAtQbwj7pAxV/qupChdONSHcvgtytQituy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxsk3E5c; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxsk3E5c"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cc97653887so33386865ad.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 08:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785167483; x=1785772283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dk4NfookR28OdkZMjXT+8GOJcuYrohVmOX6Ibnu5M7o=;
        b=kxsk3E5cZukIYwxF434kDC6Zadbsz1gu3rR6BGFtg4M78ckpCMUQwgVq96YMb8HILc
         Kb5eMpv44OVL3b8nYHG2MYyhqrM+eiHhKdCPBVsyHO5JfG91LK2WCrgDgxb0J5C+qyC2
         j+craRwkgZ6baVQxBdO05Zsy696lDZ06FOkcCc3I3Xf+DJg040p3/qE7UshuDbqz/UkJ
         3+EkBHPU5Mn+LbcNsYPuvnIXF3UYN/l170uiYNamjaa1GOyzSMKdnwKBo2Q0Hypdy2ta
         iNv3gTCTJwYGHkECNQxoLixUu19D9zZynpjTLpMvK5QyVI+9zP4/vKM0JAbS1drnd5QW
         7WWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785167483; x=1785772283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dk4NfookR28OdkZMjXT+8GOJcuYrohVmOX6Ibnu5M7o=;
        b=si4Hd4S22mE4PpW5BkYDtKj0Og6HkLwv/KIS+aNXA6rC9kWsAUMQj5SqPcQeUQMTSP
         KJ7AgjaUxjajMyZ7d9wCkf3RihOHYXmZH1P1dWAV4IX32duTvyQ53TeBThVKuSGJnt6f
         7w9ZmXcBEt+CYRSVPnIEAMOqOdICpgHPJ1Tddfy1A77G0+s6KzA0cGVRgy3zqsMvNyYj
         pAI5fgyPZYPPKXgBbpOO4/xQITvqbcy8m7/EFuVNAzO6b+2wxJpNbZ4j4iP7QXZPtHmA
         YN68lMDK/XoJNMHHccRy7fSu+O6srg3jlsXnSrhYO03yGpMhrza/VcdaLzspuFcvh55s
         znDQ==
X-Forwarded-Encrypted: i=1; AHgh+RopTCG+DvXNIC5fPBJLochn+ABzouHcXqdAfbnOM/Hi8hAk+MrF1+0t5V4f+T/AbgvWUXhFiWluk8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Xp17qINF3oCe2VTUHd7osljwtCoLsSMSk8/riYH+dUTEK3S8
	jG+g/cGEdyWYy0QrfgN4H6pnumLSzHGqAHiojyqgAl1fZ9kDDL7bJ+1B
X-Gm-Gg: AR+sD12oBdKAYxksfJ3DC8AfQb9dp/CdsGTtLlJ9HWgi+p2V53R85UwJrAn1QLZz09g
	1nj0zqYzbYH5dKi2v5CWc/zdSi8H1LmH5W39Ti1JV9445rFYC1kqk9DeETkK10jHOKNNXSFfVd9
	YI1RC+OvxbPgT3RSD9ZxbcB7kpCcxbU6cxAvN4522/rQT2Usa0awqbnHlTvy/6xSsX8UrASHySg
	Ii65Rxm9rYJQmZ2jv5KI0WCamlv9mVGDpsbZdL1jDBniVLmvnN6l1qAzg9UYSP7O1pVqylSaKFa
	jW7kp1EtR4436SuHbbUsac8AJo8g3p8XmZZZXrD1xk7GkUEZsqHbPhXypDX4AO+G2c9dwl/gJJp
	Sn7yTK53QmFNCHhiIbzRjBy0zEI95KKMl74Kixh6YxHX4hdUcbcEeYKC0P+DrOHtAUXmIzMGrN9
	XaTlosK/hxX1NB/F8yShKqyMq5mZfUAA==
X-Received: by 2002:a05:6a21:496:b0:3c3:b226:f165 with SMTP id adf61e73a8af0-3c67e060027mr8904446637.35.1785167482418;
        Mon, 27 Jul 2026 08:51:22 -0700 (PDT)
Received: from SGN-LDSENG.tasernet.com ([2405:4800:5cc3:11a:1ac0:4dff:fe8b:4a69])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc549cacsm33942974eec.16.2026.07.27.08.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 08:51:21 -0700 (PDT)
From: Cong Nguyen <congnt264@gmail.com>
To: Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: srf04: fix pm_runtime handling on probe error path
Date: Mon, 27 Jul 2026 22:51:15 +0700
Message-Id: <20260727155115.1855881-1-congnt264@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When pm_runtime_set_active() fails during probe, the driver logs the
error and unregisters the IIO device, but then falls through and still
calls pm_runtime_enable() before returning the error.

Since probe returns an error, srf04_remove() is never called, so
runtime PM is left enabled without a matching pm_runtime_disable().
This leaks the enable and triggers an "Unbalanced pm_runtime_enable!"
warning on a subsequent bind of the device.

Return the error right after unregistering the IIO device so that
runtime PM is not enabled on the failure path.

Fixes: 2251157b335b ("iio: srf04: add power management feature")
Cc: stable@vger.kernel.org
Signed-off-by: Cong Nguyen <congnt264@gmail.com>
---
 drivers/iio/proximity/srf04.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.c
index e97f9a20ac7a..337938657449 100644
--- a/drivers/iio/proximity/srf04.c
+++ b/drivers/iio/proximity/srf04.c
@@ -331,6 +331,7 @@ static int srf04_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(data->dev, "pm_runtime_set_active: %d\n", ret);
 			iio_device_unregister(indio_dev);
+			return ret;
 		}
 
 		pm_runtime_enable(data->dev);
-- 
2.25.1

