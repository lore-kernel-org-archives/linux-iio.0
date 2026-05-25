Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2613264D9
	for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779722043; cv=none; b=dx5aT1h47yQxtn7SaQemsk90inwDAj3mluGZKEpom4PJ2b7kf3C45c1uT6BTLBuJECkdkuHyNOHQr2VL7cRERBJswMxRx/xxYFgmzv/S9tRAJDVKMcARVO2XH8crfippiAU/55NqxNizxSfx46s0QJ6fkRHpgbsD/iSvk+6NufQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779722043; c=relaxed/simple;
	bh=7sqZyg1A2xVA1HgGImirs66vNVUrFytu6S1Hcz3W8ZY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JR1alGPDunAD93RdxZLscON1/yoXBnW24t+RbsH7bE+z5JzgLJ4H1G0DBPa9n3DH9g6uOjQCUpXkygy0wPkMG5kqIGSvERulZUAGmywqWAqQtofr19CRfz2i+OhlOEKQH797lkMUZ4A5QB6cWySbEC+1uf32USiJxxnGuplOs2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qQK/Lwng; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQK/Lwng"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a8772a67bcso866342e87.3
        for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 08:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779722040; x=1780326840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eadhWtfoA+05BEy4jvSvbjshogoJybOSXbJTjEBAYx4=;
        b=qQK/LwngTAkCNH8NompwwYiE2kOhTH7nTCzvskiLIN9jxJEG6/d3WII9/hXQPxzvaZ
         xQ+GctCry8sDlz6Cg/Z5GHatGlvrm1yj0zxy1HO5ljdx7iehIl7D90Avx4bBw+HUU/0E
         AFHvnx1DjsPFYtstbdDO+cb6T5wFakjEFwbxCgL3RAvLYXvdGpwjE9mhf3rrYGPsUUZw
         tVTotdru4W+K34YnQSiKEVG9I7Ybg2yJ8ern50fkhcx6O5/qb2uJGlOSSjdrvhxRfVky
         xi3Ib18gb3JvO1jx26r+Vh6u18/dM1WtcFqkqiDZNCgti/a4VDW7U13cZ587OFwVSjuE
         sJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779722040; x=1780326840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eadhWtfoA+05BEy4jvSvbjshogoJybOSXbJTjEBAYx4=;
        b=jf6WKbZ72j/FH6OnfR3n5TtZrPRP0bvblGa3CFSag412EQqE5tBM6bDGNRBRQTMkwT
         Q0Hwv5D5Lt7Iw+eeGI4BtOTeNRtobprxPTdbRlud0sQ+SvQ/hy/xM/Bo8O7lh54e8CUq
         0xwjlqOQsvDwqoDGhIjuUm93OVjVCkfw+C8aofXrjkBzXYuvTVvn7Bmuq74A5jZQZgCG
         0Bz8wqzqK+73LjaNG/yu9KWHBQKQCAoN3uNsVg+FuCRtTVQT28mZj0rvlBHMxgYZabC2
         Q2mscLLkfXw9MB3fkQbRTbTORNVAOh3W8gGHZAHo+/1wlpWHd3Us6hwdibeTuOzVUY8S
         4Dbg==
X-Forwarded-Encrypted: i=1; AFNElJ/b4uG7cppQmI9NjraSam+HPFRpSzil/aGjC3NhKHQEY+T7kXB7ze74sKgi7UOjVT1b0poCV1sf9Fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBioUbL4365SYVeUxjh8JIVMaF1ki5SshrqlhL3xkTpRAK0EpU
	aRNBfvMHm9hDc4HkqZoIZ2geN9orgqBZMXcBrVYzwyRdS6HVUdgNdyqt
X-Gm-Gg: Acq92OHu3FUM2XWGIoZh+zNbGyNduKzD9liQcSIFzClZdfg6L/BzLdLLOfzoefEd8Hp
	k/hJtNx0auj8pimeykyxW4AI5zfNvqrYpDaxeTvtVCqFsgOINWxXCB0mvig58FPSNl5YiFGbO08
	xt0SjYj4I+V2fHb4KlpX1e7spUYIy/72txOX+ctHuVkJgZgi/GnhpmeKOVZemI6RhojA9tKvp8s
	XoDapZWQQ3qgKM4JcDPGacIjxofjSLnknhS9OEkvbjqvjgEdIHfBUsdNfGYjF7koBO63qTdUngG
	GiP594W3QLOZ/jRol4+lYNHuJmfDguSLxGZ4UsVXgPHR5Fsncw8y5noRvSHsnF7mfMq5ryPj2e9
	1XJ3v5TDb+s32tQut3N66ec/5yxVfUE6LDt+45F0jxIhMojQYu5dy+6+Ks7/wGLX3T8Xd8TgV5l
	fIJCng/NWTaEqAvQYLxaaUsjqY9qv5WZ/4VSkRPwhRtuIPev5ctoc2KQ4=
X-Received: by 2002:a05:6512:39c4:b0:5a3:ff48:f7fd with SMTP id 2adb3069b0e04-5aa3239c25cmr1936731e87.8.1779722040071;
        Mon, 25 May 2026 08:14:00 -0700 (PDT)
Received: from localhost.localdomain ([94.158.61.193])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa32cbaaf2sm2782192e87.33.2026.05.25.08.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 08:13:59 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: wbg@kernel.org
Cc: patrick.havelange@essensium.com,
	peng.fan@nxp.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andy@kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH v2] counter: ftm-quaddec: use devm_mutex_init()
Date: Mon, 25 May 2026 20:12:40 +0500
Message-Id: <20260525151240.7258-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ftm_quaddec_probe() calls mutex_init() but neither the cleanup
action nor a remove callback issues a matching mutex_destroy(),
which leaks the lock debug state when CONFIG_DEBUG_MUTEXES is
enabled.

Switch to devm_mutex_init() so the mutex is torn down in the same
devm scope it was set up in.

Fixes: a3b9a99980d9 ("counter: add FlexTimer Module Quadrature decoder counter driver")
Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
v2:
- Add Fixes tag and note that the leak only shows up under
  CONFIG_DEBUG_MUTEXES (William, applied from the interrupt-cnt thread)

v1: https://lore.kernel.org/all/20260523184351.7567-1-sozdayvek@gmail.com/

 drivers/counter/ftm-quaddec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
index c47741292..8455f16d6 100644
--- a/drivers/counter/ftm-quaddec.c
+++ b/drivers/counter/ftm-quaddec.c
@@ -292,7 +292,9 @@ static int ftm_quaddec_probe(struct platform_device *pdev)
 	counter->signals = ftm_quaddec_signals;
 	counter->num_signals = ARRAY_SIZE(ftm_quaddec_signals);
 
-	mutex_init(&ftm->ftm_quaddec_mutex);
+	ret = devm_mutex_init(&pdev->dev, &ftm->ftm_quaddec_mutex);
+	if (ret)
+		return ret;
 
 	ftm_quaddec_init(ftm);
 
-- 
2.43.0

