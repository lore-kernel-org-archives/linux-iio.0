Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4526E3290D2
	for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 14:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776523677; cv=none; b=bPIHR5xAsfFrH8/aRzmtw/vMmgHj3LmjHvHMZdkI2F4NTaUNExOyTnNRydJCiPneLKWCusVIlcTXwLSPYH8Zeu5MqtdF9PzGB3SAFhpgdtZgtdBU+QQB7+F/yq9277QbAuDXOGImFnxlwFQhJzhdZ1BlJ1DBkQGXIs6c4Fsb+5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776523677; c=relaxed/simple;
	bh=l6nManMeR7Jg1MhkwUdhEH7FHLLqb5lCwS/P/91//S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o0K4a1YH2EhV1hK+CR0JaDuWFomFDX4FycbcwLckOnHqxpmvH6XuYUAEw1AGp+Vrbv301noX7hgF4AsPhNaXaSW3Wq4IgRxJALe+Qe97oWVNgRxS9Imb1PL7RG34XEYIPBkFlRC8wqJ4gJPHlrqfcRagNJaetHoT206T8d03rq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwX/3Dpa; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwX/3Dpa"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59e5aa4ca41so1606285e87.2
        for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 07:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776523674; x=1777128474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BjNK/Cg8+mI3iZeqCtPR1pHEgjWGhrHjIwJvfOxtDFI=;
        b=HwX/3DpampM+CMwhED1aecYg/VaICmqO9bw106y9Vw42qmuqKkHg/aZ3eTfmRy6UxS
         EdYjzv44WxovYglJ+muO6qBfy/bv1qEPgU2urnuM3pwWO7hjhjIMaoKHy1COtqH7SBoH
         EAToDzRq4edXme7kdhxYP30rwASQ+eo8T3qMbctuMTk4OI4VKn//6Uysey0//aEMZx7b
         lRBgKcAuRMm+e2GJIh/gL2Xh5K3YzpbI6bLaGlmSAW5Y6mjlcu03StySMyce9pG/DNVe
         YN5WysbE8B1Gw+IjU7UrXY3pWs5dcGY7xxCjC0EA+BtV+2DxIwhb2Gtbaib3Po2olVec
         dCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776523674; x=1777128474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BjNK/Cg8+mI3iZeqCtPR1pHEgjWGhrHjIwJvfOxtDFI=;
        b=qn27x722YpO+cH0WEZ5LPuOfXD/BL5XZ9934qdkyIe6XzfSAw2Z1VZE7FOimCv6Aok
         299Vv2OUzdLXr2HXEv/9svVNmkTdFz1H3Em/+QND/HNx2WqCN5J49W3Pht7f+7GJx+3o
         5fFEEtXmukY6t91vVEABK/swtcEU1Pk+PVqOgmDvXJsf4lSXwaXZg5VY/xjy6cLdrOpc
         mVcqeVfGeIYsALgYvSpqHF6Jgb/l1QGQTdZKy13aokQgryXWygHNQeVNSfDMnrvcmvXO
         KMAlmTgMmjyPrsNHVt9FU/+FOSZeHm/q4J4VB+R2KTvzpJhZHGz+08HknrMkWiF+wrVz
         iBSw==
X-Gm-Message-State: AOJu0YzysLmAzAJzh7srphyuDeOI+N9uP0yph0ydDcehhNsrKYsHkdig
	RFkyv3rCdfefrQdJVJ6V7toKUMSJri3nPNzRLKPQGUq+Bf5CI2Xx8qyr
X-Gm-Gg: AeBDieuLa2P+RbHHW/APq/QuAHTQzZwnE/OUmThOE/DCu3GeJRuHkNiKgcJWs8+1j3f
	mnS9La50sHp3hG0SE8EDs2q7MquDHo0YP5qLsLixaobVMx1gxkZo+wHlLZUg+PBMPH2axM591Yb
	Uqs3ALVXUCaKjZYYicnSrhyjoruLHKqGYdUJXWA3KvqCXfG02owqjgw5KFRBKoUOcFqrs1C9c0A
	CCV9TR+Sa5l0PJuKrX44yLu1VAZmLHV4BQuSxrweQAdXwOgINDofEKKELKNjYhne7BIIf71JkGO
	C/T1YXwdDxZ3I57dpfvGGJP5+BAIA2HDSxirWmhYtpjdq91mFeRcXYzKPoe6cZgkAPG0zKxOeau
	9hcpsgQ0F6hbhjzmA8SPQhKn0nvBWvNdzyEDEjHGrkU4TTO91ML3l3crUQ0mCOsKW0nUDqhBDVQ
	fIfHR+WuclJFptGvG9SVjgr5s=
X-Received: by 2002:a05:6512:1242:b0:5a4:640:9f07 with SMTP id 2adb3069b0e04-5a4172e7b8bmr2429015e87.31.1776523674389;
        Sat, 18 Apr 2026 07:47:54 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb4f51easm10901001fa.6.2026.04.18.07.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 07:47:53 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/5] misc: apds990x: Drop IRQF_TRIGGER_LOW trigger
Date: Sat, 18 Apr 2026 17:47:16 +0300
Message-ID: <20260418144716.132936-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260418144716.132936-1-clamor95@gmail.com>
References: <20260418144716.132936-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Predefined IRQF_TRIGGER_LOW causes a conflict when setting triggers in the
device tree node. Remove IRQF_TRIGGER_LOW from the interrupt; it can be
specified in the device tree if needed.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/misc/apds990x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/apds990x.c b/drivers/misc/apds990x.c
index 557c8476ea80..51037cdc2c47 100644
--- a/drivers/misc/apds990x.c
+++ b/drivers/misc/apds990x.c
@@ -1183,8 +1183,8 @@ static int apds990x_probe(struct i2c_client *client)
 	}
 
 	err = devm_request_threaded_irq(dev, client->irq, NULL, apds990x_irq,
-					IRQF_TRIGGER_FALLING | IRQF_TRIGGER_LOW |
-					IRQF_ONESHOT, "apds990x", chip);
+					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					"apds990x", chip);
 	if (err) {
 		dev_err(dev, "could not get IRQ %d\n", client->irq);
 		goto error_pm;
-- 
2.51.0

