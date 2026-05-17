Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F3C3CCFC6
	for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 18:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779041923; cv=none; b=KX9Lc8FX4v4w3HGkslivT/dWq5PFx3YBxySUYJYMvY8peempajlrrNs3NRk51u2ODgkZm1fNEORCus/TlIm8RfNe3Nszd/sKIAldMhYqmEKukiYj/p8r2yBPLbSJN5GS5C39vi/Fc46UwSw6WcC2XWAgYNqxnWwcC3VxykoJdoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779041923; c=relaxed/simple;
	bh=iS4Jf6/jCwjgAYz7f9Ed6IRXIvpMwekq5NKW96Q/f8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b/j63H4pcQBtmMQAejIKX+tr2q7av3ZWM48euUYlyId1tZuySEEfFw87RhWRr6N9nZt+Pyha280DDaHmSlOeVatyauYJR7w5/Y2e7Ucy6bvyxPJ4PRxaeeyIk6RDokkgNTuEeP7QHWAV0cCBmUo6+XYtACzJTpxLnl+/dbfDMDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=Vi9RLXPM; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="Vi9RLXPM"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-4043b27ddeaso876611fac.1
        for <linux-iio@vger.kernel.org>; Sun, 17 May 2026 11:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1779041915; x=1779646715; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I2YBZV5VY50zazhprv+CHf43mI977/3cuLsJa6SWAdE=;
        b=Vi9RLXPMxPi4neXAMGJVJpXuXbManG/LtuM59QNhoJvagMTJT/c3OtLh/pspuk3z4d
         DmqN1ve5k16cmWA/a87e6lFaOEZ2lf8EYnE67dBXknJDpPC3CSSPBxs3QDpZ+FH9ha87
         ltN5gNrzmhsCCG3SwHqICG1Wr5O3VwG9iD8Zm/G8m6NJ+eizh4vAkhScRPbMGae2LhmY
         IxkQoQhylVF4HDRAnN5HOKHU52o6/ZGc6shWvSacLYPiQr9WiBG1EBnB8AHSY0ieXe+D
         VoHb8v9LSK5NgYHteEUGIskat7Shch46tuRdpSM/CDpIjvWfSDcif9HLp5l9O/LNMh95
         cH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779041915; x=1779646715;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I2YBZV5VY50zazhprv+CHf43mI977/3cuLsJa6SWAdE=;
        b=gNvulrsFfkO+BmWaCi155xQGSzBtR2IfRXb8PrjlQhYk9QAKuI7L6ynxcqh/RH6O8W
         CH/3XmQ9JLZiDzLMCNYnbPGtzOI64+3hTReDWq4BPS7Ngq9Ou5RfMr6L1k+jMYGkS3F0
         w2ckkwi7JyxebmXlNk/klTalylN2lGuEB8Dv6Y8dT7OOcig3QSwJ0Gj8S0AeY+AcU8z8
         KxVx49JXIoWyP04AAxoWUUlOqRb43n9HqQYDmkhAMZZTb5YjodKL6NbRaJ6pZ9d/7IYk
         2tvB4j6yGn4QBhatEqsqBnnB1eO2CHFAa/CevQsCvogrBPmcbXhAfdOabKJOg98ivNoN
         aiBw==
X-Gm-Message-State: AOJu0YySOTqvfAC/Nqzsw2RRqg37a/O5SQtIMyhx37uA0npCcouSp1+z
	KXBZx0PBzoOxuJeSR5Usp9b+7gwFKZePQ12CZkT4Tv70cSqGCHCsJuq1VWuSVLpiQEA=
X-Gm-Gg: Acq92OFXnQglzJSV6RzkjOsJ6XC6EvaRJnxHfkVjG2cUd4QYLM1LzArnRdavrfcMaRl
	BRd15pu3HwvsnYKHOtYtZOGHJ07SbY6p+Z0JkDjP+XTiYsd2pzbxBPpC0kdxPugMB6QLyIFqkqO
	ZTHrcxWAwS4oN1iyNNuzTeS23KFaaFFodVLelElMWbbZWns6AoqLUMFuF8Qr0XNvnPANwhHiAKJ
	FhXCe55EWOf/dwRxZDCzWrfQNgXhfiFEZgmUDippbz+Kh9pvMcwKg6MEDfInyePddxkA0GjX0MS
	ifggLJoDBQyq4WSSO03zWSAEGECJnKP1moDjYMWjPE57bGr2gm2yV0VL2IYuBJMwNDP2UpQYTOt
	cpci1MOWW197mpWnTHNqzHn8d43weRcSm08+P0Bsv2+jFQVNYo8HpLX5hrkYzDboOqFHIVqaiO3
	s7oZMBTyuRHDtZ2wVGSoNtfes1QQI=
X-Received: by 2002:a05:6870:249c:b0:439:cf80:6393 with SMTP id 586e51a60fabf-43a2d9e7bfcmr7616057fac.14.1779041915129;
        Sun, 17 May 2026 11:18:35 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7a4b:ddf0:f61:f58d])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43a95766535sm2085539fac.15.2026.05.17.11.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 11:18:34 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sun, 17 May 2026 13:17:23 -0500
Subject: [PATCH 6/8] iio: common: cros_ec_sensors: simplify timestamp
 channel definition
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-iio-timestamp-cleanup-v1-6-61fb908c11c7@baylibre.com>
References: <20260517-iio-timestamp-cleanup-v1-0-61fb908c11c7@baylibre.com>
In-Reply-To: <20260517-iio-timestamp-cleanup-v1-0-61fb908c11c7@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2076; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=iS4Jf6/jCwjgAYz7f9Ed6IRXIvpMwekq5NKW96Q/f8c=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqCgZY5lNWSWQqxQfk4uVR1kmyHsPoVsVNYqIx+
 qnGwFvJ+n2JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCagoGWAAKCRDCzCAB/wGP
 wPePB/9RG04S1WGAlHEaFY+gM7XX9kJzGfYQvsVLrnb9HziWNIBAox4TGSaD20qYJkSvGsvZU9u
 1Sl57NFRld907Z4ohEajFprIB5hxn76yqOQFag/p4BnUDTBIokjTMi/SQ7+FIy6EK9/q4oT0wCq
 RRZQWdwIjdANiLo+eUBFPSDrslKvprqg6kgLwku9TCLrwbplgFed/uOiDPdZEBoGtuMq0N/CMkA
 FABssCiGug7FzwbCfnfJW8Z5c+Q+DPClR63Xbc2tWTRYdFtuKVf+SIJHb0QMaazTaRHX9ew7IzN
 bI2icbiholgNnAiJFhgHwR6XOd7ByyqUTiseleiH1zZWvil4
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
index 6e38d115b6fe..802c811dcf75 100644
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
+	*channel = (struct iio_chan_spec)IIO_CHAN_SOFT_TIMESTAMP(index);
 
 	indio_dev->channels = st->channels;
 	indio_dev->num_channels = index + 1;
diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
index f34e2bbba2d1..bf49453fc051 100644
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
+	*channel = (struct iio_chan_spec)IIO_CHAN_SOFT_TIMESTAMP(CROS_EC_SENSOR_MAX_AXIS);
 
 	indio_dev->channels = state->channels;
 	indio_dev->num_channels = CROS_EC_SENSORS_MAX_CHANNELS;

-- 
2.43.0

