Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795638159;
	b=mnM2Vac3BEFjY1w0X2HzgFvkzF+MXYEl22sj7Bujuu/BvL0+wcWP8uRg7CiEpAkSaNEZ
	 6ySe4MlAPjhyvwmgtqiwbXnH4rf33toQLhMt9BdNOIURqyN3NzI71fLHf8ewN9mO+3NsW
	 ONoLHS2aHr/sOiOi3juS5jAqx5QQ9to02+VnHu/qCDql+g5tbGjiwz8uEuSIgykQD7hXP
	 kZoEqBv+liAuQ+aH2vTdad+3kAuGKqQ809HDtKmVZOdkeKFFjyjKDrofCfoKPLy9qA33K
	 N7MyFZQyuwsi1twHdY2sngAwQIbjFnY1o6b3kPcKEMLAONycuu528yXlyEzQ5ZNE1rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795638159;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=pgnUeUO8I19NQs/CTfh4hJgcQtU+xPIOCdAi0uHfl8s=;
	b=bjYJU4u5bHRZVlWPlo7xfZMuDV/KySo7xE9EP5WESwoACJllwC7KjEQBF7xah5QFxMJ9
	 SsaFb8J08930nKQcGqUQp2pLN1mdVTAUKgYlr6ILLhJuHQuohFM/VsaGjQaUOlAPkABM8
	 LNyhl20pzvXH0lNcfM6ivnyi0oVDcy4gPMQlZErMnLLzm3e/vJpHqiFVt7AY0HXZZWhN4
	 f5kg+Sl+oT/neXGe2z4P3Vaji87CARQ6WeDfmN+VpPdECJ7EUvIrINXn0N3Ex1CoMYhiZ
	 pxtBGcJkqOka21droILVcJF8BJbODea2himcaE3LrMwON809EPjbRR4q0AoL4lhJVgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=telaak.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445D9606A685
	for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 20:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 445D9606A685
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telaak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-67da3d03263so6541741d50.1
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 12:22:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795638158; x=1796242958;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pgnUeUO8I19NQs/CTfh4hJgcQtU+xPIOCdAi0uHfl8s=;
        b=l/dMW06FGwpNiwe4u5pRktK5b7NBuTw95CAlCLGV/YL9mcsVK9CGaLFKc9gkODiT7m
         e8iAAB9XY9lQFks1kSw+u4i4Mf3u0Tj0brWUHAa+F1W486H2IG68g8WDb32A7Y8GTx2P
         g6y7y8UI3yi8ompuGTWkDpzYSy1rRfPn+w9/oImH0Hrftc233u3RnYode27tlfCRJ/h/
         rVgnA9MhIMO+viZvIhQ+Ab2e+BhAx7HjCGKelCSBsNsY3nNjyew37LsFkVQS+hhAP3Xk
         MmtONS7G+KLh167OBrV5qsrd3iaUn3h+oJdeH1TZ0aIApJUopQLffxtoCgPt6AN5oiTM
         NWpw==
X-Gm-Message-State: APuU4Z/eifDPc/GSWOE+/wMP+CVe9fE5qm1bbRgyBBMcsybQStgpetJ8
	mSjYVt8HWyh/me8HAIdrkbrvaHNHehvi+ZBtedUW2S3/G368Ds6KpqLx
X-Gm-Gg: AZFdTZf/8u1pukyn/h99K+dNrnl+sDpFuvRb1g52EAIr38Lg14bNQQO/hqSyBnz5yUs
	Ua6wNuQe5YAd752F9ZOGH70JjDHS83XiI72S3k2v9KCIymLvO9OfaYqYGtLyjBrxicPrlkMS2bf
	2wos754UwlcFG8CYeohRnIIkHrMNzxLdslO3iUk/yaUoEeBolI9Z7SBSVJUF+aONS4RdDwQwB/U
	ftD9TV9m+BI1J+ydNNmHEVE4mHLhkPyEPD1BIXz5b3S2Q8E8f9Aya1i/7vv2rCgJQjSbYVFQv5Q
	rl8EaRs+N6LgdmIwvcKHaEsG7r1etyNStckAFVbYLEsPdzIreblpv0rhWHs1ShrkMRjHYzTQo6h
	4bs9NDSvJQn0xmbI71rkiNlcokTAf653Kd4R/y1JHgiF5xHPnfsD2qeSrTkUlxdOW6R9YTE135p
	unSimX6APVBVp80k1WYSAcxtloRlIXbex9VcKWVbb1LN4UH4A0wuoRz7DNfuTGD6AQqWMl/FFvn
	p4v7G0Quh4Q7xkQ5cf7x5vrgZPkqqDBSjU8G5BtxToZD83BTMz5eot+1YTUS7qxxrPx1OidOPSK
	5/VXmpF0qD9vdjUwMrmv5epTgOFDiq2tsPoXKtHhdVE1PPFwCiHrW/46LZAoENSM7rqi9or1wjR
	iAt/KVCA78afTKCrrUmEzmNDx4jxd881wys83Q41qpo4KGh11+cSVmxyU8m/4eJad9ILlKetuhZ
	l9Uqhx/XL4Og9wXLrjnbpUFH9R5PG9zvf6bxveYr2+8iID4g==
X-Received: by 2002:a05:690e:1905:b0:675:33c4:52d1 with SMTP id 956f58d0204a3-67df42b5a2amr7810425d50.6.1795638158345;
        Wed, 25 Nov 2026 12:22:38 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([71.68.170.161])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b5201bb6c7sm77074377b3.6.2026.11.25.12.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 12:22:38 -0800 (PST)
From: Joseph Telaak <joseph@telaak.dev>
Date: Wed, 25 Nov 2026 15:22:31 -0500
Subject: [PATCH v2 4/6] iio: potentiometer: mcp4018: Turn on the vdd supply
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
Message-Id: <20261125-iio-ad5246-v2-4-8feeb630f0b6@telaak.dev>
References: <20261125-iio-ad5246-v2-0-8feeb630f0b6@telaak.dev>
In-Reply-To: <20261125-iio-ad5246-v2-0-8feeb630f0b6@telaak.dev>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Peter Rosin <peda@lysator.liu.se>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joseph Telaak <joseph@telaak.dev>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux@analog.com, devicetree@vger.kernel.org
X-Mailer: b4 0.16.0

Get and enable the vdd supply at probe, so a board that switches the
potentiometer's supply gets it powered before the wiper is used. On
boards that describe no supply, this gets the dummy regulator.

Signed-off-by: Joseph Telaak <joseph@telaak.dev>
---
 drivers/iio/potentiometer/mcp4018.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/potentiometer/mcp4018.c b/drivers/iio/potentiometer/mcp4018.c
index d6387645853d..6ca6cd7cbf71 100644
--- a/drivers/iio/potentiometer/mcp4018.c
+++ b/drivers/iio/potentiometer/mcp4018.c
@@ -14,11 +14,13 @@
 
 #include <linux/array_size.h>
 #include <linux/bits.h>
+#include <linux/dev_printk.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
 #include <linux/module.h>
 #include <linux/property.h>
+#include <linux/regulator/consumer.h>
 
 #define MCP4018_WIPER_MAX 127
 
@@ -169,6 +171,7 @@ static int mcp4018_probe(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	struct mcp4018_data *data;
 	struct iio_dev *indio_dev;
+	int ret;
 
 	if (!i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_BYTE)) {
@@ -176,6 +179,10 @@ static int mcp4018_probe(struct i2c_client *client)
 		return -EOPNOTSUPP;
 	}
 
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable vdd supply\n");
+
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;

-- 
Git-155)

