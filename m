Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794641782;
	b=jexgTyr/rI9ACEUu7Ml1pb8iKCOz79ibg7MBrrsnvQlux0IVzXdVmpPirryPyRtA5O/U
	 5vBJroBlgpgq1iRvo+GZ3zuTTLiep3ElHml6opVMC3UMKVq/oMoVR6nZlEXi8dg+RLBaB
	 pbBYjd99hWyXxXlbv50iAg3r+PCRqJHCH73K1751PMvbKIiXx0LTDaZBtyJGSysl0qnc2
	 6kfzGlFCBy3oKsqKNWU9EbmpFQtpxmag+EEytuQ0DSMtlyClKdvkoo9VKqyxQimotRGnU
	 hOhsWRraQTB/eC8I8JCLjU6FpESk0Ht61RXRp6rCAM28OTsrX/6XFvWLzzXKwa09htw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794641782;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NpzIKzf0j1MF4TQzlOAXahTkNrQC8IVb9GgpNTeOqbY=;
	b=CLvHJv4RP26LTcUNOQ7VxSMW08rSGzD/Y94S0rhi2fP0kuQSna1JZBvqR2CXRFKD7gkS
	 KSxXcF+d5KMQua0hK4iCcxUMvx0dz3+q8ziT4qVtSW7D0cJuycCPGKkBYRCpsAP4ny+4P
	 bBSDvbuvifpn5c3pxzZqPJI7+mZVIdqNZgLRGrC2tHXQA8WfmXIr3YL38X0zZNmHls7bl
	 ArT3LlV/nRNODPbc5WJBXUJQDnN2D3QqQ2Hduof/8ivE5oRbXHKrKIfta+H2RrIOYNim+
	 2ExMwpvwlIMzfyRBydrOoOv5zdCDCnSGrMXGwJhGwgDOKkGsbYncDlUKgb+7Ceyct6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yH+fI61O;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DC7606A331
	for <linux-iio@vger.kernel.org>; Sat, 14 Nov 2026 07:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97DC7606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yH+fI61O
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-37198ed3727so3186359eec.0
        for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 23:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794641781; x=1795246581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NpzIKzf0j1MF4TQzlOAXahTkNrQC8IVb9GgpNTeOqbY=;
        b=yH+fI61OsffsKXPV6EmPFbgm1cISUEjkYB31t7ZuyE0kV6rj8f7gWVNU0CavO7PsOM
         zt4nwJIx9bAxuj71IRspBEf4fD886uXjLU1VU+2Vm15llZl2X53H6RBr0gOIKfzx514H
         jEOGAUgXVliLm1sr+bBsW8Uf6lw5YvuMxcIPAZtijUKvqq92mR2smtYnJyAagwZDmioS
         7H7OZIKuAhNxTKuRsssm8L+ZrUZCR6eItcPnBTujJxeRARtKbNrdcdhoTMZXU6omBZFy
         dT1rc7icNgfNPG6K9A0Jn6QD7EPIftmn25CkGiHouGNv4Ryz5qk6FG5+V9yHPdliK04/
         DffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794641781; x=1795246581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NpzIKzf0j1MF4TQzlOAXahTkNrQC8IVb9GgpNTeOqbY=;
        b=GJTgTcMfkslKqClZYCl21Dl4wS/KGAoW4s7yOoocABnuIOy1AuWdRBn4ze9D5nGE7x
         fOpl7rx6SXcGX/buaEQcl43yLtZ5OKHAy+ilnRmG4dIXcUnzUlPwQNVZeFkiBTI+wBqb
         lo2Od/2t/u0EJX6SDxGYDRy0zlYQiAja/2S30YEKt+8WLsiSd/V/zEr8PjxGxP03+1Ku
         BxOCVPluyvf6P/dvyoJaK1w0wAVdhl8hRmMW+FiuIohFqn5N5TyD1VvaUCDmxaGsYUeU
         a21Hxf9zN8i3KAbLVH27/KMQuAWNwjDgV8xSRl5jIrBwbef3Hgj++pnz1AueLG5cAlza
         xPgQ==
X-Forwarded-Encrypted: i=1; AL+hErHfrh76oPfev8idWZoaIn5o8rZPolAsgDpHxr+e5JOb7yrOI2PxtfXJUJ2aw+kEy+LZ/gVM4k6Np0Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Pp6AdkX5vGKirk+ym/iwdHmvp/KYi2Rte26t0Nmcbop3LNEZn
	2UAa/1+ozGKaOkXx//2xKU+qx+rzi/pZRc8j4qILLiYge2kd8m+tYKId
X-Gm-Gg: AYBFou2eRHcWsjqdU1GeMOZK1jIINiwJVVomzKvIffBIQFLqF8twvdKM6tCMh85jOJo
	RBz0FkJQwlYJLn82bb5EWKJK63/ktsaFs17kZ308VvfBwdkeB7HPMyo7AAItKdvAc6yVmi7jxFW
	K9OedyWiYtqxvwPA+exyO/S55QV96YQLwfNaMCvcb5//3SEfeCjSRJHpucyVgsAf01YsnsKDEHv
	xVpgBzgYVTsopX+pyxbzBiPVF060dQtC/+9dMEN8hU+f5YLlgNvxsYGZPVx0ZH/SX+2pnvmVDAO
	sVyO90xaT3DaGWJtQLFIBVzJCBuWVaF3NeKvP30BnRaKaAZsAMXLHSxwNHnA/DlOgHVbVukhJFE
	zCaj9Ghmx4PFw8WWNkidlfdfRpFDmKyXVetYxz6XWe/LfiFuxGbooNfaYUHmsCIhhMXjHmSjgrW
	rvI4mt8itejC6HSwPESMmOCuPT67yT7Zvn4RI0uZeLNwpfA+8aaJEjAJaDliTsYo9U/iJgIwI1k
	YHOkA7LR1lnJdJFIwwRAaptTOSTEtJjjfgAHxLLLwyMH2BusZAuQ/PHdo0vwxWFg6xgGC0PbRhc
	qzOnge2t6x4W74e47hhm2Q79qJMd5cDV6dMRt/NnoZOO4veQ2iN2H8LmiJ6/PCuNYbU9fwdRpa8
	7KrBfX8KSAQ30PcpXWjhaDL1bEVgyYp029TqIj3zC3CYEi2/78V+x+y55evXRFmbPyjzMCNrCbO
	wNh0viciwJ9jDtTli65bT6keFUIrUJX2Jpu5ekOs43MQ==
X-Received: by 2002:a05:7023:e41:10b0:192:a481:361 with SMTP id a92af1059eb24-1b50308a2c0mr4266658c88.7.1794641780699;
        Fri, 13 Nov 2026 23:36:20 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50313d990sm16082635c88.4.2026.11.13.23.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:36:20 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v5 2/3] iio: proximity: sx9324: keep the IRQ balanced across suspend and resume
Date: Sat, 14 Nov 2026 13:05:56 +0530
Message-ID: <20261114073601.23404-3-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261114073601.23404-1-kapoorarnav43@gmail.com>
References: <20261114073601.23404-1-kapoorarnav43@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sx9324_suspend() disables the interrupt first and returns with it still
disabled if a register access fails. Resume isn't called after a failed
suspend, so the interrupt is never enabled again. sx9324_resume() also
returns without enabling it on error.

Enable the interrupt again when suspend fails, and enable it as the
first step of resume, before anything can fail, so resume mirrors
suspend. Use disable_irq() rather than disable_irq_nosync(), and call
it before taking the mutex, which the threaded handlers also take, so
none of them is left to run once suspend has returned. The driver works
without an interrupt line, so skip these calls when client->irq is 0,
as sx_common already does.

Fixes: 4c18a890dff8 ("iio:proximity:sx9324: Add SX9324 support")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/sx9324.c | 43 +++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 1c8ba28c030a..ed2caadc7747 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -1091,15 +1091,13 @@ static int sx9324_probe(struct i2c_client *client)
 	return sx_common_probe(client, &sx9324_chip_info, &sx9324_regmap_config);
 }
 
-static int sx9324_suspend(struct device *dev)
+static int sx9324_sleep(struct sx_common_data *data)
 {
-	struct sx_common_data *data = iio_priv(dev_get_drvdata(dev));
 	unsigned int regval;
 	int ret;
 
-	disable_irq_nosync(data->client->irq);
-
 	guard(mutex)(&data->mutex);
+
 	ret = regmap_read(data->regmap, SX9324_REG_GNRL_CTRL1, &regval);
 	if (ret < 0)
 		return ret;
@@ -1107,25 +1105,42 @@ static int sx9324_suspend(struct device *dev)
 	data->suspend_ctrl =
 		FIELD_GET(SX9324_REG_GNRL_CTRL1_PHEN_MASK, regval);
 
-
 	/* Disable all phases, send the device to sleep. */
 	return regmap_write(data->regmap, SX9324_REG_GNRL_CTRL1, 0);
 }
 
+static int sx9324_suspend(struct device *dev)
+{
+	struct sx_common_data *data = iio_priv(dev_get_drvdata(dev));
+	int ret;
+
+	/*
+	 * Before taking the mutex, as disable_irq() waits for the threaded
+	 * handlers and they take it too.
+	 */
+	if (data->client->irq)
+		disable_irq(data->client->irq);
+
+	ret = sx9324_sleep(data);
+	/* Resume isn't called if suspend fails. */
+	if (ret && data->client->irq)
+		enable_irq(data->client->irq);
+
+	return ret;
+}
+
 static int sx9324_resume(struct device *dev)
 {
 	struct sx_common_data *data = iio_priv(dev_get_drvdata(dev));
 
-	scoped_guard(mutex, &data->mutex) {
-		int ret = regmap_write(data->regmap, SX9324_REG_GNRL_CTRL1,
-				       data->suspend_ctrl |
-				       SX9324_REG_GNRL_CTRL1_PAUSECTRL);
-		if (ret)
-			return ret;
-	}
+	if (data->client->irq)
+		enable_irq(data->client->irq);
 
-	enable_irq(data->client->irq);
-	return 0;
+	guard(mutex)(&data->mutex);
+
+	return regmap_write(data->regmap, SX9324_REG_GNRL_CTRL1,
+			    data->suspend_ctrl |
+			    SX9324_REG_GNRL_CTRL1_PAUSECTRL);
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(sx9324_pm_ops, sx9324_suspend, sx9324_resume);
-- 
2.53.0

