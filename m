Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBD4399347
	for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 11:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773316404; cv=none; b=fFUcuK3WyPXxxfsBBZ/ueyZbM4yhZBMFGbTXdaNrK2yYBSGkZvPTME/fXoegblxtCvc6JfDUa/YXVtay7A+RbSnuQ5Lilz9z1AAsiWC2cB6AKSVQpa7jP3F9SB1AsK+se9feATwKqCpynz1EJ6lhqJFf/STjFdKo+agSdpcUGzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773316404; c=relaxed/simple;
	bh=8Xyy00oxH9BoglqKEOMhdKaA9OWY9AsQ82hA9RGRF9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DoJuws6qbZzpdmPyE6U7u3okfcYTYyfPson8BNZVOB1BegCGk4S+bXnsy+0W+9KaDHjbSSJWtiVTt1ypmK6JAJrl3LarZXOYOZ40E/o51Cgg4ojgESaWuaQ/FxRgxGOgNON+HtxwQ31FTwsuCM0HVsO+viZqBnxJg3ieeDOeyOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OT+8NL6Q; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OT+8NL6Q"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-483487335c2so7686775e9.2
        for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 04:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773316401; x=1773921201; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ksNpMcFOkdRuvwTL39BI4yY5vtgJD4Unsj/0RB7GtmA=;
        b=OT+8NL6Q+xa9qHCGj2CVJkyOoECqJ1v9JHMe8rCzCj5LCZih+hJlyYbntbXByED7nE
         C//0CInB9fYLGmnx12w+C1dSKVGW8/0XzJ4vb5dO8c2XilB4SV6C3J9pvWXRJvQJsXgk
         SaDoyC68C7wOAbLbDfXQ+GrlZUP5y/kqvRqI3q8yFlnD1KZ0ZfaVspztCJyPGXUfKzR8
         MWt+cQFFEFCkZg5txBi45OKQMhbSyUTuW9kthysNYCiZZFVbZsX5mtsC5TcbccJY0Pod
         bDo0viXRzkYjnmQBNchN6r/yQrqNdR/fyka2UrAadBl4zMvZ5eh6t8urKVPn0X2XWZFQ
         A41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773316401; x=1773921201;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ksNpMcFOkdRuvwTL39BI4yY5vtgJD4Unsj/0RB7GtmA=;
        b=VoATP1Hj7Ig0c0CwubouE05pPs7tuxFszDOpJGigdPmAolyK3Q/yA7aEG0Z/vqyCaA
         XMiwlsfsLn+X45FF3qTjz9nYaZT8v8g3iAbHlKm+8PkKHFwEeMGUELFYN1kxHMHXP1t8
         pOjLCKP/cCW8R7Xzl/jA2ekmPAp6tcN/xl0BFNo+G2FX5Vw8ek9rktEkI53dUQesnvX8
         ke/ToosL/NCVLFTC4sHA+XSDo5a6bq9c1avhQZbde0+xAsxPBvn4Z3+Lql1cYvOVdiSr
         /XnxPmX6vmta4ypiWX9L//ugfsluQUtz4ddrrmU+nKSysgDo++byl0Og2DEpqA0om4S7
         KDEw==
X-Gm-Message-State: AOJu0Yz7CbwSd7phB2Nuujddw5QCJtboDjv763KYTPRUiBkn09piQjcT
	ws690xkKJYzp4Wr5E0OFIAOKUZejwYKzsbxII7rB5gJEaEP7PxphW8hu
X-Gm-Gg: ATEYQzw8bluhZ52RZYBQ+nkvGeidRDMXCQG0Wj99S1fW0B1zCLmZ3/ggfI+iSRYnF3G
	0AvzF0RAFBCHYuApDm7YHVKQ1XbjsNUIJX09YMmM85vC5M/jhrGfvKRKVmPr/7KeFk64KYiLhKb
	kdjUiQ5uIhp3Nslwwi/J5rOjtp2VIW666fQh0b1SgTrQu6ASbAXQhVYvgNonydT6zfmV6QO45Bl
	uFY/1V1NxkEFBDTjOeXKrns2d51DQuh+2Jkug3Hiqqzakjj6Rf8MqTqRs8gpdz91mCydi+YkR44
	cV1gB/ZcCrX9RIdig4SOpn8UMtHbWBY3sKqsMCvgxYYqDn5xoIL0aNEe0cBPq/rH8nowxnQQGhh
	fqhtbfUw14yiOa2upnT87OO30XAk5WhrU+W69Fy/UKWXV+Tyo/CREp7LgikkfKnMARNyfG2WDsS
	MLK5lji2BMY75zv5eDfnHROtZ4Gw==
X-Received: by 2002:a05:600c:630f:b0:480:4ae2:def1 with SMTP id 5b1f17b1804b1-4854b0c7c1cmr116758785e9.13.1773316401185;
        Thu, 12 Mar 2026 04:53:21 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe22529csm7044960f8f.31.2026.03.12.04.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 04:53:20 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Thu, 12 Mar 2026 13:53:13 +0200
Subject: [PATCH v2 2/3] iio: light: vcnl4000: add support for regulators
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260312-vcnl4000-regulators-v2-2-2bdebbcbb58a@gmail.com>
References: <20260312-vcnl4000-regulators-v2-0-2bdebbcbb58a@gmail.com>
In-Reply-To: <20260312-vcnl4000-regulators-v2-0-2bdebbcbb58a@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, Erikas Bitovtas <xerikasxx@gmail.com>, 
 Raymond Hackley <raymondhackley@protonmail.com>
X-Mailer: b4 0.14.3

Add supply, I2C and cathode voltage regulators to the sensor and enable
them. This keeps the sensor powered on even after its only supply shared
by another device shuts down.
This bug was reported outside of LKML, so no Closes: tag can be
attached.

Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
Reported-by: Raymond Hackley <raymondhackley@protonmail.com>
---
 drivers/iio/light/vcnl4000.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 5e03c3d8874b..04bde498aec4 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -18,12 +18,13 @@
  */
 
 #include <linux/bitfield.h>
-#include <linux/module.h>
-#include <linux/i2c.h>
-#include <linux/err.h>
 #include <linux/delay.h>
-#include <linux/pm_runtime.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
 #include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
 #include <linux/units.h>
 
 #include <linux/iio/buffer.h>
@@ -1983,6 +1984,7 @@ static int vcnl4010_probe_trigger(struct iio_dev *indio_dev)
 static int vcnl4000_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
+	const char * const regulator_names[] = { "vdd", "vddio", "vled" };
 	struct vcnl4000_data *data;
 	struct iio_dev *indio_dev;
 	int ret;
@@ -1997,6 +1999,12 @@ static int vcnl4000_probe(struct i2c_client *client)
 	data->id = id->driver_data;
 	data->chip_spec = &vcnl4000_chip_spec_cfg[data->id];
 
+	ret = devm_regulator_bulk_get_enable(&client->dev,
+				      ARRAY_SIZE(regulator_names),
+				      regulator_names);
+	if (ret < 0)
+		return ret;
+
 	mutex_init(&data->vcnl4000_lock);
 
 	ret = data->chip_spec->init(data);

-- 
2.53.0

