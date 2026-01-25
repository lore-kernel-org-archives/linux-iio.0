Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999B13009FA
	for <linux-iio@vger.kernel.org>; Sun, 25 Jan 2026 23:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769382339; cv=none; b=geI/4QeT8c3g5A0EJ3qyQi5hiXWDScQL1++J1XLJOszNYLo9jwL4e1DXyGQKwmDy8YRrL6zvFgO7Nfdzthkt2tKA6HPcWCHNOKm6W159Sg3EIWYCt6HL6HytHbz2niX34Css10lT6VcEoamPFaXYreE9Lu73MW+rtYwG1qieRrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769382339; c=relaxed/simple;
	bh=cMgxdWitXeOCAuAju3ueXPj91D/a8w9FVq4Xtxmm8zc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fwy0Pn8QgrKA0BbekJYIrdYWyPDSCpFaxYOdCECLDvay+Q0gAlbo3e77Juvr1tX0+gFAcnX5Zy9qUc/VjzXnkuWDXZLr8VtE2FbusNdAQXmu/j04t8z9JvrIPdeyeqEdNuWya9+HJDin0dBHtbvEYkm55s/GSVtqYKADy+unFZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtN1PgtR; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtN1PgtR"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-121bf277922so6367360c88.0
        for <linux-iio@vger.kernel.org>; Sun, 25 Jan 2026 15:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769382336; x=1769987136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i8HUwLeGRFpzo9FUWLQP6iNYUn5cQ5zvukR0bF1DuE8=;
        b=JtN1PgtRmfAk3aLH2NykbMgJ4/0eBg4iWczkFzdMnhAYzGbieZ0r0ksbhWT3nAXL8v
         ySMR3ka+2OE2wkAu3fQ+TbH//EJ1ls3/eEE/Qi5ZzlUr2hgzj9Df6PFOuwYZ83LOAnDL
         ftBaz/ArXDZz8/8qj+wWeO8xuoqksP2QeB7E5cbTWuRC7wjNNclFUgsU7rlhY7qyqFIB
         efY/Sq3uMsniMgOZwN6cg4Bltz4+es0r2TkYFqaczdJ6uJDC46Mp3JYV6dp39WHg4oK4
         7wRjoqxtFHkZjnmpWSQUiIi3u77R64QCvRy/GVSCsgmCpgRR4IdFcvuD9A5tOQ/i8mFc
         APkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769382336; x=1769987136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8HUwLeGRFpzo9FUWLQP6iNYUn5cQ5zvukR0bF1DuE8=;
        b=cpEL3n0bNU17ktJJolOb3eBsJpp0piaazp3I53Eg7Vlvt/asNd9vrqv56abJs8MEiB
         E/wmtarsLEFZTebwm+tbLtQcavy6YTlyo3jpUrWyFW8GJ9a0WZDTzKxMkhKmEPFjTFif
         /Mi2YatJc6Icy1z7bwz1MQ/Nye9ezBfxNOZDxEP7Is2RhnG2EeXr1EbE7MrTC750E7wr
         MckDKuf8Xdhy111P7SO2JB3Pau+3Xfc5y9iSuH8bq/LtWeUjcQrXL9EPxxN646apwmbd
         2BgIXQPR6G1SPHAlRaJwS1yM2fs3qKOIRqToBQshtln1veowDxAIL4Ge5bgG5pmbLVr2
         e0iA==
X-Gm-Message-State: AOJu0Yyjwd69fcrT4B+cjJErxP6qAyUIyPp2v9d0tggdjIz92TLR/9XE
	j1WE51a9sWCgx4QVquhiabMoADKwp6YSVSPsnSqi93T/g5oQTfRmPoz+88AzSg==
X-Gm-Gg: AZuq6aLdLM+CC9XnOvoo7IKxgcNJ9zkclu4/mg2AO3/bMlcDpSOYeWGxCdDx15PqyZf
	lbgEO57u7A8/eNnt1dtTnD9vk/cD0vB5LxBpT4kFJRX57rZVlEcYNVU8Ceno0+0HYohP5aCRKvb
	64yFB2uBGdV5A/LSi5IiqVhQZ0oS8fCrek65xEAxgjzr4t1qSxm7mKc1/7Nk/K1SDg2PO2wllVV
	DqJWux2FGVJuxNhcnMuxoWQy5wm0CScdd7Y10L6GPSeF7um0TlHho2h4oGa44+AWoQO5+Hl3ELA
	7QW+FFFCDvW6BoHvXIWCJqU5bV1w4YeueKOHmc91sqiyFn2aLvjUFG58nuV44h2SORQSUYKi0Ao
	5UZKYaghp++2QQGZSGolzBvtHuVydZNIVRQJlqHiNZ6MvnMt6kfVQAwQATdz7QzAbxTfsj2jPga
	/i5H83JCebI3IUN9bYKQ/xGKSJIdc=
X-Received: by 2002:a05:7022:a8d:b0:119:e569:f60d with SMTP id a92af1059eb24-1248ebf0bc9mr1360140c88.6.1769382335953;
        Sun, 25 Jan 2026 15:05:35 -0800 (PST)
Received: from localhost.localdomain ([2804:20:28:3cc:d5a3:2e3a:ba09:7c1a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d90ce0dsm15061855c88.4.2026.01.25.15.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 15:05:35 -0800 (PST)
From: Gabriel Almeida <gabrielsousa230@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	gabrielsousa230@gmail.com
Subject: [PATCH v2] iio: light: zopt2201: use lock guards
Date: Sun, 25 Jan 2026 20:05:18 -0300
Message-ID: <20260125230518.112027-1-gabrielsousa230@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use guard() to handle the mutex lock instead of manually
locking and unlocking it.

Signed-off-by: Gabriel Almeida <gabrielsousa230@gmail.com>
---
v2:
- Reorder headers
- Add required linux/cleanup.h include
- Use lock guards in zopt2201_read()
- Use scoped_guard() in zopt2201_write_resolution()
 drivers/iio/light/zopt2201.c | 40 +++++++++++++++---------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/light/zopt2201.c b/drivers/iio/light/zopt2201.c
index 1dba1b949cc3..c73c604170b3 100644
--- a/drivers/iio/light/zopt2201.c
+++ b/drivers/iio/light/zopt2201.c
@@ -10,15 +10,14 @@
  * TODO: interrupt support, ALS/UVB raw mode
  */
 
-#include <linux/module.h>
-#include <linux/i2c.h>
-#include <linux/mutex.h>
-#include <linux/err.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
-
+#include <linux/err.h>
+#include <linux/i2c.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-
+#include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/unaligned.h>
 
 #define ZOPT2201_DRV_NAME "zopt2201"
@@ -186,10 +185,10 @@ static int zopt2201_read(struct zopt2201_data *data, u8 reg)
 	u8 buf[3];
 	int ret;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 	ret = zopt2201_enable_mode(data, reg == ZOPT2201_UVB_DATA);
 	if (ret < 0)
-		goto fail;
+		return ret;
 
 	while (tries--) {
 		unsigned long t = zopt2201_resolution[data->res].us;
@@ -200,30 +199,25 @@ static int zopt2201_read(struct zopt2201_data *data, u8 reg)
 			msleep(t / 1000);
 		ret = i2c_smbus_read_byte_data(client, ZOPT2201_MAIN_STATUS);
 		if (ret < 0)
-			goto fail;
+			return ret;
 		if (ret & ZOPT2201_MAIN_STATUS_DRDY)
 			break;
 	}
 
 	if (tries < 0) {
 		ret = -ETIMEDOUT;
-		goto fail;
+		return ret;
 	}
 
 	ret = i2c_smbus_read_i2c_block_data(client, reg, sizeof(buf), buf);
 	if (ret < 0)
-		goto fail;
+		return ret;
 
 	ret = i2c_smbus_write_byte_data(client, ZOPT2201_MAIN_CTRL, 0x00);
 	if (ret < 0)
-		goto fail;
-	mutex_unlock(&data->lock);
+		return ret;
 
 	return get_unaligned_le24(&buf[0]);
-
-fail:
-	mutex_unlock(&data->lock);
-	return ret;
 }
 
 static const struct iio_chan_spec zopt2201_channels[] = {
@@ -324,9 +318,9 @@ static int zopt2201_write_resolution(struct zopt2201_data *data,
 
 	for (i = 0; i < ARRAY_SIZE(zopt2201_resolution); i++)
 		if (val2 == zopt2201_resolution[i].us) {
-			mutex_lock(&data->lock);
-			ret = zopt2201_set_resolution(data, i);
-			mutex_unlock(&data->lock);
+			scoped_guard(mutex, &data->lock) {
+				ret = zopt2201_set_resolution(data, i);
+			}
 			return ret;
 		}
 
@@ -351,15 +345,13 @@ static int zopt2201_write_scale_by_idx(struct zopt2201_data *data, int idx,
 {
 	int ret;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
 	ret = zopt2201_set_resolution(data, zopt2201_scale_array[idx].res);
 	if (ret < 0)
-		goto unlock;
+		return ret;
 
 	ret = zopt2201_set_gain(data, zopt2201_scale_array[idx].gain);
 
-unlock:
-	mutex_unlock(&data->lock);
 	return ret;
 }
 
-- 
2.43.0

