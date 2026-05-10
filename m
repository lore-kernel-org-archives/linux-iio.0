Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801B6371D13
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 12:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778416687; cv=none; b=PVY1oF2RZoLD9HDCwy6ZhdVikZ+liduDq2drPgQ5QPuAlgaSF/yumbgESTjCw2KY8xu2gr5uLNZCwLQCEiHfxQEsNOvOtLdW3BfbExhPLchUla9wML3Ha0bYzJFVzpewD8ndbjgyW2tZ+Ek177oDfNEnjq2w+4Q+Lh8C/AB2a9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778416687; c=relaxed/simple;
	bh=LKT8F/bo+j3KgGf/YTp7nyOl8+Ejt9kpwLNK+n73S5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DvCdSJNNirU1/91F3nJj7cL63UkdCiqunZe3014bp9L/SnZFF48ZBJySFzZbQQTwpsrUl22M4E3EPDhtUWYH+h0wLECWWuavCXtul4P0A+lHSqqJ7I/pkCtCcaMdjPnOQ7we0H704sGKf5rUoY8yxgW/sbjlA/Owdjge+zgNAbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icg7SmQ8; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icg7SmQ8"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a40cfab24dso3744708e87.2
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 05:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778416685; x=1779021485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0QqlUk8X7Q1uAvmD37hhieqDSFoMSc9yS7Ffu0fC/jY=;
        b=icg7SmQ8WT/LkgShUSlQd/jXRRTrZKvCU8Ku094PBBDPPlUQU8rxmN7Z696cpqINRT
         Wyuy9bw+up8LWw8jDH/edfnZSn9CRmsTVqSjU/w3DpZ4Hcqh6AQvu4IDJiX8caavR0Aq
         RGLALvUijFRvJ5T4SMw04lHLKp75dcXeum4C9wJg2VNTL5DdHtXBXNWIheND2URtOqjN
         1XPc4myhjD2QoHQhXZWoeHnVPLafjlHDdBRbOTs1dAZqZ74LFBtwYowjPsmO7sbHfXFs
         6KqBq02lfQNsDJIS1CgJXiZOQcgS0tX7QUIVbjK0SBeR4KjG4+6qaAQEa+CkRAa2hMHF
         S86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778416685; x=1779021485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0QqlUk8X7Q1uAvmD37hhieqDSFoMSc9yS7Ffu0fC/jY=;
        b=b8EofI41FB03dAPOmLfJlKJv7II14VRUCOXefyFemlH325f+2g7laXqAP84tltKBa/
         GsQ49L0lDnPioMyPnU9G8Hs5dvLpEy2TJp6DwOFCFpiSeyiUxQp37eZdnghlaaluhB4n
         Cizd8pGsUXhFxD/9PXG3Zf514c6Y9RN0w6oCmE7QPKKRKNgIqWoUpb2wGjrwgLugNIgU
         1tvYvNJMOMOWDP751WSIxWKrnAZJU9chpINqdekfuLo/grg3f3QKkfSJl1xrZ27xf0gJ
         i8Cl9PBcYdG+qTq96agAVKsSxleieA+JZy47f6g95g5qYC2Bo+gELEqzSUuo2RwRtHE3
         105g==
X-Forwarded-Encrypted: i=1; AFNElJ/bXHJPavuF32MAT6Eo+ixMXHw11fTlsL2ANgEF1SSoHyJ+ib32h8s2ywi/J1IDgjHr5T8DApQuJbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsH+dxKPaxK4xhfY6vMQzERpFc/ReWPLxkGo84E2D/WVtXaU4/
	r66VE7iGycbT0tg9KxIFbZZB9SHqCQM/+IK2q5OSLGHBIZU0RySJ8UBQ
X-Gm-Gg: Acq92OHlw85sGrf2ryd344HHRjLr6ehLdki6WKyEn4UW2b2NtDza6KR0e1cNqoK+P+2
	SLuUP6KQXxW10p+Apa3UZuJMu4tDBKcCa5nZykogr8RE+dK7Ot32AFiVM+qu8cRkYzFGJ/X9CxO
	JYX0P6G4uF8NPxl+y7hLMy669V4mmRBVG2r7LW5w0R3XzZtMLKON+Hui9j7utJM0LYysar2K4df
	J43zy0cXxDcTKmZgvOAXErqVFzQICI5hRb4hUTVdMpckgqgk89fskoOwPKFg9/Jr4VzODHTloGA
	SzXJPU+K1H6TaGd19A+w1OsTTyZjQAxNRU/xMzlcsn3Q//KLODklO1YNe5hbfdKY8rLgA27x9gQ
	CqrUX5Rp+FZvUnn7M13C1BFgWFQVjyPQuuvykhNjaP53uhCHJeVy0OHPe/dsDcM0lvtxeS+K+6I
	yigMjt93xe4n8D9YgPyoexWXg3cVDjC3BvvF6lZ76ap7KpEQ1joO/yjQXuHuT3nXpMHE3yde6Oi
	kw=
X-Received: by 2002:a05:6512:39c2:b0:5a8:6c1c:6b07 with SMTP id 2adb3069b0e04-5a8a94c9327mr3090039e87.39.1778416684381;
        Sun, 10 May 2026 05:38:04 -0700 (PDT)
Received: from Shofiq (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8a9515087sm1891190e87.12.2026.05.10.05.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 05:38:03 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	mike.looijmans@topic.nl,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH v3] iio: adc: ti-ads1298: Fix incorrect timeout comment
Date: Sun, 10 May 2026 15:38:01 +0300
Message-ID: <20260510123801.4066-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
In-Reply-To: <20260509071910.12345-1-shofiqtest@gmail.com>
References: <20260509071910.12345-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At the lowest supported data rate of 250Hz, one conversion period is
4ms, not 40ms. The 50ms timeout is deliberately conservative to allow
for kernel scheduling latency, which can be significant under load or
on slow machines.

Fix the comment to state the correct conversion time, use "lowest sample
rate" for clarity, and explain that the extra margin exists to absorb
scheduling latency so that no one is tempted to shrink the timeout to
match the conversion period.

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 drivers/iio/adc/ti-ads1298.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
index cf5f954206..128b45a301 100644
--- a/drivers/iio/adc/ti-ads1298.c
+++ b/drivers/iio/adc/ti-ads1298.c
@@ -210,7 +210,11 @@ static int ads1298_read_one(struct ads1298_private *priv, int chan_index)
 		return ret;
 	}

-	/* Cannot take longer than 40ms (250Hz) */
+	/*
+	 * One conversion takes at most 4ms at the lowest sample rate (250Hz).
+	 * Use 50ms to allow for kernel scheduling latency.
+	 */
 	ret = wait_for_completion_timeout(&priv->completion, msecs_to_jiffies(50));
 	if (!ret)
 		return -ETIMEDOUT;
--
2.54.0.windows.1

