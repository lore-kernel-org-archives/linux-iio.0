Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02111208961
	for <linux-iio@vger.kernel.org>; Mon,  2 Feb 2026 07:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770018076; cv=none; b=ciPjXS/au06jVwGFF5BwgDrPOuwrhU67DVjaqyfoeQuy1ItBkm5VYAlPLgS104EbGtRN8kPJbFqmkY177fMJTz/f/P4Wfu/2Lig7mv8RVPrDXnGJKr8WPeb6ccdRUlFvcEj0SUoz9sM6Fqpca+7s9T14McWMDpv6dXfeChNXFsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770018076; c=relaxed/simple;
	bh=pzz/JBzBg3f9XU0JcyAwWBdi4oIU4sKgoV3HmdZjLXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VO6wUiUEzdffEz/EfHqRkGVyKXfXn7X+GzZil+n0B33wOjcEB2xTV3NEncD74/xg5C6fz3BFE/bqaFwxAhDzOz5tANW5REBeL3cwq1wgLAQXKueZSUuca9S6mqkC8GwPhROFfmU4qH/ZlsjeQSbHt9LMj7eqprQNQ3fD8DX49gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KpL/VgPQ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpL/VgPQ"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4801eb2c0a5so39490405e9.3
        for <linux-iio@vger.kernel.org>; Sun, 01 Feb 2026 23:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770018073; x=1770622873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HoxUZLsQeBIQDd5f6nNmuNArij5mh0WW2KR678veF/U=;
        b=KpL/VgPQMnuR1Gb0VjpAne/74coHJlgfHGZkgG1oiRU+aNoeYSm8qjg4nn+GTu1d9Y
         r1PZnC6Dodcyis8qlCFTp3CqrjEwwwwODglBwl2CETkdTC3Ery2T16KNfSD3DbVed/cB
         /6Ur0u/ycByIOYOLb3xuGQU1hmT5fTWAxxBMR5LEw3Zlt7x8RkpiUFoYFOq5G9gzLtWp
         mTBifDOojrGlyg9FWHlOYT12wVwLfi90J5HlgxOyi2KJW3vKKEa77n0TcMF7j2PVFD33
         eVp3LhbJWnI0Xz/pw396RAs7o6ZOXkkx3im5NnIaa0JFN/UbzIwNsvwDo6GhRBEC0lTJ
         N48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770018073; x=1770622873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HoxUZLsQeBIQDd5f6nNmuNArij5mh0WW2KR678veF/U=;
        b=Ie+hOjDU35ciMdDP/gXjP+jLbPeGm2fWZ3x+YsbpFJv4SjiMrwGn9gq5Ct7w1KnoJl
         sFe/Aghfut/H1YIPMRHA5b0c/noqI9G1X8IO2DEL9VAG2XP7V0XPzDIZgVS/o0kZtMnh
         2iVcqfXOEufU1gcQYZXLQRnMBAsEUxA3//HLV48M7WZBI/DVdJJpydlKMkEkrGLXJR73
         iGDPjt5E8oKYH8vC4AoQVXBsuVT8LfjYR4q6Cl9DSdc1yFtZFa25Q10ucgbIVX6o1FwY
         OIZtWwvWoU3O1rctmjcND9idJ1ecKW2+4G1Z+CDeykUR40MCZgp4kLD+e5yKMGCWKV2L
         ZRhw==
X-Gm-Message-State: AOJu0YzVtZ8ujZiLzvoNZSD/RbHahKcZ6Lm3aMEh8B8EYi8JNVqPcSvw
	NZV0rTHrW1dllyoFQA6uq6+I0ul7BOJ4gk3qN8sdNKz8Y6w+FoBNF4Xk
X-Gm-Gg: AZuq6aKAVQWYzk9SVl1AAlHVOrA8DwbIzVZq5BtWcQiSLQZcPCVdotKjbiMBtDcd1HU
	aehjXvqfkSgGMCMCCKdj5w7GM7UJhsddCrsn4DajiUU0j0y2JigQSo23KHP5DmjevOGBJYGbEvf
	xpI6gksSLHJWQ/NlrrNRyWtcIzYuZTyhTC3qfEt9lEe/hzp+FmPvkUj0fG9Q0usGk1PQkZFTYwa
	gh7hTJ8dfDcWlsG+OG2p9uZBAECgxS2YaJWkHw2sfhge87p0/vpXQr0shW3CRglYIWGMl4nS/8O
	2C+memMN6mcRP3b2Rf2HE4uCxc6vJuz3wQVVczFpJ0qzBzM2MsLvJrqz1Fu11l4zGWUHYJqef3a
	PsJkju2D9PanlmLQY5zIF6pS17Vta//LoeWpCb4HkIOqgHahqNKnUmHRspqXE7CUaAqGbWQ9wAg
	eH1gfGzdnvu08ou1hRdRjajQikUpKitNFSD6bQi/eL8fEn+74kMSQ6RHb24plg
X-Received: by 2002:a05:600c:530f:b0:47d:3690:7490 with SMTP id 5b1f17b1804b1-482db45ba1cmr134425985e9.9.1770018073043;
        Sun, 01 Feb 2026 23:41:13 -0800 (PST)
Received: from chris-laptop.home.arpa ([2a0e:1d47:c905:1800:430e:2fc9:45d7:5180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cdd79c7sm392243675e9.2.2026.02.01.23.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 23:41:12 -0800 (PST)
From: Chris Spencer <spencercw@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vassilisamir@gmail.com,
	Chris Spencer <spencercw@gmail.com>
Subject: [PATCH] iio: chemical: bme680: Fix measurement wait duration calculation
Date: Mon,  2 Feb 2026 07:38:42 +0000
Message-ID: <20260202073843.11225-1-spencercw@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function refers to the Bosch BME680 API as the source of the
calculation, but one of the constants does not match the Bosch
implementation. This appears to be a simple transposition of two digits,
resulting in a wait time that is too short. This can cause the following
'device measurement cycle incomplete' check to occasionally fail.

Fixes: 4241665e6ea0 ("iio: chemical: bme680: Fix sensor data read operation")
Link: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L521
Signed-off-by: Chris Spencer <spencercw@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 70f81c4a96ba..24e0b59e2fdf 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -613,7 +613,7 @@ static int bme680_wait_for_eoc(struct bme680_data *data)
 	 * + heater duration
 	 */
 	int wait_eoc_us = ((data->oversampling_temp + data->oversampling_press +
-			   data->oversampling_humid) * 1936) + (477 * 4) +
+			   data->oversampling_humid) * 1963) + (477 * 4) +
 			   (477 * 5) + 1000 + (data->heater_dur * 1000);
 
 	fsleep(wait_eoc_us);
-- 
2.43.0

