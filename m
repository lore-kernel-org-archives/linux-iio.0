Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792670045;
	b=slxbaqEuRnm7XTGWj6gGfFHW3krS0qHQfvGtJQD7KnfVnvsw7vRgiqDH/TzzH3yiy9YI
	 +v1yxS3KKJUtMdSvO/bL97UOobox3WFZltdHTLsnc6HVfHnPL3Tr+Ce1dwlUgcmdAIFow
	 o1+w+qoSKAtXrXSSDRWZNk+tazKfq1+xJ19cRzEjS1EveHRS6MDqf3/jArjYpno2yAa/6
	 VtExI13qWZMzgJHDaF2nJom/Rga8zbrIuhAL9Wb6e6vMPYsxXC+XNRe4FqahBkcnAx3NF
	 0Ze5yeX+7AgTMLjstHwhNfMoJsmd+cun8nYollb/crHX7TlYeklqjR7C9K+a70d10Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792670045;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=ZrTU0BeBuJ+bZ8aHoVR9RYjt+cbmEA8pWQyKk/SbD3Y=;
	b=wI8KDZClM04vCUa7lIqeKWS7tk3kK8uFzk6P5t+4GWWOeOERC0N/BD/kl2DSQPhODKQl
	 Yp3R2kQlwBKIO1qcujmdr5RYN7Ip3yTDh9x0IXijBELGhpAaFXwqFjvsQrfqwYIrrn4pb
	 eZKeRjavZimpDWSW8pWxXcFOem6FX7PhxG2bown9TV5Gz8LnGhILQrb08dvaJIgkkcVPQ
	 q8QaD0IQm/YLlqjFyw607DIa9U+nWbdh3iQgn0wCrZRPA4hKJ/LWL8/9HwNhbzlp7UF/8
	 8XsQxnfvjgWD2T1RJyWoDz/DppULMuVGBdTDrOBTVInS6zv0k7mel9Lqh2T8Iz+uPPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AwcHLmmi;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14F0606A331
	for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 11:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B14F0606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AwcHLmmi
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a20b122af8so3563815e9.0
        for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 04:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792670043; x=1793274843; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZrTU0BeBuJ+bZ8aHoVR9RYjt+cbmEA8pWQyKk/SbD3Y=;
        b=AwcHLmmi+l/2XjY7D+d2z46W+OqYVSpb+vE6rV5nPDDVtiqA/LqXxy7+rMDWTrNikO
         F0RF+Q6nMWGCzIC86iqTcaLwp8f96CF2U0sbCyNHwppZfNh/7x4pkEq0aVZQMhUezIKj
         iqz4p/DzLilVSURkVB454AdgDXOX6Jy56DS2yrr4YL8f6bLzVzRPMpW+CfyNPytTo2FY
         McRCtkGfYNexViUUtoCAUAfi4XmaYxjz3uHMvWr82cmS1VLyydkqQYyMHkzW8v1oCy6d
         HuCEW6oaYh00gyOKsFGG+wLYUaEwFDd+VeF/tCKKsqhA05KRlbaBel7Jv4PXMiErktGf
         zInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792670043; x=1793274843;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZrTU0BeBuJ+bZ8aHoVR9RYjt+cbmEA8pWQyKk/SbD3Y=;
        b=K305vlsJxY2dpZ5bfKaXrIbHIkz7fO+OjBLbvQ8wYm10QJYYVEtykdcwuHizVR3U63
         hRImFBlXSQ4jhA7pV8Q3i83tUb6I8gr5qzmD4Zc/YVkbbEsyyh4tz1I44AoqsGDPCzoc
         rpuhZm4K/5JcIuOI8VvsMrBaHJEzwA2O2h9kTH/FpEAZouIBrQJtRFj5fKKfIqkN6be4
         fmwDvF3/H470PTQmy7JDSC4v6flqPraDcni5F2cCP6g0r+60ADphAOxca3hWLxnUPVuV
         76o7Yn6nZCKBK+qLSM696D6MqhlwcTaCUsovepoSLaGTafoAiqTmVwCE3I8bFoefSJtA
         hcVA==
X-Gm-Message-State: AFq9FYK+pjrMhlC4CzMTnLCYrfqgRrZ9QEltXWvvXIeT5F/+zGMtLr1J
	bFD3pUYzkuLW5mUv0hQFx2hS1qum+6cpjxGUnFNg3deUW6qmICYax1wN
X-Gm-Gg: AYBFou0yKxrxv5UcOJXQ+2VBO9iRJvEAEK/96LFpafPcRD9aK+cVWecxmUtZNQUfJij
	6v5pAQIglvxM3C0UJJ9N1btz0YCO2Fj6jdFmk3GiQyzQZg0iWoLrigW8EGQMqBV1r29nFRpwuJz
	8Vecey3mi2AMUBL3MIkFqNbkVjHVBUdSlkBywIKQ+j38N80ODLxon6YPkaT5CcCiRQRQxTR6Aq1
	r53tPZN82Svx2EWvC5vhHlrBA472BrDvlHSkpQmmUhwN0PK2U+bdMXaIJsimgvRA2CYKT6b/Ak3
	RX4Qq65JOR3PgoLd5ITXR9Z5ev4WxuMIsECyKeEqGzVmK6LpFlDzleRyC+fJvDHCfNH9gfXTpu0
	AajW2TbeH+fpnMx8wxT1Ouq+fhnINzyl3ZTBPCyL0B9V9xmesTt9wO4C97bcZ2gpkODzDQNxeTe
	MSEguUUKQy9I4+vNv7gMo47Mb06uTSR6FMBFGSc/9GWHKEwMR/oROiOGMEYDV4NJtjlghGVhAjN
	QPyOLSptDzYdPhmTYKciY06d4zGKQNhrnLmdBX9ae9b8PAXgcNxw/eYDRummhS/06f9Uq2nbXZL
	HVdXJu2VLQ==
X-Received: by 2002:a05:600c:4684:b0:4a1:d36f:1ba0 with SMTP id 5b1f17b1804b1-4a1fdd74b6cmr103524945e9.35.1792670043037;
        Thu, 22 Oct 2026 04:54:03 -0700 (PDT)
Received: from localhost (ip-94-113-240-150.net.vodafone.cz. [94.113.240.150])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2584afe1sm13621046f8f.56.2026.10.22.04.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 04:54:02 -0700 (PDT)
From: Jan Remes <ciakval@gmail.com>
Date: Thu, 22 Oct 2026 13:53:58 +0200
Subject: [PATCH v3 2/4] iio: light: tsl2591: add I2C device ID table
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-first-patch-v3-2-b792e89a429a@mycroftmind.com>
References: <20261022-first-patch-v3-0-b792e89a429a@mycroftmind.com>
In-Reply-To: <20261022-first-patch-v3-0-b792e89a429a@mycroftmind.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Joe Sandom <joe.g.sandom@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jan Remes <jan.remes@mycroftmind.com>, Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.16.0

From: Jan Remes <jan.remes@mycroftmind.com>

The driver has only an OF match table. Devices instantiated by name
(e.g. via the sysfs new_device interface or i2c_board_info) have no
firmware node, so the I2C core can match them against an OF table only
by comparing the name with the compatible strings, and it does that only
when CONFIG_OF is enabled. Without CONFIG_OF such devices can be matched
only through the I2C device ID table, so they never bind to this driver.

Add an I2C device ID table so that they can be matched.

Signed-off-by: Jan Remes <jan.remes@mycroftmind.com>
---
 drivers/iio/light/tsl2591.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
index f56d31404c25..8cfce720efb9 100644
--- a/drivers/iio/light/tsl2591.c
+++ b/drivers/iio/light/tsl2591.c
@@ -1149,7 +1149,14 @@ static const struct of_device_id tsl2591_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, tsl2591_of_match);
 
+static const struct i2c_device_id tsl2591_id[] = {
+	{ .name = "tsl2591" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, tsl2591_id);
+
 static struct i2c_driver tsl2591_driver = {
+	.id_table = tsl2591_id,
 	.driver = {
 		.name = "tsl2591",
 		.pm = pm_ptr(&tsl2591_pm_ops),

-- 
2.53.0

