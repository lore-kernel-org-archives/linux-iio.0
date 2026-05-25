Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F5D1A4F2F
	for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 01:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779673202; cv=none; b=m7qhh7DulDuHDjJNszcSUf9GX52pOjEU6jkR6mVVMYBkIaTymVWH5YV2TV73+LVx0R7CBm3bNuspURbwfSoZOlTmSC3+DWEpQu8L7KM6vGnr3kQlH9Pxpnd0Dqi6JjT1HbagFA3vlEFWtyurhFuVYcSXQ15c2gvFhEQxXVbD3SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779673202; c=relaxed/simple;
	bh=ZT+q1uIcB6+NTxZJlpCOAl/a9R7GwZgj1SBW0pmx/qQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W7ust/bhULOdZ49Bp1TuYnDRdRlrR+ghCXQbbnvSaL8kW8wjTNqOT1nR2ca1NoK7tDQfAJBqawDM7yJQGDf5AvARIKwJUVeW9YhZ8R4CE9TezuJviilitXCZZhgKAwG0obzQamuSJ0H1kR/OAZs+ehdU6dSuXD+1FsSUxP7aAcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Nes374lH; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Nes374lH"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7e615efd7d7so1670120a34.2
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 18:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779673200; x=1780278000; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qAuC+S48oKndwyYOp8JJtJ7EFoaTestnDBoMKOxyMfY=;
        b=Nes374lHvj3kXNCMbNPcSpj1GvBJEDPdmhHVLGlZMvuIGiYpc2W/R2LLqtfSgl5rSw
         Y0866ecO201Ijjxnb10DwfwucjSAT5LfWcI0giszPjJVFwaMBWX9zy/pP5OLQyUXwigC
         IKD8DjcgwoeeCNOdlMDj0sZ9kMSf+zRP6nXnbBu8va0mQDpQjzQ0APgi+re4Uks1mC/T
         f+FzSX/BoqCTU0PHgcnU1BiHPQuYXQ25x77dIrvX4+m214V7H8aKRW7ZsLlfQ71QyzLN
         /jnciPBkiqY6aGA17NFu47alEvRZk1s0vG6WDii7dbMCIsjDeDgkfFwnOl1nj1kUwEMq
         s0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779673200; x=1780278000;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qAuC+S48oKndwyYOp8JJtJ7EFoaTestnDBoMKOxyMfY=;
        b=AtrkDSvuQJEkOXZsQU+ObtLnqn/M+8aA7aRIV4xgjHGECBQIKYepSHKMMpoQttZNY9
         XVlopHnOeYM3N0EedV2S6AAu4itJCL8IkdE4U6FZKwmtJZiBYOPx7QsB7aRnjnHrS8Cn
         JBXt1/jhfpykrshxIRCUzHvS/IIUhOhA5YXgzzRTqMlKGlX9un5r30ozyZtnCEvwuFk1
         OjWTF5z7jl7sv2Ts9snWFQcCPbqMV8zJMdjDnHlfQRFyDvnJgLzTZuVKsWjpwBvO1NYX
         hlhEglBvpsDOmeKJVMbJEKVPrBH1GB7UewaQ/MSFH2If/yA0b+AIUxp/ynsOLrpSRSlB
         o6gw==
X-Gm-Message-State: AOJu0YyBp7Dvfdk7q0iBO0d0yOniMdCTbe7rocz6h4mJDyACVlWzJ1Z/
	8BzopawSOhQATWEj0J7azv3toEiMiANDSgZrlIePdpEIy6SRWStzPbk+Z5LgYtL/fJ8Kj5Idl23
	fbOKLHTg=
X-Gm-Gg: Acq92OFtMh1jj4ABojc4OGpXUGi56SicmjS2PpCgSZHgbZ9MSnWczUsNEw0/XDblC4q
	W4m+sRWU8Sk0Lu2PQQhelfZuqGadMKyxT7/moLDU06LFEBMzlgK0Jv3EHHGHqcKlO8XkEBdG0B1
	/FeZIYitTKzb8EV/+ovs3P8rK9lbBXy3i3FKU71EUwzHfjcz9TKtRr5tc36ctZv6GnycmJTpXrA
	+pOBU8Fym0ejF1VHYr+3Ah8h9iYEdDk4bJyan4qL66iQYFAnHC6rEy40WoSnPxe4SURFQajIAOL
	9vvQYj8vuyVHPaOGDZfNfQfOEDtbIw+L6dAp+Q2QlpMGrCNXiW8BhE0etmHkE170/DOXlHwOxqO
	PJxdp3ALyKEwoxY9kVQeYwzB9DGlwgM8FvMLItffn0eGJ+gAOLG818661CcPZdhxejjegfRjFiD
	q2666mBRcKWEfaGqaAm6QxC+MNqLTU94156lkCNFo=
X-Received: by 2002:a05:6830:6182:b0:7dc:cd0b:58ac with SMTP id 46e09a7af769-7e5feda98ccmr8635037a34.9.1779673200405;
        Sun, 24 May 2026 18:40:00 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:713b:3006:84c3:c1bb])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6060b2dffsm6250206a34.0.2026.05.24.18.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 18:40:00 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sun, 24 May 2026 20:38:39 -0500
Subject: [PATCH v2 7/9] iio: common: cros_ec_sensors: simplify timestamp
 channel definition
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-iio-timestamp-cleanup-v2-7-c37c9408b7f7@baylibre.com>
References: <20260524-iio-timestamp-cleanup-v2-0-c37c9408b7f7@baylibre.com>
In-Reply-To: <20260524-iio-timestamp-cleanup-v2-0-c37c9408b7f7@baylibre.com>
To: Jyoti Bhayana <jbhayana@google.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, chrome-platform@lists.linux.dev, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2032; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=ZT+q1uIcB6+NTxZJlpCOAl/a9R7GwZgj1SBW0pmx/qQ=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqE6hM39CnRhd7ZB2gP19BJ4GLnYKluJq5+aC4X
 i8XRKRITNSJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCahOoTAAKCRDCzCAB/wGP
 wAskCACfNSL5Vz4Cx1MbQaKk90iMp4pl1QLQYrJOWI95BPLFaXenWsYkLPkTMIjVPhfG9LBUqi7
 BIIzwLhw03+63ZtMhBxMIK8+lf/QcMewhBjifvxlt35sb49gsX+MVkKjUhZf3NYHeBjw49PiCEo
 2ek/mmaAv2Q4Y768kMkOKz0BjszAZSWygmYZBUKEO1pYKXECEBGTz+eeGwEuHrqcyw/kb1nCQ/Y
 a+oX3tZKu7pSI2yIoR8FPd9ue+uDqxisYZFGiifQgGkD+WoXw07zgBvRLEvYmJ9WocRMkN+iq1w
 GG6J7I+0XDN9HYbw17EULER6YA+vgzT6NaSrOGJYjEogLbRM
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use IIO_CHAN_SOFT_TIMESTAMP() to define the timestamp channel instead of
manually filling in the struct iio_chan_spec fields. This makes the code
less verbose and mistake-prone.

Also drop obvious comment while we're at it.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/common/cros_ec_sensors/cros_ec_activity.c | 8 +-------
 drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c  | 8 +-------
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_activity.c b/drivers/iio/common/cros_ec_sensors/cros_ec_activity.c
index 6e38d115b6fe..6762685e6876 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_activity.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_activity.c
@@ -279,13 +279,7 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
 		channel++;
 	}
 
-	/* Timestamp */
-	channel->scan_index = index;
-	channel->type = IIO_TIMESTAMP;
-	channel->channel = -1;
-	channel->scan_type.sign = 's';
-	channel->scan_type.realbits = 64;
-	channel->scan_type.storagebits = 64;
+	*channel = IIO_CHAN_SOFT_TIMESTAMP(index);
 
 	indio_dev->channels = st->channels;
 	indio_dev->num_channels = index + 1;
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
index f34e2bbba2d1..651632ccfe0d 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
@@ -279,13 +279,7 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
 		}
 	}
 
-	/* Timestamp */
-	channel->type = IIO_TIMESTAMP;
-	channel->channel = -1;
-	channel->scan_index = CROS_EC_SENSOR_MAX_AXIS;
-	channel->scan_type.sign = 's';
-	channel->scan_type.realbits = 64;
-	channel->scan_type.storagebits = 64;
+	*channel = IIO_CHAN_SOFT_TIMESTAMP(CROS_EC_SENSOR_MAX_AXIS);
 
 	indio_dev->channels = state->channels;
 	indio_dev->num_channels = CROS_EC_SENSORS_MAX_CHANNELS;

-- 
2.43.0

