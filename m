Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931693E3D90
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 09:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779097376; cv=none; b=FBCFBMjxOvO0M/YFWVAB1q0C66rAaZPQDVHXN7PVA/7ONqPh48J4AWphljqc27dYm8B3D7jThBb7gmsN9ZkwCjizDOAaf5wv2WvCbzAuuvH5lnNH7FBJ6loDlkv8eavMxzhFWYOHQ07fQ3zJW8BFkjRjIeqLfzm/MXt8iYi0dFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779097376; c=relaxed/simple;
	bh=oJj8hUTaYVHpAd+ywEzMzj7LcqrMBR3b27Pw+5sLAdU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lCITKXIbOYAHV2smkB6HueHslFT7sBtWakleXuvArhKjQErsce6h0M29efpUxLF31hIJeC7OQMolqiY7rm0qNBdxlPqInCLqF5lXGgCJEoQjtw7NN9xW1tBVG6ACp7NbR56iab/HVo5z6xknpZhK5CZ3bczvixDuIUrlUkDbXS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHtVjKr1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHtVjKr1"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48fde653997so2520185e9.2
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 02:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779097373; x=1779702173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgADJOxU9OGwFQpUQDyXunQW5uJtIZQoGTi296Hj+c4=;
        b=NHtVjKr117f8Olu674L3Ak8y4wcAd5X/VidUCPa4t2HVg32XIoErf7ubej10xht+4I
         7EEIO5n6umbkO9xnv6w/egVc+8S0VayGVKMLF3UqZsYk+rOE69/M743Iecivqz41G5cW
         SYX9zP8onv076+d0kZp1aM70qJ7BPJmuhHaA5Dig6uoWsfELtK690dh+XUU8ttI83038
         JWOTSsDUZy4yVLPCn0mDwxK9tkKpLMxqhAlpejLW2Y8q9tn3sQyTQHVU17pwSY1QOjUP
         jdm5KIfQ/52Z2kfo/BsfojVD2zp0r8H/1TFg9727KR0uZrqqRWDCnIL8/laMkbpMMlS9
         Hfag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779097373; x=1779702173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wgADJOxU9OGwFQpUQDyXunQW5uJtIZQoGTi296Hj+c4=;
        b=QnuCpF3lej14bAg93yQRMr4RdbFqoFIOSyDDA7KjweOK57c9l5W9/hOeHIqgtZObtD
         6OqVKB4kJZiLQYS6hQ511z498DEvFxOxFvwBN3BbJmUGQYs7azgUHtIChq/D+9NsGcmJ
         lOvT3qX4DLtW9Ao125MHRCEN7mqiy6aC2mfZVWKV1LbopSlQCgzAl8Ueeme0tAFpQqTy
         TUBlbq6Wzdw/x8Por8c31fOZ0wO1GLf7XLvwbWNd07Ug7R12gYTh9pGEu25pvtztdUQ4
         S4QOimqjbGdUcCrex1le9mXw+9Z/hwPgJWBxJZ4QDmH7BfxaQv4nnD5dYyKNxOzu2JSA
         Cx7Q==
X-Forwarded-Encrypted: i=1; AFNElJ+KJ46pmZM5n1c5oihlKOJEzue3ZFvyApIuHHan8awuKxVqRm7HTn1ZKhRJ8DGTBTlYg2poKRNGGNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk6QBKqmXsr7fQmA9FTytiXyXzeYEZhaoxSRIauzo67kdjo/Mf
	TZ+pTIMUXCmxeBYJwFdOAKusLiY7qDTSH1GKbkNYdmAk3KMyNv9DAD49
X-Gm-Gg: Acq92OFw20ijS9cS4ALMeh7syoI02klphOvsd1w1Vp39BuBlIAg8seqVgd0uqaS134g
	x6tqdtTmLdgwJj5xZbtZPlNsGKeKPMynY7IOlQfw1y/3eUKULF7EOvt97JRMlXZ4LsSwG2YXpUY
	KpruJe157YYjbuYAjBfE7TFkf8rWyAcSVaioa3GeHbaYnEO4S285gG8/pBDtQ4NdH/SIqkKVdTu
	eNZUnQFO/UX6JyvhRURq7ArDziDvxJh01Pzp1igRUlZ/cRkbABqc2wIwS+KxsGD0uY30YYusvy6
	2jVw6O0iwOeOvwzdi7Sz4mjyKflX4esskKtHL7RYuvjRt82MHToX52wsVorlqxsbR0hvkU0BnGD
	DWKYg2QdI1yws3IQEZ31+94ya6xu/LMEPTyWfzN/64+5ImipqNP6XvxmIZNtaBpJoeXB3meMX0e
	RjnixNnWvXofObWfGwH9bbyNAEjKip/cWfPxDgS/8TyiFP
X-Received: by 2002:a05:600c:4588:b0:489:1c1f:35e5 with SMTP id 5b1f17b1804b1-48fe664be2amr98337705e9.6.1779097372785;
        Mon, 18 May 2026 02:42:52 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe2464sm37460225f8f.32.2026.05.18.02.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:42:52 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: mazziesaccount@gmail.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH v2] iio: pressure: rohm-bm1390: notify trigger on all error paths
Date: Mon, 18 May 2026 14:42:38 +0500
Message-Id: <20260518094238.1986-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20260517160801.269-1-sozdayvek@gmail.com>
References: <20260517160801.269-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bm1390_trigger_handler() returns from three error paths without
calling iio_trigger_notify_done(). The success path at the end
does, so on a single transient regmap or read failure the trigger
use_count is never decremented, and the !atomic_read(&trig->use_count)
guard in iio_trigger_poll_chained() drops every subsequent dispatch.
The buffered-data flow stays wedged until the trigger is detached.

Funnel all returns through a single done label that calls
iio_trigger_notify_done() and reports the outcome via IRQ_RETVAL().

Fixes: 81ca5979b6ed ("iio: pressure: Support ROHM BU1390")
Cc: stable@vger.kernel.org
Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
v2:
- Use a bool and IRQ_RETVAL() instead of irqreturn_t (Andy)

v1: https://lore.kernel.org/all/20260517160801.269-1-sozdayvek@gmail.com/

 drivers/iio/pressure/rohm-bm1390.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/rohm-bm1390.c
index 08146ca0f..81368e578 100644
--- a/drivers/iio/pressure/rohm-bm1390.c
+++ b/drivers/iio/pressure/rohm-bm1390.c
@@ -626,12 +626,15 @@ static irqreturn_t bm1390_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *idev = pf->indio_dev;
 	struct bm1390_data *data = iio_priv(idev);
+	bool handled = true;
 	int ret, status;
 
 	/* DRDY is acked by reading status reg */
 	ret = regmap_read(data->regmap, BM1390_REG_STATUS, &status);
-	if (ret || !status)
-		return IRQ_NONE;
+	if (ret || !status) {
+		handled = false;
+		goto done;
+	}
 
 	dev_dbg(data->dev, "DRDY trig status 0x%x\n", status);
 
@@ -639,7 +642,8 @@ static irqreturn_t bm1390_trigger_handler(int irq, void *p)
 		ret = bm1390_pressure_read(data, &data->buf.pressure);
 		if (ret) {
 			dev_warn(data->dev, "sample read failed %d\n", ret);
-			return IRQ_NONE;
+			handled = false;
+			goto done;
 		}
 	}
 
@@ -648,15 +652,16 @@ static irqreturn_t bm1390_trigger_handler(int irq, void *p)
 				       &data->buf.temp, sizeof(data->buf.temp));
 		if (ret) {
 			dev_warn(data->dev, "temp read failed %d\n", ret);
-			return IRQ_HANDLED;
+			goto done;
 		}
 	}
 
 	iio_push_to_buffers_with_ts(idev, &data->buf, sizeof(data->buf),
 				    data->timestamp);
+done:
 	iio_trigger_notify_done(idev->trig);
 
-	return IRQ_HANDLED;
+	return IRQ_RETVAL(handled);
 }
 
 /* Get timestamps and wake the thread if we need to read data */
-- 
2.43.0

