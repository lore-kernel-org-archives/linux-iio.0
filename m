Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324153D524E
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 17:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681603; cv=none; b=US+xzbA9pvPrgTa+DEL8rsRo3R8E0VEvF5WrwfH0MRGfSlf84sg9yhieFz7gdbrYVNRMuZRJuoyX37E80GWHbvlgbaf18SOeODUI8TOVUfmIe/8XLH0bul8pgRmxCU/2QfubhDmLdMWCujl8cQuyFofL33NUDRULOhmmF/KarqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681603; c=relaxed/simple;
	bh=IU0IBscarTUHstHmwSwIa08PL60ws1VZKbiLKVlW0Jc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TM6y01JE4h2LjzM38k03aGjmKHbc35dJ4x7fCNGnk4bCQZkfm8cRU3Xx4oKy0Ycpb7Z14NrksVfTuzEga8UScVPmmSZ2yjVXAGdjcU0+RtY4bn6ptWs5UPZRDdGgM2mnzxcKiDt+M2cTSRIb72RAeKbWfDP/E6zKfdDgVY12tak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=goVsI22c; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goVsI22c"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b9358bc9c50so597559966b.1
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 10:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773681599; x=1774286399; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LvZUSKnnGPiJWJPl2Ub4VP/4FdncxUtageJMqGG/QlU=;
        b=goVsI22cRBccBY1QhKM3ZgHopz2avwnvc6FgW70gB9AewxC9933tQbDjq4q/p7JGkV
         Aku/W6wDs+iJcapBKHozLHDIqFCLneLT+W0sQuf1GhPYEaJbeyX8wy1ZqXVU4pp14v8R
         vzwSsww5144oJi38W/n0xjg/2J5/nuHsrVw7DLplJdQ+ujCfTBc4mFBc6421iO6elFI/
         D7O/1U28rKrit68DA981T1xPM78M/AR228laQcKIoXPqhg2ahSyCWnbQDC3QzBEbc+jJ
         KEHLadNU2MuHr4XlFN8aF56wQBxvNqhXzX0xkmqGCnHEpB7M9IDN1S3WbvcBStvDlS/b
         fuAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773681599; x=1774286399;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LvZUSKnnGPiJWJPl2Ub4VP/4FdncxUtageJMqGG/QlU=;
        b=dfJWb7sEcWkeNyJVL21SYX0x56/NjUuf6zKXbqW14607/6Kfrc2uGR5MjkM3cBr96v
         Ij3nVjXObYwZdiCOKJp7UYJrd1fBuxJaYRvOjt5oINeyhTc/u00eobPQ0xZdXVNfihrI
         6pTXh3qlwYrMX5jtHpOjjsZfPnAFr9jOtgMfCpS99YtVADz7eZsULiQUkxrVSJHJrsyr
         4R4Gd8n8C9mVhz1o7yjPcT/36h9PmmlfdUDSXDoNCLfdyKO0M3zRRip+8jecXAURBK4E
         HvKvXa6l4UcOsGjeb1/JaT53r57J64WwfBOnSVP8DqE8LqeQzbhOSMBeiXgJbF56L+IM
         BqWA==
X-Gm-Message-State: AOJu0YwmhLRJA+0V36QnQfEq36/eKGgvrx2g10aoEHqApr7y9/Cl5YuP
	U8h3XXtLz6813Sk3TtpyFeakU3HtmsIfvvX4XxjYb6RG5ZFNPmWB4pS8wZT10aCF
X-Gm-Gg: ATEYQzzagGJP6l25vbG/yDzC90z+QBp4wccY78DltlwqunyHSAnYTeKpH1nGXoMcczE
	noqPTR2fP8OSwmWBzJ4gabLTXTOZk3fkv8IKF92j9sp0hgL1ZYSfDlHo4zUkSKlsTpt//WJkGVy
	10/YDjt1HtilKqeB50yzt1K4zvAUJvJH7xQRWxXm+7bdlQzgH4hvuHxzkSffyFqSMg11DuGcu3z
	qDP5DD1TEMyGQMzbK5ff3dWVaPX9jPwXfe58wLdNgmOfDF2PKV/0wU5YwPTDtforune17nMY8XU
	xrZfYEb9XJ/zpbJBQKuL8I1L4Udkq1RO2zS223tiY1YjhSwJHTFmhglYyInFxYcwkWCbYQerwww
	iafXDcde0WMh+Z/e+sxZjxoiJEsEiXAREBslzJFVQ+0y9Aslivvv1xlTSoZ+JUiYEXOAFBk4QRJ
	MVEAxMYc3ML+u0Dkba8jvT4UcOjA==
X-Received: by 2002:a17:907:d2e1:b0:b93:56a4:d6bc with SMTP id a640c23a62f3a-b976537e217mr764917466b.49.1773681599374;
        Mon, 16 Mar 2026 10:19:59 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97846174cfsm505940266b.22.2026.03.16.10.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 10:19:59 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Mon, 16 Mar 2026 19:19:51 +0200
Subject: [PATCH v4 7/7] iio: light: vcnl4000: add support for regulators
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-vcnl4000-regulators-v4-7-854fc2eaf54b@gmail.com>
References: <20260316-vcnl4000-regulators-v4-0-854fc2eaf54b@gmail.com>
In-Reply-To: <20260316-vcnl4000-regulators-v4-0-854fc2eaf54b@gmail.com>
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

Reported-by: Raymond Hackley <raymondhackley@protonmail.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 0a4d82679cfe..5d1408aca562 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -24,6 +24,7 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
 #include <linux/units.h>
 
 #include <linux/iio/buffer.h>
@@ -1985,6 +1986,7 @@ static int vcnl4010_probe_trigger(struct iio_dev *indio_dev)
 static int vcnl4000_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
+	const char * const regulator_names[] = { "vdd", "vddio", "vled" };
 	struct device *dev = &client->dev;
 	struct vcnl4000_data *data;
 	struct iio_dev *indio_dev;
@@ -2000,6 +2002,11 @@ static int vcnl4000_probe(struct i2c_client *client)
 	data->id = id->driver_data;
 	data->chip_spec = &vcnl4000_chip_spec_cfg[data->id];
 
+	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulator_names),
+					     regulator_names);
+	if (ret)
+		return ret;
+
 	ret = devm_mutex_init(dev, &data->vcnl4000_lock);
 	if (ret)
 		return ret;

-- 
2.53.0

