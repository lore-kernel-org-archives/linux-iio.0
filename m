Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A3923C4E9
	for <linux-iio@vger.kernel.org>; Sat,  7 Mar 2026 10:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772880528; cv=none; b=I/GkpwGhiKoTRZLZGZunFzas7BTCBn4kyr8rCj7T5/m+zhnQxFX+ffyEkGQK5af2ACivFEQf1d7CYGrVwLjU5a8WA/JJ0tnhBlbuIxg4WJfH2pMf0IGekTW+qD120VAupNnl1I6M7QeCbSPLCGucBr4YFV9APtPUgoT3NLErbZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772880528; c=relaxed/simple;
	bh=O4gEiGCc2XNjPoD7AuUrEV6Sb+osVHVJP1Y0aAA1tTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aDh27T04nIt6x86h7GaDODYf317Nxlz6P9DnVKzPnNHefMnmdBUnLZ9u7ZdCMRbSALutjjNuodSK9VStrIDybq0i3Qv1L0mL6F/A+SNt00ohDJHMh/byti8hvx9VQxTbkiw8fhlVMS3a2tjW/Ls/jMq+piv/Hq1WditiC4nvy9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKc+b+RY; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKc+b+RY"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c70ea5e9e9dso3818177a12.1
        for <linux-iio@vger.kernel.org>; Sat, 07 Mar 2026 02:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772880526; x=1773485326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+b5Q6JH7ir7f585HJelVMQPjjKIMWEKALemlf2LRjXE=;
        b=EKc+b+RYBK6oWJfK5kliTbaELtyy5Na/h/UGBI98kOSew+bsyjOD986oazOg4hXhxX
         LD0Oo1sJHChViUstCQBNvBuVtXDmN4bInO5jxKBALxAq8gP6P33bJvlpUD5ZBXks3Zko
         2yXSydQUQJy22CAHOl+FLMZxREUnicqzGBWqmkEs19yczFB4e0ZyLVa/uyFZI9Fk1OV5
         TFt51F/UNBb0AYBPENVHxP2lh40hn9CmIUxaPC4zRQb35oapZZGxA5230F9Ie9FVRmjH
         WXSGBxyDzyX6u4aUGi/q0KC1QVycmJviqsOJnJfEyWgaAM1BGgPq185REBQBV5egSzWS
         7sUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772880526; x=1773485326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+b5Q6JH7ir7f585HJelVMQPjjKIMWEKALemlf2LRjXE=;
        b=rM7ldiwqPMmbGiSbdQFkE/iQmXgbZ8leeFOYS2ePc18iiFEUkwwwx66KvAmk+9jGnD
         d0ZEK8b+qFVaJHLhPKhV6oqAI7Gj7A8SPtrA+cI75IYnn6BHnSeYvHWL1zlKEXaNqD8g
         NygsiDByOR0UzaAeqSYB1flrFtYxoFaPsLLyVRWM1hWdfJjhL3wwf8Qx7qTGbayzrAuP
         GsTPBScDoEIHLkceFyprQfhYqDzFATSFCZCiJ0hFeg78EDHl1tUM0GtSwKyljCqqO352
         PZbUBJrw+Pwrw6aqiFidspLU/W8rgCsXTzVHa8Mo13bZX7kOi2yuax36ZeLw2v5UHC0M
         2m4g==
X-Forwarded-Encrypted: i=1; AJvYcCUVBjGdxUsHzupHuew40VWcEBnGkVf8HekmLxI850JVKfDG6aMHtEksmYEs/pf3EtfhRFDe6n2MRGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5VINNT7aA4UTr1ZK69M5DcFAsneInrjCX2HVlRMou87+JJSFX
	k6q3SArPUKxh3ihzB6jKg5Eqeof34lm791w6wyyCO7RiZiNepe5Are2d
X-Gm-Gg: ATEYQzwgfofZfnLDz+a7QlDIZHkJQTKTTDmQpyZBjMNwCKomb0AbqIrsvLXFIZKGDeS
	ckhAY8c1QLkOYrYC2SZpB+jiaoT7yIUwikXjvXRjCnPXJg6mPasrXZg2zxdF9BrOs0fM3i/yrMs
	YgwztOsXXiVvEiHfzUN4awzEkLDXyXc3nNLdjY6l1pFXFhtfdreVlVRX0f07iN5ikQJ8NQTpnNZ
	WOqY3bryYYwKnZzACN7RAVY8A2AmITV7agojGpdU1zrl3nvm5y6HGwih7RNnkl3THaF6oUgOIGJ
	FvGfLpQw6hSYf038fZhLJo26sbZhUpQ+o8vGS8AZafEzCL5ZSMWqFl0XiRyG9H9Ju6rKQDizQkk
	8nP4qx7K6PvUtNeCOZa0Y8h+ad0RvxM+KptD8FXwA1wqz8mNQFIWMWAl23+DHSN7e/9tohNwdXJ
	twzt6Oa7rerkoaioOgubk9vPZ+VPt1k2bMpoM=
X-Received: by 2002:a17:902:e803:b0:2ae:5442:45cf with SMTP id d9443c01a7336-2ae82431065mr59916915ad.33.1772880526564;
        Sat, 07 Mar 2026 02:48:46 -0800 (PST)
Received: from fedora ([2401:4900:1c6a:49e5:cff6:c6fd:2f81:fb7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e78d48sm49541235ad.22.2026.03.07.02.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 02:48:46 -0800 (PST)
From: Shi Hao <i.shihao.999@gmail.com>
To: andriy.shevchenko@intel.com
Cc: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcelo.schmitt@analog.com,
	mazziesaccount@gmail.com,
	nuno.sa@analog.com,
	i.shihao.999@gmail.com
Subject: [PATCH v2 3/6] iio: amplifiers: fix spelling mistake in comment
Date: Sat,  7 Mar 2026 16:17:02 +0530
Message-ID: <20260307104705.49129-4-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260307104705.49129-1-i.shihao.999@gmail.com>
References: <20260307104705.49129-1-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fix incorrect spelling in comment

- Curren -> Current

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 drivers/iio/amplifiers/ada4250.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/amplifiers/ada4250.c b/drivers/iio/amplifiers/ada4250.c
index 40f396ea9069..71e361af2074 100644
--- a/drivers/iio/amplifiers/ada4250.c
+++ b/drivers/iio/amplifiers/ada4250.c
@@ -109,7 +109,7 @@ static int ada4250_set_offset_uv(struct iio_dev *indio_dev,

	/*
	 * Compute Range and Voltage per LSB for the Sensor Offset Calibration
-	 * Example of computation for Range 1 and Range 2 (Curren Bias Set = AVDD):
+	 * Example of computation for Range 1 and Range 2 (Current Bias Set = AVDD):
	 *                     Range 1                            Range 2
	 *   Gain   | Max Vos(mV) |   LSB(mV)        |  Max Vos(mV)  | LSB(mV) |
	 *    2     |    X1*127   | X1=0.126(AVDD-1) |   X1*3*127    |  X1*3   |
--
2.53.0
