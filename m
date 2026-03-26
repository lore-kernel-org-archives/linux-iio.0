Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FDB3F0777
	for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 12:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774527110; cv=none; b=HQO/Qhrxs6Vgn8ozVC+NCl9WLFwHVDjI+pQtIvEQ9KufYjR+VXNjkCP2oWYU+B0iFHmSZaGbv4b3atqLk6tNlnhYtII15JFutbjo45+0X0AtVIIZ83GqjqmZJW3+M02ytifs1DI8HAODJ6QNRCsIy4tAQpYntBlaPSbvymQdFgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774527110; c=relaxed/simple;
	bh=q5VeKQaMOeAzIRvj0zdKA5E5UwciJ+dVl5nvFwGPIVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PwAKFxo8suMZZfGlQfJLegydQn7g7VOi6AVWfB+kKDMxlePnnyvh1OS1Fkrsq7Yc7oTchdQd834hnpp6TfEfjBIANhoBHAkczDKvaMRNFlIU+rcLtkHLkrLukqjM2DnZrM+Dwu/pwqaRyB1olYBXYrOR0IYrrKTl0qgKbzVlvgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FC7svJ2R; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FC7svJ2R"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2adbfab4501so4100285ad.2
        for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 05:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774527108; x=1775131908; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jt1VHbnznQyLT9ogy/s9keX/4mRMMLiQg9FocJbWV7M=;
        b=FC7svJ2RA1cD4RkKhptnTvP7Rf5IP8yjY64HM5Caa93WSkuIr9f4hWaqQD0UZa+ZLQ
         6gBo/09jqUPHTfs9smmH/dWmOU3VsCfKlsK1KM/JmjaW+vTmXXPgPzf+27TJ04HachIg
         KOMzrxXanXOPgWjP0bVpDtKcx+Yer4BJevyACdzxjioVjVji2IUZ/Sw8AZLu9LOs1WvX
         7SLCVwDVLPRicuJ+V3y985RHH3H2VB537an9QvpB9qVSHOaEJSR7bldGkdBbKPBNkTgz
         KQ19xIB0WwiM4qkL0xvaQuVjnW9Ismx9jVIchdzQjYNpn8IIYVrfbjdAXw7F/QeS+US2
         DnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774527108; x=1775131908;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jt1VHbnznQyLT9ogy/s9keX/4mRMMLiQg9FocJbWV7M=;
        b=cGJRi8p31zB9AN1EkRNdyqCLiaw22cqBMCF8atJwDCU+B6cnMyOsnGYEsxzB5sZMml
         8ALphsMmlYa3m4jwCfByhu+P1IH8QXQoc326P3l7IjWo8nkmBwuaAmWytMa5x6viT8Ay
         oZKnRhxCkhgFAvwwqsW8znBRpFDFL4+b0XOAuAqdwYprVfUOPuWMF/F4Cbpclx3jvFOy
         Ay3nQNaJArvmDIOqpCOOWTU5asmu9xC4NVRY4+ScEn2Qt2evNJ3NRrVNKAz0TPNT8uKV
         VbMaLXZiGMvwKaaNXv0GshUxR/Hj1kP+k6m3CDqxMit8roEyiobzzcKkbQHOIQyAgPXj
         /GNg==
X-Forwarded-Encrypted: i=1; AJvYcCXwrTfSpP9GCf6fXZcIIMAwWwmeA3+T9PNDJUKwY1oaoKks56bESILjqr95jbluE+DEpnQpcKRE6xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMOQKqmXJHmpXV4AYFkvysBT7KDbHeFNj4zx4IT/qaSMmT2eCc
	oSHBue4GpXDTZ02+HYl6hHDRMsM4Va6h5B7UA/La6w80tKOnq0k/LoZ0
X-Gm-Gg: ATEYQzxtfRkgkhGuYJicYqjr49D1xYdPH49Q/zQhU0M/rEKmKH8Q1QZZtYu/5ihH2oU
	wT9BqB02XRYgX6VarJhZMs3xi6GNlZckbekGREBQJwMwKSfzQKkvYvyBb94QopzeqFZXHkNzNKw
	hn6nkKOOpZLWof28zOImJPpBCkgKan+TrLKXZqE5NrrtIk9UUZnKyinlaWOzlA6Fa1Le0+phoEK
	E6JN0vDNu0Ps7Pd+PYfkYPVdJKLgurRDvT8zh/AiOI7ci39kIiXDwXxp1IC/G4CnyVz5/Gzc+3G
	v3aAGX9AGHu9fu0tQrwETfgjJrPGxNqitF+BQWjDp/+UFwU49oc8v78qByqW3g9x3xV6OLjvVR4
	MkJjBrKuYxaHd6uFpk9dG+QqlPCBmiq0Fz/AXW/Nsb2/1JondHBXB9mSktdwGcBOzA7e38Iad3x
	1JyOCH+Gs0TVE0dA6A/hHTGAxALxPtA1mpAHAow8Q+l6805ac=
X-Received: by 2002:a17:903:234a:b0:2ae:4445:f39a with SMTP id d9443c01a7336-2b0b099d271mr76407185ad.7.1774527108015;
        Thu, 26 Mar 2026 05:11:48 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.167.147.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc87e820sm27623345ad.50.2026.03.26.05.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 05:11:47 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Thu, 26 Mar 2026 20:11:42 +0800
Subject: [PATCH] iio: light: veml6070: Fix resource leak in probe error
 path
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-veml6070-v1-1-5d79022e76f1@gmail.com>
X-B4-Tracking: v=1; b=H4sIAH0ixWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYyMz3bLU3BwzA3MDXUMTC0tzSwsDC/OUNCWg8oKi1LTMCrBR0bG1tQD
 A1fHqWgAAAA==
X-Change-ID: 20260326-veml6070-1489798087df
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774527105; l=1981;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=q5VeKQaMOeAzIRvj0zdKA5E5UwciJ+dVl5nvFwGPIVA=;
 b=K2IRwI23jzeggJTdMGQMp2IvyQTATTfUQWdah2xnK6ps4QNcLHM7qr6sGHW+/nGsnQ+VzmDdq
 NwP6INirp/TBopVzjdX0X62+6G+72hFgAW+W2z68q8YFsYY7VV68MCQ
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

The original code registered the i2c dummy device cleanup via
devm_add_action_or_reset() after i2c_new_dummy_device(). If probe
failed between these two calls, the dummy device would leak.

Use devm_i2c_new_dummy_device() which registers cleanup atomically
with device creation, eliminating the error-path window.

Fixes: 7501bff87c3e ("iio: light: veml6070: add action for i2c_unregister_device")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/iio/light/veml6070.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/light/veml6070.c b/drivers/iio/light/veml6070.c
index 6d4483c85f30..416a9520713f 100644
--- a/drivers/iio/light/veml6070.c
+++ b/drivers/iio/light/veml6070.c
@@ -247,13 +247,6 @@ static const struct iio_info veml6070_info = {
 	.write_raw = veml6070_write_raw,
 };
 
-static void veml6070_i2c_unreg(void *p)
-{
-	struct veml6070_data *data = p;
-
-	i2c_unregister_device(data->client2);
-}
-
 static int veml6070_probe(struct i2c_client *client)
 {
 	struct veml6070_data *data;
@@ -283,7 +276,8 @@ static int veml6070_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
-	data->client2 = i2c_new_dummy_device(client->adapter, VEML6070_ADDR_DATA_LSB);
+	data->client2 = devm_i2c_new_dummy_device(&client->dev, client->adapter,
+						  VEML6070_ADDR_DATA_LSB);
 	if (IS_ERR(data->client2))
 		return dev_err_probe(&client->dev, PTR_ERR(data->client2),
 				     "i2c device for second chip address failed\n");
@@ -294,10 +288,6 @@ static int veml6070_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
-	ret = devm_add_action_or_reset(&client->dev, veml6070_i2c_unreg, data);
-	if (ret < 0)
-		return ret;
-
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 

---
base-commit: 66ba480978ce390e631e870b740a3406e3eb6b01
change-id: 20260326-veml6070-1489798087df

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

