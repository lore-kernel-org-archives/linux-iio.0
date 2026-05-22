Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC33C3BC667
	for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 12:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779453270; cv=none; b=pSdrjITka9Td/efvSiX2GH1m++uDCrCn9qytYs4qspRlfiZiYt9Nd1Qw2HuFwh4POghhUoO54+5Mf6mMyqzhIeXc57LLpL+FyV4sMskQmO59ppl2g7yagXxscFZVTH1gI8ga1PGuejjuCAqRhU4pWm9N1qnUr/LE5PDaBmHsHNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779453270; c=relaxed/simple;
	bh=GgdK1NdF3v1bW+YEFIuLHRfz4sXog4cMyMCRp7zuipk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbypfo3ccXLVvVVPoQCT//pcoB820pADGf9lpl4JCcf/vTYBFy3bLle+hviE80l3xozevO7vH9GPsJdGoP4R5gXsew7AmHhXjGST4l+GuGreLMh5oGsMja+h3iAUe1q3lUUPDELZpjMig4PF75PvAjZ2fEpPLY3b33wy/Yb3330=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MjT8xFIU; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjT8xFIU"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso14615315e9.2
        for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 05:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779453267; x=1780058067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9MVD6i7sa82Oj//XUlVTMNpu1VIZIfx70ZqUMN7z/Y=;
        b=MjT8xFIU9E9ksXAAmQC0F59oOLHZRrLA3YkCjbnsEMWS2nawkQ3EGr/gPlPw0hFDyj
         8WCIpvI6y5H47vu6lyLeYYSfBK8lj4/7j19XNXqT6jYY5y3v4xI8g9WDLOoCdKciVEew
         HkE0YAeBeahYTeW6rJF7lALUh233DqKYaH7SHbEByCeQaObZHBvDEZI4rlYgdM9pPF0c
         FN8ptrU097zwqDyFbyy5hFU5RteUwrCLuQSvu+AcV4dQweCNgkAx7Xs4FjvEEq3dlHYR
         0vyXgoCsIdtnJfkIOEjHYaCx+IPjEgBKc6hz7KoYYxXmfodGh2jmec0mmCzNiXarK6pP
         eP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779453267; x=1780058067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/9MVD6i7sa82Oj//XUlVTMNpu1VIZIfx70ZqUMN7z/Y=;
        b=NIF+TFzl7aKtUYeMvTU0n3WK/8w7RofE4qetcD1sQkS4o9m8fclPRSMJxZMv47GwQh
         7TU5e14+SrhvD+My74GQ1rNl5TRXH/VjLUkvBKn1ivMoGotV7DOd7bGEx5LAI5ncIEK0
         Guv0+uBNDdGXbvW9+dOH2R64SMHUAX7Ij1431X50ojfSg/NxDQmuv1OrdBqYPwLMko46
         HINlDcGmfhmpaK/drMaf6/B/aKlpSFUB3TI5n34VnGr4V4hJVoLoFlqpmRn0BX4Q3s6C
         myASW5DpUGMKCfbQo/xyyI880U+iL6jkr0sz6//olkn97HUQZy1pUlySRLH52CIKl933
         HFpg==
X-Forwarded-Encrypted: i=1; AFNElJ9EopGuf/hl03Uv3xQY+CVSIjeydKNXJYgyCvmQDFuRWFRt1byjs322+N0VVa6hG5QhF9859IzM/Yw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdas2fAAU0f58dzba1+HbvQfoPOi/d72yWYEfCHf0w5qocN2ms
	1X/GSUEoDcQKHtID2PaVYZhlMLL+7kd/VDQtc5mX/eTrd+MbMW5vMqT4
X-Gm-Gg: Acq92OHANOaWB3XbVzjVH3tAEc8cltE4MsBdDA28cpvH5LueeaCD82FdOJEZdtK0G7e
	WtCfFLn8/DnmRacip/KMpJpe0ry94ocMaVwfgDowUHPvi33/wPXDd7xa8K0Z6xvtC80ZGMuBNIv
	msdIDdigOvUgcw8+45dnDHdenklnLshvdVyoc8N/BbEehNersITp36x0aVBrX3gckKGa10pascU
	oKxoTV8NNMdbsVg2kUjWPlwu66p473SZqw1GCKb1eUJYAiY9oPtvnBerpcl97de+/OADgWNdxF7
	GYllVL6Noqd7CCNxX+V0lS4TteDc9j/nP7nzfE95/vfT1cqLEl69W3CVd4m7lpUU+L/pf7NlhzO
	AVkzbMKET9YNylN7sF/e8uNN+Xp0vHXXlX5N4Gaqfk3gkDKL+yNAmLgF69838+U2q7ygK2jzMz7
	1AVaOcM3NGI7JSpux7/msPPGfAZqm31u7bkyBBYEItbDAdl+fBI35H
X-Received: by 2002:a05:600d:108:10b0:48f:fe2a:107b with SMTP id 5b1f17b1804b1-4904249d1f9mr36827575e9.7.1779453266742;
        Fri, 22 May 2026 05:34:26 -0700 (PDT)
Received: from aldo-conte-t14.tailf68ad9.ts.net ([217.61.173.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49042af0ac1sm14760175e9.31.2026.05.22.05.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 05:34:26 -0700 (PDT)
From: Aldo Conte <aldocontelk@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	shuah@kernel.org,
	joshua.crofts1@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v3 5/8] iio: tcs3472: use devm for resource management
Date: Fri, 22 May 2026 14:34:16 +0200
Message-ID: <20260522123420.45495-6-aldocontelk@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522123420.45495-1-aldocontelk@gmail.com>
References: <20260522123420.45495-1-aldocontelk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the driver to use device-managed resource allocation:
- Add tcs3472_powerdown_action() and register it with
  devm_add_action_or_reset() to ensure the device is powered down on
  cleanup.
- Replace iio_triggered_buffer_setup() with
  devm_iio_triggered_buffer_setup().
- Replace request_threaded_irq() with devm_request_threaded_irq().
- Replace iio_device_register() with devm_iio_device_register().
- Replace mutex_init() with devm_mutex_init().
- Remove tcs3472_remove() as all cleanup is now handled by devm.

Use a local 'dev = &client->dev' in tcs3472_probe() to keep the devm
calls compact.

Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
---
v3:
- Drop Suggested-by: Andy (inappropriate tag).
- Drop powerdown bug fix (now patch 1).
- Drop powerdown/resume RMW refactor (now in guard patch).
- Drop TCS3472_ENABLE_RUN define (now in wait time patch).
- Drop dev_info() conversion (now in separate patch).
- Add devm_mutex_init() for the lock (suggested by Joshua).

 drivers/iio/light/tcs3472.c | 63 +++++++++++++++----------------------
 1 file changed, 26 insertions(+), 37 deletions(-)

diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
index d7b5805108f6..4966abf83c18 100644
--- a/drivers/iio/light/tcs3472.c
+++ b/drivers/iio/light/tcs3472.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/pm.h>
 
 #include <linux/iio/buffer.h>
@@ -445,20 +446,28 @@ static int tcs3472_powerdown(struct tcs3472_data *data)
 	return 0;
 }
 
+static void tcs3472_powerdown_action(void *data)
+{
+	tcs3472_powerdown(data);
+}
+
 static int tcs3472_probe(struct i2c_client *client)
 {
+	struct device *dev = &client->dev;
 	struct tcs3472_data *data;
 	struct iio_dev *indio_dev;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
-	mutex_init(&data->lock);
+	ret = devm_mutex_init(dev, &data->lock);
+	if (ret)
+		return ret;
 
 	indio_dev->info = &tcs3472_info;
 	indio_dev->name = TCS3472_DRV_NAME;
@@ -515,46 +524,27 @@ static int tcs3472_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
-	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-		tcs3472_trigger_handler, NULL);
+	ret = devm_add_action_or_reset(dev, tcs3472_powerdown_action, data);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
+					      tcs3472_trigger_handler, NULL);
 	if (ret < 0)
-		goto error_powerdown;
+		return ret;
 
 	if (client->irq) {
-		ret = request_threaded_irq(client->irq, NULL,
-					   tcs3472_event_handler,
-					   IRQF_TRIGGER_FALLING | IRQF_SHARED |
-					   IRQF_ONESHOT,
-					   client->name, indio_dev);
+		ret = devm_request_threaded_irq(dev, client->irq, NULL,
+						tcs3472_event_handler,
+						IRQF_TRIGGER_FALLING |
+						IRQF_SHARED |
+						IRQF_ONESHOT,
+						client->name, indio_dev);
 		if (ret)
-			goto buffer_cleanup;
+			return ret;
 	}
 
-	ret = iio_device_register(indio_dev);
-	if (ret < 0)
-		goto free_irq;
-
-	return 0;
-
-free_irq:
-	if (client->irq)
-		free_irq(client->irq, indio_dev);
-buffer_cleanup:
-	iio_triggered_buffer_cleanup(indio_dev);
-error_powerdown:
-	tcs3472_powerdown(data);
-	return ret;
-}
-
-static void tcs3472_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-
-	iio_device_unregister(indio_dev);
-	if (client->irq)
-		free_irq(client->irq, indio_dev);
-	iio_triggered_buffer_cleanup(indio_dev);
-	tcs3472_powerdown(iio_priv(indio_dev));
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static int tcs3472_suspend(struct device *dev)
@@ -598,7 +588,6 @@ static struct i2c_driver tcs3472_driver = {
 		.pm	= pm_sleep_ptr(&tcs3472_pm_ops),
 	},
 	.probe		= tcs3472_probe,
-	.remove		= tcs3472_remove,
 	.id_table	= tcs3472_id,
 };
 module_i2c_driver(tcs3472_driver);
-- 
2.54.0

