Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C6747A0C4
	for <linux-iio@vger.kernel.org>; Thu,  2 Jul 2026 11:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782992826; cv=none; b=WzCTdLQOaUYes5RkfFYpjMvrZZLq3drhFNP9yVV32gdv6UZD0YLX3C23kb3WvgMe8iqcpW/TCVy0Nl3+hNVo2t009/HHNtTQWFWDkSGC8fkfXarl43sF0PtPVW9VTn4QvehA4PexQhC/EQtjbXy+9QYT2J290ElKH85MjT+gicU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782992826; c=relaxed/simple;
	bh=xmwWSaBy4FHvE2lZSfawLpH4uzj+yitUohO7k8IBseA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GWEXZLgMri7FV2A4bPg4KAlqpHltOrC2Tlt/5uslcNXIEk3thSaCQ1LKK17PQ5KSSzbsI36R6cIOzIA3zUDBXlWUkLOYWkrlCd7vPtXoP3/sC6vs+53wLiTzEqpDxKvHytJZ4i0IWCkhTO2DKrCGZGJG/nWZv7+smonKAIegkvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3obnsyk; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3obnsyk"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-37d82f3a244so1345709a91.2
        for <linux-iio@vger.kernel.org>; Thu, 02 Jul 2026 04:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782992824; x=1783597624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBiW+Jb5ofAnhQsaYWPoJcN5SGqMaVDonBUCRupHVH8=;
        b=U3obnsykP7FUM+MS/WbnsOJHbFxb/b21f4zHEaXbMZfTABLrS+pzKtTF95mEBQTm5w
         wkwWb8gYpRkO4ia8bW+vHMWZ+v38pP4MwEBM+Kp3FB495jI1NYlvDxFbHg6FGGyVP4oM
         kPvuzxiBxw/u9/bsXMbGfXihqon6whEiGUh3tXmYfQG44NWlIQ9A+5zSP7hDs0eQKbW8
         zHYgYNLXnQmWaEX75M06CB4DEYD5eYxMKvNTSkhoHInM0S3VYgr5L1fr3syffVlQDVmS
         v2gaAeXCcxrut9/SnifTnndRut7HEZQNgKXBH+OVTRfHbiAnGsTuqjKYTm+lNBTPK2L1
         toOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782992824; x=1783597624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iBiW+Jb5ofAnhQsaYWPoJcN5SGqMaVDonBUCRupHVH8=;
        b=pOD3jQyjGmlIB566IuwVTXgW4fhT7SoxkLHR9XMwpO9RkUMzyWetgG8QUdXvi7SR4+
         TJ50nFG6WpXpVBqRcJUYwlUZ4ezIxqVFvzpcGXY8DEASWthdHGMaynf8Rg4oesxKuPvW
         nAPZscqXETabqPwgCZ2G+EcVoPcXJ6/AyIpZHIkI6ouXwAbw28NCVKvYElnTTMt1xlwG
         IcAmyjLn3E6pjBfN2+wqeVzJyhQcQn6ScyqJMbjvf8IS6Yr9dp0IlR5n8cxmDVk0S5ba
         NXNAD+BpZxiTMzeSik2INq+TTiVk6Ga1CAWfuJTvJTI4izBxAw0yj+lNL5naQvLUBeIp
         wmXQ==
X-Forwarded-Encrypted: i=1; AHgh+RphzXy7JgBkt5EqYImbmb/zq7HAWEce1RV0ETsuDwnmL2PydUFVeP+gO65I0684bWSvPbnVfjAGc1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyPtDH9lixmWnGo1C26qx+ZxsvPLEgI9YMFYA18wNCcD+9zHxc
	o1SuofbnTeTAtzLz/8wCs7NDbarBLJfbk2HaSpJJbwfO3H2V9zy1JkMQ
X-Gm-Gg: AfdE7cnwIEGGx/fD+7r/Jcbh94awrOJYp5AoU23zu9gS7aJEixWAk10unfKBLeVt8Ga
	SrKtsag8tfPHybo4Z7Kd+cl2Hz12tPGBb0ZwxYaTohGuzUvsGghguuKhf5lECFx92DM5kURDpbA
	6ouoTQhqND/fcoIX/6FzSwgAI7CXqC2+SwLCWsfrkwvbJlRyrb1E5ZOARd0OJRm/1i2NqJ/tAQZ
	I14Pluvmt4KUo1MswbBDZUBFvXwYsdbICVW/1bMe0ri14Ph3kOBkf+sZ5pQZtVOs3+TY6JHPpWi
	CxggIq2ApImmyOnA+ru/gmTiRCRU9u0JmfN1ry7Xv4P5lp6t1c44ii5jH7DoGzZbiwtinbI6lfz
	gUdzcEMbWL6dYT5DbgmnUIHMGzvFjDL8HYtPL1CAMl/DXlbheQk1MCy2I7sMM1POEYVCsrnKSYd
	vMf9NnltgljP0N96nUGGb9e6T9FBM+EwcCVNGHk2B+DruUM6sCnpDDU7citv+pyJVWgMwyKz4oI
	lSRYfU=
X-Received: by 2002:a17:90b:3c03:b0:37d:ee77:78ac with SMTP id 98e67ed59e1d1-380aa206b8amr5613051a91.19.1782992824218;
        Thu, 02 Jul 2026 04:47:04 -0700 (PDT)
Received: from moksh-Nitro-ANV15-51.. ([2401:4900:c12e:fec4:e7a1:6f69:20dc:cd96])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bb84405sm12313834eec.17.2026.07.02.04.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 04:47:03 -0700 (PDT)
From: Moksh Panicker <mokshpanicker.7@gmail.com>
To: jic23@kernel.org
Cc: nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	joshua.crofts1@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Moksh Panicker <mokshpanicker.7@gmail.com>
Subject: [PATCH v3 1/2] iio: adc: ad7779: Remove unused completion field
Date: Thu,  2 Jul 2026 11:46:48 +0000
Message-Id: <20260702114649.9758-2-mokshpanicker.7@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260702114649.9758-1-mokshpanicker.7@gmail.com>
References: <20260702114649.9758-1-mokshpanicker.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct ad7779_state contains a completion field that is initialized
in ad7779_setup_without_backend() but never waited on or signaled
anywhere in the driver. Remove the dead code.

Suggested-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Moksh Panicker <mokshpanicker.7@gmail.com>
---
 drivers/iio/adc/ad7779.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
index 695cc79e78da..c1a99b4c1256 100644
--- a/drivers/iio/adc/ad7779.c
+++ b/drivers/iio/adc/ad7779.c
@@ -143,7 +143,6 @@ struct ad7779_state {
 	const struct ad7779_chip_info *chip_info;
 	struct clk *mclk;
 	struct iio_trigger *trig;
-	struct completion completion;
 	unsigned int sampling_freq;
 	enum ad7779_filter filter_enabled;
 	struct iio_backend *back;
@@ -852,7 +851,6 @@ static int ad7779_setup_without_backend(struct ad7779_state *st, struct iio_dev
 
 	indio_dev->trig = iio_trigger_get(st->trig);
 
-	init_completion(&st->completion);
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      &iio_pollfunc_store_time,
-- 
2.34.1

