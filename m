Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF2130E0F8
	for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 01:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779846070; cv=none; b=q+gPR5mFxbQ/45E0NWU8JS38VQvbdzivK32BrS5hLg01jC5ec4g8o8zlNjJm1VxmYdxTKN5zaZROeqPCxxkqiC3L6e1wSE/buWxf0gZoIbNR89+3J+elOFpeKFJhX9IOfG6qML9ljIfRHfIHwofmYBsnf1ufrviv3Ur1H7P6vow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779846070; c=relaxed/simple;
	bh=nXG00qI4jbRkiq1UNzqhNcbG8PzRvXDO1LwaoONKdlw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=au//WnjbMiDa7PZCBVYdOlpzbq9H1ee0uYmd9bgBs7VtoE/mnZmH++R3eIfVRt9hLsXZ9j04FF6rR0R3EGhOelVisuYWy/t3i1YH+CiJKhlwrURjgBDaO8ewEXFVmGsTaX0YHGU+uXggiyZTkp4Z/nQJ/RHlpXf138G1r9FTYJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4gn/PY4; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4gn/PY4"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5751b7d147aso4119761e0c.2
        for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 18:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779846068; x=1780450868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+obQ+QMObdWoIY0dkdCGKByIrij2b20AJF6FCBoa2Rw=;
        b=f4gn/PY4rKuiRcbvGGn+W6xmS2wq1uhqH4LtAl1d24bh7EBnXwDayCx/y80hH5VkeX
         HwzhAJr98dzmwKknapzn+gxyBjedbyxo0p/Q+JKkn5ig+hzKvUraRtCB+BNFmOawjiQG
         IwDrtVzYCQtc4Es3AHDCzLb6QfbEc9umIpv9nziYT2v9ru5PysKlOAiqui+iZIrAhPil
         5nO2UGz5sZHm13ANdOTnoAhRQNgeymRj5Y18t4tuHXYBZY1lvijadmpNIoV1nS6bw5aA
         6UphRZfOoQR3Q32jr4oWVB3zvTAV7MWhypP0w1W5hz2i7uTj7fIA8eVBWssD/rq9MK1L
         05iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779846068; x=1780450868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+obQ+QMObdWoIY0dkdCGKByIrij2b20AJF6FCBoa2Rw=;
        b=C6LWvlZcJD+8ukJ8MH8c22RmLFfxyEBpE12PzE+V3ZghRXjyUCeu430Cl+MN/sgbQP
         eTNymzdOVp1Kwbj37kfS7dALXfg+xwx+g6344nhqW0VxhfWDSjo3pSP6OVhC1Tdl/Fmk
         sidKKp2WewrvWoLU4A6j/yyrYzpMtoIiP7xNMK9FiAWkvseiKZt0r63oKm7eTeUEMzF6
         xkLK52TqKqvP4I28s31eevWUKfHdJWo/xT1GZvZQjw7HU1hUoIOOLacjxYQr1XPfREt7
         aNyEBr2310ljz8WyotRmkLKE5oEdCPUquzxseo3DQfFXJnhD0nx4vbo3hNOg7q9MCihE
         GO4A==
X-Forwarded-Encrypted: i=1; AFNElJ9YsZlifJzUiwrd8d1B4/JIp8sypXlBjcoufoHw3VSHb37mtIdYoeI23BMTn9JgCTLOcDcroD5/kg0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza80yutxZB4DCHieDrXEvzAvNq/f9SsSiilBy/wZQemilOUDXt
	imNeFX91Ix6no6jz0o6t8fJEA1nHg34cLf32ctNBeAMB2dmGuACjIzqe
X-Gm-Gg: Acq92OF6e/CU1Lp9oIN2xw5oAJmcpbpAkcVwZphVyPU3mbRuLA6yD9sZSPb+pZ0sZFG
	bkOnxUWnH7fa2CeuJHs+0jAyviK2QXBWi3G/MxGLQWlJ3TMrhxPCAOmWg0SmGTreKYaOYV9wWZt
	2B5a59wuaBCbEFqDzoVfktQi5Pfbbv0Y7XfNHL239EBfjOOZizFxOMqd897z75exnb88PLnA+3f
	KSOBl+RINw0uq4mE6mTmRDjYTRwkPveDAkbSOBbDXVx3Nqjwu/f37/YQDyy7qJBDuCr2yO/aYkv
	BbHzcPbEFgBuffAD+ex/sNZZigS/bzuorYv09CHEaumj/qdWIeqWS0aGdMLdix38f1bT+/YQe/v
	UqMfxtdzVvi0MyHFnz75YmGzOOI7bpB03jdUD/0jjJgv6P8sfo6iDO8VcJfWkkORe2c16fwojZu
	TIog6JGHkFsjYH8/0rS8a+c0wi/1xGEllDLNjtjFu3IlT7AHhi0cQLMJdmqkKPdUQAwHhQxI4kT
	dA=
X-Received: by 2002:a05:6122:ca1:b0:575:3b34:28b6 with SMTP id 71dfb90a1353d-586624cee61mr10386614e0c.11.1779846068065;
        Tue, 26 May 2026 18:41:08 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:82a2:730:757b:d7ca:355])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-586f2f791d1sm18491348e0c.5.2026.05.26.18.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 18:41:07 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-kernel-mentees@lists.linux.dev,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] iio: adc: spear_adc: sort and clean up headers for IWYU
Date: Tue, 26 May 2026 22:36:38 -0300
Message-ID: <20260527014058.35265-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is sorting existing includes and then cleaning up unused
headers as well as adding new ones to follow the IWYU principle.
---
Hi, all, 

Creating a series as suggested at v3, no functional change.
Tks and regards.

Changelog:
v4: split into two patches as requested by reviewer
v3: https://lore.kernel.org/all/20260324221313.119473-1-rodrigo.gobbi.7@gmail.com/
v2: https://lore.kernel.org/all/20251206132120.11059-1-rodrigo.gobbi.7@gmail.com/
v1: https://lore.kernel.org/all/20251009182636.187026-1-rodrigo.gobbi.7@gmail.com/

---
Rodrigo Gobbi (2):
  iio: adc: spear_adc: sort includes alphabetically
  iio: adc: spear_adc: Align headers with IWYU principle

 drivers/iio/adc/spear_adc.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

-- 
2.48.1

