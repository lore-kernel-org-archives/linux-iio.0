Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626BB3A2565
	for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 11:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773316406; cv=none; b=GHGU7MT9tEnnNlruNvt9bqCdOyC4ow/Bt8HxI2Ysu5AYS8BnaSLzTMNanTpCTUfFha7aBe9dEftiYvlJN3AIwmj+To5OM8/v7ntFK5u8dFgLSQF8p8YqC9m/lANMv90mu517e39G60J5AUSIaWxRxcaJ0WSnQtWyNYlQod8qZks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773316406; c=relaxed/simple;
	bh=6TUyoJLJSqeungB5Dy08vZAqsI6zizoCJy5q8AmL2/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jaPY33h9Un5bki6DI5r+7sdwqpYAtvPINlNhqXO8cya61jdBAfoNyOEW+S8bF9KTkXMwTrS5OTw4t6dNwfme6OOxXCi1232ZJbNb0z/Zx7OfVGz1JY4u/oMtoqpLL3/bX5S1DYycFVBl/YQ4P7ex3OPhVNmqAS4hIOTiohQJra0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxLbspGt; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxLbspGt"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48374014a77so10303125e9.3
        for <linux-iio@vger.kernel.org>; Thu, 12 Mar 2026 04:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773316403; x=1773921203; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zJtLWo5ws6cOY8PPBgpE01aNyBcJ7pcov+uZ7h1HS6E=;
        b=DxLbspGtxz9Q6QNkA6okY2YiBQNjpHb4sbbGAYsNfczWxfyTi8gijMyWahB+xf5Il7
         9Cu9x1uwC8gYz1janyFJvW2Jrl/45h2weuIa0T8o7/cL/I5HDHXP0ZRCd0m/q3bkX+LT
         sN/2TsH2EyzMK6ka0PYNHUOHTCn2d1cZEKKMPykwnFL0UjQOjv2wNYerZjNA3PvzFjQT
         yzlhgzL5KetUJTSMfn0VlW/QUT2W8FuC3agq9Zo7OVeUSuMgVus2ud0HLs+f9k40CG/X
         JvyrmC08JE1sszAEmmbOtk7hJGG5/XhcAjQGWel0fe+Jgz7ojURYAxD6r4zLhn4G38vt
         w8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773316403; x=1773921203;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zJtLWo5ws6cOY8PPBgpE01aNyBcJ7pcov+uZ7h1HS6E=;
        b=cFbCK9PZ+YP+DupNcG2bB/73SAgHRUCUu1HAblU5yVVsGNrneiD84gEYr/aTC94Cpl
         XzradKPMgzmJuzJ1+J3GtmRbrzmJy/nIiRHPIJt8wvSOrMxJJJVOHZKMlGHHvP44j5f3
         39N+V+jeVElRI736yGT60f9BkCxR0Op/4ko0SNM85xC4xxwwx2lOa7TuS5tp3NUXqgDS
         Tj/wyLxuqQlTZ7bJkoUgNkniTLt1fJJusPoBYCgaj9Lh9mWtOTfOEJ/YVyG3xIwillne
         nlA8dzDg/SjncEjq+bVbX5BQbHrXxLssU28yIjOWv8hQ2t0WenOrsxlfnR6WUQThnefq
         t/6g==
X-Gm-Message-State: AOJu0Yy071Yi48eP1oNyD9UFK30+YAgw2r/N9PTbPzBrrxTOA0cHLBEM
	7SKLlMXKCiYrflI4fI+737koWfFBPU7c4rtkT9wd/6pt321SKw1m9AAg
X-Gm-Gg: ATEYQzz+E+lwovj22zw4m9M1aKGD7qhBW78lu9CiCTlM51u7sk6DsKP1aMm/8DJOO4C
	dlnKpnA76FFdx/DljXMFskLPRNq02mDV04iKE1jgtIDqrqMVte0L8EKMIdCt+HcrtEzk1RYmCfD
	WSJN1JTsyac9Ro/1eETlNDaNYam99sDelnb3cYurQUa+SXVPcC6eAJYvDoe1k0KobH0w2Epit1y
	KdZAYwsXJl5k+g4ezPjpNdbL2d+1NEuwQ27H0rKP6M9G3d+hmSP0J9PMljvixOsHDYopjtnotmp
	1PbzWAbQK4hCJEG5DeInJBQ8I6nKyjQSTFSpQC2VvGSHBLjYBeyOsC2bdUAkujp4+Gi2bzmwVMR
	bXLRU7b3ONK7RgCmZ8mfIdTQih0Y9I5epcRVXjqpinC3bzUt4K+pxoEnCOEtUZuwrbeSd90dfh3
	hfAucn3IdC0SwzkAm18qvrvNlv/g==
X-Received: by 2002:a05:600c:19d4:b0:485:3ae3:b394 with SMTP id 5b1f17b1804b1-4854b158082mr108421115e9.31.1773316402466;
        Thu, 12 Mar 2026 04:53:22 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe22529csm7044960f8f.31.2026.03.12.04.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 04:53:22 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Thu, 12 Mar 2026 13:53:14 +0200
Subject: [PATCH v2 3/3] iio: light: vcnl4000: move client->dev in probe
 into a variable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260312-vcnl4000-regulators-v2-3-2bdebbcbb58a@gmail.com>
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
 phone-devel@vger.kernel.org, Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.14.3

Move client->dev into a variable of its own and replace all instances of
client->dev being used by it.

Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 04bde498aec4..36a3d8075eb3 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -1987,9 +1987,10 @@ static int vcnl4000_probe(struct i2c_client *client)
 	const char * const regulator_names[] = { "vdd", "vddio", "vled" };
 	struct vcnl4000_data *data;
 	struct iio_dev *indio_dev;
+	struct device *dev = &client->dev;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -1999,7 +2000,7 @@ static int vcnl4000_probe(struct i2c_client *client)
 	data->id = id->driver_data;
 	data->chip_spec = &vcnl4000_chip_spec_cfg[data->id];
 
-	ret = devm_regulator_bulk_get_enable(&client->dev,
+	ret = devm_regulator_bulk_get_enable(dev,
 				      ARRAY_SIZE(regulator_names),
 				      regulator_names);
 	if (ret < 0)
@@ -2011,10 +2012,10 @@ static int vcnl4000_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
-	dev_dbg(&client->dev, "%s Ambient light/proximity sensor, Rev: %02x\n",
+	dev_dbg(dev, "%s Ambient light/proximity sensor, Rev: %02x\n",
 		data->chip_spec->prod, data->rev);
 
-	if (device_property_read_u32(&client->dev, "proximity-near-level",
+	if (device_property_read_u32(dev, "proximity-near-level",
 				     &data->near_level))
 		data->near_level = 0;
 
@@ -2026,26 +2027,26 @@ static int vcnl4000_probe(struct i2c_client *client)
 
 	if (data->chip_spec->trig_buffer_func &&
 	    data->chip_spec->buffer_setup_ops) {
-		ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev,
+		ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 						      NULL,
 						      data->chip_spec->trig_buffer_func,
 						      data->chip_spec->buffer_setup_ops);
 		if (ret < 0) {
-			dev_err(&client->dev,
+			dev_err(dev,
 				"unable to setup iio triggered buffer\n");
 			return ret;
 		}
 	}
 
 	if (client->irq && data->chip_spec->irq_thread) {
-		ret = devm_request_threaded_irq(&client->dev, client->irq,
-						NULL, data->chip_spec->irq_thread,
+		ret = devm_request_threaded_irq(dev, client->irq, NULL,
+						data->chip_spec->irq_thread,
 						IRQF_TRIGGER_FALLING |
 						IRQF_ONESHOT,
 						"vcnl4000_irq",
 						indio_dev);
 		if (ret < 0) {
-			dev_err(&client->dev, "irq request failed\n");
+			dev_err(dev, "irq request failed\n");
 			return ret;
 		}
 
@@ -2054,7 +2055,7 @@ static int vcnl4000_probe(struct i2c_client *client)
 			return ret;
 	}
 
-	ret = pm_runtime_set_active(&client->dev);
+	ret = pm_runtime_set_active(dev);
 	if (ret < 0)
 		goto fail_poweroff;
 
@@ -2062,9 +2063,9 @@ static int vcnl4000_probe(struct i2c_client *client)
 	if (ret < 0)
 		goto fail_poweroff;
 
-	pm_runtime_enable(&client->dev);
-	pm_runtime_set_autosuspend_delay(&client->dev, VCNL4000_SLEEP_DELAY_MS);
-	pm_runtime_use_autosuspend(&client->dev);
+	pm_runtime_enable(dev);
+	pm_runtime_set_autosuspend_delay(dev, VCNL4000_SLEEP_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
 
 	return 0;
 fail_poweroff:

-- 
2.53.0

