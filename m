Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AA234B661
	for <linux-iio@vger.kernel.org>; Thu, 22 Jan 2026 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769093806; cv=none; b=mro8a4FQcF7sJaSHcPR4FkdO6p1manGbJqbIGtr26j5i98V7JuJdPYs8p3TmMOPprWU6zLjS/dupLS2eU66XOYsw8KWJOexnIUl3TSDqWfSrM6eZlLSxUKJ4+WE+5hMnii0uOJbC3eG6vlWuSQ705uH1cN1abOOfINof9ymBZ4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769093806; c=relaxed/simple;
	bh=YcwchRL3dmquMNXp0MXiCoLQ/zmWnbBjTfaHSzYtjL0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Sy83LOGXD2PphdlIHqVXLyAjg+QleBH4i+6z4cg53NtV811tChDjie7iSVgVdpkShaYcUR25A6o54Pfz0GHR9NTn+YnU0LPkYtm6s+MzvbN1aa5mjFZmDpcSLofSQEzBbfdwhBfmKcHsb2r5q6rR+4OAW6+FRVzoIkEDPNRWjfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btD02vTg; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btD02vTg"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-82311f4070cso147283b3a.0
        for <linux-iio@vger.kernel.org>; Thu, 22 Jan 2026 06:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769093804; x=1769698604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rP4Md871BpNzoliM2Q93M6GSwYNDmOpzKTl/uPt8x+I=;
        b=btD02vTgWzC1fb/6tAELT5wJHQcX5BlcMagVsi81bIJ3GxkSDOMw5HfCl/2M9SNC8a
         pDJ5g78bltTM+msuG+hjpc8lFijF3Av/SHsDPTPD7uxudUWgWSCs0vnBkjsCyod2R/iq
         B57mFpC5wLy57VtEgK+U0PCiahQ03IlIkp8bOyujNsbpmtK79anB+Qs9uaaM2J9i++Lu
         LiSYQ7C8V88yVh+Z2Z1/2z8iUCAzY+b+BsMk3dJNgo4vXF4Ah7XQ+5nywK2I4NTAwyl/
         MQL+xNf7uGGg6VQeXtgITCjzvC3bKfAaBfGlntVR7yiL3PN8UfdBUMq8lAEyZQKfJS1e
         tHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769093804; x=1769698604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rP4Md871BpNzoliM2Q93M6GSwYNDmOpzKTl/uPt8x+I=;
        b=kbBiY+Cd4V46oy2vUwgmNi6+pKkDtFWU3IYzV1T0AUNMA57jzTsfY8Z40Bm6BJNt57
         Pr/eA1olaO1xZZH1HcQKPmWkqTYsuBvNDn84TqtylA3Ra067XgXjbKSid/FmhqNr+WFl
         o1F4E09iy991rfw4KSKP7TrcgzSTSuR8Si6wOt70XLsrmMx/pd0lI580BroFd1QuosGR
         wvMMvpHdYH5BzSHRZsMm1ogi8NiDrIKQY2dnVdMpVPPW+MmyBn1BNdWWr5+54t9uDaEG
         XGMJ4fkx45PNdPbrHYds+vFCHBHhMBTPrh9OnCoiLf/JatOWHCJqOLAhK0m9izx/aFDq
         1S1g==
X-Forwarded-Encrypted: i=1; AJvYcCUiENFSUfPfXd7tcnteE7NAjK5XsB7hcigYF6PFnX88kHq5aSM1acrdibJVnrpnL1qQocgWnLY4xNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpfSttuET0d8xa+czRBK1os8/pdKK/YuGufJV4swlxjikXNg5F
	zZjoBlbxjddATx0oZCgrD6UvcoD148RSFjGPHyQZaz/PuVbL47GYLDXI
X-Gm-Gg: AZuq6aKA82iovA9Y/m2IFMUIkoRzhLOdXmNYuEGHpQc82OH111bED9a2xExTF2Ypw29
	8nDWWW4WnVphjGgyMhkgH5fQSv6NwXsQoO90t9bUR03wpwP757KHwpZMI/uUc5qNX0t7WjmPvDk
	8WrBIN3xi0xQsHX4daanICFsgkLq4KSYMSSqqWQ5ggtf2vyidjtiYKaEumvkjOCASGVxSIj4bL+
	eK2xuLOCXoACUZbjQqCw7Rn1sWSJUoa9JgtuCdsOT3NBksiJ1iMH+WuODTQ+ep9lRZsDbt2yB1F
	WORdzQ8IcYIg97isYkwkHs2mkBVF/hZNWSEmyjgoWTwiE3qRiTpQc61neHZ1CoQw5SgaKCtmeXO
	M05t/3FwaN+P2XT/JtSedWyjooxPXwRirLfxlx5ZK+FcHHDl4cWueHj15/Q6T3IIfFrfdOjadtL
	/IRR6jYlPbgC069jY6bh7PudMtJ+fj
X-Received: by 2002:a05:6a00:84f:b0:7e8:3fcb:9b09 with SMTP id d2e1a72fcca58-821a7b4b364mr2805889b3a.31.1769093803845;
        Thu, 22 Jan 2026 06:56:43 -0800 (PST)
Received: from debian.ari ([152.58.182.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa1277966sm18318780b3a.31.2026.01.22.06.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 06:56:43 -0800 (PST)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Cc: gregkh@linuxfoundation.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH] staging: iio: impedance-analyzer: ad5933: use div64_ul() instead of do_div()
Date: Thu, 22 Jan 2026 20:26:33 +0530
Message-Id: <20260122145633.14938-1-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace do_div() with div64_ul() since the remainder is not used.
div64_ul() is the preferred API for 64-bit by 32-bit division when
only the quotient is needed, as it returns the result directly rather
than modifying the dividend in-place.

Issue identified by coccicheck using do_div.cocci.

Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 85a4223295cd..772267f6f093 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -194,8 +194,8 @@ static int ad5933_set_freq(struct ad5933_state *st,
 		u8 d8[4];
 	} dat;
 
-	freqreg = (u64)freq * (u64)(1 << 27);
-	do_div(freqreg, st->mclk_hz / 4);
+	freqreg = div64_ul((u64)freq * (u64)(1 << 27),
+			   st->mclk_hz / 4);
 
 	switch (reg) {
 	case AD5933_REG_FREQ_START:
-- 
2.39.5

