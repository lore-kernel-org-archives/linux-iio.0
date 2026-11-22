Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795367801;
	b=pAoxs8nUho2Ount0Xh/AByqCd7xpGTq+2XbT5kd9Vh3U39s5bveGwfUkEngh+HHNsMT+
	 cdny4XGZbHwZdndY/iQ7gCfdrTxu3RSs3ubCX8LvMRrGAUgTj8zqHaMoxKoR/3e3tVOn+
	 d/fW8YScYOYC2Fz6iez1y/RY0HVmu1AUNBzZLiCNsMlv66WsNIguQYhx0bomnqwRqcFbK
	 Vpu4sGAD00HfxU83cxRDql+RXZ4KjxWZJm3Il8vwt83PwGAd4F3cS/vmJdcmR07j5iq6m
	 IOMmY1MS7DveEvRUDaWThPuldU7ibyk8HdcTcF9tQc85RevhzTzzPBXI2sQTnxEPlsQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795367801;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=8BX4qMtkXZZEEur5iCL9/lu6vNU0NV7vJc4oUC//V5I=;
	b=VRlEauN3KGg5gZ+Ec0hEM2jSnRaQLk73fxZGraAMEjQCiqnLaCeJca7zH6WqGc0qe2PZ
	 mTMBNIlXvsXgGff5kHhyzVrWZVCTUBX2JoSWQnAeWKKgvVt3hbpiKBVmHKo419HfrxbHy
	 Ms2TUqttiKD1bXl2RtpvXbWKk5+ykD70i4TdCf3iAi37gt3jjCiHCBty3iMJJVfIJoZY4
	 c72mnbGu6q0aA8x6bzsGkL0XQWgmIEs/y8hAqYZqJ/19UDPP1T7D2MCY1r6nD/EMs6i7a
	 7zbUkm8g51fgbnr0Y/Ej44XIrFp6RC/g4zhSX++3kX9Jnoj+56vNPmuxL/LlMwSPYQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="m71UZ2E/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84329606A330;
	Sun, 22 Nov 2026 17:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m71UZ2E/
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795367800;
	b=bMrzJfyKnii93x2Pm8Qf1jHI7chrSzNe+Au9o6mV8m8dwuQJXFob/+auAn6YoV7lOqYz
	 j9kjT0FaInwLp0Ut7nVXbU0j5sJ2aHrQaNmZvPKfE+NSRsZr0IYxUOJWVd6PxkD6LWHPc
	 UPdyDb6NEX2kb+7FuItTaqgO1K/nqOzvIubaM0b3DoBqtHae4klQqxlQ9/Ffr2AWycStX
	 dWjUH0gtIM7EE9KmeNNBemwqG0Spx6Iue6bISWzKDvqHT1gcy1uUsskIctpdTmMTAZoyj
	 /635NehWCxyDMrds0BnkuxEcTvWpYCnHxZgdem8kwbwi18Q64Bd4aNICvZeVkEY1SoA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795367800;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=8BX4qMtkXZZEEur5iCL9/lu6vNU0NV7vJc4oUC//V5I=;
	b=bb/x9UjPIQP/JS3RpC7odRVLXsqRW9QIcZm+aUOBmaJZEUctwWuNiV2nAU6VoG44Qqel
	 aRyYCbOKPiOopeZhcZv2+dwSscaqDms0B29vn1pXrLshhYo7gFS2Gy9ik0U2ErXy7jjkA
	 gq6FRguulqfw0UCl8m5zP0fgaQODgOUQD+47xDmROdY1OvsF5Yh25rEey/qnMg6cgqevf
	 kbh6z+9Ok4BidiMTeKZ21KYN7lj+l2XbyhE58mMCYgcS8U39Rh3kO3w8sy5ngON8+vJ3N
	 sdUdDbqgS4wj6LX00sntrNMEdEiXIWF3zOOKUhQDHnVfGBBsPNHpjvc5M0C7xfd6tYw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CF3E91F000C4;
	Sun, 22 Nov 2026 17:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795367800;
	bh=8BX4qMtkXZZEEur5iCL9/lu6vNU0NV7vJc4oUC//V5I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=m71UZ2E/5aBaP+aV30ARKfpgHJS+o3xHumrXMyRakaNRLBCYjx1dXckTjVx/IIdNO
	 3a/eNwaHNKgRQytGo7cfEfLiJReUB05tmRyKSmBnPuJndr1ge3aOKvSf89xXzWDGrq
	 bMp+gUExg9NA5DY6XCnFvnxh623WXYkMHlkxtDD0Dkp9sL7P0U+n3PdnG62yoKzpWk
	 8eOiRcp7rCZ2cOrewc9jnl9D+53HZatWEjP1Kf28glaqj6T4PLhM2KU1wXk+NLUlx/
	 uSDnmKd46tn7vXINi6bx008CUPuk3isLSaNu4p0I+pme48RA3dpAdCg+DvXm8h3aAs
	 vdYcYEFwlBl4w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 509614C133;
	Sun, 22 Nov 2026 17:16:36 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Sun, 22 Nov 2026 19:15:42 +0200
Subject: [PATCH v3 1/7] iio: light: stk3310: migrate to devm_* API
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
Message-Id: <20261122-6768-stk3337-v3-1-b0d0a924e843@protonmail.com>
References: <20261122-6768-stk3337-v3-0-b0d0a924e843@protonmail.com>
In-Reply-To: <20261122-6768-stk3337-v3-0-b0d0a924e843@protonmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Joshua Crofts <crofts@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795367795; l=2793;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=0op2+wuVDhpkZWTj316+uOP3iudK90lB8euvzogwbR4=;
 b=cvgOwMN/d6emckerpitU2MxglfwkIlCCY1/WLT0l6KbFxqr4uRSz2yYqdqKk6YRgXLmnnmqph
 OIv64uYaL07BuLZMfjC15q3NWx5Q/3/mlLD2Gd+f6KTs0Zzosqbj+iS
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com
Content-Transfer-Encoding: 7bit

From: Roman Vivchar <rva333@protonmail.com>

Replace manual .remove() and mutex_init() with devm_* helpers for
consistency with existing devm_request_threaded_irq().

Suggested-by: Joshua Crofts <crofts@kernel.org>
Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 drivers/iio/light/stk3310.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index e751e7c97bc1..708ac0503be0 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -10,6 +10,7 @@
 #include <linux/array_size.h>
 #include <linux/bits.h>
 #include <linux/dev_printk.h>
+#include <linux/device/devres.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
@@ -594,6 +595,11 @@ static int stk3310_set_state(struct stk3310_data *data, u8 state)
 	return ret;
 }
 
+static void stk3310_standby(void *data)
+{
+	stk3310_set_state(data, STK3310_STATE_STANDBY);
+}
+
 static int stk3310_init(struct iio_dev *indio_dev)
 {
 	int ret;
@@ -617,6 +623,10 @@ static int stk3310_init(struct iio_dev *indio_dev)
 		return ret;
 	}
 
+	ret = devm_add_action_or_reset(&client->dev, stk3310_standby, data);
+	if (ret)
+		return ret;
+
 	/* Enable PS interrupts */
 	ret = regmap_field_write(data->reg_int_ps, STK3310_PSINT_EN);
 	if (ret < 0) {
@@ -745,7 +755,9 @@ static int stk3310_probe(struct i2c_client *client)
 	device_property_read_u32(&client->dev, "proximity-near-level",
 				 &data->ps_near_level);
 
-	mutex_init(&data->lock);
+	ret = devm_mutex_init(dev, &data->lock);
+	if (ret)
+		return ret;
 
 	ret = stk3310_regmap_init(data);
 	if (ret < 0)
@@ -769,28 +781,14 @@ static int stk3310_probe(struct i2c_client *client)
 						IRQF_ONESHOT,
 						"stk3310_event", indio_dev);
 		if (ret)
-			goto err_standby;
+			return ret;
 	}
 
-	ret = iio_device_register(indio_dev);
-	if (ret < 0) {
-		dev_err(&client->dev, "device_register failed\n");
-		goto err_standby;
-	}
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "device_register failed\n");
 
 	return 0;
-
-err_standby:
-	stk3310_set_state(data, STK3310_STATE_STANDBY);
-	return ret;
-}
-
-static void stk3310_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-
-	iio_device_unregister(indio_dev);
-	stk3310_set_state(iio_priv(indio_dev), STK3310_STATE_STANDBY);
 }
 
 static int stk3310_suspend(struct device *dev)
@@ -896,7 +894,6 @@ static struct i2c_driver stk3310_driver = {
 		.acpi_match_table = stk3310_acpi_id,
 	},
 	.probe =        stk3310_probe,
-	.remove =           stk3310_remove,
 	.id_table =         stk3310_i2c_id,
 };
 

-- 
2.56.1


