Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9059944E027
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 17:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780506777; cv=none; b=g4sxOtUoYn0zM/Djl4f6nytOjMjjlVqgW6hjzxjnQOHYSABtIAeGvDMqGfCNdtEYhEI6itaq9me+MquWrHwanneRt5YsSiCleD4xxL1eWOAsvgwqiwvul9uC3ve2yKR30Rdy21tDVQjP1TNE7FrinO8CRAsNKLONxkFedVy5Zss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780506777; c=relaxed/simple;
	bh=VPE1N0CcVBqslo2XPjxC64Yibn0ybQG+k6RsuywdWac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=szVVTI6FMov1KpnlBsiz884m/zg7hHiBNSV1OZyLepavPUN1THWZV9iJDeL/iTyXulOj/W78o4Q+u7OFKOwfIQoHFpKQ/dXg2CheTaydVckuDxdymzvbldA2GYlHMBCE1ItZGoDeqgUphseHFwA9mtTz6cMJjLker5WDrf18FrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAVXDmMB; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAVXDmMB"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490ac10e337so21183735e9.3
        for <linux-iio@vger.kernel.org>; Wed, 03 Jun 2026 10:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780506775; x=1781111575; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E4j0TI1un02xuJRUmwkXAF6i5ZkGtnqZivF2Rw6pdJ8=;
        b=iAVXDmMBIxqv41HbOAZS9twc3EWDm7qYqXwvovCAhSKSDIVTuRW89+T5/dR0gJaNV3
         8ZPWJhBONAFZ8ybQKSsOXSl0g/RUS/QBNFnMJctF4ETv3sy5GjoWb5CBnwoK4cV8LWD9
         ZATGmD+e/qqrd/i4/lKNJ76tqPrOQ6CcqtS73MAAWTOUCo/ESJoqmo/xlxtaVQZjUTEA
         88+wejKcv7Sg8JFxtpWaYMHiLe7HIZDKj0b7LQW8Be7RFhC5yG6LrWd4QZYXpigr4wK7
         j3RMDIhVEg2F13qYzY5J8Iwp7vEZslC5nEXrdR8BD2adCUkdot5E7RY2+f1mMfqmI2Ee
         0TgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780506775; x=1781111575;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E4j0TI1un02xuJRUmwkXAF6i5ZkGtnqZivF2Rw6pdJ8=;
        b=lsnSJfLuRqtOX+1haER+zWFCJkspqGBh8Z7f0FzvnseSqdVYfXaJgIGIc/PqddmzHZ
         PtAulwUfhVF3PWmqOPqD9sBDHS7PC5DukbuTCOeGt8BnOEau7ECf27rB9Zy3tWt9crGo
         HDicnH2eLedyK51LCwz6N7489Vmx9rMi4lI6PvTmQaPBmpo4NlOx0WDY2vC639svQiIZ
         cLSloIfDq4ByCCuPhrO0IBIIjTwNRO2I/A6O8/62QqeslNzZMvFBHGxzIXJuHs0S0h2n
         ly2eNVEfOmD4zPvBGPERoTDXrcCQtWTA/ycjzOQ51hVzZRF9hfr1N8xUQ25UVfMICQAy
         /y2w==
X-Gm-Message-State: AOJu0YwkbUXnfwORMyN1D/AtsQf7uC7+6NIqBZtp5iPZKAyqo5e6B2Z0
	meHQQwG6bWg8cPrqQJx4q26tNvaoybIE5uVjFmA9JEfI5I+hStosYVeDLGs0vDIP
X-Gm-Gg: Acq92OHVobyIWtO0JQ51KorSI1+aUvtIm+qv/K1hvWFcNJ8maqS2AphEpxFNib8YKJU
	/0C84kOEAXTOB81PpBX/r5BfeczjdhQ3YcWhvLqrg9uv3xxzcXm+MLH6MZY6yn9sYKvAOILNYmn
	8OTP1gYVXdaBgc0UKc0uQPTscTemvbwsvPTv6VmiEtprglW31v98XR3iNRkrptDd35EwAOPk9Sa
	4rNnSQUaUHZj13VJ6pGxK14AV04sQbMV0x2EApr1NcHSsoFYa3CZ4m9H+7EpsJbm327isSpOztQ
	Dob1BdiKexlhY/OYYGNx/rpD70Xi/JQjonbgf8r6ADsgUPYrnLiRRrGT8GXJOHkQmrMS1NqUEK+
	tl7v0F+aoXEgapaC/ud61kmO3+a4jSWGawilZ4qLom9khOaqTV1qeka1uwsspuZ7sk0tw1IuLg/
	O7MDSwnfmV/+MXiApkJM2RhzB8RTQZ4SaxJEdn34CU/z/mFs5lYiMa9eiale337ANWRR6h5Xr4s
	Zc1oZMCJBum9uVnMl1Qh9Ab1VGL7kLN5+kLwLyAlTqV3NztvdTQsAP7389tn01nOWklte7zF3iH
	VrnX32/6MjuaM3kV1QTQbkCsgcAEIq+D4At2IcojWSnspaQR+0I=
X-Received: by 2002:a05:600c:4ecc:b0:490:b724:dbd6 with SMTP id 5b1f17b1804b1-490b724dd8emr67557545e9.6.1780506775009;
        Wed, 03 Jun 2026 10:12:55 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0:c287:187e:fb7a:66a4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f345209sm8797506f8f.17.2026.06.03.10.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 10:12:54 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 03 Jun 2026 19:12:52 +0200
Subject: [PATCH v5 1/8] iio: light: opt3001: move device registration to
 end of probe()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-opt3001-cleanup-v5-1-3ef7b926d555@gmail.com>
References: <20260603-opt3001-cleanup-v5-0-3ef7b926d555@gmail.com>
In-Reply-To: <20260603-opt3001-cleanup-v5-0-3ef7b926d555@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780506773; l=1802;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=VPE1N0CcVBqslo2XPjxC64Yibn0ybQG+k6RsuywdWac=;
 b=z2HRwVihwymPCuEoRhCW0B/RoRNvFBQWK9OoJnIJ/qWm1XgLj3j/eB/t+Y5BF+rPYAzt7AE7I
 sXMuMXo5ZBnBFJFa/9FUl8MgIXiGWN8fwz9wEH6yUWLZhqOvf1j4KQO
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Move IIO device registration to the end of the probe() function to
follow standard driver teardown/setup ordering and improve driver
logic. Additionally, switch devm_iio_device_register() to its
unmanaged counterpart as current driver implementation mixes managed
and unmanaged resources, causing potential resource leaks.

Also, add iio_device_unregister() to remove() function to correctly
handle teardown.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/opt3001.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 03c7a87b4a8e..6a39f116f931 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -874,12 +874,6 @@ static int opt3001_probe(struct i2c_client *client)
 	iio->modes = INDIO_DIRECT_MODE;
 	iio->info = &opt3001_info;
 
-	ret = devm_iio_device_register(dev, iio);
-	if (ret) {
-		dev_err(dev, "failed to register IIO device\n");
-		return ret;
-	}
-
 	/* Make use of INT pin only if valid IRQ no. is given */
 	if (irq > 0) {
 		ret = request_threaded_irq(irq, NULL, opt3001_irq,
@@ -894,7 +888,17 @@ static int opt3001_probe(struct i2c_client *client)
 		dev_dbg(opt->dev, "enabling interrupt-less operation\n");
 	}
 
+	ret = iio_device_register(iio);
+	if (ret)
+		goto free_irq;
+
 	return 0;
+
+free_irq:
+	if (irq > 0)
+		free_irq(irq, iio);
+
+	return ret;
 }
 
 static void opt3001_remove(struct i2c_client *client)
@@ -904,6 +908,8 @@ static void opt3001_remove(struct i2c_client *client)
 	int ret;
 	u16 reg;
 
+	iio_device_unregister(iio);
+
 	if (opt->use_irq)
 		free_irq(client->irq, iio);
 

-- 
2.54.0

