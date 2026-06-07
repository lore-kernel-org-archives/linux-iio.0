Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9242EEE7E
	for <linux-iio@vger.kernel.org>; Sun,  7 Jun 2026 13:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780838545; cv=none; b=n56dcwlzfMQXlEkbiuhKsZxsf5+iGKhsuk2oI6QrOQ9cTPphjbugHIGK+S4oUr0u3msSDM+25RTKZCI8GKHJKBgdW5BlGK92QW+3M8ApMJmvsQNv2SWZLm8l/PT9DD0RhxKJ70S6HnOVZlLq3tmaB8r11gHfl3FloomBDzHy8g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780838545; c=relaxed/simple;
	bh=XHFUzIxMyyABgChh9wP7uoBWMWkNHsjsEvwkg5nB3DY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eEG6ogajQOqecwtTo2VS2p7zNhO18RgIgHQ+E9h6VRXI9H8igSzj1L+vXlH3qSFDdEf69NKo7rE+frGZu7gjuCtoXFJJijejMGkihidrpXaJ1oxmw61vAOo7/AH46VC8eeHS3vY9h778Tdc3urrY23QWbUayVg15AYOIvsvoCNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpImdNPR; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpImdNPR"
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-1363e78746eso3565998c88.1
        for <linux-iio@vger.kernel.org>; Sun, 07 Jun 2026 06:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780838543; x=1781443343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qsrZ/dEMbXA0u3pxCWhirM6+dAy0w1EaxAo0wuQ8x4Q=;
        b=DpImdNPRAx+ENzNMmmZZ+Psv8URzZRWZsQ6/tZlpP8A95c3CCJ2HxurmpZQ1EeKZxY
         A4jJLffUGAfQ+IsdXC+FnURvLpAc5RcTITCCDwjQo4dm/SwD1Sl5szc4akyOF00BS4Xz
         vltTCTkSUvqAsoi8wbQOkGpl/PSZ4zkFJ+iYd2UPzzQIzu0qqROjxt9pWQkpuGnldNBv
         s8QLrcSKPOZhAq1K8RVmhSBN6CNDwdJ9vrrgfsPgPCnUHu/gnm/hsjnE/2rppsT0Xf5B
         d+gPIY1T0gLwte/PQfbNDf8QemFcrtj48uUtzgd7lSEqlwxivJSDh2hDPNIyJ7216Ojy
         CAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780838543; x=1781443343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qsrZ/dEMbXA0u3pxCWhirM6+dAy0w1EaxAo0wuQ8x4Q=;
        b=oVbiYTLMjQTVz7Imecq7CpeYYIL009gLim6SwwaflJQjoOv/5yJXEHqCeK+kyI1c3o
         HLoaHlJX96EQX3jea7XS3spzTugGY8iPkYIqGbsWVw6ohIvZYS50FbKsNjG9QoFBQ66R
         5CqFMhd6Eiw90kTCNWTriPYUV7HvBFXxqqN4xWtcrSWP65knW2vyMYixDdGYA3/bb20F
         fvndioLs5J4znK6yNoen/NNeEGLfOXMRErv4LKt7E1ukUKwZj9syHVjSUUtcIpwyBssu
         60tAONwrtzw1ol+u9T9rY7ZuvoV8Og6g6UBisWHirh+GU5hMlder5lDVADVsfBSX3+iD
         hY8w==
X-Forwarded-Encrypted: i=1; AFNElJ9XRDfgFE2Zq4mihbfVoeNVBAKA190iq5Bk7G7UH00xM8ALYTiRFmsklsNoYl7My5mTufS175nheMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLuN9HCDTKG+4uWyoVFTI3Hu4I/cAyLSAOBu7E1R5K5sdJnWaf
	7SqdSvGVRNMZjTT46w02yFGLylNU496IwIMgTcPwBpNvgVr8XMd2BpH0OXK1O+vT
X-Gm-Gg: Acq92OGZXIGydZcVAcPvX3SWfusDL5mjVLzwDWSvXCEhUcU4Ri0/IyDhNtRITA594a7
	o0mO/2kWF84rD+EI6rm5Cg3k6ViazecfpV9KBGPsUQano7nJnWQCcxECbOL9Q1jr2aPnw7/8pLs
	ra/USbxCAzRat2wYYotjyL8XDA0xICj/iAK/V7HtNf4YjSNw0LwlKlAIxD/szbFCsxzf6vkGwvU
	NOOLUxr3dU7jdKJNAvSBZ9DXehwq0gwDzNQTCQw8EpxY314QFvapNAsL0sYKUB+fwVMIdzfQO5s
	dILxXaO4EwGaRR/wM31g1J9bOAAcGeuBbdlRvtbNI1pKPzj9fxdKilPryXuszObMadJW5hdKou7
	5hvxzy92svEoPnMAzrrq6Sdjyw1NLwzewIZWTMAdzq+nVYwWqVEC9qwqPjtH1yC5sO96jbpPNRf
	jJYzMuTFdp9JMTNwBdNKsE09LyIQvEqtnkXxHJojNp+qXKyhoFAwoll9lFDIuUb0tY58RCk3qev
	fre
X-Received: by 2002:a05:7022:6899:b0:137:ee4a:6604 with SMTP id a92af1059eb24-13806683c6bmr5876844c88.5.1780838543004;
        Sun, 07 Jun 2026 06:22:23 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13803eb106esm6639917c88.5.2026.06.07.06.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 06:22:22 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: jagathjog1996@gmail.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] iio: imu: bmi323: use min_t() for watermark limit
Date: Sun,  7 Jun 2026 13:22:00 +0000
Message-Id: <20260607132200.56495-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use min_t(u32, ...) instead of min() with an explicit cast to
match the argument types and address a checkpatch.pl warning.

No functional change intended.

Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 drivers/iio/imu/bmi323/bmi323_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
index f3d499423399..38ad05f9ef58 100644
--- a/drivers/iio/imu/bmi323/bmi323_core.c
+++ b/drivers/iio/imu/bmi323/bmi323_core.c
@@ -1128,7 +1128,7 @@ static int bmi323_set_watermark(struct iio_dev *indio_dev, unsigned int val)
 {
 	struct bmi323_data *data = iio_priv(indio_dev);
 
-	val = min(val, (u32)BMI323_FIFO_FULL_IN_FRAMES);
+	val = min_t(u32, val, BMI323_FIFO_FULL_IN_FRAMES);
 
 	guard(mutex)(&data->mutex);
 	data->watermark = val;
-- 
2.34.1

