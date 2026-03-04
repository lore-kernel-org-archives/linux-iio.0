Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03CE39D6FB
	for <linux-iio@vger.kernel.org>; Wed,  4 Mar 2026 14:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633687; cv=none; b=Ii3iusbozI5oGxTbSgz+fJWZxOfg4R1w13CIRQU7J6lwweiUeBE6ylrfhWxBqdhVQcjxSC4tSnLISZ+mE59vdaiQa/DnqWHz/klYMUV+9Ynn7hEh/QpnymmmZ2RInO5Jd8d0efIQOxDksfA9SXQoCG5V1lJl/qFtQxxfjX6xmnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633687; c=relaxed/simple;
	bh=Y3ZEpfGtBo5wEfRJBpy2tfrMQpFq9i6vp/FNkZcZBpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BuQvgFH0qlqRqT1SqxInJGmjBBmcLS7aNErPmexhOdzneREetcBlYTuqZzK7V5aKtDUArArcD1x7y68oYWylph5s0xNWzf57pwTrVyVLzyOUW3lYRHYsZG5saHMKJJ/EeO4ni1LYmDOgcpmXm6uUUkVtbenj3CgUTT0H9Qf7t2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFGvmb1Y; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFGvmb1Y"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ae43042ea7so42699265ad.0
        for <linux-iio@vger.kernel.org>; Wed, 04 Mar 2026 06:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772633686; x=1773238486; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U55+Fp08poiTG4IfoFQdxSWkxQAw3Oak5NMij+UTg0o=;
        b=QFGvmb1YuRzceqhHXT2tgqogW7n+K0B5+uI5VyTnLkdFetvecXZbHcabUmUv/uvgsE
         jX4bjY9vuYPRY/EFXkf6hxtt7jjgjsPizDxCKu8QfZKcvZkWo9TtOLDxhMJRQdYvFTsX
         3ts4XFodDux4SOi4jCTwLb3kAiVjCrHQ29/mKEDdrM/KtEcjZbBOhkbosEWVQQpCHc4d
         RaxTxxp7ABGQ8HkBmzCXw0FzagVlRpWcF+bYr/4VkFXjnD8nHtwon++WxOyvoEWAb3fT
         Nsw12rtDlY9COPXmjbyzsOxelKJqdqmaKqeqk6d6ss9cr9g+kTC+j0tcViILKNocsus1
         1Y+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772633686; x=1773238486;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U55+Fp08poiTG4IfoFQdxSWkxQAw3Oak5NMij+UTg0o=;
        b=BzByXvKcZWMibw+FCsJ7iHcqlQnPEBAsYx+v3CR8tjfhI2lfNtI2VuW4OW2W7jjsfs
         15IGghy+K3FNbBr8u3Iu2b0FWCG/5FEnyBn1WOrn5v2obFhp18Pk8ONrp2TlTZ3bAwJT
         vy2b1GRLYt9jz/M4ZJrewDR8pQ/oic5c1p9hDvifQBplHJ2+1HkbkJEVTt1+dH2Tcf3L
         A3z7N/t2s90MnSEewqWM004mJpP6JlDfDz+ArkLbQ/BWJ6WQotkZTdQB6qO7CAJ4OeSj
         EzEzvPaQiWRcsEVUlr/ePe416QeIpfQzqIG9aFxII1tYsbkyW7lXxhlBP7FBbyr53yHf
         Lg5g==
X-Forwarded-Encrypted: i=1; AJvYcCUrNFPe34/C5ahtBtnu+rgyNiSo/kp+OCR+MRqjGOk7P3HxeCcLa2JUmBRqlXlC279ImQFF4MTDp64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz961mJzzeRl+/+7QSGhlXlYc68xdW9/KQMW5ewBAPAUQcyOVzC
	2Hn4tABx02/3vvlEaNaGfoje55j4FzbIuAfxeac9sQq6M2ocofBGzJiQt5SxMiP9Kx4=
X-Gm-Gg: ATEYQzz9w/OFJyszFJZUo3H1n1FOm8Xb45vMLS77N+XU2jpfUc1r3kD6HCb/jq4sRYp
	M763a9qFxm2qUEJb2KhGkAkGL5jpeXY24CKIIjmYuUw73Xb7YgHPB2pKJFQuvs6oIsdOR6+7Ll9
	chwf8I1NYzmpbXaMulYqiJKoe1fy+R2hIgXCxKy1BPUyZkjhonIJh3bjBMA7q3SoO9UPJz5wAy3
	38qzXNfOQaP0TJD8yIM0GFRXdAARUYZKt5kRx1f+3BDIPYuG3GCRVgsUvWhCQrVOPUbz22qYBi7
	FDA0mn6UN6HeG/kMhyLXDE+Kiqby6B9kxywKaCSbxgRrG1HbCeHpdYrWr+CPvzkJl4NbsGQUK/r
	4+T0C2H65/txLFGTwBQOmXED2wIa6Xx2vmEX9pQZIa3JkUDYDhDEJacE6EqWBFFlufgelzNqkza
	YCrQkhRlhowkc86oYLy6u2YgDhNr71ktKuQUgI
X-Received: by 2002:a17:902:cecf:b0:2ae:5a76:e26c with SMTP id d9443c01a7336-2ae6ab67292mr20188245ad.55.1772633685961;
        Wed, 04 Mar 2026 06:14:45 -0800 (PST)
Received: from junjungu-PC.localdomain ([2408:820c:9009:3f2:c48d:9c04:d04e:c13a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae45b5201fsm111498375ad.87.2026.03.04.06.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 06:14:45 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Wed, 04 Mar 2026 22:14:32 +0800
Subject: [PATCH] iio: proximity: rfd77402: Fix completion race condition in
 IRQ mode
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-77402-v1-1-47ad6eedd643@gmail.com>
X-B4-Tracking: v=1; b=H4sIAEc+qGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYwMTXXNzEwMj3dRkE3PLlFTDJMs0MyWg2oKi1LTMCrA50bG1tQB7col
 NVwAAAA==
X-Change-ID: 20260304-77402-ec479de1b9f6
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Shrikant Raskar <raskar.shree97@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772633681; l=1745;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=Y3ZEpfGtBo5wEfRJBpy2tfrMQpFq9i6vp/FNkZcZBpI=;
 b=Cw5mT3O/rAnh6PpT80UyGPggjhMR/GdwmzE0LnoPsMuZjtlUsqDggT1iBqKyKoR0mx1WYsLBF
 zKLrlJqTcSvCBf2ehvcYafJRhzTkAB6ZuEaJUtfB/It7N+3fkW2UroX
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

In IRQ mode, the completion was being reinitialized after the
measurement command had already been sent to the hardware. This
created a race condition where the IRQ handler could call complete()
before reinit_completion() was executed. Consequently,
wait_for_completion_timeout() would fail to see the signal and wait
until it timed out.

Move reinit_completion() to occur before the measurement command is
triggered to ensure the synchronization primitive is ready to
capture the interrupt.

Fixes: dc81be96a73a ("iio: proximity: rfd77402: Add interrupt handling support")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/iio/proximity/rfd77402.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd77402.c
index 6afdbfca3e5a..81b8daf17a54 100644
--- a/drivers/iio/proximity/rfd77402.c
+++ b/drivers/iio/proximity/rfd77402.c
@@ -173,10 +173,8 @@ static int rfd77402_wait_for_result(struct rfd77402_data *data)
 	struct i2c_client *client = data->client;
 	int val, ret;
 
-	if (data->irq_en) {
-		reinit_completion(&data->completion);
+	if (data->irq_en)
 		return rfd77402_wait_for_irq(data);
-	}
 
 	/*
 	 * As per RFD77402 datasheet section '3.1.1 Single Measure', the
@@ -204,6 +202,9 @@ static int rfd77402_measure(struct rfd77402_data *data)
 	if (ret < 0)
 		return ret;
 
+	if (data->irq_en)
+		reinit_completion(&data->completion);
+
 	ret = i2c_smbus_write_byte_data(client, RFD77402_CMD_R,
 					RFD77402_CMD_SINGLE |
 					RFD77402_CMD_VALID);

---
base-commit: c025f6cf4209e1542ec2afebe49f42bbaf1a5c7b
change-id: 20260304-77402-ec479de1b9f6

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

