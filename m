Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A78D3A0B3A
	for <linux-iio@vger.kernel.org>; Fri,  6 Mar 2026 13:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772804791; cv=none; b=a47yqh3YIOkl0OlHAz69p+hOweERc0SmBswGwI3wckdZP1sJ/LhDtkZsw5OPFzZ3RVOjiDl7RQ3lCMJuFhR2MakmPLJe/v6YABAlG/aEYoXM8JTdK1kqZ/nh7sfbwVfXJGmcGbJ09X7K1+YAUL1GMUzlQuKR4UPcFExWxrkC+YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772804791; c=relaxed/simple;
	bh=csEjjDLi6SpEXl2DdL5mEw5wkF3j0SXOOlvkpfWlO8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kRnxZia6/UN5VrqeOm5romYY3Z83tmExm2jf3a3PKKnRdidbsOKhbryEylumkKR4zgjNIGBN5A0U2F4mED8fYsztthfp9Nvr3P3Q4ND1j6IF2BYly/SlKhIPYHTeqRzdAFWSGrTrA6vu2KqfRITluynT5D4153v4Zoi/fGGixr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdqwaJ8O; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdqwaJ8O"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439acc60f9dso634044f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 06 Mar 2026 05:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772804781; x=1773409581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pxrVsLEgO+Q9Gj9IzQjGjxIIScDX/iogdhdfvLyaTO0=;
        b=kdqwaJ8OfcoVQkh9a2n9Eu+AZ8Z6ZWqZvFF5I+yRh8rUy3CynpFhA3bf6CbnOt6Ckp
         m4SJB+eZIrCRfztHOlYpYCt5NoTOs1mVDixYVaSebhygWQejEq9UiNjHiSFqq+bG5ufs
         9LdIv8PmugZ8J6eJZ+EF9sxyBWM+Ukybun9/Kf/bUNx7SA7X/A5hl+0XYJkSnfeROAEM
         o5kRMl/U2u2Yfz5g4S60LPmiDJDtip3eZA+Z0cCg+twpH/GV+IPPlOP6tqFIL17DiaZe
         WNsu2sWyw+knQnIZm/Fr1BChf2u6QMNKmtBU+NXiJwB+/cHh5lqLGW+jVZSbxjFiCJ1S
         4AZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772804781; x=1773409581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxrVsLEgO+Q9Gj9IzQjGjxIIScDX/iogdhdfvLyaTO0=;
        b=AUAbvqEsPcT0s8i2g8lofWHgRkqD5dacrJ2NC2tT0x1R3LcD5R+9bfA/Iz9gmRjJ+5
         TcGAQADwRNtzUNSSG/qlylvKNT7nSGXf53+WoiXM9BZXTU6+bEHHOzyljlGd1vW6TxOZ
         IEGmJrL9RAYeKGicUziibORlWvbFLhaeyoK83tZfcni3hrnHFnjk+60hY7AaLA8rJOpA
         su+8QPUtb0bOoobdLeCgv+trcf6vEywQinnHQ7aA/erZ5K39q0PhEbukBUdjkwLgKonC
         EuKJT3SgHYdTDWsESFrS3z6xzO/EEJSM095IwtkPsqhuIa2q7qWDFKdhDercQ65MgN7s
         nMrA==
X-Forwarded-Encrypted: i=1; AJvYcCUM8ozcamGbH6GPZGisPbTkmq5YbdlmWD3+wggmnVsy/I367lA27thFHdYxrbmvO1TzPLiFiCOR/yg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3g0u0DxkanS2gBvadFHhmAOJ4w5dwYyh8I/7kMlaW61PCV9Em
	GYpvIIhJ7LbFmjlt0PAJOgcYCuj8u8ppfK13iKQMtwJoUF+p9q4+yYSC
X-Gm-Gg: ATEYQzwrw6sAddfwOfrVKlFWwDxt0GeV2xoW74VIl/w7p/JdLjdTgE6dIIHXMR7E2o4
	fH2f9gf2+SbvK8dJ7V+TLPPrmqBjXL1xEr5Ml5SCuSYMdhREbnVm3kd7jUmXwQi0QvEVnHSlVDP
	pUG8atyrGhsO4kivsMgTvVfbEqh3Cf594HT/oRwxFVnwKlpchGNEcl4Uy4gyG25ZTk4BbjNmxGB
	6RnJUiyipnEbgJjXuPLYGQFE0Zc2trHdj+lqmxi2RaDNjPhYRv1cpjZY/WDs2BEYSwZmwn2BClx
	qQ/DPjRtro6vbVlu9mRacW2pHskNVINTZqjGyj/KBvur30TG5jkzHEvsUIFP63AWIsgUIFyxZyh
	37WMv5r4aZYKMZfJdOl0uza76VAmtv2WnwLcHYRNKY7UECsFwhBjZ/knQf2YjlOxJLN16EBSbIL
	B4IW6G8lk87Frmqv6WzNYP3yq+ZYAIWuKdT/XmfnzOdNxWg9/C++jZseuRimafaRXFKZpoQ1clH
	Uo3EhRY/0LSWC03ZZ2ACQ1eh6oU6PTpa7f7uMeI2AWSaGkRKdpS
X-Received: by 2002:a05:6000:4028:b0:439:d735:757f with SMTP id ffacd0b85a97d-439da68339emr2349948f8f.6.1772804781031;
        Fri, 06 Mar 2026 05:46:21 -0800 (PST)
Received: from fedora ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d973sm3610838f8f.3.2026.03.06.05.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 05:46:20 -0800 (PST)
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
To: antoniu.miclaus@analog.com
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Subject: [PATCH] iio: adc: max1363: Fix leading space indentation
Date: Fri,  6 Mar 2026 17:43:36 +0400
Message-ID: <20260306134332.746728-5-giorgitchankvetadze1997@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix leading space indentation in the device enum (found by checkpatch).

No functional change.

Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
---
 drivers/iio/adc/max1363.c | 74 +++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index d35f4487b2f9..75af10bc37de 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -638,43 +638,43 @@ static const struct iio_chan_spec max11646_channels[] = MAX1363_2X_CHANS(10);
 static const struct iio_chan_spec max11644_channels[] = MAX1363_2X_CHANS(12);
 
 enum { max1361,
-       max1362,
-       max1363,
-       max1364,
-       max1036,
-       max1037,
-       max1038,
-       max1039,
-       max1136,
-       max1137,
-       max1138,
-       max1139,
-       max1236,
-       max1237,
-       max1238,
-       max1239,
-       max11600,
-       max11601,
-       max11602,
-       max11603,
-       max11604,
-       max11605,
-       max11606,
-       max11607,
-       max11608,
-       max11609,
-       max11610,
-       max11611,
-       max11612,
-       max11613,
-       max11614,
-       max11615,
-       max11616,
-       max11617,
-       max11644,
-       max11645,
-       max11646,
-       max11647
+	max1362,
+	max1363,
+	max1364,
+	max1036,
+	max1037,
+	max1038,
+	max1039,
+	max1136,
+	max1137,
+	max1138,
+	max1139,
+	max1236,
+	max1237,
+	max1238,
+	max1239,
+	max11600,
+	max11601,
+	max11602,
+	max11603,
+	max11604,
+	max11605,
+	max11606,
+	max11607,
+	max11608,
+	max11609,
+	max11610,
+	max11611,
+	max11612,
+	max11613,
+	max11614,
+	max11615,
+	max11616,
+	max11617,
+	max11644,
+	max11645,
+	max11646,
+	max11647
 };
 
 static const int max1363_monitor_speeds[] = { 133000, 665000, 33300, 16600,
-- 
2.52.0

