Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F87A41D65B
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 23:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784072635; cv=none; b=eGn/Mw2vfdKTmmQwC1jA3cnR1dfZKkFowaZfAXC4TyVmwFOr2cAr3wwHp54WFHXern2MO0Xm6rPotU5E5nl2DhRh6rgFFSqx+cHM1pX6VRgl56OFKTK3pzgdGEVtILrCUSrElkTHYy00iiF04s40w9AxypcZ5/8AN81VAfyJ+k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784072635; c=relaxed/simple;
	bh=dCf0Q6aJ8SY9P7WKfIBXY0C/UqKkj+m9dxP4ipo7Dn8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=seQM7iTyD5DZ4iv85HjAg/5EQb23vrDTZ2q0664FxCRpk16PO4cmC3VMBEepNPnsKbCBL8M6l8fADY193Q76cfexkPqVhAIim64gfnKVf0O8lFIivNwna6gq/ZmhGaG12KKErp2BU0L2058lVVzeh8eyTmFE3ctBWr21nQIMIro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HyuFuCSV; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyuFuCSV"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ccf2360620so13001465ad.3
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 16:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784072633; x=1784677433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jEOOTsn4hC/InOasCmFmuOAff9CBOfHb3eXMINdEwFM=;
        b=HyuFuCSVFAwOqeYkk8MjNzXt9wl+Bw81x/9oqivO/x98LGM9+LChi2fizxuBwaROoP
         KtmLsWXa++3j7JGYOvtbErgY/oZVeZxGvw0qdgNJxmbAxpMbbmO/KOit1hKkYNvKnt/R
         QcpocLXCgAZ3cPJob9Jl4rR9Ly8T1w2kQ1IQ+V1tezCxPlGsnpuSa63qiRNNyNXbSL3W
         zesBBPrz6y4DMl/ib8V48t9p01IxDIxSQSL0Z4m7pqpGDumYtHSqDMv8wFnQAYObY6DA
         G79cakwxy4Wj6qFTG94NGZlVZhhBDPcHWM4VD5o/kIIbNQrRvJYCTIO07b/3K7Ujervb
         q3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784072633; x=1784677433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jEOOTsn4hC/InOasCmFmuOAff9CBOfHb3eXMINdEwFM=;
        b=lcIAvRQ2wLK0oIqatyrGtouPLLi24kvu8uHX0ssVduiorQbBQB8mb/5JnWZkFX3XUV
         O4Dgfgr4muAW44/Vw+PqtUjkg7Qt9X9x2wOBX03b5wAQNWTcaHyCng88QL/R6VIg7t9p
         E35tyew9sio7hDB3xg9iiaM5rArpOCFQ47oVvCqTDxmtQT3NLiCh+OmqpZfOVcjA+gyD
         AFVO+o6CMkZqezqo8RvyaUCRO+ufTo3AQx1nmC0NRNFcT2Q9QoFtwjJjOAhj8v5rYcfK
         3B3t1oD8UFJeKengeXg9/OxRZUnqqBvGRsrlE8wJUoP18vmA2kF3FakomiU04Un2RUuS
         x10w==
X-Gm-Message-State: AOJu0YxztZD+E8xARpVt/5lRFzE+pg8JnEC7rXsZ8Y/simOyz+G9SAKq
	sLvvQNmGoGuIbARSmWk6gg5PogULEOvMXf17IuQXxQFfiMqBCFKG0OBl9nPobQ==
X-Gm-Gg: AfdE7cmv3pOm+IUAc2qsINDJnMLryPKwSsaovTlD08kDArQh4wpjDpH5ZelGCoLr/Nc
	dS0rvY5+KHAjp8g3aIYVxM19YmKo4douMfvvAlXsCSfIDp2JS89QKZ+XmJfwu6O/ZxEcSKQ+W8X
	NQ8dT9bygNBP+umjQoWvJDHmcbD2Hb0owNo1zpmh3MgFVQ7PDsCeTnYbJTrzNYAynyq/ZViFdlV
	oyrbccjS10rS8gi4SwZpFedEkkNrzS5zpXUIYr8g5BDWguu3NiABXblik9lFf8Un8v39uHF4Zyb
	afSLfjrzmbG2QPIXxg33HOBbEVdrTGT/jjG5r2vl3pYgrFID3YwNauobuWIqPUfi/y0jA2Fjy/m
	oMZAczXUu3iOTyCDUeQ9t+XgHsOWdCHYCNHRHjQNIOKwIIFHVrLGfTQKNcEsOLdRZaHdsZTGQ0s
	65a9r+PcHwtZ4SEfRagiokCNuX7eUIJ2jd66dYaAW5pAxQEeVbGhU58E0AsZfb1LN8bh7W4T+ra
	sH25O2oBKaL/KG1KvZcXAPHutxSolOl3LVPGOof58tchbJ4mLcwhsUg0iKNPkrtsg==
X-Received: by 2002:a17:903:32cc:b0:2c9:854c:a45c with SMTP id d9443c01a7336-2ce9f02bb90mr154625965ad.34.1784072633341;
        Tue, 14 Jul 2026 16:43:53 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9c25fccsm122539085ad.35.2026.07.14.16.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 16:43:52 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Patrick Havelange <patrick.havelange@essensium.com>,
	William Breathitt Gray <wbg@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org (open list),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [PATCH] counter: ftm-quaddec: use devm_platform_ioremap_resource
Date: Tue, 14 Jul 2026 16:43:50 -0700
Message-ID: <20260714234350.892367-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the open-coded platform_get_resource() plus devm_ioremap()
sequence with devm_platform_ioremap_resource(), which fetches the
resource, requests the region and maps it in one call. Switch the error
check to IS_ERR()/PTR_ERR() and drop the now-unused struct resource
pointer.

The DT nodes (counter@29d0000 / counter@29e0000 in ls1021a.dtsi) each
have a single 0x10000 reg region, so the region reservation added by
devm_ioremap_resource() is exclusive and does not introduce overlap
failures.

Built for ARM (drivers/counter/ftm-quaddec.o) with LLVM=1.

Assisted-by: opencode:hy3-free
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/counter/ftm-quaddec.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
index 8455f16d62cb..ed93f3621d2a 100644
--- a/drivers/counter/ftm-quaddec.c
+++ b/drivers/counter/ftm-quaddec.c
@@ -262,28 +262,22 @@ static int ftm_quaddec_probe(struct platform_device *pdev)
 	struct ftm_quaddec *ftm;
 
 	struct device_node *node = pdev->dev.of_node;
-	struct resource *io;
+	void __iomem *ftm_base;
 	int ret;
 
+	ftm_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ftm_base))
+		return PTR_ERR(ftm_base);
+
 	counter = devm_counter_alloc(&pdev->dev, sizeof(*ftm));
 	if (!counter)
 		return -ENOMEM;
 	ftm = counter_priv(counter);
 
-	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!io) {
-		dev_err(&pdev->dev, "Failed to get memory region\n");
-		return -ENODEV;
-	}
-
 	ftm->pdev = pdev;
 	ftm->big_endian = of_property_read_bool(node, "big-endian");
-	ftm->ftm_base = devm_ioremap(&pdev->dev, io->start, resource_size(io));
+	ftm->ftm_base = ftm_base;
 
-	if (!ftm->ftm_base) {
-		dev_err(&pdev->dev, "Failed to map memory region\n");
-		return -EINVAL;
-	}
 	counter->name = dev_name(&pdev->dev);
 	counter->parent = &pdev->dev;
 	counter->ops = &ftm_quaddec_cnt_ops;
-- 
2.55.0

