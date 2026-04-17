Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D46239E7D
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 13:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776430984; cv=none; b=OwdQ3ywMDi1OlCk+fqh/pXxDzCptvga33YfKdkCrXILuScPsIOmK2Pzfm2EoUIEeW+CGC+UMXShY1Xbptp6f95fzIFPG6938F0qhLa46F+Jasub4D2wzZOdNrPHC5NzAi4VCiLpkode76aJ9Np4YfPGDyql6Go7lRneEQRy+oIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776430984; c=relaxed/simple;
	bh=urOgl8YSYZ8l1uapYHKGcyDfVWJ9pmW7qyENPuW8nGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sOV1S+W+5F7qu1dJQrUOHkHcwCSFlJ44O4kvrA3J9UCINBXEazpo8aqxsueE5mHMei0ilA3NGwc9Vy+0V2iOEs0ENYmNv8ApCIOzvo9CSFt3n7A2WS6zefYS9dzBtspOPLBs8dwsOo3gUhMt9rSpq+7Mchee1c4EiqU5GWI7MDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVEylTXr; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVEylTXr"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b8d7f22d405so114719666b.0
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 06:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776430981; x=1777035781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vwcCC32dz00YNns9p/o+UJ6R+dX9aYiI5Q1hND+QY3Q=;
        b=kVEylTXrCL5P8Ua4ZaDTnnE4KbCdN0n4I39bFLeepSXKhTEwh62WhbKvWbwKx5QvlI
         QFINXHUBEpAaiyeBw+BXulXu2COEvIRz+vuddpA+WHf1u9CzvJZIivx/pmp5JARMQMgj
         VtH1/R50g6Uj9aNRGL2ridIIvedERlp5SjjjFIZxiQbnX+p9m/oeghX8F/r3OrcHuZxT
         80gmR2NC3bM2+SPKEfsGn03FMWXOZUyyCLoJgcejySdSNjR5HRzBKLG90ObL+qumYf47
         IPuEKDUs+m8apQVrTsl/D/6tmGAUBhN1eBkg1/dJGYNkh5f3BzNIkCsXzBqtrJVsKBPO
         WdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776430981; x=1777035781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwcCC32dz00YNns9p/o+UJ6R+dX9aYiI5Q1hND+QY3Q=;
        b=ICQaWeaePGvLnCEKmC34HbILWFXQxnMpGnkorHn/9jXC3dxUlwl4l/xkm+T4/N1izO
         rK7AheI64iNpz8jjlUmNigSD1BCy1Dlf41AaCpYjsl4rub1W8B7XJDa8+uPxqOxeEV/Y
         ej20t+el5wxX84+psSL3FNG0cK+sPHA/Nw20rKZR4m5MzS4qUjd0C6j6tSvKCC3pA0nj
         Z487nZ6YzUDb9rBLfKo4UXWk0h3Uv+pzaU/zzW+1H0WjtI1b4N2DefGw/PBPwoAcIuQs
         0CrSVaJX9vKoA7y5OEJrx2BGMcrQbnqdk9FQsozUEbCEB8KRy9JX0nXaOhkphWYsBY+N
         iM/Q==
X-Forwarded-Encrypted: i=1; AFNElJ8ngan4cF0Muw0rrayOq8HkZR8s807c9vFQ5kFy26AHoqIz31JeJcDZk0WT37JR1VG6RNr8AiReG78=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBdGTIG2aIJ/IcF/fR1hdUrxMc5JF1v5Oev4Z+6d5LMXEVOaai
	XD8ij+Xc2Bylq5Z96QscNbKR++xF6AAbXZgsHM8AmYsPgFzlXAXZZNlvDYVYbZHhGw/aHQ==
X-Gm-Gg: AeBDietRUKuJtevwokhUpHhyTxfgj/npcxVLp2NIH2jOCEOmjcyGLU8mWsU5QxzzX3j
	GGcJJFrW52hLPvNwTsVfLlnya6yIz2LNlOsfGT4Cm76YL09I+0dxcdMTsSeM/lvWlTx+/ub7CoJ
	rwchTau5xMtBy2OHb3OKvEuElJzw4oR1LTfpLx8iRjUQyM+EURYJ5mfJ3/Xl+njh7GkWvsn6+/O
	RCxP4bF0RD0v4iBxTJNNjqN8i956vKxh/do3JQfNLF4Wp2IusAgMpfydXjwLZz1Dnod7FtkHE/q
	GNhAyXVXYDh4fxh1Ypt6dNlfxtrqpfsGX6bRfVlNJyqxLS9S+hHIwCKLzw5zFNy5qbRf5+PS5HP
	hTGEOGc/NqnOro/7Sdq506mb4pyBhRQbZ8PF2FErApX2+VJJqToSmzCoDnYmJW+anNBTt/q7Hh4
	ZohGdUrdo0uyd9U30Lg+Ft8fiQFnvPsg/rhkTlKvqUMYVe96FeWaJ69xNi/PHD+zF0oEBJRTB1P
	9sWR3eHlRoo0FcOwNKrKv3eRzImCBwq8iR7GDzR5eike3HXzc9JtfAXm5lDqYiUoGLauzIZ+4xV
	xM2J1WmTZphWvOJdDsbFX5gcq38gLFyDid6HhyVrf5rVIrq8DLBQH6babobUH+Qci/1R7i7RLLT
	DYV5HajbBNYvnnhkEPoosLWt2nKDbAupAfznD4WXSBnf64KFFuCSSypgNKTtXd9meUz91fWHJSY
	/3cq8I
X-Received: by 2002:a17:906:dc89:b0:b98:435d:9939 with SMTP id a640c23a62f3a-ba418b7e205mr163003166b.9.1776430967206;
        Fri, 17 Apr 2026 06:02:47 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-a.c.od237066db22328bb-tp.internal (22.211.32.34.bc.googleusercontent.com. [34.32.211.22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba4512113a3sm54504966b.4.2026.04.17.06.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 06:02:46 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH] iio: magnetometer: ak8975: remove unnecessary braces
Date: Fri, 17 Apr 2026 13:02:24 +0000
Message-ID: <20260417130224.1308-1-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unnecessary braces at single if statement block.

No functional change.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index d30315ad85..443011748b 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -541,9 +541,9 @@ static int ak8975_set_mode(struct ak8975_data *data, enum ak_ctrl_mode mode)
 		 data->def->ctrl_modes[mode];
 	ret = i2c_smbus_write_byte_data(data->client,
 					data->def->ctrl_regs[CNTL], regval);
-	if (ret < 0) {
+	if (ret < 0)
 		return ret;
-	}
+
 	data->cntl_cache = regval;
 	/* After mode change wait atleast 100us */
 	usleep_range(100, 500);
-- 
2.47.3

